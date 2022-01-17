Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC9C4908A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiAQMYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:24:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57394 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiAQMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:24:23 -0500
Date:   Mon, 17 Jan 2022 12:24:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642422262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4iw34WfCFpu33VgCPV1ex9HvQDVJJY7P8gg1Phu0Tfo=;
        b=BlF0OzUJonoNZKD0CK9Aldg3yOrOpTvh3ZnG2pFKkhQG5uNMTBbqrhoPwVlnonTox2uYDM
        d521vLp1UlDYTDRItfmHvsBS2O3LJnGT/wLr2aQLSfObUtQEMUsWXYwhUcAzNQuFPW8HI7
        6Ew5wGbnYn8iBxyhiK7krOARjkEHp6+JgW2RdVXy2BjDtY+1Ap8o3BniU7aWdxG+LrQPnW
        DdeTmGQgF/O13ScFltB3oPm63dqbGBFZQjs0kgn7kHg2t8RmUHtOTDtLYk3T1hm6joFHks
        zFKZlLbRINGHYoMtop6VcuG3Q5EsTI7yYKs0HfonNidK6oPMCbNG5ujVtSrKTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642422262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4iw34WfCFpu33VgCPV1ex9HvQDVJJY7P8gg1Phu0Tfo=;
        b=jIJnYtxTfa+p2Yt6y3gp2wRL+aXoGzZGcijAcD9bEVNdyfGf2tHJZdne/e+sBu63T3/86f
        S861263fmi1YFEAg==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/realtek-rtl: Map control data to virq
Cc:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C4b4936606480265db47df152f00bc2ed46340599=2E16417?=
 =?utf-8?q?39718=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3C4b4936606480265db47df152f00bc2ed46340599=2E164173?=
 =?utf-8?q?9718=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <164242226169.16921.10741933704404329926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     291e79c7e2eb6fdc016453597b78482e06199d0f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/291e79c7e2eb6fdc016453597b78482e06199d0f
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Sun, 09 Jan 2022 15:54:32 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Jan 2022 12:13:58 

irqchip/realtek-rtl: Map control data to virq

The driver assigned the irqchip and irq handler to the hardware irq,
instead of the virq. This is incorrect, and only worked because these
irq numbers happened to be the same on the devices used for testing the
original driver.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/4b4936606480265db47df152f00bc2ed46340599.1641739718.git.sander@svanheule.net
---
 drivers/irqchip/irq-realtek-rtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index fd9f275..d6788dd 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -62,7 +62,7 @@ static struct irq_chip realtek_ictl_irq = {
 
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(hw, &realtek_ictl_irq, handle_level_irq);
+	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
 
 	return 0;
 }
