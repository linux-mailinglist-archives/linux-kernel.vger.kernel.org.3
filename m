Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B256CDB5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiGJIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:19:59 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635CBC0E;
        Sun, 10 Jul 2022 01:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657441168; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ePp+WLrKqCtxJWWWJ0LwYb1tVhdAib9TBQ6ebqsPo2uD9yQJfK2mflQ/5Ndnm+O6zkcZju3dMAn9lyvDw4sEan3G+LlE2tJwnCAvpy578fiNlIJNAJdbZaVpIVQKZAPJJiiUOuoCW4ouBfd1RMZjwbQqLAOHRi/s9xCkz2X9aH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657441168; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8Z9qBI6jr5hQxHYu4QIUTWKS1t5LLKoIRIPaDexyE2w=; 
        b=XPtU33tdyUbyaV84KeCoP+wp174LSJdCnVeYwA/cKlixgSD1+/Abd4pAdlP1FBui5XFHAsbUWMneKoL9p+n6QNNx4adAM/y5aOAZWbiZ76cds+u+lY8Mj6z36+Nauz7ti8H3NksEe+xcyvvT/NmdAy2mmTLmCj35nMG6zPR9Fy8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657441168;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=8Z9qBI6jr5hQxHYu4QIUTWKS1t5LLKoIRIPaDexyE2w=;
        b=JwqzRNvJMb1pQd2CEStodrEiXbnJ6ALKM37RQbO5RLfPI9Qoa/UrDRSGn4cuhC7L
        rH43rPAdUS9POlJtNzuxD4tFGgfly8T2Js2TDatPf8oR5tv3O9RFJAoIRNVckOmZq1H
        kM9eG/YLTybBnsaOIF3q01OnwaKqqP0dbWj16JJI=
Received: from edelgard.icenowy.me (59.41.163.237 [59.41.163.237]) by mx.zohomail.com
        with SMTPS id 1657441166629543.6866088183991; Sun, 10 Jul 2022 01:19:26 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 2/3] pinctrl: sunxi: add support for R329 CPUX pin controller
Date:   Sun, 10 Jul 2022 16:18:52 +0800
Message-Id: <20220710081853.1699028-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220710081853.1699028-1-uwu@icenowy.me>
References: <20220710081853.1699028-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 SoC has two pin controllers similar to ones on previous
SoCs, one in CPUX power domain and another in CPUS.

This patch adds support for the CPUX domain pin controller.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
Changes in v2:
- Fixes of the pin configuration array suggested by Sameul Holland.
- Update the copyright part to cover my work outside Sipeed.
- Added Maxime's ACK.

 drivers/pinctrl/sunxi/Kconfig               |   5 +
 drivers/pinctrl/sunxi/Makefile              |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c | 412 ++++++++++++++++++++
 3 files changed, 418 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 7a7bcdc198a3..bc97610a79c9 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -126,4 +126,9 @@ config PINCTRL_SUN50I_H616_R
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329
+	bool "Support for the Allwinner R329 PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index d3440c42b9d6..e33f7c5f1ff9 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
 obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
new file mode 100644
index 000000000000..8d39dbfeebb6
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner R329 SoC pinctrl driver.
+ *
+ * Copyright (C) 2021 Shenzhen Sipeed Technology Co., Ltd
+ * Copyright (C) 2022 Icenowy Zheng <uwu@icenowy.me>
+ *
+ * based on the H616 pinctrl driver, which is:
+ *   Copyright (C) 2020 Arm Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin r329_pins[] = {
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PB_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* MCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PB_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* LRCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PB_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "i2s0"),		/* BCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PB_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout0"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din1"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PB_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION(0x4, "i2s0_dout1"),
+		  SUNXI_FUNCTION(0x5, "i2s0_din0"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PB_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM6 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT2 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PB_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM7 */
+		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT3 */
+		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PB_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "ir_tx"),
+		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM8 */
+		  SUNXI_FUNCTION(0x4, "ir_rx"),
+		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PB_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* WP */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* CLK */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
+		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "spi0")),		/* HOLD */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
+		  SUNXI_FUNCTION(0x3, "mmc0")),		/* RST */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x5, "boot_sel")),
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPEN */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ6 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPPP */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ5 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* PWREN */
+		  SUNXI_FUNCTION(0x4, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ4 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CMD */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQS */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DATA */
+		  SUNXI_FUNCTION(0x4, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ2 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* RST */
+		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
+		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
+		  SUNXI_FUNCTION(0x3, "sim0"),		/* DET */
+		  SUNXI_FUNCTION(0x4, "spdif_in"),
+		  SUNXI_FUNCTION(0x5, "spdif_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_clk"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d2"),
+		  /* 0x4 is also mmc1_d2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x4, "mmc1_clk"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d0"),
+		  SUNXI_FUNCTION(0x3, "mmc1_cmd"),
+		  SUNXI_FUNCTION(0x4, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x5, "pll"),		/* LOCK_DBG */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x3, "mmc1_clk"),
+		  /* 0x4 is also mmc1_d1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d2"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d0"),
+		  /* 0x4 is also mmc1_d0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "mmc1_d3"),
+		  SUNXI_FUNCTION(0x3, "mmc1_d1"),
+		  SUNXI_FUNCTION(0x4, "mmc1_cmd"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* MCLK */
+		  SUNXI_FUNCTION(0x4, "ledc"),		/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* LRCK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "i2s1"),		/* BCLK */
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout0"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din1"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "i2s1_dout1"),
+		  SUNXI_FUNCTION(0x4, "i2s1_din0"),
+		  SUNXI_FUNCTION(0x5, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI/DBI-SDO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
+		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
+		  SUNXI_FUNCTION(0x3, "spi1_cs"),	/* CS/DBI-CSX */
+		  SUNXI_FUNCTION(0x4, "spi1_hold"),	/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "spi1_clk"),	/* CLK/DBI-SCLK */
+		  SUNXI_FUNCTION(0x4, "spi1_wp"),	/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI/SPI-DBO */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
+		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "spi1"),		/* WP/DBI-TE */
+		  SUNXI_FUNCTION(0x4, "ledc"),		/* DO */
+		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
+};
+static const unsigned int r329_irq_bank_map[] = { 1, 5, 6, 7 };
+
+static const struct sunxi_pinctrl_desc r329_pinctrl_data = {
+	.pins = r329_pins,
+	.npins = ARRAY_SIZE(r329_pins),
+	.irq_banks = ARRAY_SIZE(r329_irq_bank_map),
+	.irq_bank_map = r329_irq_bank_map,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int r329_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev, &r329_pinctrl_data);
+}
+
+static const struct of_device_id r329_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-pinctrl", },
+	{}
+};
+
+static struct platform_driver r329_pinctrl_driver = {
+	.probe	= r329_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-pinctrl",
+		.of_match_table	= r329_pinctrl_match,
+	},
+};
+builtin_platform_driver(r329_pinctrl_driver);
-- 
2.36.0

