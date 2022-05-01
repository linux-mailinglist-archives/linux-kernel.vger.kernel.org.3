Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFD51644E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346793AbiEAMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiEAMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADD123172
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 05:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4835860EA1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E80C385AA;
        Sun,  1 May 2022 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651406556;
        bh=3jiGB3l/BCNDk9mdCFdwTsJm8ACLeE2RYaBMzyjS/pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejof5RBF5RSp/H+2Zlnms4Ch9GRzKJjZm2UidbRcF4662qifP3AGTn+1m5SbsYOC1
         bryoEtmeNV5UGyFZM8gUq6C8BGOFUfeqDumAEftB80JyWHdg05RMakVKKjrArub6ro
         M5fWyD3nAYmC3en7n7tw9L7Fdq8Mz7RlDK4jy4pa1wnmcR/Wi1R1qbvO55VNDcd9aY
         kHGubSwWm3K6z2SX4Z9K64/ftGCpHqGvLGMr5Annlz2CZMyKpF4ULqiz/EUTQOzinl
         eYZaqoLhr12IGkpY4StpDERW5RJVGMeh44EsuP+4D/PlEUDUlaKGU1FJG0avId2l65
         QONVmkphySvxw==
Received: by pali.im (Postfix)
        id 22902942; Sun,  1 May 2022 14:02:33 +0200 (CEST)
Date:   Sun, 1 May 2022 14:02:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/armada-370-xp: Do not allow mapping IRQ 0
 and 1
Message-ID: <20220501120233.xfzh62tbuuvatx3v@pali>
References: <20220425113706.29310-1-pali@kernel.org>
 <20220425113706.29310-2-pali@kernel.org>
 <YmvafYwhtIoaOMmk@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmvafYwhtIoaOMmk@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2022 14:30:53 Andrew Lunn wrote:
> On Mon, Apr 25, 2022 at 01:37:06PM +0200, Pali Rohár wrote:
> > IRQs 0 and 1 cannot be mapped, they are handled internally by this driver
> > and this driver does not call generic_handle_domain_irq() for these IRQs.
> > So do not allow mapping these IRQs and correctly propagate error from the
> > .irq_map callback.
> 
> So you are referring to this?
> 
>                 /* Check if the interrupt is not masked on current CPU.
>                  * Test IRQ (0-1) and FIQ (8-9) mask bits.
>                  */
>                 if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
>                         continue;
> 
>                 if (irqn == 1) {
>                         armada_370_xp_handle_msi_irq(NULL, true);
>                         continue;
>                 }

I'm referring to irqn, which is not handled on armada_370_xp_mpic_domain
via generic_handle_domain_irq() when it is == 1.

Also I'm referring to another section:

		if (irqnr > 1) {
			generic_handle_domain_irq(armada_370_xp_mpic_domain,
						  irqnr);
			continue;
		}

		/* MSI handling */
		if (irqnr == 1)
			armada_370_xp_handle_msi_irq(regs, false);

#ifdef CONFIG_SMP
		/* IPI Handling */
		if (irqnr == 0) {
			unsigned long ipimask;
			int ipi;

			ipimask = readl_relaxed(per_cpu_int_base +
						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
				& IPI_DOORBELL_MASK;

			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
				generic_handle_domain_irq(ipi_domain, ipi);
		}
#endif

First 'if (irqnr > 1)' just cause that irqnr 0 and 1 are not handled on
armada_370_xp_mpic_domain via generic_handle_domain_irq().

> 
> Should the two FIQ interrupts also return -EINVAL?
> 
>        Andrew

No. Following code

		irqsrc = readl_relaxed(main_int_base +
				       ARMADA_370_XP_INT_SOURCE_CTL(irqn));

		/* Check if the interrupt is not masked on current CPU.
		 * Test IRQ (0-1) and FIQ (8-9) mask bits.
		 */
		if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
			continue;

skips processing irqn interrupt if it is masked for the current CPU.
Interrupt irqn is **unmasked** on CPU0 if either bit 0 or 8 is set in
register ARMADA_370_XP_INT_IRQ_FIQ_MASK. And **unmasked** on CPU1 if
either bit 1 or 9 is set.

The reason for this check and skipping is because some per-cpu
interrupts on A375, A38x and A39x can be handled directly via GIC and
also via MPIC subhierarchy (it depends what you put into DTS, both
options are possible and working, just some interrupts are MPIC-only).
So if you unmask some interrupt on GIC and interrupt is triggered then
also MPIC per-CPU cause register contains in bit for that triggered
interrupt (even you have not asked MPIC to unmask interrupt). And once
another MPIC interrupt is triggered then routine for handling MPIC
subhierarchy see that some cause bits are set and tried to call
generic_handle_domain_irq() for all of them, also for those which are
masked. That is why it is needed to check if MPIC interrupt is masked on
the current CPU or not prior processing it.

So those bits 0-1 and 8-9 have nothing with mapping interrupts.
