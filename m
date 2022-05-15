Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CCA527899
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiEOP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 11:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiEOP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 11:57:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C113F8F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 08:57:23 -0700 (PDT)
Date:   Sun, 15 May 2022 15:57:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652630242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgOvXRVU2ushuMEW1s2hm+ID9o9VYCZrSTZwRor+mg0=;
        b=zsHRTaxcM/CGSDdK2ex0ycn+AYAE9NmbxJYV5Ur0kBCEvRgmLflKQNbBTOGcArA8pnW2gX
        fg5oXaZzMpNqhp4t1hwfFTs4tUXe8lZNnircCrnpjP7lCGK+lGi1wDcZzoUpjUM1Kli1hp
        L3PUmfSvRe5cYkNwUuqc+lD03MXY2pJAxCvHq+YY6mFBV3WvDT2Oz9crcIXMy8S2bYThzx
        FEqEq/NODOMvkX0d+B5GHqW5+XHDWn27nmK5Cm9QqhcXmcKdFgiyn8+HRXUx22rdKeWvWP
        A3NHprLb1aQUskYIGK2s0Jk6+EANoT+ReSWtbs0lZ/dqg6egr/AWjXBqrGq+Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652630242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgOvXRVU2ushuMEW1s2hm+ID9o9VYCZrSTZwRor+mg0=;
        b=bnLq1WPx0E+XKxSRlHKY1NiDBM6MC1lc1jMyolx4GTXLi4/kIYjoPVTt2oIQN0TwJflQAO
        nu+9IbPlaQJn4RAA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Ensure pseudo-NMIs have
 an ISB between ack and handling
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
In-Reply-To: <20220513133038.226182-2-mark.rutland@arm.com>
References: <20220513133038.226182-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <165263024134.4207.16216291350190659715.tip-bot2@tip-bot2>
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

Commit-ID:     adf14453d2c037ab529040c1186ea32e277e783a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/adf14453d2c037ab529040c1186ea32e277e783a
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 13 May 2022 14:30:36 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 15 May 2022 16:38:18 +01:00

irqchip/gic-v3: Ensure pseudo-NMIs have an ISB between ack and handling

There are cases where a context synchronization event is necessary
between an IRQ being raised and being handled, and there are races such
that we cannot rely upon the exception entry being subsequent to the
interrupt being raised.

We identified and fixes this for regular IRQs in commit:

  39a06b67c2c1256b ("irqchip/gic: Ensure we have an ISB between ack and ->handle_irq")

Unfortunately, we forgot to do the same for psuedo-NMIs when support for
those was added in commit:

  f32c926651dcd168 ("irqchip/gic-v3: Handle pseudo-NMIs")

Which means that when pseudo-NMIs are used for PMU support, we'll hit
the same problem.

Apply the same fix as for regular IRQs. Note that when EOI mode 1 is in
use, the call to gic_write_eoir() will provide an ISB.

Fixes: f32c926651dcd168 ("irqchip/gic-v3: Handle pseudo-NMIs")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220513133038.226182-2-mark.rutland@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b252d55..7305d84 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -654,6 +654,9 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
+	else
+		isb()
+
 	/*
 	 * Leave the PSR.I bit set to prevent other NMIs to be
 	 * received while handling this one.
