Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0E5873C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 00:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiHAWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbiHAWJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 18:09:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F0A41D15;
        Mon,  1 Aug 2022 15:09:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so13487550pjf.2;
        Mon, 01 Aug 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RU1FbrBJr/X5C2fv3CbgZ52enehMfwrLIwTRu81oqKc=;
        b=Fc7B2ZUd5A9TsCrmOgh15oxPJycZWjrMCLB66jLJmfpMyUjTYJMv6NDPJrBQXwUi0v
         cwVAupmkKQ3of4+CBkN5ocbHbNIGpfLUH/dAcEwd667vpI78cN2bPvKxvgb9cAbnnJUv
         oLTSfsrI9sUeNvxvJigyalzmLGOPVXeQygA0HGtL8NkIAzLQcQI1RWo3oPtC0QGMg8Z8
         /RnZEljK63wbrKo5Pv7easYRTVshnPjUT0eIv70hDOvlqGuT0/i3mdnTipec8UVxOfSt
         d0DSqiO12X2of455kwFEY+jc+bsin1YRSK+1PlUj1EDCEw1E8fJH7Xar6wKdLtxteQp+
         nsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RU1FbrBJr/X5C2fv3CbgZ52enehMfwrLIwTRu81oqKc=;
        b=rR/SbyNhTmrEoc83ClYSQB29XwPoOK6gaDPW6L+dZ/B1pnmz/+NOHlrIzaihM3f3Z6
         SmcPqX9mypo2IssLdK93OFmeFzBTtquyhPTj8/YQgCcJtPnb9WqF1EbD0lB4XNjVhnJp
         HtrfJlmV+vNXckAom81rcT76ajLZGtGC/9IdRZGh/TErNN3LSkfCmo8HJSEW68j+3Sh9
         m1P1IRDskuTDO/J7ogHRZ+zD0WqNHNIWDzepoWt9TQof+1cTtt0Z+N2DwidfcZ3Es2F+
         hymlrcuXFagJN7as2yT8XFZpqTD2PwfNCr8RbG2T9PLnvffBamq+FrHrsxdBBXMRJbh3
         3Qdg==
X-Gm-Message-State: ACgBeo32u4LbVvBg1O7w2VV4/B2ond1mhP1BkxeDtFAfazlnyHeN/gHG
        +NsNzyTJDS/uXbjRj0sP6IDwMVKxcIA=
X-Google-Smtp-Source: AA6agR7fQ51Q+/e1LAipO+90SGxf2M8RCI9fN2hScWp2XrH8xA9CixtfVcY0i4Zibqp6YvfpnUTLsw==
X-Received: by 2002:a17:902:8302:b0:16d:d74f:e5cc with SMTP id bd2-20020a170902830200b0016dd74fe5ccmr16012360plb.6.1659391777953;
        Mon, 01 Aug 2022 15:09:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001637529493esm10136969plq.66.2022.08.01.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:09:37 -0700 (PDT)
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
Subject: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Date:   Mon,  1 Aug 2022 15:09:31 -0700
Message-Id: <20220801220931.181531-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801220931.181531-1-f.fainelli@gmail.com>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
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
 drivers/memory/brcmstb_memc.c | 302 ++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
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
index 000000000000..9b993343d447
--- /dev/null
+++ b/drivers/memory/brcmstb_memc.c
@@ -0,0 +1,302 @@
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
+		.owner		= THIS_MODULE,
+		.of_match_table	= brcmstb_memc_of_match,
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

