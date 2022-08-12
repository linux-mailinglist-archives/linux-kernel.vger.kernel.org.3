Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0291B5914D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiHLRcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiHLRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:31:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260C5A74CD;
        Fri, 12 Aug 2022 10:31:38 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id m10so1103857qvu.4;
        Fri, 12 Aug 2022 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cnGlLj7kED+0umSEXRpR16vGmIvX7t6d2KRAOcwODhM=;
        b=MGA99ssFFqlEVlrOGCKGkOxcIkvMYXSafVJRuJkbjSRW6ZQZXrQO8bH63MLzzAWuj3
         0sZrhgA/IjEywdx7USDWyWU8kkDXua6VydU9Yppf2xRoowV+uAmM4y/MtIAQO1wmj3Le
         zD1rUnbLmwqudrVN/kZjkUzxs2pqTplH8tpwsrgAXLafKuv8br//BydSOucAwCaRux++
         AUpWd0qSRIOtM61n+ZPxIys/chEzTPXBtqfha5sG7el0HeePfiUl4UF+wI9GqlaenAPm
         dB6zilZYacmosdv2m+fGOBq0LkCdWNTTInb9MuNdDU34ISpoNmk/ZWzSiNZLAkffZLlP
         yRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cnGlLj7kED+0umSEXRpR16vGmIvX7t6d2KRAOcwODhM=;
        b=GeUS/h1j3cBRlANbXlWY/1Vx8ww81glVdOauKvfkwbja8Gs8wgw2k9vKvayLJELGXK
         3eLwluDxpO8HaT7Gpy6nKv2TXSFVzliqZ4ni3HCOfNv44K00YZtF99XOcdK08rAJJNEy
         jxFBCWolscvX4FsOGCnv8AVikhp+5eztwq9Bfpn7KPh2edzsi52mX3t/zrkBk53B5elF
         lfpiaLm8AjHVBslW5MptCisBuoVMiYeqVJ2js5JCe5NB603c1p50mal38uF6GOiDqhns
         GBfveimbRlC36HJfXAOPu8rWS+gUta7xvZRiqeVPK7q/N1ETZMa/2r4X+3WnLLT+u/0a
         gW+A==
X-Gm-Message-State: ACgBeo3db620u+ZFn4Z5hg7P6hhbzK4YJe+35bVtWPis+KBCkdZmr9b0
        ZulCzAQ+Q7drQ1C2wc32GU8iJJJAjO0=
X-Google-Smtp-Source: AA6agR5kfmGbiogVJ0hhJaTlzcrxGrG6qZnCaVjbES36ieV6xOVRdmh/miB/l4dHYh4ov9v1IfXaqQ==
X-Received: by 2002:a05:6214:d66:b0:476:a5d7:57e5 with SMTP id 6-20020a0562140d6600b00476a5d757e5mr4558989qvs.113.1660325496734;
        Fri, 12 Aug 2022 10:31:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t201-20020a37aad2000000b006b9b7879964sm2369300qke.28.2022.08.12.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:31:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v4 3/3] memory: Add Broadcom STB memory controller driver
Date:   Fri, 12 Aug 2022 10:31:25 -0700
Message-Id: <20220812173125.2410536-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812173125.2410536-1-f.fainelli@gmail.com>
References: <20220812173125.2410536-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring the Self Refresh Power Down (SRPD)
inactivity timeout on Broadcom STB chips. This is used to conserve power
when the DRAM activity is reduced.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/memory/Kconfig        |   9 +
 drivers/memory/Makefile       |   1 +
 drivers/memory/brcmstb_memc.c | 301 ++++++++++++++++++++++++++++++++++
 3 files changed, 311 insertions(+)
 create mode 100644 drivers/memory/brcmstb_memc.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index ac1a411648d8..fac290e48e0b 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -66,6 +66,15 @@ config BRCMSTB_DPFE
 	  for the DRAM's temperature. Slower refresh rate means cooler RAM,
 	  higher refresh rate means hotter RAM.
 
+config BRCMSTB_MEMC
+	tristate "Broadcom STB MEMC driver"
+	default ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	help
+	  This driver provides a way to configure the Broadcom STB memory
+	  controller and specifically control the Self Refresh Power Down
+	  (SRPD) inactivity timeout.
+
 config BT1_L2_CTL
 	bool "Baikal-T1 CM2 L2-RAM Cache Control Block"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index bc7663ed1c25..e148f636c082 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
 obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
 obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
+obj-$(CONFIG_BRCMSTB_MEMC)	+= brcmstb_memc.o
 obj-$(CONFIG_BT1_L2_CTL)	+= bt1-l2-ctl.o
 obj-$(CONFIG_TI_AEMIF)		+= ti-aemif.o
 obj-$(CONFIG_TI_EMIF)		+= emif.o
diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
new file mode 100644
index 000000000000..5705b346b1f5
--- /dev/null
+++ b/drivers/memory/brcmstb_memc.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DDR Self-Refresh Power Down (SRPD) support for Broadcom STB SoCs
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define REG_MEMC_CNTRLR_CONFIG		0x00
+#define  CNTRLR_CONFIG_LPDDR4_SHIFT	5
+#define  CNTRLR_CONFIG_MASK		0xf
+#define REG_MEMC_SRPD_CFG_21		0x20
+#define REG_MEMC_SRPD_CFG_20		0x34
+#define REG_MEMC_SRPD_CFG_1x		0x3c
+#define INACT_COUNT_SHIFT		0
+#define INACT_COUNT_MASK		0xffff
+#define SRPD_EN_SHIFT			16
+
+struct brcmstb_memc_data {
+	u32 srpd_offset;
+};
+
+struct brcmstb_memc {
+	struct device *dev;
+	void __iomem *ddr_ctrl;
+	unsigned int timeout_cycles;
+	u32 frequency;
+	u32 srpd_offset;
+};
+
+static int brcmstb_memc_uses_lpddr4(struct brcmstb_memc *memc)
+{
+	void __iomem *config = memc->ddr_ctrl + REG_MEMC_CNTRLR_CONFIG;
+	u32 reg;
+
+	reg = readl_relaxed(config) & CNTRLR_CONFIG_MASK;
+
+	return reg == CNTRLR_CONFIG_LPDDR4_SHIFT;
+}
+
+static int brcmstb_memc_srpd_config(struct brcmstb_memc *memc,
+				    unsigned int cycles)
+{
+	void __iomem *cfg = memc->ddr_ctrl + memc->srpd_offset;
+	u32 val;
+
+	/* Max timeout supported in HW */
+	if (cycles > INACT_COUNT_MASK)
+		return -EINVAL;
+
+	memc->timeout_cycles = cycles;
+
+	val = (cycles << INACT_COUNT_SHIFT) & INACT_COUNT_MASK;
+	if (cycles)
+		val |= BIT(SRPD_EN_SHIFT);
+
+	writel_relaxed(val, cfg);
+	/* Ensure the write is committed to the controller */
+	(void)readl_relaxed(cfg);
+
+	return 0;
+}
+
+static ssize_t frequency_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", memc->frequency);
+}
+
+static ssize_t srpd_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", memc->timeout_cycles);
+}
+
+static ssize_t srpd_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	/*
+	 * Cannot change the inactivity timeout on LPDDR4 chips because the
+	 * dynamic tuning process will also get affected by the inactivity
+	 * timeout, thus making it non functional.
+	 */
+	if (brcmstb_memc_uses_lpddr4(memc))
+		return -EOPNOTSUPP;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	ret = brcmstb_memc_srpd_config(memc, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(frequency);
+static DEVICE_ATTR_RW(srpd);
+
+static struct attribute *dev_attrs[] = {
+	&dev_attr_frequency.attr,
+	&dev_attr_srpd.attr,
+	NULL,
+};
+
+static struct attribute_group dev_attr_group = {
+	.attrs = dev_attrs,
+};
+
+static const struct of_device_id brcmstb_memc_of_match[];
+
+static int brcmstb_memc_probe(struct platform_device *pdev)
+{
+	const struct brcmstb_memc_data *memc_data;
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct brcmstb_memc *memc;
+	int ret;
+
+	memc = devm_kzalloc(dev, sizeof(*memc), GFP_KERNEL);
+	if (!memc)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, memc);
+
+	of_id = of_match_device(brcmstb_memc_of_match, dev);
+	memc_data = of_id->data;
+	memc->srpd_offset = memc_data->srpd_offset;
+
+	memc->ddr_ctrl = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(memc->ddr_ctrl))
+		return PTR_ERR(memc->ddr_ctrl);
+
+	of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+			     &memc->frequency);
+
+	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int brcmstb_memc_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	sysfs_remove_group(&dev->kobj, &dev_attr_group);
+
+	return 0;
+}
+
+enum brcmstb_memc_hwtype {
+	BRCMSTB_MEMC_V21,
+	BRCMSTB_MEMC_V20,
+	BRCMSTB_MEMC_V1X,
+};
+
+static const struct brcmstb_memc_data brcmstb_memc_versions[] = {
+	{ .srpd_offset = REG_MEMC_SRPD_CFG_21 },
+	{ .srpd_offset = REG_MEMC_SRPD_CFG_20 },
+	{ .srpd_offset = REG_MEMC_SRPD_CFG_1x },
+};
+
+static const struct of_device_id brcmstb_memc_of_match[] = {
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.1.x",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V1X]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.0",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V20]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.1",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.2",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.3",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.5",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.6",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.7",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.2.8",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.0",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-b.3.1",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.0",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.1",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.2",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.3",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	{
+		.compatible = "brcm,brcmstb-memc-ddr-rev-c.1.4",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V21]
+	},
+	/* default to the original offset */
+	{
+		.compatible = "brcm,brcmstb-memc-ddr",
+		.data = &brcmstb_memc_versions[BRCMSTB_MEMC_V1X]
+	},
+	{}
+};
+
+static int __maybe_unused brcmstb_memc_suspend(struct device *dev)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+	void __iomem *cfg = memc->ddr_ctrl + memc->srpd_offset;
+	u32 val;
+
+	if (memc->timeout_cycles == 0)
+		return 0;
+
+	/*
+	 * Disable SRPD prior to suspending the system since that can
+	 * cause issues with other memory clients managed by the ARM
+	 * trusted firmware to access memory.
+	 */
+	val = readl_relaxed(cfg);
+	val &= ~BIT(SRPD_EN_SHIFT);
+	writel_relaxed(val, cfg);
+	/* Ensure the write is committed to the controller */
+	(void)readl_relaxed(cfg);
+
+	return 0;
+}
+
+static int __maybe_unused brcmstb_memc_resume(struct device *dev)
+{
+	struct brcmstb_memc *memc = dev_get_drvdata(dev);
+
+	if (memc->timeout_cycles == 0)
+		return 0;
+
+	return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
+}
+
+static SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
+			 brcmstb_memc_resume);
+
+static struct platform_driver brcmstb_memc_driver = {
+	.probe = brcmstb_memc_probe,
+	.remove = brcmstb_memc_remove,
+	.driver = {
+		.name		= "brcmstb_memc",
+		.of_match_table	= brcmstb_memc_of_match,
+		.pm		= pm_ptr(&brcmstb_memc_pm_ops),
+	},
+};
+module_platform_driver(brcmstb_memc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("DDR SRPD driver for Broadcom STB chips");
-- 
2.25.1

