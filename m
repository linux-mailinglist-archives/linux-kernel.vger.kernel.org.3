Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2C4B3451
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiBLKo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiBLKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:44:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C526AD0;
        Sat, 12 Feb 2022 02:44:01 -0800 (PST)
X-UUID: 8e52404fa81a47c9915abefe35a56fc9-20220212
X-UUID: 8e52404fa81a47c9915abefe35a56fc9-20220212
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 281329606; Sat, 12 Feb 2022 18:43:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 12 Feb 2022 18:43:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Feb 2022 18:43:52 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <sumit.garg@linaro.org>,
        <kernelfans@gmail.com>, <lecopzer.chen@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH 2/5] kernel/watchdog: change watchdog_nmi_enable() to void
Date:   Sat, 12 Feb 2022 18:43:46 +0800
Message-ID: <20220212104349.14266-3-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
References: <20220212104349.14266-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nobody cares about the return value of watchdog_nmi_enable(),
changing its prototype to void.

This commit reworks from [1].

[1] https://lore.kernel.org/lkml/20211014024155.15253-2-kernelfans@gmail.com/
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/sparc/kernel/nmi.c | 8 ++++----
 include/linux/nmi.h     | 2 +-
 kernel/watchdog.c       | 3 +--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 060fff95a305..8dc0f4e820b0 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -282,11 +282,11 @@ __setup("nmi_watchdog=", setup_nmi_watchdog);
  * sparc specific NMI watchdog enable function.
  * Enables watchdog if it is not enabled already.
  */
-int watchdog_nmi_enable(unsigned int cpu)
+void watchdog_nmi_enable(unsigned int cpu)
 {
 	if (atomic_read(&nmi_active) == -1) {
 		pr_warn("NMI watchdog cannot be enabled or disabled\n");
-		return -1;
+		return;
 	}
 
 	/*
@@ -295,11 +295,11 @@ int watchdog_nmi_enable(unsigned int cpu)
 	 * process first.
 	 */
 	if (!nmi_init_done)
-		return 0;
+		return;
 
 	smp_call_function_single(cpu, start_nmi_watchdog, NULL, 1);
 
-	return 0;
+	return;
 }
 /*
  * sparc specific NMI watchdog disable function.
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 750c7f395ca9..b7bcd63c36b4 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
-int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_enable(unsigned int cpu);
 void watchdog_nmi_disable(unsigned int cpu);
 
 /**
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index db451e943a04..b71d434cf648 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -93,10 +93,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-int __weak watchdog_nmi_enable(unsigned int cpu)
+void __weak watchdog_nmi_enable(unsigned int cpu)
 {
 	hardlockup_detector_perf_enable();
-	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
-- 
2.25.1

