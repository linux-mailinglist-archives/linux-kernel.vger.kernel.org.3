Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276FD56D1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGJXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGJXGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:06:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277FF597
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p4so2149194wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNH1geTaFS8UgrJdKxdLAWd/njt1ov+nbcgh7oJT0rY=;
        b=T87IiTdb4pJnCgF0XeioT2CsjqmQdwyQjcZzrX/yjr+VQuaFEsbAGpDF6XUTV9rLQA
         JcXl0fW2wMaYiqTrEkO8BxhXWlqQk8BfN10qYEXGITDn76UzveWAgPGHZIMzLLq8EfrB
         lv4wJ/2nDndYjjktKWPcszs2Gs4Igf3kor8if/eoTbzhbV/aYuFSmXIXYTU65kSdIqSs
         n1C4h9qT2u6O+x8F3TN7nZpFnaT10uOdJwMXlQlIPCsTLSoUqM/uRJn9WnviUMcxto+B
         W0+F7oeKoAy1gfUjtyr8hNRIiGDnRwVfygDk5yfRo88r49NqOVOl/f4ErVy40Bb1jQWD
         zjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNH1geTaFS8UgrJdKxdLAWd/njt1ov+nbcgh7oJT0rY=;
        b=Zi9PCd1kujQh841jwgmJRAJNi/VIz3WPI67S2sFcC/RNhYCM2EKGB2JW1oCDJYdFwf
         d7ztoDsWKqqSWjatIk8XuMYvYH0auwAawTxVTYbQAN1lc4RUuYLZRqKFV3/9Uzrh6oLU
         4u4Ve8EgOzh2CaKKDdmEGT/Ogg4EDIXfVskiZx5a045+1ZDtUDSRSWrX460usWnv12XG
         u1wyYrt8s0cVvCz9Ej+djd9BozGePQGwL4rz4b7rfksTPDG4jnv/Lj2zG4UBzmZ5wkYf
         AQ6SDY8hOsZd0bFYXj0ng9UfmU1BgnCOoztOVQRkloOowKEoUgopjtbHmQsXfGKJQWCG
         Q8Wg==
X-Gm-Message-State: AJIora/DI6jOCdpjWPzvvJSB8ud1t1FDAVbEhGEg7kpMBB9OKxV8g+aT
        sU1tLqP0X8DU3wjZNIafiLw2ZQ==
X-Google-Smtp-Source: AGRyM1uRQCdLusX8/Jae+V5XrhdfTKy0U5Q5Dq20Gv5hGNi+JheNXS9bP0mjHWaY7BqUTaz/Kqw2DA==
X-Received: by 2002:a05:600c:4e4a:b0:3a2:e29e:9a with SMTP id e10-20020a05600c4e4a00b003a2e29e009amr8825907wmq.138.1657494373220;
        Sun, 10 Jul 2022 16:06:13 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c460a00b003a03185231bsm5019981wmo.31.2022.07.10.16.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:12 -0700 (PDT)
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
Subject: [PATCH v2 7/7] iommu/exynos: Enable default VM instance on SysMMU v7
Date:   Mon, 11 Jul 2022 02:06:03 +0300
Message-Id: <20220710230603.13526-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
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

In order to enable SysMMU v7 with VM register layout, at least the
default VM instance (n=0) must be enabled, in addition to enabling the
SysMMU itself. To do so, add corresponding write to MMU_CTRL_VM[0]
register, before writing to MMU_CTRL register.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Extracted VM enabling code to the separate function
  - Used new SysMMU read/write functions to access the registers

 drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 64bf3331064f..2b333e137f57 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,8 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CTRL_VM_ENABLE			BIT(0)
+#define CTRL_VM_FAULT_MODE_STALL	BIT(3)
 #define CAPA0_CAPA1_EXIST		BIT(11)
 #define CAPA1_VCR_ENABLED		BIT(14)
 
@@ -183,6 +185,7 @@ enum {
 	IDX_FLUSH_END,
 	IDX_INT_STATUS,
 	IDX_INT_CLEAR,
+	IDX_CTRL_VM,
 	MAX_REG_IDX
 };
 
@@ -196,22 +199,22 @@ static const unsigned int sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
 	/* SysMMU v1..v3 */
 	{
 		0x00, 0x04, 0x08, 0x14, 0x0c, 0x10, 0x1, 0x1, 0x1,
-		0x18, 0x1c,
+		0x18, 0x1c, 0x1,
 	},
 	/* SysMMU v5 */
 	{
 		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
-		0x60, 0x64,
+		0x60, 0x64, 0x1,
 	},
 	/* SysMMU v7: Default register set (non-VM) */
 	{
 		0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x20, 0x24,
-		0x60, 0x64,
+		0x60, 0x64, 0x1,
 	},
 	/* SysMMU v7: VM capable register set */
 	{
 		0x00, 0x04, 0x08, 0x800c, 0x8010, 0x8014, 0x8018, 0x8020,
-		0x8024, 0x60, 0x64,
+		0x8024, 0x60, 0x64, 0x8000,
 	},
 };
 
@@ -567,6 +570,18 @@ static void __sysmmu_init_config(struct sysmmu_drvdata *data)
 	sysmmu_write(data, IDX_CFG, cfg);
 }
 
+static void __sysmmu_enable_vid(struct sysmmu_drvdata *data)
+{
+	u32 ctrl;
+
+	if (MMU_MAJ_VER(data->version) < 7 || !data->has_vcr)
+		return;
+
+	ctrl = sysmmu_read(data, IDX_CTRL_VM);
+	ctrl |= CTRL_VM_ENABLE | CTRL_VM_FAULT_MODE_STALL;
+	sysmmu_write(data, IDX_CTRL_VM, ctrl);
+}
+
 static void __sysmmu_enable(struct sysmmu_drvdata *data)
 {
 	unsigned long flags;
@@ -577,6 +592,7 @@ static void __sysmmu_enable(struct sysmmu_drvdata *data)
 	sysmmu_write(data, IDX_CTRL, CTRL_BLOCK);
 	__sysmmu_init_config(data);
 	__sysmmu_set_ptbase(data, data->pgtable);
+	__sysmmu_enable_vid(data);
 	sysmmu_write(data, IDX_CTRL, CTRL_ENABLE);
 	data->active = true;
 	spin_unlock_irqrestore(&data->lock, flags);
-- 
2.30.2

