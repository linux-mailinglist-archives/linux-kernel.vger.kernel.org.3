Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676654A5C15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiBAMTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbiBAMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:19:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC7C061714;
        Tue,  1 Feb 2022 04:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FE7ECE1854;
        Tue,  1 Feb 2022 12:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA996C340F3;
        Tue,  1 Feb 2022 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717987;
        bh=CPBUZ3CFf4sfa2zR3if6mfs1ReZrPgfwhV5ghh58fY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4+flIaHvJaTGho4NBH+FPjMytcOnJViax8MHEyeI1NzlrmnL8NprDAoJVeSKMu+d
         4bWuk1I0CULtDF++2pBTeYlLWsCZSgJ1I4W/cTVcy+P9xMb3WKL9yREISKH12GwRqz
         3vA1qDsIgGcRd02hOh5WVPa2NavAtzDOfrQD1jVcpjv1/9Z5hFe2VPJxcHzIeGEcAR
         DXoO8r8cSd/Xkml0NhcfhrdBMCWzNR+iFxlKYn/4GLslyOylrhr3omY8/+46Ag2LES
         6j5BHPYaOu/IsUENfCl9Dz4uSMky72yjEc8k2FggksqOtxK2d7+VTQ6QovlOITfDOw
         oTE/yO3jfFFZw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsj-004d46-Em; Tue, 01 Feb 2022 12:03:33 +0000
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
Subject: [PATCH 11/12] pinctrl: starfive: Move PM device over to irq domain
Date:   Tue,  1 Feb 2022 12:03:09 +0000
Message-Id: <20220201120310.878267-12-maz@kernel.org>
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
 drivers/pinctrl/pinctrl-starfive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 0b912152a405..5be9866c2b3c 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -1307,7 +1307,6 @@ static int starfive_probe(struct platform_device *pdev)
 	sfp->gc.base = -1;
 	sfp->gc.ngpio = NR_GPIOS;
 
-	starfive_irq_chip.parent_device = dev;
 	starfive_irq_chip.name = sfp->gc.label;
 
 	sfp->gc.irq.chip = &starfive_irq_chip;
@@ -1330,6 +1329,8 @@ static int starfive_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not register gpiochip\n");
 
+	irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
+
 out_pinctrl_enable:
 	return pinctrl_enable(sfp->pctl);
 }
-- 
2.30.2

