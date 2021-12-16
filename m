Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439F4775D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhLPPYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhLPPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDDC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:24:49 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:24:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639668287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dq6fzs8y4JQXyLqOOmzL+YHW1c1H0CuUY9kjDNrXDw0=;
        b=jpuWgii3Lo5VSsUy9ePh64NDwGd9G8ZYDcGmERPMLPNMIcVvgqY5qbtaEh5v2g42FnaywX
        9optbXtSfckLqmn/rmxVquav74U98vg2ncl8tQBpcQc2UIt69qiTUH0U0V+36D/8WHVEYF
        ZSyflstm3sAYnLtGDhMQvb1sCy/Y+8MO0nDZ8Mm/CBDYv7ZGUZhl3vhRJrQQN5k8OreIqA
        PLaGWRNtEbOwfLYJ0kG5XUdKYx4aHL1Ag9GSCg1x259PmapyUhepitVHvFMFryrHXffkRR
        o/lkazr5Gds+KGjGoYxQBQpEBRKF7MBgCWGPuwKsWoocY91PEAlOjGeTsdNnWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639668287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dq6fzs8y4JQXyLqOOmzL+YHW1c1H0CuUY9kjDNrXDw0=;
        b=AVZ5FOptIAqtjyHXG3LgQzRkfdq7f2pofILGc7vH6DZjT6YjurC10z9TmRq1A7ThRtm0y9
        dvsQzebhlZidVrAg==
From:   "irqchip-bot for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/spear-shirq: Add support for IRQ 0..6
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211202095255.165797-6-herve.codina@bootlin.com>
References: <20211202095255.165797-6-herve.codina@bootlin.com>
MIME-Version: 1.0
Message-ID: <163966828689.23020.13154863439448547706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f63c862587c9ba1c62de8c549e8f2fbe0fc88b6b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f63c862587c9ba1c62de8c549e8f2fbe0fc88b6b
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Thu, 02 Dec 2021 10:52:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 13:29:44 

irqchip/spear-shirq: Add support for IRQ 0..6

IRQ 0..7 are not supported by the driver for SPEAr320 SOC family.

IRQ 0 is not reserved in SPEAr320 SOC (assigned to GPIOINT).
Furthermore, in SPEAr320s SOC variant, IRQ 0..6 are assigned
as follow:
  IRQ 6 - NGPIO_INTR: Combined status of edge programmable
                      interrupts from GPIO ports
  IRQ 5 - TX_OR_INTR: I2S interrupt on Transmit FIFO overrun
  IRQ 4 - TX_EMP_INTR: I2S interrupt on Transmit FIFO empty
  IRQ 3 - RX_OR_INTR: I2S interrupt on Receive FIFO overrun
  IRQ 2 - RX_DA_INTR: I2S interrupt on data available in Receive FIFO
  IRQ 1 - Reserved
  IRQ 0 - GPIO_INTR: Legacy interrupt from GPIO ports

Add support for these IRQs in SPEAr320 SOC family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211202095255.165797-6-herve.codina@bootlin.com
---
 drivers/irqchip/spear-shirq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 1518ba3..7c17a6f 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -149,6 +149,8 @@ static struct spear_shirq spear320_shirq_ras3 = {
 	.offset		= 0,
 	.nr_irqs	= 7,
 	.mask		= ((0x1 << 7) - 1) << 0,
+	.irq_chip	= &dummy_irq_chip,
+	.status_reg	= SPEAR320_INT_STS_MASK_REG,
 };
 
 static struct spear_shirq spear320_shirq_ras1 = {
