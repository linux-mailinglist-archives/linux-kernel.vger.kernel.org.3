Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14F74C310D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiBXQNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiBXQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:12:58 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A04158EA6;
        Thu, 24 Feb 2022 08:12:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EB69B223F0;
        Thu, 24 Feb 2022 17:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645719039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qzw+kR2qzAEtlrrCdkWu8sUT4TvXDm0xnydMaXN0U6I=;
        b=rgRn87mdvKSuqxmhsGaWcf7Uf3NdGYh6yH3fe42Upqfdo2lZ7dVCykpvyiYS52bdkFSbJo
        sngrLJo8PI5OTdD4wn6JUvHSyJdMaqEekj1n7KeZVfEoEYffzAIKVFang0iEeisQTvZu3d
        k85bfMdb7FxfYBfCv3AjSXt3Zh2HZ5Y=
From:   Michael Walle <michael@walle.cc>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin Foster <colin.foster@in-advantage.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 4/5] pinctrl: microchip-sgpio: return error in spgio_output_set()
Date:   Thu, 24 Feb 2022 17:10:20 +0100
Message-Id: <20220224161021.2197263-5-michael@walle.cc>
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

Make sgpio_output_set() return an error value. Don't just ignore the
return value of any regmap access but propagate it to our callers. Even
if the accesses never fail, this is a preparation patch to add single
shot mode where we need to poll a bit and thus we might get -ETIMEDOUT.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index f01ca94943da..3f3b8c482f3a 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -225,9 +225,9 @@ static inline void sgpio_configure_clock(struct sgpio_priv *priv, u32 clkfrq)
 	sgpio_clrsetbits(priv, REG_SIO_CLOCK, 0, clr, set);
 }
 
-static void sgpio_output_set(struct sgpio_priv *priv,
-			     struct sgpio_port_addr *addr,
-			     int value)
+static int sgpio_output_set(struct sgpio_priv *priv,
+			    struct sgpio_port_addr *addr,
+			    int value)
 {
 	unsigned int bit = SGPIO_SRC_BITS * addr->bit;
 	u32 clr, set;
@@ -246,10 +246,12 @@ static void sgpio_output_set(struct sgpio_priv *priv,
 		set = FIELD_PREP(SGPIO_SPARX5_BIT_SOURCE, value << bit);
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
 
 	sgpio_clrsetbits(priv, REG_PORT_CONFIG, addr->port, clr, set);
+
+	return 0;
 }
 
 static int sgpio_output_get(struct sgpio_priv *priv,
@@ -335,7 +337,7 @@ static int sgpio_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_OUTPUT:
 			if (bank->is_input)
 				return -EINVAL;
-			sgpio_output_set(priv, &addr, arg);
+			err = sgpio_output_set(priv, &addr, arg);
 			break;
 
 		default:
@@ -475,9 +477,7 @@ static int microchip_sgpio_direction_output(struct gpio_chip *gc,
 
 	sgpio_pin_to_addr(priv, gpio, &addr);
 
-	sgpio_output_set(priv, &addr, value);
-
-	return 0;
+	return sgpio_output_set(priv, &addr, value);
 }
 
 static int microchip_sgpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
-- 
2.30.2

