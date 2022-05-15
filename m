Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9985A527695
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiEOJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiEOJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:25:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72C13F4B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:25:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652606706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4OL9iZZAlbFbZe/YdKVfu/q9AQtPYZxzYOxLeX5JjE=;
        b=X+eGbj8FCXe4XpH84EXPDvLbcVqAzjRrvyGNmso5XVpSfcKCMaQZA76bzzburKxGSiWxFh
        s8kIHLMXmjh9PMt7BBiuB67czZFpuOAzuhlayDFK4qAccQRfgeJ3LaJo+M6tNUY4GBi3CV
        EN70A56t1MgR0iOos9R313u6UjxQo/W9dwgzralt6YfIDQyoAQ/oW0S1WzYMER83viuwq5
        3OYIyQaU/hCVon+FhVTVZ8w70IReXhfTEtIQKJPZ8qbI1pZx+txlT/wIvKb80lfneY05ZE
        cmg7++SkMRRSyQvrA/RyBspT83dCvn+vSNtfFf9gTeLWV1Z3nQp+MZco3893DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652606706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H4OL9iZZAlbFbZe/YdKVfu/q9AQtPYZxzYOxLeX5JjE=;
        b=CuMulhl3uUMkLypembwW8bFR/0pQdHimCTRBvZs2/TgQkuO56q3ApaaJcc5n5VDPXN6Eaj
        +LUxtJsW42FJcWBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.18-rc7
Message-ID: <165260667543.920532.17932536291158599837.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 15 May 2022 11:25:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-=
05-15

up to:  792ea6a074ae: genirq: Remove WARN_ON_ONCE() in generic_handle_domain_=
irq()


A single fix for a recent (introduced in 5.16) regression in the core
interrupt code. The consolidation of the interrupt handler invocation code
added an unconditional warning when generic_handle_domain_irq() is invoked
from outside hard interrupt context. That's overbroad as the requirement
for invoking these handlers in hard interrupt context is only required for
certain interrupt types. The subsequently called code already contains a
warning which triggers conditionally for interrupt chips which indicate
this requirement in their properties. Remove the overbroad one.

Thanks,

	tglx

P.S.: I added a couple of links this time which point to relevant
context. If that's too broad, holler.

------------------>
Lukas Wunner (1):
      genirq: Remove WARN_ON_ONCE() in generic_handle_domain_irq()


 kernel/irq/irqdesc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0099b87dd853..d323b180b0f3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -701,7 +701,6 @@ EXPORT_SYMBOL_GPL(generic_handle_irq_safe);
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
-	WARN_ON_ONCE(!in_hardirq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);

