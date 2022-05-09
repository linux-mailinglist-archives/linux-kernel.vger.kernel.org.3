Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490BB51F8DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiEIJgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbiEII60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:58:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 386951FB2CC;
        Mon,  9 May 2022 01:54:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF85F1042;
        Mon,  9 May 2022 01:54:32 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 203253F66F;
        Mon,  9 May 2022 01:54:28 -0700 (PDT)
Date:   Mon, 9 May 2022 09:54:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     maz@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506203242.GA1855@wunner.de>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 10:32:42PM +0200, Lukas Wunner wrote:
> On Tue, Oct 26, 2021 at 10:25:04AM +0100, Mark Rutland wrote:
> > Now that entry code handles IRQ entry (including setting the IRQ regs)
> > before calling irqchip code, irqchip code can safely call
> > generic_handle_domain_irq(), and there's no functional reason for it to
> > call handle_domain_irq().
> > 
> > Let's cement this split of responsibility and remove handle_domain_irq()
> > entirely, updating irqchip drivers to call generic_handle_domain_irq().
> > 
> > For consistency, handle_domain_nmi() is similarly removed and replaced
> > with a generic_handle_domain_nmi() function which also does not perform
> > any entry logic.
> > 
> > Previously handle_domain_{irq,nmi}() had a WARN_ON() which would fire
> > when they were called in an inappropriate context. So that we can
> > identify similar issues going forward, similar WARN_ON_ONCE() logic is
> > added to the generic_handle_*() functions, and comments are updated for
> > clarity and consistency.
> [...]
> >  int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
> >  {
> > +	WARN_ON_ONCE(!in_irq());
> >  	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> >  }
> >  EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
> 
> Why isn't the WARN_ON_ONCE() conditional on handle_enforce_irqctx()?
> (See handle_irq_desc() and c16816acd086.)

I did this for consistency with the in_nmi() check in
generic_handle_domain_nmi(); I was unaware of commit c16816acd086 and
IRQD_HANDLE_ENFORCE_IRQCTX.

I'll have ot leave it to Marc and Thomas as to what we should do there.

> I believe the above change causes a regression in drivers/gpio/gpio-dln2.c
> such that a gratuitous WARN splat is now emitted.

Do you mean you beleive that from inspection, or are you actually seeing this
go wrong in practice?

If it's the latter, are you able to give a copy of the dmesg splat?

Thanks,
Mark.
