Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F756CDB6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGJIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGJIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:20:06 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F233CE34;
        Sun, 10 Jul 2022 01:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657441174; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FIM+EX7ovvlLzGXv1cKalp+eDlLfAiQvQr+jEICi4yoD+lb5hIPBWR4gDa7Vnho6TLH8hkQXiOW+hpGAtQlUIF8ZXvq2MDqirmrV2j+IGbGLkmAJtusVfMfTvYiSQQoN9Ez3Nt7Z5qvo+ciIopnczP/S60JkKz6oK9fGbUxoC2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657441174; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YNNPisOclSY1WNs3Yuqxf8pp+Fad1U2feZ/xWyTJay0=; 
        b=N0XZj2QGIvwKHRaMC8BJppj2lk5iebV+3ErbfJh1rv7oP+YKdfxHkqkfdjx/QnwrzZb9sFqjycmiyutoPvWwOC8eKuZlDmjBdHZJ3VdSs79Y0gNKZGhUTkZNWlM9k8/+0KaXCPFypj2s136H6c+WljHIXCNrHMsjUmhhkG4OWH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657441174;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=YNNPisOclSY1WNs3Yuqxf8pp+Fad1U2feZ/xWyTJay0=;
        b=Qc5CtGcTpqKp5Q1IJB1scLEnU0WZxzuU4JhM+vzGkLNHWlsm1DFEE4QSF929y7Qh
        H7nho++5YRV5cx+dTyyjMKX+6w9FgzeiJjHmtRWn+gHLiQG02Z79h6Aefzxdf3GulYL
        2NJ7XIwTOxe3l12dHmma2m4M8a5eHZuRA97LlTJI=
Received: from edelgard.icenowy.me (59.41.163.237 [59.41.163.237]) by mx.zohomail.com
        with SMTPS id 165744117214261.50355713094916; Sun, 10 Jul 2022 01:19:32 -0700 (PDT)
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
Subject: [PATCH v2 3/3] pinctrl: sunxi: add support for R329 R-PIO pin controller
Date:   Sun, 10 Jul 2022 16:18:53 +0800
Message-Id: <20220710081853.1699028-4-uwu@icenowy.me>
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

Allwinner R320 SoC has a pin controller in the CPUS power domain.

Add support for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
Changes in v2:
- Fixes of the driver name in comment.
- Update the copyright part to cover my work outside Sipeed.
- Added Maxime's ACK.

 drivers/pinctrl/sunxi/Kconfig                 |   5 +
 drivers/pinctrl/sunxi/Makefile                |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 293 ++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index bc97610a79c9..9a005b719ac4 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -131,4 +131,9 @@ config PINCTRL_SUN50I_R329
 	default ARM64 && ARCH_SUNXI
 	select PINCTRL_SUNXI
 
+config PINCTRL_SUN50I_R329_R
+	bool "Support for the Allwinner R329 R-PIO"
+	default ARM64 && ARCH_SUNXI
+	select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index e33f7c5f1ff9..245840a7959e 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
 obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
 obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
+obj-$(CONFIG_PINCTRL_SUN50I_R329_R)	+= pinctrl-sun50i-r329-r.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
new file mode 100644
index 000000000000..0d9b5a5a0ee2
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner R329 R_PIO pin controller driver
+ *
+ * Copyright (C) 2021 Shenzhen Sipeed Technology Co., Ltd.
+ * Copyright (C) 2022 Icenowy Zheng <uwu@icenowy.me>
+ *
+ * Based on former work, which is:
+ *   Copyright (C) 2020 Arm Ltd.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun50i_r329_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s0"),		/* LRCK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA3 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s0"),		/* BCLK */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA2 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PL_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s0_dout0"),
+		  SUNXI_FUNCTION(0x3, "s_i2s0_din1"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA1 */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PL_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s0_dout1"),
+		  SUNXI_FUNCTION(0x3, "s_i2s0_din0"),
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* DATA0 */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PL_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2s0"),		/* MCLK */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "s_dmic"),	/* CLK */
+		  SUNXI_FUNCTION(0x5, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PL_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PL_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM4 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PL_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x5, "s_pwm"),		/* PWM5 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PL_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x4, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),	/* PL_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),	/* PL_EINT10 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PM_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* CK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PM_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DO */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x5, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PM_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PM_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PM_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DI */
+		  SUNXI_FUNCTION(0x4, "s_i2c"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PM_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "nmi"),
+		  SUNXI_FUNCTION(0x3, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x4, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PM_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_ir"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "clock"),		/* X32KFOUT */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 7)),	/* PM_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(M, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 8)),	/* PM_EINT8 */
+	/* Hole */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PN_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDC */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PN_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* MDIO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PN_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PN_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PN_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PN_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PN_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PN_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXERR */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PN_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXCTL/TXEN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PN_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD3 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PN_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PN_EINT11 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 12),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* RXCTL/CRS_DV */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PN_EINT12 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 13),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD2 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PN_EINT13 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 14),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD1 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PN_EINT14 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 15),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* TXD0 */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 15)),	/* PN_EINT15 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 16),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* EPHY-25M */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 16)),	/* PN_EINT16 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 17),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "emac"),		/* CLKIN */
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 17)),	/* PN_EINT17 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 18),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 18)),	/* PN_EINT18 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 19),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 19)),	/* PN_EINT19 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 20),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 20)),	/* PN_EINT20 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 21),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 21)),	/* PN_EINT21 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 22),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 22)),	/* PN_EINT22 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(N, 23),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 23)),	/* PN_EINT23 */
+};
+
+static const struct sunxi_pinctrl_desc sun50i_r329_r_pinctrl_data = {
+	.pins = sun50i_r329_r_pins,
+	.npins = ARRAY_SIZE(sun50i_r329_r_pins),
+	.pin_base = PL_BASE,
+	.irq_banks = 3,
+	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
+};
+
+static int sun50i_r329_r_pinctrl_probe(struct platform_device *pdev)
+{
+	return sunxi_pinctrl_init(pdev,
+				  &sun50i_r329_r_pinctrl_data);
+}
+
+static const struct of_device_id sun50i_r329_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun50i-r329-r-pinctrl", },
+	{}
+};
+
+static struct platform_driver sun50i_r329_r_pinctrl_driver = {
+	.probe	= sun50i_r329_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun50i-r329-r-pinctrl",
+		.of_match_table	= sun50i_r329_r_pinctrl_match,
+	},
+};
-- 
2.36.0

