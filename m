Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4C4C5819
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiBZUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBZUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:45:58 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC801B60A2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 12:45:23 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E3C15223F6;
        Sat, 26 Feb 2022 21:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645908321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq8gHgquh0jgbMncNWZSaTkUOjPHETNZUCUaSag6Og8=;
        b=UEAAxUCCtqMrS7Px9f2djd6B0VvtRcHKx5czQ2fD0uwJrjV6L1+KAPsAf6BVyYQtSKsCmo
        /+f9Xquw8+iWUT5HIS8QErUCy9gj2vCbyEFmQLDDLRhzsBQVCwjwhsVF/M2fGPKU5AuQEg
        T70+eOqN3USoG+oKrMZGhcprXMZIKXM=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/5] pinctrl: microchip-sgpio: wait until output is actually set
Date:   Sat, 26 Feb 2022 21:45:07 +0100
Message-Id: <20220226204507.2511633-6-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220226204507.2511633-1-michael@walle.cc>
References: <20220226204507.2511633-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, when a gpio value is set, the actual hardware pin gets set
asynchronously. When linux write the output register, it takes some time
until it is actually propagated to the output shift registers. If that
output port is connected to an I2C mux for example, the linux driver
assumes the I2C bus is already switched although it is not.

Fortunately, there is a single shot mode with a feedback: you can
trigger the single shot and the hardware will clear that bit once it has
finished the clocking and strobed the load signal of the shift
registers. This can take a considerable amount of time though.
Measuremens have shown that it takes up to a whole burst cycle gap which
is about 50ms on the largest setting. Therefore, we have to mark the
output bank as sleepable. To avoid unnecessary waiting, just trigger the
single shot if the value was actually changed.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 69 ++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index a5085a215b8b..80a8939ad0c0 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -64,11 +64,13 @@ struct sgpio_properties {
 #define SGPIO_LUTON_BIT_SOURCE   GENMASK(11, 0)
 
 #define SGPIO_OCELOT_AUTO_REPEAT BIT(10)
+#define SGPIO_OCELOT_SINGLE_SHOT BIT(11)
 #define SGPIO_OCELOT_PORT_WIDTH  GENMASK(8, 7)
 #define SGPIO_OCELOT_CLK_FREQ    GENMASK(19, 8)
 #define SGPIO_OCELOT_BIT_SOURCE  GENMASK(23, 12)
 
 #define SGPIO_SPARX5_AUTO_REPEAT BIT(6)
+#define SGPIO_SPARX5_SINGLE_SHOT BIT(7)
 #define SGPIO_SPARX5_PORT_WIDTH  GENMASK(4, 3)
 #define SGPIO_SPARX5_CLK_FREQ    GENMASK(19, 8)
 #define SGPIO_SPARX5_BIT_SOURCE  GENMASK(23, 12)
@@ -118,6 +120,8 @@ struct sgpio_priv {
 	struct regmap *regs;
 	const struct sgpio_properties *properties;
 	spinlock_t lock;
+	/* protects the config register and single shot mode */
+	struct mutex poll_lock;
 };
 
 struct sgpio_port_addr {
@@ -225,12 +229,64 @@ static inline void sgpio_configure_clock(struct sgpio_priv *priv, u32 clkfrq)
 	sgpio_clrsetbits(priv, REG_SIO_CLOCK, 0, clr, set);
 }
 
+static int sgpio_single_shot(struct sgpio_priv *priv)
+{
+	u32 addr = sgpio_get_addr(priv, REG_SIO_CONFIG, 0);
+	int ret, ret2;
+	u32 ctrl;
+	unsigned int single_shot;
+	unsigned int auto_repeat;
+
+	switch (priv->properties->arch) {
+	case SGPIO_ARCH_LUTON:
+		/* not supported for now */
+		return 0;
+	case SGPIO_ARCH_OCELOT:
+		single_shot = SGPIO_OCELOT_SINGLE_SHOT;
+		auto_repeat = SGPIO_OCELOT_AUTO_REPEAT;
+		break;
+	case SGPIO_ARCH_SPARX5:
+		single_shot = SGPIO_SPARX5_SINGLE_SHOT;
+		auto_repeat = SGPIO_SPARX5_AUTO_REPEAT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Trigger immediate burst. This only works when auto repeat is turned
+	 * off. Otherwise, the single shot bit will never be cleared by the
+	 * hardware. Measurements showed that an update might take as long as
+	 * the burst gap. On a LAN9668 this is about 50ms for the largest
+	 * setting.
+	 * After the manual burst, reenable the auto repeat mode again.
+	 */
+	mutex_lock(&priv->poll_lock);
+	ret = regmap_update_bits(priv->regs, addr, single_shot | auto_repeat,
+				 single_shot);
+	if (ret)
+		goto out;
+
+	ret = regmap_read_poll_timeout(priv->regs, addr, ctrl,
+				       !(ctrl & single_shot), 100, 60000);
+
+	/* reenable auto repeat mode even if there was an error */
+	ret2 = regmap_update_bits(priv->regs, addr, auto_repeat, auto_repeat);
+out:
+	mutex_unlock(&priv->poll_lock);
+
+	return ret ?: ret2;
+}
+
 static int sgpio_output_set(struct sgpio_priv *priv,
 			    struct sgpio_port_addr *addr,
 			    int value)
 {
 	unsigned int bit = SGPIO_SRC_BITS * addr->bit;
+	u32 reg = sgpio_get_addr(priv, REG_PORT_CONFIG, addr->port);
+	bool changed;
 	u32 clr, set;
+	int ret;
 
 	switch (priv->properties->arch) {
 	case SGPIO_ARCH_LUTON:
@@ -249,7 +305,16 @@ static int sgpio_output_set(struct sgpio_priv *priv,
 		return -EINVAL;
 	}
 
-	sgpio_clrsetbits(priv, REG_PORT_CONFIG, addr->port, clr, set);
+	ret = regmap_update_bits_check(priv->regs, reg, clr | set, set,
+				       &changed);
+	if (ret)
+		return ret;
+
+	if (changed) {
+		ret = sgpio_single_shot(priv);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -788,6 +853,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 	gc->of_gpio_n_cells     = 3;
 	gc->base		= -1;
 	gc->ngpio		= ngpios;
+	gc->can_sleep		= !bank->is_input;
 
 	if (bank->is_input && priv->properties->flags & SGPIO_FLAGS_HAS_IRQ) {
 		int irq = fwnode_irq_get(fwnode, 0);
@@ -848,6 +914,7 @@ static int microchip_sgpio_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 	spin_lock_init(&priv->lock);
+	mutex_init(&priv->poll_lock);
 
 	reset = devm_reset_control_get_optional_shared(&pdev->dev, "switch");
 	if (IS_ERR(reset))
-- 
2.30.2

