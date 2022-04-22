Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A850B50BE33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiDVRN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbiDVRMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187139136B;
        Fri, 22 Apr 2022 10:09:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 833F51F46AF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647377;
        bh=xKsayHojt26SxtKzfAYPIuwAwQh6HxgpvHEntOE+k3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjYSmHOEN4Ag8n4LI4jo3H1QHuhyBRJmfZvvCNTOAJa2x4RAgIl5fMEmIKoLOrDWL
         ao/h1yzUnbnzRKlUygLnvbU5eYEvSnZBIRDeefNksxxNbA/2GtjNktiPqbZmPlreBi
         KjNUNR8V1jh+eCECQvdYiP3e9Jbr8F2edz9qszGvBp593nOyH6AzGRhWjle3zJXxU7
         IVgxVMHho1neiXoTNixiyjwwcdD7G41sAelMAQd6SD87GZ129v9opZ/QIdxdGZS3LB
         gjrZA/B2ei0RhktmbfOlJdOnl5gB8h1A/VU0wyXp4gWEeVYTK6ec1ACOpnhHuOabAU
         dBeeJjz7ea7Qw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E04AE480C1C; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 13/19] pinctrl/rockchip: add rk3588 support
Date:   Fri, 22 Apr 2022 19:09:14 +0200
Message-Id: <20220422170920.401914-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add pinctrl support for RK3588.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
[merged in downstream fixes, simplified register lookup logic for better
maintanence at the cost of a bit more static const memory and fixed some
incorrect registers]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 300 ++++++++++++++++++++++++++++-
 drivers/pinctrl/pinctrl-rockchip.h | 166 ++++++++++++++++
 2 files changed, 465 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 012cd2f0d85b..db2489a785d4 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -103,6 +103,25 @@
 		},							\
 	}
 
+#define PIN_BANK_IOMUX_FLAGS_PULL_FLAGS(id, pins, label, iom0, iom1,	\
+					iom2, iom3, pull0, pull1,	\
+					pull2, pull3)			\
+	{								\
+		.bank_num	= id,					\
+		.nr_pins	= pins,					\
+		.name		= label,				\
+		.iomux		= {					\
+			{ .type = iom0, .offset = -1 },			\
+			{ .type = iom1, .offset = -1 },			\
+			{ .type = iom2, .offset = -1 },			\
+			{ .type = iom3, .offset = -1 },			\
+		},							\
+		.pull_type[0] = pull0,					\
+		.pull_type[1] = pull1,					\
+		.pull_type[2] = pull2,					\
+		.pull_type[3] = pull3,					\
+	}
+
 #define PIN_BANK_DRV_FLAGS_PULL_FLAGS(id, pins, label, drv0, drv1,	\
 				      drv2, drv3, pull0, pull1,		\
 				      pull2, pull3)			\
@@ -197,6 +216,9 @@
 #define RK_MUXROUTE_PMU(ID, PIN, FUNC, REG, VAL)	\
 	PIN_BANK_MUX_ROUTE_FLAGS(ID, PIN, FUNC, REG, VAL, ROCKCHIP_ROUTE_PMU)
 
+#define RK3588_PIN_BANK_FLAGS(ID, PIN, LABEL, M, P)			\
+	PIN_BANK_IOMUX_FLAGS_PULL_FLAGS(ID, PIN, LABEL, M, M, M, M, P, P, P, P)
+
 static struct regmap_config rockchip_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -822,6 +844,7 @@ static bool rockchip_get_mux_route(struct rockchip_pin_bank *bank, int pin,
 static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
+	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	int iomux_num = (pin / 8);
 	struct regmap *regmap;
 	unsigned int val;
@@ -863,6 +886,27 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	if (bank->recalced_mask & BIT(pin))
 		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
 
+	if (ctrl->type == RK3588) {
+		if (bank->bank_num == 0) {
+			if ((pin >= RK_PB4) && (pin <= RK_PD7)) {
+				u32 reg0 = 0;
+
+				reg0 = reg + 0x4000 - 0xC; /* PMU2_IOC_BASE */
+				ret = regmap_read(regmap, reg0, &val);
+				if (ret)
+					return ret;
+
+				if (!(val & BIT(8)))
+					return ((val >> bit) & mask);
+
+				reg = reg + 0x8000; /* BUS_IOC_BASE */
+				regmap = info->regmap_base;
+			}
+		} else if (bank->bank_num > 0) {
+			reg += 0x8000; /* BUS_IOC_BASE */
+		}
+	}
+
 	ret = regmap_read(regmap, reg, &val);
 	if (ret)
 		return ret;
@@ -911,6 +955,7 @@ static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
 static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 {
 	struct rockchip_pinctrl *info = bank->drvdata;
+	struct rockchip_pin_ctrl *ctrl = info->ctrl;
 	struct device *dev = info->dev;
 	int iomux_num = (pin / 8);
 	struct regmap *regmap;
@@ -951,6 +996,46 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	if (bank->recalced_mask & BIT(pin))
 		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
 
+	if (ctrl->type == RK3588) {
+		if (bank->bank_num == 0) {
+			if ((pin >= RK_PB4) && (pin <= RK_PD7)) {
+				if (mux < 8) {
+					reg += 0x4000 - 0xC; /* PMU2_IOC_BASE */
+					data = (mask << (bit + 16));
+					rmask = data | (data >> 16);
+					data |= (mux & mask) << bit;
+					ret = regmap_update_bits(regmap, reg, rmask, data);
+				} else {
+					u32 reg0 = 0;
+
+					reg0 = reg + 0x4000 - 0xC; /* PMU2_IOC_BASE */
+					data = (mask << (bit + 16));
+					rmask = data | (data >> 16);
+					data |= 8 << bit;
+					ret = regmap_update_bits(regmap, reg0, rmask, data);
+
+					reg0 = reg + 0x8000; /* BUS_IOC_BASE */
+					data = (mask << (bit + 16));
+					rmask = data | (data >> 16);
+					data |= mux << bit;
+					regmap = info->regmap_base;
+					ret |= regmap_update_bits(regmap, reg0, rmask, data);
+				}
+			} else {
+				data = (mask << (bit + 16));
+				rmask = data | (data >> 16);
+				data |= (mux & mask) << bit;
+				ret = regmap_update_bits(regmap, reg, rmask, data);
+			}
+			return ret;
+		} else if (bank->bank_num > 0) {
+			reg += 0x8000; /* BUS_IOC_BASE */
+		}
+	}
+
+	if (mux > mask)
+		return -EINVAL;
+
 	if (bank->route_mask & BIT(pin)) {
 		if (rockchip_get_mux_route(bank, pin, mux, &route_location,
 					   &route_reg, &route_val)) {
@@ -1602,6 +1687,187 @@ static int rk3568_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
 	return 0;
 }
 
+#define RK3588_PMU1_IOC_REG		(0x0000)
+#define RK3588_PMU2_IOC_REG		(0x4000)
+#define RK3588_BUS_IOC_REG		(0x8000)
+#define RK3588_VCCIO1_4_IOC_REG		(0x9000)
+#define RK3588_VCCIO3_5_IOC_REG		(0xA000)
+#define RK3588_VCCIO2_IOC_REG		(0xB000)
+#define RK3588_VCCIO6_IOC_REG		(0xC000)
+#define RK3588_EMMC_IOC_REG		(0xD000)
+
+static const u32 rk3588_ds_regs[][2] = {
+	{RK_GPIO0_A0, RK3588_PMU1_IOC_REG + 0x0010},
+	{RK_GPIO0_A4, RK3588_PMU1_IOC_REG + 0x0014},
+	{RK_GPIO0_B0, RK3588_PMU1_IOC_REG + 0x0018},
+	{RK_GPIO0_B4, RK3588_PMU2_IOC_REG + 0x0014},
+	{RK_GPIO0_C0, RK3588_PMU2_IOC_REG + 0x0018},
+	{RK_GPIO0_C4, RK3588_PMU2_IOC_REG + 0x001C},
+	{RK_GPIO0_D0, RK3588_PMU2_IOC_REG + 0x0020},
+	{RK_GPIO0_D4, RK3588_PMU2_IOC_REG + 0x0024},
+	{RK_GPIO1_A0, RK3588_VCCIO1_4_IOC_REG + 0x0020},
+	{RK_GPIO1_A4, RK3588_VCCIO1_4_IOC_REG + 0x0024},
+	{RK_GPIO1_B0, RK3588_VCCIO1_4_IOC_REG + 0x0028},
+	{RK_GPIO1_B4, RK3588_VCCIO1_4_IOC_REG + 0x002C},
+	{RK_GPIO1_C0, RK3588_VCCIO1_4_IOC_REG + 0x0030},
+	{RK_GPIO1_C4, RK3588_VCCIO1_4_IOC_REG + 0x0034},
+	{RK_GPIO1_D0, RK3588_VCCIO1_4_IOC_REG + 0x0038},
+	{RK_GPIO1_D4, RK3588_VCCIO1_4_IOC_REG + 0x003C},
+	{RK_GPIO2_A0, RK3588_EMMC_IOC_REG + 0x0040},
+	{RK_GPIO2_A4, RK3588_VCCIO3_5_IOC_REG + 0x0044},
+	{RK_GPIO2_B0, RK3588_VCCIO3_5_IOC_REG + 0x0048},
+	{RK_GPIO2_B4, RK3588_VCCIO3_5_IOC_REG + 0x004C},
+	{RK_GPIO2_C0, RK3588_VCCIO3_5_IOC_REG + 0x0050},
+	{RK_GPIO2_C4, RK3588_VCCIO3_5_IOC_REG + 0x0054},
+	{RK_GPIO2_D0, RK3588_EMMC_IOC_REG + 0x0058},
+	{RK_GPIO2_D4, RK3588_EMMC_IOC_REG + 0x005C},
+	{RK_GPIO3_A0, RK3588_VCCIO3_5_IOC_REG + 0x0060},
+	{RK_GPIO3_A4, RK3588_VCCIO3_5_IOC_REG + 0x0064},
+	{RK_GPIO3_B0, RK3588_VCCIO3_5_IOC_REG + 0x0068},
+	{RK_GPIO3_B4, RK3588_VCCIO3_5_IOC_REG + 0x006C},
+	{RK_GPIO3_C0, RK3588_VCCIO3_5_IOC_REG + 0x0070},
+	{RK_GPIO3_C4, RK3588_VCCIO3_5_IOC_REG + 0x0074},
+	{RK_GPIO3_D0, RK3588_VCCIO3_5_IOC_REG + 0x0078},
+	{RK_GPIO3_D4, RK3588_VCCIO3_5_IOC_REG + 0x007C},
+	{RK_GPIO4_A0, RK3588_VCCIO6_IOC_REG + 0x0080},
+	{RK_GPIO4_A4, RK3588_VCCIO6_IOC_REG + 0x0084},
+	{RK_GPIO4_B0, RK3588_VCCIO6_IOC_REG + 0x0088},
+	{RK_GPIO4_B4, RK3588_VCCIO6_IOC_REG + 0x008C},
+	{RK_GPIO4_C0, RK3588_VCCIO6_IOC_REG + 0x0090},
+	{RK_GPIO4_C2, RK3588_VCCIO3_5_IOC_REG + 0x0090},
+	{RK_GPIO4_C4, RK3588_VCCIO3_5_IOC_REG + 0x0094},
+	{RK_GPIO4_D0, RK3588_VCCIO2_IOC_REG + 0x0098},
+	{RK_GPIO4_D4, RK3588_VCCIO2_IOC_REG + 0x009C},
+};
+
+static const u32 rk3588_p_regs[][2] = {
+	{RK_GPIO0_A0, RK3588_PMU1_IOC_REG + 0x0020},
+	{RK_GPIO0_B0, RK3588_PMU1_IOC_REG + 0x0024},
+	{RK_GPIO0_B5, RK3588_PMU2_IOC_REG + 0x0028},
+	{RK_GPIO0_C0, RK3588_PMU2_IOC_REG + 0x002C},
+	{RK_GPIO0_D0, RK3588_PMU2_IOC_REG + 0x0030},
+	{RK_GPIO1_A0, RK3588_VCCIO1_4_IOC_REG + 0x0110},
+	{RK_GPIO1_B0, RK3588_VCCIO1_4_IOC_REG + 0x0114},
+	{RK_GPIO1_C0, RK3588_VCCIO1_4_IOC_REG + 0x0118},
+	{RK_GPIO1_D0, RK3588_VCCIO1_4_IOC_REG + 0x011C},
+	{RK_GPIO2_A0, RK3588_EMMC_IOC_REG + 0x0120},
+	{RK_GPIO2_A6, RK3588_VCCIO3_5_IOC_REG + 0x0120},
+	{RK_GPIO2_B0, RK3588_VCCIO3_5_IOC_REG + 0x0124},
+	{RK_GPIO2_C0, RK3588_VCCIO3_5_IOC_REG + 0x0128},
+	{RK_GPIO2_D0, RK3588_EMMC_IOC_REG + 0x012C},
+	{RK_GPIO3_A0, RK3588_VCCIO3_5_IOC_REG + 0x0130},
+	{RK_GPIO3_B0, RK3588_VCCIO3_5_IOC_REG + 0x0134},
+	{RK_GPIO3_C0, RK3588_VCCIO3_5_IOC_REG + 0x0138},
+	{RK_GPIO3_D0, RK3588_VCCIO3_5_IOC_REG + 0x013C},
+	{RK_GPIO4_A0, RK3588_VCCIO6_IOC_REG + 0x0140},
+	{RK_GPIO4_B0, RK3588_VCCIO6_IOC_REG + 0x0144},
+	{RK_GPIO4_C0, RK3588_VCCIO6_IOC_REG + 0x0148},
+	{RK_GPIO4_C2, RK3588_VCCIO3_5_IOC_REG + 0x0148},
+	{RK_GPIO4_D0, RK3588_VCCIO2_IOC_REG + 0x014C},
+};
+
+static const u32 rk3588_smt_regs[][2] = {
+	{RK_GPIO0_A0, RK3588_PMU1_IOC_REG + 0x0030},
+	{RK_GPIO0_B0, RK3588_PMU1_IOC_REG + 0x0034},
+	{RK_GPIO0_B5, RK3588_PMU2_IOC_REG + 0x0040},
+	{RK_GPIO0_C0, RK3588_PMU2_IOC_REG + 0x0044},
+	{RK_GPIO0_D0, RK3588_PMU2_IOC_REG + 0x0048},
+	{RK_GPIO1_A0, RK3588_VCCIO1_4_IOC_REG + 0x0210},
+	{RK_GPIO1_B0, RK3588_VCCIO1_4_IOC_REG + 0x0214},
+	{RK_GPIO1_C0, RK3588_VCCIO1_4_IOC_REG + 0x0218},
+	{RK_GPIO1_D0, RK3588_VCCIO1_4_IOC_REG + 0x021C},
+	{RK_GPIO2_A0, RK3588_EMMC_IOC_REG + 0x0220},
+	{RK_GPIO2_A6, RK3588_VCCIO3_5_IOC_REG + 0x0220},
+	{RK_GPIO2_B0, RK3588_VCCIO3_5_IOC_REG + 0x0224},
+	{RK_GPIO2_C0, RK3588_VCCIO3_5_IOC_REG + 0x0228},
+	{RK_GPIO2_D0, RK3588_EMMC_IOC_REG + 0x022C},
+	{RK_GPIO3_A0, RK3588_VCCIO3_5_IOC_REG + 0x0230},
+	{RK_GPIO3_B0, RK3588_VCCIO3_5_IOC_REG + 0x0234},
+	{RK_GPIO3_C0, RK3588_VCCIO3_5_IOC_REG + 0x0238},
+	{RK_GPIO3_D0, RK3588_VCCIO3_5_IOC_REG + 0x023C},
+	{RK_GPIO4_A0, RK3588_VCCIO6_IOC_REG + 0x0240},
+	{RK_GPIO4_B0, RK3588_VCCIO6_IOC_REG + 0x0244},
+	{RK_GPIO4_C0, RK3588_VCCIO6_IOC_REG + 0x0248},
+	{RK_GPIO4_C2, RK3588_VCCIO3_5_IOC_REG + 0x0248},
+	{RK_GPIO4_D0, RK3588_VCCIO2_IOC_REG + 0x024C},
+};
+
+#define RK3588_PULL_BITS_PER_PIN		2
+#define RK3588_PULL_PINS_PER_REG		8
+
+static int rk3588_calc_pull_reg_and_bit(struct rockchip_pin_bank *bank,
+					int pin_num, struct regmap **regmap,
+					int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	u8 bank_num = bank->bank_num;
+	u32 pin = bank_num * 32 + pin_num;
+	int i;
+
+	for (i = ARRAY_SIZE(rk3588_p_regs) - 1; i >= 0; i--) {
+		if (pin >= rk3588_p_regs[i][0]) {
+			*reg = rk3588_p_regs[i][1];
+			*regmap = info->regmap_base;
+			*bit = pin_num % RK3588_PULL_PINS_PER_REG;
+			*bit *= RK3588_PULL_BITS_PER_PIN;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define RK3588_DRV_BITS_PER_PIN		4
+#define RK3588_DRV_PINS_PER_REG		4
+
+static int rk3588_calc_drv_reg_and_bit(struct rockchip_pin_bank *bank,
+				       int pin_num, struct regmap **regmap,
+				       int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	u8 bank_num = bank->bank_num;
+	u32 pin = bank_num * 32 + pin_num;
+	int i;
+
+	for (i = ARRAY_SIZE(rk3588_ds_regs) - 1; i >= 0; i--) {
+		if (pin >= rk3588_ds_regs[i][0]) {
+			*reg = rk3588_ds_regs[i][1];
+			*regmap = info->regmap_base;
+			*bit = pin_num % RK3588_DRV_PINS_PER_REG;
+			*bit *= RK3588_DRV_BITS_PER_PIN;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+#define RK3588_SMT_BITS_PER_PIN		1
+#define RK3588_SMT_PINS_PER_REG		8
+
+static int rk3588_calc_schmitt_reg_and_bit(struct rockchip_pin_bank *bank,
+					   int pin_num,
+					   struct regmap **regmap,
+					   int *reg, u8 *bit)
+{
+	struct rockchip_pinctrl *info = bank->drvdata;
+	u8 bank_num = bank->bank_num;
+	u32 pin = bank_num * 32 + pin_num;
+	int i;
+
+	for (i = ARRAY_SIZE(rk3588_smt_regs) - 1; i >= 0; i--) {
+		if (pin >= rk3588_smt_regs[i][0]) {
+			*reg = rk3588_smt_regs[i][1];
+			*regmap = info->regmap_base;
+			*bit = pin_num % RK3588_SMT_PINS_PER_REG;
+			*bit *= RK3588_SMT_BITS_PER_PIN;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int rockchip_perpin_drv_list[DRV_TYPE_MAX][8] = {
 	{ 2, 4, 8, 12, -1, -1, -1, -1 },
 	{ 3, 6, 9, 12, -1, -1, -1, -1 },
@@ -1707,7 +1973,11 @@ static int rockchip_set_drive_perpin(struct rockchip_pin_bank *bank,
 	ret = ctrl->drv_calc_reg(bank, pin_num, &regmap, &reg, &bit);
 	if (ret)
 		return ret;
-	if (ctrl->type == RK3568) {
+	if (ctrl->type == RK3588) {
+		rmask_bits = RK3588_DRV_BITS_PER_PIN;
+		ret = strength;
+		goto config;
+	} else if (ctrl->type == RK3568) {
 		rmask_bits = RK3568_DRV_BITS_PER_PIN;
 		ret = (1 << (strength + 1)) - 1;
 		goto config;
@@ -1840,6 +2110,7 @@ static int rockchip_get_pull(struct rockchip_pin_bank *bank, int pin_num)
 	case RK3308:
 	case RK3368:
 	case RK3399:
+	case RK3588:
 		pull_type = bank->pull_type[pin_num / 8];
 		data >>= bit;
 		data &= (1 << RK3188_PULL_BITS_PER_PIN) - 1;
@@ -1888,6 +2159,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank *bank,
 	case RK3368:
 	case RK3399:
 	case RK3568:
+	case RK3588:
 		pull_type = bank->pull_type[pin_num / 8];
 		ret = -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(rockchip_pull_list[pull_type]);
@@ -2135,6 +2407,7 @@ static bool rockchip_pinconf_pull_valid(struct rockchip_pin_ctrl *ctrl,
 	case RK3368:
 	case RK3399:
 	case RK3568:
+	case RK3588:
 		return (pull != PIN_CONFIG_BIAS_PULL_PIN_DEFAULT);
 	}
 
@@ -3238,6 +3511,29 @@ static struct rockchip_pin_ctrl rk3568_pin_ctrl = {
 	.schmitt_calc_reg	= rk3568_calc_schmitt_reg_and_bit,
 };
 
+static struct rockchip_pin_bank rk3588_pin_banks[] = {
+	RK3588_PIN_BANK_FLAGS(0, 32, "gpio0",
+			      IOMUX_WIDTH_4BIT, PULL_TYPE_IO_1V8_ONLY),
+	RK3588_PIN_BANK_FLAGS(1, 32, "gpio1",
+			      IOMUX_WIDTH_4BIT, PULL_TYPE_IO_1V8_ONLY),
+	RK3588_PIN_BANK_FLAGS(2, 32, "gpio2",
+			      IOMUX_WIDTH_4BIT, PULL_TYPE_IO_1V8_ONLY),
+	RK3588_PIN_BANK_FLAGS(3, 32, "gpio3",
+			      IOMUX_WIDTH_4BIT, PULL_TYPE_IO_1V8_ONLY),
+	RK3588_PIN_BANK_FLAGS(4, 32, "gpio4",
+			      IOMUX_WIDTH_4BIT, PULL_TYPE_IO_1V8_ONLY),
+};
+
+static struct rockchip_pin_ctrl rk3588_pin_ctrl = {
+	.pin_banks		= rk3588_pin_banks,
+	.nr_banks		= ARRAY_SIZE(rk3588_pin_banks),
+	.label			= "RK3588-GPIO",
+	.type			= RK3588,
+	.pull_calc_reg		= rk3588_calc_pull_reg_and_bit,
+	.drv_calc_reg		= rk3588_calc_drv_reg_and_bit,
+	.schmitt_calc_reg	= rk3588_calc_schmitt_reg_and_bit,
+};
+
 static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 	{ .compatible = "rockchip,px30-pinctrl",
 		.data = &px30_pin_ctrl },
@@ -3269,6 +3565,8 @@ static const struct of_device_id rockchip_pinctrl_dt_match[] = {
 		.data = &rk3399_pin_ctrl },
 	{ .compatible = "rockchip,rk3568-pinctrl",
 		.data = &rk3568_pin_ctrl },
+	{ .compatible = "rockchip,rk3588-pinctrl",
+		.data = &rk3588_pin_ctrl },
 	{},
 };
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4992a048acbc..3505b5c5f0e5 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -18,6 +18,171 @@
 #ifndef _PINCTRL_ROCKCHIP_H
 #define _PINCTRL_ROCKCHIP_H
 
+#define RK_GPIO0_A0	0
+#define RK_GPIO0_A1	1
+#define RK_GPIO0_A2	2
+#define RK_GPIO0_A3	3
+#define RK_GPIO0_A4	4
+#define RK_GPIO0_A5	5
+#define RK_GPIO0_A6	6
+#define RK_GPIO0_A7	7
+#define RK_GPIO0_B0	8
+#define RK_GPIO0_B1	9
+#define RK_GPIO0_B2	10
+#define RK_GPIO0_B3	11
+#define RK_GPIO0_B4	12
+#define RK_GPIO0_B5	13
+#define RK_GPIO0_B6	14
+#define RK_GPIO0_B7	15
+#define RK_GPIO0_C0	16
+#define RK_GPIO0_C1	17
+#define RK_GPIO0_C2	18
+#define RK_GPIO0_C3	19
+#define RK_GPIO0_C4	20
+#define RK_GPIO0_C5	21
+#define RK_GPIO0_C6	22
+#define RK_GPIO0_C7	23
+#define RK_GPIO0_D0	24
+#define RK_GPIO0_D1	25
+#define RK_GPIO0_D2	26
+#define RK_GPIO0_D3	27
+#define RK_GPIO0_D4	28
+#define RK_GPIO0_D5	29
+#define RK_GPIO0_D6	30
+#define RK_GPIO0_D7	31
+
+#define RK_GPIO1_A0	32
+#define RK_GPIO1_A1	33
+#define RK_GPIO1_A2	34
+#define RK_GPIO1_A3	35
+#define RK_GPIO1_A4	36
+#define RK_GPIO1_A5	37
+#define RK_GPIO1_A6	38
+#define RK_GPIO1_A7	39
+#define RK_GPIO1_B0	40
+#define RK_GPIO1_B1	41
+#define RK_GPIO1_B2	42
+#define RK_GPIO1_B3	43
+#define RK_GPIO1_B4	44
+#define RK_GPIO1_B5	45
+#define RK_GPIO1_B6	46
+#define RK_GPIO1_B7	47
+#define RK_GPIO1_C0	48
+#define RK_GPIO1_C1	49
+#define RK_GPIO1_C2	50
+#define RK_GPIO1_C3	51
+#define RK_GPIO1_C4	52
+#define RK_GPIO1_C5	53
+#define RK_GPIO1_C6	54
+#define RK_GPIO1_C7	55
+#define RK_GPIO1_D0	56
+#define RK_GPIO1_D1	57
+#define RK_GPIO1_D2	58
+#define RK_GPIO1_D3	59
+#define RK_GPIO1_D4	60
+#define RK_GPIO1_D5	61
+#define RK_GPIO1_D6	62
+#define RK_GPIO1_D7	63
+
+#define RK_GPIO2_A0	64
+#define RK_GPIO2_A1	65
+#define RK_GPIO2_A2	66
+#define RK_GPIO2_A3	67
+#define RK_GPIO2_A4	68
+#define RK_GPIO2_A5	69
+#define RK_GPIO2_A6	70
+#define RK_GPIO2_A7	71
+#define RK_GPIO2_B0	72
+#define RK_GPIO2_B1	73
+#define RK_GPIO2_B2	74
+#define RK_GPIO2_B3	75
+#define RK_GPIO2_B4	76
+#define RK_GPIO2_B5	77
+#define RK_GPIO2_B6	78
+#define RK_GPIO2_B7	79
+#define RK_GPIO2_C0	80
+#define RK_GPIO2_C1	81
+#define RK_GPIO2_C2	82
+#define RK_GPIO2_C3	83
+#define RK_GPIO2_C4	84
+#define RK_GPIO2_C5	85
+#define RK_GPIO2_C6	86
+#define RK_GPIO2_C7	87
+#define RK_GPIO2_D0	88
+#define RK_GPIO2_D1	89
+#define RK_GPIO2_D2	90
+#define RK_GPIO2_D3	91
+#define RK_GPIO2_D4	92
+#define RK_GPIO2_D5	93
+#define RK_GPIO2_D6	94
+#define RK_GPIO2_D7	95
+
+#define RK_GPIO3_A0	96
+#define RK_GPIO3_A1	97
+#define RK_GPIO3_A2	98
+#define RK_GPIO3_A3	99
+#define RK_GPIO3_A4	100
+#define RK_GPIO3_A5	101
+#define RK_GPIO3_A6	102
+#define RK_GPIO3_A7	103
+#define RK_GPIO3_B0	104
+#define RK_GPIO3_B1	105
+#define RK_GPIO3_B2	106
+#define RK_GPIO3_B3	107
+#define RK_GPIO3_B4	108
+#define RK_GPIO3_B5	109
+#define RK_GPIO3_B6	110
+#define RK_GPIO3_B7	111
+#define RK_GPIO3_C0	112
+#define RK_GPIO3_C1	113
+#define RK_GPIO3_C2	114
+#define RK_GPIO3_C3	115
+#define RK_GPIO3_C4	116
+#define RK_GPIO3_C5	117
+#define RK_GPIO3_C6	118
+#define RK_GPIO3_C7	119
+#define RK_GPIO3_D0	120
+#define RK_GPIO3_D1	121
+#define RK_GPIO3_D2	122
+#define RK_GPIO3_D3	123
+#define RK_GPIO3_D4	124
+#define RK_GPIO3_D5	125
+#define RK_GPIO3_D6	126
+#define RK_GPIO3_D7	127
+
+#define RK_GPIO4_A0	128
+#define RK_GPIO4_A1	129
+#define RK_GPIO4_A2	130
+#define RK_GPIO4_A3	131
+#define RK_GPIO4_A4	132
+#define RK_GPIO4_A5	133
+#define RK_GPIO4_A6	134
+#define RK_GPIO4_A7	135
+#define RK_GPIO4_B0	136
+#define RK_GPIO4_B1	137
+#define RK_GPIO4_B2	138
+#define RK_GPIO4_B3	139
+#define RK_GPIO4_B4	140
+#define RK_GPIO4_B5	141
+#define RK_GPIO4_B6	142
+#define RK_GPIO4_B7	143
+#define RK_GPIO4_C0	144
+#define RK_GPIO4_C1	145
+#define RK_GPIO4_C2	146
+#define RK_GPIO4_C3	147
+#define RK_GPIO4_C4	148
+#define RK_GPIO4_C5	149
+#define RK_GPIO4_C6	150
+#define RK_GPIO4_C7	151
+#define RK_GPIO4_D0	152
+#define RK_GPIO4_D1	153
+#define RK_GPIO4_D2	154
+#define RK_GPIO4_D3	155
+#define RK_GPIO4_D4	156
+#define RK_GPIO4_D5	157
+#define RK_GPIO4_D6	158
+#define RK_GPIO4_D7	159
+
 enum rockchip_pinctrl_type {
 	PX30,
 	RV1108,
@@ -30,6 +195,7 @@ enum rockchip_pinctrl_type {
 	RK3368,
 	RK3399,
 	RK3568,
+	RK3588,
 };
 
 /**
-- 
2.35.1

