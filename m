Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555A3548439
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiFMKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbiFMKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:01:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BC401CFF5;
        Mon, 13 Jun 2022 03:01:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FCCFD6E;
        Mon, 13 Jun 2022 03:01:47 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3A5B3F66F;
        Mon, 13 Jun 2022 03:01:41 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/8] arm64/perf: Add register definitions for BRBE
Date:   Mon, 13 Jun 2022 15:31:13 +0530
Message-Id: <20220613100119.684673-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613100119.684673-1-anshuman.khandual@arm.com>
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/arm64/include/asm/sysreg.h | 222 ++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 42ff95dba6da..f3547bc30b2a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -161,6 +161,224 @@
 #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
 #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
 
+/*
+ * BRBINF<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 0)
+ */
+#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), (((n) & 0x10)) >> 2)
+
+#define SYS_BRBINF0_EL1			__SYS_BRBINFO(0)
+#define SYS_BRBINF1_EL1			__SYS_BRBINFO(1)
+#define SYS_BRBINF2_EL1			__SYS_BRBINFO(2)
+#define SYS_BRBINF3_EL1			__SYS_BRBINFO(3)
+#define SYS_BRBINF4_EL1			__SYS_BRBINFO(4)
+#define SYS_BRBINF5_EL1			__SYS_BRBINFO(5)
+#define SYS_BRBINF6_EL1			__SYS_BRBINFO(6)
+#define SYS_BRBINF7_EL1			__SYS_BRBINFO(7)
+#define SYS_BRBINF8_EL1			__SYS_BRBINFO(8)
+#define SYS_BRBINF9_EL1			__SYS_BRBINFO(9)
+#define SYS_BRBINF10_EL1		__SYS_BRBINFO(10)
+#define SYS_BRBINF11_EL1		__SYS_BRBINFO(11)
+#define SYS_BRBINF12_EL1		__SYS_BRBINFO(12)
+#define SYS_BRBINF13_EL1		__SYS_BRBINFO(13)
+#define SYS_BRBINF14_EL1		__SYS_BRBINFO(14)
+#define SYS_BRBINF15_EL1		__SYS_BRBINFO(15)
+#define SYS_BRBINF16_EL1		__SYS_BRBINFO(16)
+#define SYS_BRBINF17_EL1		__SYS_BRBINFO(17)
+#define SYS_BRBINF18_EL1		__SYS_BRBINFO(18)
+#define SYS_BRBINF19_EL1		__SYS_BRBINFO(19)
+#define SYS_BRBINF20_EL1		__SYS_BRBINFO(20)
+#define SYS_BRBINF21_EL1		__SYS_BRBINFO(21)
+#define SYS_BRBINF22_EL1		__SYS_BRBINFO(22)
+#define SYS_BRBINF23_EL1		__SYS_BRBINFO(23)
+#define SYS_BRBINF24_EL1		__SYS_BRBINFO(24)
+#define SYS_BRBINF25_EL1		__SYS_BRBINFO(25)
+#define SYS_BRBINF26_EL1		__SYS_BRBINFO(26)
+#define SYS_BRBINF27_EL1		__SYS_BRBINFO(27)
+#define SYS_BRBINF28_EL1		__SYS_BRBINFO(28)
+#define SYS_BRBINF29_EL1		__SYS_BRBINFO(29)
+#define SYS_BRBINF30_EL1		__SYS_BRBINFO(30)
+#define SYS_BRBINF31_EL1		__SYS_BRBINFO(31)
+
+/*
+ * BRBSRC<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 1)
+ */
+#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
+
+#define SYS_BRBSRC0_EL1			__SYS_BRBSRC(0)
+#define SYS_BRBSRC1_EL1			__SYS_BRBSRC(1)
+#define SYS_BRBSRC2_EL1			__SYS_BRBSRC(2)
+#define SYS_BRBSRC3_EL1			__SYS_BRBSRC(3)
+#define SYS_BRBSRC4_EL1			__SYS_BRBSRC(4)
+#define SYS_BRBSRC5_EL1			__SYS_BRBSRC(5)
+#define SYS_BRBSRC6_EL1			__SYS_BRBSRC(6)
+#define SYS_BRBSRC7_EL1			__SYS_BRBSRC(7)
+#define SYS_BRBSRC8_EL1			__SYS_BRBSRC(8)
+#define SYS_BRBSRC9_EL1			__SYS_BRBSRC(9)
+#define SYS_BRBSRC10_EL1		__SYS_BRBSRC(10)
+#define SYS_BRBSRC11_EL1		__SYS_BRBSRC(11)
+#define SYS_BRBSRC12_EL1		__SYS_BRBSRC(12)
+#define SYS_BRBSRC13_EL1		__SYS_BRBSRC(13)
+#define SYS_BRBSRC14_EL1		__SYS_BRBSRC(14)
+#define SYS_BRBSRC15_EL1		__SYS_BRBSRC(15)
+#define SYS_BRBSRC16_EL1		__SYS_BRBSRC(16)
+#define SYS_BRBSRC17_EL1		__SYS_BRBSRC(17)
+#define SYS_BRBSRC18_EL1		__SYS_BRBSRC(18)
+#define SYS_BRBSRC19_EL1		__SYS_BRBSRC(19)
+#define SYS_BRBSRC20_EL1		__SYS_BRBSRC(20)
+#define SYS_BRBSRC21_EL1		__SYS_BRBSRC(21)
+#define SYS_BRBSRC22_EL1		__SYS_BRBSRC(22)
+#define SYS_BRBSRC23_EL1		__SYS_BRBSRC(23)
+#define SYS_BRBSRC24_EL1		__SYS_BRBSRC(24)
+#define SYS_BRBSRC25_EL1		__SYS_BRBSRC(25)
+#define SYS_BRBSRC26_EL1		__SYS_BRBSRC(26)
+#define SYS_BRBSRC27_EL1		__SYS_BRBSRC(27)
+#define SYS_BRBSRC28_EL1		__SYS_BRBSRC(28)
+#define SYS_BRBSRC29_EL1		__SYS_BRBSRC(29)
+#define SYS_BRBSRC30_EL1		__SYS_BRBSRC(30)
+#define SYS_BRBSRC31_EL1		__SYS_BRBSRC(31)
+
+/*
+ * BRBTGT<N>_EL1 Encoding: [2, 1, 8, CRm, op2]
+ *
+ * derived as <CRm> = c{N<3:0>} <op2> = (N<4>x4 + 2)
+ */
+#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))
+
+#define SYS_BRBTGT0_EL1			__SYS_BRBTGT(0)
+#define SYS_BRBTGT1_EL1			__SYS_BRBTGT(1)
+#define SYS_BRBTGT2_EL1			__SYS_BRBTGT(2)
+#define SYS_BRBTGT3_EL1			__SYS_BRBTGT(3)
+#define SYS_BRBTGT4_EL1			__SYS_BRBTGT(4)
+#define SYS_BRBTGT5_EL1			__SYS_BRBTGT(5)
+#define SYS_BRBTGT6_EL1			__SYS_BRBTGT(6)
+#define SYS_BRBTGT7_EL1			__SYS_BRBTGT(7)
+#define SYS_BRBTGT8_EL1			__SYS_BRBTGT(8)
+#define SYS_BRBTGT9_EL1			__SYS_BRBTGT(9)
+#define SYS_BRBTGT10_EL1		__SYS_BRBTGT(10)
+#define SYS_BRBTGT11_EL1		__SYS_BRBTGT(11)
+#define SYS_BRBTGT12_EL1		__SYS_BRBTGT(12)
+#define SYS_BRBTGT13_EL1		__SYS_BRBTGT(13)
+#define SYS_BRBTGT14_EL1		__SYS_BRBTGT(14)
+#define SYS_BRBTGT15_EL1		__SYS_BRBTGT(15)
+#define SYS_BRBTGT16_EL1		__SYS_BRBTGT(16)
+#define SYS_BRBTGT17_EL1		__SYS_BRBTGT(17)
+#define SYS_BRBTGT18_EL1		__SYS_BRBTGT(18)
+#define SYS_BRBTGT19_EL1		__SYS_BRBTGT(19)
+#define SYS_BRBTGT20_EL1		__SYS_BRBTGT(20)
+#define SYS_BRBTGT21_EL1		__SYS_BRBTGT(21)
+#define SYS_BRBTGT22_EL1		__SYS_BRBTGT(22)
+#define SYS_BRBTGT23_EL1		__SYS_BRBTGT(23)
+#define SYS_BRBTGT24_EL1		__SYS_BRBTGT(24)
+#define SYS_BRBTGT25_EL1		__SYS_BRBTGT(25)
+#define SYS_BRBTGT26_EL1		__SYS_BRBTGT(26)
+#define SYS_BRBTGT27_EL1		__SYS_BRBTGT(27)
+#define SYS_BRBTGT28_EL1		__SYS_BRBTGT(28)
+#define SYS_BRBTGT29_EL1		__SYS_BRBTGT(29)
+#define SYS_BRBTGT30_EL1		__SYS_BRBTGT(30)
+#define SYS_BRBTGT31_EL1		__SYS_BRBTGT(31)
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
@@ -936,6 +1154,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_BRBE_SHIFT		52
 #define ID_AA64DFR0_MTPMU_SHIFT		48
 #define ID_AA64DFR0_TRBE_SHIFT		44
 #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
@@ -958,6 +1177,9 @@
 #define ID_AA64DFR0_PMSVER_8_2		0x1
 #define ID_AA64DFR0_PMSVER_8_3		0x2
 
+#define ID_AA64DFR0_BRBE		0x1
+#define ID_AA64DFR0_BRBE_V1P1		0x2
+
 #define ID_DFR0_PERFMON_SHIFT		24
 
 #define ID_DFR0_PERFMON_8_0		0x3
-- 
2.25.1

