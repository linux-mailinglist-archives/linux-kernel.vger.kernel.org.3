Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46F4CD8EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbiCDQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiCDQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:16:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87E1B8CB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:15:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ay10so13432955wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5BQTOw/sXp3TYshwTZm9beWJAVLkCvWgXDxaIwyMSA=;
        b=dia3oXp7q/1VjrCfFLkAy+mPg5LwHgobOELdYWi3Z9dN6Shze/dwz/uopWDUgcShMT
         LWmn7K89YF9pI7AbweONu4D6ImhQY7kdEKga7xxDUMMmLWf+4+pIW0d/XjSVt7VteyCj
         sFaT+UD8QFdcYk7jfAImoFpyEuGxAskWUOkxEC/qQc2V1uIljxXLI6k4vg0w7k2Wr3ct
         JPzgjgdLxUeVYY2IRM6RjU+Tyo2eB1rzhIr1uJLJmvyjj9Pp62FqAIy6SaZkQj9YUi7Y
         yJSre1ellL7hMYy60GkcVEJmkY4x5M2yO0WC5pzb+KbrkLIU73Ci5tWsp56jpRCrSk4g
         gz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5BQTOw/sXp3TYshwTZm9beWJAVLkCvWgXDxaIwyMSA=;
        b=i5+kPt4jlBsU/+b2uVe/UdR3sAGAahDXu++u2iRveq+YpmrnPCxG5NrKRo6xVLpo3V
         UvaxzjfcWGEb1Dl7a6BTsCp+9AiVw1tvNa4ASamXUGjZKO8RvUgIIM9ItUJaIbNnbFzV
         NIL6B69qKI1nEobdKX2Vc6b1fqkguZJajdOrJO5MVinsibVotctBua4+j2MsxGG02MHy
         u3uYtd9/kblagi6FQdCUTsjI01Zb/CjvVyKPTurf7wIkUgFRhPceSJcXZZtjjeklLSeH
         FSFUzlTyKc7gi5ssQlUw7k4qmBEjL7oHgx4WiQJfFd153+8KxbHTh46OyCA8L3+/iYAx
         jCEg==
X-Gm-Message-State: AOAM530u9FjgBpk1UEzYco+vBD3IUc7QCwaTi9STCB/Lb6EkjpriTnYW
        x6FHN1cnEVyLLtEf55bxzdbYDg==
X-Google-Smtp-Source: ABdhPJy3avM7h1zWOCFAbWXeckRHWDmyJ1lmQgTKMw5y5k07tM3CGmgyGL90bbNcQ5hbA47XiHbodg==
X-Received: by 2002:adf:f34c:0:b0:1ef:fde2:6d83 with SMTP id e12-20020adff34c000000b001effde26d83mr15098505wrp.637.1646410528617;
        Fri, 04 Mar 2022 08:15:28 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm4937307wrv.79.2022.03.04.08.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:15:28 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or
Cc:     matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 3/7] remoteproc: Add a remoteproc driver for the MT8183's APU
Date:   Fri,  4 Mar 2022 17:15:10 +0100
Message-Id: <20220304161514.994128-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304161514.994128-1-abailon@baylibre.com>
References: <20220304161514.994128-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver to control the APU present in the MT8183.
This loads the firmware and start the DSP.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/remoteproc/Kconfig   |  10 +
 drivers/remoteproc/Makefile  |   1 +
 drivers/remoteproc/mtk_apu.c | 486 +++++++++++++++++++++++++++++++++++
 3 files changed, 497 insertions(+)
 create mode 100644 drivers/remoteproc/mtk_apu.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 341156e2a29b..959d24e9492c 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -64,6 +64,16 @@ config MTK_SCP
 
 	  It's safe to say N here.
 
+config MTK_APU
+	tristate "Mediatek APU remoteproc support"
+	depends on ARCH_MEDIATEK
+	depends on MTK_IOMMU
+	help
+	  Say y to support the Mediatek's AI Processing Unit (APU) via
+	  the remote processor framework.
+
+	  It's safe to say N here.
+
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
 	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 0ac256b6c977..0ab4461c33af 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
 obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
 obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
+obj-$(CONFIG_MTK_APU)			+= mtk_apu.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
new file mode 100644
index 000000000000..867b4682b507
--- /dev/null
+++ b/drivers/remoteproc/mtk_apu.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 BayLibre SAS
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/string.h>
+
+#include "remoteproc_internal.h"
+
+#define SW_RST					(0x0000000C)
+#define SW_RST_OCD_HALT_ON_RST			BIT(12)
+#define SW_RST_IPU_D_RST			BIT(8)
+#define SW_RST_IPU_B_RST			BIT(4)
+#define CORE_CTRL				(0x00000110)
+#define CORE_CTRL_PDEBUG_ENABLE			BIT(31)
+#define CORE_CTRL_SRAM_64K_iMEM			(0x00 << 27)
+#define CORE_CTRL_SRAM_96K_iMEM			(0x01 << 27)
+#define CORE_CTRL_SRAM_128K_iMEM		(0x02 << 27)
+#define CORE_CTRL_SRAM_192K_iMEM		(0x03 << 27)
+#define CORE_CTRL_SRAM_256K_iMEM		(0x04 << 27)
+#define CORE_CTRL_PBCLK_ENABLE			BIT(26)
+#define CORE_CTRL_RUN_STALL			BIT(23)
+#define CORE_CTRL_STATE_VECTOR_SELECT		BIT(19)
+#define CORE_CTRL_PIF_GATED			BIT(17)
+#define CORE_CTRL_NMI				BIT(0)
+#define CORE_XTENSA_INT				(0x00000114)
+#define CORE_CTL_XTENSA_INT			(0x00000118)
+#define CORE_DEFAULT0				(0x0000013C)
+#define CORE_DEFAULT0_QOS_SWAP_0		(0x00 << 28)
+#define CORE_DEFAULT0_QOS_SWAP_1		(0x01 << 28)
+#define CORE_DEFAULT0_QOS_SWAP_2		(0x02 << 28)
+#define CORE_DEFAULT0_QOS_SWAP_3		(0x03 << 28)
+#define CORE_DEFAULT0_ARUSER_USE_IOMMU		(0x10 << 23)
+#define CORE_DEFAULT0_AWUSER_USE_IOMMU		(0x10 << 18)
+#define CORE_DEFAULT1				(0x00000140)
+#define CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
+#define CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
+#define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
+
+#define VDEV_MEM_COUNT				(3)
+
+#define APU_RESET_DELAY				(27)
+
+struct mtk_apu_rproc {
+	struct device *dev;
+	void __iomem *base;
+	int irq;
+	unsigned int num_clks;
+	struct clk_bulk_data *clks;
+	struct iommu_domain *domain;
+	struct list_head mappings;
+};
+
+static const char * const mt8183_clk_names[] = {
+	"ipu",
+	"axi",
+	"jtag"
+};
+
+static int mtk_apu_iommu_map(struct rproc *rproc, struct rproc_mem_entry *entry)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	struct rproc_mem_entry *mapping;
+	int ret;
+	u64 pa;
+
+	/* vdev buffer and vring are already mapped */
+	if (strstr(entry->name, "vdev"))
+		return 0;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return -ENOMEM;
+
+	if (!entry->va)
+		pa = entry->dma;
+	else
+		pa = rproc_va_to_pa(entry->va);
+
+	ret = iommu_map(apu_rproc->domain, entry->da, pa, entry->len, entry->flags);
+	if (ret) {
+		dev_err(dev, "iommu_map failed: %d\n", ret);
+		goto free_mapping;
+	}
+
+	mapping->da = entry->da;
+	mapping->len = entry->len;
+	list_add_tail(&mapping->node, &apu_rproc->mappings);
+
+	return 0;
+
+free_mapping:
+	kfree(mapping);
+
+	return ret;
+}
+
+static void mtk_apu_iommu_unmap_all(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	struct rproc_mem_entry *entry, *tmp;
+
+	/* clean up iommu mapping entries */
+	list_for_each_entry_safe(entry, tmp, &apu_rproc->mappings, node) {
+		size_t unmapped;
+
+		unmapped = iommu_unmap(apu_rproc->domain, entry->da, entry->len);
+		if (unmapped != entry->len) {
+			/* nothing much to do besides complaining */
+			dev_err(dev, "failed to unmap %zx/%zu\n", entry->len,
+				unmapped);
+		}
+
+		list_del(&entry->node);
+		kfree(entry);
+	}
+}
+
+static int mtk_apu_rproc_alloc_carveout(struct rproc *rproc,
+					struct rproc_mem_entry *mem)
+{
+	int flags = IOMMU_READ | IOMMU_READ | IOMMU_NOEXEC;
+	struct device *dev = rproc->dev.parent;
+	int ret;
+
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	mem->va = memremap(mem->dma, mem->len, MEMREMAP_WC);
+	if (IS_ERR_OR_NULL(mem->va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%zu\n",
+			&mem->dma, mem->len);
+		return PTR_ERR(mem->va);
+	}
+
+	ret = iommu_map(domain, mem->da, mem->dma, mem->len, flags);
+	if (ret)
+		memunmap(mem->va);
+
+	return 0;
+}
+
+static int mtk_apu_rproc_release_carveout(struct rproc *rproc,
+					  struct rproc_mem_entry *mem)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	struct device *dev = apu_rproc->dev;
+	struct iommu_domain *domain;
+	size_t unmapped;
+
+	domain = iommu_get_domain_for_dev(dev);
+	unmapped = iommu_unmap(domain, mem->da, mem->len);
+	if (unmapped != mem->len) {
+		/* nothing much to do besides complaining */
+		dev_err(dev, "failed to unmap %zx/%zu\n", mem->len, unmapped);
+	}
+	memunmap(mem->va);
+
+	return 0;
+}
+
+static int mtk_apu_rproc_vdev_mem_init(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	struct device *dev = apu_rproc->dev;
+	struct device_node *np = dev->of_node;
+	struct reserved_mem *rmem;
+	struct rproc_mem_entry *mem;
+	u32 da[VDEV_MEM_COUNT];
+	int ret;
+	int i;
+
+	ret = of_property_read_u32_array(np, "memory-region-da", da, VDEV_MEM_COUNT);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < VDEV_MEM_COUNT; i++) {
+		struct device_node *target;
+		char *name;
+
+		target = of_parse_phandle(np, "memory-region", i);
+		if (!target)
+			return -EINVAL;
+
+		rmem = of_reserved_mem_lookup(target);
+		of_node_put(target);
+
+		if (!rmem)
+			return -ENOMEM;
+
+		ret = strcspn(rmem->name, "@");
+		if (!ret)
+			return -EINVAL;
+
+		name = kstrndup(rmem->name, ret, GFP_KERNEL);
+		if (!name)
+			return -ENOMEM;
+
+		mem = rproc_mem_entry_init(dev, NULL, rmem->base, rmem->size,
+					   da[i],
+					   mtk_apu_rproc_alloc_carveout,
+					   mtk_apu_rproc_release_carveout,
+					   name);
+		kfree(name);
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+	}
+
+	return 0;
+}
+
+static int mtk_apu_rproc_prepare(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(apu_rproc->num_clks, apu_rproc->clks);
+	if (ret)
+		dev_err(apu_rproc->dev, "Failed to enable clocks\n");
+
+	ret = mtk_apu_rproc_vdev_mem_init(rproc);
+	if (ret) {
+		dev_err(apu_rproc->dev, "Failed to init vdev memory\n");
+		clk_bulk_disable_unprepare(apu_rproc->num_clks, apu_rproc->clks);
+
+	}
+
+	return ret;
+}
+
+static int mtk_apu_rproc_unprepare(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+
+	clk_bulk_disable_unprepare(apu_rproc->num_clks, apu_rproc->clks);
+
+	return 0;
+}
+
+static int mtk_apu_rproc_start(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	u32 core_ctrl;
+
+	/* Set reset vector of APU firmware boot address */
+	writel(rproc->bootaddr, apu_rproc->base + CORE_XTENSA_ALTRESETVEC);
+
+	/* Turn on the clocks and stall the APU */
+	core_ctrl = readl(apu_rproc->base + CORE_CTRL);
+	core_ctrl |= CORE_CTRL_PDEBUG_ENABLE | CORE_CTRL_PBCLK_ENABLE |
+		     CORE_CTRL_STATE_VECTOR_SELECT | CORE_CTRL_RUN_STALL |
+		     CORE_CTRL_PIF_GATED;
+	writel(core_ctrl, apu_rproc->base + CORE_CTRL);
+
+	/* Reset the APU: this requires 27 ns to be effective on any platform */
+	writel(SW_RST_OCD_HALT_ON_RST | SW_RST_IPU_B_RST | SW_RST_IPU_D_RST,
+		apu_rproc->base + SW_RST);
+	ndelay(APU_RESET_DELAY);
+	writel(0, apu_rproc->base + SW_RST);
+
+	core_ctrl &= ~CORE_CTRL_PIF_GATED;
+	writel(core_ctrl, apu_rproc->base + CORE_CTRL);
+
+	/* Configure memory accesses to go through the IOMMU */
+	writel(CORE_DEFAULT0_AWUSER_USE_IOMMU | CORE_DEFAULT0_ARUSER_USE_IOMMU |
+	      CORE_DEFAULT0_QOS_SWAP_1, apu_rproc->base + CORE_DEFAULT0);
+	writel(CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
+		CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU,
+		apu_rproc->base + CORE_DEFAULT1);
+
+	/* Release the APU */
+	core_ctrl &= ~CORE_CTRL_RUN_STALL;
+	writel(core_ctrl, apu_rproc->base + CORE_CTRL);
+
+	return 0;
+}
+
+static int mtk_apu_rproc_stop(struct rproc *rproc)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+	u32 core_ctrl;
+
+	core_ctrl = readl(apu_rproc->base + CORE_CTRL);
+	writel(core_ctrl | CORE_CTRL_RUN_STALL, apu_rproc->base + CORE_CTRL);
+
+	mtk_apu_iommu_unmap_all(rproc);
+
+	return 0;
+}
+
+static void mtk_apu_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct mtk_apu_rproc *apu_rproc = rproc->priv;
+
+	writel(1 << vqid, apu_rproc->base + CORE_CTL_XTENSA_INT);
+}
+
+static int mtk_apu_load(struct rproc *rproc, const struct firmware *fw)
+
+{
+	struct rproc_mem_entry *entry, *tmp;
+	int ret;
+
+	ret = rproc_elf_load_segments(rproc, fw);
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(entry, tmp, &rproc->carveouts, node) {
+		ret = mtk_apu_iommu_map(rproc, entry);
+		if (ret)
+			goto err_unmap_all;
+	}
+
+	return 0;
+
+err_unmap_all:
+	mtk_apu_iommu_unmap_all(rproc);
+
+	return ret;
+}
+
+static const struct rproc_ops mtk_apu_rproc_ops = {
+	.prepare		= mtk_apu_rproc_prepare,
+	.unprepare		= mtk_apu_rproc_unprepare,
+	.start			= mtk_apu_rproc_start,
+	.stop			= mtk_apu_rproc_stop,
+	.kick			= mtk_apu_rproc_kick,
+	.load			= mtk_apu_load,
+	.parse_fw		= rproc_elf_load_rsc_table,
+	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
+	.sanity_check		= rproc_elf_sanity_check,
+	.get_boot_addr		= rproc_elf_get_boot_addr,
+};
+
+static irqreturn_t mtk_apu_rproc_callback(int irq, void *data)
+{
+	struct rproc *rproc = data;
+	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
+
+	writel(1, apu_rproc->base + CORE_XTENSA_INT);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int mtk_apu_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_apu_rproc *apu_rproc;
+	struct rproc *rproc;
+	struct resource *res;
+	int ret;
+	int i;
+
+	ret = of_property_count_elems_of_size(dev->of_node, "memory-region",
+					      sizeof(phandle));
+	if (ret != VDEV_MEM_COUNT)
+		return -EINVAL;
+
+	ret = of_property_count_elems_of_size(dev->of_node, "memory-region-da",
+					      sizeof(u32));
+	if (ret != VDEV_MEM_COUNT)
+		return -EINVAL;
+
+	rproc = rproc_alloc(dev, dev_name(dev), &mtk_apu_rproc_ops, NULL,
+			    sizeof(*apu_rproc));
+	if (!rproc)
+		return -ENOMEM;
+
+	rproc->recovery_disabled = true;
+	rproc->has_iommu = false;
+	rproc->auto_boot = false;
+
+	apu_rproc = rproc->priv;
+	apu_rproc->dev = dev;
+	INIT_LIST_HEAD(&apu_rproc->mappings);
+
+	platform_set_drvdata(pdev, rproc);
+
+	apu_rproc->domain = iommu_get_domain_for_dev(dev);
+	if (!apu_rproc->domain) {
+		ret = -ENODEV;
+		goto free_rproc;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	apu_rproc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(apu_rproc->base)) {
+		dev_err(dev, "Failed to map mmio\n");
+		ret = PTR_ERR(apu_rproc->base);
+		goto free_rproc;
+	}
+
+	apu_rproc->irq = platform_get_irq(pdev, 0);
+	if (apu_rproc->irq < 0) {
+		ret = apu_rproc->irq;
+		goto free_rproc;
+	}
+
+	apu_rproc->domain = iommu_get_domain_for_dev(dev);
+	if (!apu_rproc->domain) {
+		ret = -ENODEV;
+		goto free_rproc;
+	}
+
+	ret = devm_request_threaded_irq(dev, apu_rproc->irq,
+					mtk_apu_rproc_callback, handle_event,
+					IRQF_SHARED | IRQF_ONESHOT,
+					NULL, rproc);
+	if (ret) {
+		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
+		goto free_rproc;
+	}
+
+	apu_rproc->num_clks = ARRAY_SIZE(mt8183_clk_names);
+	apu_rproc->clks = devm_kcalloc(dev, apu_rproc->num_clks,
+				     sizeof(*apu_rproc->clks), GFP_KERNEL);
+	for (i = 0; i < apu_rproc->num_clks; ++i)
+		apu_rproc->clks[i].id = mt8183_clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, apu_rproc->num_clks, apu_rproc->clks);
+	if (ret) {
+		dev_err(dev, "Failed to get clocks\n");
+		goto free_rproc;
+	}
+
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "rproc_add failed: %d\n", ret);
+		goto free_rproc;
+	}
+
+	return 0;
+
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int mtk_apu_rproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
+	struct device *dev = &pdev->dev;
+
+	disable_irq(apu_rproc->irq);
+
+	rproc_del(rproc);
+	of_reserved_mem_device_release(dev);
+	rproc_free(rproc);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_apu_rproc_of_match[] = {
+	{ .compatible = "mediatek,mt8183-apu", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_apu_rproc_of_match);
+
+static struct platform_driver mtk_apu_rproc_driver = {
+	.probe = mtk_apu_rproc_probe,
+	.remove = mtk_apu_rproc_remove,
+	.driver = {
+		.name = "mtk_apu-rproc",
+		.of_match_table = of_match_ptr(mtk_apu_rproc_of_match),
+	},
+};
+module_platform_driver(mtk_apu_rproc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Alexandre Bailon");
+MODULE_DESCRIPTION("MTK APU Remote Processor control driver");
-- 
2.34.1

