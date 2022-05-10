Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC60D520F35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiEJIA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbiEJIAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:00:20 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED91D8109;
        Tue, 10 May 2022 00:56:21 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6CA86300069FE;
        Tue, 10 May 2022 09:56:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 608802E6C12; Tue, 10 May 2022 09:56:19 +0200 (CEST)
Message-Id: <c3caf60bfa78e5fdbdf483096b7174da65d1813a.1652168866.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 10 May 2022 09:56:05 +0200
Subject: [PATCH] genirq: Deduplicate WARN_ON_ONCE() in
 generic_handle_domain_irq()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0953fb263714 ("irq: remove handle_domain_{irq,nmi}()"),
generic_handle_domain_irq() warns if called outside hardirq context,
even though the function calls down to handle_irq_desc(), which warns
about the same.

Moreover the newly added warning is false positive if the interrupt
originates from any other irqchip than x86 APIC or arm GIC/GICv3.
Those are the only ones for which handle_enforce_irqctx() returns true.
Per commit c16816acd086 ("genirq: Add protection against unsafe usage of
generic_handle_irq()"):

 "In general calling generic_handle_irq() with interrupts disabled from
  non interrupt context is harmless.  [But for] interrupt controllers
  like the x86 trainwrecks this is outright dangerous as it might
  corrupt state if an interrupt affinity change is pending."

An example for irqchips where the warning is false positive are
USB-attached GPIO controllers such as drivers/gpio/gpio-dln2.c:
USB gadgets are incapable of directly signaling an interrupt because
they cannot initiate a bus transaction by themselves.  All communication
on the bus is initiated by the host controller, which polls a gadget's
Interrupt Endpoint in regular intervals.  If an interrupt is pending,
that information is passed up the stack in softirq context, from which
a hardirq is synthesized via generic_handle_domain_irq().

Deduplicate the warning to eliminate false positives and speed up IRQ
handling.

Fixes: 0953fb263714 ("irq: remove handle_domain_{irq,nmi}()")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.16+
Cc: Mark Rutland <mark.rutland@arm.com>
---
 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 939d21c..da3e495 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -699,7 +699,6 @@ int generic_handle_irq_safe(unsigned int irq)
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
-	WARN_ON_ONCE(!in_hardirq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
-- 
2.35.2

