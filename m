Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF665122EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiD0Tle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiD0Tj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DE1016
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C54461B71
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79933C385A9;
        Wed, 27 Apr 2022 19:36:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSt-002Izw-Gd;
        Wed, 27 Apr 2022 15:36:43 -0400
Message-ID: <20220427193643.341238948@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [for-next][PATCH 21/21] tracing: make tracer_init_tracefs initcall asynchronous
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Move trace_eval_init() to subsys_initcall to make it start
earlier.
And to avoid tracer_init_tracefs being blocked by
trace_event_sem which trace_eval_init() hold [1],
queue tracer_init_tracefs() to eval_map_wq to let
the two works being executed sequentially.

It can speed up the initialization of kernel as result
of making tracer_init_tracefs asynchronous.

On my arm64 platform, it reduce ~20ms of 125ms which total
time do_initcalls spend.

Link: https://lkml.kernel.org/r/20220426122407.17042-3-mark-pk.tsai@mediatek.com

[1]: https://lore.kernel.org/r/68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7275173c55d0..400d3e9fe9ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9615,6 +9615,7 @@ extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
 static struct workqueue_struct *eval_map_wq __initdata;
 static struct work_struct eval_map_work __initdata;
+static struct work_struct tracerfs_init_work __initdata;
 
 static void __init eval_map_work_func(struct work_struct *work)
 {
@@ -9640,6 +9641,8 @@ static int __init trace_eval_init(void)
 	return 0;
 }
 
+subsys_initcall(trace_eval_init);
+
 static int __init trace_eval_sync(void)
 {
 	/* Make sure the eval map updates are finished */
@@ -9722,15 +9725,8 @@ static struct notifier_block trace_module_nb = {
 };
 #endif /* CONFIG_MODULES */
 
-static __init int tracer_init_tracefs(void)
+static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
-	int ret;
-
-	trace_access_lock_init();
-
-	ret = tracing_init_dentry();
-	if (ret)
-		return 0;
 
 	event_trace_init();
 
@@ -9752,8 +9748,6 @@ static __init int tracer_init_tracefs(void)
 	trace_create_file("saved_tgids", TRACE_MODE_READ, NULL,
 			NULL, &tracing_saved_tgids_fops);
 
-	trace_eval_init();
-
 	trace_create_eval_file(NULL);
 
 #ifdef CONFIG_MODULES
@@ -9768,6 +9762,24 @@ static __init int tracer_init_tracefs(void)
 	create_trace_instances(NULL);
 
 	update_tracer_options(&global_trace);
+}
+
+static __init int tracer_init_tracefs(void)
+{
+	int ret;
+
+	trace_access_lock_init();
+
+	ret = tracing_init_dentry();
+	if (ret)
+		return 0;
+
+	if (eval_map_wq) {
+		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
+		queue_work(eval_map_wq, &tracerfs_init_work);
+	} else {
+		tracer_init_tracefs_work_func(NULL);
+	}
 
 	return 0;
 }
-- 
2.35.1
