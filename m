Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101B54C580E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiBZUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiBZUp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:45:56 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B131B45E0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 12:45:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 57772223ED;
        Sat, 26 Feb 2022 21:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645908319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8xvvhK271QRdegqFwLAfRIGQqEXyXtaSS8xqkOohR88=;
        b=Z0aX5cig+qMwLpktysIL8/WycgNZsrMy9FNNavBzROAhPNyXBLSbHxkxJXCSUbrNDNbROe
        1Q34g+7dVRUfrUj9zQ9/bmmxh43gnqnjmBtwvqBzlha9U05LvSs39HtUTY0SQtDa7k8JOu
        PP1sUnR7EqYzt5lJAgmIhgerhTACppI=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/5] pinctrl: microchip-sgpio: don't do RMW for interrupt ack register
Date:   Sat, 26 Feb 2022 21:45:04 +0100
Message-Id: <20220226204507.2511633-3-michael@walle.cc>
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

The interrupt ack register has the usual "write one to clear" semantics.
No read-modify-write is required here.

This is also a preparation patch to change the sgpio_clrsetbits() to use
regmap_update_bits() which don't write the value if it is not changed.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 666f1e3889e0..29cce0609fd9 100644
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

