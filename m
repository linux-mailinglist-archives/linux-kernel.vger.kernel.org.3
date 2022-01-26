Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6128549D109
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiAZRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243863AbiAZRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C75C061747;
        Wed, 26 Jan 2022 09:40:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e8so450273wrc.0;
        Wed, 26 Jan 2022 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzQkhLBS70dEhyFA0pnQ2jAb/yuPb18VvGMin2IIfps=;
        b=mZXdWA3pxNhnsRou/96wMixaVrpZViMelAElL4m1J3ccF5lVmxstPdehFg/fmNXJvp
         PVN8ZhlbSy8PxrQXTXB9lhrDNkqxNFoD1qeagyRg3Bis2QlrvfsLFMa2WHF4U9NPRQrw
         ICU8zwUBnSPetS6zBZ4SuhcYI9XhwPH0ybMeuZPxizSOvWjwMT6mWH83ktXRrzKcqBCy
         cR/6B+eFNfSyLiEXftrliQK8PAACongo23YqV8dLRzkQR8mG+zsYEOQRjjLpPS154zH6
         sssQdCBSEiHTK2rmVhEMnf2xgThUxJGzcLMjtMSARYE3jKAYhene7kbKDDty/oOf4+g5
         yr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vzQkhLBS70dEhyFA0pnQ2jAb/yuPb18VvGMin2IIfps=;
        b=lKltSBlAnq86zORHYQS6FGPjibG5IF1n3LBm21GV9abfD7Sjz7hc8w7rKvkzdq7BEH
         GmvCA434lbzyKkGgYZtOrioPnMB2vy0wM0V9sGDsbdVH4y0/k/12EU/YhBlJ2tOvSxXQ
         dC4VqYdzQ9aXZiqBCLEq6MoUGiHUaYgjTysX0iGV2rEMWUUAShbSxdIuidc1TUzEtEx6
         ZCfXyuP3np+x+15V2C6OB2vtAgQTOdjIauFiOCRWbaGmsMilwDnL32BQvESkmT9UCoBj
         +tb5a/bBsLmpSDsQAt2yZVRn47mjNVkMYe1iq4w2JlQJBsjzn3EyqYKrBtbACe/P+ydY
         6zHg==
X-Gm-Message-State: AOAM5327mKC2NFfZc1oWKcPISWpY4eLDnp1nE8MoZ1RNGbrmTtQIdaEk
        oMFH+JMhfeidjB6mOJxlM8Tz2TNXDis=
X-Google-Smtp-Source: ABdhPJwdUUNl3K0u8oQwmUALIFV2eaDwBv4Zbs+vjfk6Lx1pBSP+z1WpUlznbVyoTVXmN+0zJ7qohA==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr11837502wrt.453.1643218830233;
        Wed, 26 Jan 2022 09:40:30 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:29 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/7] clk: starfive: Add JH7100 audio clock driver
Date:   Wed, 26 Jan 2022 18:39:53 +0100
Message-Id: <20220126173953.1016706-8-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the audio clocks on the Starfive JH7100 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 MAINTAINERS                                   |   8 +-
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 170 ++++++++++++++++++
 4 files changed, 183 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100-audio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..19a855f3fdca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18376,12 +18376,12 @@ M:	Ion Badulescu <ionut@badula.org>
 S:	Odd Fixes
 F:	drivers/net/ethernet/adaptec/starfire*
 
-STARFIVE JH7100 CLOCK DRIVER
+STARFIVE JH7100 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 S:	Maintained
-F:	Documentation/devicetree/bindings/clock/starfive,jh7100-clkgen.yaml
-F:	drivers/clk/starfive/clk-starfive-jh7100.c
-F:	include/dt-bindings/clock/starfive-jh7100.h
+F:	Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
+F:	drivers/clk/starfive/clk-starfive-jh7100*
+F:	include/dt-bindings/clock/starfive-jh7100*.h
 
 STARFIVE JH7100 PINCTRL DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index c0fa9d5e641f..003bd2d56ce7 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -7,3 +7,11 @@ config CLK_STARFIVE_JH7100
 	help
 	  Say yes here to support the clock controller on the StarFive JH7100
 	  SoC.
+
+config CLK_STARFIVE_JH7100_AUDIO
+	tristate "StarFive JH7100 audio clock support"
+	depends on CLK_STARFIVE_JH7100
+	default m if SOC_STARFIVE
+	help
+	  Say Y or M here to support the audio clocks on the StarFive JH7100
+	  SoC.
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index 09759cc73530..0fa8ecb9ec1c 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 # StarFive Clock
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
+obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
new file mode 100644
index 000000000000..8473a65e219b
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7100 Audio Clock Driver
+ *
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/starfive-jh7100-audio.h>
+
+#include "clk-starfive-jh7100.h"
+
+/* external clocks */
+#define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
+#define JH7100_AUDCLK_AUDIO_12288		(JH7100_AUDCLK_END + 1)
+#define JH7100_AUDCLK_DOM7AHB_BUS		(JH7100_AUDCLK_END + 2)
+#define JH7100_AUDCLK_I2SADC_BCLK_IOPAD		(JH7100_AUDCLK_END + 3)
+#define JH7100_AUDCLK_I2SADC_LRCLK_IOPAD	(JH7100_AUDCLK_END + 4)
+#define JH7100_AUDCLK_I2SDAC_BCLK_IOPAD		(JH7100_AUDCLK_END + 5)
+#define JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD	(JH7100_AUDCLK_END + 6)
+#define JH7100_AUDCLK_VAD_INTMEM                (JH7100_AUDCLK_END + 7)
+
+static const struct jh7100_clk_data jh7100_audclk_data[] = {
+	JH7100__GMD(JH7100_AUDCLK_ADC_MCLK, "adc_mclk", 0, 15, 2,
+		    JH7100_AUDCLK_AUDIO_SRC,
+		    JH7100_AUDCLK_AUDIO_12288),
+	JH7100__GMD(JH7100_AUDCLK_I2S1_MCLK, "i2s1_mclk", 0, 15, 2,
+		    JH7100_AUDCLK_AUDIO_SRC,
+		    JH7100_AUDCLK_AUDIO_12288),
+	JH7100_GATE(JH7100_AUDCLK_I2SADC_APB, "i2sadc_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100_MDIV(JH7100_AUDCLK_I2SADC_BCLK, "i2sadc_bclk", 31, 2,
+		    JH7100_AUDCLK_ADC_MCLK,
+		    JH7100_AUDCLK_I2SADC_BCLK_IOPAD),
+	JH7100__INV(JH7100_AUDCLK_I2SADC_BCLK_N, "i2sadc_bclk_n", JH7100_AUDCLK_I2SADC_BCLK),
+	JH7100_MDIV(JH7100_AUDCLK_I2SADC_LRCLK, "i2sadc_lrclk", 63, 3,
+		    JH7100_AUDCLK_I2SADC_BCLK_N,
+		    JH7100_AUDCLK_I2SADC_LRCLK_IOPAD,
+		    JH7100_AUDCLK_I2SADC_BCLK),
+	JH7100_GATE(JH7100_AUDCLK_PDM_APB, "pdm_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100__GMD(JH7100_AUDCLK_PDM_MCLK, "pdm_mclk", 0, 15, 2,
+		    JH7100_AUDCLK_AUDIO_SRC,
+		    JH7100_AUDCLK_AUDIO_12288),
+	JH7100_GATE(JH7100_AUDCLK_I2SVAD_APB, "i2svad_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100__GMD(JH7100_AUDCLK_SPDIF, "spdif", 0, 15, 2,
+		    JH7100_AUDCLK_AUDIO_SRC,
+		    JH7100_AUDCLK_AUDIO_12288),
+	JH7100_GATE(JH7100_AUDCLK_SPDIF_APB, "spdif_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100_GATE(JH7100_AUDCLK_PWMDAC_APB, "pwmdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100__GMD(JH7100_AUDCLK_DAC_MCLK, "dac_mclk", 0, 15, 2,
+		    JH7100_AUDCLK_AUDIO_SRC,
+		    JH7100_AUDCLK_AUDIO_12288),
+	JH7100_GATE(JH7100_AUDCLK_I2SDAC_APB, "i2sdac_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100_MDIV(JH7100_AUDCLK_I2SDAC_BCLK, "i2sdac_bclk", 31, 2,
+		    JH7100_AUDCLK_DAC_MCLK,
+		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	JH7100__INV(JH7100_AUDCLK_I2SDAC_BCLK_N, "i2sdac_bclk_n", JH7100_AUDCLK_I2SDAC_BCLK),
+	JH7100_MDIV(JH7100_AUDCLK_I2SDAC_LRCLK, "i2sdac_lrclk", 31, 2,
+		    JH7100_AUDCLK_I2S1_MCLK,
+		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	JH7100_GATE(JH7100_AUDCLK_I2S1_APB, "i2s1_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100_MDIV(JH7100_AUDCLK_I2S1_BCLK, "i2s1_bclk", 31, 2,
+		    JH7100_AUDCLK_I2S1_MCLK,
+		    JH7100_AUDCLK_I2SDAC_BCLK_IOPAD),
+	JH7100__INV(JH7100_AUDCLK_I2S1_BCLK_N, "i2s1_bclk_n", JH7100_AUDCLK_I2S1_BCLK),
+	JH7100_MDIV(JH7100_AUDCLK_I2S1_LRCLK, "i2s1_lrclk", 63, 3,
+		    JH7100_AUDCLK_I2S1_BCLK_N,
+		    JH7100_AUDCLK_I2SDAC_LRCLK_IOPAD),
+	JH7100_GATE(JH7100_AUDCLK_I2SDAC16K_APB, "i2s1dac16k_apb", 0, JH7100_AUDCLK_APB0_BUS),
+	JH7100__DIV(JH7100_AUDCLK_APB0_BUS, "apb0_bus", 8, JH7100_AUDCLK_DOM7AHB_BUS),
+	JH7100_GATE(JH7100_AUDCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7100_AUDCLK_DOM7AHB_BUS),
+	JH7100_GATE(JH7100_AUDCLK_USB_APB, "usb_apb", CLK_IGNORE_UNUSED, JH7100_AUDCLK_APB_EN),
+	JH7100_GDIV(JH7100_AUDCLK_USB_LPM, "usb_lpm", CLK_IGNORE_UNUSED, 4, JH7100_AUDCLK_USB_APB),
+	JH7100_GDIV(JH7100_AUDCLK_USB_STB, "usb_stb", CLK_IGNORE_UNUSED, 3, JH7100_AUDCLK_USB_APB),
+	JH7100__DIV(JH7100_AUDCLK_APB_EN, "apb_en", 8, JH7100_AUDCLK_DOM7AHB_BUS),
+	JH7100__MUX(JH7100_AUDCLK_VAD_MEM, "vad_mem", 2,
+		    JH7100_AUDCLK_VAD_INTMEM,
+		    JH7100_AUDCLK_AUDIO_12288),
+};
+
+static struct clk_hw *jh7100_audclk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh7100_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7100_AUDCLK_END)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7100_audclk_probe(struct platform_device *pdev)
+{
+	struct jh7100_clk_priv *priv;
+	unsigned int idx;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_AUDCLK_END), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rmw_lock);
+	priv->dev = &pdev->dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (idx = 0; idx < JH7100_AUDCLK_END; idx++) {
+		u32 max = jh7100_audclk_data[idx].max;
+		struct clk_parent_data parents[4] = {};
+		struct clk_init_data init = {
+			.name = jh7100_audclk_data[idx].name,
+			.ops = starfive_jh7100_clk_ops(max),
+			.parent_data = parents,
+			.num_parents = ((max & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT) + 1,
+			.flags = jh7100_audclk_data[idx].flags,
+		};
+		struct jh7100_clk *clk = &priv->reg[idx];
+		unsigned int i;
+
+		for (i = 0; i < init.num_parents; i++) {
+			unsigned int pidx = jh7100_audclk_data[idx].parents[i];
+
+			if (pidx < JH7100_AUDCLK_END)
+				parents[i].hw = &priv->reg[pidx].hw;
+			else if (pidx == JH7100_AUDCLK_AUDIO_SRC)
+				parents[i].fw_name = "audio_src";
+			else if (pidx == JH7100_AUDCLK_AUDIO_12288)
+				parents[i].fw_name = "audio_12288";
+			else if (pidx == JH7100_AUDCLK_DOM7AHB_BUS)
+				parents[i].fw_name = "dom7ahb_bus";
+		}
+
+		clk->hw.init = &init;
+		clk->idx = idx;
+		clk->max_div = max & JH7100_CLK_DIV_MASK;
+
+		ret = devm_clk_hw_register(priv->dev, &clk->hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(priv->dev, jh7100_audclk_get, priv);
+}
+
+static const struct of_device_id jh7100_audclk_match[] = {
+	{ .compatible = "starfive,jh7100-audclk" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7100_audclk_match);
+
+static struct platform_driver jh7100_audclk_driver = {
+	.probe = jh7100_audclk_probe,
+	.driver = {
+		.name = "clk-starfive-jh7100-audio",
+		.of_match_table = jh7100_audclk_match,
+	},
+};
+module_platform_driver(jh7100_audclk_driver);
+
+MODULE_AUTHOR("Emil Renner Berthing");
+MODULE_DESCRIPTION("StarFive JH7100 audio clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

