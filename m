Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2E4AF695
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiBIQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiBIQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A3C05CB89;
        Wed,  9 Feb 2022 08:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CC261646;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274DC36AE7;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423980;
        bh=FoVj5SOWBkaHxyXSi6ANHebxE4k7dg/LG8CNlIMPZJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0xscCS0ZQ7qEg1b6ceRQ16EU1jdqbIVwXjjlJpESnBsF89HKgF5MJKnw0Qt9ZMgX
         L+8J0TRZ7Qjtq5v3oe2QSlWzdzCh6h7YkX2mdwPXwBDqZG68qc3NkqJ76mKa8/OkpY
         WaD/DjNp6jj0DLPVIviCSK7qQocktwIhW1nXE8KlqA7hJtLCvYFafNyqTEQEepNxqN
         1tzY9qtYxYz+YaZJg7OaTDyHVtpI24+e7cdXtAxssEN8lmCrj8+ahd+I68+VmQuUvP
         Q8InZYN+AA67NODG6j5P9UHJ7PZ9Yj9tLZID/fSjWTbf5bT2wo/JdUxXn2C+ltQrzb
         hVpGyciwBxaAw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnO-006fgT-6R; Wed, 09 Feb 2022 16:26:18 +0000
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
Subject: [PATCH 08/10] gpio: mt7621: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:05 +0000
Message-Id: <20220209162607.1118325-9-maz@kernel.org>
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
 drivers/gpio/gpio-mt7621.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index d8a26e503ca5..14ba4bc141c9 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
 #define MTK_BANK_CNT	3
@@ -188,6 +189,15 @@ mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void mediatek_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mtk_gc *rg = to_mediatek_gpio(gc);
+	struct mtk *mtk = container_of(rg - rg->bank, struct mtk, gc_map[0]);
+
+	seq_printf(p, dev_name(mtk->dev));
+}
+
 static int
 mediatek_gpio_xlate(struct gpio_chip *chip,
 		    const struct of_phandle_args *spec, u32 *flags)
@@ -238,11 +248,11 @@ mediatek_gpio_bank_probe(struct device *dev, int bank)
 		return -ENOMEM;
 
 	rg->chip.offset = bank * MTK_BANK_WIDTH;
-	rg->irq_chip.name = dev_name(dev);
 	rg->irq_chip.irq_unmask = mediatek_gpio_irq_unmask;
 	rg->irq_chip.irq_mask = mediatek_gpio_irq_mask;
 	rg->irq_chip.irq_mask_ack = mediatek_gpio_irq_mask;
 	rg->irq_chip.irq_set_type = mediatek_gpio_irq_type;
+	rg->irq_chip.irq_print_chip = mediatek_gpio_irq_print_chip;
 
 	if (mtk->gpio_irq) {
 		struct gpio_irq_chip *girq;
-- 
2.30.2

