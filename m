Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A843749782E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiAXEby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:31:54 -0500
Received: from foss.arm.com ([217.140.110.172]:47150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241414AbiAXEbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:31:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C56CED1;
        Sun, 23 Jan 2022 20:31:53 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.119.34.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 826C53F73B;
        Sun, 23 Jan 2022 20:31:44 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: [RFC V1 02/11] arm64/perf: Add register definitions for BRBE
Date:   Mon, 24 Jan 2022 10:00:44 +0530
Message-Id: <1642998653-21377-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds BRBE related register definitions and various other related field
macros there in. These will be used subsequently in a BRBE driver which is
being added later on.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 216 ++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 898bee0004ae..d8fd7e806a47 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -141,6 +141,218 @@
 #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
 #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
 
+/*
+ * BRBINF<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 0)
+ */
+#define SYS_BRBINF0_EL1			sys_reg(2, 1, 8, 0, 0)
+#define SYS_BRBINF1_EL1			sys_reg(2, 1, 8, 1, 0)
+#define SYS_BRBINF2_EL1			sys_reg(2, 1, 8, 2, 0)
+#define SYS_BRBINF3_EL1			sys_reg(2, 1, 8, 3, 0)
+#define SYS_BRBINF4_EL1			sys_reg(2, 1, 8, 4, 0)
+#define SYS_BRBINF5_EL1			sys_reg(2, 1, 8, 5, 0)
+#define SYS_BRBINF6_EL1			sys_reg(2, 1, 8, 6, 0)
+#define SYS_BRBINF7_EL1			sys_reg(2, 1, 8, 7, 0)
+#define SYS_BRBINF8_EL1			sys_reg(2, 1, 8, 8, 0)
+#define SYS_BRBINF9_EL1			sys_reg(2, 1, 8, 9, 0)
+#define SYS_BRBINF10_EL1		sys_reg(2, 1, 8, 10, 0)
+#define SYS_BRBINF11_EL1		sys_reg(2, 1, 8, 11, 0)
+#define SYS_BRBINF12_EL1		sys_reg(2, 1, 8, 12, 0)
+#define SYS_BRBINF13_EL1		sys_reg(2, 1, 8, 13, 0)
+#define SYS_BRBINF14_EL1		sys_reg(2, 1, 8, 14, 0)
+#define SYS_BRBINF15_EL1		sys_reg(2, 1, 8, 15, 0)
+#define SYS_BRBINF16_EL1		sys_reg(2, 1, 8, 0, 4)
+#define SYS_BRBINF17_EL1		sys_reg(2, 1, 8, 1, 4)
+#define SYS_BRBINF18_EL1		sys_reg(2, 1, 8, 2, 4)
+#define SYS_BRBINF19_EL1		sys_reg(2, 1, 8, 3, 4)
+#define SYS_BRBINF20_EL1		sys_reg(2, 1, 8, 4, 4)
+#define SYS_BRBINF21_EL1		sys_reg(2, 1, 8, 5, 4)
+#define SYS_BRBINF22_EL1		sys_reg(2, 1, 8, 6, 4)
+#define SYS_BRBINF23_EL1		sys_reg(2, 1, 8, 7, 4)
+#define SYS_BRBINF24_EL1		sys_reg(2, 1, 8, 8, 4)
+#define SYS_BRBINF25_EL1		sys_reg(2, 1, 8, 9, 4)
+#define SYS_BRBINF26_EL1		sys_reg(2, 1, 8, 10, 4)
+#define SYS_BRBINF27_EL1		sys_reg(2, 1, 8, 11, 4)
+#define SYS_BRBINF28_EL1		sys_reg(2, 1, 8, 12, 4)
+#define SYS_BRBINF29_EL1		sys_reg(2, 1, 8, 13, 4)
+#define SYS_BRBINF30_EL1		sys_reg(2, 1, 8, 14, 4)
+#define SYS_BRBINF31_EL1		sys_reg(2, 1, 8, 15, 4)
+
+/*
+ * BRBSRC<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 1)
+ */
+#define SYS_BRBSRC0_EL1			sys_reg(2, 1, 8, 0, 1)
+#define SYS_BRBSRC1_EL1			sys_reg(2, 1, 8, 1, 1)
+#define SYS_BRBSRC2_EL1			sys_reg(2, 1, 8, 2, 1)
+#define SYS_BRBSRC3_EL1			sys_reg(2, 1, 8, 3, 1)
+#define SYS_BRBSRC4_EL1			sys_reg(2, 1, 8, 4, 1)
+#define SYS_BRBSRC5_EL1			sys_reg(2, 1, 8, 5, 1)
+#define SYS_BRBSRC6_EL1			sys_reg(2, 1, 8, 6, 1)
+#define SYS_BRBSRC7_EL1			sys_reg(2, 1, 8, 7, 1)
+#define SYS_BRBSRC8_EL1			sys_reg(2, 1, 8, 8, 1)
+#define SYS_BRBSRC9_EL1			sys_reg(2, 1, 8, 9, 1)
+#define SYS_BRBSRC10_EL1		sys_reg(2, 1, 8, 10, 1)
+#define SYS_BRBSRC11_EL1		sys_reg(2, 1, 8, 11, 1)
+#define SYS_BRBSRC12_EL1		sys_reg(2, 1, 8, 12, 1)
+#define SYS_BRBSRC13_EL1		sys_reg(2, 1, 8, 13, 1)
+#define SYS_BRBSRC14_EL1		sys_reg(2, 1, 8, 14, 1)
+#define SYS_BRBSRC15_EL1		sys_reg(2, 1, 8, 15, 1)
+#define SYS_BRBSRC16_EL1		sys_reg(2, 1, 8, 0, 5)
+#define SYS_BRBSRC17_EL1		sys_reg(2, 1, 8, 1, 5)
+#define SYS_BRBSRC18_EL1		sys_reg(2, 1, 8, 2, 5)
+#define SYS_BRBSRC19_EL1		sys_reg(2, 1, 8, 3, 5)
+#define SYS_BRBSRC20_EL1		sys_reg(2, 1, 8, 4, 5)
+#define SYS_BRBSRC21_EL1		sys_reg(2, 1, 8, 5, 5)
+#define SYS_BRBSRC22_EL1		sys_reg(2, 1, 8, 6, 5)
+#define SYS_BRBSRC23_EL1		sys_reg(2, 1, 8, 7, 5)
+#define SYS_BRBSRC24_EL1		sys_reg(2, 1, 8, 8, 5)
+#define SYS_BRBSRC25_EL1		sys_reg(2, 1, 8, 9, 5)
+#define SYS_BRBSRC26_EL1		sys_reg(2, 1, 8, 10, 5)
+#define SYS_BRBSRC27_EL1		sys_reg(2, 1, 8, 11, 5)
+#define SYS_BRBSRC28_EL1		sys_reg(2, 1, 8, 12, 5)
+#define SYS_BRBSRC29_EL1		sys_reg(2, 1, 8, 13, 5)
+#define SYS_BRBSRC30_EL1		sys_reg(2, 1, 8, 14, 5)
+#define SYS_BRBSRC31_EL1		sys_reg(2, 1, 8, 15, 5)
+
+/*
+ * BRBTGT<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 2)
+ */
+#define SYS_BRBTGT0_EL1			sys_reg(2, 1, 8, 0, 2)
+#define SYS_BRBTGT1_EL1			sys_reg(2, 1, 8, 1, 2)
+#define SYS_BRBTGT2_EL1			sys_reg(2, 1, 8, 2, 2)
+#define SYS_BRBTGT3_EL1			sys_reg(2, 1, 8, 3, 2)
+#define SYS_BRBTGT4_EL1			sys_reg(2, 1, 8, 4, 2)
+#define SYS_BRBTGT5_EL1			sys_reg(2, 1, 8, 5, 2)
+#define SYS_BRBTGT6_EL1			sys_reg(2, 1, 8, 6, 2)
+#define SYS_BRBTGT7_EL1			sys_reg(2, 1, 8, 7, 2)
+#define SYS_BRBTGT8_EL1			sys_reg(2, 1, 8, 8, 2)
+#define SYS_BRBTGT9_EL1			sys_reg(2, 1, 8, 9, 2)
+#define SYS_BRBTGT10_EL1		sys_reg(2, 1, 8, 10, 2)
+#define SYS_BRBTGT11_EL1		sys_reg(2, 1, 8, 11, 2)
+#define SYS_BRBTGT12_EL1		sys_reg(2, 1, 8, 12, 2)
+#define SYS_BRBTGT13_EL1		sys_reg(2, 1, 8, 13, 2)
+#define SYS_BRBTGT14_EL1		sys_reg(2, 1, 8, 14, 2)
+#define SYS_BRBTGT15_EL1		sys_reg(2, 1, 8, 15, 2)
+#define SYS_BRBTGT16_EL1		sys_reg(2, 1, 8, 0, 6)
+#define SYS_BRBTGT17_EL1		sys_reg(2, 1, 8, 1, 6)
+#define SYS_BRBTGT18_EL1		sys_reg(2, 1, 8, 2, 6)
+#define SYS_BRBTGT19_EL1		sys_reg(2, 1, 8, 3, 6)
+#define SYS_BRBTGT20_EL1		sys_reg(2, 1, 8, 4, 6)
+#define SYS_BRBTGT21_EL1		sys_reg(2, 1, 8, 5, 6)
+#define SYS_BRBTGT22_EL1		sys_reg(2, 1, 8, 6, 6)
+#define SYS_BRBTGT23_EL1		sys_reg(2, 1, 8, 7, 6)
+#define SYS_BRBTGT24_EL1		sys_reg(2, 1, 8, 8, 6)
+#define SYS_BRBTGT25_EL1		sys_reg(2, 1, 8, 9, 6)
+#define SYS_BRBTGT26_EL1		sys_reg(2, 1, 8, 10, 6)
+#define SYS_BRBTGT27_EL1		sys_reg(2, 1, 8, 11, 6)
+#define SYS_BRBTGT28_EL1		sys_reg(2, 1, 8, 12, 6)
+#define SYS_BRBTGT29_EL1		sys_reg(2, 1, 8, 13, 6)
+#define SYS_BRBTGT30_EL1		sys_reg(2, 1, 8, 14, 6)
+#define SYS_BRBTGT31_EL1		sys_reg(2, 1, 8, 15, 6)
+
+#define SYS_BRBIDR0_EL1			sys_reg(2, 1, 9, 2, 0)
+#define SYS_BRBCR_EL1			sys_reg(2, 1, 9, 0, 0)
+#define SYS_BRBFCR_EL1			sys_reg(2, 1, 9, 0, 1)
+#define SYS_BRBTS_EL1			sys_reg(2, 1, 9, 0, 2)
+#define SYS_BRBINFINJ_EL1		sys_reg(2, 1, 9, 1, 0)
+#define SYS_BRBSRCINJ_EL1		sys_reg(2, 1, 9, 1, 1)
+#define SYS_BRBTGTINJ_EL1		sys_reg(2, 1, 9, 1, 2)
+
+#define BRBIDR0_CC_SHIFT	12
+#define BRBIDR0_CC_MASK		GENMASK(3, 0)
+#define BRBIDR0_FORMAT_SHIFT	8
+#define BRBIDR0_FORMAT_MASK	GENMASK(3, 0)
+#define BRBIDR0_NUMREC_SHIFT	0
+#define BRBIDR0_NUMREC_MASK	GENMASK(7, 0)
+
+#define BRBIDR0_CC_20_BIT	0x5
+#define BRBIDR0_FORMAT_0	0x0
+
+#define BRBIDR0_NUMREC_8	0x08
+#define BRBIDR0_NUMREC_16	0x10
+#define BRBIDR0_NUMREC_32	0x20
+#define BRBIDR0_NUMREC_64	0x40
+
+#define BRBINF_VALID_SHIFT	0
+#define BRBINF_VALID_MASK	GENMASK(1, 0)
+#define BRBINF_MPRED		(1UL << 5)
+#define BRBINF_EL_SHIFT		6
+#define BRBINF_EL_MASK		GENMASK(1, 0)
+#define BRBINF_TYPE_SHIFT	8
+#define BRBINF_TYPE_MASK	GENMASK(5, 0)
+#define BRBINF_TX		(1UL << 16)
+#define BRBINF_LASTFAILED	(1UL << 17)
+#define BRBINF_CC_SHIFT		32
+#define BRBINF_CC_MASK		GENMASK(13, 0)
+#define BRBINF_CCU		(1UL << 46)
+
+#define BRBINF_EL_EL0		0x0
+#define BRBINF_EL_EL1		0x1
+#define BRBINF_EL_EL2		0x2
+
+#define BRBINF_VALID_INVALID	0x0
+#define BRBINF_VALID_TARGET	0x1
+#define BRBINF_VALID_SOURCE	0x2
+#define BRBINF_VALID_ALL	0x3
+
+#define BRBINF_TYPE_UNCOND_DIR	0x0
+#define BRBINF_TYPE_INDIR	0x1
+#define BRBINF_TYPE_DIR_LINK	0x2
+#define BRBINF_TYPE_INDIR_LINK	0x3
+#define BRBINF_TYPE_RET_SUB	0x5
+#define BRBINF_TYPE_RET_EXCPT	0x7
+#define BRBINF_TYPE_COND_DIR	0x8
+#define BRBINF_TYPE_DEBUG_HALT	0x21
+#define BRBINF_TYPE_CALL	0x22
+#define BRBINF_TYPE_TRAP	0x23
+#define BRBINF_TYPE_SERROR	0x24
+#define BRBINF_TYPE_INST_DEBUG	0x26
+#define BRBINF_TYPE_DATA_DEBUG	0x27
+#define BRBINF_TYPE_ALGN_FAULT	0x2A
+#define BRBINF_TYPE_INST_FAULT	0x2B
+#define BRBINF_TYPE_DATA_FAULT	0x2C
+#define BRBINF_TYPE_IRQ		0x2E
+#define BRBINF_TYPE_FIQ		0x2F
+#define BRBINF_TYPE_DEBUG_EXIT	0x39
+
+#define BRBCR_E0BRE		(1UL << 0)
+#define BRBCR_E1BRE		(1UL << 1)
+#define BRBCR_CC		(1UL << 3)
+#define BRBCR_MPRED		(1UL << 4)
+#define BRBCR_FZP		(1UL << 8)
+#define BRBCR_ERTN		(1UL <<	22)
+#define BRBCR_EXCEPTION		(1UL << 23)
+#define BRBCR_TS_MASK		GENMASK(1, 0)
+#define BRBCR_TS_SHIFT		5
+
+#define BRBCR_TS_VIRTUAL	0x1
+#define BRBCR_TS_GST_PHYSICAL	0x2
+#define BRBCR_TS_PHYSICAL	0x3
+
+#define BRBFCR_LASTFAILED	(1UL << 6)
+#define BRBFCR_PAUSED		(1UL << 7)
+#define BRBFCR_ENL		(1UL << 16)
+#define BRBFCR_DIRECT		(1UL << 17)
+#define BRBFCR_INDIRECT		(1UL << 18)
+#define BRBFCR_RTN		(1UL << 19)
+#define BRBFCR_INDCALL		(1UL << 20)
+#define BRBFCR_DIRCALL		(1UL << 21)
+#define BRBFCR_CONDDIR		(1UL << 22)
+#define BRBFCR_BANK_MASK	GENMASK(1, 0)
+#define BRBFCR_BANK_SHIFT	28
+
+#define BRBFCR_BANK_FIRST	0x0
+#define BRBFCR_BANK_SECOND	0x1
+
+#define BRBFCR_BRANCH_ALL	(BRBFCR_DIRECT | BRBFCR_INDIRECT | \
+				 BRBFCR_RTN | BRBFCR_INDCALL | \
+				 BRBFCR_DIRCALL | BRBFCR_CONDDIR)
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -937,6 +1149,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_BRBE_SHIFT		52
 #define ID_AA64DFR0_MTPMU_SHIFT		48
 #define ID_AA64DFR0_TRBE_SHIFT		44
 #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
@@ -959,6 +1172,9 @@
 #define ID_AA64DFR0_PMSVER_8_2		0x1
 #define ID_AA64DFR0_PMSVER_8_3		0x2
 
+#define ID_AA64DFR0_BRBE		0x1
+#define ID_AA64DFR0_BRBE_V1P1		0x2
+
 #define ID_DFR0_PERFMON_SHIFT		24
 
 #define ID_DFR0_PERFMON_8_0		0x3
-- 
2.25.1

