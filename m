Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2987A4AF661
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiBIQSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiBIQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF2C05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:58 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3X2i0EGqBcQArlkB+7bdS/RFoZSdi6FLGDl0t82ARc=;
        b=jE3J1ZezV4rL/uPmb7J+EgPz6vFytFT2VJ4h4Xx4M++SDx6AVnhO2VX00FXD9U+cRrrGaa
        PpMwf5VVBZ1pn5+RwkDGyhW2L9QsKRDwpB26WIb4oYg91sHSPbkmX6WJuzj4CJUoxt6cKi
        ayNGYBAqLABHKpH1hf8W5ygJUNOKl/1AglA/NDwPc00q63Ad01bFF7thhXONh2nKKy900r
        iBkgNRmXtiUsFtjNHBJ62nPHyTw72ZNy1+Ta9xpKZ0Km3mGeJ7wN7Kth0ydtcmylrpJFR3
        Hy75al9OmHpaShtbj0atS2BX22bdHG4DqAnYtDgLSJj08PN/RXhlJ+Ogcuk12w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3X2i0EGqBcQArlkB+7bdS/RFoZSdi6FLGDl0t82ARc=;
        b=jjO3rrxVkSJO+T8zDasF7LfPwj51GzYpVtP3EboFfz3PRsyNCVf3VBIQlNIAAk0l8ggqXf
        EC8Mm+jwzHMBvzCg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: mt7621: Kill parent_device usage
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        tglx@linutronix.de
In-Reply-To: <20220201120310.878267-7-maz@kernel.org>
References: <20220201120310.878267-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347653.16921.5297090133222688838.tip-bot2@tip-bot2>
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

Commit-ID:     4b9558f92036c968119e1de383f604c19b3ca99b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4b9558f92036c968119e1de383f604c19b3ca99b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:04 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:53 

gpio: mt7621: Kill parent_device usage

This gpio controller sets the parent_device field, but doesn't have
any runtime PM functionality. Get rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-7-maz@kernel.org
---
 drivers/gpio/gpio-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index ccaad1c..d8a26e5 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -239,7 +239,6 @@ mediatek_gpio_bank_probe(struct device *dev, int bank)
 
 	rg->chip.offset = bank * MTK_BANK_WIDTH;
 	rg->irq_chip.name = dev_name(dev);
-	rg->irq_chip.parent_device = dev;
 	rg->irq_chip.irq_unmask = mediatek_gpio_irq_unmask;
 	rg->irq_chip.irq_mask = mediatek_gpio_irq_mask;
 	rg->irq_chip.irq_mask_ack = mediatek_gpio_irq_mask;
