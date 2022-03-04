Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7224CCB69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiCDBod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCDBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:44:30 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C34A927
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:43:42 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223KFNKI002105;
        Thu, 3 Mar 2022 17:43:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=gMRSygu8oUVD18f0RXxPP6e46xxHMRZu3DOJmUmOsPY=;
 b=LzjWKXdlwBKF9L1G4mftG6FOVm1Zg0F9nzlfzUqsO2hQFIVkXRTpcMbdG4ouLNpOnqAb
 9/bMfdZWBp9fO5QUzLMjx6tS6gVknoIFmuD2MqmIxVzDLiN8SAfsEs7YMWSerSQd5n/9
 Ey5OWIrzVDhTjuzzbae3cL1UOnUs8rygcVt2qV/JfKzn34YyMnLW4gLuRRiNKpsRupwJ
 cFWBqKuDxpZ8+3AZnwC18ij+JEWsP0fCa/acEO6uR16jiOQ2YGpGLTvnFmI94dgf3StG
 WjyJx9+MlGNUy3apZyE6P1fP2/Qf6DQ6yrrv9UANnGA8N1WVAGQaHZ37UJ/TEwGo/3vE xQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ek4j6187a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 17:43:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Mar
 2022 17:43:10 -0800
Received: from localhost.localdomain (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Mar 2022 17:43:08 -0800
From:   Linu Cherian <lcherian@marvell.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH V2] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
Date:   Fri, 4 Mar 2022 07:13:01 +0530
Message-ID: <20220304014301.2515-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6-xQbTQ54jeVRPVKTw6ZtllguXLcTU34
X-Proofpoint-ORIG-GUID: 6-xQbTQ54jeVRPVKTw6ZtllguXLcTU34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_14,2022-02-26_01,2022-02-23_01
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

Since there are silicon variants where both 23154 and 38545 are applicable,
workaround for erratum 23154 has been extended to address both of them.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changes since V2:
- IIDR based quirk management done for 23154 has been reverted
- Extended existing 23154 errata to address 38545 as well,
  so that existing static keys are reused. 
- Added MIDR based support macros to cover all the affected parts
- Changed the unlikely construct to likely construct in the workaround
  function.



 Documentation/arm64/silicon-errata.rst |  2 +-
 arch/arm64/Kconfig                     |  8 ++++++--
 arch/arm64/include/asm/arch_gicv3.h    | 22 ++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 25 ++++++++++++++++++++++---
 5 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ea281dd75517..466cb9e89047 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -136,7 +136,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144        |
 +----------------+-----------------+-----------------+-----------------------------+
-| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
+| Cavium         | ThunderX GICv3  | #23154,38545    | CAVIUM_ERRATUM_23154        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Cavium         | ThunderX GICv3  | #38539          | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09b885cc4db5..778cc2e22c21 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -891,13 +891,17 @@ config CAVIUM_ERRATUM_23144
 	  If unsure, say Y.
 
 config CAVIUM_ERRATUM_23154
-	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
+	bool "Cavium errata 23154 and 38545: GICv3 lacks HW synchronisation"
 	default y
 	help
-	  The gicv3 of ThunderX requires a modified version for
+	  The ThunderX GICv3 implementation requires a modified version for
 	  reading the IAR status to ensure data synchronization
 	  (access to icc_iar1_el1 is not sync'ed before and after).
 
+	  It also suffers from erratum 38545 (also present on Marvell's
+	  OcteonTX and OcteonTX2), resulting in deactivated interrupts being
+	  spuriously presented to the CPU interface.
+
 	  If unsure, say Y.
 
 config CAVIUM_ERRATUM_27456
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 4ad22c3135db..b8fd7b1f9944 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -53,17 +53,35 @@ static inline u64 gic_read_iar_common(void)
  * The gicv3 of ThunderX requires a modified version for reading the
  * IAR status to ensure data synchronization (access to icc_iar1_el1
  * is not sync'ed before and after).
+ *
+ * Erratum 38545
+ *
+ * When a IAR register read races with a GIC interrupt RELEASE event,
+ * GIC-CPU interface could wrongly return a valid INTID to the CPU
+ * for an interrupt that is already released(non activated) instead of 0x3ff.
+ *
+ * To workaround this, return a valid interrupt ID only if there is a change
+ * in the active priority list after the IAR read.
+ *
+ * Common function used for both the workarounds since,
+ * 1. On Thunderx 88xx 1.x both erratas are applicable.
+ * 2. Having extra nops doesn't add any side effects for Silicons where
+ *    erratum 23154 is not applicable.
  */
 static inline u64 gic_read_iar_cavium_thunderx(void)
 {
-	u64 irqstat;
+	u64 irqstat, apr;
 
+	apr = read_sysreg_s(SYS_ICC_AP1R0_EL1);
 	nops(8);
 	irqstat = read_sysreg_s(SYS_ICC_IAR1_EL1);
 	nops(4);
 	mb();
 
-	return irqstat;
+	if (likely(apr != read_sysreg_s(SYS_ICC_AP1R0_EL1)))
+		return irqstat;
+
+	return 0x3ff;
 }
 
 static inline void gic_write_ctlr(u32 val)
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 999b9149f856..9407c5074a4f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -80,6 +80,7 @@
 
 #define APM_CPU_PART_POTENZA		0x000
 
+#define CAVIUM_CPU_PART_THUNDERX_OTX_GEN 0x0A0
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
 #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
@@ -121,6 +122,7 @@
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
+#define MIDR_THUNDERX_OTX_GEN MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_OTX_GEN)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b217941713a8..82ed09b363d6 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -41,6 +41,25 @@ is_affected_midr_range_list(const struct arm64_cpu_capabilities *entry,
 	return is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list);
 }
 
+static bool __maybe_unused
+is_marvell_thunderx_otx_family(const struct arm64_cpu_capabilities *entry,
+			       int scope)
+{
+	u32 model;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	model = read_cpuid_id();
+	/* 0xe8 mask will cover  0xA1 - 0xA3 and 0xB1 - 0xB6 series with
+	 * 0xAF and 0xB8 as exceptions
+	 */
+	model &= MIDR_IMPLEMENTOR_MASK | (0x0e8 << MIDR_PARTNUM_SHIFT) |
+		 MIDR_ARCHITECTURE_MASK;
+
+	/* This includes Thunderx, OcteonTx, OcteonTx2 family of processors */
+	return model == MIDR_THUNDERX_OTX_GEN;
+}
+
 static bool __maybe_unused
 is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -425,10 +444,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
 	{
-	/* Cavium ThunderX, pass 1.x */
-		.desc = "Cavium erratum 23154",
+		.desc = "Cavium errata 23154 and 38545",
 		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = is_marvell_thunderx_otx_family,
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-- 
2.31.1

