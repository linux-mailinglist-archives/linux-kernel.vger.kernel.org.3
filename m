Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4283B4C4BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiBYRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbiBYRMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:12:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA589202893
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:12:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 713AAED1;
        Fri, 25 Feb 2022 09:12:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.19.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598573F70D;
        Fri, 25 Feb 2022 09:12:16 -0800 (PST)
Date:   Fri, 25 Feb 2022 17:12:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] clocksource/drivers/arm_arch_timer: Use event stream
 scaling when available
Message-ID: <YhkN7Ds6dZompwks@FVFF77S0Q05N>
References: <20220203170502.2694422-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203170502.2694422-1-maz@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:05:02PM +0000, Marc Zyngier wrote:
> With FEAT_ECV and the 1GHz counter, it is pretty likely that the
> event stream divider doesn't fit in the field that holds the
> divider value (we only have 4 bits to describe counter bits [15:0]

I was worried we'd be orders of magnitude out, but it looks like we're on the
borderline here. IIUC if we have a 1GHz counter and *don't* have ECV, the best
we can do is count bit 15 transitioning (one-way), and the minimal event
frequency we can get is:

  1_000_000_000 / 2 / (1 << 15))

Which is ~15KHz.

With ECV we can make that, using bit 16 instead we get ~7.5KHz.

Is that right? Could we note this in the commit message?

Given that, this seems reasonable, but not crititcally important for
backporting or whatever.

Longer term, for WFET we'll need to consider disabling the event stream (either
by default or opt-in).

> Thankfully, FEAT_ECV also provides a scaling mechanism to switch
> the field to cover counter bits [23:8] instead.
> 
> Enable this on arm64 when ECV is available (32bit doesn't have
> any detection infrastructure and is unlikely to be run on an
> ARMv8.6 system anyway).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>

The logic looks right to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/clocksource/arm_arch_timer.c | 13 +++++++++++--
>  include/clocksource/arm_arch_timer.h |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 1ecd52f903b8..9ab8221ee3c6 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -880,10 +880,19 @@ static void __arch_timer_setup(unsigned type,
>  	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
>  }
>  
> -static void arch_timer_evtstrm_enable(int divider)
> +static void arch_timer_evtstrm_enable(unsigned int divider)
>  {
>  	u32 cntkctl = arch_timer_get_cntkctl();
>  
> +#ifdef CONFIG_ARM64
> +	/* ECV is likely to require a large divider. Use the EVNTIS flag. */
> +	if (cpus_have_const_cap(ARM64_HAS_ECV) && divider > 15) {
> +		cntkctl |= ARCH_TIMER_EVT_INTERVAL_SCALE;
> +		divider -= 8;
> +	}
> +#endif
> +
> +	divider = min(divider, 15U);
>  	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
>  	/* Set the divider and enable virtual event stream */
>  	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
> @@ -912,7 +921,7 @@ static void arch_timer_configure_evtstream(void)
>  		lsb++;
>  
>  	/* enable event stream */
> -	arch_timer_evtstrm_enable(max(0, min(lsb, 15)));
> +	arch_timer_evtstrm_enable(max(0, lsb));
>  }
>  
>  static void arch_counter_set_user_access(void)
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index e715bdb720d5..057c8964aefb 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -56,6 +56,7 @@ enum arch_timer_spi_nr {
>  #define ARCH_TIMER_EVT_TRIGGER_MASK	(0xF << ARCH_TIMER_EVT_TRIGGER_SHIFT)
>  #define ARCH_TIMER_USR_VT_ACCESS_EN	(1 << 8) /* virtual timer registers */
>  #define ARCH_TIMER_USR_PT_ACCESS_EN	(1 << 9) /* physical timer registers */
> +#define ARCH_TIMER_EVT_INTERVAL_SCALE	(1 << 17) /* EVNTIS in the ARMv8 ARM */
>  
>  #define ARCH_TIMER_EVT_STREAM_PERIOD_US	100
>  #define ARCH_TIMER_EVT_STREAM_FREQ				\
> -- 
> 2.34.1
> 
