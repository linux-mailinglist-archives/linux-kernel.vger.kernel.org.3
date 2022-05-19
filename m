Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0B52D5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiESOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiESOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:24:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B67CC16E;
        Thu, 19 May 2022 07:24:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hh4so4880252qtb.10;
        Thu, 19 May 2022 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8zoP5QkbL8xvAjRoLL23SLbTT8n/as/p9ml7iTtPMM=;
        b=aN3nNP2p1/pDWhh/fnqUHmpYcqYQn+NErmHvq01lHqCZ3eU7HHnomZykiZXzAr7nl4
         nZnotjoZS4jl0wbz+abIH1bCV+H56K2hErICPfNeQp7lSae7aP7leTlKsqi5jwKQhhgi
         vIiBVywHllxmaDZ2a2vJ7QPuj+11Vf21K+zaJPRWiGnKmyxSQFkN2wISiJhAZif2sJhG
         jLl2YIuxNv/dG+s2+j6mOBpbRmKumKWnliuLlHivVdhohu0LbZqNaiqOcMS66XM5wyfN
         z82SginsuVlcEkF6WXXvA6EAhxMH8866XkeNYa+4y4SUjyinacs9JNlD2KEKEDNs2P9V
         OMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8zoP5QkbL8xvAjRoLL23SLbTT8n/as/p9ml7iTtPMM=;
        b=HQ0X+TtwGM11fwl3LeWBpZS6hZLZ7ocCcmcjq5h/Sm8DiTnBdYGvR3sDyxz9npq2/A
         iqyQWOvbwNuAgMkYz2/SvW2wtIRhCL7yYnoKCYsILMX7hw0CbTF9XQd/YoY8bsvCy96M
         Gw0kd14+leVEFKWvRSaTLgbSgfE1OQPEVYjE6ofZSM0khZOsHgFtZlMdDYF/DF9HqBH7
         LgOOMXogRzYZDg55s7Ig5AW83Z1zecGS8dYKtZe53dRyKF1bJKGpxaP0AAQpwiBLZyRu
         THHA2vIE9R0vwBNcOfpy4SB9thf0IYhVPd/DCH2X0KLoGa/KHnrMuoW4tzQ0ynuqLcmr
         zIwA==
X-Gm-Message-State: AOAM531Ev1iYI3aEnvUlVWbluooMGXMuLP3x26JwoMMq/lrBJmW5eept
        SbKLJwfv4bWiUgKUWLs6kvY=
X-Google-Smtp-Source: ABdhPJy52Yg5mJbkATXChVnefUsCQcyD8Pcpc6oXDhXAx05c3/PiFo0jOvkz59ZG1EKX9eIF3dl7Tg==
X-Received: by 2002:ac8:5850:0:b0:2f3:b4c3:110c with SMTP id h16-20020ac85850000000b002f3b4c3110cmr4040632qth.379.1652970292748;
        Thu, 19 May 2022 07:24:52 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id c15-20020ac85a8f000000b002f39b99f697sm1539342qtc.49.2022.05.19.07.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:24:52 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers
Date:   Thu, 19 May 2022 18:22:11 +0400
Message-Id: <20220519142211.458336-5-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519142211.458336-1-y.oudjana@protonmail.com>
References: <20220519142211.458336-1-y.oudjana@protonmail.com>
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

Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
clock and reset controllers. These provide the base clocks on the
platform, and should be enough to bring up all essential blocks
including PWRAP, MSDC and peripherals (UART, I2C, SPI).

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
- clk: mediatek: Improvements to simple probe/remove and reset controller unregistration
  https://patchwork.kernel.org/project/linux-clk/cover/20220519134728.456643-1-y.oudjana@protonmail.com/

 MAINTAINERS                                  |    4 +
 drivers/clk/mediatek/Kconfig                 |    9 +
 drivers/clk/mediatek/Makefile                |    1 +
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  235 ++++
 drivers/clk/mediatek/clk-mt6735-infracfg.c   |  205 ++++
 drivers/clk/mediatek/clk-mt6735-pericfg.c    |  301 +++++
 drivers/clk/mediatek/clk-mt6735-topckgen.c   | 1087 ++++++++++++++++++
 7 files changed, 1842 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c0af554a7b6..65f7c95bba9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12499,6 +12499,10 @@ M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+F:	drivers/clk/mediatek/clk-mt6735-infracfg.c
+F:	drivers/clk/mediatek/clk-mt6735-pericfg.c
+F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d5936cfb3bee..2d2d51c9829e 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -117,6 +117,15 @@ config COMMON_CLK_MT2712_VENCSYS
 	help
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
+config COMMON_CLK_MT6735
+	tristate "Main clock drivers for MediaTek MT6735"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This enables drivers for clocks and resets provided
+	  by apmixedsys, topckgen, infracfg and pericfg on the
+	  MediaTek MT6735 SoC.
+
 config COMMON_CLK_MT6765
        bool "Clock driver for MediaTek MT6765"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index caf2ce93d666..45530dae64a2 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 
+obj-$(CONFIG_COMMON_CLK_MT6735) += clk-mt6735-apmixedsys.o clk-mt6735-infracfg.o clk-mt6735-pericfg.o clk-mt6735-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
 obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
new file mode 100644
index 000000000000..65afbe8d38fa
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
@@ -0,0 +1,235 @@
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
+#define APLL1_PWR_CON0		0x280
+#define APLL2_CON0		0x284
+#define APLL2_CON1		0x288
+#define APLL2_CON2		0x28c
+#define APLL2_PWR_CON0		0x294
+
+#define CON0_RST_BAR		BIT(24)
+
+static const struct mtk_pll_data apmixedsys_plls[] = {
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
+static const struct mtk_clk_desc apmixedsys_clks = {
+	.plls = apmixedsys_plls,
+	.num_plls = ARRAY_SIZE(apmixedsys_plls)
+};
+
+static const struct of_device_id of_match_mt6735_apmixedsys[] = {
+	{ .compatible = "mediatek,mt6735-apmixedsys", .data = &apmixedsys_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_apmixedsys = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-apmixedsys",
+		.of_match_table = of_match_mt6735_apmixedsys,
+	},
+};
+module_platform_driver(clk_mt6735_apmixedsys);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 apmixedsys clock driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-infracfg.c b/drivers/clk/mediatek/clk-mt6735-infracfg.c
new file mode 100644
index 000000000000..37cf64a192ab
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-infracfg.c
@@ -0,0 +1,205 @@
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
+#include <dt-bindings/clock/mediatek,mt6735-infracfg.h>
+
+#define INFRA_RST0			0x30
+#define INFRA_GLOBALCON_PDN0		0x40
+#define INFRA_PDN1			0x44
+#define	INFRA_PDN_STA			0x48
+
+static struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = INFRA_GLOBALCON_PDN0,
+	.clr_ofs = INFRA_PDN1,
+	.sta_ofs = INFRA_PDN_STA,
+};
+
+static const struct mtk_gate infracfg_gates[] = {
+	{
+		.id = DBGCLK,
+		.name = "dbgclk",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 0,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = GCE,
+		.name = "gce",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 1,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = TRBG,
+		.name = "trbg",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 2,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = CPUM,
+		.name = "cpum",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 3,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = DEVAPC,
+		.name = "devapc",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 4,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = AUDIO,
+		.name = "audio",
+		.parent_name = "aud_intbus_sel",
+		.regs = &infra_cg_regs,
+		.shift = 5,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = GCPU,
+		.name = "gcpu",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 6,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = L2C_SRAM,
+		.name = "l2csram",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 7,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = M4U,
+		.name = "m4u",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 8,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = CLDMA,
+		.name = "cldma",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 12,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = CONNMCU_BUS,
+		.name = "connmcu_bus",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 15,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = KP,
+		.name = "kp",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 16,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = APXGPT,
+		.name = "apxgpt",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 18,
+		.ops = &mtk_clk_gate_ops_setclr,
+		.flags = CLK_IS_CRITICAL
+	},
+	{
+		.id = SEJ,
+		.name = "sej",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 19,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = CCIF0_AP,
+		.name = "ccif0ap",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 20,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = CCIF1_AP,
+		.name = "ccif1ap",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 21,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PMIC_SPI,
+		.name = "pmicspi",
+		.parent_name = "pmicspi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 22,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+	{
+		.id = PMIC_WRAP,
+		.name = "pmicwrap",
+		.parent_name = "axi_sel",
+		.regs = &infra_cg_regs,
+		.shift = 23,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+};
+
+static u16 infracfg_rst_ofs[] = { INFRA_RST0 };
+
+static const struct mtk_clk_rst_desc infracfg_resets = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infracfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infracfg_rst_ofs)
+};
+
+static const struct mtk_clk_desc infracfg_clks = {
+	.gates = infracfg_gates,
+	.num_gates = ARRAY_SIZE(infracfg_gates),
+
+	.rst_desc = &infracfg_resets
+};
+
+static const struct of_device_id of_match_mt6735_infracfg[] = {
+	{ .compatible = "mediatek,mt6735-infracfg", .data = &infracfg_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_infracfg = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-infracfg",
+		.of_match_table = of_match_mt6735_infracfg,
+	},
+};
+module_platform_driver(clk_mt6735_infracfg);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 infracfg clock and reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6735-pericfg.c b/drivers/clk/mediatek/clk-mt6735-pericfg.c
new file mode 100644
index 000000000000..6ec987197a22
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-pericfg.c
@@ -0,0 +1,301 @@
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
+#define PERI_GLOBALCON_RST1		0x04
+#define PERI_GLOBALCON_PDN0_SET		0x08
+#define PERI_GLOBALCON_PDN0_CLR		0x10
+#define	PERI_GLOBALCON_PDN0_STA		0x18
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
+		.name = "irtx",
+		.parent_name = "irtx_sel",
+		.regs = &peri_cg_regs,
+		.shift = 29,
+		.ops = &mtk_clk_gate_ops_setclr
+	},
+};
+
+static u16 pericfg_rst_ofs[] = { PERI_GLOBALCON_RST0, PERI_GLOBALCON_RST1 };
+
+static const struct mtk_clk_rst_desc pericfg_resets = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs)
+};
+
+static const struct mtk_clk_desc pericfg_clks = {
+	.gates = pericfg_gates,
+	.num_gates = ARRAY_SIZE(pericfg_gates),
+
+	.rst_desc = &pericfg_resets
+};
+
+static const struct of_device_id of_match_mt6735_pericfg[] = {
+	{ .compatible = "mediatek,mt6735-pericfg", .data = &pericfg_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_pericfg = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
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
diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c b/drivers/clk/mediatek/clk-mt6735-topckgen.c
new file mode 100644
index 000000000000..4540bbd2cfcd
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
@@ -0,0 +1,1087 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
+
+#define CLK_CFG_0		0x40
+#define CLK_CFG_0_SET		0x44
+#define CLK_CFG_0_CLR		0x48
+#define CLK_CFG_1		0x50
+#define CLK_CFG_1_SET		0x54
+#define CLK_CFG_1_CLR		0x58
+#define CLK_CFG_2		0x60
+#define CLK_CFG_2_SET		0x64
+#define CLK_CFG_2_CLR		0x68
+#define CLK_CFG_3		0x70
+#define CLK_CFG_3_SET		0x74
+#define CLK_CFG_3_CLR		0x78
+#define CLK_CFG_4		0x80
+#define CLK_CFG_4_SET		0x84
+#define CLK_CFG_4_CLR		0x88
+#define CLK_CFG_5		0x90
+#define CLK_CFG_5_SET		0x94
+#define CLK_CFG_5_CLR		0x98
+#define CLK_CFG_6		0xa0
+#define CLK_CFG_6_SET		0xa4
+#define CLK_CFG_6_CLR		0xa8
+#define CLK_CFG_7		0xb0
+#define CLK_CFG_7_SET		0xb4
+#define CLK_CFG_7_CLR		0xb8
+
+/* Some clocks with unknown details are modeled as fixed clocks */
+static const struct mtk_fixed_clk topckgen_fixed_clks[] = {
+	{
+		/*
+		 * This clock is available as a parent option for multiple
+		 * muxes and seems like an alternative name for clk26m at first,
+		 * but it appears alongside it in several muxes which should
+		 * mean it is a separate clock.
+		 */
+		.id = AD_SYS_26M_CK,
+		.name = "ad_sys_26m_ck",
+		.parent = "clk26m",
+		.rate = 26 * MHZ,
+	},
+	{
+		/*
+		 * This clock is the parent of DMPLL divisors. It might be MEMPLL
+		 * or its parent, as DMPLL appears to be an alternative name for
+		 * MEMPLL.
+		 */
+		.id = CLKPH_MCK_O,
+		.name = "clkph_mck_o",
+		.parent = NULL
+	},
+	{
+		/*
+		 * DMPLL clock (dmpll_ck), controlled by DDRPHY.
+		 */
+		.id = DMPLL,
+		.name = "dmpll",
+		.parent = "clkph_mck_o"
+	},
+	{
+		/*
+		 * MIPI DPI clock. Parent option for dpi0_sel. Unknown parent.
+		 */
+		.id = DPI_CK,
+		.name = "dpi_ck",
+		.parent = NULL
+	},
+	{
+		/*
+		 * This clock is a child of WHPLL which is controlled by
+		 * the modem.
+		 */
+		.id = WHPLL_AUDIO_CK,
+		.name = "whpll_audio_ck",
+		.parent = NULL
+	},
+};
+
+static const struct mtk_fixed_factor topckgen_factors[] = {
+	{
+		.id = SYSPLL_D2,
+		.name = "syspll_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL_D3,
+		.name = "syspll_d3",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = SYSPLL_D5,
+		.name = "syspll_d5",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 5
+	},
+	{
+		.id = SYSPLL1_D2,
+		.name = "syspll1_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL1_D4,
+		.name = "syspll1_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL1_D8,
+		.name = "syspll1_d8",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = SYSPLL1_D16,
+		.name = "syspll1_d16",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 16
+	},
+	{
+		.id = SYSPLL2_D2,
+		.name = "syspll2_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL2_D4,
+		.name = "syspll2_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL3_D2,
+		.name = "syspll3_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL3_D4,
+		.name = "syspll3_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL4_D2,
+		.name = "syspll4_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL4_D4,
+		.name = "syspll4_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL_D2,
+		.name = "univpll_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL_D3,
+		.name = "univpll_d3",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = UNIVPLL_D5,
+		.name = "univpll_d5",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 5
+	},
+	{
+		.id = UNIVPLL_D26,
+		.name = "univpll_d26",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 26
+	},
+	{
+		.id = UNIVPLL1_D2,
+		.name = "univpll1_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL1_D4,
+		.name = "univpll1_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL1_D8,
+		.name = "univpll1_d8",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = UNIVPLL2_D2,
+		.name = "univpll2_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL2_D4,
+		.name = "univpll2_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL2_D8,
+		.name = "univpll2_d8",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = UNIVPLL3_D2,
+		.name = "univpll3_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL3_D4,
+		.name = "univpll3_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = MSDCPLL_D2,
+		.name = "msdcpll_d2",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = MSDCPLL_D4,
+		.name = "msdcpll_d4",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = MSDCPLL_D8,
+		.name = "msdcpll_d8",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = MSDCPLL_D16,
+		.name = "msdcpll_d16",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 16
+	},
+	{
+		.id = VENCPLL_D3,
+		.name = "vencpll_d3",
+		.parent_name = "vencpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = TVDPLL_D2,
+		.name = "tvdpll_d2",
+		.parent_name = "tvdpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = TVDPLL_D4,
+		.name = "tvdpll_d4",
+		.parent_name = "tvdpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = DMPLL_D2,
+		.name = "dmpll_d2",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = DMPLL_D4,
+		.name = "dmpll_d4",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = DMPLL_D8,
+		.name = "dmpll_d8",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = AD_SYS_26M_D2,
+		.name = "ad_sys_26m_d2",
+		.parent_name = "clk26m",
+		.mult = 1,
+		.div = 2
+	},
+};
+
+static const char * const axi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll",
+	"dmpll_d2"
+};
+
+static const char * const mem_sel_parents[] = {
+	"clk26m",
+	"dmpll"
+};
+
+static const char * const ddrphycfg_parents[] = {
+	"clk26m",
+	"syspll1_d8"
+};
+
+static const char * const mm_sel_parents[] = {
+	"clk26m",
+	"vencpll",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll"
+};
+
+static const char * const pwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"univpll3_d2",
+	"univpll1_d4"
+};
+
+static const char * const vdec_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"syspll_d2",
+	"syspll2_d2",
+	"msdcpll_d2"
+};
+
+static const char * const mfg_sel_parents[] = {
+	"clk26m",
+	"mmpll",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"syspll_d3",
+	"syspll1_d2",
+	"syspll_d5",
+	"univpll_d3",
+	"univpll1_d2"
+};
+
+static const char * const camtg_sel_parents[] = {
+	"clk26m",
+	"univpll_d26",
+	"univpll2_d2",
+	"syspll3_d2",
+	"syspll3_d4",
+	"msdcpll_d4"
+};
+
+static const char * const uart_sel_parents[] = {
+	"clk26m",
+	"univpll2_d8"
+};
+
+static const char * const spi_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"msdcpll_d8",
+	"syspll2_d4",
+	"syspll4_d2",
+	"univpll2_d4",
+	"univpll1_d8"
+};
+
+static const char * const usb20_sel_parents[] = {
+	"clk26m",
+	"univpll1_d8",
+	"univpll3_d4"
+};
+
+static const char * const msdc50_0_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll2_d2",
+	"syspll4_d2",
+	"univpll_d5",
+	"univpll1_d4"
+};
+
+static const char * const msdc30_0_sel_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"msdcpll_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d3",
+	"univpll_d26",
+	"syspll2_d4",
+	"univpll_d2"
+};
+
+static const char * const msdc30_1_2_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"syspll2_d4"
+};
+
+static const char * const msdc30_3_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"msdcpll_d16",
+	"syspll2_d4"
+};
+
+static const char * const audio_sel_parents[] = {
+	"clk26m",
+	"syspll3_d4",
+	"syspll4_d4",
+	"syspll1_d16"
+};
+
+static const char * const aud_intbus_sel_parents[] = {
+	"clk26m",
+	"syspll1_d4",
+	"syspll4_d2",
+	"dmpll_d4"
+};
+
+static const char * const pmicspi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"syspll3_d4",
+	"syspll1_d16",
+	"univpll3_d4",
+	"univpll_d26",
+	"dmpll_d4",
+	"dmpll_d8"
+};
+
+static const char * const scp_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char * const atb_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"dmpll"
+};
+
+static const char * const dpi0_sel_parents[] = {
+	"clk26m",
+	"tvdpll",
+	"tvdpll_d2",
+	"tvdpll_d4",
+	"dpi_ck"
+};
+
+static const char * const scam_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"univpll2_d4",
+	"vencpll_d3"
+};
+
+static const char * const mfg13m_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_d2"
+};
+
+static const char * const aud_1_2_sel_parents[] = {
+	"clk26m",
+	"apll1"
+};
+
+static const char * const irda_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4"
+};
+
+static const char * const irtx_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_ck"
+};
+
+static const char * const disppwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"syspll4_d2_d8",
+	"ad_sys_26m_ck"
+};
+
+static const struct mtk_mux topckgen_muxes[] = {
+	{
+		.id = AXI_SEL,
+		.name = "axi_sel",
+		.parent_names = axi_sel_parents,
+		.num_parents = ARRAY_SIZE(axi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 3,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = MEM_SEL,
+		.name = "mem_sel",
+		.parent_names = mem_sel_parents,
+		.num_parents = ARRAY_SIZE(mem_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 1,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = DDRPHY_SEL,
+		.name = "ddrphycfg_sel",
+		.parent_names = ddrphycfg_parents,
+		.num_parents = ARRAY_SIZE(ddrphycfg_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 1,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = MM_SEL,
+		.name = "mm_sel",
+		.parent_names = mm_sel_parents,
+		.num_parents = ARRAY_SIZE(mm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = PWM_SEL,
+		.name = "pwm_sel",
+		.parent_names = pwm_sel_parents,
+		.num_parents = ARRAY_SIZE(pwm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = VDEC_SEL,
+		.name = "vdec_sel",
+		.parent_names = vdec_sel_parents,
+		.num_parents = ARRAY_SIZE(vdec_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MFG_SEL,
+		.name = "mfg_sel",
+		.parent_names = mfg_sel_parents,
+		.num_parents = ARRAY_SIZE(mfg_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 4,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = CAMTG_SEL,
+		.name = "camtg_sel",
+		.parent_names = camtg_sel_parents,
+		.num_parents = ARRAY_SIZE(camtg_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = UART_SEL,
+		.name = "uart_sel",
+		.parent_names = uart_sel_parents,
+		.num_parents = ARRAY_SIZE(uart_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 1,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = SPI_SEL,
+		.name = "spi_sel",
+		.parent_names = spi_sel_parents,
+		.num_parents = ARRAY_SIZE(spi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = USB20_SEL,
+		.name = "usb20_sel",
+		.parent_names = usb20_sel_parents,
+		.num_parents = ARRAY_SIZE(usb20_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 2,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC50_0_SEL,
+		.name = "msdc50_0_sel",
+		.parent_names = msdc50_0_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc50_0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_0_SEL,
+		.name = "msdc30_0_sel",
+		.parent_names = msdc30_0_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 4,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_1_SEL,
+		.name = "msdc30_1_sel",
+		.parent_names = msdc30_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_2_SEL,
+		.name = "msdc30_2_sel",
+		.parent_names = msdc30_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 3,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_3_SEL,
+		.name = "msdc30_3_sel",
+		.parent_names = msdc30_3_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_3_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 4,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUDIO_SEL,
+		.name = "audio_sel",
+		.parent_names = audio_sel_parents,
+		.num_parents = ARRAY_SIZE(audio_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUDINTBUS_SEL,
+		.name = "aud_intbus_sel",
+		.parent_names = aud_intbus_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_intbus_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 2,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = PMICSPI_SEL,
+		.name = "pmicspi_sel",
+		.parent_names = pmicspi_sel_parents,
+		.num_parents = ARRAY_SIZE(pmicspi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 3,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = SCP_SEL,
+		.name = "scp_sel",
+		.parent_names = scp_sel_parents,
+		.num_parents = ARRAY_SIZE(scp_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 2,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = ATB_SEL,
+		.name = "atb_sel",
+		.parent_names = atb_sel_parents,
+		.num_parents = ARRAY_SIZE(atb_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = DPI0_SEL,
+		.name = "dpi0_sel",
+		.parent_names = dpi0_sel_parents,
+		.num_parents = ARRAY_SIZE(dpi0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = SCAM_SEL,
+		.name = "scam_sel",
+		.parent_names = scam_sel_parents,
+		.num_parents = ARRAY_SIZE(scam_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 2,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MFG13M_SEL,
+		.name = "mfg13m_sel",
+		.parent_names = mfg13m_sel_parents,
+		.num_parents = ARRAY_SIZE(mfg13m_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 1,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUD1_SEL,
+		.name = "aud_1_sel",
+		.parent_names = aud_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 1,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUD2_SEL,
+		.name = "aud_2_sel",
+		.parent_names = aud_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 1,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = IRDA_SEL,
+		.name = "irda_sel",
+		.parent_names = irda_sel_parents,
+		.num_parents = ARRAY_SIZE(irda_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 1,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = IRTX_SEL,
+		.name = "irtx_sel",
+		.parent_names = irtx_sel_parents,
+		.num_parents = ARRAY_SIZE(irtx_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 1,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = DISPPWM_SEL,
+		.name = "disppwm_sel",
+		.parent_names = disppwm_sel_parents,
+		.num_parents = ARRAY_SIZE(disppwm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_7,
+		.set_ofs = CLK_CFG_7_SET,
+		.clr_ofs = CLK_CFG_7_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+};
+
+static const struct mtk_clk_desc topckgen_clks = {
+	.fixed_clks = topckgen_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(topckgen_fixed_clks),
+	.factors = topckgen_factors,
+	.num_factors = ARRAY_SIZE(topckgen_factors),
+	.muxes = topckgen_muxes,
+	.num_muxes = ARRAY_SIZE(topckgen_muxes)
+};
+
+static const struct of_device_id of_match_mt6735_topckgen[] = {
+	{ .compatible = "mediatek,mt6735-topckgen", .data = &topckgen_clks },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_topckgen = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6735-topckgen",
+		.of_match_table = of_match_mt6735_topckgen,
+	},
+};
+module_platform_driver(clk_mt6735_topckgen);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 topckgen clock driver");
+MODULE_LICENSE("GPL");
-- 
2.36.1

