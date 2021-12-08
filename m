Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AF746DD41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLHUsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHUse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:48:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A1C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADD5CB82285
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3D5C00446;
        Wed,  8 Dec 2021 20:44:58 +0000 (UTC)
Date:   Wed, 8 Dec 2021 15:44:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix possible memory leak in
 __create_synth_event
Message-ID: <20211208154457.3a301cf8@gandalf.local.home>
In-Reply-To: <20211126104708.7899-1-linmq006@gmail.com>
References: <20211126104708.7899-1-linmq006@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 10:47:08 +0000
Miaoqian Lin <linmq006@gmail.com> wrote:

> Before goto err, call argv_free to handle argv in order to prevent
> memory leak.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  kernel/trace/trace_events_synth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 22db3ce95e74..fe2e37564c9b 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -1261,6 +1261,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  			 */
>  			if (cmd_version > 1 && n_fields_this_loop >= 1) {
>  				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
> +				argv_free(argv);
>  				ret = -EINVAL;
>  				goto err;
>  			}
> @@ -1268,6 +1269,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  			fields[n_fields++] = field;
>  			if (n_fields == SYNTH_FIELDS_MAX) {
>  				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> +				argv_free(argv);
>  				ret = -EINVAL;
>  				goto err;
>  			}
> @@ -1277,6 +1279,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  
>  		if (consumed < argc) {
>  			synth_err(SYNTH_ERR_INVALID_CMD, 0);
> +			argv_free(argv);
>  			ret = -EINVAL;
>  			goto err;
>  		}

A cleaner way is to have:

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 98e002648994..a88f1f9046a6 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1237,9 +1237,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 						  argv + consumed, &consumed,
 						  &field_version);
 			if (IS_ERR(field)) {
-				argv_free(argv);
 				ret = PTR_ERR(field);
-				goto err;
+				goto err_free_arg;
 			}
 
 			/*
@@ -1262,26 +1261,25 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			if (cmd_version > 1 && n_fields_this_loop >= 1) {
 				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			fields[n_fields++] = field;
 			if (n_fields == SYNTH_FIELDS_MAX) {
 				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 				ret = -EINVAL;
-				goto err;
+				goto err_free_arg;
 			}
 
 			n_fields_this_loop++;
 		}
+		argv_free(argv);
 
 		if (consumed < argc) {
 			synth_err(SYNTH_ERR_INVALID_CMD, 0);
 			ret = -EINVAL;
 			goto err;
 		}
-
-		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
@@ -1307,6 +1305,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	kfree(saved_fields);
 
 	return ret;
+ err_free_arg:
+	argv_free(argv);
  err:
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);


Feel free to send v2 and add:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
