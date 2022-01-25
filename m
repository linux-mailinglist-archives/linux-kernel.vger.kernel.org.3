Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843449B4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576533AbiAYNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:22:49 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47315 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575982AbiAYNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643116714; x=1674652714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zEy6c3Xr7K/oyYt7/Wet9D7vJ9CLbnE1y+wa+Dz6Xns=;
  b=sIKEqSha92jvmkDnSRUrWx4GNjIDgoQ6rL5qEqxobwVwaiY87hjrd7ax
   6qgPU7mG3YyNC8QbbZ2pzgS6B8P68Ghb5w7w9Q+XW21O14O7XbNQov0g+
   A32Ixa1OulUa+l+/Qc4RsaFCJ+8BO/IAyG6W69uDelyhXOxOWgLInWbX+
   reIqLVgUeD9ku8tCVs3zkn2NVKhIpprGUb3NWCRiXPSwjbLz/mHZAWQVX
   WupQsxZQXhjaXAa3nHkOfsqB9RxbIedjCMGbeqS17Hg1x5x7rCwkatRYg
   mTOWnsO4YDmsGhIWkluvnzKP4lTYHNzj2bCXKabBmiym6tjLwONKZE1kF
   Q==;
IronPort-SDR: LLQFX5w+UQNRZF5jDfF95sy2BnM9f5Mmn7Y7WQqT0dUfBEpnvqtLQKl2E1A+IC3GdW4lM9QNMz
 Jqp/PxtWLyoPeBMwWeyoizcjPzK2ccvhZahdxGJrjoJO0vQONgHd795jjoDxRcwZFaRYZ0c2lA
 Yo7hgm2cMX9deInCfVSevm01WqBEaFsCBzi+KdNOoq7Sm0QQ0xeO3JiJc4pGL+Cto4FQ4TEP04
 oVxVDgCWcQFjn7nt69qHItKTEkFAirvqm0gW2Gom9uRGD5PXHbymRGZf37Ly9RuQAdSknl2Daa
 s7h/lrQNCokfFKWbumxKsrBD
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="146528375"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2022 06:18:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 25 Jan 2022 06:18:25 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 25 Jan 2022 06:18:23 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 2/2] pinctrl: ocelot: Add support for ServalT SoC
Date:   Tue, 25 Jan 2022 14:18:58 +0100
Message-ID: <20220125131858.309237-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220125131858.309237-1-horatiu.vultur@microchip.com>
References: <20220125131858.309237-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for ServalT pinctrl, using the ocelot driver as
basis.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 102 +++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index fc969208d904..685c79e08d40 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -695,6 +695,98 @@ static const struct pinctrl_pin_desc jaguar2_pins[] = {
 	JAGUAR2_PIN(63),
 };
 
+#define SERVALT_P(p, f0, f1, f2)					\
+static struct ocelot_pin_caps servalt_pin_##p = {			\
+	.pin = p,							\
+	.functions = {							\
+		FUNC_GPIO, FUNC_##f0, FUNC_##f1, FUNC_##f2		\
+	},								\
+}
+
+SERVALT_P(0,  SG0,        NONE,      NONE);
+SERVALT_P(1,  SG0,        NONE,      NONE);
+SERVALT_P(2,  SG0,        NONE,      NONE);
+SERVALT_P(3,  SG0,        NONE,      NONE);
+SERVALT_P(4,  IRQ0_IN,    IRQ0_OUT,  TWI_SCL_M);
+SERVALT_P(5,  IRQ1_IN,    IRQ1_OUT,  TWI_SCL_M);
+SERVALT_P(6,  UART,       NONE,      NONE);
+SERVALT_P(7,  UART,       NONE,      NONE);
+SERVALT_P(8,  SI,         SFP,       TWI_SCL_M);
+SERVALT_P(9,  PCI_WAKE,   SFP,       SI);
+SERVALT_P(10, PTP0,       SFP,       TWI_SCL_M);
+SERVALT_P(11, PTP1,       SFP,       TWI_SCL_M);
+SERVALT_P(12, REF_CLK,    SFP,       TWI_SCL_M);
+SERVALT_P(13, REF_CLK,    SFP,       TWI_SCL_M);
+SERVALT_P(14, REF_CLK,    IRQ0_OUT,  SI);
+SERVALT_P(15, REF_CLK,    IRQ1_OUT,  SI);
+SERVALT_P(16, TACHO,      SFP,       SI);
+SERVALT_P(17, PWM,        NONE,      TWI_SCL_M);
+SERVALT_P(18, PTP2,       SFP,       SI);
+SERVALT_P(19, PTP3,       SFP,       SI);
+SERVALT_P(20, UART2,      SFP,       SI);
+SERVALT_P(21, UART2,      NONE,      NONE);
+SERVALT_P(22, MIIM,       SFP,       TWI2);
+SERVALT_P(23, MIIM,       SFP,       TWI2);
+SERVALT_P(24, TWI,        NONE,      NONE);
+SERVALT_P(25, TWI,        SFP,       TWI_SCL_M);
+SERVALT_P(26, TWI_SCL_M,  SFP,       SI);
+SERVALT_P(27, TWI_SCL_M,  SFP,       SI);
+SERVALT_P(28, TWI_SCL_M,  SFP,       SI);
+SERVALT_P(29, TWI_SCL_M,  NONE,      NONE);
+SERVALT_P(30, TWI_SCL_M,  NONE,      NONE);
+SERVALT_P(31, TWI_SCL_M,  NONE,      NONE);
+SERVALT_P(32, TWI_SCL_M,  NONE,      NONE);
+SERVALT_P(33, RCVRD_CLK,  NONE,      NONE);
+SERVALT_P(34, RCVRD_CLK,  NONE,      NONE);
+SERVALT_P(35, RCVRD_CLK,  NONE,      NONE);
+SERVALT_P(36, RCVRD_CLK,  NONE,      NONE);
+
+#define SERVALT_PIN(n) {					\
+	.number = n,						\
+	.name = "GPIO_"#n,					\
+	.drv_data = &servalt_pin_##n				\
+}
+
+static const struct pinctrl_pin_desc servalt_pins[] = {
+	SERVALT_PIN(0),
+	SERVALT_PIN(1),
+	SERVALT_PIN(2),
+	SERVALT_PIN(3),
+	SERVALT_PIN(4),
+	SERVALT_PIN(5),
+	SERVALT_PIN(6),
+	SERVALT_PIN(7),
+	SERVALT_PIN(8),
+	SERVALT_PIN(9),
+	SERVALT_PIN(10),
+	SERVALT_PIN(11),
+	SERVALT_PIN(12),
+	SERVALT_PIN(13),
+	SERVALT_PIN(14),
+	SERVALT_PIN(15),
+	SERVALT_PIN(16),
+	SERVALT_PIN(17),
+	SERVALT_PIN(18),
+	SERVALT_PIN(19),
+	SERVALT_PIN(20),
+	SERVALT_PIN(21),
+	SERVALT_PIN(22),
+	SERVALT_PIN(23),
+	SERVALT_PIN(24),
+	SERVALT_PIN(25),
+	SERVALT_PIN(26),
+	SERVALT_PIN(27),
+	SERVALT_PIN(28),
+	SERVALT_PIN(29),
+	SERVALT_PIN(30),
+	SERVALT_PIN(31),
+	SERVALT_PIN(32),
+	SERVALT_PIN(33),
+	SERVALT_PIN(34),
+	SERVALT_PIN(35),
+	SERVALT_PIN(36),
+};
+
 #define SPARX5_P(p, f0, f1, f2)					\
 static struct ocelot_pin_caps sparx5_pin_##p = {			\
 	.pin = p,							\
@@ -1497,6 +1589,15 @@ static struct pinctrl_desc jaguar2_desc = {
 	.owner = THIS_MODULE,
 };
 
+static struct pinctrl_desc servalt_desc = {
+	.name = "servalt-pinctrl",
+	.pins = servalt_pins,
+	.npins = ARRAY_SIZE(servalt_pins),
+	.pctlops = &ocelot_pctl_ops,
+	.pmxops = &ocelot_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
 static struct pinctrl_desc sparx5_desc = {
 	.name = "sparx5-pinctrl",
 	.pins = sparx5_pins,
@@ -1774,6 +1875,7 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
 	{ .compatible = "mscc,serval-pinctrl", .data = &serval_desc },
 	{ .compatible = "mscc,ocelot-pinctrl", .data = &ocelot_desc },
 	{ .compatible = "mscc,jaguar2-pinctrl", .data = &jaguar2_desc },
+	{ .compatible = "mscc,servalt-pinctrl", .data = &servalt_desc },
 	{ .compatible = "microchip,sparx5-pinctrl", .data = &sparx5_desc },
 	{ .compatible = "microchip,lan966x-pinctrl", .data = &lan966x_desc },
 	{},
-- 
2.33.0

