Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D4D56FC12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiGKJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiGKJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:37:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0564E872
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:19:39 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657531177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbBJhKVx5aMwTkvMy1IDVxxzwjunJNxbD3Dkq9aWZ4g=;
        b=Uw4qGT/tv5kjxRkIOyYFWNcUaIPe9lkeK06IW1NcSXYWAam4ZeU67wHpwTmUo54yd7Y9pm
        o1FfIaiCrIKkTxknRejMkMHaFVY+cx5qkksXgqImkG1M4+zGzcWhJJkPImEU8RoTEHHplP
        pgQ2IoASHZTExDpyjpEkLfa1RzmELYPZ/VHYMPlFJR6WyQTI02sduEC4t+62x29VScTXLv
        4fEzHyeM6ZFkK08SPwJ3Em1m5KQncVLj/Vh4UTwzT96kv/0dNaEKzwNRGWEE9t4Por3rE5
        lx+pw1DYM0V6hHXgfEbV8dIhaSioS6RmxgkJLyxioc9GNDQG/2ZQmwwiHQOJLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657531177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbBJhKVx5aMwTkvMy1IDVxxzwjunJNxbD3Dkq9aWZ4g=;
        b=LTpzIaJkvI8YkXHjDbsa0C2b30+H0w4kzGiGSkJFYl1jXzkE05nv0lgPGp4yBz+0v4GBld
        bHhg7Iw6Xp0NdZCw==
From:   "irqchip-bot for Michael Walle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Allow
 irq_set_chip_handler_name_locked() to take a const irq_chip
Cc:     Michael Walle <michael@walle.cc>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220706151553.1580790-1-michael@walle.cc>
References: <20220706151553.1580790-1-michael@walle.cc>
MIME-Version: 1.0
Message-ID: <165753117562.15455.14225696524286000343.tip-bot2@tip-bot2>
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

Commit-ID:     ef6e5d61eb7a0a30f776a829274573094185d03d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ef6e5d61eb7a0a30f776a829274573094185d03d
Author:        Michael Walle <michael@walle.cc>
AuthorDate:    Wed, 06 Jul 2022 17:15:52 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 11 Jul 2022 10:12:49 +01:00

genirq: Allow irq_set_chip_handler_name_locked() to take a const irq_chip

Similar to commit 393e1280f765 ("genirq: Allow irq_chip registration
functions to take a const irq_chip"), allow the
irq_set_chip_handler_name_locked() function to take a const irq_chip
argument.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220706151553.1580790-1-michael@walle.cc
---
 include/linux/irqdesc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a775845..1cd4e36 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -209,14 +209,15 @@ static inline void irq_set_handler_locked(struct irq_data *data,
  * Must be called with irq_desc locked and valid parameters.
  */
 static inline void
-irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
+irq_set_chip_handler_name_locked(struct irq_data *data,
+				 const struct irq_chip *chip,
 				 irq_flow_handler_t handler, const char *name)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
 	desc->handle_irq = handler;
 	desc->name = name;
-	data->chip = chip;
+	data->chip = (struct irq_chip *)chip;
 }
 
 bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
