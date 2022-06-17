Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2254F589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381600AbiFQKgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiFQKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:36:51 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598F6AA6A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:36:50 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5496D6000E;
        Fri, 17 Jun 2022 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655462209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L7gTUF8a3Fk1Db925OgjqW5aQ3xnW52hgb2IRHmS45A=;
        b=lbBfiq4C4incIfANk98pgLgOExz7PpRfd1pDAPiNZVpGxt5lEohDTrvQgg4TYYHxRujAnT
        VxB5PBNGSjwbs3HOdNU1hTE79ZOOTFeKzoBNSl5ZoLhWt9cfENzjJcBEAKtM2fI0cB8RbD
        uCFkHsEy0ZL9Q4c4T5IRPqnyEjRPvH1rm65Jyr/rR5L0o/QBaZmBCGtpR7E7YkUmRP3jMa
        2dDfWjYqul2dCU60pBGQscZdv3UAk5qe4uWK0QqvlqwRfmrEPI2dSWEWv+mFd2HeQlBY8N
        5hO8/8oeND6vSGBnLD+5nSZjCDZJK1rQI8S/mr1nJNkD/pf93q5KFdQ+Wnq04w==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH] pinctrl: ocelot: allow building as a module
Date:   Fri, 17 Jun 2022 12:35:48 +0200
Message-Id: <20220617103548.490092-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set PINCTRL_OCELOT config option as a tristate and add
MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate
information. Moreover, switch from builtin_platform_driver()
to module_platform_driver().

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/pinctrl/Kconfig          | 2 +-
 drivers/pinctrl/pinctrl-ocelot.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f52960d2dfbe..257b06752747 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -311,7 +311,7 @@ config PINCTRL_MICROCHIP_SGPIO
 	  LED controller.
 
 config PINCTRL_OCELOT
-	bool "Pinctrl driver for the Microsemi Ocelot and Jaguar2 SoCs"
+	tristate "Pinctrl driver for the Microsemi Ocelot and Jaguar2 SoCs"
 	depends on OF
 	depends on HAS_IOMEM
 	select GPIOLIB
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 5f4a8c5c6650..349e063a04fa 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1889,6 +1889,7 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
 	{ .compatible = "microchip,lan966x-pinctrl", .data = &lan966x_desc },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ocelot_pinctrl_of_match);
 
 static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
 {
@@ -1984,4 +1985,5 @@ static struct platform_driver ocelot_pinctrl_driver = {
 	},
 	.probe = ocelot_pinctrl_probe,
 };
-builtin_platform_driver(ocelot_pinctrl_driver);
+module_platform_driver(ocelot_pinctrl_driver);
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.36.1

