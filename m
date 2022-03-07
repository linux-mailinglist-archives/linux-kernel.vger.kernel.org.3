Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01E4D0140
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243208AbiCGObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiCGObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:31:44 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0447892E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:30:50 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2278qQiL024110;
        Mon, 7 Mar 2022 06:30:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=wUeQpqXJQ5UQkotA01zIIJyxFuuD7za50yQqRypCnt0=;
 b=QTnhD85H38LYNUkNXe2VM5pGM64V4yrArV8XNav22//fO3mQOa+Rl4PIQrbWeacAAjj2
 gISyXwNWN0AfQWXIcieMabQmi97yJuLmKWzyx69u/BtVwheJ7BLXvQV/ecG6+cijDUBx
 uAnnn9TVZRJrzVAUG6G0HNnUGq4xaPXYHZPxZ1vxuO68U2hM7RHQfTgEWfcvZe2+2d70
 CRli9daxq34js0QlZ4duZkGgQGUOcRgTOdQlijfXts2rcJl+QtEDYieXkTAdu6g6lBcW
 Os8gCoAOSI3XW58V1sdS+Gd5oafPRi2yLeqI8XNId5rc0zURarJ73RR+MSvfWYxf7pyh nQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3em88rf6e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 06:30:28 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 06:30:26 -0800
Received: from localhost.localdomain (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 06:30:24 -0800
From:   Linu Cherian <lcherian@marvell.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuc.decode@gmail.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH V3] irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
Date:   Mon, 7 Mar 2022 20:00:14 +0530
Message-ID: <20220307143014.22758-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LM-p_-9FdQF_nN_gXxaEomHeLkYCzdlD
X-Proofpoint-GUID: LM-p_-9FdQF_nN_gXxaEomHeLkYCzdlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_05,2022-03-04_01,2022-02-23_01
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
- Changed masked part number to individual part numbers
- Added additional comment to clarify on priority groups


Changes since V1:
- IIDR based quirk management done for 23154 has been reverted
- Extended existing 23154 errata to address 38545 as well,
  so that existing static keys are reused. 
- Added MIDR based support macros to cover all the affected parts
- Changed the unlikely construct to likely construct in the workaround
  function.




 Documentation/arm64/silicon-errata.rst |  2 +-
 arch/arm64/Kconfig                     |  8 ++++++--
 arch/arm64/include/asm/arch_gicv3.h    | 23 +++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h       | 13 +++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++++++---
 5 files changed, 58 insertions(+), 8 deletions(-)

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
index 4ad22c3135db..8bd5afc7b692 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -53,17 +53,36 @@ static inline u64 gic_read_iar_common(void)
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
+	/* Max priority groups implemented is only 32 */
+	if (likely(apr != read_sysreg_s(SYS_ICC_AP1R0_EL1)))
+		return irqstat;
+
+	return 0x3ff;
 }
 
 static inline void gic_write_ctlr(u32 val)
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 999b9149f856..4596e7ca29a3 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,13 @@
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
 #define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
 #define CAVIUM_CPU_PART_THUNDERX2	0x0AF
+/* OcteonTx2 series */
+#define CAVIUM_CPU_PART_OCTX2_98XX	0x0B1
+#define CAVIUM_CPU_PART_OCTX2_96XX	0x0B2
+#define CAVIUM_CPU_PART_OCTX2_95XX	0x0B3
+#define CAVIUM_CPU_PART_OCTX2_95XXN	0x0B4
+#define CAVIUM_CPU_PART_OCTX2_95XXMM	0x0B5
+#define CAVIUM_CPU_PART_OCTX2_95XXO	0x0B6
 
 #define BRCM_CPU_PART_BRAHMA_B53	0x100
 #define BRCM_CPU_PART_VULCAN		0x516
@@ -124,6 +131,12 @@
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
+#define MIDR_OCTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_98XX)
+#define MIDR_OCTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_96XX)
+#define MIDR_OCTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XX)
+#define MIDR_OCTX2_95XXN MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXN)
+#define MIDR_OCTX2_95XXMM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXMM)
+#define MIDR_OCTX2_95XXO MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXO)
 #define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
 #define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
 #define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index b217941713a8..510f47055b91 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -214,6 +214,20 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 };
 #endif
 
+#ifdef CONFIG_CAVIUM_ERRATUM_23154
+const struct midr_range cavium_erratum_23154_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_THUNDERX),
+	MIDR_ALL_VERSIONS(MIDR_THUNDERX_81XX),
+	MIDR_ALL_VERSIONS(MIDR_THUNDERX_83XX),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_98XX),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_96XX),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XX),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXN),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXMM),
+	MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXO),
+};
+#endif
+
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
 const struct midr_range cavium_erratum_27456_cpus[] = {
 	/* Cavium ThunderX, T88 pass 1.x - 2.1 */
@@ -425,10 +439,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_23154
 	{
-	/* Cavium ThunderX, pass 1.x */
-		.desc = "Cavium erratum 23154",
+		.desc = "Cavium errata 23154 and 38545",
 		.capability = ARM64_WORKAROUND_CAVIUM_23154,
-		ERRATA_MIDR_REV_RANGE(MIDR_THUNDERX, 0, 0, 1),
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		ERRATA_MIDR_RANGE_LIST(cavium_erratum_23154_cpus),
 	},
 #endif
 #ifdef CONFIG_CAVIUM_ERRATUM_27456
-- 
2.31.1

