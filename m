Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81A6522DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbiEKILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbiEKILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:11:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E7DB36684;
        Wed, 11 May 2022 01:11:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB718106F;
        Wed, 11 May 2022 01:11:09 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9853F73D;
        Wed, 11 May 2022 01:11:05 -0700 (PDT)
Date:   Wed, 11 May 2022 09:11:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lukas Wunner <lukas@wunner.de>, maz@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        palmer@dabbelt.com, paul.walmsley@sifive.com, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@kernel.org, vladimir.murzin@arm.com, will@kernel.org
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <YntvlrKyyhChlmrb@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
 <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de>
 <Ynpzb5L53iGex14D@FVFF77S0Q05N>
 <874k1xorlj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k1xorlj.ffs@tglx>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 02:11:52AM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 15:15, Mark Rutland wrote:
> > On Tue, May 10, 2022 at 02:13:20PM +0200, Lukas Wunner wrote:
> >> Actually, since you're mentioning the in_nmi() check, I suspect
> >> there's another problem here:
> >> 
> >> generic_handle_domain_nmi() warns if !in_nmi(), then calls down 
> >> to handle_irq_desc() which warns if !in_hardirq().  Doesn't this
> >> cause a false-positive !in_hardirq() warning for a NMI on GIC/GICv3?
> >
> > I agree that doesn't look right.
> >
> >> The only driver calling request_nmi() or request_percpu_nmi() is
> >> drivers/perf/arm_pmu.c.  So that's the only one affected.
> >> You may want to test if that driver indeed exhibits such a
> >> false-positive warning since c16816acd086.
> >
> > In testing with v5.18-rc5, I can't see that going wrong.
> >
> > I also hacked the following in:
> >
> > -------->8--------
> > diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> > index 939d21cd55c38..3c85608a8779f 100644
> > --- a/kernel/irq/irqdesc.c
> > +++ b/kernel/irq/irqdesc.c
> > @@ -718,6 +718,7 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
> >  int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
> >  {
> >         WARN_ON_ONCE(!in_nmi());
> > +       WARN_ON_ONCE(!in_hardirq());
> >         return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> 
> which is pointless because NMI entry code has to invoke [__]nmi_enter()
> before invoking this function. [__]nmi_enter() does:
> 
>     __preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);
> 
> So it's more than bloody obvious why there is no warning triggered for a
> regular hardware induced NMI invocation.

Ugh, yes; clearly I need new eyes and/or more sleep. I entirely missed that we
treat an NMI as *also* being a hardirq rather than something completely
independent, and that means that this is *not* a problem for NMI.

Thanks for pointing that out!

> For a software invocation from the wrong context it does not matter how
> many redundant WARN_ONs you add. The existing ones are covering it
> nicely already.

Yup; as above I was clearly not thinknig straight here.

Mark.
