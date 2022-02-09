Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE24AF659
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiBIQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbiBIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EFC05CB95
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:18:02 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:18:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzFjmjmxe8Nd/RfQt5SciQe4zR5L0wLeEFsLkBZnnUg=;
        b=oCyTBvBBR7FqUiGVnd/jGco0KxQeS/aRX6K1oaNgCz8xabwdTnSHxmo7y30hxDUT5iJgBB
        pg11NyHB0fLhleWZX2NdoOHgQOiA3oiTNLySBzqqP9B+Y0RRRP/f6QibUKGR/GdzFnkjyE
        X4NsJnOhNiqbw5kTvSy4d55lePPqH2eUi9ahP9InlGJn00Yx/YxC7G2tfMl3HbGtw7IE85
        aW5pM/6zg2cMosldHznAjA1C7iwhysQ+C9YrjnDJDjAqlRtpjGtHj457fCWlOTuJ12OlQz
        lYF4IB89/aL5KFjaDTgotLWKqRxFwDLe+gUFN7eWJBjENrLDdL7pdHAK2/BBHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzFjmjmxe8Nd/RfQt5SciQe4zR5L0wLeEFsLkBZnnUg=;
        b=Lly6GTIyCU1MkNENvLdCLZkeQO/YoorhGMIUOFMekpKOww9nxq3hWw+YYnj/oadrqfYxnf
        rlsboQNw1zVpEpCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Move PM device over to irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-3-maz@kernel.org>
References: <20220201120310.878267-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442348025.16921.15496974487364454668.tip-bot2@tip-bot2>
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

Commit-ID:     e95f3efdeb499accf2b05333a1eac7862f5a10f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e95f3efdeb499accf2b05333a1eac7862f5a10f6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:00 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:35:56 

irqchip/gic: Move PM device over to irq domain

Move the reference to the GIC device over to the irq domain.
This allows for some localised cleanup.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-3-maz@kernel.org
---
 drivers/irqchip/irq-gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b8bb46c..fb741b4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1127,13 +1127,12 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.unmap = gic_irq_domain_unmap,
 };
 
-static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
-			  const char *name, bool use_eoimode1)
+static void gic_init_chip(struct gic_chip_data *gic, const char *name,
+			  bool use_eoimode1)
 {
 	/* Initialize irq_chip */
 	gic->chip = gic_chip;
 	gic->chip.name = name;
-	gic->chip.parent_device = dev;
 
 	if (use_eoimode1) {
 		gic->chip.irq_mask = gic_eoimode1_mask_irq;
@@ -1268,10 +1267,10 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 
 	if (static_branch_likely(&supports_deactivate_key) && gic == &gic_data[0]) {
 		name = kasprintf(GFP_KERNEL, "GICv2");
-		gic_init_chip(gic, NULL, name, true);
+		gic_init_chip(gic, name, true);
 	} else {
 		name = kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic-&gic_data[0]));
-		gic_init_chip(gic, NULL, name, false);
+		gic_init_chip(gic, name, false);
 	}
 
 	ret = gic_init_bases(gic, handle);
@@ -1460,7 +1459,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 	if (!*gic)
 		return -ENOMEM;
 
-	gic_init_chip(*gic, dev, dev->of_node->name, false);
+	gic_init_chip(*gic, dev->of_node->name, false);
 
 	ret = gic_of_setup(*gic, dev->of_node);
 	if (ret)
@@ -1472,6 +1471,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 		return ret;
 	}
 
+	irq_domain_set_pm_device((*gic)->domain, dev);
 	irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, *gic);
 
 	return 0;
