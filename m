Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8004354A96A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbiFNG2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFNG2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:28:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C551A053;
        Mon, 13 Jun 2022 23:28:44 -0700 (PDT)
X-UUID: 60ba03447e5242208d7a45c4a509135a-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:7d242545-ccb6-4726-ad27-5548a84fd232,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:73c68407-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 60ba03447e5242208d7a45c4a509135a-20220614
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1522900914; Tue, 14 Jun 2022 14:28:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 14 Jun 2022 14:28:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 14:28:38 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <pmladek@suse.com>, <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: [PATCH v6 3/6] kernel/watchdog_hld: Ensure CPU-bound context when creating hardlockup detector event
Date:   Tue, 14 Jun 2022 14:28:32 +0800
Message-ID: <20220614062835.7196-4-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614062835.7196-1-lecopzer.chen@mediatek.com>
References: <20220614062835.7196-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pingfan Liu <kernelfans@gmail.com>

hardlockup_detector_event_create() should create perf_event on the
current CPU. Preemption could not get disabled because
perf_event_create_kernel_counter() allocates memory. Instead,
the CPU locality is achieved by processing the code in a per-CPU
bound kthread.

Add a check to prevent mistakes when calling the code in another
code path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Co-developed-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog_hld.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 701f35f0e2d4..0573cef0b9dc 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -169,10 +169,16 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 static int hardlockup_detector_event_create(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
+	/*
+	 * Preemption is not disabled because memory will be allocated.
+	 * Ensure CPU-locality by calling this in per-CPU kthread.
+	 */
+	WARN_ON(!is_percpu_thread());
+	cpu = raw_smp_processor_id();
 	wd_attr = &wd_hw_attr;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
-- 
2.25.1

