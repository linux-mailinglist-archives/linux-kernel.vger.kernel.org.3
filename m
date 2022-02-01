Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65174A5BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiBAMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:03:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52742 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiBAMDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:03:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 590C3B82D90;
        Tue,  1 Feb 2022 12:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC4CC340FC;
        Tue,  1 Feb 2022 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717013;
        bh=ivwGxoRB89+AhyONe21DIuW5LDCQ0oy5QMR/jN8ut1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koIbWbowa86u/1r+2OMJQNwsohG4mHkjIFv7bejQVnYV3AST+uthS03wdMI1zL/3g
         keo3JM5GtSkXjZRsN9htAnq49Zhm73ZTOGe0BOV3GdQDJkD77l+XAhlL26pqWrG+YY
         XHKQNk0CUtx7vs45R8AP60t0nEuXz7LwMbOOH3/vlW0R53eJiWjH7Vb2Ouwvcg/cmO
         hs/U5Om/63ajNH76ATJuCdejzCdus+ejzryevimpYaCsYH5et9kBPH5PbJGMPmxDjI
         9j5YT3H5KbJeM1aWtC+xyWXf0CIZKYH5X9+xTYOVTeX6AOq39W6mk7ldT1o5ByVMXN
         48GSl3qna0qCw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsh-004d46-AA; Tue, 01 Feb 2022 12:03:31 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 06/12] gpio: mt7621: Kill parent_device usage
Date:   Tue,  1 Feb 2022 12:03:04 +0000
Message-Id: <20220201120310.878267-7-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201120310.878267-1-maz@kernel.org>
References: <20220201120310.878267-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gpio controller sets the parent_device field, but doesn't have
any runtime PM functionality. Get rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index ccaad1cb3c2e..d8a26e503ca5 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -239,7 +239,6 @@ mediatek_gpio_bank_probe(struct device *dev, int bank)
 
 	rg->chip.offset = bank * MTK_BANK_WIDTH;
 	rg->irq_chip.name = dev_name(dev);
-	rg->irq_chip.parent_device = dev;
 	rg->irq_chip.irq_unmask = mediatek_gpio_irq_unmask;
 	rg->irq_chip.irq_mask = mediatek_gpio_irq_mask;
 	rg->irq_chip.irq_mask_ack = mediatek_gpio_irq_mask;
-- 
2.30.2

