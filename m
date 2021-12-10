Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D796470313
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbhLJOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:49:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53452 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhLJOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD31BB8074E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0873DC00446;
        Fri, 10 Dec 2021 14:45:27 +0000 (UTC)
Date:   Fri, 10 Dec 2021 09:45:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH] tracing: Fix possible memory leak in
 __create_synth_event() error path
Message-ID: <20211210094526.4483a105@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing update for 5.16:

- Fix memory leak in error path of __create_synth_event()

Miaoqian Lin (1):
      tracing: Fix possible memory leak in __create_synth_event() error path

----
 kernel/trace/trace_events_synth.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
---------------------------
commit c24be24aed405d64ebcf04526614c13b2adfb1d2
Author: Miaoqian Lin <linmq006@gmail.com>
Date:   Thu Dec 9 02:43:17 2021 +0000

    tracing: Fix possible memory leak in __create_synth_event() error path
    
    There's error paths in __create_synth_event() after the argv is allocated
    that fail to free it. Add a jump to free it when necessary.
    
    Link: https://lkml.kernel.org/r/20211209024317.11783-1-linmq006@gmail.com
    
    Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
    [ Fixed up the patch and change log ]
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 22db3ce95e74..ca9c13b2ecf4 100644
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
@@ -1262,18 +1261,19 @@ static int __create_synth_event(const char *name, const char *raw_fields)
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
@@ -1281,7 +1281,6 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 			goto err;
 		}
 
-		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
@@ -1307,6 +1306,8 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	kfree(saved_fields);
 
 	return ret;
+ err_free_arg:
+	argv_free(argv);
  err:
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
