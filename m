Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA925642EA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGBVhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiGBVhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:37:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54AB878
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:37:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fw3so10017567ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjkLlnpo3rJV91gWG5Ub4TjaCmhb4e/5Gjwv7rGBuNk=;
        b=BqX0hBiyoAeYzJvTN5zLo10CPIik6CQ1uuNpCfO3oq+RooTR3lviNeDHJH/TUUuJKS
         wUSkXeozyQgNLTM/cvKl2jPJTrzSH0myVq5M75OZivSySF+gkQJ24NlIDVVgrMbqLVGX
         wkH/4iI0lA4+uHrtf1nuF5wtDyjpFzVf22KES+ZXA7mX/AmqqcIl6kcFyx2NZ2gOLDlt
         p9mSagqMQh+9sF09gikAhlQeJfk12Cqxl0F9W852boCwBSMqhYRwIUoyGMhDm7HXBKL7
         g2SABFfGTM0PskN5Bd0582SNluuYumuv8oc6R2l95M6DBu0m7EL/q/aAicGaXR/wWln5
         Y6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjkLlnpo3rJV91gWG5Ub4TjaCmhb4e/5Gjwv7rGBuNk=;
        b=eUUa5JnDixqzgboDLgt46Xvpp8iDZT3JmurC2lilnW2XQs5DrS4lQM2VbqvQVYB++s
         H5rnixScBFgHGTcDFB56cmShUFeKVtdS8xX4W/6ylwpwFGZ63Z+hBxmGRrKPRjqVjYb8
         DeCLNRhEFw/ic9Xpi2gGPj3qZhEajAcPmJmZndAJbrW79TNDI4D/LuOUJ3rWKDP1ZOzu
         khA4nZ1JUDMqBbBZKm3CBajTHY7ZZshmajibd18VewNJEYhfGDn4CGN7U8Y5TQYWyKXE
         mq4lIpjzdNVBlxxlJdK+660fAFx1STuXqKPr87sBdvQK9LuxUaWZVthJzBtAzf+vIlyy
         nwxw==
X-Gm-Message-State: AJIora/sNXzjppiIWQ8tnoYnKJeq/XBDVT2uPFPLVaa4wMzfKsCj8khE
        Jnf0kykSL37tQbQ1vZQ6KpAp4w==
X-Google-Smtp-Source: AGRyM1tIDyoc701JH7tqf6GG8NYNGAr1P57wdNbZb5l5imY87uRjSo8YlTS/OW6VjdvCTXTf8Tu4AA==
X-Received: by 2002:a17:906:8a53:b0:72a:8a2d:db61 with SMTP id gx19-20020a1709068a5300b0072a8a2ddb61mr10421953ejc.674.1656797848790;
        Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id lo17-20020a170906fa1100b0072696b3a327sm9436558ejb.187.2022.07.02.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iommu/exynos: Use lookup based approach to access v7 registers
Date:   Sun,  3 Jul 2022 00:37:23 +0300
Message-Id: <20220702213724.3949-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
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

SysMMU v7 might have different register layouts (VM capable or non-VM
capable). Check which layout is implemented in current SysMMU module and
prepare the corresponding register table for futher usage. This way is
faster and more elegant than checking corresponding condition (if it's
VM or non-VM SysMMU) each time before accessing v7 registers. For now
the register table contains only most basic registers needed to add the
SysMMU v7 support.

This patch is based on downstream work of next authors:
  - Janghyuck Kim <janghyuck.kim@samsung.com>
  - Daniel Mentz <danielmentz@google.com>

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index df6ddbebbe2b..47017e8945c5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -180,6 +180,47 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
+#define MMU_REG(data, idx)		\
+	((data)->sfrbase + (data)->regs[idx].off)
+#define MMU_VM_REG(data, idx, vmid)	\
+	(MMU_REG(data, idx) + (vmid) * (data)->regs[idx].mult)
+
+enum {
+	REG_SET_NON_VM,
+	REG_SET_VM,
+	MAX_REG_SET
+};
+
+enum {
+	IDX_CTRL_VM,
+	IDX_CFG_VM,
+	IDX_FLPT_BASE,
+	IDX_ALL_INV,
+	MAX_REG_IDX
+};
+
+struct sysmmu_vm_reg {
+	unsigned int off;	/* register offset */
+	unsigned int mult;	/* VM index offset multiplier */
+};
+
+static const struct sysmmu_vm_reg sysmmu_regs[MAX_REG_SET][MAX_REG_IDX] = {
+	/* Default register set (non-VM) */
+	{
+		/*
+		 * SysMMUs without VM support do not have CTRL_VM and CFG_VM
+		 * registers. Setting the offsets to 1 will trigger an unaligned
+		 * access exception.
+		 */
+		{0x1}, {0x1}, {0x000c}, {0x0010},
+	},
+	/* VM capable register set */
+	{
+		{0x8000, 0x1000}, {0x8004, 0x1000}, {0x800c, 0x1000},
+		{0x8010, 0x1000},
+	},
+};
+
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
 static sysmmu_pte_t *zero_lv2_table;
@@ -284,6 +325,7 @@ struct sysmmu_drvdata {
 
 	/* v7 fields */
 	bool has_vcr;			/* virtual machine control register */
+	const struct sysmmu_vm_reg *regs; /* register set */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -407,6 +449,10 @@ static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
 	__sysmmu_get_version(data);
 	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
 		__sysmmu_get_vcr(data);
+	if (data->has_vcr)
+		data->regs = sysmmu_regs[REG_SET_VM];
+	else
+		data->regs = sysmmu_regs[REG_SET_NON_VM];
 
 	__sysmmu_disable_clocks(data);
 }
-- 
2.30.2

