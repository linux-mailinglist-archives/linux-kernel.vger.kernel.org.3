Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A557E6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiGVSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiGVSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:41:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF438734C;
        Fri, 22 Jul 2022 11:41:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so8882428pjq.4;
        Fri, 22 Jul 2022 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5Xsj66xxsI8UZs+AVns8DSIdMWqwjaUdpUS2P9wJnY=;
        b=fNEcOHQ7HWXM6gS95YYCZ5vn5e/Ehuvl+K76mGVCjrhL/cB8j/iHUYMl/3gm4tQPZJ
         CQA9JRrc4M+CKtzmDtvLf4HLqAVv/VJHSbIxwxrwmwI/BbuxxrMf/tkjiLBDkSNdQfpS
         s2ukdA/ZB69rquwgs+xsvfQkSGNiVkOOUbeXXcL/rccmsy8c/kOrbwSgD+4dhIA1z6QQ
         CZM6EnZdOdcE+7jfnte8Q5wisoD5P3sxmHQLIZt8xYx8GnG+kOuiWlUHLR77pSTct+/Q
         i/462QSpmpnUNl3swtGTSmPQsWJuv5AAWg7Zl6yyLe1C/1Mri4+tNsCRRSakf8OJHvO9
         +OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5Xsj66xxsI8UZs+AVns8DSIdMWqwjaUdpUS2P9wJnY=;
        b=uFhuuqGMHBS+xGaCvExfMylzGYNKWMKMHRden4cq7tPWx3kbcuv3Q2FmS2TWCm59oq
         8YRWBM6jR5jGyyEqQKnauTnyhWHYI4fy+0YKCaKSJEZdHd4B/jTeiptL9DxuRf2b26jz
         ArIK9qxXpKQCCf8Ehji33cgluy0ad9YIC9wjXia+s2BzBo0LE31r10EqbTUoow/p+KUs
         p+PuqTwt4J6mY0FJt0Tswf4jniBx5j9X2ksI/3iauiyyt2PU0ktiGhKQo6na8U8dNH22
         keIfXjkZCY5pwE0ANg5n+O9dBNr4YiwM08trMjrfxQ8FhPrOrUohLfGAms6ifCTOkAVA
         g2Pw==
X-Gm-Message-State: AJIora/2WjVeR0/HYvzUIzY0CEwTMbtRGO8BlreKw8GVU0ZN8O2UrOI0
        MeCbjvZuZ9gj9+9e7VUcBSyMOhbgxLQ=
X-Google-Smtp-Source: AGRyM1t+RNULRgXeo5W7u1cUgfEXfTrkNxMxLtd06HvttxsDE1MeHr2HpCk7m3bOx6NDFHyl00FMZA==
X-Received: by 2002:a17:90b:4a8c:b0:1f2:4736:e75e with SMTP id lp12-20020a17090b4a8c00b001f24736e75emr5960645pjb.239.1658515305728;
        Fri, 22 Jul 2022 11:41:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016c9e5f291bsm675976plg.111.2022.07.22.11.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:41:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 3/3] memory: Add Broadcom STB memory controller driver
Date:   Fri, 22 Jul 2022 11:41:38 -0700
Message-Id: <20220722184138.2666241-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722184138.2666241-1-f.fainelli@gmail.com>
References: <20220722184138.2666241-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/memory/brcmstb_memc.c | 304 ++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
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
index 000000000000..881da958c542
--- /dev/null
+++ b/drivers/memory/brcmstb_memc.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DDR Self-Refresh Power Down (SRPD) support for Broadcom STB SoCs
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/io.h>
+
+#define REG_MEMC_CNTRLR_CONFIG		0x00
+#define  CNTRLR_CONFIG_LPDDR4		5
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
+	return reg == CNTRLR_CONFIG_LPDDR4;
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
+		val |= (1 << SRPD_EN_SHIFT);
+
+	writel_relaxed(val, cfg);
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
+	/* Cannot change the inactivity timeout on LPDDR4 chips because the
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
+	struct resource *res;
+	int ret;
+
+	memc = devm_kzalloc(dev, sizeof(*memc), GFP_KERNEL);
+	if (!memc)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, memc);
+
+	of_id = of_match_device(brcmstb_memc_of_match, dev);
+	if (!of_id || !of_id->data)
+		return -EINVAL;
+
+	memc_data = of_id->data;
+	memc->srpd_offset = memc_data->srpd_offset;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	memc->ddr_ctrl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(memc->ddr_ctrl))
+		return PTR_ERR(memc->ddr_ctrl);
+
+	of_property_read_u32(pdev->dev.of_node, "clock-frequency",
+			     &memc->frequency);
+
+	ret = sysfs_create_group(&dev->kobj, &dev_attr_group);
+	if (ret) {
+		dev_err(dev, "failed to create attribute group (%d)\n", ret);
+		return ret;
+	}
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
+	/* Disable SPRD prior to suspending the system since that can
+	 * cause issues with e.g: XPT_DMA trying to hash memory
+	 */
+	val = readl_relaxed(cfg);
+	val &= ~(1 << SRPD_EN_SHIFT);
+	writel_relaxed(val, cfg);
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
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(brcmstb_memc_of_match),
+		.pm		= &brcmstb_memc_pm_ops,
+	},
+};
+module_platform_driver(brcmstb_memc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("DDR SRPD driver for Broadcom STB chips");
-- 
2.25.1

