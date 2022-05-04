Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969FB519F85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbiEDMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbiEDMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926925E96;
        Wed,  4 May 2022 05:32:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so2587229ejb.6;
        Wed, 04 May 2022 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBKA3UWWI9ka6cADxyOyqQzWUHiKDpIGUD+hMYCWwIE=;
        b=IyuGDa6VlGR8uuGgrygUdtZZA5TYqkZHkTBcLz+i70K9r+1qT8CbupcEsDQTytvDhw
         Y9K4JOoTspW2qMnjuniMQ3KmpsPvcIEEsMz7zT4woWw8Dcz1G9KaMHPew+nml4bFPyBH
         fchFcSRfPi+Mj2wS2r5oOsNSpLDNKPg3OZVAzL4MGx5me1tNRdFRMl5+zb1fir2fpSaH
         3Ka/fgqO72ar+MmR81PLsewQqPsqzpEDqTJVO4ogn2nBIswn/PMZOgXzFC9k458Q8C1r
         Z5u/3nkYuxWTg0eERZQVbxU87/8s/HpT4ysl6+lMnYDX337XhVtm5+rMz8xoOdeyPre7
         TZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBKA3UWWI9ka6cADxyOyqQzWUHiKDpIGUD+hMYCWwIE=;
        b=UoYWuWhyjDS4RXF9oVQpeG927wznsdY+wYtc+cSNoBCR6/6HlcX1p1dGJemObIgoWV
         GSuDWKppZmMNJbiqvLmWgp72R496kROZ1h5vNTOdConU4WFrurAhYc6uWRP6S7hIAulD
         648Xv+xIAhxv60PwTNliFtGMc9LvEb3DLPurai5pEPG7ihkgyMUEsImduRJQNI4VXfB4
         +fiX880pjEhcW4pAYSWDyVulvvSlGHpN/FGjDn/HkgtPEF0Fp760CutMh1d1paeTK+CT
         x60nBUsDozZk5TL6senBNtsHwUJc0pAhiEmQ7lhcPoIC4WmUzxiI6nXog1jRyShLcGLH
         8IWw==
X-Gm-Message-State: AOAM532MpTY7HKf/m17ZVL+OtPqjvMN2GegC3TpdmerMWI5akyUFQ05F
        ganvVOveTh9S1r3VZSz+l4M=
X-Google-Smtp-Source: ABdhPJyh3RaGuyNMpjEnKgDQjawtnF9SoXDPNlstOvMG1X0fvWRNarG3SkkNIl/eZ8ahLkcMZBxLAA==
X-Received: by 2002:a17:906:4985:b0:6ef:b344:2a56 with SMTP id p5-20020a170906498500b006efb3442a56mr20451501eju.625.1651667560889;
        Wed, 04 May 2022 05:32:40 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:40 -0700 (PDT)
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
Subject: [PATCH 06/13] clk: mediatek: Add driver for MT6735 apmixedsys
Date:   Wed,  4 May 2022 16:25:55 +0400
Message-Id: <20220504122601.335495-7-y.oudjana@protonmail.com>
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

Add a driver for MT6735 apmixedsys PLLs.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/clk/mediatek/Kconfig              |   7 +
 drivers/clk/mediatek/Makefile             |   1 +
 drivers/clk/mediatek/clk-mt6735-apmixed.c | 274 ++++++++++++++++++++++
 4 files changed, 283 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixed.c

diff --git a/MAINTAINERS b/MAINTAINERS
index de15c3d50d2d..1077712edb4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12442,6 +12442,7 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	drivers/clk/mediatek/clk-mt6735-apmixed.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d5936cfb3bee..ab364892f602 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -117,6 +117,13 @@ config COMMON_CLK_MT2712_VENCSYS
 	help
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
+config COMMON_CLK_MT6735_APMIXED
+	tristate "Clock driver for MediaTek MT6735 apmixedsys"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This driver supports MediaTek MT6735 apmixedsys clocks.
+
 config COMMON_CLK_MT6765
        bool "Clock driver for MediaTek MT6765"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index caf2ce93d666..7f45a22c6178 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 
+obj-$(CONFIG_COMMON_CLK_MT6735_APMIXED) += clk-mt6735-apmixed.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
 obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
diff --git a/drivers/clk/mediatek/clk-mt6735-apmixed.c b/drivers/clk/mediatek/clk-mt6735-apmixed.c
new file mode 100644
index 000000000000..6c4ec77d1d19
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-apmixed.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-apmixedsys.h>
+
+#define AP_PLL_CON_5		0x014
+#define ARMPLL_CON0		0x200
+#define ARMPLL_CON1		0x204
+#define ARMPLL_PWR_CON0		0x20c
+#define MAINPLL_CON0		0x210
+#define MAINPLL_CON1		0x214
+#define MAINPLL_PWR_CON0	0x21c
+#define UNIVPLL_CON0		0x220
+#define UNIVPLL_CON1		0x224
+#define UNIVPLL_PWR_CON0	0x22c
+#define MMPLL_CON0		0x230
+#define MMPLL_CON1		0x234
+#define MMPLL_PWR_CON0		0x23c
+#define MSDCPLL_CON0		0x240
+#define MSDCPLL_CON1		0x244
+#define MSDCPLL_PWR_CON0	0x24c
+#define VENCPLL_CON0		0x250
+#define VENCPLL_CON1		0x254
+#define VENCPLL_PWR_CON0	0x25c
+#define TVDPLL_CON0		0x260
+#define TVDPLL_CON1		0x264
+#define TVDPLL_PWR_CON0		0x26c
+#define APLL1_CON0		0x270
+#define APLL1_CON1		0x274
+#define APLL1_CON2		0x278
+#define APLL1_PWR_CON0		0x27c
+#define APLL2_CON0		0x280
+#define APLL2_CON1		0x284
+#define APLL2_CON2		0x288
+#define APLL2_PWR_CON0		0x28c
+
+#define CON0_RST_BAR		BIT(24)
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	{
+		.id = ARMPLL,
+		.name = "armpll",
+		.parent_name = "clk26m",
+
+		.reg = ARMPLL_CON0,
+		.pwr_reg = ARMPLL_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = ARMPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = ARMPLL_CON1,
+		.pcw_chg_reg = ARMPLL_CON1,
+		.pcwbits = 21,
+
+		.flags = PLL_AO
+	},
+	{
+		.id = MAINPLL,
+		.name = "mainpll",
+		.parent_name = "clk26m",
+
+		.reg = MAINPLL_CON0,
+		.pwr_reg = MAINPLL_PWR_CON0,
+		.en_mask = 0xf0000101,
+
+		.pd_reg = MAINPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = MAINPLL_CON1,
+		.pcw_chg_reg = MAINPLL_CON1,
+		.pcwbits = 21,
+
+		.flags = HAVE_RST_BAR,
+		.rst_bar_mask = CON0_RST_BAR
+	},
+	{
+		.id = UNIVPLL,
+		.name = "univpll",
+		.parent_name = "clk26m",
+
+		.reg = UNIVPLL_CON0,
+		.pwr_reg = UNIVPLL_PWR_CON0,
+		.en_mask = 0xfc000001,
+
+		.pd_reg = UNIVPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = UNIVPLL_CON1,
+		.pcw_chg_reg = UNIVPLL_CON1,
+		.pcwbits = 21,
+
+		.flags = HAVE_RST_BAR,
+		.rst_bar_mask = CON0_RST_BAR
+	},
+	{
+		.id = MMPLL,
+		.name = "mmpll",
+		.parent_name = "clk26m",
+
+		.reg = MMPLL_CON0,
+		.pwr_reg = MMPLL_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = MMPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = MMPLL_CON1,
+		.pcw_chg_reg = MMPLL_CON1,
+		.pcwbits = 21
+	},
+	{
+		.id = MSDCPLL,
+		.name = "msdcpll",
+		.parent_name = "clk26m",
+
+		.reg = MSDCPLL_CON0,
+		.pwr_reg = MSDCPLL_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = MSDCPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = MSDCPLL_CON1,
+		.pcw_chg_reg = MSDCPLL_CON1,
+		.pcwbits = 21,
+	},
+	{
+		.id = VENCPLL,
+		.name = "vencpll",
+		.parent_name = "clk26m",
+
+		.reg = VENCPLL_CON0,
+		.pwr_reg = VENCPLL_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = VENCPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = VENCPLL_CON1,
+		.pcw_chg_reg = VENCPLL_CON1,
+		.pcwbits = 21,
+
+		.flags = HAVE_RST_BAR,
+		.rst_bar_mask = CON0_RST_BAR
+	},
+	{
+		.id = TVDPLL,
+		.name = "tvdpll",
+		.parent_name = "clk26m",
+
+		.reg = TVDPLL_CON0,
+		.pwr_reg = TVDPLL_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = TVDPLL_CON1,
+		.pd_shift = 24,
+
+		.pcw_reg = TVDPLL_CON1,
+		.pcw_chg_reg = TVDPLL_CON1,
+		.pcwbits = 21
+	},
+	{
+		.id = APLL1,
+		.name = "apll1",
+		.parent_name = "clk26m",
+
+		.reg = APLL1_CON0,
+		.pwr_reg = APLL1_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = APLL1_CON0,
+		.pd_shift = 4,
+
+		.pcw_reg = APLL1_CON1,
+		.pcw_chg_reg = APLL1_CON1,
+		.pcwbits = 31,
+
+		.tuner_reg = APLL1_CON2,
+		.tuner_en_reg = AP_PLL_CON_5,
+		.tuner_en_bit = 0
+	},
+	{
+		.id = APLL2,
+		.name = "apll2",
+		.parent_name = "clk26m",
+
+		.reg = APLL2_CON0,
+		.pwr_reg = APLL2_PWR_CON0,
+		.en_mask = 0x00000001,
+
+		.pd_reg = APLL2_CON0,
+		.pd_shift = 4,
+
+		.pcw_reg = APLL2_CON1,
+		.pcw_chg_reg = APLL2_CON1,
+		.pcwbits = 31,
+
+		.tuner_reg = APLL1_CON2,
+		.tuner_en_reg = AP_PLL_CON_5,
+		.tuner_en_bit = 1
+	}
+};
+
+int clk_mt6735_apmixed_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct clk_onecell_data *clk_data;
+	int ret;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, clk_data);
+
+	ret = mtk_clk_register_plls(pdev->dev.of_node, apmixed_plls,
+				   ARRAY_SIZE(apmixed_plls), clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register PLLs: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+					  clk_data);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register clock provider: %pe\n",
+			ERR_PTR(ret));
+
+	return ret;
+}
+
+int clk_mt6735_apmixed_remove(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	mtk_clk_unregister_plls(apmixed_plls, ARRAY_SIZE(apmixed_plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static const struct of_device_id of_match_mt6735_apmixedsys[] = {
+	{ .compatible = "mediatek,mt6735-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_apmixed = {
+	.probe = clk_mt6735_apmixed_probe,
+	.remove = clk_mt6735_apmixed_remove,
+	.driver = {
+		.name = "clk-mt6735-apmixed",
+		.of_match_table = of_match_mt6735_apmixedsys,
+	},
+};
+module_platform_driver(clk_mt6735_apmixed);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 apmixedsys clock driver");
+MODULE_LICENSE("GPL");
-- 
2.36.0

