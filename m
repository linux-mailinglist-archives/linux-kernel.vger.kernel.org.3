Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF94E4B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiCWD0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiCWD0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:26:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DA6EB3D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:24:50 -0700 (PDT)
X-UUID: 331f8de305874faf8f575c8a29f5cf6a-20220323
X-UUID: 331f8de305874faf8f575c8a29f5cf6a-20220323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1424701584; Wed, 23 Mar 2022 11:24:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 11:24:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 11:24:44 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <oliver.sang@intel.com>, <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <lkp@intel.com>,
        <lkp@lists.01.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mingo@redhat.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] tracing: Avoid adding duplicated tracer options when update_tracer_options is running in parallel
Date:   Wed, 23 Mar 2022 11:24:42 +0800
Message-ID: <20220323032442.22082-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220322133339.GA32582@xsang-OptiPlex-9020>
References: <20220322133339.GA32582@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When update_tracer_options is running in parallel,
tr->tops might be updated before the trace_types list traversal.
Let update_tracer_options traverse the trace_types list safely in
kernel init time and avoid the tr->tops update before it finish.

Link: https://lore.kernel.org/lkml/20220322133339.GA32582@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 kernel/trace/trace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index adb37e437a05..2974ae056068 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6317,12 +6317,18 @@ static void tracing_set_nop(struct trace_array *tr)
 	tr->current_trace = &nop_trace;
 }
 
+static bool tracer_options_updated;
+
 static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
 	if (!tr->dir)
 		return;
 
+	/* Only create trace option files after update_tracer_options finish */
+	if (!tracer_options_updated)
+		return;
+
 	create_trace_option_files(tr, t);
 }
 
@@ -9133,6 +9139,7 @@ static void update_tracer_options(struct trace_array *tr)
 {
 	mutex_lock(&trace_types_lock);
 	__update_tracer_options(tr);
+	tracer_options_updated = true;
 	mutex_unlock(&trace_types_lock);
 }
 
-- 
2.18.0

