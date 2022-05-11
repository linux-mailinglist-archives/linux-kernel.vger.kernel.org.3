Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80316522E44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiEKIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiEKIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:24:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F141A562D6;
        Wed, 11 May 2022 01:24:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A67FF106F;
        Wed, 11 May 2022 01:24:04 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24923F73D;
        Wed, 11 May 2022 01:24:00 -0700 (PDT)
Date:   Wed, 11 May 2022 09:23:56 +0100
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
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <YntynKK5Jjw2Q1rX@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
 <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de>
 <Ynpzb5L53iGex14D@FVFF77S0Q05N>
 <87a6bpov9u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6bpov9u.ffs@tglx>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:52:29AM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 15:15, Mark Rutland wrote:
> > On Tue, May 10, 2022 at 02:13:20PM +0200, Lukas Wunner wrote:
> >> For gpio-dln2.c, I believe it from inspection.
> >> 
> >> For smsc95xx.c, I'm actually seeing it go wrong in practice,
> >> unedited dmesg splat is included below FWIW.
> >
> > Thanks; having the trace makes this much easier to analyse.
> 
> which confirmes what I talked about before:
> 
> >> WARNING: CPU: 3 PID: 75 at kernel/irq/irqdesc.c:702 generic_handle_domain_irq+0x88/0x94
> >>  generic_handle_domain_irq from smsc95xx_status+0x54/0xb0
> >>  smsc95xx_status from intr_complete+0x80/0x84
> >>  intr_complete from __usb_hcd_giveback_urb+0xa4/0x12c
> >>  __usb_hcd_giveback_urb from usb_hcd_giveback_urb+0x118/0x11c
> >>  usb_hcd_giveback_urb from completion_tasklet_func+0x7c/0xc8
> >>  completion_tasklet_func from tasklet_callback+0x20/0x24
> >>  tasklet_callback from tasklet_action_common.constprop.0+0x148/0x220
> >>  tasklet_action_common.constprop.0 from tasklet_hi_action+0x28/0x30
> >>  tasklet_hi_action from __do_softirq+0x154/0x3e8
> >>  __do_softirq from __local_bh_enable_ip+0x12c/0x1a8
> >>  __local_bh_enable_ip from irq_forced_thread_fn+0x7c/0xac
> >>  irq_forced_thread_fn from irq_thread+0x16c/0x228
> >>  irq_thread from kthread+0x100/0x140
> 
> So what happens here:
> 
>  interrupt
>     -> wakeup threaded handler
> 
>  threaded handler runs
>     local_bh_disable();
>     ....
>     schedules tasklet
>     ...
>     local_bh_enable()
>       do_softirq()
>         run_tasklet()
>           urb_completion()
>             smsc95xx_status()
>               generic_handle_domain_irq()
> 
> That interrupt in question is an interrupt, which is not handled by the
> primary CPU interrupt chips. It's a synthetic interrupt which is
> generated from the received USB packet.
> 
> +	/* USB interrupts are received in softirq (tasklet) context.
> +	 * Switch to hardirq context to make genirq code happy.
> +	 */
> +	local_irq_save(flags);
> +	__irq_enter_raw();
> +
>  	if (intdata & INT_ENP_PHY_INT_)
> -		;
> +		generic_handle_domain_irq(pdata->irqdomain, PHY_HWIRQ);
> 
> This __irq_enter_raw() is really wrong. This is _not_ running in hard
> interrupt context. Pretending so creates more problems than it
> solves. It breaks context tracking, confuses lockdep ...
> 
> We also have demultiplexed interrupts which are nested in a threaded
> interrupt handler and share the thread context. No, we are not going to
> pretend that they run in hard interrupt context either.
> 
> So we need a clear distinction between interrupts which really happen in
> hard interrupt context and those which are synthetic and can be invoked
> from pretty much any context.
> 
> Anything else is just a recipe for disaster and endless supply of half
> baken hacks.

Agreed. IIUC everyone agrees the __irq_enter_raw() usage is a hack, but what's
not clear is what we *should* do -- sorry if I'm being thick here.

I suspect that given we have generic_handle_irq_safe() for situations like this
we should add a generic_handle_domain_irq_safe(), and use that in this driver?
That way we can keep the `WARN_ON_ONCE(!in_hardirq())` in
generic_handle_domain_irq().

... or do you think we should do something else entirely?

Thanks,
Mark.
