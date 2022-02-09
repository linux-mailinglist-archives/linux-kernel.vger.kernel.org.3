Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C424AF65A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiBIQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiBIQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71960C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:54 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W38HnjedU3EJ5k9Tq2eAtC9yYIwSBvbQ92xLek8Vhqo=;
        b=mJRt/8Ci45bGG/G/wuBIANaInKy2j0HzXQTDAkgs5EcdCKS4H+iCPkISSsvTGDz4Dc/eT5
        UjCkGCoMTOZn36S1uxzVqZjD7GqR0wNVf+eOvP31ngveOmUkON2BUtu0xuPbGjHnJu1rGT
        QbrDLlwUYHAKvTfFGPnKxzLDlJ0EH6eWYbImjGqLH+fAOoLVjX+9foN2LlHjzY+2XmrTcm
        vOsbhsOIkFUk6eqyBB16mkPeciOSOScqnODmANN3+28RE6ksm/vYBQC7Ny+GNvCsvGSPte
        idwWM7dLyxhS/t7u1OnvgPf5iXPv74fEutlyiPnhPGuDTx8Xx+vdvE+pIigkXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W38HnjedU3EJ5k9Tq2eAtC9yYIwSBvbQ92xLek8Vhqo=;
        b=SiAluHX50KO10IkOWiXNGOMfvtVNK2liOmKAEO8dfxiz5c9xFbCc0P6w8pcJ7JGklVADDC
        B++ZgDMxHLbYyFCQ==
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
Message-ID: <164442347205.16921.2326212531375236802.tip-bot2@tip-bot2>
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

Commit-ID:     de72f9429628e9c5b1124087c36bd7457b2ab241
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/de72f9429628e9c5b1124087c36bd7457b2ab241
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:09 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:54 

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
