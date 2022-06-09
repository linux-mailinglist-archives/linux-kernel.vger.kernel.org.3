Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCA545259
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbiFIQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbiFIQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC98E21
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:33 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u15XumVur9JpMXMMkU3BZwJ8hWCd8qkWcy1gDSKwbZg=;
        b=vVqVMXuqRVZjnRJcm3kbuRa05wx29AePSuQJXeZi71B7gunHqjubvuxS+t9TnKJZGh20GE
        BSwa9Ovnnnbw51Ilephb08n6OvqJFvbb2gUvtr5lgUdISb+esh9aV9fDGHcoAjkZdv2nDs
        CuWZRbfoH3lICNokWG1/jTQeHSFxOjNCgfgQf/C9MknPoxdNzlv0bV433iOK/Qubyd9zT+
        xKrMUhANU/JZC1rrgTaBR15EzF1bnSK25ZfHYP0P5ze/uCVb2QMg7OrHM5ozV1SQeQJ/0Z
        BDJtLgWu2gfONk8aLwy92hvOp8yLITBMkk1ZKpUgZKdICOhqpqvjoZIGHArRPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793432;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u15XumVur9JpMXMMkU3BZwJ8hWCd8qkWcy1gDSKwbZg=;
        b=eISXRXNoGPP+1njjiNQltmKOYkDBC8oIg4xox4AdysamK/+C8q2Q9JAJPNuivWAqO6r8Qt
        XlPIkD2a7PVAveCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] genirq: PM: Use runtime PM for chained
 interrupts
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Liu Ying <victor.liu@nxp.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de>
References: <26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de>
MIME-Version: 1.0
Message-ID: <165479343125.4207.18391675887674520232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     668a9fe5c6a1bcac6b65d5e9b91a9eca86f782a3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/668a9fe5c6a1bcac6b65d5e9b91a9eca86f782a3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 08 Jun 2022 14:45:35 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 15:58:13 +01:00

genirq: PM: Use runtime PM for chained interrupts

When requesting an interrupt, we correctly call into the runtime
PM framework to guarantee that the underlying interrupt controller
is up and running.

However, we fail to do so for chained interrupt controllers, as
the mux interrupt is not requested along the same path.

Augment __irq_do_set_handler() to call into the runtime PM code
in this case, making sure the PM flow is the same for all interrupts.

Reported-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de
---
 kernel/irq/chip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e6b8e56..886789d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1006,8 +1006,10 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		if (desc->irq_data.chip != &no_irq_chip)
 			mask_ack_irq(desc);
 		irq_state_set_disabled(desc);
-		if (is_chained)
+		if (is_chained) {
 			desc->action = NULL;
+			WARN_ON(irq_chip_pm_put(irq_desc_get_irq_data(desc)));
+		}
 		desc->depth = 1;
 	}
 	desc->handle_irq = handle;
@@ -1033,6 +1035,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		irq_settings_set_norequest(desc);
 		irq_settings_set_nothread(desc);
 		desc->action = &chained_action;
+		WARN_ON(irq_chip_pm_get(irq_desc_get_irq_data(desc)));
 		irq_activate_and_startup(desc, IRQ_RESEND);
 	}
 }
