Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C925B4AE95E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbiBIFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:35:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBIFeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:34:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E64C03C180
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:33:55 -0800 (PST)
X-UUID: 3e4478ee8b9a48adad1dfc034d29a3c2-20220209
X-UUID: 3e4478ee8b9a48adad1dfc034d29a3c2-20220209
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 203253098; Wed, 09 Feb 2022 13:33:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Feb 2022 13:33:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Feb 2022 13:33:51 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <matthias.bgg@gmail.com>, <akpm@linux-foundation.org>,
        <mhiramat@kernel.org>, <vbabka@suse.cz>, <ahalaney@redhat.com>,
        <wangkefeng.wang@huawei.com>, <linux@rasmusvillemoes.dk>,
        <keescook@chromium.org>, <mark-pk.tsai@mediatek.com>,
        <valentin.schneider@arm.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: [PATCH] init: Use ktime_us_delta() to make initcall_debug log more precise
Date:   Wed, 9 Feb 2022 13:33:50 +0800
Message-ID: <20220209053350.15771-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Use ktime_us_delta() to make the initcall_debug log more precise than
right shifting the result of ktime_to_ns() by 10 bits.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 init/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c0..c8edcc3029b1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1246,15 +1246,11 @@ trace_initcall_start_cb(void *data, initcall_t fn)
 static __init_or_module void
 trace_initcall_finish_cb(void *data, initcall_t fn, int ret)
 {
-	ktime_t *calltime = (ktime_t *)data;
-	ktime_t delta, rettime;
-	unsigned long long duration;
+	ktime_t rettime, *calltime = (ktime_t *)data;
 
 	rettime = ktime_get();
-	delta = ktime_sub(rettime, *calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 	printk(KERN_DEBUG "initcall %pS returned %d after %lld usecs\n",
-		 fn, ret, duration);
+		 fn, ret, (unsigned long long)ktime_us_delta(rettime, *calltime));
 }
 
 static ktime_t initcall_calltime;
-- 
2.18.0

