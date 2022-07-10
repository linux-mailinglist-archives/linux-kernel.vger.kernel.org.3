Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DFC56D1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiGJXGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGJXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080010FC1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay25so2135545wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWpujlI5omHz17Fb+MoaFJbCPt7aAheJ5MhgDzPMgM0=;
        b=cSG664Q9gF3etdWSbwOEagSbmm/jbAvPlTd0GQyTFqGN0Nmz90AyqP2Ln6A7NZIWX4
         BDzgUmWae5Ic+hS20Ca3borTfTTIyVGUL4NwlG9GD1tm/LJ3lGvUNN6RNZlzQiHfH2SE
         L3QfFmHDRmPjlqrvK85oV8iMPDm/uBBAvs1B0PFQQv8Ll+f9x3mx/pgN97tTGbgNQ7w5
         01xhL8TppXdWi6mbTBI9UtIOWPN0GL4H3TkuRZt6t5tBzr18wo6WcVYHWTenWvV3SuNN
         s9/Ow2ISk4FRzZts//4BO8jKBWa1MPLypBT2YoXFP21TdTdDr0ORkZky7Ha9JMGiwEcN
         YTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWpujlI5omHz17Fb+MoaFJbCPt7aAheJ5MhgDzPMgM0=;
        b=4ggBlzXwh0k7XN0ltdLsDwgyvt5vc9XnBN3CjeQN+aRLctD0Y2Gzt2O1l7K/0Gf9O/
         C5l0bJ1b5F8upbf3qfXEqC7l9mHbmHnIlTFomTdveTXfRx6MnS/JNbEm6qYxpcfMQKl9
         UzOSyICoZxY1vnL/61WD5Me3AydA0KA0OPlp51c475L8Fs2SJtNfmQ6j2BE+vRmJcpem
         qBZ5fO+L/AqBsMWDXBtMYuMoZN/0903LjVKY3IEp7w5RloKmDJONoHKp0c0lKQY6jrJt
         SNsbR4shCao4S40Yw6SvIYMxtueagR/kpHHXr2t99VLgMmjd3tzRCKMPuOImv97eEae2
         w2Bw==
X-Gm-Message-State: AJIora97ZOIJhkhpn56WEz0igGCaEyHTV/fs8yM7dctiJnwi4hoRf7/t
        Le/ptWNRXUR5Z8qjVQfHkSM4Pw==
X-Google-Smtp-Source: AGRyM1t2lcHq7wxqO/juKZwr2K4NYwiyQlyw/MxC3xMXkZH43/eHky8In7BlEl8djCE4qAYCjJutfA==
X-Received: by 2002:a05:600c:5129:b0:3a1:92e6:563e with SMTP id o41-20020a05600c512900b003a192e6563emr12469243wms.81.1657494369557;
        Sun, 10 Jul 2022 16:06:09 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003a04962ad3esm8775052wme.31.2022.07.10.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:09 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access registers
Date:   Mon, 11 Jul 2022 02:06:00 +0300
Message-Id: <20220710230603.13526-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the driver supports SysMMU v1..v5 versions. SysMMU v5 has
different register layout than SysMMU v1..v3. Instead of checking the
version each time before reading/writing the registers, let's create
corresponding register table for each SysMMU version and set the needed
table on init, checking the SysMMU version one single time. This way is
faster and more elegant.

No functional change here, just a refactoring patch.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Reworked existing code (SysMMU v1..v5) to use this approach
  - Extracted v7 registers to the separate patches
  - Replaced MMU_REG() with corresponding SysMMU read/write functions
  - Improved the comment for 0x1 offsets triggering an unaligned access
    exception
  - Removed support for VMID number, as only VMID=0 (default) is used
    for now
  - Renamed register index names to reflect the old SysMMU version
    register names

 drivers/iommu/exynos-iommu.c | 141 ++++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 494f7d7aa9c5..0cb1ce10db51 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -136,9 +136,6 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
 /* common registers */
-#define REG_MMU_CTRL		0x000
-#define REG_MMU_CFG		0x004
-#define REG_MMU_STATUS		0x008
 #define REG_MMU_VERSION		0x034
 
 #define MMU_MAJ_VER(val)	((val) >> 7)
@@ -148,31 +145,57 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define MAKE_MMU_VER(maj, min)	((((maj) & 0xF) << 7) | ((min) & 0x7F))
 
 /* v1.x - v3.x registers */
-#define REG_MMU_FLUSH		0x00C
-#define REG_MMU_FLUSH_ENTRY	0x010
-#define REG_PT_BASE_ADDR	0x014
-#define REG_INT_STATUS		0x018
-#define REG_INT_CLEAR		0x01C
-
 #define REG_PAGE_FAULT_ADDR	0x024
 #define REG_AW_FAULT_ADDR	0x028
 #define REG_AR_FAULT_ADDR	0x02C
 #define REG_DEFAULT_SLAVE_ADDR	0x030
 
 /* v5.x registers */
-#define REG_V5_PT_BASE_PFN	0x00C
-#define REG_V5_MMU_FLUSH_ALL	0x010
-#define REG_V5_MMU_FLUSH_ENTRY	0x014
-#define REG_V5_MMU_FLUSH_RANGE	0x018
-#define REG_V5_MMU_FLUSH_START	0x020
-#define REG_V5_MMU_FLUSH_END	0x024
-#define REG_V5_INT_STATUS	0x060
-#define REG_V5_INT_CLEAR	0x064
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
+enum {
+	REG_SET_V1,
+	REG_SET_V5,
+	MAX_REG_SET
+};
+
+enum {
+	IDX_CTRL,
+	IDX_CFG,
+	IDX_STATUS,
+	IDX_PT_BASE,
+	IDX_FLUSH_ALL,
+	IDX_FLUSH_ENTRY,
+	IDX_FLUSH_RANGE,
+	IDX_FLUSH_START,
+	IDX_FLUSH_END,
+	IDX_INT_STATUS,
+	IDX_INT_CLEAR,
+	MAX_REG_IDX
+};
+
+/*
+ * Some SysMMU versions might not implement some registers from this set, thus
+ * those registers shouldn't be accessed. Set the offsets for those registers to
+ * 0x1 to trigger an unaligned access exception, which can help one to debug
+ * related issues.
+ */
+static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
+	/* SysMMU v1..v3 */
+	{
+		0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
+		0x18, 0x1c,
+	},
+	/* SysMMU v5 */
+	{
+		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
+		0x60, 0x64,
+	},
+};
+
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
@@ -274,6 +297,7 @@ struct sysmmu_drvdata {
 	unsigned int version;		/* our version */
 
 	struct iommu_device iommu;	/* IOMMU core handle */
+	const unsigned int *regs;	/* register set */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -281,20 +305,30 @@ static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
 	return container_of(dom, struct exynos_iommu_domain, domain);
 }
 
+static void sysmmu_write(struct sysmmu_drvdata *data, size_t idx, u32 val)
+{
+	writel(val, data->sfrbase + data->regs[idx]);
+}
+
+static u32 sysmmu_read(struct sysmmu_drvdata *data, size_t idx)
+{
+	return readl(data->sfrbase + data->regs[idx]);
+}
+
 static void sysmmu_unblock(struct sysmmu_drvdata *data)
 {
-	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
+	sysmmu_write(data, IDX_CTRL, CTRL_ENABLE);
 }
 
 static bool sysmmu_block(struct sysmmu_drvdata *data)
 {
 	int i = 120;
 
-	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
-	while ((i > 0) && !(readl(data->sfrbase + REG_MMU_STATUS) & 1))
+	sysmmu_write(data, IDX_CTRL, CTRL_BLOCK);
+	while (i > 0 && !(sysmmu_read(data, IDX_STATUS) & 0x1))
 		--i;
 
-	if (!(readl(data->sfrbase + REG_MMU_STATUS) & 1)) {
+	if (!(sysmmu_read(data, IDX_STATUS) & 0x1)) {
 		sysmmu_unblock(data);
 		return false;
 	}
@@ -304,10 +338,7 @@ static bool sysmmu_block(struct sysmmu_drvdata *data)
 
 static void __sysmmu_tlb_invalidate(struct sysmmu_drvdata *data)
 {
-	if (MMU_MAJ_VER(data->version) < 5)
-		writel(0x1, data->sfrbase + REG_MMU_FLUSH);
-	else
-		writel(0x1, data->sfrbase + REG_V5_MMU_FLUSH_ALL);
+	sysmmu_write(data, IDX_FLUSH_ALL, 0x1);
 }
 
 static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
@@ -317,31 +348,33 @@ static void __sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 
 	if (MMU_MAJ_VER(data->version) < 5) {
 		for (i = 0; i < num_inv; i++) {
-			writel((iova & SPAGE_MASK) | 1,
-				     data->sfrbase + REG_MMU_FLUSH_ENTRY);
+			sysmmu_write(data, IDX_FLUSH_ENTRY,
+				     (iova & SPAGE_MASK) | 0x1);
 			iova += SPAGE_SIZE;
 		}
 	} else {
 		if (num_inv == 1) {
-			writel((iova & SPAGE_MASK) | 1,
-				     data->sfrbase + REG_V5_MMU_FLUSH_ENTRY);
+			sysmmu_write(data, IDX_FLUSH_ENTRY,
+				     (iova & SPAGE_MASK) | 0x1);
 		} else {
-			writel((iova & SPAGE_MASK),
-				     data->sfrbase + REG_V5_MMU_FLUSH_START);
-			writel((iova & SPAGE_MASK) + (num_inv - 1) * SPAGE_SIZE,
-				     data->sfrbase + REG_V5_MMU_FLUSH_END);
-			writel(1, data->sfrbase + REG_V5_MMU_FLUSH_RANGE);
+			sysmmu_write(data, IDX_FLUSH_START, iova & SPAGE_MASK);
+			sysmmu_write(data, IDX_FLUSH_END, (iova & SPAGE_MASK) +
+				     (num_inv - 1) * SPAGE_SIZE);
+			sysmmu_write(data, IDX_FLUSH_RANGE, 0x1);
 		}
 	}
 }
 
 static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 {
+	u32 pt_base;
+
 	if (MMU_MAJ_VER(data->version) < 5)
-		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
+		pt_base = pgd;
 	else
-		writel(pgd >> SPAGE_ORDER, data->sfrbase + REG_V5_PT_BASE_PFN);
+		pt_base = pgd >> SPAGE_ORDER;
 
+	sysmmu_write(data, IDX_PT_BASE, pt_base);
 	__sysmmu_tlb_invalidate(data);
 }
 
@@ -365,8 +398,7 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 {
 	u32 ver;
 
-	__sysmmu_enable_clocks(data);
-
+	/* Don't use sysmmu_read() here, as data->regs is not set yet */
 	ver = readl(data->sfrbase + REG_MMU_VERSION);
 
 	/* controllers on some SoCs don't report proper version */
@@ -377,6 +409,17 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
+}
+
+static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
+{
+	__sysmmu_enable_clocks(data);
+
+	__sysmmu_get_version(data);
+	if (MMU_MAJ_VER(data->version) < 5)
+		data->regs = sysmmu_regs[REG_SET_V1];
+	else
+		data->regs = sysmmu_regs[REG_SET_V5];
 
 	__sysmmu_disable_clocks(data);
 }
@@ -405,19 +448,14 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	const struct sysmmu_fault_info *finfo;
 	unsigned int i, n, itype;
 	sysmmu_iova_t fault_addr;
-	unsigned short reg_status, reg_clear;
 	int ret = -ENOSYS;
 
 	WARN_ON(!data->active);
 
 	if (MMU_MAJ_VER(data->version) < 5) {
-		reg_status = REG_INT_STATUS;
-		reg_clear = REG_INT_CLEAR;
 		finfo = sysmmu_faults;
 		n = ARRAY_SIZE(sysmmu_faults);
 	} else {
-		reg_status = REG_V5_INT_STATUS;
-		reg_clear = REG_V5_INT_CLEAR;
 		finfo = sysmmu_v5_faults;
 		n = ARRAY_SIZE(sysmmu_v5_faults);
 	}
@@ -426,7 +464,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 
 	clk_enable(data->clk_master);
 
-	itype = __ffs(readl(data->sfrbase + reg_status));
+	itype = __ffs(sysmmu_read(data, IDX_INT_STATUS));
 	for (i = 0; i < n; i++, finfo++)
 		if (finfo->bit == itype)
 			break;
@@ -443,7 +481,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 	/* fault is not recovered by fault handler */
 	BUG_ON(ret != 0);
 
-	writel(1 << itype, data->sfrbase + reg_clear);
+	sysmmu_write(data, IDX_INT_CLEAR, 1 << itype);
 
 	sysmmu_unblock(data);
 
@@ -461,8 +499,8 @@ static void __sysmmu_disable(struct sysmmu_drvdata *data)
 	clk_enable(data->clk_master);
 
 	spin_lock_irqsave(&data->lock, flags);
-	writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
-	writel(0, data->sfrbase + REG_MMU_CFG);
+	sysmmu_write(data, IDX_CTRL, CTRL_DISABLE);
+	sysmmu_write(data, IDX_CFG, 0x0);
 	data->active = false;
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -482,7 +520,7 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 
 	cfg |= CFG_EAP; /* enable access protection bits check */
 
-	writel(cfg, data->sfrbase + REG_MMU_CFG);
+	sysmmu_write(data, IDX_CFG, cfg);
 }
 
 static void __sysmmu_enable(struct sysmmu_drvdata *data)
@@ -492,10 +530,10 @@ static void __sysmmu_enable(struct sysmmu_drvdata *data)
 	__sysmmu_enable_clocks(data);
 
 	spin_lock_irqsave(&data->lock, flags);
-	writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
+	sysmmu_write(data, IDX_CTRL, CTRL_BLOCK);
 	__sysmmu_init_config(data);
 	__sysmmu_set_ptbase(data, data->pgtable);
-	writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
+	sysmmu_write(data, IDX_CTRL, CTRL_ENABLE);
 	data->active = true;
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -622,6 +660,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
+	sysmmu_get_hw_info(data);
+
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(data->sysmmu));
 	if (ret)
@@ -633,7 +673,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	__sysmmu_get_version(data);
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
 			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
-- 
2.30.2

