Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015C519F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbiEDMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiEDMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:37:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47415739;
        Wed,  4 May 2022 05:33:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d6so1516718ede.8;
        Wed, 04 May 2022 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaxu342gW/DxI/UbFlGnJ28uFv24iJXQEXgIM7X6xNY=;
        b=gzpglsT3GbEbSKxWMMGXE8IUhn9CIvsl4DZZIukFszALKYf5VT1ii6YiXYkuU3s/+U
         kUhDIUzj6W8iql6H7Hotlxo068Ki63sidwo3JMXC6vQrvjAi3mG03XvOiIWAzwf0oH1H
         0+XjQpgtXTYX2Cox+9Z/E+m6cjLIzPedD5ApVVswXxWk+9sOvF/TSGX2zIb2I0GcAjaG
         p2PK/Fc6/8/+TpjkHfkdlWCq85HF1UV9N6vMG+XkcWlBaK14XOCjvvgfE/gRvsLIajGF
         eF0pdRWeCfCGZLX3rOQSOdzdcdYf2Rm9HTCI/uMPR9SByll6C1rDfhJO1FGc99Oof3BP
         hiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaxu342gW/DxI/UbFlGnJ28uFv24iJXQEXgIM7X6xNY=;
        b=oF3sPQa5yHYRdcAJAiRQu+6hwdKq4cbwIHRG6AeAd2/PhN3DGZv56r9nd+rNxbVaDx
         heWYYdZVicSdWYING6x5q8bnBVvd8khKwGKpPfl4FBCRzGtifmxzpb7ByqRmMN8ogctk
         qXQxdRnoEARoUIsaFLa5JIk3Dih10fYPVvVVandbJhJ6jIlqJzxwTYzR0JkBLCbbiVcm
         tKMnbSAz5KM/6DZhOSrSKAYubzhs144BnE9gyPkaSXR14P0Y5QmW/d1Sxno2pwYhXHwH
         of3GcvyvzQXNJFWVW+9lxrfGgCOxQI2/GGpkb9dONhMdSo8IVbIpFuqkumwvDHAgiNWJ
         ZYow==
X-Gm-Message-State: AOAM530zsu4WJOE+m67mebT4ytSsurdN1T8I0wuNDF1VAQJuqnl7a4Mu
        TcoQ2/2wdcBlrFd9mU8yc5Q=
X-Google-Smtp-Source: ABdhPJwqvDd9s9CXSy8fq2M92UshSnESjStcnJ7mVCiCMQjMr7LK/H5QCrfFxo6eZHbABGhzV1U7QQ==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id f1-20020a056402194100b00413282209c8mr22706309edz.13.1651667603720;
        Wed, 04 May 2022 05:33:23 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:33:23 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/13] clk: mediatek: Add driver for MT6735 pericfg
Date:   Wed,  4 May 2022 16:26:02 +0400
Message-Id: <20220504122601.335495-14-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a driver for MT6735 pericfg clock gates and resets.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/clk/mediatek/Kconfig              |   7 +
 drivers/clk/mediatek/Makefile             |   1 +
 drivers/clk/mediatek/clk-mt6735-pericfg.c | 360 ++++++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8662f12f34a2..5d90c2f2a587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12444,6 +12444,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/clk/mediatek/clk-mt6735-apmixed.c
 F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
+F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
 F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 62195e5d90a0..698ff2995460 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -131,6 +131,13 @@ config COMMON_CLK_MT6735_INFRACFG
 	help
 	  This driver supports MediaTek MT6735 infracfg clocks and resets.
 
+config COMMON_CLK_MT6735_PERICFG
+	tristate "Clock driver for MediaTek MT6735 pericfg"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This driver supports MediaTek MT6735 pericfg clocks and resets.
+
 config COMMON_CLK_MT6735_TOPCKGEN
 	tristate "Clock driver for MediaTek MT6735 topckgen"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e5c1da6e2711..b1a4d18e382d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.
 
 obj-$(CONFIG_COMMON_CLK_MT6735_APMIXED) += clk-mt6735-apmixed.o
 obj-$(CONFIG_COMMON_CLK_MT6735_INFRACFG) += clk-mt6735-infracfg.o
+obj-$(CONFIG_COMMON_CLK_MT6735_PERICFG) += clk-mt6735-pericfg.o
 obj-$(CONFIG_COMMON_CLK_MT6735_TOPCKGEN) += clk-mt6735-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/mediatek/clk-mt6735-pericfg.c
new file mode 100644
index 000000000000..8a01aa63a81e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-pericfg.h>
+
+#define PERI_GLOBALCON_RST0		0x00
+#define PERI_GLOBALCON_PDN0_SET		0x08
+#define PERI_GLOBALCON_PDN0_CLR		0x10
+#define	PERI_GLOBALCON_PDN0_STA		0x18
+
+struct mt6735_pericfg {
+	struct clk_onecell_data *clk_data;
+	struct mtk_reset *reset_data;
+};
+
+static struct mtk_gate_regs peri_cg_regs = {
+	.set_ofs = PERI_GLOBALCON_PDN0_SET,
+	.clr_ofs = PERI_GLOBALCON_PDN0_CLR,
+	.sta_ofs = PERI_GLOBALCON_PDN0_STA,
+};
+
+static const struct mtk_gate pericfg_gates[] = {
+	{
+		.id = DISP_PWM,
+		.name = "disp_pwm",
+		.parent_name = "disppwm_sel",
+		.regs = &peri_cg_regs,
+		.shift = 0,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = THERM,
+		.name = "therm",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 1,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM1,
+		.name = "pwm1",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 2,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM2,
+		.name = "pwm2",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 3,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM3,
+		.name = "pwm3",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 4,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM4,
+		.name = "pwm4",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 5,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM5,
+		.name = "pwm5",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 6,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM6,
+		.name = "pwm6",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 7,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM7,
+		.name = "pwm7",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 8,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PWM,
+		.name = "pwm",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 9,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = USB0,
+		.name = "usb0",
+		.parent_name = "usb20_sel",
+		.regs = &peri_cg_regs,
+		.shift = 10,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = IRDA,
+		.name = "irda",
+		.parent_name = "irda_sel",
+		.regs = &peri_cg_regs,
+		.shift = 11,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = APDMA,
+		.name = "apdma",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 12,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = MSDC30_0,
+		.name = "msdc30_0",
+		.parent_name = "msdc30_0_sel",
+		.regs = &peri_cg_regs,
+		.shift = 13,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = MSDC30_1,
+		.name = "msdc30_1",
+		.parent_name = "msdc30_1_sel",
+		.regs = &peri_cg_regs,
+		.shift = 14,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = MSDC30_2,
+		.name = "msdc30_2",
+		.parent_name = "msdc30_2_sel",
+		.regs = &peri_cg_regs,
+		.shift = 15,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = MSDC30_3,
+		.name = "msdc30_3",
+		.parent_name = "msdc30_3_sel",
+		.regs = &peri_cg_regs,
+		.shift = 16,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = UART0,
+		.name = "uart0",
+		.parent_name = "uart_sel",
+		.regs = &peri_cg_regs,
+		.shift = 17,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = UART1,
+		.name = "uart1",
+		.parent_name = "uart_sel",
+		.regs = &peri_cg_regs,
+		.shift = 18,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = UART2,
+		.name = "uart2",
+		.parent_name = "uart_sel",
+		.regs = &peri_cg_regs,
+		.shift = 19,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = UART3,
+		.name = "uart3",
+		.parent_name = "uart_sel",
+		.regs = &peri_cg_regs,
+		.shift = 20,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = UART4,
+		.name = "uart4",
+		.parent_name = "uart_sel",
+		.regs = &peri_cg_regs,
+		.shift = 21,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = BTIF,
+		.name = "btif",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 22,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = I2C0,
+		.name = "i2c0",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 23,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = I2C1,
+		.name = "i2c1",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 24,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = I2C2,
+		.name = "i2c2",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 25,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = I2C3,
+		.name = "i2c3",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 26,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = AUXADC,
+		.name = "auxadc",
+		.parent_name = "axi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 27,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = SPI0,
+		.name = "spi0",
+		.parent_name = "spi_sel",
+		.regs = &peri_cg_regs,
+		.shift = 28,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = IRTX,
+		.name = "IRTX",
+		.parent_name = "irtx_sel",
+		.regs = &peri_cg_regs,
+		.shift = 29,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+};
+
+int clk_mt6735_pericfg_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct mt6735_pericfg *pericfg;
+	int ret;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pericfg = devm_kmalloc(&pdev->dev, sizeof(struct mt6735_pericfg),
+				GFP_KERNEL);
+	if (!pericfg)
+		return -ENOMEM;
+
+	pericfg->clk_data = mtk_alloc_clk_data(ARRAY_SIZE(pericfg_gates));
+	if (!pericfg->clk_data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pericfg);
+
+	ret = mtk_clk_register_gates_with_dev(pdev->dev.of_node, pericfg_gates,
+					      ARRAY_SIZE(pericfg_gates),
+					      pericfg->clk_data, &pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register gates: %pe\n",
+			ERR_PTR(ret));
+		goto free_clk_data;
+	}
+
+	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+				  pericfg->clk_data);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register clock provider: %pe\n",
+			ERR_PTR(ret));
+		goto unregister_gates;
+	}
+
+	pericfg->reset_data = mtk_register_reset_controller(pdev->dev.of_node, 2,
+							    PERI_GLOBALCON_RST0);
+	if (IS_ERR(pericfg->reset_data)) {
+		dev_err(&pdev->dev, "Failed to register reset controller: %pe\n",
+			pericfg->reset_data);
+		return PTR_ERR(pericfg->reset_data);
+	}
+
+	return 0;
+unregister_gates:
+	mtk_clk_unregister_gates(pericfg_gates, ARRAY_SIZE(pericfg_gates),
+				 pericfg->clk_data);
+free_clk_data:
+	mtk_free_clk_data(pericfg->clk_data);
+
+	return ret;
+}
+
+int clk_mt6735_pericfg_remove(struct platform_device *pdev)
+{
+	struct mt6735_pericfg *pericfg = platform_get_drvdata(pdev);
+
+	mtk_unregister_reset_controller(pericfg->reset_data);
+	of_clk_del_provider(pdev->dev.of_node);
+	mtk_clk_unregister_gates(pericfg_gates, ARRAY_SIZE(pericfg_gates),
+				 pericfg->clk_data);
+	mtk_free_clk_data(pericfg->clk_data);
+
+	return 0;
+}
+
+static const struct of_device_id of_match_mt6735_pericfg[] = {
+	{ .compatible = "mediatek,mt6735-pericfg" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_pericfg = {
+	.probe = clk_mt6735_pericfg_probe,
+	.remove = clk_mt6735_pericfg_remove,
+	.driver = {
+		.name = "clk-mt6735-pericfg",
+		.of_match_table = of_match_mt6735_pericfg,
+	},
+};
+module_platform_driver(clk_mt6735_pericfg);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 pericfg clock driver");
+MODULE_LICENSE("GPL");
-- 
2.36.0

