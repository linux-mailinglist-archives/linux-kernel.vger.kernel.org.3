Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CC4B21C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbiBKJYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBKJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C107B81;
        Fri, 11 Feb 2022 01:24:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ABD8B828BA;
        Fri, 11 Feb 2022 09:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215EC340E9;
        Fri, 11 Feb 2022 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644571442;
        bh=LTholiIYCR8EzJtQHKwYUx7qncEDYk0rJjJf2Lp4PXA=;
        h=From:To:Cc:Subject:Date:From;
        b=c7ZSkS5S2CRJXW3RMICmKMprBymDhysSYVju2LFNAKRIMEwUHcBnPIA9W9MHX8ubM
         TCToLWdahXpgvPC4Qp/3hQTOuHBiao1iBplkGY7fXKYAQtot+tPoCY9XhcoXLuKUfn
         2g6fSIEKtrGtI2Jko2XXHcHhblG0t4nLtYGW6X9SxvMjKZbEypN9rsA7PsWVraB/V6
         zyH1ENo6tNh/f9Cl4GZO8NCxEC7UAzccTYdYu2/JlBKVrYfBdjIAvPu9m7w3OyBVDu
         70B+PkBB6FAG7VLCT/uN5PiXN7+feuvH9XBA1fR5DWhD9CBALKI/4WIN/Alqcs7G5v
         6wma57cRCQjdA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nIS9o-0077l5-RS; Fri, 11 Feb 2022 09:24:00 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     kernel-team@android.com, Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] pinctrl: starfive: Use a static name for the GPIO irq_chip
Date:   Fri, 11 Feb 2022 09:23:45 +0000
Message-Id: <20220211092345.1093332-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, kernel-team@android.com, kernel@esmil.dk, linus.walleij@linaro.org, brgl@bgdev.pl
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

Drop the device name used for the GPIO irq_chip and replace it
with something static. The information is still available from
debugfs and carried as part of the irqdomain.

Suggested-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/pinctrl/pinctrl-starfive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 0b912152a405..266da41a6162 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -1164,6 +1164,7 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
 }
 
 static struct irq_chip starfive_irq_chip = {
+	.name = "StarFive GPIO",
 	.irq_ack = starfive_irq_ack,
 	.irq_mask = starfive_irq_mask,
 	.irq_mask_ack = starfive_irq_mask_ack,
@@ -1308,7 +1309,6 @@ static int starfive_probe(struct platform_device *pdev)
 	sfp->gc.ngpio = NR_GPIOS;
 
 	starfive_irq_chip.parent_device = dev;
-	starfive_irq_chip.name = sfp->gc.label;
 
 	sfp->gc.irq.chip = &starfive_irq_chip;
 	sfp->gc.irq.parent_handler = starfive_gpio_irq_handler;
-- 
2.34.1

