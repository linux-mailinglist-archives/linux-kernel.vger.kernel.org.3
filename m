Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066D569D49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiGGISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiGGIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F024D4E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:15:54 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agB4s4WADpNkKagZMVxc6n5C9p1szKTvYPMmkV5M5Qw=;
        b=xwIPqH5cDAVMXzR9PScT60mjMLZoywE9Fm19Eeb74vY8LrED0tB7DZo51Fm2+iUG0/M+Dc
        mKfETsVyVMabrBx1aqgm9Z8UzISfIO01andoaZC/0ufgTpcFN0m3kRxRqELFPPSMrZjTt1
        /ujIMXw8LJ1STav4bMyMQdcgqXBNu1m3pxNlK2oz/Enz4VnHN0R4HHEBGYq2bAIc9pdCt4
        Ep2D5P6oEAG2W5OVke1HFitWF4qWYzyLGed872CqDD7qb8b5e23NWnCTy1Ha6D9/TWaLyv
        dgP0ayIQ3AkExjX0Obw5r+pbBNdDe2UqZ6EgDh0oyByvttx6UZstzXfzcygeFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agB4s4WADpNkKagZMVxc6n5C9p1szKTvYPMmkV5M5Qw=;
        b=k24qG0nyWHpqQPcExStzS5MUYFQe3tzMbWyCzWi0Y6K1tbnvmN7r6E+J8ACbXWFUMT2cCB
        g7yaCBKeazmSnLCA==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Prevent illegal read
 due to unbounded DT value
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-4-antonio.borneo@foss.st.com>
References: <20220606162757.415354-4-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175212.15455.3837977774030321982.tip-bot2@tip-bot2>
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

Commit-ID:     c16ae609214e835692c33b1a090b5a15bf1b9e7e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c16ae609214e835692c33b1a090b5a15bf1b9e7e
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:54 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Prevent illegal read due to unbounded DT value

The value hwirq is received from DT. If it exceeds the maximum
valid value it causes the code to address unexisting irq chips
reading outside the array boundary.

Check the value of hwirq before using it.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-4-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 1145f06..e2722e4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -713,6 +713,9 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	int bank;
 
 	hwirq = fwspec->param[0];
+	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
 	bank  = hwirq / IRQS_PER_BANK;
 	chip_data = &host_data->chips_data[bank];
 
