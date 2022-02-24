Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA94C3186
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiBXQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBXQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:34:28 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F111C024D;
        Thu, 24 Feb 2022 08:33:57 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4753F223ED;
        Thu, 24 Feb 2022 17:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645719038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfIDQa6FJTFwfCIXNvNQ6T+ZpBTS7tbFcvelBvUPgsA=;
        b=YVLvsrlFhhYpizdRGZmET0UpkAklb9xkIMvO2paxqpe2GjSdlE887eVqs/Q6HCIKvNf3Ms
        LgGr3gZICJWIZJ6/6UQ1yKa44oNQf3jcgHb12oAbcj6ZxS3XhvEFwUVDYZYSC12xM6mp+X
        Vh4MeZlvNbbGJixj6wszqCU/oki0yF8=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 2/5] pinctrl: microchip-sgpio: don't do RMW for interrupt ack register
Date:   Thu, 24 Feb 2022 17:10:18 +0100
Message-Id: <20220224161021.2197263-3-michael@walle.cc>
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

The interrupt ack register has the usual "write one to clear" semantics.
No read-modify-write is required here.

This is also a preparation patch to change the sgpio_clrsetbits() to use
regmap_update_bits() which don't write the value if it is not changed.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index b43302cc188a..31c4401f725e 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -640,7 +640,14 @@ static void microchip_sgpio_irq_unmask(struct irq_data *data)
 
 static void microchip_sgpio_irq_ack(struct irq_data *data)
 {
-	microchip_sgpio_irq_setreg(data, REG_INT_ACK, false);
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+	struct sgpio_bank *bank = gpiochip_get_data(chip);
+	unsigned int gpio = irqd_to_hwirq(data);
+	struct sgpio_port_addr addr;
+
+	sgpio_pin_to_addr(bank->priv, gpio, &addr);
+
+	sgpio_writel(bank->priv, BIT(addr.port), REG_INT_ACK, addr.bit);
 }
 
 static int microchip_sgpio_irq_set_type(struct irq_data *data, unsigned int type)
-- 
2.30.2

