Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEA4908A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbiAQMY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:24:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiAQMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:24:22 -0500
Date:   Mon, 17 Jan 2022 12:24:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642422261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xn8Tf8OGT62AB8lgwbLdJnoZHST9sm/ZalyTyMZXzXc=;
        b=kkdekkyftUTnbdixJWzOg/w7q8tRBFQ1k8R+rXiuUhd6qREDc62S9QQFnZeW69srMaH21N
        +4R/KC6fm4+/to8d1X4PERwiR6S2bzFUpsL+XR2ot+juHwAa46PiqB+ILLyWzgFWXLZzkK
        iYN1GMfs9k7E2Sftxo0k1oUqvYqCq+Yi+0XUhRDu71FjocTp/aE8oLXq38jaNNHkvyqWmk
        1r5ivlk4ob9ru/57YqZnzx3ubCy5ztg23BROW2YN36eoSyoFUa2F1g6GXx9YUqiObb0LZQ
        qSGTdewHTBuWJoQrBBzrHrT700OopBf2MmMEQbIAMq2hxl4rOhku/lr3o5KdeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642422261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xn8Tf8OGT62AB8lgwbLdJnoZHST9sm/ZalyTyMZXzXc=;
        b=kvnEhgJiQBme8YpsNxQVX8hM7FwAbyneyGSUD3YormH+A09d/9+1/zz6nkmOE9gy5FUFHe
        zHBtY0/5SibKAXDw==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/realtek-rtl: Service all pending
 interrupts
Cc:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C5082ad3cb8b4eedf55075561b93eff6570299fe1=2E16417?=
 =?utf-8?q?39718=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3C5082ad3cb8b4eedf55075561b93eff6570299fe1=2E164173?=
 =?utf-8?q?9718=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <164242225972.16921.17762117940529896605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     960dd884ddf5621ae6284cd3a42724500a97ae4c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/960dd884ddf5621ae6284cd3a42724500a97ae4c
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Sun, 09 Jan 2022 15:54:34 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Jan 2022 12:16:26 

irqchip/realtek-rtl: Service all pending interrupts

Instead of only servicing the lowest pending interrupt line, make sure
all pending SoC interrupts are serviced before exiting the chained
handler. This adds a small overhead if only one interrupt is pending,
but should prevent rapid re-triggering of the handler.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/5082ad3cb8b4eedf55075561b93eff6570299fe1.1641739718.git.sander@svanheule.net
---
 drivers/irqchip/irq-realtek-rtl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 568614e..50a5682 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -76,16 +76,20 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *domain;
-	unsigned int pending;
+	unsigned long pending;
+	unsigned int soc_int;
 
 	chained_irq_enter(chip, desc);
 	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+
 	if (unlikely(!pending)) {
 		spurious_interrupt();
 		goto out;
 	}
+
 	domain = irq_desc_get_handler_data(desc);
-	generic_handle_domain_irq(domain, __ffs(pending));
+	for_each_set_bit(soc_int, &pending, 32)
+		generic_handle_domain_irq(domain, soc_int);
 
 out:
 	chained_irq_exit(chip, desc);
