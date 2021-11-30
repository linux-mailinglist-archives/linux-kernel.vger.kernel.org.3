Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E85462A65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhK3C2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhK3C2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:28:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3654AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:24:56 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l7so38137005lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/IWZSOaKdk/mOrNyluTxke9aOsIgAwxOopRM0hhknc=;
        b=maMZCytHKi8n40D+z1hQwsNWujIV+kJeQxpQ7JezI1m0XYg9mEnIWnW4CRstMBl5VP
         A5tam4etyha6PzkeNAjdWO7qd0tBS6YGh9TZEtqGsWrH78mTpVmweocJ8KhgrEhNj2jg
         0+l2gP9epnjbM+Rg+dQqhDUQQrrwTPxGJ8LgEM3Wkn4qn7x4J1exlbzXgdvBurt6KYYy
         N21T/W8DoxdZmKoO+I4tW2iMEBfQC5JOLRAOFQMbORZe+gGocLpopl479+MzGY6/aGoW
         6EwYQ0rGyyD4p52AWxznTDwkJ1UGlV8rZyH6cus+EpVsrSmwxaMmM5JSltDcSskgVAuo
         6J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/IWZSOaKdk/mOrNyluTxke9aOsIgAwxOopRM0hhknc=;
        b=YdxxSJMWMIXhNDiE3zdiYy6VxAn6Y6jNmYXkw/CyUvrDdw0aPa1iz8+pRB2BnUK/h8
         YRE3qut2YJnvnJw84l9NZql6MR7omldQn4dmkXBsAYWDKVw/VY6YZVQkzAmxi9WDI43v
         VK12RGu/4qtsvb6ZhnTDUpcQr5HvTK4ZZGEOQnU0WVL1qj9PLKXe2AFStw2xgssi0XpI
         c2rmdXm71B4aPok9pzYYP0Y5jLp+chTRe2ZqkgpUxK0Nuut8zWrloPKI5MSPe/zHbbcW
         ZT0EIl95GFgn4/fZEIq/y7P9HO/xInweIjFi+edUmikBKAyyitr6Ra4mqTp5OfIqpbwn
         ioEQ==
X-Gm-Message-State: AOAM530fICtCnwipfdJWdjrPpPmmt+Cx5aunVJCn6rRRgiVoCWD/nfmg
        jV1xBaU5COZQQ/KPvlgvWF0YEA==
X-Google-Smtp-Source: ABdhPJyk1Y9orfUV6P3R4qlbXldagrKSa2FLHgi+CRTksLJHbpwDlxzvzf7nlQnq/V5xY0K/j2Le7Q==
X-Received: by 2002:a2e:93c6:: with SMTP id p6mr24387703ljh.476.1638239094452;
        Mon, 29 Nov 2021 18:24:54 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y20sm1541405lfk.231.2021.11.29.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:24:54 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 2/5] soc: samsung: Add USI driver
Date:   Tue, 30 Nov 2021 04:24:50 +0200
Message-Id: <20211130022453.28648-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
registers usually reside in the same register map as a particular
underlying protocol it implements, but have some particular offset. E.g.
on Exynos850 the USI_UART has 0x13820000 base address, where UART
registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
offsets. Desired protocol can be chosen via SW_CONF register from System
Register block of the same domain as USI.

Before starting to use a particular protocol, USIv2 must be configured
properly:
  1. Select protocol to be used via System Register
  2. Clear "reset" flag in USI_CON
  3. Configure HWACG behavior (e.g. for UART Rx the HWACG must be
     disabled, so that the IP clock is not gated automatically); this is
     done using USI_OPTION register
  4. Keep both USI clocks (PCLK and IPCLK) running during USI registers
     modification

This driver implements above behavior. Of course, USIv2 driver should be
probed before UART/I2C/SPI drivers. It can be achived by embedding
UART/I2C/SPI nodes inside of USI node (in Device Tree); driver then
walks underlying nodes and instantiates those. Driver also handles USI
configuration on PM resume, as register contents can be lost during CPU
suspend.

This driver is designed with different USI versions in mind. So it
should be relatively easy to add new USI revisions to it later.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Replaced arch_initcall() with module_platform_driver()
  - Reworked the whole driver for the easy adoption of other USI
    revisions
  - Added "mode" validation right after reading it from device tree
  - Handled new USI_V2_NONE value

 drivers/soc/samsung/Kconfig      |  14 ++
 drivers/soc/samsung/Makefile     |   2 +
 drivers/soc/samsung/exynos-usi.c | 274 +++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-usi.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index e2cedef1e8d1..a9f8b224322e 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -23,6 +23,20 @@ config EXYNOS_CHIPID
 	  Support for Samsung Exynos SoC ChipID and Adaptive Supply Voltage.
 	  This driver can also be built as module (exynos_chipid).
 
+config EXYNOS_USI
+	tristate "Exynos USI (Universal Serial Interface) driver"
+	default ARCH_EXYNOS && ARM64
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Enable support for USI block. USI (Universal Serial Interface) is an
+	  IP-core found in modern Samsung Exynos SoCs, like Exynos850 and
+	  ExynosAutoV0. USI block can be configured to provide one of the
+	  following serial protocols: UART, SPI or High Speed I2C.
+
+	  This driver allows one to configure USI for desired protocol, which
+	  is usually done in USI node in Device Tree.
+
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 2ae4bea804cf..9f59d1905ab0 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -4,6 +4,8 @@ obj-$(CONFIG_EXYNOS_ASV_ARM)	+= exynos5422-asv.o
 obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos_chipid.o
 exynos_chipid-y			+= exynos-chipid.o exynos-asv.o
 
+obj-$(CONFIG_EXYNOS_USI)	+= exynos-usi.o
+
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-usi.c b/drivers/soc/samsung/exynos-usi.c
new file mode 100644
index 000000000000..6e4112696f49
--- /dev/null
+++ b/drivers/soc/samsung/exynos-usi.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Samsung Exynos USI driver (Universal Serial Interface).
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include <dt-bindings/soc/samsung,exynos-usi.h>
+
+/* USIv2: System Register: SW_CONF register bits */
+#define USI_V2_SW_CONF_NONE	0x0
+#define USI_V2_SW_CONF_UART	BIT(0)
+#define USI_V2_SW_CONF_SPI	BIT(1)
+#define USI_V2_SW_CONF_I2C	BIT(2)
+#define USI_V2_SW_CONF_MASK	(USI_V2_SW_CONF_UART | USI_V2_SW_CONF_SPI | \
+				 USI_V2_SW_CONF_I2C)
+
+/* USIv2: USI register offsets */
+#define USI_CON			0x04
+#define USI_OPTION		0x08
+
+/* USIv2: USI register bits */
+#define USI_CON_RESET		BIT(0)
+#define USI_OPTION_CLKREQ_ON	BIT(1)
+#define USI_OPTION_CLKSTOP_ON	BIT(2)
+
+enum exynos_usi_ver {
+	USI_VER2 = 2,
+};
+
+struct exynos_usi_variant {
+	enum exynos_usi_ver ver;	/* USI IP-core version */
+	unsigned int sw_conf_mask;	/* SW_CONF mask for all protocols */
+	size_t min_mode;		/* first index in exynos_usi_modes[] */
+	size_t max_mode;		/* last index in exynos_usi_modes[] */
+};
+
+struct exynos_usi {
+	struct device *dev;
+	void __iomem *regs;		/* USI register map */
+	struct clk *pclk;		/* USI bus clock */
+	struct clk *ipclk;		/* USI operating clock */
+
+	size_t mode;			/* current USI SW_CONF mode index */
+	bool clkreq_on;			/* always provide clock to IP */
+
+	/* System Register */
+	struct regmap *sysreg;		/* System Register map */
+	unsigned int sw_conf;		/* SW_CONF register offset in sysreg */
+
+	const struct exynos_usi_variant *data;
+};
+
+struct exynos_usi_mode {
+	const char *name;		/* mode name */
+	unsigned int val;		/* mode register value */
+};
+
+static const struct exynos_usi_mode exynos_usi_modes[] = {
+	[USI_V2_NONE] =	{ .name = "none", .val = USI_V2_SW_CONF_NONE },
+	[USI_V2_UART] =	{ .name = "uart", .val = USI_V2_SW_CONF_UART },
+	[USI_V2_SPI] =	{ .name = "spi",  .val = USI_V2_SW_CONF_SPI },
+	[USI_V2_I2C] =	{ .name = "i2c",  .val = USI_V2_SW_CONF_I2C },
+};
+
+static const struct exynos_usi_variant exynos_usi_v2_data = {
+	.ver		= USI_VER2,
+	.sw_conf_mask	= USI_V2_SW_CONF_MASK,
+	.min_mode	= USI_V2_NONE,
+	.max_mode	= USI_V2_I2C,
+};
+
+static const struct of_device_id exynos_usi_dt_match[] = {
+	{
+		.compatible = "samsung,exynos-usi-v2",
+		.data = &exynos_usi_v2_data,
+	},
+	{ }, /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, exynos_usi_dt_match);
+
+/**
+ * exynos_usi_set_sw_conf - Set USI block configuration mode
+ * @usi: USI driver object
+ * @mode: Mode index
+ *
+ * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int exynos_usi_set_sw_conf(struct exynos_usi *usi, size_t mode)
+{
+	unsigned int val;
+	int ret;
+
+	if (mode < usi->data->min_mode || mode > usi->data->max_mode)
+		return -EINVAL;
+
+	val = exynos_usi_modes[mode].val;
+	ret = regmap_update_bits(usi->sysreg, usi->sw_conf,
+				 usi->data->sw_conf_mask, val);
+	if (ret)
+		return ret;
+
+	usi->mode = mode;
+	dev_dbg(usi->dev, "protocol: %s\n", exynos_usi_modes[usi->mode].name);
+
+	return 0;
+}
+
+/**
+ * exynos_usi_enable - Initialize USI block
+ * @usi: USI driver object
+ *
+ * USI IP-core start state is "reset" (on startup and after CPU resume). This
+ * routine enables USI block by clearing the reset flag. It also configures
+ * HWACG behavior (needed e.g. for UART Rx). It should be performed before
+ * underlying protocol becomes functional.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int exynos_usi_enable(const struct exynos_usi *usi)
+{
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(usi->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(usi->ipclk);
+	if (ret)
+		goto err_pclk;
+
+	/* Enable USI block */
+	val = readl(usi->regs + USI_CON);
+	val &= ~USI_CON_RESET;
+	writel(val, usi->regs + USI_CON);
+	udelay(1);
+
+	/* Continuously provide the clock to USI IP w/o gating */
+	if (usi->clkreq_on) {
+		val = readl(usi->regs + USI_OPTION);
+		val &= ~USI_OPTION_CLKSTOP_ON;
+		val |= USI_OPTION_CLKREQ_ON;
+		writel(val, usi->regs + USI_OPTION);
+	}
+
+	clk_disable_unprepare(usi->ipclk);
+err_pclk:
+	clk_disable_unprepare(usi->pclk);
+	return ret;
+}
+
+static int exynos_usi_configure(struct exynos_usi *usi)
+{
+	int ret;
+
+	ret = exynos_usi_set_sw_conf(usi, usi->mode);
+	if (ret)
+		return ret;
+
+	if (usi->data->ver == USI_VER2)
+		return exynos_usi_enable(usi);
+
+	return 0;
+}
+
+static int exynos_usi_parse_dt(struct device_node *np, struct exynos_usi *usi)
+{
+	int ret;
+	u32 mode;
+
+	ret = of_property_read_u32(np, "samsung,mode", &mode);
+	if (ret)
+		return ret;
+	if (mode < usi->data->min_mode || mode > usi->data->max_mode)
+		return -EINVAL;
+	usi->mode = mode;
+
+	usi->sysreg = syscon_regmap_lookup_by_phandle(np, "samsung,sysreg");
+	if (IS_ERR(usi->sysreg))
+		return PTR_ERR(usi->sysreg);
+
+	ret = of_property_read_u32_index(np, "samsung,sysreg", 1,
+					 &usi->sw_conf);
+	if (ret)
+		return ret;
+
+	usi->clkreq_on = of_property_read_bool(np, "samsung,clkreq-on");
+
+	return 0;
+}
+
+static int exynos_usi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct exynos_usi *usi;
+	int ret;
+
+	usi = devm_kzalloc(dev, sizeof(*usi), GFP_KERNEL);
+	if (!usi)
+		return -ENOMEM;
+
+	usi->dev = dev;
+	platform_set_drvdata(pdev, usi);
+
+	usi->data = of_device_get_match_data(dev);
+	if (!usi->data)
+		return -EINVAL;
+
+	ret = exynos_usi_parse_dt(np, usi);
+	if (ret)
+		return ret;
+
+	if (usi->data->ver == USI_VER2) {
+		usi->regs = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(usi->regs))
+			return PTR_ERR(usi->regs);
+
+		usi->pclk = devm_clk_get(dev, "pclk");
+		if (IS_ERR(usi->pclk))
+			return PTR_ERR(usi->pclk);
+
+		usi->ipclk = devm_clk_get(dev, "ipclk");
+		if (IS_ERR(usi->ipclk))
+			return PTR_ERR(usi->ipclk);
+	}
+
+	ret = exynos_usi_configure(usi);
+	if (ret)
+		return ret;
+
+	/* Make it possible to embed protocol nodes into USI np */
+	return of_platform_populate(np, NULL, NULL, dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int exynos_usi_resume_noirq(struct device *dev)
+{
+	struct exynos_usi *usi = dev_get_drvdata(dev);
+
+	return exynos_usi_configure(usi);
+}
+#endif
+
+static const struct dev_pm_ops exynos_usi_pm = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, exynos_usi_resume_noirq)
+};
+
+static struct platform_driver exynos_usi_driver = {
+	.driver = {
+		.name		= "exynos-usi",
+		.pm		= &exynos_usi_pm,
+		.of_match_table	= exynos_usi_dt_match,
+	},
+	.probe = exynos_usi_probe,
+};
+
+module_platform_driver(exynos_usi_driver);
+
+MODULE_DESCRIPTION("Samsung USI driver");
+MODULE_AUTHOR("Sam Protsenko <semen.protsenko@linaro.org>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

