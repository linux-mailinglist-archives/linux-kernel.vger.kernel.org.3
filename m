Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B14B0BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiBJLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:10:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiBJLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:09:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CCEB7A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:09:59 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644491398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoKkTHXvZMCEcPIsvt7kDL8Zz6f2kdswwx5gjobHScE=;
        b=a4tlYvIBClmphotD0qn8zMtKdU8yZ+l5OQ+PmOeCa3IQzr+CCPflGlGFcxB/A1JCzscsMQ
        y2Wts0opsdrvMA85KKIOTgOBvBJbyiRGJYac98m9gJfuONOEsuXYFtu8iQe/XLYkuqCAhe
        aqKVuWDaKjCS8Lt6KWkyTIZVs4MJD5KS1nQ/gTuL5+GRoHfyIinq+INE3uvpIuJbhMD5E+
        Dd4qioo5d970tCuUUSXbV8kBQooWIxvTXRTO0IVPwhrBrSRYRO02oJBGKTGkxeWfTjGbzU
        iwSpOsifA7GMYtyh95HQVml6/BY8u2+BUSo3p0zE8xiVhsTf/N2o8CPyGpV7mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644491398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoKkTHXvZMCEcPIsvt7kDL8Zz6f2kdswwx5gjobHScE=;
        b=99X9qjuOghypfzJjR1naE5WkhUbypWACkQifKEjxLYEf9t3zIcGSTv6PuGbOpRspevuMIW
        Dr6l3H8m/6D66dAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: starfive: Move PM device over to
 irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-12-maz@kernel.org>
References: <20220201120310.878267-12-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164449139716.16921.10672369683936005266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0d872ed9e2148a8ba29de5a71c352fa54abf8e5e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0d872ed9e2148a8ba29de5a71c352fa54abf8e5e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:09 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Feb 2022 11:07:04 

pinctrl: starfive: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-12-maz@kernel.org
---
 drivers/pinctrl/pinctrl-starfive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 0b91215..5be9866 100644
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
