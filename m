Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D534AF65C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiBIQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiBIQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13919C061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:57 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JE16wGRtYe7FISUqG//zgKuNklCMDzWrauzxs0rZDeE=;
        b=a7bNXodLZBY0XTAFO2Pk0kOXqzXzN8+GElxj2J8t2c5ETZaMvtbl73CC7omWAt2Za0vso4
        krwyqBfbkmeTq4YRP1D7GJDofqauH/o0/Nmr3o3UkSmIq7CjEgh1Fgh2LG6G6JqETJMCJc
        gM2FxnrF1NQbDTAGyr8YBnt9ZnELWfFxAep0d3jOvbjrroG2PAlsQ75bc0mn3VjvwFrDC9
        z6e2/mcPx7QFyN5Y3rcXGDsI7FLD74kkfWWj//YaeOQn/hkVBZleunKOvxc//6BuZVqAYk
        Wkini0YthKNhedBJNd0ufanOiu0EaBIA+9smB7N6pI/aqJ+A9wiTz1XFfA8/ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JE16wGRtYe7FISUqG//zgKuNklCMDzWrauzxs0rZDeE=;
        b=QhgtXq8VKHp1Jx1ZP2Ervaj8PVD+hsqBeYaKnSZrqPHA9cBLXphlzgujMSdF0k2MuLOv3Z
        ewsTOj5zJGdWQbAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: rcar: Move PM device over to irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-9-maz@kernel.org>
References: <20220201120310.878267-9-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347471.16921.3227595274290721969.tip-bot2@tip-bot2>
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

Commit-ID:     373d664b7d3babe1743f64746bc3c553ac23a1bd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/373d664b7d3babe1743f64746bc3c553ac23a1bd
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:06 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:53 

gpio: rcar: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-9-maz@kernel.org
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index bd2e16d..3a76538 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -530,7 +530,6 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	irq_chip = &p->irq_chip;
 	irq_chip->name = "gpio-rcar";
-	irq_chip->parent_device = dev;
 	irq_chip->irq_mask = gpio_rcar_irq_disable;
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
@@ -552,6 +551,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
+	irq_domain_set_pm_device(gpio_chip->irq.domain, dev);
 	ret = devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
 			       IRQF_SHARED, name, p);
 	if (ret) {
