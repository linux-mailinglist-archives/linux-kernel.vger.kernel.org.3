Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC64CB165
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbiCBVg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiCBVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:36:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFAC46B32;
        Wed,  2 Mar 2022 13:35:39 -0800 (PST)
Date:   Wed, 02 Mar 2022 21:35:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646256938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gj4MAdJpqSWwDZaOYbPqatr1LmMEJp06NeXMN8Ht7jQ=;
        b=smaz3OYmDHhy4TOn9ymVIbzb4ESiFhRxYosoxgoiv9WM2TTsWhvOyKcBOqI+dcYs0fEJGS
        4kHsS7P0yrNgAszzXxe4zHFEe0k9mtz5GvbqL84oEnq5OOTQ4Jrl5YXQMAlBlAaJvpGy0+
        C3pFRgQEpc2dsq6vK/2tjzlSdYSmTSIHdFgP78cZniestfpbZjha6usMVjxChBiBsoU2hN
        UIwT1sH5FhkVdx/FS98P07HzMMYc13EvLfLHFKED5QyocvB60sGZaL05rAbr5FmHPNtHjb
        tsQ2vy+jW/i70O0ULB9Amxme9L1rt2/0U4Y6d3pakbUnUhKHUm1krHAt/I5qLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646256938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gj4MAdJpqSWwDZaOYbPqatr1LmMEJp06NeXMN8Ht7jQ=;
        b=klfnp3H6GZvyqX+KEEDvl2dBdN7NVvGS9owEy7bQr3EFbTaH6cpuutnGyP07cJmbLSp+nD
        EsXNd9nBV4/UuZCQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] misc: hi6421-spmi-pmic: Use generic_handle_irq_safe().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211181500.1856198-5-bigeasy@linutronix.de>
References: <20220211181500.1856198-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164625693694.16921.15227620434324740318.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1b9855de1ef4a3f82119f9d8b054a588c7c315fb
Gitweb:        https://git.kernel.org/tip/1b9855de1ef4a3f82119f9d8b054a588c7c315fb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 11 Feb 2022 19:14:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Mar 2022 22:28:50 +01:00

misc: hi6421-spmi-pmic: Use generic_handle_irq_safe().

generic_handle_irq() is invoked from a regular interrupt service
routine. This handler will become a forced-threaded handler on
PREEMPT_RT and will be invoked with enabled interrupts. The
generic_handle_irq() must be invoked with disabled interrupts in order
to avoid deadlocks.

Instead of manually disabling interrupts before invoking use
generic_handle_irq_safe() which can be invoked with enabled and disabled
interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org> 
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20220211181500.1856198-5-bigeasy@linutronix.de

---
 drivers/misc/hi6421v600-irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 1c76379..caa3de3 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -117,8 +117,8 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *__priv)
 			 * If both powerkey down and up IRQs are received,
 			 * handle them at the right order
 			 */
-			generic_handle_irq(priv->irqs[POWERKEY_DOWN]);
-			generic_handle_irq(priv->irqs[POWERKEY_UP]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_DOWN]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_UP]);
 			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
 		}
 
@@ -126,7 +126,7 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *__priv)
 			continue;
 
 		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
-			generic_handle_irq(priv->irqs[offset + i * BITS_PER_BYTE]);
+			generic_handle_irq_safe(priv->irqs[offset + i * BITS_PER_BYTE]);
 		}
 	}
 
