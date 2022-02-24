Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC64C310E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiBXQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiBXQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:12:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB11141FDE;
        Thu, 24 Feb 2022 08:12:15 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 92435223EF;
        Thu, 24 Feb 2022 17:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645719038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+y+BxTTNJQzbFxHr7bW2D/PlpySv4+4O8TfivZabfgA=;
        b=lQ8s3GalJm274l7UbnEJjMk4HOjcnSD7cwVf0kPLliB2uiaEfq1YKXJ3M+Pn0ONKm6MOWV
        emEhxjIhzecoo3k5T+yT2aMgx/SkDfUYTcwYP5FE3btuUusw24q4SGBDwMajRxcKv7uerw
        1P66HZWTMhAjDC2PwHdHfjzcrvzPpRM=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 3/5] pinctrl: microchip-sgpio: use regmap_update_bits()
Date:   Thu, 24 Feb 2022 17:10:19 +0100
Message-Id: <20220224161021.2197263-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224161021.2197263-1-michael@walle.cc>
References: <20220224161021.2197263-1-michael@walle.cc>
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

Convert sgpio_clrsetbits() to use regmap_update_bits() and drop the
spinlocks because regmap already takes care of the locking.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 31c4401f725e..f01ca94943da 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -168,12 +168,11 @@ static void sgpio_writel(struct sgpio_priv *priv,
 static inline void sgpio_clrsetbits(struct sgpio_priv *priv,
 				    u32 rno, u32 off, u32 clear, u32 set)
 {
-	u32 val = sgpio_readl(priv, rno, off);
-
-	val &= ~clear;
-	val |= set;
+	u32 addr = sgpio_get_addr(priv, rno, off);
+	int ret;
 
-	sgpio_writel(priv, val, rno, off);
+	ret = regmap_update_bits(priv->regs, addr, clear | set, set);
+	WARN_ONCE(ret, "error updating sgpio reg %d\n", ret);
 }
 
 static inline void sgpio_configure_bitstream(struct sgpio_priv *priv)
@@ -231,7 +230,6 @@ static void sgpio_output_set(struct sgpio_priv *priv,
 			     int value)
 {
 	unsigned int bit = SGPIO_SRC_BITS * addr->bit;
-	unsigned long flags;
 	u32 clr, set;
 
 	switch (priv->properties->arch) {
@@ -251,9 +249,7 @@ static void sgpio_output_set(struct sgpio_priv *priv,
 		return;
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
 	sgpio_clrsetbits(priv, REG_PORT_CONFIG, addr->port, clr, set);
-	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static int sgpio_output_get(struct sgpio_priv *priv,
@@ -616,16 +612,13 @@ static void microchip_sgpio_irq_setreg(struct irq_data *data,
 	struct sgpio_bank *bank = gpiochip_get_data(chip);
 	unsigned int gpio = irqd_to_hwirq(data);
 	struct sgpio_port_addr addr;
-	unsigned long flags;
 
 	sgpio_pin_to_addr(bank->priv, gpio, &addr);
 
-	spin_lock_irqsave(&bank->priv->lock, flags);
 	if (clear)
 		sgpio_clrsetbits(bank->priv, reg, addr.bit, BIT(addr.port), 0);
 	else
 		sgpio_clrsetbits(bank->priv, reg, addr.bit, 0, BIT(addr.port));
-	spin_unlock_irqrestore(&bank->priv->lock, flags);
 }
 
 static void microchip_sgpio_irq_mask(struct irq_data *data)
-- 
2.30.2

