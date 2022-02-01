Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCA4A5BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiBAMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:04:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52780 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbiBAMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:04:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C643E61528;
        Tue,  1 Feb 2022 12:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D16C340F6;
        Tue,  1 Feb 2022 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717014;
        bh=ilwI/e1ttHjdl7xv7YPOr3xUTctN1SCSeqI4kAUKElM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxffx4+hJrtA2LBp/3HCvF7Chr3pzY2PaAh9Rf/14mXpPqlHS4xR1e4wW4t1jBEt4
         4P027AejzUZwke716bMW26OvM6EE3W4CkZol6c+Pk2oWIqwuXuER+yHw7GeRxChRmj
         qIFXfzD2tZWRB7SyZ4XFM6vupJQf5zDminaKH+LpITDS9rm9Spwl+sPPfvSB63xQkN
         gN+G08wUArGZsNWbAnCJKrkntfp89yg+rnoLatfDtBOBnkG2bpc4JLdaHRUQgbwATs
         VwApeLfCBiMhT1KglPM7YD46TsoCJHe9V4P61cd3zmRgRh9tLpGJsgprlxVgP2Jifg
         LWlBGER8Lp3yg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsi-004d46-GH; Tue, 01 Feb 2022 12:03:32 +0000
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
Subject: [PATCH 09/12] gpio: tpmx86: Move PM device over to irq domain
Date:   Tue,  1 Feb 2022 12:03:07 +0000
Message-Id: <20220201120310.878267-10-maz@kernel.org>
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

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-tqmx86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 5b103221b58d..fa4bc7481f9a 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -281,7 +281,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		u8 irq_status;
 
 		irq_chip->name = chip->label;
-		irq_chip->parent_device = &pdev->dev;
 		irq_chip->irq_mask = tqmx86_gpio_irq_mask;
 		irq_chip->irq_unmask = tqmx86_gpio_irq_unmask;
 		irq_chip->irq_set_type = tqmx86_gpio_irq_set_type;
@@ -316,6 +315,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		goto out_pm_dis;
 	}
 
+	irq_domain_set_pm_device(girq->domain, dev);
+
 	dev_info(dev, "GPIO functionality initialized with %d pins\n",
 		 chip->ngpio);
 
-- 
2.30.2

