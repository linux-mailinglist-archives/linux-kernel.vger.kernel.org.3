Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1424E551B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiCWPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbiCWPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:24:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF35BC96
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:23:12 -0700 (PDT)
X-UUID: c3bd6049ef754fcdb4d69a74ef15eca9-20220323
X-UUID: c3bd6049ef754fcdb4d69a74ef15eca9-20220323
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 449557789; Wed, 23 Mar 2022 23:23:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 23 Mar 2022 23:23:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 23:23:02 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v3 2/2] tracing: make tracer_init_tracefs initcall asynchronous
Date:   Wed, 23 Mar 2022 23:22:57 +0800
Message-ID: <20220323152257.7871-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
References: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

[1]: https://lore.kernel.org/r/68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 kernel/trace/trace.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 85ec758c4455..2974ae056068 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9571,6 +9571,7 @@ extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
 static struct workqueue_struct *eval_map_wq __initdata;
 static struct work_struct eval_map_work __initdata;
+static struct work_struct tracerfs_init_work __initdata;
 
 static void __init eval_map_work_func(struct work_struct *work)
 {
@@ -9596,6 +9597,8 @@ static int __init trace_eval_init(void)
 	return 0;
 }
 
+subsys_initcall(trace_eval_init);
+
 static int __init trace_eval_sync(void)
 {
 	/* Make sure the eval map updates are finished */
@@ -9678,15 +9681,8 @@ static struct notifier_block trace_module_nb = {
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
 
@@ -9708,8 +9704,6 @@ static __init int tracer_init_tracefs(void)
 	trace_create_file("saved_tgids", TRACE_MODE_READ, NULL,
 			NULL, &tracing_saved_tgids_fops);
 
-	trace_eval_init();
-
 	trace_create_eval_file(NULL);
 
 #ifdef CONFIG_MODULES
@@ -9724,6 +9718,23 @@ static __init int tracer_init_tracefs(void)
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
+	INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
+	if (!eval_map_wq)
+		tracer_init_tracefs_work_func(&tracerfs_init_work);
+	else
+		queue_work(eval_map_wq, &tracerfs_init_work);
 
 	return 0;
 }
-- 
2.18.0

