Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93E74C55CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiBZMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiBZMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:35:03 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF801CFA2E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:34:28 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21QB9OKh026106;
        Sat, 26 Feb 2022 04:33:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=D9x7VqFP9H1RRad+KXn/qCLD1LolS1QYT66GB+23zJQ=;
 b=VTnD4LcyiuK1ckJkhGL45bGEBr/puVJZygj2McPU11JeUG2D6/aETOHFd1dfljNsjUMB
 Oh3h+0VXyLVSlO8TfMD+riC0z/SwwZ+h336yrVMI5S3gUCA/D3LKKsZijtbVMXTLFdnc
 rmcP7URO1ayx0J/0YS9eBGhzfEBPOOsLrdhbf4GckA6AKPE+jY9MyXZ0Ls1UkI9d2Jpn
 n9mFKSb0bqnGwnexk5BG4pknuYPsk2lM9silFwgr7nfDRgMOxG64jvebr4LGnU5rCxUJ
 SvzFZdfwMUX2m17JnxPiKHAFblFTaeQWpwl9FKztiuE2DkZyyTNLADPgw9gI3c1N7BKw 2g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3eegm888sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 26 Feb 2022 04:33:57 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 26 Feb
 2022 04:33:55 -0800
Received: from localhost.localdomain (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sat, 26 Feb 2022 04:33:52 -0800
From:   Linu Cherian <lcherian@marvell.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
Date:   Sat, 26 Feb 2022 18:03:32 +0530
Message-ID: <20220226123332.29988-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gIyQA9F90xhWVyQskfzq5Tg3wgwp7HIP
X-Proofpoint-GUID: gIyQA9F90xhWVyQskfzq5Tg3wgwp7HIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_11,2022-02-25_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a IAR register read races with a GIC interrupt RELEASE event,
GIC-CPU interface could wrongly return a valid INTID to the CPU
for an interrupt that is already released(non activated) instead of 0x3ff.

As a side effect, an interrupt handler could run twice, once with
interrupt priority and then with idle priority.

As a workaround, gic_read_iar is updated so that it will return a
valid interrupt ID only if there is a change in the active priority list
after the IAR read on all the affected Silicons.

Along with this, Thunderx erratum 23154 is reworked to use GIC IIDR
based quirk management for the sake of consistency and also
because there is workaround overlap on some silicon variants.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +-
 arch/arm64/Kconfig                     | 10 -----
 arch/arm64/include/asm/arch_gicv3.h    | 24 +++++++++--
 arch/arm64/kernel/cpu_errata.c         |  8 ----
 arch/arm64/tools/cpucaps               |  1 -
 drivers/irqchip/irq-gic-v3.c           | 56 +++++++++++++++++++++++++-
 6 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ea281dd75517..f602faf4bf82 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -136,10 +136,12 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144        |
 +----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
+| Cavium         | ThunderX GICv3  | #23154          | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX GICv3  | #38539          | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Cavium         | ThunderX GICv3  | #38545          | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09b885cc4db5..889cb56bf5ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -890,16 +890,6 @@ config CAVIUM_ERRATUM_23144
 
 	  If unsure, say Y.
 
-config CAVIUM_ERRATUM_23154
-	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
-	default y
-	help
-	  The gicv3 of ThunderX requires a modified version for
-	  reading the IAR status to ensure data synchronization
-	  (access to icc_iar1_el1 is not sync'ed before and after).
-
-	  If unsure, say Y.
-
 config CAVIUM_ERRATUM_27456
 	bool "Cavium erratum 27456: Broadcast TLBI instructions may cause icache corruption"
 	default y
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 4ad22c3135db..bc98a60a4bcb 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -47,21 +47,37 @@ static inline u64 gic_read_iar_common(void)
 	return irqstat;
 }
 
-/*
+/* Marvell Erratum 38545
+ *
+ * When a IAR register read races with a GIC interrupt RELEASE event,
+ * GIC-CPU interface could wrongly return a valid INTID to the CPU
+ * for an interrupt that is already released(non activated) instead of 0x3ff.
+ *
+ * To workaround this, return a valid interrupt ID only if there is a change
+ * in the active priority list after the IAR read.
+ *
  * Cavium ThunderX erratum 23154
  *
  * The gicv3 of ThunderX requires a modified version for reading the
  * IAR status to ensure data synchronization (access to icc_iar1_el1
  * is not sync'ed before and after).
+ *
+ * Have merged both the workarounds into a common function since,
+ * 1. On Thunderx 88xx 1.x both erratas are applicable.
+ * 2. Having extra nops doesn't add any side effects for Silicons where
+ *    erratum 23154 is not applicable.
  */
-static inline u64 gic_read_iar_cavium_thunderx(void)
+static inline u64 gic_read_iar_marvell_38545_23154(void)
 {
-	u64 irqstat;
+	u64 irqstat, apr;
 
+	apr = read_sysreg_s(SYS_ICC_AP1R0_EL1);
 	nops(8);
 	irqstat = read_sysreg_s(SYS_ICC_IAR1_EL1);
 	nops(4);
-	mb();
+	dsb(sy);
+	if (unlikely(apr == read_sysreg_s(SYS_ICC_AP1R0_EL1)))
+		return 0x3ff;
 
 	return irqstat;
 }
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b217941713a8..79beb800ee79 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -423,14 +423,6 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(erratum_845719_list),
 	},
 #endif
-#ifdef CONFIG_CAVIUM_ERRATUM_23154
-	{
-	/* Cavium ThunderX, pass 1.x */
-		.desc = "Cavium erratum 23154",
-		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
-	},
-#endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 	{
 		.desc = "Cavium erratum 27456",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 9c65b1e25a96..3f751fe4fec4 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -62,7 +62,6 @@ WORKAROUND_2077057
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
-WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
 WORKAROUND_CAVIUM_TX2_219_PRFM
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5e935d97207d..a3b58bf4fce4 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -35,6 +35,8 @@
 
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
+#define FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154	(1ULL << 2)
+#define FLAGS_WORKAROUND_MARVELL_ERRATUM_38545	(1ULL << 3)
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
@@ -60,6 +62,7 @@ struct gic_chip_data {
 
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
+static DEFINE_STATIC_KEY_FALSE(gic_iar_quirk);
 
 #define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
 #define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
@@ -235,10 +238,19 @@ static void gic_redist_wait_for_rwp(void)
 
 #ifdef CONFIG_ARM64
 
+static u64 __maybe_unused gic_read_iar_fixup(void)
+{
+	if (gic_data.flags & FLAGS_WORKAROUND_MARVELL_ERRATUM_38545 ||
+		gic_data.flags & FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154)
+		return gic_read_iar_marvell_38545_23154();
+	else /* Not possible */
+		return ICC_IAR1_EL1_SPURIOUS;
+}
+
 static u64 __maybe_unused gic_read_iar(void)
 {
-	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
-		return gic_read_iar_cavium_thunderx();
+	if (static_branch_unlikely(&gic_iar_quirk))
+		return gic_read_iar_fixup();
 	else
 		return gic_read_iar_common();
 }
@@ -1614,6 +1626,16 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_cavium_23154(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_CAVIUM_ERRATUM_23154;
+	static_branch_enable(&gic_iar_quirk);
+
+	return true;
+}
+
 static bool gic_enable_quirk_cavium_38539(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1623,6 +1645,16 @@ static bool gic_enable_quirk_cavium_38539(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_marvell_38545(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	d->flags |= FLAGS_WORKAROUND_MARVELL_ERRATUM_38545;
+	static_branch_enable(&gic_iar_quirk);
+
+	return true;
+}
+
 static bool gic_enable_quirk_hip06_07(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1660,6 +1692,13 @@ static const struct gic_quirk gic_quirks[] = {
 		.iidr	= 0x00000000,
 		.mask	= 0xffffffff,
 		.init	= gic_enable_quirk_hip06_07,
+	},
+		/* ThunderX: CN88xx 1.x */
+	{
+		.desc	= "GICv3: Cavium erratum 23154",
+		.iidr	= 0xa101034c,
+		.mask	= 0xffff0fff,
+		.init	= gic_enable_quirk_cavium_23154,
 	},
 	{
 		/*
@@ -1674,6 +1713,19 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xe8f00fff,
 		.init	= gic_enable_quirk_cavium_38539,
 	},
+	{
+		/*
+		 * IAR register reads could be unreliable, under certain
+		 * race conditions. This erratum applies to:
+		 * - ThunderX: CN88xx
+		 * - OCTEON TX: CN83xx, CN81xx
+		 * - OCTEON TX2: CN93xx, CN96xx, CN98xx, CNF95xx*
+		 */
+		.desc	= "GICv3: Marvell erratum 38545",
+		.iidr	= 0xa000034c,
+		.mask	= 0xe0f00fff,
+		.init	= gic_enable_quirk_marvell_38545,
+	},
 	{
 	}
 };
-- 
2.31.1

