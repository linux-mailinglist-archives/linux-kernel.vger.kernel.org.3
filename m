Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF064DC347
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiCQJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCQJsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:48:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A421D7DB4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:47:31 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647510449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tumt5osRrCKQbL6rmSvAeMUsR7rsUT0BNA75yAoEbpw=;
        b=2BqY/3HRYoWdgW/TT1EfcRjJhhmjZwUcB7hDY+euHt+f62U4tFj1c8JwU+A3J04NLXuvGV
        MuWhRx4oFB40oSR2cxl+lLVDGo2NtB51vr1TnA2qRjqDU1pQGB/I7nTSDY+UyNYsXtecuG
        ILBzgrPeMqcIKsvEweQv6LmyPgLQt/XKeAJYGuiFfZxzxb7t0VxStxNlG4QX7850D9Bf7W
        ro3yD1Q6J/r/GRHUAKaNyrNdZq+ZlkmTTvs7oIRHWlcYiYMe1vhwVYcg24s/dlTozXsJru
        kXDX1dznPFEcDYY+KcvN01mkOJQqwssOMKwCp7rLGqPAnbrkOao2PzoelQhByA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647510449;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tumt5osRrCKQbL6rmSvAeMUsR7rsUT0BNA75yAoEbpw=;
        b=F+t076fuSel2M1UsBromCGJ9US9royaat7iZzJgspVEeGLg6rjWNZNGl2hLg3eUPeotTsy
        seLpxkUi7yL53hDw==
From:   "irqchip-bot for Stephen Rothwell" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: npcm: Fix broken typing on 64bit
 platforms
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220316183227.725bfd37@canb.auug.org.au>
References: <20220316183227.725bfd37@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <164751044707.389.16417510835118111853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     1c3b5c62fc856e8ba71f071d1cf37b2d88411e8b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/1c3b5c62fc856e8ba71f071d1cf37b2d88411e8b
Author:        Stephen Rothwell <sfr@canb.auug.org.au>
AuthorDate:    Wed, 16 Mar 2022 18:12:14 +11:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Mar 2022 08:20:39=20

pinctrl: npcm: Fix broken typing on 64bit platforms

The npcm driver confuses u32 and unsigned long, which works on
32bit platforms, but leads to disasters on 64bit systems (and
breaks the build if using -Werror=3Darray-bounds).

Use proper typing to address the issue.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
[maz: commit message, additional changes suggested by Jonathan Neusch=C3=A4fe=
r]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220316183227.725bfd37@canb.auug.org.au
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvo=
ton/pinctrl-npcm7xx.c
index ba536fd..a9831da 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -216,7 +216,7 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 	struct gpio_chip *gc;
 	struct irq_chip *chip;
 	struct npcm7xx_gpio *bank;
-	u32 sts, en, bit;
+	unsigned long sts, bit, en;
=20
 	gc =3D irq_desc_get_handler_data(desc);
 	bank =3D gpiochip_get_data(gc);
@@ -225,11 +225,11 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 	sts =3D ioread32(bank->base + NPCM7XX_GP_N_EVST);
 	en  =3D ioread32(bank->base + NPCM7XX_GP_N_EVEN);
-	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8x %.8x\n", sts,
+	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8lx %.8lx\n", sts,
 		en);
=20
 	sts &=3D en;
-	for_each_set_bit(bit, (const void *)&sts, NPCM7XX_GPIO_PER_BANK)
+	for_each_set_bit(bit, &sts, NPCM7XX_GPIO_PER_BANK)
 		generic_handle_domain_irq(gc->irq.domain, bit);
 	chained_irq_exit(chip, desc);
 }
