Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2949555A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377652AbiATUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377615AbiATUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:20:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66308C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:05 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so26039153lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stM6rtCmeCfLYKQfRp4s9qjPP/vxrAlF+iACfdMlm60=;
        b=tzsHpPUUNaX8gA2LDDB+8C+KX5po7but2XyaqxvbnxdFgaV5opWICwOD3hGOiDU99w
         k3owABMnsqZtL7owoyiP3uaIlVQefCUYzpr2lLJXPvHlwpYPLyY/eLkI/q+NRG/SiZd4
         NCn4Ngi91XK0B0mFum5V0SGZsqWojMbkW8aDo735whyaXJzFyux9LVBrFPo5Ot4WmXzw
         az0ySd+7qrIIgDwc4Z6bjgCT6AlvX1ADuJ1WAsjshV4jOR4XNqqDVz6jOdLDH+JWqz6X
         j33yb4rd5+XVzaSI7+0MyWtzPpWAi5FcuGLzLZCVs2tLQDfTdWIySpFAHPMRjsazbNni
         mtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stM6rtCmeCfLYKQfRp4s9qjPP/vxrAlF+iACfdMlm60=;
        b=IrXMXlj9CIupI2ShEPf/ksIiVh5Pp5nrt53sAC5v8EgBUInDoe6T03W4vOfDUIhJ58
         S3Ht2LICNeLKH1ueTHfNgfLwlt6lsXrHFs0Xnt8lNZM6XFucGRFZIjfBu3Wkhtk1wMKL
         PHeWlcK5z+eVC+0PFzDV432rHItxPD4qWkbEPTyN1HE7qH8ZJchfuTceHOahpBuNW0Q+
         uvP38dji3DEcIXM2nYk+CCF3aAPhVfh11Jh49g6N9/ecJz9phMpiykj0Yr/daWGLKk7P
         Mab/UtoD4/PoFBuA9KT2rhtgqCVTUX5zOCmiK9HJufx2Z6BLrMbEBwwdl+4LRwMXSfXq
         blIw==
X-Gm-Message-State: AOAM533mCDqbEUKrariGzR+p5fK2TEXJGJQ9f2JX3NGMXzz9NrcH4/z0
        hHa5Eqzrd/OyOjnx6idD25/DqQ==
X-Google-Smtp-Source: ABdhPJzOpQc/qY0uq8TYZR0oJttOreE7jAioyE0r8o4X4aGc7qV2Wt/zycS07IkPIcFqNVFxBEAZ4A==
X-Received: by 2002:a05:6512:2011:: with SMTP id a17mr663170lfb.643.1642710003316;
        Thu, 20 Jan 2022 12:20:03 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id p13sm22184lfh.189.2022.01.20.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:20:02 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Jinkyu Yang <jinkyu1.yang@samsung.com>,
        Alex <acnwigwe@google.com>, Carlos Llamas <cmllamas@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Erick Reyes <erickreyes@google.com>,
        "J . Avila" <elavila@google.com>, Jonglin Lee <jonglin@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 2/3] iommu/samsung: Introduce Exynos sysmmu-v8 driver
Date:   Thu, 20 Jan 2022 22:19:57 +0200
Message-Id: <20220120201958.2649-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120201958.2649-1-semen.protsenko@linaro.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new driver for modern Exynos ARMv8 SoCs, e.g. Exynos850. Also
it's used for Google's GS101 SoC.

This is squashed commit, contains next patches of different authors. See
`iommu-exynos850-dev' branch for details: [1].

Original authors (Samsung):

 - Cho KyongHo <pullip.cho@samsung.com>
 - Hyesoo Yu <hyesoo.yu@samsung.com>
 - Janghyuck Kim <janghyuck.kim@samsung.com>
 - Jinkyu Yang <jinkyu1.yang@samsung.com>

Some improvements were made by Google engineers:

 - Alex <acnwigwe@google.com>
 - Carlos Llamas <cmllamas@google.com>
 - Daniel Mentz <danielmentz@google.com>
 - Erick Reyes <erickreyes@google.com>
 - J. Avila <elavila@google.com>
 - Jonglin Lee <jonglin@google.com>
 - Mark Salyzyn <salyzyn@google.com>
 - Thierry Strudel <tstrudel@google.com>
 - Will McVicker <willmcvicker@google.com>

[1] https://github.com/joe-skb7/linux/tree/iommu-exynos850-dev

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/Kconfig               |   13 +
 drivers/iommu/Makefile              |    3 +
 drivers/iommu/samsung-iommu-fault.c |  617 +++++++++++
 drivers/iommu/samsung-iommu-group.c |   50 +
 drivers/iommu/samsung-iommu.c       | 1521 +++++++++++++++++++++++++++
 drivers/iommu/samsung-iommu.h       |  216 ++++
 6 files changed, 2420 insertions(+)
 create mode 100644 drivers/iommu/samsung-iommu-fault.c
 create mode 100644 drivers/iommu/samsung-iommu-group.c
 create mode 100644 drivers/iommu/samsung-iommu.c
 create mode 100644 drivers/iommu/samsung-iommu.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3eb68fa1b8cc..78e7039f18aa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -452,6 +452,19 @@ config QCOM_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
 
+config SAMSUNG_IOMMU
+	tristate "Samsung IOMMU Support"
+	select ARM_DMA_USE_IOMMU
+	select IOMMU_DMA
+	select SAMSUNG_IOMMU_GROUP
+	help
+	  Support for IOMMU on Samsung Exynos SoCs.
+
+config SAMSUNG_IOMMU_GROUP
+	tristate "Samsung IOMMU Group Support"
+	help
+	  Support for IOMMU group on Samsung Exynos SoCs.
+
 config HYPERV_IOMMU
 	bool "Hyper-V x2APIC IRQ Handling"
 	depends on HYPERV && X86
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bc7f730edbb0..a8bdf449f1d4 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,9 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_SAMSUNG_IOMMU) += samsung_iommu.o
+samsung_iommu-objs += samsung-iommu.o samsung-iommu-fault.o
+obj-$(CONFIG_SAMSUNG_IOMMU_GROUP) += samsung-iommu-group.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
diff --git a/drivers/iommu/samsung-iommu-fault.c b/drivers/iommu/samsung-iommu-fault.c
new file mode 100644
index 000000000000..c6b4259976c4
--- /dev/null
+++ b/drivers/iommu/samsung-iommu-fault.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ */
+
+#define pr_fmt(fmt) "sysmmu: " fmt
+
+#include <linux/smc.h>
+#include <linux/arm-smccc.h>
+#include <linux/pm_runtime.h>
+
+#include "samsung-iommu.h"
+
+#define MMU_TLB_INFO(n)			(0x2000 + ((n) * 0x20))
+#define MMU_CAPA1_NUM_TLB_SET(reg)	(((reg) >> 16) & 0xFF)
+#define MMU_CAPA1_NUM_TLB_WAY(reg)	((reg) & 0xFF)
+#define MMU_CAPA1_SET_TLB_READ_ENTRY(tid, set, way, line)		\
+					((set) | ((way) << 8) |		\
+					 ((line) << 16) | ((tid) << 20))
+
+#define MMU_TLB_ENTRY_VALID(reg)	((reg) >> 28)
+#define MMU_SBB_ENTRY_VALID(reg)	((reg) >> 28)
+#define MMU_VADDR_FROM_TLB(reg, idx)	((((reg) & 0xFFFFC) | ((idx) & 0x3)) << 12)
+#define MMU_VID_FROM_TLB(reg)		(((reg) >> 20) & 0x7U)
+#define MMU_PADDR_FROM_TLB(reg)		((phys_addr_t)((reg) & 0xFFFFFF) << 12)
+#define MMU_VADDR_FROM_SBB(reg)		(((reg) & 0xFFFFF) << 12)
+#define MMU_VID_FROM_SBB(reg)		(((reg) >> 20) & 0x7U)
+#define MMU_PADDR_FROM_SBB(reg)		((phys_addr_t)((reg) & 0x3FFFFFF) << 10)
+
+#define REG_MMU_INT_STATUS		0x060
+#define REG_MMU_INT_CLEAR		0x064
+#define REG_MMU_FAULT_RW_MASK		GENMASK(20, 20)
+#define IS_READ_FAULT(x)		(((x) & REG_MMU_FAULT_RW_MASK) == 0)
+
+#define SYSMMU_FAULT_PTW_ACCESS   0
+#define SYSMMU_FAULT_PAGE_FAULT   1
+#define SYSMMU_FAULT_ACCESS       2
+#define SYSMMU_FAULT_RESERVED     3
+#define SYSMMU_FAULT_UNKNOWN      4
+
+#define SYSMMU_SEC_FAULT_MASK		(BIT(SYSMMU_FAULT_PTW_ACCESS) | \
+					 BIT(SYSMMU_FAULT_PAGE_FAULT) | \
+					 BIT(SYSMMU_FAULT_ACCESS))
+
+#define SYSMMU_FAULTS_NUM         (SYSMMU_FAULT_UNKNOWN + 1)
+
+#if IS_ENABLED(CONFIG_EXYNOS_CONTENT_PATH_PROTECTION)
+#define SMC_DRM_SEC_SMMU_INFO		(0x820020D0)
+#define SMC_DRM_SEC_SYSMMU_INT_CLEAR	(0x820020D7)
+
+/* secure SysMMU SFR access */
+enum sec_sysmmu_sfr_access_t {
+	SEC_SMMU_SFR_READ,
+	SEC_SMMU_SFR_WRITE,
+};
+
+#define is_secure_info_fail(x)		((((x) >> 16) & 0xffff) == 0xdead)
+static inline u32 read_sec_info(unsigned int addr)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_DRM_SEC_SMMU_INFO,
+		      (unsigned long)addr, 0, SEC_SMMU_SFR_READ, 0, 0, 0, 0,
+		      &res);
+	if (is_secure_info_fail(res.a0))
+		pr_err("Invalid value returned, %#lx\n", res.a0);
+
+	return (u32)res.a0;
+}
+
+static inline u32 clear_sec_fault(unsigned int addr, unsigned int val)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_DRM_SEC_SYSMMU_INT_CLEAR,
+		      (unsigned long)addr, (unsigned long)val, 0, 0, 0, 0, 0,
+		      &res);
+	return (u32)res.a0;
+}
+
+#else
+static inline u32 read_sec_info(unsigned int addr)
+{
+	return 0xdead;
+}
+
+static inline u32 clear_sec_fault(unsigned int addr, unsigned int val)
+{
+	return 0;
+}
+
+#endif
+
+static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
+	"PTW ACCESS FAULT",
+	"PAGE FAULT",
+	"ACCESS FAULT",
+	"RESERVED",
+	"UNKNOWN FAULT"
+};
+
+static unsigned int sysmmu_fault_type[SYSMMU_FAULTS_NUM] = {
+	IOMMU_FAULT_REASON_WALK_EABT,
+	IOMMU_FAULT_REASON_PTE_FETCH,
+	IOMMU_FAULT_REASON_ACCESS,
+	IOMMU_FAULT_REASON_UNKNOWN,
+	IOMMU_FAULT_REASON_UNKNOWN,
+};
+
+struct samsung_sysmmu_fault_info {
+	struct sysmmu_drvdata *drvdata;
+	struct iommu_fault_event event;
+};
+
+static inline u32 __sysmmu_get_intr_status(struct sysmmu_drvdata *data,
+					   bool is_secure)
+{
+	if (is_secure)
+		return read_sec_info(data->secure_base + REG_MMU_INT_STATUS);
+	else
+		return readl_relaxed(data->sfrbase + REG_MMU_INT_STATUS);
+}
+
+static inline sysmmu_iova_t __sysmmu_get_fault_address(struct sysmmu_drvdata *data,
+						       unsigned int vid, bool is_secure)
+{
+	if (is_secure)
+		return read_sec_info(MMU_SEC_VM_REG(data, IDX_FAULT_VA, vid));
+	else
+		return readl_relaxed(MMU_VM_REG(data, IDX_FAULT_VA, vid));
+}
+
+static inline void sysmmu_tlb_compare(phys_addr_t pgtable[MAX_VIDS],
+				      unsigned int idx_sub, u32 vpn, u32 ppn, u32 attr)
+{
+	sysmmu_pte_t *entry;
+	sysmmu_iova_t vaddr = MMU_VADDR_FROM_TLB(vpn, idx_sub);
+	unsigned int vid = MMU_VID_FROM_TLB(attr);
+	phys_addr_t paddr = MMU_PADDR_FROM_TLB(ppn);
+	phys_addr_t phys = 0;
+
+	if (!pgtable[vid])
+		return;
+
+	entry = section_entry(phys_to_virt(pgtable[vid]), vaddr);
+
+	if (lv1ent_section(entry)) {
+		phys = section_phys(entry);
+	} else if (lv1ent_page(entry)) {
+		entry = page_entry(entry, vaddr);
+
+		if (lv2ent_large(entry))
+			phys = lpage_phys(entry);
+		else if (lv2ent_small(entry))
+			phys = spage_phys(entry);
+	} else {
+		pr_crit(">> Invalid address detected! entry: %#lx",
+			(unsigned long)*entry);
+		return;
+	}
+
+	if (paddr != phys) {
+		pr_crit(">> TLB mismatch detected!\n");
+		pr_crit("   TLB: %pa, PT entry: %pa\n", &paddr, &phys);
+	}
+}
+
+static inline void sysmmu_sbb_compare(u32 sbb_vpn, u32 sbb_link, u32 sbbattr,
+				      phys_addr_t pgtable[MAX_VIDS])
+{
+	sysmmu_pte_t *entry;
+	sysmmu_iova_t vaddr = MMU_VADDR_FROM_SBB(sbb_vpn);
+	unsigned int vid = MMU_VID_FROM_SBB(sbbattr);
+	phys_addr_t paddr = MMU_PADDR_FROM_SBB(sbb_link);
+	phys_addr_t phys = 0;
+
+	if (!pgtable[vid])
+		return;
+
+	entry = section_entry(phys_to_virt(pgtable[vid]), vaddr);
+
+	if (lv1ent_page(entry)) {
+		phys = lv2table_base(entry);
+
+		if (paddr != phys) {
+			pr_crit(">> SBB mismatch detected!\n");
+			pr_crit("   entry addr: %pa / SBB addr %pa\n",
+				&paddr, &phys);
+		}
+	} else {
+		pr_crit(">> Invalid address detected! entry: %#lx",
+			(unsigned long)*entry);
+	}
+}
+
+static inline
+unsigned int dump_tlb_entry_port_type(struct sysmmu_drvdata *drvdata, phys_addr_t pgtable[MAX_VIDS],
+				      unsigned int idx_way, unsigned int idx_set,
+				      unsigned int idx_sub)
+{
+	u32 attr = readl_relaxed(MMU_REG(drvdata, IDX_TLB_ATTR));
+
+	if (MMU_TLB_ENTRY_VALID(attr)) {
+		u32 vpn, ppn;
+
+		vpn = readl_relaxed(MMU_REG(drvdata, IDX_TLB_VPN)) + idx_sub;
+		ppn = readl_relaxed(MMU_REG(drvdata, IDX_TLB_PPN));
+
+		pr_crit("[%02u][%02u] VPN: %#010x, PPN: %#010x, ATTR: %#010x\n",
+			idx_way, idx_set, vpn, ppn, attr);
+		sysmmu_tlb_compare(pgtable, idx_sub, vpn, ppn, attr);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+#define MMU_NUM_TLB_SUBLINE		4
+static unsigned int dump_tlb_entry_port(struct sysmmu_drvdata *drvdata,
+					phys_addr_t pgtable[MAX_VIDS],
+					unsigned int tlb, unsigned int way, unsigned int num_set)
+{
+	unsigned int cnt = 0;
+	unsigned int set, line, val;
+
+	for (set = 0; set < num_set; set++) {
+		for (line = 0; line < MMU_NUM_TLB_SUBLINE; line++) {
+			val = MMU_CAPA1_SET_TLB_READ_ENTRY(tlb, set, way, line);
+			writel_relaxed(val, MMU_REG(drvdata, IDX_TLB_READ));
+			cnt += dump_tlb_entry_port_type(drvdata, pgtable,
+							way, set, line);
+		}
+	}
+
+	return cnt;
+}
+
+static inline void dump_sysmmu_tlb_status(struct sysmmu_drvdata *drvdata,
+					  phys_addr_t pgtable[MAX_VIDS])
+{
+	unsigned int t, i;
+	u32 capa0, capa1, info;
+	unsigned int cnt;
+	unsigned int num_tlb, num_port, num_sbb;
+	void __iomem *sfrbase = drvdata->sfrbase;
+
+	capa0 = readl_relaxed(sfrbase + REG_MMU_CAPA0_V7);
+	capa1 = readl_relaxed(sfrbase + REG_MMU_CAPA1_V7);
+
+	num_tlb = MMU_CAPA1_NUM_TLB(capa1);
+	num_port = MMU_CAPA1_NUM_PORT(capa1);
+	num_sbb = 1 << MMU_CAPA_NUM_SBB_ENTRY(capa0);
+
+	pr_crit("SysMMU has %u TLBs, %u ports, %u sbb entries\n",
+		num_tlb, num_port, num_sbb);
+
+	for (t = 0; t < num_tlb; t++) {
+		unsigned int num_set, num_way;
+
+		info = readl_relaxed(sfrbase + MMU_TLB_INFO(t));
+		num_way = MMU_CAPA1_NUM_TLB_WAY(info);
+		num_set = MMU_CAPA1_NUM_TLB_SET(info);
+
+		pr_crit("TLB.%u has %u way, %u set.\n", t, num_way, num_set);
+		pr_crit("------------- TLB[WAY][SET][ENTRY] -------------\n");
+		for (i = 0, cnt = 0; i < num_way; i++)
+			cnt += dump_tlb_entry_port(drvdata, pgtable,
+						   t, i, num_set);
+	}
+	if (!cnt)
+		pr_crit(">> No Valid TLB Entries\n");
+
+	pr_crit("--- SBB(Second-Level Page Table Base Address Buffer) ---\n");
+	for (i = 0, cnt = 0; i < num_sbb; i++) {
+		u32 sbb_vpn, sbblink, sbbattr;
+
+		writel_relaxed(i, MMU_REG(drvdata, IDX_SBB_READ));
+		sbb_vpn = readl_relaxed(MMU_REG(drvdata, IDX_SBB_VPN));
+
+		if (MMU_SBB_ENTRY_VALID(sbb_vpn)) {
+			sbblink = readl_relaxed(MMU_REG(drvdata, IDX_SBB_LINK));
+			sbbattr = readl_relaxed(MMU_REG(drvdata, IDX_SBB_ATTR));
+
+			pr_crit("[%02d] VPN: %#010x, PPN: %#010x, ATTR: %#010x",
+				i, sbb_vpn, sbblink, sbbattr);
+			sysmmu_sbb_compare(sbb_vpn, sbblink, sbbattr, pgtable);
+			cnt++;
+		}
+	}
+	if (!cnt)
+		pr_crit(">> No Valid SBB Entries\n");
+}
+
+static inline void dump_sysmmu_status(struct sysmmu_drvdata *drvdata,
+				      phys_addr_t pgtable[MAX_VIDS], unsigned int vid)
+{
+	int info;
+	void __iomem *sfrbase = drvdata->sfrbase;
+
+	info = MMU_RAW_VER(readl_relaxed(sfrbase + REG_MMU_VERSION));
+
+	pr_crit("ADDR: (VA: %p), MMU_CTRL: %#010x, PT_BASE: %#010x\n",
+		sfrbase,
+		readl_relaxed(sfrbase + REG_MMU_CTRL),
+		readl_relaxed(MMU_VM_REG(drvdata, IDX_FLPT_BASE, vid)));
+	pr_crit("VERSION %d.%d.%d, MMU_CFG: %#010x, MMU_STATUS: %#010x\n",
+		MMU_MAJ_VER(info), MMU_MIN_VER(info), MMU_REV_VER(info),
+		readl_relaxed(sfrbase + REG_MMU_CFG),
+		readl_relaxed(sfrbase + REG_MMU_STATUS));
+
+	if (drvdata->has_vcr)
+		pr_crit("MMU_CTRL_VM: %#010x, MMU_CFG_VM: %#010x\n",
+			readl_relaxed(MMU_VM_REG(drvdata, IDX_CTRL_VM, vid)),
+			readl_relaxed(MMU_VM_REG(drvdata, IDX_CFG_VM, vid)));
+
+	dump_sysmmu_tlb_status(drvdata, pgtable);
+}
+
+static void sysmmu_get_fault_msg(struct sysmmu_drvdata *drvdata, unsigned int intr_type,
+				 unsigned int vid, sysmmu_iova_t fault_addr,
+				 bool is_secure, char *fault_msg, size_t fault_msg_sz)
+{
+	const char *port_name = NULL;
+	unsigned int info;
+
+	of_property_read_string(drvdata->dev->of_node, "port-name", &port_name);
+
+	if (is_secure) {
+		info = read_sec_info(MMU_SEC_REG(drvdata, IDX_FAULT_TRANS_INFO));
+		scnprintf(fault_msg, fault_msg_sz,
+			  "SysMMU %s %s from %s (secure) at %#010x",
+			  IS_READ_FAULT(info) ? "READ" : "WRITE",
+			  sysmmu_fault_name[intr_type],
+			  port_name ? port_name : dev_name(drvdata->dev),
+			  fault_addr);
+	} else {
+		info = readl_relaxed(MMU_VM_REG(drvdata, IDX_FAULT_TRANS_INFO, vid));
+		scnprintf(fault_msg, fault_msg_sz,
+			  "SysMMU %s %s from %s VID %u at %#010x",
+			  IS_READ_FAULT(info) ? "READ" : "WRITE",
+			  sysmmu_fault_name[intr_type],
+			  port_name ? port_name : dev_name(drvdata->dev), vid,
+			  fault_addr);
+	}
+}
+
+static void sysmmu_show_secure_fault_information(struct sysmmu_drvdata *drvdata,
+						 unsigned int intr_type, sysmmu_iova_t fault_addr)
+{
+	unsigned int info;
+	phys_addr_t pgtable;
+	unsigned int sfrbase = drvdata->secure_base;
+	char err_msg[128];
+
+	pgtable = read_sec_info(MMU_SEC_REG(drvdata, IDX_SEC_FLPT_BASE));
+	pgtable <<= PAGE_SHIFT;
+
+	info = read_sec_info(MMU_SEC_REG(drvdata, IDX_FAULT_TRANS_INFO));
+
+	pr_crit("----------------------------------------------------------\n");
+
+	sysmmu_get_fault_msg(drvdata, intr_type, 0, fault_addr,
+			     true, err_msg, sizeof(err_msg));
+
+	pr_crit("%s (pgtable @ %pa)\n", err_msg, &pgtable);
+
+	if (intr_type == SYSMMU_FAULT_UNKNOWN) {
+		pr_crit("The fault is not caused by this System MMU.\n");
+		pr_crit("Please check IRQ and SFR base address.\n");
+		goto finish;
+	}
+
+	pr_crit("AxID: %#x, AxLEN: %#x\n", info & 0xFFFF, (info >> 16) & 0xF);
+
+	if (!pfn_valid(pgtable >> PAGE_SHIFT)) {
+		pr_crit("Page table base is not in a valid memory region\n");
+		pgtable = 0;
+	}
+
+	if (intr_type == SYSMMU_FAULT_PTW_ACCESS) {
+		pr_crit("System MMU has failed to access page table\n");
+		pgtable = 0;
+	}
+
+	info = MMU_RAW_VER(read_sec_info(sfrbase + REG_MMU_VERSION));
+
+	pr_crit("ADDR: %#x, MMU_CTRL: %#010x, PT_BASE: %#010x\n",
+		sfrbase,
+		read_sec_info(sfrbase + REG_MMU_CTRL),
+		read_sec_info(MMU_SEC_REG(drvdata, IDX_SEC_FLPT_BASE)));
+	pr_crit("VERSION %d.%d.%d, MMU_CFG: %#010x, MMU_STATUS: %#010x\n",
+		MMU_MAJ_VER(info), MMU_MIN_VER(info), MMU_REV_VER(info),
+		read_sec_info(sfrbase + REG_MMU_CFG),
+		read_sec_info(sfrbase + REG_MMU_STATUS));
+
+finish:
+	pr_crit("----------------------------------------------------------\n");
+}
+
+static void sysmmu_show_fault_info_simple(struct sysmmu_drvdata *drvdata,
+					  unsigned int intr_type, unsigned int vid,
+					  sysmmu_iova_t fault_addr, phys_addr_t *pt)
+{
+	u32 info;
+	char err_msg[128];
+
+	info = readl_relaxed(MMU_VM_REG(drvdata, IDX_FAULT_TRANS_INFO, vid));
+
+	sysmmu_get_fault_msg(drvdata, intr_type, vid, fault_addr,
+			     false, err_msg, sizeof(err_msg));
+
+	pr_crit("%s (pgtable @ %pa, AxID: %#x)\n", err_msg, pt, info & 0xFFFF);
+}
+
+static void sysmmu_show_fault_information(struct sysmmu_drvdata *drvdata,
+					  unsigned int intr_type, unsigned int vid,
+					  sysmmu_iova_t fault_addr)
+{
+	unsigned int i;
+	phys_addr_t pgtable[MAX_VIDS];
+
+	for (i = 0; i < __max_vids(drvdata); i++) {
+		pgtable[i] = readl_relaxed(MMU_VM_REG(drvdata, IDX_FLPT_BASE, i));
+		pgtable[i] <<= PAGE_SHIFT;
+	}
+
+	pr_crit("----------------------------------------------------------\n");
+	sysmmu_show_fault_info_simple(drvdata, intr_type, vid, fault_addr, &pgtable[vid]);
+
+	if (intr_type == SYSMMU_FAULT_UNKNOWN) {
+		pr_crit("The fault is not caused by this System MMU.\n");
+		pr_crit("Please check IRQ and SFR base address.\n");
+		goto finish;
+	}
+
+	for (i = 0; i < __max_vids(drvdata); i++) {
+		if (pgtable[i] != drvdata->pgtable[i])
+			pr_crit("Page table (VID %u) base of driver: %pa\n", i,
+				&drvdata->pgtable[i]);
+		if (pgtable[i] && !pfn_valid(pgtable[i] >> PAGE_SHIFT)) {
+			pr_crit("Page table (VID %u) base is not in a valid memory region\n", i);
+			pgtable[i] = 0;
+		}
+	}
+
+	if (pgtable[vid]) {
+		sysmmu_pte_t *ent;
+
+		ent = section_entry(phys_to_virt(pgtable[vid]), fault_addr);
+		pr_crit("Lv1 entry: %#010x\n", *ent);
+
+		if (lv1ent_page(ent)) {
+			ent = page_entry(ent, fault_addr);
+			pr_crit("Lv2 entry: %#010x\n", *ent);
+		}
+	}
+
+	if (intr_type == SYSMMU_FAULT_PTW_ACCESS) {
+		pr_crit("System MMU has failed to access page table\n");
+		pgtable[vid] = 0;
+	}
+
+	dump_sysmmu_status(drvdata, pgtable, vid);
+finish:
+	pr_crit("----------------------------------------------------------\n");
+}
+
+static void sysmmu_get_interrupt_info(struct sysmmu_drvdata *data, unsigned int *intr_type,
+				      unsigned int *vid, sysmmu_iova_t *addr, bool is_secure)
+{
+	u32 istatus;
+
+	istatus = (unsigned int)__ffs(__sysmmu_get_intr_status(data, is_secure));
+	*vid = istatus / 4;
+	*intr_type = istatus % 4;
+	*addr = __sysmmu_get_fault_address(data, *vid, is_secure);
+}
+
+static int sysmmu_clear_interrupt(struct sysmmu_drvdata *data, bool is_secure)
+{
+	u32 val = __sysmmu_get_intr_status(data, is_secure);
+
+	if (is_secure) {
+		if (val & ~SYSMMU_SEC_FAULT_MASK) {
+			dev_warn(data->dev, "Unknown secure fault (%x)\n", val);
+			val &= SYSMMU_SEC_FAULT_MASK;
+		}
+		return clear_sec_fault(data->secure_base, val);
+	}
+	writel(val, data->sfrbase + REG_MMU_INT_CLEAR);
+	return 0;
+}
+
+irqreturn_t samsung_sysmmu_irq(int irq, void *dev_id)
+{
+	unsigned int itype;
+	unsigned int vid;
+	sysmmu_iova_t addr;
+	struct sysmmu_drvdata *drvdata = dev_id;
+	bool is_secure = (irq == drvdata->secure_irq);
+
+	if (drvdata->hide_page_fault)
+		return IRQ_WAKE_THREAD;
+
+	dev_info(drvdata->dev, "[%s] interrupt (%d) happened\n",
+		 is_secure ? "Secure" : "Non-secure", irq);
+
+	if (drvdata->async_fault_mode)
+		return IRQ_WAKE_THREAD;
+
+	sysmmu_get_interrupt_info(drvdata, &itype, &vid, &addr, is_secure);
+	if (is_secure)
+		sysmmu_show_secure_fault_information(drvdata, itype, addr);
+	else
+		sysmmu_show_fault_information(drvdata, itype, vid, addr);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int samsung_sysmmu_fault_notifier(struct device *dev, void *data)
+{
+	struct samsung_sysmmu_fault_info *fi;
+	struct sysmmu_clientdata *client;
+	struct sysmmu_drvdata *drvdata;
+	unsigned int i;
+	int ret, result = 0;
+
+	fi = (struct samsung_sysmmu_fault_info *)data;
+	drvdata = fi->drvdata;
+
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+
+	for (i = 0; i < client->sysmmu_count; i++) {
+		if (drvdata == client->sysmmus[i]) {
+			ret = iommu_report_device_fault(dev, &fi->event);
+			if (ret == -EAGAIN)
+				result = ret;
+			break;
+		}
+	}
+
+	return result;
+}
+
+irqreturn_t samsung_sysmmu_irq_thread(int irq, void *dev_id)
+{
+	unsigned int itype, vid;
+	int ret;
+	sysmmu_iova_t addr;
+	struct sysmmu_drvdata *drvdata = dev_id;
+	bool is_secure = (irq == drvdata->secure_irq);
+	struct iommu_group *group = drvdata->group;
+	enum iommu_fault_reason reason;
+	struct samsung_sysmmu_fault_info fi = {
+		.drvdata = drvdata,
+		.event.fault.type = IOMMU_FAULT_DMA_UNRECOV,
+	};
+	char fault_msg[128] = "Unspecified SysMMU fault";
+
+	/* Prevent power down while handling faults */
+	pm_runtime_get_sync(drvdata->dev);
+
+	sysmmu_get_interrupt_info(drvdata, &itype, &vid, &addr, is_secure);
+	reason = sysmmu_fault_type[itype];
+
+	fi.event.fault.event.addr = addr;
+	fi.event.fault.event.pasid = vid;
+	if (vid)
+		fi.event.fault.event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
+	fi.event.fault.event.reason = reason;
+	if (reason == IOMMU_FAULT_REASON_PTE_FETCH ||
+	    reason == IOMMU_FAULT_REASON_PERMISSION)
+		fi.event.fault.type = IOMMU_FAULT_PAGE_REQ;
+
+	ret = iommu_group_for_each_dev(group, &fi,
+				       samsung_sysmmu_fault_notifier);
+	if (ret == -EAGAIN) {
+		if (is_secure) {
+			if (drvdata->async_fault_mode && !drvdata->hide_page_fault)
+				sysmmu_show_secure_fault_information(drvdata, itype, addr);
+			ret = sysmmu_clear_interrupt(drvdata, true);
+			if (ret) {
+				if (drvdata->hide_page_fault)
+					sysmmu_show_secure_fault_information(drvdata, itype, addr);
+				dev_err(drvdata->dev, "Failed to clear secure fault (%d)\n", ret);
+				goto out;
+			}
+		} else  {
+			phys_addr_t pgtable;
+
+			pgtable = readl_relaxed(MMU_VM_REG(drvdata, IDX_FLPT_BASE, vid));
+			pgtable <<= PAGE_SHIFT;
+			if (!drvdata->hide_page_fault)
+				sysmmu_show_fault_info_simple(drvdata, itype, vid, addr, &pgtable);
+			sysmmu_clear_interrupt(drvdata, false);
+		}
+		pm_runtime_put(drvdata->dev);
+		return IRQ_HANDLED;
+	}
+
+	if (drvdata->async_fault_mode || drvdata->hide_page_fault) {
+		if (is_secure)
+			sysmmu_show_secure_fault_information(drvdata, itype, addr);
+		else
+			sysmmu_show_fault_information(drvdata, itype, vid, addr);
+	}
+
+out:
+	sysmmu_get_fault_msg(drvdata, itype, vid, addr, is_secure, fault_msg, sizeof(fault_msg));
+
+	pm_runtime_put(drvdata->dev);
+
+	panic(fault_msg);
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/iommu/samsung-iommu-group.c b/drivers/iommu/samsung-iommu-group.c
new file mode 100644
index 000000000000..425a7345363c
--- /dev/null
+++ b/drivers/iommu/samsung-iommu-group.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/iommu.h>
+#include <linux/kmemleak.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static int sysmmu_group_device_probe(struct platform_device *pdev)
+{
+	struct iommu_group *data;
+	struct device *dev = &pdev->dev;
+
+	data = iommu_group_alloc();
+	if (IS_ERR(data)) {
+		dev_err(dev, "Failed to alloc group, ret:%d\n", (int)PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+
+	platform_set_drvdata(pdev, data);
+	iommu_group_set_name(data, dev->of_node->name);
+
+	dev_dbg(dev, "Initialized IOMMU group[%s]\n", dev->of_node->name);
+
+	return 0;
+}
+
+static void sysmmu_group_device_shutdown(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id sysmmu_group_of_match[] = {
+	{ .compatible = "samsung,sysmmu-group" },
+	{ }
+};
+
+static struct platform_driver sysmmu_group_driver = {
+	.driver	= {
+		.name			= "sysmmu-group",
+		.of_match_table		= of_match_ptr(sysmmu_group_of_match),
+		.suppress_bind_attrs	= true,
+	},
+	.probe = sysmmu_group_device_probe,
+	.shutdown = sysmmu_group_device_shutdown,
+};
+module_platform_driver(sysmmu_group_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/samsung-iommu.c b/drivers/iommu/samsung-iommu.c
new file mode 100644
index 000000000000..e66da74167b9
--- /dev/null
+++ b/drivers/iommu/samsung-iommu.c
@@ -0,0 +1,1521 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ */
+
+#define pr_fmt(fmt) "sysmmu: " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/kmemleak.h>
+#include <linux/module.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "samsung-iommu.h"
+
+#define FLPD_SHAREABLE_FLAG	BIT(6)
+#define SLPD_SHAREABLE_FLAG	BIT(4)
+
+#define MMU_TLB_CFG_MASK(reg)		((reg) & (GENMASK(7, 5) | GENMASK(3, 2) | GENMASK(1, 1)))
+#define MMU_TLB_MATCH_CFG_MASK(reg)	((reg) & (GENMASK(31, 16) | GENMASK(9, 8)))
+
+#define REG_MMU_TLB_CFG(n)		(0x2000 + ((n) * 0x20) + 0x4)
+#define REG_MMU_TLB_MATCH_CFG(n)	(0x2000 + ((n) * 0x20) + 0x8)
+#define REG_MMU_TLB_MATCH_ID(n)		(0x2000 + ((n) * 0x20) + 0x14)
+
+#define DEFAULT_QOS_VALUE	-1
+#define DEFAULT_TLB_NONE	~0U
+#define UNUSED_TLB_INDEX	~0U
+
+#define REG_MMU_S2PF_ENABLE	0x7000
+#define MMU_S2PF_ENABLE		BIT(0)
+
+static const unsigned int sysmmu_reg_set[MAX_SET_IDX][MAX_REG_IDX] = {
+	/* Default without VM */
+	{
+		/*
+		 * SysMMUs without VM support do not have the two registers CTRL_VM and CFG_VM.
+		 * Setting the offsets to 1 will trigger an unaligned access exception.
+		 */
+		0x1,	0x1,
+		/* FLPT base, TLB invalidation, Fault information */
+		0x000C,	0x0010,	0x0014,	0x0018,
+		0x0020,	0x0024,	0x0070,	0x0078,
+		/* TLB information */
+		0x8000,	0x8004,	0x8008,	0x800C,
+		/* SBB information */
+		0x8020,	0x8024,	0x8028,	0x802C,
+		/* secure FLPT base (same as non-secure) */
+		0x000C,
+	},
+	/* VM */
+	{
+		/* CTRL_VM, CFG_VM */
+		0x8000,	0x8004,
+		/* FLPT base, TLB invalidation, Fault information */
+		0x800C,	0x8010,	0x8014,	0x8018,
+		0x8020,	0x8024,	0x1000,	0x1004,
+		/* TLB information */
+		0x3000,	0x3004,	0x3008,	0x300C,
+		/* SBB information */
+		0x3020,	0x3024,	0x3028,	0x302C,
+		/* secure FLPT base */
+		0x000C,
+	},
+};
+
+static struct iommu_ops samsung_sysmmu_ops;
+static struct platform_driver samsung_sysmmu_driver;
+
+struct samsung_sysmmu_domain {
+	struct iommu_domain domain;
+	struct iommu_group *group;
+	struct sysmmu_drvdata *vm_sysmmu; /* valid only if vid != 0 */
+	/* if vid != 0, domain is aux domain attached to only one device and sysmmu */
+	unsigned int vid;
+	sysmmu_pte_t *page_table;
+	atomic_t *lv2entcnt;
+	spinlock_t pgtablelock; /* serialize races to page table updates */
+};
+
+static bool sysmmu_global_init_done;
+static struct device sync_dev;
+static struct kmem_cache *flpt_cache, *slpt_cache;
+
+static inline u32 __sysmmu_get_tlb_num(struct sysmmu_drvdata *data)
+{
+	return MMU_CAPA1_NUM_TLB(readl_relaxed(data->sfrbase +
+					       REG_MMU_CAPA1_V7));
+}
+
+static inline u32 __sysmmu_get_hw_version(struct sysmmu_drvdata *data)
+{
+	return MMU_RAW_VER(readl_relaxed(data->sfrbase + REG_MMU_VERSION));
+}
+
+static inline bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	return MMU_CAPA1_EXIST(readl_relaxed(data->sfrbase + REG_MMU_CAPA0_V7));
+}
+
+static inline u32 __sysmmu_get_capa_type(struct sysmmu_drvdata *data)
+{
+	return MMU_CAPA1_TYPE(readl_relaxed(data->sfrbase + REG_MMU_CAPA1_V7));
+}
+
+static inline bool __sysmmu_get_capa_no_block_mode(struct sysmmu_drvdata *data)
+{
+	return MMU_CAPA1_NO_BLOCK_MODE(readl_relaxed(data->sfrbase +
+						     REG_MMU_CAPA1_V7));
+}
+
+static inline bool __sysmmu_get_capa_vcr_enabled(struct sysmmu_drvdata *data)
+{
+	return MMU_CAPA1_VCR_ENABLED(readl_relaxed(data->sfrbase +
+						   REG_MMU_CAPA1_V7));
+}
+
+static inline void __sysmmu_tlb_invalidate_all(struct sysmmu_drvdata *data, unsigned int vid)
+{
+	writel(0x1, MMU_VM_REG(data, IDX_ALL_INV, vid));
+}
+
+static inline void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data, unsigned int vid,
+					   dma_addr_t start, dma_addr_t end)
+{
+	writel_relaxed(ALIGN_DOWN(start, SPAGE_SIZE), MMU_VM_REG(data, IDX_RANGE_INV_START, vid));
+	writel_relaxed(ALIGN_DOWN(end, SPAGE_SIZE), MMU_VM_REG(data, IDX_RANGE_INV_END, vid));
+	writel(0x1, MMU_VM_REG(data, IDX_RANGE_INV, vid));
+}
+
+static inline void __sysmmu_disable_vid(struct sysmmu_drvdata *data, unsigned int vid)
+{
+	u32 ctrl_val = readl_relaxed(MMU_VM_REG(data, IDX_CTRL_VM, vid));
+
+	ctrl_val &= ~CTRL_VID_ENABLE;
+	writel(ctrl_val, MMU_VM_REG(data, IDX_CTRL_VM, vid));
+	__sysmmu_tlb_invalidate_all(data, vid);
+	writel_relaxed(0, MMU_VM_REG(data, IDX_FLPT_BASE, vid));
+}
+
+static inline void __sysmmu_disable(struct sysmmu_drvdata *data)
+{
+	if (data->no_block_mode) {
+		__sysmmu_tlb_invalidate_all(data, 0);
+	} else {
+		u32 ctrl_val = readl_relaxed(data->sfrbase + REG_MMU_CTRL);
+
+		ctrl_val &= ~CTRL_MMU_ENABLE;
+		writel(ctrl_val | CTRL_MMU_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	}
+}
+
+static inline void __sysmmu_set_tlb(struct sysmmu_drvdata *data)
+{
+	struct tlb_props *tlb_props = &data->tlb_props;
+	struct tlb_config *cfg = tlb_props->cfg;
+	int id_cnt = tlb_props->id_cnt;
+	int i;
+	unsigned int index;
+
+	if (tlb_props->default_cfg != DEFAULT_TLB_NONE)
+		writel_relaxed(MMU_TLB_CFG_MASK(tlb_props->default_cfg),
+			       data->sfrbase + REG_MMU_TLB_CFG(0));
+
+	for (i = 0; i < id_cnt; i++) {
+		if (cfg[i].index == UNUSED_TLB_INDEX)
+			continue;
+
+		index = cfg[i].index;
+		writel_relaxed(MMU_TLB_CFG_MASK(cfg[i].cfg),
+			       data->sfrbase + REG_MMU_TLB_CFG(index));
+		writel_relaxed(MMU_TLB_MATCH_CFG_MASK(cfg[i].match_cfg),
+			       data->sfrbase + REG_MMU_TLB_MATCH_CFG(index));
+		writel_relaxed(cfg[i].match_id,
+			       data->sfrbase + REG_MMU_TLB_MATCH_ID(index));
+	}
+}
+
+static inline void __sysmmu_init_config(struct sysmmu_drvdata *data)
+{
+	u32 cfg = readl_relaxed(data->sfrbase + REG_MMU_CFG);
+
+	if (data->qos != DEFAULT_QOS_VALUE) {
+		cfg &= ~CFG_QOS(0xF);
+		cfg |= CFG_QOS_OVRRIDE | CFG_QOS((u32)data->qos);
+	}
+
+	if (data->no_s2pf) {
+		u32 val = readl_relaxed(data->sfrbase + REG_MMU_S2PF_ENABLE);
+
+		writel_relaxed(val & ~MMU_S2PF_ENABLE, data->sfrbase + REG_MMU_S2PF_ENABLE);
+	}
+
+	__sysmmu_set_tlb(data);
+
+	writel_relaxed(cfg, data->sfrbase + REG_MMU_CFG);
+}
+
+static inline void __sysmmu_enable_vid(struct sysmmu_drvdata *data, unsigned int vid)
+{
+	u32 ctrl_val;
+
+	writel_relaxed(data->pgtable[vid] / SPAGE_SIZE, MMU_VM_REG(data, IDX_FLPT_BASE, vid));
+
+	__sysmmu_tlb_invalidate_all(data, vid);
+
+	ctrl_val = readl_relaxed(MMU_VM_REG(data, IDX_CTRL_VM, vid));
+	if (!data->async_fault_mode)
+		ctrl_val |= CTRL_FAULT_STALL_MODE;
+	else
+		ctrl_val &= ~CTRL_FAULT_STALL_MODE;
+	writel(ctrl_val | CTRL_VID_ENABLE, MMU_VM_REG(data, IDX_CTRL_VM, vid));
+}
+
+static inline void __sysmmu_enable(struct sysmmu_drvdata *data)
+{
+	unsigned int vid;
+	u32 ctrl_val = readl_relaxed(data->sfrbase + REG_MMU_CTRL);
+
+	if (!data->no_block_mode)
+		writel_relaxed(ctrl_val | CTRL_MMU_BLOCK, data->sfrbase + REG_MMU_CTRL);
+
+	__sysmmu_init_config(data);
+
+	for (vid = 0; vid < __max_vids(data); vid++)
+		if (data->pgtable[vid])
+			__sysmmu_enable_vid(data, vid);
+
+	writel(ctrl_val | CTRL_MMU_ENABLE, data->sfrbase + REG_MMU_CTRL);
+}
+
+static struct samsung_sysmmu_domain *to_sysmmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct samsung_sysmmu_domain, domain);
+}
+
+static inline void pgtable_flush(void *vastart, void *vaend)
+{
+	dma_sync_single_for_device(&sync_dev, virt_to_phys(vastart),
+				   (size_t)(vaend - vastart), DMA_TO_DEVICE);
+}
+
+static bool samsung_sysmmu_capable(enum iommu_cap cap)
+{
+	return cap == IOMMU_CAP_CACHE_COHERENCY;
+}
+
+static struct iommu_domain *samsung_sysmmu_domain_alloc(unsigned int type)
+{
+	struct samsung_sysmmu_domain *domain;
+
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY) {
+		pr_err("invalid domain type %u\n", type);
+		return NULL;
+	}
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
+	domain->page_table =
+		(sysmmu_pte_t *)kmem_cache_alloc(flpt_cache,
+						 GFP_KERNEL | __GFP_ZERO);
+	if (!domain->page_table)
+		goto err_pgtable;
+
+	domain->lv2entcnt = kcalloc(NUM_LV1ENTRIES, sizeof(*domain->lv2entcnt),
+				    GFP_KERNEL);
+	if (!domain->lv2entcnt)
+		goto err_counter;
+
+	pgtable_flush(domain->page_table, domain->page_table + NUM_LV1ENTRIES);
+
+	spin_lock_init(&domain->pgtablelock);
+
+	return &domain->domain;
+
+err_counter:
+	kmem_cache_free(flpt_cache, domain->page_table);
+err_pgtable:
+	kfree(domain);
+	return NULL;
+}
+
+static void samsung_sysmmu_domain_free(struct iommu_domain *dom)
+{
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+
+	kmem_cache_free(flpt_cache, domain->page_table);
+	kfree(domain->lv2entcnt);
+	kfree(domain);
+}
+
+static inline void samsung_sysmmu_detach_drvdata(struct sysmmu_drvdata *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->lock, flags);
+	if (--data->attached_count == 0) {
+		if (pm_runtime_active(data->dev))
+			__sysmmu_disable(data);
+
+		list_del(&data->list);
+		data->pgtable[0] = 0;
+		data->group = NULL;
+	}
+	spin_unlock_irqrestore(&data->lock, flags);
+}
+
+/* TODO: Since upstream has removed of_get_dma_window() we'll temporarily
+ * open code relevant portion here, until we can come up with a generic
+ * enough implementation that can be proposed upstream for these drivers.
+ */
+static int samsung_sysmmu_get_dma_window(struct device_node *dn,
+					 dma_addr_t *addr, size_t *size)
+{
+	const __be32 *dma_window, *prop;
+	u32 cells;
+
+	dma_window = of_get_property(dn, "dma-window", NULL);
+	if (!dma_window)
+		return -ENODEV;
+
+	prop = of_get_property(dn, "#dma-address-cells", NULL);
+	cells = prop ? be32_to_cpup(prop) : of_n_addr_cells(dn);
+	if (!cells)
+		return -EINVAL;
+	*addr = of_read_number(dma_window, cells);
+	dma_window += cells;
+
+	prop = of_get_property(dn, "#dma-size-cells", NULL);
+	cells = prop ? be32_to_cpup(prop) : of_n_size_cells(dn);
+	if (!cells)
+		return -EINVAL;
+	*size = of_read_number(dma_window, cells);
+
+	return 0;
+}
+
+static int samsung_sysmmu_set_domain_range(struct iommu_domain *dom,
+					   struct device *dev)
+{
+	struct iommu_domain_geometry *geom = &dom->geometry;
+	dma_addr_t start, end;
+	size_t size;
+
+	if (samsung_sysmmu_get_dma_window(dev->of_node, &start, &size))
+		return 0;
+
+	end = start + size;
+
+	if (end > DMA_BIT_MASK(32))
+		end = DMA_BIT_MASK(32);
+
+	if (geom->force_aperture) {
+		dma_addr_t d_start, d_end;
+
+		d_start = max(start, geom->aperture_start);
+		d_end = min(end, geom->aperture_end);
+
+		if (d_start >= d_end) {
+			dev_err(dev, "current range is [%pad..%pad]\n",
+				&geom->aperture_start, &geom->aperture_end);
+			dev_err(dev, "requested range [%zx @ %pad] is not allowed\n",
+				size, &start);
+			return -ERANGE;
+		}
+
+		geom->aperture_start = d_start;
+		geom->aperture_end = d_end;
+	} else {
+		geom->aperture_start = start;
+		geom->aperture_end = end;
+		/*
+		 * All CPUs should observe the change of force_aperture after
+		 * updating aperture_start and aperture_end because dma-iommu
+		 * restricts dma virtual memory by this aperture when
+		 * force_aperture is set.
+		 * We allow allocating dma virtual memory during changing the
+		 * aperture range because the current allocation is free from
+		 * the new restricted range.
+		 */
+		smp_wmb();
+		geom->force_aperture = true;
+	}
+
+	dev_info(dev, "changed DMA range [%pad..%pad] successfully.\n",
+		 &geom->aperture_start, &geom->aperture_end);
+
+	return 0;
+}
+
+static struct samsung_sysmmu_domain *attach_helper(struct iommu_domain *dom, struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct samsung_sysmmu_domain *domain;
+
+	if (!fwspec || fwspec->ops != &samsung_sysmmu_ops) {
+		dev_err(dev, "failed to attach, IOMMU instance data %s.\n",
+			!fwspec ? "is not initialized" : "has different ops");
+		return ERR_PTR(-ENXIO);
+	}
+
+	if (!dev_iommu_priv_get(dev)) {
+		dev_err(dev, "has no IOMMU\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	domain = to_sysmmu_domain(dom);
+	if (domain->vm_sysmmu) {
+		dev_err(dev, "IOMMU domain is already used as AUX domain\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return domain;
+}
+
+static int samsung_sysmmu_attach_dev(struct iommu_domain *dom,
+				     struct device *dev)
+{
+	struct sysmmu_clientdata *client;
+	struct samsung_sysmmu_domain *domain;
+	struct list_head *group_list;
+	struct sysmmu_drvdata *drvdata;
+	struct iommu_group *group = dev->iommu_group;
+	unsigned long flags;
+	phys_addr_t page_table;
+	int i, ret = -EINVAL;
+
+	domain = attach_helper(dom, dev);
+	if (IS_ERR(domain))
+		return (int)PTR_ERR(domain);
+
+	domain->group = group;
+	group_list = iommu_group_get_iommudata(group);
+	page_table = virt_to_phys(domain->page_table);
+
+	client = dev_iommu_priv_get(dev);
+	for (i = 0; i < (int)client->sysmmu_count; i++) {
+		drvdata = client->sysmmus[i];
+
+		spin_lock_irqsave(&drvdata->lock, flags);
+		if (drvdata->attached_count++ == 0) {
+			list_add(&drvdata->list, group_list);
+			drvdata->group = group;
+			drvdata->pgtable[0] = page_table;
+
+			if (pm_runtime_active(drvdata->dev))
+				__sysmmu_enable(drvdata);
+		} else if (drvdata->pgtable[0] != page_table) {
+			dev_err(dev, "%s is already attached to other domain\n",
+				dev_name(drvdata->dev));
+			spin_unlock_irqrestore(&drvdata->lock, flags);
+			goto err_drvdata_add;
+		}
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+	}
+
+	ret = samsung_sysmmu_set_domain_range(dom, dev);
+	if (ret)
+		goto err_drvdata_add;
+
+	dev_info(dev, "attached with pgtable %pa\n", &domain->page_table);
+
+	return 0;
+
+err_drvdata_add:
+	while (i-- > 0) {
+		drvdata = client->sysmmus[i];
+
+		samsung_sysmmu_detach_drvdata(drvdata);
+	}
+
+	return ret;
+}
+
+static void samsung_sysmmu_detach_dev(struct iommu_domain *dom,
+				      struct device *dev)
+{
+	struct sysmmu_clientdata *client;
+	struct samsung_sysmmu_domain *domain;
+	struct list_head *group_list;
+	struct sysmmu_drvdata *drvdata;
+	struct iommu_group *group = dev->iommu_group;
+	unsigned int i;
+
+	domain = to_sysmmu_domain(dom);
+	group_list = iommu_group_get_iommudata(group);
+
+	client = dev_iommu_priv_get(dev);
+	for (i = 0; i < client->sysmmu_count; i++) {
+		drvdata = client->sysmmus[i];
+
+		samsung_sysmmu_detach_drvdata(drvdata);
+	}
+
+	dev_info(dev, "detached from pgtable %pa\n", &domain->page_table);
+}
+
+static inline sysmmu_pte_t make_sysmmu_pte(phys_addr_t paddr,
+					   unsigned int pgsize, unsigned int attr)
+{
+	return ((sysmmu_pte_t)((paddr) >> PG_ENT_SHIFT)) | pgsize | attr;
+}
+
+static sysmmu_pte_t *alloc_lv2entry(struct samsung_sysmmu_domain *domain,
+				    sysmmu_pte_t *sent, sysmmu_iova_t iova,
+				    atomic_t *pgcounter)
+{
+	if (lv1ent_section(sent)) {
+		WARN(1, "trying mapping on %#08x mapped with 1MiB page", iova);
+		return ERR_PTR(-EADDRINUSE);
+	}
+
+	if (lv1ent_unmapped(sent)) {
+		unsigned long flags;
+		sysmmu_pte_t *pent;
+
+		pent = kmem_cache_zalloc(slpt_cache, GFP_KERNEL);
+		if (!pent)
+			return ERR_PTR(-ENOMEM);
+
+		spin_lock_irqsave(&domain->pgtablelock, flags);
+		if (lv1ent_unmapped(sent)) {
+			*sent = make_sysmmu_pte(virt_to_phys(pent),
+						SLPD_FLAG, 0);
+			kmemleak_ignore(pent);
+			atomic_set(pgcounter, 0);
+			pgtable_flush(pent, pent + NUM_LV2ENTRIES);
+			pgtable_flush(sent, sent + 1);
+		} else {
+			/* allocated entry is not used, so free it. */
+			kmem_cache_free(slpt_cache, pent);
+		}
+		spin_unlock_irqrestore(&domain->pgtablelock, flags);
+	}
+
+	return page_entry(sent, iova);
+}
+
+static inline void clear_lv2_page_table(sysmmu_pte_t *ent, unsigned int n)
+{
+	memset(ent, 0, sizeof(*ent) * n);
+}
+
+static int lv1set_section(struct samsung_sysmmu_domain *domain,
+			  sysmmu_pte_t *sent, sysmmu_iova_t iova,
+			  phys_addr_t paddr, int prot, atomic_t *pgcnt)
+{
+	unsigned int attr = !!(prot & IOMMU_CACHE) ? FLPD_SHAREABLE_FLAG : 0;
+	sysmmu_pte_t *pent_to_free = NULL;
+
+	if (lv1ent_section(sent)) {
+		WARN(1, "Trying mapping 1MB@%#08x on valid FLPD", iova);
+		return -EADDRINUSE;
+	}
+
+	if (lv1ent_page(sent)) {
+		if (WARN_ON(atomic_read(pgcnt) != 0)) {
+			WARN(1, "Trying mapping 1MB@%#08x on valid SLPD", iova);
+			return -EADDRINUSE;
+		}
+
+		pent_to_free = page_entry(sent, 0);
+		atomic_set(pgcnt, NUM_LV2ENTRIES);
+	}
+
+	*sent = make_sysmmu_pte(paddr, SECT_FLAG, attr);
+	pgtable_flush(sent, sent + 1);
+
+	if (pent_to_free) {
+		struct iommu_iotlb_gather gather = {
+			.start = iova,
+			.end = iova + SECT_SIZE - 1,
+		};
+
+		iommu_iotlb_sync(&domain->domain, &gather);
+		kmem_cache_free(slpt_cache, pent_to_free);
+	}
+
+	return 0;
+}
+
+static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr,
+		       size_t size, int prot, atomic_t *pgcnt)
+{
+	unsigned int attr = !!(prot & IOMMU_CACHE) ? SLPD_SHAREABLE_FLAG : 0;
+
+	if (size == SPAGE_SIZE) {
+		if (WARN_ON(!lv2ent_unmapped(pent)))
+			return -EADDRINUSE;
+
+		*pent = make_sysmmu_pte(paddr, SPAGE_FLAG, attr);
+		pgtable_flush(pent, pent + 1);
+		atomic_inc(pgcnt);
+	} else {	/* size == LPAGE_SIZE */
+		unsigned int i;
+
+		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
+			if (WARN_ON(!lv2ent_unmapped(pent))) {
+				clear_lv2_page_table(pent - i, i);
+				return -EADDRINUSE;
+			}
+
+			*pent = make_sysmmu_pte(paddr, LPAGE_FLAG, attr);
+		}
+		pgtable_flush(pent - SPAGES_PER_LPAGE, pent);
+		atomic_add(SPAGES_PER_LPAGE, pgcnt);
+	}
+
+	return 0;
+}
+
+static int samsung_sysmmu_map(struct iommu_domain *dom, unsigned long l_iova,
+			      phys_addr_t paddr, size_t size, int prot,
+			      gfp_t unused)
+{
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
+	atomic_t *lv2entcnt = &domain->lv2entcnt[lv1ent_offset(iova)];
+	sysmmu_pte_t *entry;
+	int ret = -ENOMEM;
+
+	/* Do not use IO coherency if iOMMU_PRIV exists */
+	if (!!(prot & IOMMU_PRIV))
+		prot &= ~IOMMU_CACHE;
+
+	entry = section_entry(domain->page_table, iova);
+
+	if (size == SECT_SIZE) {
+		ret = lv1set_section(domain, entry, iova, paddr, prot,
+				     lv2entcnt);
+	} else {
+		sysmmu_pte_t *pent;
+
+		pent = alloc_lv2entry(domain, entry, iova, lv2entcnt);
+
+		if (IS_ERR(pent))
+			ret = PTR_ERR(pent);
+		else
+			ret = lv2set_page(pent, paddr, size, prot, lv2entcnt);
+	}
+
+	if (ret)
+		pr_err("failed to map %#zx @ %#x, ret:%d\n", size, iova, ret);
+
+	return ret;
+}
+
+static size_t samsung_sysmmu_unmap(struct iommu_domain *dom,
+				   unsigned long l_iova, size_t size,
+				   struct iommu_iotlb_gather *gather)
+{
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
+	atomic_t *lv2entcnt = &domain->lv2entcnt[lv1ent_offset(iova)];
+	sysmmu_pte_t *sent, *pent;
+	size_t err_pgsize;
+
+	sent = section_entry(domain->page_table, iova);
+
+	if (lv1ent_section(sent)) {
+		if (WARN_ON(size < SECT_SIZE)) {
+			err_pgsize = SECT_SIZE;
+			goto err;
+		}
+
+		*sent = 0;
+		pgtable_flush(sent, sent + 1);
+		size = SECT_SIZE;
+		goto done;
+	}
+
+	if (unlikely(lv1ent_unmapped(sent))) {
+		if (size > SECT_SIZE)
+			size = SECT_SIZE;
+		goto done;
+	}
+
+	/* lv1ent_page(sent) == true here */
+
+	pent = page_entry(sent, iova);
+
+	if (unlikely(lv2ent_unmapped(pent))) {
+		size = SPAGE_SIZE;
+		goto done;
+	}
+
+	if (lv2ent_small(pent)) {
+		*pent = 0;
+		size = SPAGE_SIZE;
+		pgtable_flush(pent, pent + 1);
+		atomic_dec(lv2entcnt);
+		goto done;
+	}
+
+	/* lv1ent_large(pent) == true here */
+	if (WARN_ON(size < LPAGE_SIZE)) {
+		err_pgsize = LPAGE_SIZE;
+		goto err;
+	}
+
+	clear_lv2_page_table(pent, SPAGES_PER_LPAGE);
+	pgtable_flush(pent, pent + SPAGES_PER_LPAGE);
+	size = LPAGE_SIZE;
+	atomic_sub(SPAGES_PER_LPAGE, lv2entcnt);
+
+done:
+	iommu_iotlb_gather_add_page(dom, gather, iova, size);
+
+	return size;
+
+err:
+	pr_err("failed: size(%#zx) @ %#x is smaller than page size %#zx\n",
+	       size, iova, err_pgsize);
+
+	return 0;
+}
+
+static void samsung_sysmmu_flush_iotlb_all(struct iommu_domain *dom)
+{
+	unsigned long flags;
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+	struct sysmmu_drvdata *drvdata;
+
+	if (domain->vm_sysmmu) {
+		/* Domain is used as AUX domain */
+		drvdata = domain->vm_sysmmu;
+		spin_lock_irqsave(&drvdata->lock, flags);
+		if (drvdata->attached_count && drvdata->rpm_resume)
+			__sysmmu_tlb_invalidate_all(drvdata, domain->vid);
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+	} else if (domain->group) {
+		/* Domain is used as regular domain */
+		/*
+		 * domain->group might be NULL if flush_iotlb_all is called
+		 * before attach_dev. Just ignore it.
+		 */
+		struct list_head *sysmmu_list = iommu_group_get_iommudata(domain->group);
+
+		list_for_each_entry(drvdata, sysmmu_list, list) {
+			spin_lock_irqsave(&drvdata->lock, flags);
+			if (drvdata->attached_count && drvdata->rpm_resume)
+				__sysmmu_tlb_invalidate_all(drvdata, 0);
+			spin_unlock_irqrestore(&drvdata->lock, flags);
+		}
+	}
+}
+
+static void samsung_sysmmu_iotlb_sync(struct iommu_domain *dom,
+				      struct iommu_iotlb_gather *gather)
+{
+	unsigned long flags;
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+	struct sysmmu_drvdata *drvdata;
+
+	if (domain->vm_sysmmu) {
+		/* Domain is used as AUX domain */
+		drvdata = domain->vm_sysmmu;
+		spin_lock_irqsave(&drvdata->lock, flags);
+		if (drvdata->attached_count && drvdata->rpm_resume)
+			__sysmmu_tlb_invalidate(drvdata, domain->vid, gather->start, gather->end);
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+	} else if (domain->group) {
+		/* Domain is used as regular domain */
+		/*
+		 * domain->group might be NULL if iotlb_sync is called
+		 * before attach_dev. Just ignore it.
+		 */
+		struct list_head *sysmmu_list = iommu_group_get_iommudata(domain->group);
+
+		list_for_each_entry(drvdata, sysmmu_list, list) {
+			spin_lock_irqsave(&drvdata->lock, flags);
+			if (drvdata->attached_count && drvdata->rpm_resume)
+				__sysmmu_tlb_invalidate(drvdata, 0, gather->start, gather->end);
+			spin_unlock_irqrestore(&drvdata->lock, flags);
+		}
+	}
+}
+
+static phys_addr_t samsung_sysmmu_iova_to_phys(struct iommu_domain *dom,
+					       dma_addr_t d_iova)
+{
+	struct samsung_sysmmu_domain *domain = to_sysmmu_domain(dom);
+	sysmmu_iova_t iova = (sysmmu_iova_t)d_iova;
+	sysmmu_pte_t *entry;
+	phys_addr_t phys = 0;
+
+	entry = section_entry(domain->page_table, iova);
+
+	if (lv1ent_section(entry)) {
+		phys = section_phys(entry) + section_offs(iova);
+	} else if (lv1ent_page(entry)) {
+		entry = page_entry(entry, iova);
+
+		if (lv2ent_large(entry))
+			phys = lpage_phys(entry) + lpage_offs(iova);
+		else if (lv2ent_small(entry))
+			phys = spage_phys(entry) + spage_offs(iova);
+	}
+
+	return phys;
+}
+
+static struct iommu_device *samsung_sysmmu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct sysmmu_clientdata *client;
+	int i;
+
+	if (!fwspec) {
+		dev_dbg(dev, "IOMMU instance data is not initialized\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (fwspec->ops != &samsung_sysmmu_ops) {
+		dev_err(dev, "has different IOMMU ops\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+	client->dev_link = kcalloc(client->sysmmu_count,
+				   sizeof(*client->dev_link), GFP_KERNEL);
+	if (!client->dev_link)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < (int)client->sysmmu_count; i++) {
+		client->dev_link[i] =
+			device_link_add(dev, client->sysmmus[i]->dev,
+					DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+		if (!client->dev_link[i]) {
+			dev_err(dev, "failed to add device link of %s\n",
+				dev_name(client->sysmmus[i]->dev));
+			while (i-- > 0)
+				device_link_del(client->dev_link[i]);
+			return ERR_PTR(-EINVAL);
+		}
+		dev_dbg(dev, "device link to %s\n",
+			dev_name(client->sysmmus[i]->dev));
+	}
+
+	return &client->sysmmus[0]->iommu;
+}
+
+static void samsung_sysmmu_release_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct sysmmu_clientdata *client;
+	unsigned int i;
+
+	if (!fwspec || fwspec->ops != &samsung_sysmmu_ops)
+		return;
+
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+	for (i = 0; i < client->sysmmu_count; i++)
+		device_link_del(client->dev_link[i]);
+	kfree(client->dev_link);
+
+	iommu_fwspec_free(dev);
+}
+
+static void samsung_sysmmu_group_data_release(void *iommu_data)
+{
+	kfree(iommu_data);
+}
+
+static struct iommu_group *samsung_sysmmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct list_head *list;
+	bool need_unmanaged_domain = false;
+
+	if (device_iommu_mapped(dev))
+		return iommu_group_get(dev);
+
+	np = of_parse_phandle(dev->of_node, "samsung,iommu-group", 0);
+	if (!np) {
+		dev_err(dev, "group is not registered\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		dev_err(dev, "no device in device_node[%s]\n", np->name);
+		of_node_put(np);
+		return ERR_PTR(-ENODEV);
+	}
+
+	if (of_property_read_bool(np, "samsung,unmanaged-domain"))
+		need_unmanaged_domain = true;
+
+	of_node_put(np);
+
+	group = platform_get_drvdata(pdev);
+	if (!group) {
+		dev_err(dev, "no group in device_node[%s]\n", np->name);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	if (iommu_group_get_iommudata(group))
+		return group;
+
+	list = kzalloc(sizeof(*list), GFP_KERNEL);
+	if (!list)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(list);
+	iommu_group_set_iommudata(group, list,
+				  samsung_sysmmu_group_data_release);
+
+	if (need_unmanaged_domain) {
+		int ret;
+		struct iommu_domain *domain =
+				iommu_domain_alloc(&platform_bus_type);
+
+		ret = iommu_attach_group(domain, group);
+		if (ret) {
+			dev_err(dev, "failed to attach group, ret:%d\n", ret);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return group;
+}
+
+static void samsung_sysmmu_clientdata_release(struct device *dev, void *res)
+{
+	struct sysmmu_clientdata *client = res;
+
+	kfree(client->sysmmus);
+}
+
+static int samsung_sysmmu_of_xlate(struct device *dev,
+				   struct of_phandle_args *args)
+{
+	struct platform_device *sysmmu = of_find_device_by_node(args->np);
+	struct sysmmu_drvdata *data = platform_get_drvdata(sysmmu);
+	struct sysmmu_drvdata **new_link;
+	struct sysmmu_clientdata *client;
+	struct iommu_fwspec *fwspec;
+	unsigned int fwid = 0;
+	int ret;
+
+	ret = iommu_fwspec_add_ids(dev, &fwid, 1);
+	if (ret) {
+		dev_err(dev, "failed to add fwspec. (err:%d)\n", ret);
+		iommu_device_unlink(&data->iommu, dev);
+		return ret;
+	}
+
+	fwspec = dev_iommu_fwspec_get(dev);
+	if (!dev_iommu_priv_get(dev)) {
+		client = devres_alloc(samsung_sysmmu_clientdata_release,
+				      sizeof(*client), GFP_KERNEL);
+		if (!client)
+			return -ENOMEM;
+		dev_iommu_priv_set(dev, client);
+		devres_add(&sysmmu->dev, client);
+	}
+
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+	new_link = krealloc(client->sysmmus,
+			    sizeof(data) * (client->sysmmu_count + 1),
+			    GFP_KERNEL);
+	if (!new_link)
+		return -ENOMEM;
+
+	client->sysmmus = new_link;
+	client->sysmmus[client->sysmmu_count++] = data;
+
+	dev_info(dev, "has sysmmu %s (total count:%d)\n",
+		 dev_name(data->dev), client->sysmmu_count);
+
+	return ret;
+}
+
+static int samsung_sysmmu_aux_attach_dev(struct iommu_domain *dom, struct device *dev)
+{
+	struct sysmmu_clientdata *client;
+	struct samsung_sysmmu_domain *domain;
+	struct sysmmu_drvdata *drvdata;
+	unsigned long flags;
+	unsigned int vid;
+
+	domain = attach_helper(dom, dev);
+	if (IS_ERR(domain))
+		return (int)PTR_ERR(domain);
+
+	if (domain->group) {
+		dev_err(dev, "IOMMU domain is already in use as vid 0 domain\n");
+		return -EBUSY;
+	}
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+	if (client->sysmmu_count != 1) {
+		dev_err(dev, "IOMMU AUX domains not supported for devices served by more than one IOMMU\n");
+		return -ENXIO;
+	}
+	drvdata = client->sysmmus[0];
+	if (!drvdata->has_vcr) {
+		dev_err(dev, "SysMMU does not support IOMMU AUX domains\n");
+		return -ENXIO;
+	}
+	spin_lock_irqsave(&drvdata->lock, flags);
+	if (!drvdata->attached_count) {
+		dev_err(dev, "IOMMU needs to be enabled to attach AUX domain\n");
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+		return -ENXIO;
+	}
+	for (vid = 1; vid < MAX_VIDS; vid++)
+		if (!drvdata->pgtable[vid])
+			break;
+	if (vid == MAX_VIDS) {
+		dev_err(dev, "Unable to allocate vid for AUX domain\n");
+		spin_unlock_irqrestore(&drvdata->lock, flags);
+		return -EBUSY;
+	}
+	drvdata->pgtable[vid] = virt_to_phys(domain->page_table);
+	if (pm_runtime_active(drvdata->dev))
+		__sysmmu_enable_vid(drvdata, vid);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+	domain->vm_sysmmu = drvdata;
+	domain->vid = vid;
+	return 0;
+}
+
+static void samsung_sysmmu_aux_detach_dev(struct iommu_domain *dom, struct device *dev)
+{
+	struct samsung_sysmmu_domain *domain;
+	struct sysmmu_drvdata *drvdata;
+	unsigned long flags;
+	unsigned int vid;
+
+	domain = to_sysmmu_domain(dom);
+
+	if (WARN_ON(!domain->vm_sysmmu || !domain->vid))
+		return;
+
+	drvdata = domain->vm_sysmmu;
+	vid = domain->vid;
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->pgtable[vid] = 0;
+	__sysmmu_disable_vid(drvdata, vid);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	domain->vm_sysmmu = NULL;
+	domain->vid = 0;
+}
+
+static int samsung_sysmmu_aux_get_pasid(struct iommu_domain *dom, struct device *dev)
+{
+	struct samsung_sysmmu_domain *domain;
+
+	domain = to_sysmmu_domain(dom);
+
+	if (!domain->vm_sysmmu)
+		return -EINVAL;
+
+	return (int)domain->vid;
+}
+
+static bool samsung_sysmmu_dev_has_feat(struct device *dev, enum iommu_dev_features f)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct sysmmu_clientdata *client;
+	struct sysmmu_drvdata *drvdata;
+
+	if (f != IOMMU_DEV_FEAT_AUX)
+		return false;
+
+	client = (struct sysmmu_clientdata *) dev_iommu_priv_get(dev);
+	if (!fwspec || !client || fwspec->ops != &samsung_sysmmu_ops)
+		return false;
+
+	if (client->sysmmu_count != 1)
+		return false;
+	drvdata = client->sysmmus[0];
+	return !!drvdata->has_vcr;
+}
+
+static bool samsung_sysmmu_dev_feat_enabled(struct device *dev, enum iommu_dev_features f)
+{
+	return samsung_sysmmu_dev_has_feat(dev, f);
+}
+
+static int samsung_sysmmu_dev_enable_feat(struct device *dev, enum iommu_dev_features f)
+{
+	if (!samsung_sysmmu_dev_has_feat(dev, f))
+		return -EINVAL;
+	return 0;
+}
+
+static int samsung_sysmmu_dev_disable_feat(struct device *dev, enum iommu_dev_features f)
+{
+	return -EINVAL;
+}
+
+static void samsung_sysmmu_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	enum iommu_resv_type resvtype[] = {
+		IOMMU_RESV_DIRECT, IOMMU_RESV_RESERVED
+	};
+	const char *propname[ARRAY_SIZE(resvtype)] = {
+		"samsung,iommu-identity-map",
+		"samsung,iommu-reserved-map"
+	};
+	int n_addr_cells = of_n_addr_cells(dev->of_node);
+	int n_size_cells = of_n_size_cells(dev->of_node);
+	int n_all_cells = n_addr_cells + n_size_cells;
+	unsigned int type;
+
+	for (type = 0; type < ARRAY_SIZE(propname); type++) {
+		const __be32 *prop;
+		u64 base, size;
+		int i, cnt;
+
+		prop = of_get_property(dev->of_node, propname[type], &cnt);
+		if (!prop)
+			continue;
+
+		cnt /=  sizeof(u32);
+		if (cnt % n_all_cells != 0) {
+			dev_err(dev, "Invalid number(%d) of values in %s\n", cnt, propname[type]);
+			break;
+		}
+
+		for (i = 0; i < cnt; i += n_all_cells) {
+			struct iommu_resv_region *region;
+
+			base = of_read_number(prop + i, n_addr_cells);
+			size = of_read_number(prop + i + n_addr_cells, n_size_cells);
+			if (base & ~dma_get_mask(dev) || (base + size) & ~dma_get_mask(dev)) {
+				dev_err(dev, "Unreachable DMA region in %s, [%#lx..%#lx)\n",
+					propname[type], (unsigned long)base,
+					(unsigned long)(base + size));
+				continue;
+			}
+
+			region = iommu_alloc_resv_region(base, size, 0, resvtype[type]);
+			if (!region)
+				continue;
+
+			list_add_tail(&region->list, head);
+			dev_info(dev, "Reserved IOMMU mapping [%#lx..%#lx)\n",
+				 (unsigned long)base,
+				 (unsigned long)(base + size));
+		}
+	}
+}
+
+static struct iommu_ops samsung_sysmmu_ops = {
+	.capable		= samsung_sysmmu_capable,
+	.domain_alloc		= samsung_sysmmu_domain_alloc,
+	.domain_free		= samsung_sysmmu_domain_free,
+	.attach_dev		= samsung_sysmmu_attach_dev,
+	.detach_dev		= samsung_sysmmu_detach_dev,
+	.map			= samsung_sysmmu_map,
+	.unmap			= samsung_sysmmu_unmap,
+	.flush_iotlb_all	= samsung_sysmmu_flush_iotlb_all,
+	.iotlb_sync		= samsung_sysmmu_iotlb_sync,
+	.iova_to_phys		= samsung_sysmmu_iova_to_phys,
+	.probe_device		= samsung_sysmmu_probe_device,
+	.release_device		= samsung_sysmmu_release_device,
+	.device_group		= samsung_sysmmu_device_group,
+	.of_xlate		= samsung_sysmmu_of_xlate,
+	.get_resv_regions	= samsung_sysmmu_get_resv_regions,
+	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.dev_has_feat		= samsung_sysmmu_dev_has_feat,
+	.dev_feat_enabled	= samsung_sysmmu_dev_feat_enabled,
+	.dev_enable_feat	= samsung_sysmmu_dev_enable_feat,
+	.dev_disable_feat	= samsung_sysmmu_dev_disable_feat,
+	.aux_attach_dev		= samsung_sysmmu_aux_attach_dev,
+	.aux_detach_dev		= samsung_sysmmu_aux_detach_dev,
+	.aux_get_pasid		= samsung_sysmmu_aux_get_pasid,
+	.pgsize_bitmap		= SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
+	.owner						= THIS_MODULE,
+};
+
+static int sysmmu_get_hw_info(struct sysmmu_drvdata *data)
+{
+	data->version = __sysmmu_get_hw_version(data);
+	data->num_tlb = __sysmmu_get_tlb_num(data);
+
+	/* Default value */
+	data->reg_set = sysmmu_reg_set[REG_IDX_DEFAULT];
+
+	if (__sysmmu_get_capa_vcr_enabled(data)) {
+		data->reg_set = sysmmu_reg_set[REG_IDX_VM];
+		data->has_vcr = true;
+	}
+	if (__sysmmu_get_capa_no_block_mode(data))
+		data->no_block_mode = true;
+
+	return 0;
+}
+
+static int sysmmu_parse_tlb_property(struct device *dev,
+				     struct sysmmu_drvdata *drvdata)
+{
+	const char *default_props_name = "sysmmu,default_tlb";
+	const char *props_name = "sysmmu,tlb_property";
+	struct tlb_props *tlb_props = &drvdata->tlb_props;
+	struct tlb_config *cfg;
+	int i, cnt, ret;
+	size_t readsize;
+
+	if (of_property_read_u32(dev->of_node, default_props_name,
+				 &tlb_props->default_cfg))
+		tlb_props->default_cfg = DEFAULT_TLB_NONE;
+
+	cnt = of_property_count_elems_of_size(dev->of_node, props_name,
+					      sizeof(*cfg));
+	if (cnt <= 0)
+		return 0;
+
+	cfg = devm_kcalloc(dev, (unsigned int)cnt, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	readsize = (unsigned int)cnt * sizeof(*cfg) / sizeof(u32);
+	ret = of_property_read_variable_u32_array(dev->of_node, props_name,
+						  (u32 *)cfg,
+						  readsize, readsize);
+	if (ret < 0) {
+		dev_err(dev, "failed to get tlb property, return %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (cfg[i].index >= drvdata->num_tlb) {
+			dev_err(dev, "invalid index %d is ignored. (max:%d)\n",
+				cfg[i].index, drvdata->num_tlb);
+			cfg[i].index = UNUSED_TLB_INDEX;
+		}
+	}
+
+	tlb_props->id_cnt = cnt;
+	tlb_props->cfg = cfg;
+
+	return 0;
+}
+
+static int __sysmmu_secure_irq_init(struct device *sysmmu,
+				    struct sysmmu_drvdata *data)
+{
+	struct platform_device *pdev = to_platform_device(sysmmu);
+	int ret;
+
+	ret = platform_get_irq(pdev, 1);
+	if (ret <= 0) {
+		dev_err(sysmmu, "unable to find secure IRQ resource\n");
+		return -EINVAL;
+	}
+	data->secure_irq = ret;
+
+	ret = devm_request_threaded_irq(sysmmu, (unsigned int)data->secure_irq,
+					samsung_sysmmu_irq,
+					samsung_sysmmu_irq_thread,
+					IRQF_ONESHOT, dev_name(sysmmu), data);
+	if (ret) {
+		dev_err(sysmmu, "failed to set secure irq handler %d, ret:%d\n",
+			data->secure_irq, ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(sysmmu->of_node, "sysmmu,secure_base",
+				   &data->secure_base);
+	if (ret) {
+		dev_err(sysmmu, "failed to get secure base\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int sysmmu_parse_dt(struct device *sysmmu, struct sysmmu_drvdata *data)
+{
+	int qos = DEFAULT_QOS_VALUE;
+	int ret;
+
+	/* Parsing QoS */
+	ret = of_property_read_u32_index(sysmmu->of_node, "qos", 0, &qos);
+	if (!ret && qos > 15) {
+		dev_err(sysmmu, "Invalid QoS value %d, use default.\n", qos);
+		qos = DEFAULT_QOS_VALUE;
+	}
+
+	data->qos = qos;
+	data->no_s2pf = of_property_read_bool(sysmmu->of_node, "sysmmu,no-s2pf");
+
+	/* Secure IRQ */
+	if (of_find_property(sysmmu->of_node, "sysmmu,secure-irq", NULL)) {
+		ret = __sysmmu_secure_irq_init(sysmmu, data);
+		if (ret) {
+			dev_err(sysmmu, "failed to init secure irq\n");
+			return ret;
+		}
+	}
+
+	data->hide_page_fault = of_property_read_bool(sysmmu->of_node,
+						      "sysmmu,hide-page-fault");
+	/* use async fault mode */
+	data->async_fault_mode = of_property_read_bool(sysmmu->of_node,
+						       "sysmmu,async-fault");
+
+	ret = sysmmu_parse_tlb_property(sysmmu, data);
+	if (ret)
+		dev_err(sysmmu, "Failed to parse TLB property\n");
+
+	return ret;
+}
+
+static int samsung_sysmmu_init_global(void)
+{
+	int ret = 0;
+
+	flpt_cache = kmem_cache_create("samsung-iommu-lv1table",
+				       LV1TABLE_SIZE, LV1TABLE_SIZE,
+				       0, NULL);
+	if (!flpt_cache)
+		return -ENOMEM;
+
+	slpt_cache = kmem_cache_create("samsung-iommu-lv2table",
+				       LV2TABLE_SIZE, LV2TABLE_SIZE,
+				       0, NULL);
+	if (!slpt_cache) {
+		ret = -ENOMEM;
+		goto err_init_slpt_fail;
+	}
+
+	bus_set_iommu(&platform_bus_type, &samsung_sysmmu_ops);
+
+	device_initialize(&sync_dev);
+	sysmmu_global_init_done = true;
+
+	return 0;
+
+err_init_slpt_fail:
+	kmem_cache_destroy(flpt_cache);
+
+	return ret;
+}
+
+static int samsung_sysmmu_device_probe(struct platform_device *pdev)
+{
+	struct sysmmu_drvdata *data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int irq, ret, err = 0;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get resource info\n");
+		return -ENOENT;
+	}
+
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, (unsigned int)irq, samsung_sysmmu_irq,
+					samsung_sysmmu_irq_thread,
+					IRQF_ONESHOT, dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "unabled to register handler of irq %d\n", irq);
+		return ret;
+	}
+
+	data->clk = devm_clk_get(dev, "gate");
+	if (PTR_ERR(data->clk) == -ENOENT) {
+		data->clk = NULL;
+	} else if (IS_ERR(data->clk)) {
+		dev_err(dev, "failed to get clock!\n");
+		return PTR_ERR(data->clk);
+	}
+
+	// XXX: HACK: keep the gate clock enabled to fix registers access freeze
+	// TODO: Implement proper clock handling later
+	clk_prepare_enable(data->clk);
+
+	ret = sysmmu_get_hw_info(data);
+	if (ret) {
+		dev_err(dev, "failed to get h/w info\n");
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&data->list);
+	spin_lock_init(&data->lock);
+	data->dev = dev;
+
+	ret = sysmmu_parse_dt(data->dev, data);
+	if (ret)
+		return ret;
+
+	ret = iommu_device_sysfs_add(&data->iommu, data->dev,
+				     NULL, dev_name(dev));
+	if (ret) {
+		dev_err(dev, "failed to register iommu in sysfs\n");
+		return ret;
+	}
+
+	err = iommu_device_register(&data->iommu, &samsung_sysmmu_ops, dev);
+	if (err) {
+		dev_err(dev, "failed to register iommu\n");
+		goto err_iommu_register;
+	}
+
+	if (!sysmmu_global_init_done) {
+		err = samsung_sysmmu_init_global();
+		if (err) {
+			dev_err(dev, "failed to initialize global data\n");
+			goto err_global_init;
+		}
+	}
+	pm_runtime_enable(dev);
+
+	platform_set_drvdata(pdev, data);
+
+	dev_info(dev, "initialized IOMMU. Ver %d.%d.%d, %sgate clock\n",
+		 MMU_MAJ_VER(data->version),
+		 MMU_MIN_VER(data->version),
+		 MMU_REV_VER(data->version),
+		 data->clk ? "" : "no ");
+	return 0;
+
+err_global_init:
+	iommu_device_unregister(&data->iommu);
+err_iommu_register:
+	iommu_device_sysfs_remove(&data->iommu);
+	return err;
+}
+
+static void samsung_sysmmu_device_shutdown(struct platform_device *pdev)
+{
+}
+
+static int __maybe_unused samsung_sysmmu_runtime_suspend(struct device *sysmmu)
+{
+	unsigned long flags;
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->rpm_resume = false;
+	if (drvdata->attached_count > 0)
+		__sysmmu_disable(drvdata);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	return 0;
+}
+
+static int __maybe_unused samsung_sysmmu_runtime_resume(struct device *sysmmu)
+{
+	unsigned long flags;
+	struct sysmmu_drvdata *drvdata = dev_get_drvdata(sysmmu);
+
+	spin_lock_irqsave(&drvdata->lock, flags);
+	drvdata->rpm_resume = true;
+	if (drvdata->attached_count > 0)
+		__sysmmu_enable(drvdata);
+	spin_unlock_irqrestore(&drvdata->lock, flags);
+
+	return 0;
+}
+
+static int __maybe_unused samsung_sysmmu_suspend(struct device *dev)
+{
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	dev->power.must_resume = true;
+	return samsung_sysmmu_runtime_suspend(dev);
+}
+
+static int __maybe_unused samsung_sysmmu_resume(struct device *dev)
+{
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	return samsung_sysmmu_runtime_resume(dev);
+}
+
+static const struct dev_pm_ops samsung_sysmmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(samsung_sysmmu_runtime_suspend,
+			   samsung_sysmmu_runtime_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(samsung_sysmmu_suspend,
+				     samsung_sysmmu_resume)
+};
+
+static const struct of_device_id sysmmu_of_match[] = {
+	{ .compatible = "samsung,sysmmu-v8" },
+	{ }
+};
+
+static struct platform_driver samsung_sysmmu_driver = {
+	.driver	= {
+		.name			= "samsung-sysmmu",
+		.of_match_table		= of_match_ptr(sysmmu_of_match),
+		.pm			= &samsung_sysmmu_pm_ops,
+		.suppress_bind_attrs	= true,
+	},
+	.probe	= samsung_sysmmu_device_probe,
+	.shutdown = samsung_sysmmu_device_shutdown,
+};
+module_platform_driver(samsung_sysmmu_driver);
+MODULE_SOFTDEP("pre: samsung-iommu-group");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/samsung-iommu.h b/drivers/iommu/samsung-iommu.h
new file mode 100644
index 000000000000..c6162740b296
--- /dev/null
+++ b/drivers/iommu/samsung-iommu.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SAMSUNG_IOMMU_H
+#define __SAMSUNG_IOMMU_H
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+
+#define MAX_VIDS			8U
+
+struct tlb_config {
+	unsigned int index;
+	u32 cfg;
+	u32 match_cfg;
+	u32 match_id;
+};
+
+struct tlb_props {
+	int id_cnt;
+	u32 default_cfg;
+	struct tlb_config *cfg;
+};
+
+struct sysmmu_drvdata {
+	struct list_head list;
+	struct iommu_device iommu;
+	struct device *dev;
+	struct iommu_group *group;
+	void __iomem *sfrbase;
+	struct clk *clk;
+	phys_addr_t pgtable[MAX_VIDS];
+	spinlock_t lock; /* protect atomic update to H/W status */
+	u32 version;
+	unsigned int num_tlb;
+	int qos;
+	int attached_count;
+	int secure_irq;
+	unsigned int secure_base;
+	const unsigned int *reg_set;
+	struct tlb_props tlb_props;
+	bool no_block_mode;
+	bool has_vcr;
+	bool no_s2pf;		/* Disable stage 2 prefetch */
+	bool rpm_resume;	/* true if .runtime_resume() is called */
+	bool async_fault_mode;
+	bool hide_page_fault;
+};
+
+struct sysmmu_clientdata {
+	struct sysmmu_drvdata **sysmmus;
+	struct device_link **dev_link;
+	unsigned int sysmmu_count;
+};
+
+
+enum {
+	REG_IDX_DEFAULT = 0,
+	REG_IDX_VM,
+
+	MAX_SET_IDX,
+};
+
+enum {
+	IDX_CTRL_VM = 0,
+	IDX_CFG_VM,
+	IDX_FLPT_BASE,
+	IDX_ALL_INV,
+	IDX_VPN_INV,
+	IDX_RANGE_INV,
+	IDX_RANGE_INV_START,
+	IDX_RANGE_INV_END,
+	IDX_FAULT_VA,
+	IDX_FAULT_TRANS_INFO,
+	IDX_TLB_READ,
+	IDX_TLB_VPN,
+	IDX_TLB_PPN,
+	IDX_TLB_ATTR,
+	IDX_SBB_READ,
+	IDX_SBB_VPN,
+	IDX_SBB_LINK,
+	IDX_SBB_ATTR,
+	IDX_SEC_FLPT_BASE,
+
+	MAX_REG_IDX,
+};
+
+#define MMU_VM_REG_MULT(idx)		(((idx) == IDX_FAULT_VA || (idx) == IDX_FAULT_TRANS_INFO) \
+					 ? 0x10 : 0x1000)
+
+#define MMU_REG(data, idx)		((data)->sfrbase + (data)->reg_set[idx])
+#define MMU_VM_REG(data, idx, vmid)	(MMU_REG(data, idx) + (vmid) * MMU_VM_REG_MULT(idx))
+#define MMU_SEC_REG(data, offset_idx)	((data)->secure_base + (data)->reg_set[offset_idx])
+#define MMU_SEC_VM_REG(data, offset_idx, vmid) (MMU_SEC_REG(data, offset_idx) + \
+						(vmid) * MMU_VM_REG_MULT(offset_idx))
+
+static inline unsigned int __max_vids(struct sysmmu_drvdata *data)
+{
+	if (data->has_vcr)
+		return MAX_VIDS;
+	return 1;
+}
+
+typedef u32 sysmmu_iova_t;
+typedef u32 sysmmu_pte_t;
+
+#define SECT_ORDER 20
+#define LPAGE_ORDER 16
+#define SPAGE_ORDER 12
+
+#define SECT_SIZE  (1UL << SECT_ORDER)
+#define LPAGE_SIZE (1UL << LPAGE_ORDER)
+#define SPAGE_SIZE (1UL << SPAGE_ORDER)
+
+#define SECT_MASK (~(SECT_SIZE - 1))
+#define LPAGE_MASK (~(LPAGE_SIZE - 1))
+#define SPAGE_MASK (~(SPAGE_SIZE - 1))
+
+#define SECT_ENT_MASK	~((SECT_SIZE >> PG_ENT_SHIFT) - 1)
+#define LPAGE_ENT_MASK	~((LPAGE_SIZE >> PG_ENT_SHIFT) - 1)
+#define SPAGE_ENT_MASK	~((SPAGE_SIZE >> PG_ENT_SHIFT) - 1)
+
+#define SPAGES_PER_LPAGE	(LPAGE_SIZE / SPAGE_SIZE)
+
+#define NUM_LV1ENTRIES	4096
+#define NUM_LV2ENTRIES (SECT_SIZE / SPAGE_SIZE)
+#define LV1TABLE_SIZE (NUM_LV1ENTRIES * sizeof(sysmmu_pte_t))
+#define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(sysmmu_pte_t))
+
+#define lv1ent_offset(iova) ((iova) >> SECT_ORDER)
+#define lv2ent_offset(iova) (((iova) & ~SECT_MASK) >> SPAGE_ORDER)
+
+#define FLPD_FLAG_MASK	7
+#define SLPD_FLAG_MASK	3
+
+#define SECT_FLAG	2
+#define SLPD_FLAG	1
+
+#define LPAGE_FLAG	1
+#define SPAGE_FLAG	2
+
+#define PG_ENT_SHIFT	4
+#define lv1ent_unmapped(sent)	((*(sent) & 7) == 0)
+#define lv1ent_page(sent)	((*(sent) & 7) == 1)
+
+#define lv1ent_section(sent)	((*(sent) & FLPD_FLAG_MASK) == SECT_FLAG)
+#define lv2table_base(sent)	((phys_addr_t)(*(sent) & ~0x3FU) << PG_ENT_SHIFT)
+#define lv2ent_unmapped(pent)	((*(pent) & SLPD_FLAG_MASK) == 0)
+#define lv2ent_small(pent)	((*(pent) & SLPD_FLAG_MASK) == SPAGE_FLAG)
+#define lv2ent_large(pent)	((*(pent) & SLPD_FLAG_MASK) == LPAGE_FLAG)
+
+#define PGBASE_TO_PHYS(pgent)	((phys_addr_t)(pgent) << PG_ENT_SHIFT)
+#define ENT_TO_PHYS(ent) (phys_addr_t)(*(ent))
+#define section_phys(sent) PGBASE_TO_PHYS(ENT_TO_PHYS(sent) & SECT_ENT_MASK)
+#define section_offs(iova) ((iova) & (SECT_SIZE - 1))
+#define lpage_phys(pent) PGBASE_TO_PHYS(ENT_TO_PHYS(pent) & LPAGE_ENT_MASK)
+#define lpage_offs(iova) ((iova) & (LPAGE_SIZE - 1))
+#define spage_phys(pent) PGBASE_TO_PHYS(ENT_TO_PHYS(pent) & SPAGE_ENT_MASK)
+#define spage_offs(iova) ((iova) & (SPAGE_SIZE - 1))
+
+static inline sysmmu_pte_t *page_entry(sysmmu_pte_t *sent, sysmmu_iova_t iova)
+{
+	return (sysmmu_pte_t *)(phys_to_virt(lv2table_base(sent))) +
+				lv2ent_offset(iova);
+}
+
+static inline sysmmu_pte_t *section_entry(sysmmu_pte_t *pgtable,
+					  sysmmu_iova_t iova)
+{
+	return pgtable + lv1ent_offset(iova);
+}
+
+#define REG_MMU_CTRL			0x000
+#define REG_MMU_CFG			0x004
+#define REG_MMU_STATUS			0x008
+#define REG_MMU_FLPT_BASE		0x00C
+#define REG_MMU_VERSION			0x034
+#define REG_MMU_CAPA0_V7		0x870
+#define REG_MMU_CAPA1_V7		0x874
+
+#define MMU_CAPA_NUM_TLB_WAY(reg)	((reg) & 0xFF)
+#define MMU_CAPA_NUM_SBB_ENTRY(reg)	(((reg) >> 12) & 0xF)
+#define MMU_CAPA1_EXIST(reg)		(((reg) >> 11) & 0x1)
+#define MMU_CAPA1_TYPE(reg)		(((reg) >> 28) & 0xF)
+#define MMU_CAPA1_NO_BLOCK_MODE(reg)	(((reg) >> 15) & 0x1)
+#define MMU_CAPA1_VCR_ENABLED(reg)	(((reg) >> 14) & 0x1)
+#define MMU_CAPA1_NUM_TLB(reg)		(((reg) >> 4) & 0xFF)
+#define MMU_CAPA1_NUM_PORT(reg)		((reg) & 0xF)
+
+#define MMU_MAJ_VER(val)	((val) >> 11)
+#define MMU_MIN_VER(val)	(((val) >> 4) & 0x7F)
+#define MMU_REV_VER(val)	((val) & 0xF)
+#define MMU_RAW_VER(reg)	(((reg) >> 17) & 0x7FFF)
+
+#define CTRL_VID_ENABLE			BIT(0)
+#define CTRL_MMU_ENABLE			BIT(0)
+#define CTRL_MMU_BLOCK			BIT(1)
+#define CTRL_INT_ENABLE			BIT(2)
+#define CTRL_FAULT_STALL_MODE		BIT(3)
+
+#define CFG_MASK_GLOBAL			0x00000F80 /* Bit 11, 10-7 */
+#define CFG_MASK_VM			0xB00F1004 /* Bit 31, 29, 28, 19-16, 12, 2 */
+#define CFG_QOS_OVRRIDE			BIT(11)
+#define CFG_QOS(n)			(((n) & 0xFU) << 7)
+
+irqreturn_t samsung_sysmmu_irq_thread(int irq, void *dev_id);
+irqreturn_t samsung_sysmmu_irq(int irq, void *dev_id);
+
+#endif /* __SAMSUNG_IOMMU_H */
+
-- 
2.30.2

