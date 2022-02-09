Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0B4AF72F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiBIQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiBIQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:49:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48514C05CB86;
        Wed,  9 Feb 2022 08:49:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E768EB82333;
        Wed,  9 Feb 2022 16:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C070C340E7;
        Wed,  9 Feb 2022 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644425386;
        bh=kBxIrNEuH/U8BJq5dfqutQsGqFRhrpCG3nnGR2AIM4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ks/NQFSVNzFY0yg/OWrI+1vCiJNuu5llOzoRFBjysiaU2c0/pP2yJe4zjapUVXvJm
         QVtaDB5VIvIF92xWq3NDKuN5JtGF07n26Mp8AJ6RayGrQtt4x/lMhTUNgh3bRc3E+j
         Nwt3EMQrf7CNuBVMmw5DUFlMtOUfEP0QdlJVeRDPQkp15+c8mznEbQR1tP4oJXNN2N
         iPKjMkDzGAzZinVZ0SySl0S3b2CP0Usqodi51RN8C1mrgoRFKF783hgyWFjToFpCQX
         mkGRwSnez+ipuOJkhLHgxL7hyaWxv5RO6iFztLmcNfIvcHdUH1RrJn0L07haOk/ZRX
         zc3WEIChpELbQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnO-006fgT-OB; Wed, 09 Feb 2022 16:26:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: [PATCH 10/10] pinctrl: starfive: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:07 +0000
Message-Id: <20220209162607.1118325-11-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209162607.1118325-1-maz@kernel.org>
References: <20220209162607.1118325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tony@atomide.com, tglx@linutronix.de, vz@mleia.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kernel@esmil.dk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of overloading the name field, use the relevant callback to
output the device name.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pinctrl/pinctrl-starfive.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 5be9866c2b3c..f29d9ccf858b 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
 #include <linux/pinctrl/pinctrl.h>
@@ -1163,12 +1164,20 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
 	return 0;
 }
 
+static void starfive_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
+
+	seq_printf(p, sfp->gc.label);
+}
+
 static struct irq_chip starfive_irq_chip = {
 	.irq_ack = starfive_irq_ack,
 	.irq_mask = starfive_irq_mask,
 	.irq_mask_ack = starfive_irq_mask_ack,
 	.irq_unmask = starfive_irq_unmask,
 	.irq_set_type = starfive_irq_set_type,
+	.irq_print_chip = starfive_irq_print_chip,
 	.flags = IRQCHIP_SET_TYPE_MASKED,
 };
 
@@ -1307,8 +1316,6 @@ static int starfive_probe(struct platform_device *pdev)
 	sfp->gc.base = -1;
 	sfp->gc.ngpio = NR_GPIOS;
 
-	starfive_irq_chip.name = sfp->gc.label;
-
 	sfp->gc.irq.chip = &starfive_irq_chip;
 	sfp->gc.irq.parent_handler = starfive_gpio_irq_handler;
 	sfp->gc.irq.num_parents = 1;
-- 
2.30.2

