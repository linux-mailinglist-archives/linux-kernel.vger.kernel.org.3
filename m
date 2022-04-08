Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1C44F9DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiDHT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiDHT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:56:34 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832531B74DD;
        Fri,  8 Apr 2022 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649447670; x=1680983670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hs7l7btx3BvvUpzY5LDUhOznGf7Nmxoq2X1eK/jQ31U=;
  b=n3Kvxt0U43bX0rzt7nt9YEuVIZYmkwrnO6QBYysXl6/Qo8ULiZFQuS+C
   KIcxHfs1xITGBU+gwqsrwu0gHiL80hIdXnD9PaO+/dDM/ZRCStQyKFwUA
   GQrztIzQ4cBYAHNqmx6jcZo9X0Y6EhI/qmObSM/dlI3LZJIYQpztsMBmO
   E=;
X-IronPort-AV: E=Sophos;i="5.90,245,1643673600"; 
   d="scan'208";a="187479329"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 08 Apr 2022 19:54:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-54c9d11f.us-east-1.amazon.com (Postfix) with ESMTPS id 0730DC08E5;
        Fri,  8 Apr 2022 19:54:21 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:57 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:57 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 8 Apr 2022 19:53:56 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 740AE256D; Fri,  8 Apr 2022 19:53:55 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>, <acme@kernel.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <alexander.shishkin@linux.intel.com>,
        <andrew.kilroy@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>, <will@kernel.org>
Subject: [PATCH v5 1/5] tools: arm64: Import cputype.h
Date:   Fri, 8 Apr 2022 19:53:40 +0000
Message-ID: <20220408195344.32764-2-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408195344.32764-1-alisaidi@amazon.com>
References: <20220408195344.32764-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
for arm64 to make use of all the core-type definitions in perf.

Replace sysreg.h with the version already imported into tools/.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/arch/arm64/include/asm/cputype.h | 258 +++++++++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 tools/arch/arm64/include/asm/cputype.h

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
new file mode 100644
index 000000000000..9afcc6467a09
--- /dev/null
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+#ifndef __ASM_CPUTYPE_H
+#define __ASM_CPUTYPE_H
+
+#define INVALID_HWID		ULONG_MAX
+
+#define MPIDR_UP_BITMASK	(0x1 << 30)
+#define MPIDR_MT_BITMASK	(0x1 << 24)
+#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
+
+#define MPIDR_LEVEL_BITS_SHIFT	3
+#define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
+#define MPIDR_LEVEL_MASK	((1 << MPIDR_LEVEL_BITS) - 1)
+
+#define MPIDR_LEVEL_SHIFT(level) \
+	(((1 << level) >> 1) << MPIDR_LEVEL_BITS_SHIFT)
+
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
+
+#define MIDR_REVISION_MASK	0xf
+#define MIDR_REVISION(midr)	((midr) & MIDR_REVISION_MASK)
+#define MIDR_PARTNUM_SHIFT	4
+#define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
+#define MIDR_PARTNUM(midr)	\
+	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
+#define MIDR_ARCHITECTURE_SHIFT	16
+#define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
+#define MIDR_ARCHITECTURE(midr)	\
+	(((midr) & MIDR_ARCHITECTURE_MASK) >> MIDR_ARCHITECTURE_SHIFT)
+#define MIDR_VARIANT_SHIFT	20
+#define MIDR_VARIANT_MASK	(0xf << MIDR_VARIANT_SHIFT)
+#define MIDR_VARIANT(midr)	\
+	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
+#define MIDR_IMPLEMENTOR_SHIFT	24
+#define MIDR_IMPLEMENTOR_MASK	(0xff << MIDR_IMPLEMENTOR_SHIFT)
+#define MIDR_IMPLEMENTOR(midr)	\
+	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
+
+#define MIDR_CPU_MODEL(imp, partnum) \
+	(((imp)			<< MIDR_IMPLEMENTOR_SHIFT) | \
+	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
+	((partnum)		<< MIDR_PARTNUM_SHIFT))
+
+#define MIDR_CPU_VAR_REV(var, rev) \
+	(((var)	<< MIDR_VARIANT_SHIFT) | (rev))
+
+#define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
+			     MIDR_ARCHITECTURE_MASK)
+
+#define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_APM			0x50
+#define ARM_CPU_IMP_CAVIUM		0x43
+#define ARM_CPU_IMP_BRCM		0x42
+#define ARM_CPU_IMP_QCOM		0x51
+#define ARM_CPU_IMP_NVIDIA		0x4E
+#define ARM_CPU_IMP_FUJITSU		0x46
+#define ARM_CPU_IMP_HISI		0x48
+#define ARM_CPU_IMP_APPLE		0x61
+
+#define ARM_CPU_PART_AEM_V8		0xD0F
+#define ARM_CPU_PART_FOUNDATION		0xD00
+#define ARM_CPU_PART_CORTEX_A57		0xD07
+#define ARM_CPU_PART_CORTEX_A72		0xD08
+#define ARM_CPU_PART_CORTEX_A53		0xD03
+#define ARM_CPU_PART_CORTEX_A73		0xD09
+#define ARM_CPU_PART_CORTEX_A75		0xD0A
+#define ARM_CPU_PART_CORTEX_A35		0xD04
+#define ARM_CPU_PART_CORTEX_A55		0xD05
+#define ARM_CPU_PART_CORTEX_A76		0xD0B
+#define ARM_CPU_PART_NEOVERSE_N1	0xD0C
+#define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_NEOVERSE_V1	0xD40
+#define ARM_CPU_PART_CORTEX_A78		0xD41
+#define ARM_CPU_PART_CORTEX_X1		0xD44
+#define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_A710	0xD47
+#define ARM_CPU_PART_CORTEX_X2		0xD48
+#define ARM_CPU_PART_NEOVERSE_N2	0xD49
+#define ARM_CPU_PART_CORTEX_A78C	0xD4B
+
+#define APM_CPU_PART_POTENZA		0x000
+
+#define CAVIUM_CPU_PART_THUNDERX	0x0A1
+#define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
+#define CAVIUM_CPU_PART_THUNDERX_83XX	0x0A3
+#define CAVIUM_CPU_PART_THUNDERX2	0x0AF
+/* OcteonTx2 series */
+#define CAVIUM_CPU_PART_OCTX2_98XX	0x0B1
+#define CAVIUM_CPU_PART_OCTX2_96XX	0x0B2
+#define CAVIUM_CPU_PART_OCTX2_95XX	0x0B3
+#define CAVIUM_CPU_PART_OCTX2_95XXN	0x0B4
+#define CAVIUM_CPU_PART_OCTX2_95XXMM	0x0B5
+#define CAVIUM_CPU_PART_OCTX2_95XXO	0x0B6
+
+#define BRCM_CPU_PART_BRAHMA_B53	0x100
+#define BRCM_CPU_PART_VULCAN		0x516
+
+#define QCOM_CPU_PART_FALKOR_V1		0x800
+#define QCOM_CPU_PART_FALKOR		0xC00
+#define QCOM_CPU_PART_KRYO		0x200
+#define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
+#define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
+#define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
+#define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
+
+#define NVIDIA_CPU_PART_DENVER		0x003
+#define NVIDIA_CPU_PART_CARMEL		0x004
+
+#define FUJITSU_CPU_PART_A64FX		0x001
+
+#define HISI_CPU_PART_TSV110		0xD01
+
+#define APPLE_CPU_PART_M1_ICESTORM	0x022
+#define APPLE_CPU_PART_M1_FIRESTORM	0x023
+
+#define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+#define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
+#define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
+#define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
+#define MIDR_CORTEX_A35 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A35)
+#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
+#define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
+#define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
+#define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
+#define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
+#define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
+#define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
+#define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
+#define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
+#define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
+#define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
+#define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
+#define MIDR_OCTX2_98XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_98XX)
+#define MIDR_OCTX2_96XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_96XX)
+#define MIDR_OCTX2_95XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XX)
+#define MIDR_OCTX2_95XXN MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXN)
+#define MIDR_OCTX2_95XXMM MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXMM)
+#define MIDR_OCTX2_95XXO MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_OCTX2_95XXO)
+#define MIDR_CAVIUM_THUNDERX2 MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX2)
+#define MIDR_BRAHMA_B53 MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_BRAHMA_B53)
+#define MIDR_BRCM_VULCAN MIDR_CPU_MODEL(ARM_CPU_IMP_BRCM, BRCM_CPU_PART_VULCAN)
+#define MIDR_QCOM_FALKOR_V1 MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR_V1)
+#define MIDR_QCOM_FALKOR MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_FALKOR)
+#define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
+#define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
+#define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
+#define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
+#define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
+#define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
+#define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
+#define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
+#define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
+
+/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
+#define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
+#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_CPU_VAR_REV(1, 0))
+#define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)
+
+#ifndef __ASSEMBLY__
+
+#include "sysreg.h"
+
+#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
+
+/*
+ * Represent a range of MIDR values for a given CPU model and a
+ * range of variant/revision values.
+ *
+ * @model	- CPU model as defined by MIDR_CPU_MODEL
+ * @rv_min	- Minimum value for the revision/variant as defined by
+ *		  MIDR_CPU_VAR_REV
+ * @rv_max	- Maximum value for the variant/revision for the range.
+ */
+struct midr_range {
+	u32 model;
+	u32 rv_min;
+	u32 rv_max;
+};
+
+#define MIDR_RANGE(m, v_min, r_min, v_max, r_max)		\
+	{							\
+		.model = m,					\
+		.rv_min = MIDR_CPU_VAR_REV(v_min, r_min),	\
+		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
+	}
+
+#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
+#define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
+#define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
+
+static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
+					   u32 rv_max)
+{
+	u32 _model = midr & MIDR_CPU_MODEL_MASK;
+	u32 rv = midr & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);
+
+	return _model == model && rv >= rv_min && rv <= rv_max;
+}
+
+static inline bool is_midr_in_range(u32 midr, struct midr_range const *range)
+{
+	return midr_is_cpu_model_range(midr, range->model,
+				       range->rv_min, range->rv_max);
+}
+
+static inline bool
+is_midr_in_range_list(u32 midr, struct midr_range const *ranges)
+{
+	while (ranges->model)
+		if (is_midr_in_range(midr, ranges++))
+			return true;
+	return false;
+}
+
+/*
+ * The CPU ID never changes at run time, so we might as well tell the
+ * compiler that it's constant.  Use this function to read the CPU ID
+ * rather than directly reading processor_id or read_cpuid() directly.
+ */
+static inline u32 __attribute_const__ read_cpuid_id(void)
+{
+	return read_cpuid(MIDR_EL1);
+}
+
+static inline u64 __attribute_const__ read_cpuid_mpidr(void)
+{
+	return read_cpuid(MPIDR_EL1);
+}
+
+static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
+{
+	return MIDR_IMPLEMENTOR(read_cpuid_id());
+}
+
+static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
+{
+	return MIDR_PARTNUM(read_cpuid_id());
+}
+
+static inline u32 __attribute_const__ read_cpuid_cachetype(void)
+{
+	return read_cpuid(CTR_EL0);
+}
+#endif /* __ASSEMBLY__ */
+
+#endif
-- 
2.32.0

