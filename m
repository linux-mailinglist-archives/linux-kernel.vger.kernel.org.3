Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2446EBFD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239983AbhLIPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:46:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44902 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhLIPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:46:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5198BCE2690
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0FEC004DD;
        Thu,  9 Dec 2021 15:42:36 +0000 (UTC)
Date:   Thu, 9 Dec 2021 10:42:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v2] tracing: Fix possible memory leak in
 __create_synth_event
Message-ID: <20211209104235.5486d8e5@gandalf.local.home>
In-Reply-To: <20211209024317.11783-1-linmq006@gmail.com>
References: <20211208154457.3a301cf8@gandalf.local.home>
        <20211209024317.11783-1-linmq006@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Dec 2021 02:43:17 +0000
Miaoqian Lin <linmq006@gmail.com> wrote:

> Before goto err, call argv_free to handle argv in order to prevent
> memory leak.

No. That's what you did previously. This patch does:

  There's error paths in __create_synth_event() after the argv is allocated
  that fail to free it. Add a jump to free it when necessary.

> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes in v2:
> use a cleaner way to handle cleanup operations
> ---
> ---
>  kernel/trace/trace_events_synth.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 22db3ce95e74..c4a490ec7a38 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -1262,26 +1262,26 @@ static int __create_synth_event(const char *name, const char *raw_fields)

You failed to add:

                        if (IS_ERR(field)) {
-                               argv_free(argv);
                                ret = PTR_ERR(field);
-                               goto err;
+                               goto err_free_arg;
                        }


>  			if (cmd_version > 1 && n_fields_this_loop >= 1) {
>  				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
>  				ret = -EINVAL;
> -				goto err;
> +				goto err_free_arg;
>  			}
>  
>  			fields[n_fields++] = field;
>  			if (n_fields == SYNTH_FIELDS_MAX) {
>  				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
>  				ret = -EINVAL;
> -				goto err;
> +				goto err_free_arg;
>  			}
>  
>  			n_fields_this_loop++;
>  		}
>  

No space here.

> +		argv_free(argv);

And a space here.

If you had just applied the patch I gave you, you would not have had these
mistakes.

Anyway, I'll update your patch and start testing it. No need to send
another patch.

-- Steve

>  		if (consumed < argc) {
>  			synth_err(SYNTH_ERR_INVALID_CMD, 0);
>  			ret = -EINVAL;
>  			goto err;
>  		}
>  
> -		argv_free(argv);
>  	}
>  
>  	if (n_fields == 0) {
> @@ -1307,6 +1307,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  	kfree(saved_fields);
>  
>  	return ret;
> + err_free_arg:
> +	argv_free(argv);
>   err:
>  	for (i = 0; i < n_fields; i++)
>  		free_synth_field(fields[i]);

