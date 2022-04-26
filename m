Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21E050FCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbiDZM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiDZM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:27:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8015AE0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:24:27 -0700 (PDT)
X-UUID: 04aee38b8ee7468ba8aba8e641dbf88e-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b1772e2a-f2b1-483c-8415-f0fdec7e7836,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:9781c22e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 04aee38b8ee7468ba8aba8e641dbf88e-20220426
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1964950952; Tue, 26 Apr 2022 20:24:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 26 Apr 2022 20:24:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Apr
 2022 20:24:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 20:24:19 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v4 2/2] tracing: make tracer_init_tracefs initcall asynchronous
Date:   Tue, 26 Apr 2022 20:24:07 +0800
Message-ID: <20220426122407.17042-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220426122407.17042-1-mark-pk.tsai@mediatek.com>
References: <20220426122407.17042-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 kernel/trace/trace.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0ec7b013104a..7f6ad8f06129 100644
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
2.18.0

