Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A957538A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbiGNQ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiGNQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:56:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBE14E851
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so1591579wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55TJor/aCJoOF4UFT1NY5SUJ0CHcR5BKyA02/AHT5cA=;
        b=byRP/VN0EqKXhheJyOKz3lqTWrKNaT9JuVUOLLLCWecygrJz5FM+E/i8q8DMlThq6e
         Ixc0EA9Qe2ffbdpY9lvTl5gcr8ws7Szeag2UHmhxb6V72ykanixC5tPpgohQFBYTag8o
         Epb4T+hw2QFVaENvVDZJF2CmI7ipwyRwrobXZGRX0LnZDCN6gMNbDgChPk/bTZqICXD7
         7RDMRE6VsKtDGJrd28oq0UybVqVKMo7UIT4Idtm09O2b4pSIdjJDYK/Lb9jdj7fcLGHL
         kFQRBhko2FwlI1Ox8QbiiKLTrfnB2haQFB8Irrapx2jH1bWc8pC0qdrnfktZvEcvmJc7
         t3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55TJor/aCJoOF4UFT1NY5SUJ0CHcR5BKyA02/AHT5cA=;
        b=A0pptf6Oeyh5Qxw0PL8H7s6698KpAgsNTbm+QMzjud/YuTnCduq7xD3v8b5RY0Aat0
         IHGW2+frLvylcvAtL+nRZope5RjmL/agKZu86U4rYUA5Waw/hGN0eFI6U3mxW2MCywFz
         J3jpWFPlZvWLt3XsmNUIuUko/wIQ0KI5K3WVn7QnGj5bFeu34bB/TrVgIgm/U2T+HvlM
         PTZ7yS9/qOT2nON47P9Y3mrZfQYCNDZKwFy8c4sRxlNQPGGyNXP42T0I/N0ZWSXWQ9A9
         H79MLqUlQICelBaoZfp4c8fCIaTNHJgj/L8ETbN5ZUjyp98eJWeVvYbhcyahRiHih4Uz
         AFtQ==
X-Gm-Message-State: AJIora9/vzqEV1YN9ScKbIWEo3RdN6VKnU4X4DO4znXxMaAkEd33yaUn
        T3JNSLvVCsT4/QETTM8JRkCIZw==
X-Google-Smtp-Source: AGRyM1vvKu2kw7N9KRAEjNxUqHhJ2Bqucjaaf8iDnA3CwW9K5CvrPj01Y3rCAjO1g6YvCESEdQJl8g==
X-Received: by 2002:a05:600c:1d9a:b0:3a3:34d:d6ac with SMTP id p26-20020a05600c1d9a00b003a3034dd6acmr2971190wms.206.1657817759428;
        Thu, 14 Jul 2022 09:55:59 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b0021d6d18a9f8sm1887563wrs.76.2022.07.14.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:58 -0700 (PDT)
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
Subject: [PATCH v3 5/6] iommu/exynos: Add SysMMU v7 register set
Date:   Thu, 14 Jul 2022 19:55:49 +0300
Message-Id: <20220714165550.8884-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SysMMU v7 might have different register layouts (VM capable or non-VM
capable). Virtual Machine registers (if present) implement multiple
translation domains. If VM registers are not present, the driver
shouldn't try to access those.

Check which layout is implemented in current SysMMU module (by reading
the capability registers) and prepare the corresponding variant
structure for further usage.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Merged "Check if SysMMU v7 has VM registers" patch into this patch
  - Reworked for using variant struct (instead of array)

Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6a0299fe1722..fc9ef3ff0057 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CAPA0_CAPA1_EXIST		BIT(11)
+#define CAPA1_VCR_ENABLED		BIT(14)
+
 /* common registers */
 #define REG_MMU_CTRL		0x000
 #define REG_MMU_CFG		0x004
@@ -157,6 +160,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
+/* v7.x registers */
+#define REG_V7_CAPA0		0x870
+#define REG_V7_CAPA1		0x874
+
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 static struct device *dma_dev;
@@ -276,6 +283,9 @@ struct sysmmu_drvdata {
 
 	struct iommu_device iommu;	/* IOMMU core handle */
 	const struct sysmmu_variant *variant; /* version specific data */
+
+	/* v7 fields */
+	bool has_vcr;			/* virtual machine control register */
 };
 
 #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
@@ -289,7 +299,7 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
 	.int_clear	= 0x1c,
 };
 
-/* SysMMU v5 */
+/* SysMMU v5 and v7 (non-VM capable) */
 static const struct sysmmu_variant sysmmu_v5_variant = {
 	.pt_base	= 0x0c,
 	.flush_all	= 0x10,
@@ -301,6 +311,18 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
 	.int_clear	= 0x64,
 };
 
+/* SysMMU v7: VM capable register set */
+static const struct sysmmu_variant sysmmu_v7_vm_variant = {
+	.pt_base	= 0x800c,
+	.flush_all	= 0x8010,
+	.flush_entry	= 0x8014,
+	.flush_range	= 0x8018,
+	.flush_start	= 0x8020,
+	.flush_end	= 0x8024,
+	.int_status	= 0x60,
+	.int_clear	= 0x64,
+};
+
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct exynos_iommu_domain, domain);
@@ -380,6 +402,20 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
 	clk_disable_unprepare(data->clk_master);
 }
 
+static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
+
+	return capa0 & CAPA0_CAPA1_EXIST;
+}
+
+static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
+{
+	u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
+
+	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+}
+
 static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 {
 	u32 ver;
@@ -397,10 +433,18 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
 
-	if (MMU_MAJ_VER(data->version) < 5)
+	if (MMU_MAJ_VER(data->version) < 5) {
 		data->variant = &sysmmu_v1_variant;
-	else
+	} else if (MMU_MAJ_VER(data->version) < 7) {
 		data->variant = &sysmmu_v5_variant;
+	} else {
+		if (__sysmmu_has_capa1(data))
+			__sysmmu_get_vcr(data);
+		if (data->has_vcr)
+			data->variant = &sysmmu_v7_vm_variant;
+		else
+			data->variant = &sysmmu_v5_variant;
+	}
 
 	__sysmmu_disable_clocks(data);
 }
-- 
2.30.2

