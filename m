Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1C522F61
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiEKJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiEKJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:28:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08E5547545;
        Wed, 11 May 2022 02:28:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71611FB;
        Wed, 11 May 2022 02:28:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1EC73F73D;
        Wed, 11 May 2022 02:27:56 -0700 (PDT)
Date:   Wed, 11 May 2022 10:27:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <YnuBk5dP89w6lvhB@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
 <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de>
 <Ynpzb5L53iGex14D@FVFF77S0Q05N>
 <87a6bpov9u.ffs@tglx>
 <YntynKK5Jjw2Q1rX@FVFF77S0Q05N>
 <20220511085741.GA6558@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511085741.GA6558@wunner.de>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:57:41AM +0200, Lukas Wunner wrote:
> On Wed, May 11, 2022 at 09:23:56AM +0100, Mark Rutland wrote:
> > On Wed, May 11, 2022 at 12:52:29AM +0200, Thomas Gleixner wrote:
> > > +	/* USB interrupts are received in softirq (tasklet) context.
> > > +	 * Switch to hardirq context to make genirq code happy.
> > > +	 */
> > > +	local_irq_save(flags);
> > > +	__irq_enter_raw();
> > > +
> > >  	if (intdata & INT_ENP_PHY_INT_)
> > > -		;
> > > +		generic_handle_domain_irq(pdata->irqdomain, PHY_HWIRQ);
> > 
> > Agreed. IIUC everyone agrees the __irq_enter_raw() usage is a hack,
> > but what's not clear is what we *should* do
> > 
> > I suspect that given we have generic_handle_irq_safe() for situations
> > like this we should add a generic_handle_domain_irq_safe(), and use
> > that in this driver?
> > That way we can keep the `WARN_ON_ONCE(!in_hardirq())` in
> > generic_handle_domain_irq().
> 
> Thomas applied 792ea6a074ae ("genirq: Remove WARN_ON_ONCE() in
> generic_handle_domain_irq()") tonight:
> 
> http://git.kernel.org/tip/tip/c/792ea6a074ae

Ah; I missed that. Sorry for the noise!

> That allows me to drop the controversial __irq_enter_raw()
> and thus unblock my smsc95xx series.
> 
> generic_handle_domain_irq_safe() would merely be a wrapper for
> generic_handle_domain_irq() which disables local interrupts.
> Then I wouldn't have to do that in smsc95xx.c.  IMHO that's a
> cosmetic improvement, though I'll be happy to provide a patch
> if desired?

I think it's a nice-to-have, but I don't have a strong feelings about it, so I
think we can forget about it for now unless Marc or Thomas want it.

Thanks,
Mark.
