Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8952F49B85F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357585AbiAYQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:14:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24688 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583352AbiAYQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643127073; x=1674663073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xRYkd7VewVRjl2nwBsabmztrBiW/NhQrxdxHXY44LgQ=;
  b=Zu/t+WQ3I2tThkJUySD0iMV0Oa3zpSl2R71Exf3cKUnRUKEqf20i1mjd
   aCT+SK8csG1+H3KuKg/1hgiQuBBM0M9FbHBqsGo3LrnwlMaITe1X8UhyT
   Hu4rYD5qsQLS6uGK0PJd2fzkB4DJSJGBuxfsYSZ7OL2FsnQXRUfB7m0GR
   nabVGaob40Rq2Ao8ROqSdyrWMr1PB+a6GUqA9QOHsD+UsrOiRPdSDBFrz
   lYjIFUxyVry5vaiH6ZVLRWfLwIjiSXJynbx//MWXPKYaJxLReW8+fu0RQ
   Ghh1DC6+tyl4QE4tdKmJRc1tRGBoXu110n936YTaXol2SaY9eFdrqWFYD
   w==;
IronPort-SDR: 2ZX6Jzv4KYS6XAdsDpNOkUNCRiajSPWu+JvId5T0r+V3uhUO8t/v4s34gwICPsjqRKfqhXolFb
 Dm+k7QZPq00RnqYdIqcUSj8mig5WzuaVz3bqmSYatVHzrX6Syd60hMLDfjls1zr1A6w4b0/ymf
 fXXX7+JGgIZTOJ28PF3AQBxmoO7zyXNwwsyNWI2AleCPf0gj8PwvR8Afrig/iaLeXveMPs9D19
 Y+kQ9ob4/IgsN2Q9wcebexiTGvA1r12eLJYOyBO8BqiRbmzINXtZE9l1x7V8nqFu20jKANHUDv
 IWm0SWF/xpWdVJQL7sajvG7y
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="143829729"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2022 09:11:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 25 Jan 2022 09:11:05 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 25 Jan 2022 09:11:03 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <linus.walleij@linaro.org>,
        <colin.foster@in-advantage.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Date:   Tue, 25 Jan 2022 17:12:45 +0100
Message-ID: <20220125161245.418882-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially the driver accessed the registers using u32 __iomem but then
in the blamed commit it changed it to use regmap. The problem is that now
the offset of the registers is not calculated anymore at word offset but
at byte offset. Therefore make sure to multiply the offset with word size.

Fixes: 2afbbab45c261a ("pinctrl: microchip-sgpio: update to support regmap")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 8e081c90bdb2..2999c98bbdee 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -98,6 +98,12 @@ static const struct sgpio_properties properties_sparx5 = {
 	.regoff = { 0x00, 0x06, 0x26, 0x04, 0x05, 0x2a, 0x32, 0x3a, 0x3e, 0x42 },
 };
 
+static const struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+};
+
 static const char * const functions[] = { "gpio" };
 
 struct sgpio_bank {
@@ -137,7 +143,7 @@ static inline int sgpio_addr_to_pin(struct sgpio_priv *priv, int port, int bit)
 
 static inline u32 sgpio_get_addr(struct sgpio_priv *priv, u32 rno, u32 off)
 {
-	return priv->properties->regoff[rno] + off;
+	return (priv->properties->regoff[rno] + off) * regmap_config.reg_stride;
 }
 
 static u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
@@ -821,11 +827,6 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
 	struct clk *clk;
 	u32 __iomem *regs;
 	u32 val;
-	struct regmap_config regmap_config = {
-		.reg_bits = 32,
-		.val_bits = 32,
-		.reg_stride = 4,
-	};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-- 
2.33.0

