Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD1581AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiGZUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiGZUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:07:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803AB326C9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f15so10530821edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x8JEg80flsOmhOVw9xUtj3ZgqdSAd1GXYYmLiUgwIJo=;
        b=tw6yzHk/lm71yQid4IVhbAI+D4WbhqtLTB1PMKPiKVL47WmpnzDTus99S2FLogl+Cj
         ZVtP1/8VvtcKA5xqz8Kcqy5aHXrHoud2fveQUn4LxZXaxadU6OEs56oSBsPH3tEfl4+p
         HZaWFGQHQ07D+HWSLgiEqgzmetfnfZ6b8REfPthktn9dIEl3FFwjgZDnEbbRMBH0OZAn
         AcPz88GazikLj7G7IsZXABlVXgmgIg3f9wimCnBPBA+4XmeOsqegNkGor2dxnIiQI0v4
         lV69D0IigT3ZdcA0XqRVNFHk7E0LsTfIRQ1+0Xp1yRzdRTb8BtBQ7UANZu6deWF7VL0g
         4ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x8JEg80flsOmhOVw9xUtj3ZgqdSAd1GXYYmLiUgwIJo=;
        b=7V3b+Hx9ME2t9O2epiL1mgA6G31kguwpmp+YN0Vq1CUgh4y+hm1KoDlH/b8lw5Itjn
         uZC8L98ElCkpmA8OeZjwL9AQuKqBiwZXWnNrHr0EzVHBQg+ZcM0MHKB2EcfMminj+h2+
         MrthwSdms94iGcJcepz+eNIKuDfLs2u97ghAg/XXosnfCAgeptve/ypUEONRsn697q8Z
         5eaIurJD8TtwG/J1uMfvDDz/x4dYKNk7rDx9HpZyfJKdPkLsBNVxwBoSayhbwfoMcwFs
         h3bogh2XHLzLcU2wvG8iTvY9V+ob3dZ6stzR/hwAmS1NqnTJIvTamj/3qES4Xca5hBff
         0F/Q==
X-Gm-Message-State: AJIora9Y+w5+deg6dHwBX5En929cb2AGjbiWSo9zlEr8oYJ5bXc8OumV
        n9CllpLrXy2VdOLqxAfQ17fTOA==
X-Google-Smtp-Source: AGRyM1sccCHUG8UBx4UK0ipRILdGaGAQpbl5Qi74F85okFwDRJZEtbSVSED/iKNvA3Od982IY4Rlgg==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr19098596edb.273.1658866061999;
        Tue, 26 Jul 2022 13:07:41 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0042de3d661d2sm8926964edb.1.2022.07.26.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:07:41 -0700 (PDT)
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
Subject: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
Date:   Tue, 26 Jul 2022 23:07:38 +0300
Message-Id: <20220726200739.30017-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726200739.30017-1-semen.protsenko@linaro.org>
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fault info obtaining is implemented for SysMMU v1..v5 in a very hardware
specific way, as it relies on:
  - interrupt bits being tied to read or write access
  - having separate registers for the fault address w.r.t. AR/AW ops

Newer SysMMU versions (like SysMMU v7) have different way of providing
the fault info via registers:
  - the transaction type (read or write) should be read from the
    register (instead of hard-coding it w.r.t. corresponding interrupt
    status bit)
  - there is only one single register for storing the fault address

Because of that, it is not possible to add newer SysMMU support into
existing paradigm. Also it's not very effective performance-wise:
  - checking SysMMU version in ISR each time is not necessary
  - performing linear search to find the fault info by interrupt bit can
    be replaced with a single lookup operation

Pave the way for adding support for new SysMMU versions by abstracting
the getting of fault info in ISR. While at it, do some related style
cleanups as well.

This is mostly a refactoring patch, but there are some minor functional
changes:
  - fault message format is a bit different; now instead of AR/AW
    prefixes for the fault's name, the request direction is printed as
    [READ]/[WRITE]. It has to be done to prepare an abstraction for
    SysMMU v7 support
  - don't panic on unknown interrupts; print corresponding message and
    continue
  - if fault wasn't recovered, panic with some sane message instead of
    just doing BUG_ON()

The whole fault message looks like this now:

    [READ] PAGE FAULT occurred at 0x12341000

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 162 +++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8e18984a0c4f..766d409e084a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -185,38 +185,36 @@ static sysmmu_pte_t *page_entry(sysmmu_pte_t *sent, sysmmu_iova_t iova)
 				lv2table_base(sent)) + lv2ent_offset(iova);
 }
 
-/*
- * IOMMU fault information register
- */
-struct sysmmu_fault_info {
-	unsigned int bit;	/* bit number in STATUS register */
-	unsigned short addr_reg; /* register to read VA fault address */
+struct sysmmu_fault {
+	sysmmu_iova_t addr;	/* IOVA address that caused fault */
+	const char *name;	/* human readable fault name */
+	unsigned int type;	/* fault type for report_iommu_fault() */
+};
+
+struct sysmmu_v1_fault_info {
+	unsigned short addr_reg; /* register to read IOVA fault address */
 	const char *name;	/* human readable fault name */
 	unsigned int type;	/* fault type for report_iommu_fault */
 };
 
-static const struct sysmmu_fault_info sysmmu_faults[] = {
-	{ 0, REG_PAGE_FAULT_ADDR, "PAGE", IOMMU_FAULT_READ },
-	{ 1, REG_AR_FAULT_ADDR, "AR MULTI-HIT", IOMMU_FAULT_READ },
-	{ 2, REG_AW_FAULT_ADDR, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
-	{ 3, REG_DEFAULT_SLAVE_ADDR, "BUS ERROR", IOMMU_FAULT_READ },
-	{ 4, REG_AR_FAULT_ADDR, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
-	{ 5, REG_AR_FAULT_ADDR, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
-	{ 6, REG_AW_FAULT_ADDR, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
-	{ 7, REG_AW_FAULT_ADDR, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
+static const struct sysmmu_v1_fault_info sysmmu_v1_faults[] = {
+	{ REG_PAGE_FAULT_ADDR, "PAGE", IOMMU_FAULT_READ },
+	{ REG_AR_FAULT_ADDR, "MULTI-HIT", IOMMU_FAULT_READ },
+	{ REG_AW_FAULT_ADDR, "MULTI-HIT", IOMMU_FAULT_WRITE },
+	{ REG_DEFAULT_SLAVE_ADDR, "BUS ERROR", IOMMU_FAULT_READ },
+	{ REG_AR_FAULT_ADDR, "SECURITY PROTECTION", IOMMU_FAULT_READ },
+	{ REG_AR_FAULT_ADDR, "ACCESS PROTECTION", IOMMU_FAULT_READ },
+	{ REG_AW_FAULT_ADDR, "SECURITY PROTECTION", IOMMU_FAULT_WRITE },
+	{ REG_AW_FAULT_ADDR, "ACCESS PROTECTION", IOMMU_FAULT_WRITE },
 };
 
-static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
-	{ 0, REG_V5_FAULT_AR_VA, "AR PTW", IOMMU_FAULT_READ },
-	{ 1, REG_V5_FAULT_AR_VA, "AR PAGE", IOMMU_FAULT_READ },
-	{ 2, REG_V5_FAULT_AR_VA, "AR MULTI-HIT", IOMMU_FAULT_READ },
-	{ 3, REG_V5_FAULT_AR_VA, "AR ACCESS PROTECTION", IOMMU_FAULT_READ },
-	{ 4, REG_V5_FAULT_AR_VA, "AR SECURITY PROTECTION", IOMMU_FAULT_READ },
-	{ 16, REG_V5_FAULT_AW_VA, "AW PTW", IOMMU_FAULT_WRITE },
-	{ 17, REG_V5_FAULT_AW_VA, "AW PAGE", IOMMU_FAULT_WRITE },
-	{ 18, REG_V5_FAULT_AW_VA, "AW MULTI-HIT", IOMMU_FAULT_WRITE },
-	{ 19, REG_V5_FAULT_AW_VA, "AW ACCESS PROTECTION", IOMMU_FAULT_WRITE },
-	{ 20, REG_V5_FAULT_AW_VA, "AW SECURITY PROTECTION", IOMMU_FAULT_WRITE },
+/* SysMMU v5 has the same faults for AR (0..4 bits) and AW (16..20 bits) */
+static const char * const sysmmu_v5_fault_names[] = {
+	"PTW",
+	"PAGE",
+	"MULTI-HIT",
+	"ACCESS PROTECTION",
+	"SECURITY PROTECTION"
 };
 
 /*
@@ -246,9 +244,12 @@ struct exynos_iommu_domain {
 	struct iommu_domain domain; /* generic domain data structure */
 };
 
+struct sysmmu_drvdata;
+
 /*
  * SysMMU version specific data. Contains offsets for the registers which can
  * be found in different SysMMU variants, but have different offset values.
+ * Also contains version specific callbacks to abstract the hardware.
  */
 struct sysmmu_variant {
 	u32 pt_base;		/* page table base address (physical) */
@@ -259,6 +260,9 @@ struct sysmmu_variant {
 	u32 flush_end;		/* end address of range invalidation */
 	u32 int_status;		/* interrupt status information */
 	u32 int_clear;		/* clear the interrupt */
+
+	int (*get_fault_info)(struct sysmmu_drvdata *data, unsigned int itype,
+			      struct sysmmu_fault *fault);
 };
 
 /*
@@ -293,6 +297,46 @@ struct sysmmu_drvdata {
 
 #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
 
+static int exynos_sysmmu_v1_get_fault_info(struct sysmmu_drvdata *data,
+					   unsigned int itype,
+					   struct sysmmu_fault *fault)
+{
+	const struct sysmmu_v1_fault_info *finfo;
+
+	if (itype >= ARRAY_SIZE(sysmmu_v1_faults))
+		return -ENXIO;
+
+	finfo = &sysmmu_v1_faults[itype];
+	fault->addr = readl(data->sfrbase + finfo->addr_reg);
+	fault->name = finfo->name;
+	fault->type = finfo->type;
+
+	return 0;
+}
+
+static int exynos_sysmmu_v5_get_fault_info(struct sysmmu_drvdata *data,
+					   unsigned int itype,
+					   struct sysmmu_fault *fault)
+{
+	unsigned int addr_reg;
+
+	if (itype < ARRAY_SIZE(sysmmu_v5_fault_names)) {
+		fault->type = IOMMU_FAULT_READ;
+		addr_reg = REG_V5_FAULT_AR_VA;
+	} else if (itype >= 16 && itype <= 20) {
+		fault->type = IOMMU_FAULT_WRITE;
+		addr_reg = REG_V5_FAULT_AW_VA;
+		itype -= 16;
+	} else {
+		return -ENXIO;
+	}
+
+	fault->name = sysmmu_v5_fault_names[itype];
+	fault->addr = readl(data->sfrbase + addr_reg);
+
+	return 0;
+}
+
 /* SysMMU v1..v3 */
 static const struct sysmmu_variant sysmmu_v1_variant = {
 	.flush_all	= 0x0c,
@@ -300,6 +344,8 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
 	.pt_base	= 0x14,
 	.int_status	= 0x18,
 	.int_clear	= 0x1c,
+
+	.get_fault_info	= exynos_sysmmu_v1_get_fault_info,
 };
 
 /* SysMMU v5 and v7 (non-VM capable) */
@@ -312,6 +358,8 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
 	.flush_end	= 0x24,
 	.int_status	= 0x60,
 	.int_clear	= 0x64,
+
+	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
 };
 
 /* SysMMU v7: VM capable register set */
@@ -324,6 +372,8 @@ static const struct sysmmu_variant sysmmu_v7_vm_variant = {
 	.flush_end	= 0x8024,
 	.int_status	= 0x60,
 	.int_clear	= 0x64,
+
+	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -453,68 +503,56 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 }
 
 static void show_fault_information(struct sysmmu_drvdata *data,
-				   const struct sysmmu_fault_info *finfo,
-				   sysmmu_iova_t fault_addr)
+				   const struct sysmmu_fault *fault)
 {
 	sysmmu_pte_t *ent;
 
-	dev_err(data->sysmmu, "%s: %s FAULT occurred at %#x\n",
-		dev_name(data->master), finfo->name, fault_addr);
+	dev_err(data->sysmmu, "%s: [%s] %s FAULT occurred at %#x\n",
+		dev_name(data->master),
+		fault->type == IOMMU_FAULT_READ ? "READ" : "WRITE",
+		fault->name, fault->addr);
 	dev_dbg(data->sysmmu, "Page table base: %pa\n", &data->pgtable);
-	ent = section_entry(phys_to_virt(data->pgtable), fault_addr);
+	ent = section_entry(phys_to_virt(data->pgtable), fault->addr);
 	dev_dbg(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
 	if (lv1ent_page(ent)) {
-		ent = page_entry(ent, fault_addr);
+		ent = page_entry(ent, fault->addr);
 		dev_dbg(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
 	}
 }
 
 static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 {
-	/* SYSMMU is in blocked state when interrupt occurred. */
 	struct sysmmu_drvdata *data = dev_id;
-	const struct sysmmu_fault_info *finfo;
-	unsigned int i, n, itype;
-	sysmmu_iova_t fault_addr;
+	unsigned int itype;
+	struct sysmmu_fault fault;
 	int ret = -ENOSYS;
 
 	WARN_ON(!data->active);
 
-	if (MMU_MAJ_VER(data->version) < 5) {
-		finfo = sysmmu_faults;
-		n = ARRAY_SIZE(sysmmu_faults);
-	} else {
-		finfo = sysmmu_v5_faults;
-		n = ARRAY_SIZE(sysmmu_v5_faults);
-	}
-
 	spin_lock(&data->lock);
-
 	clk_enable(data->clk_master);
 
 	itype = __ffs(readl(SYSMMU_REG(data, int_status)));
-	for (i = 0; i < n; i++, finfo++)
-		if (finfo->bit == itype)
-			break;
-	/* unknown/unsupported fault */
-	BUG_ON(i == n);
-
-	/* print debug message */
-	fault_addr = readl(data->sfrbase + finfo->addr_reg);
-	show_fault_information(data, finfo, fault_addr);
-
-	if (data->domain)
-		ret = report_iommu_fault(&data->domain->domain,
-					data->master, fault_addr, finfo->type);
-	/* fault is not recovered by fault handler */
-	BUG_ON(ret != 0);
+	ret = data->variant->get_fault_info(data, itype, &fault);
+	if (ret) {
+		dev_err(data->sysmmu, "Unhandled interrupt bit %u\n", itype);
+		goto out;
+	}
+	show_fault_information(data, &fault);
 
+	if (data->domain) {
+		ret = report_iommu_fault(&data->domain->domain, data->master,
+					 fault.addr, fault.type);
+	}
+	if (ret)
+		panic("Unrecoverable System MMU Fault!");
+
+out:
 	writel(1 << itype, SYSMMU_REG(data, int_clear));
 
+	/* SysMMU is in blocked state when interrupt occurred */
 	sysmmu_unblock(data);
-
 	clk_disable(data->clk_master);
-
 	spin_unlock(&data->lock);
 
 	return IRQ_HANDLED;
-- 
2.30.2

