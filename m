Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADF46A545
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbhLFTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:01:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58618 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhLFTBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:01:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF619B811ED
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF80C341C5;
        Mon,  6 Dec 2021 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638817103;
        bh=nUsQ1XV3qRZjwsUTBcA3Qf7V0lJmi8OkalkE0741Bgg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ErrxFY789NwStjpL7G2XBmeCuxapYj76pnMISFislX9F+rKnveNFaY1KY5BB3pjbv
         RNPbtZONX1YhFis7UW4UECgst8y7z5xuakReopIc07WvzZCZyZ0FsNidB97wyWegPx
         p2lEfMYCqgfG7JWbXy+aToZ8Aoz2Gg82NF/zvd8ZSLnUX9B3FMrvRr5Dp/JxYkD+/N
         cm+CxHoqjbfPwzOiz2jiWNgmdefAq7w0XXuVuDIlGvmp2xWaG4w4z43LwPtt0OuZkP
         4yBaNNGr2apgLKa/RHQbagc8N9n6Trvm8mIp2whM6zzhSM8eJ6xZ1NBULqlJQTRPiV
         FJmYF+nb3TAzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 801B75C1461; Mon,  6 Dec 2021 10:58:23 -0800 (PST)
Date:   Mon, 6 Dec 2021 10:58:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-rcu] clocksource: Add a Kconfig option for
 WATCHDOG_MAX_SKEW
Message-ID: <20211206185823.GC641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211206033815.871823-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206033815.871823-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:38:15PM -0500, Waiman Long wrote:
> A watchdog maximum skew of 100us may still be too small for
> some systems or archs. It may also be too small when some kernel
> debug config options are enabled.  So add a new Kconfig option
> CLOCKSOURCE_WATCHDOG_MAX_SKEW_US to allow kernel builders to have more
> control on the threshold for marking clocksource as unstable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Queued, thank you!

							Thanx, Paul

> ---
>  kernel/time/Kconfig       | 9 +++++++++
>  kernel/time/clocksource.c | 8 +++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 04bfd62f5e5c..27b7868b5c30 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -181,5 +181,14 @@ config HIGH_RES_TIMERS
>  	  hardware is not capable then this option only increases
>  	  the size of the kernel image.
>  
> +config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> +	int "Clocksource watchdog maximum allowable skew (in μs)"
> +	depends on CLOCKSOURCE_WATCHDOG
> +	range 50 1000
> +	default 100
> +	help
> +	  Specify the maximum amount of allowable watchdog skew in
> +	  microseconds before reporting the clocksource to be unstable.
> +
>  endmenu
>  endif
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b7e52a642948..877a78bea9b0 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -107,7 +107,13 @@ static u64 suspend_start;
>   * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
>   * a lower bound for cs->uncertainty_margin values when registering clocks.
>   */
> -#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
> +#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> +#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
> +#else
> +#define MAX_SKEW_USEC	100
> +#endif
> +
> +#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
>  
>  #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
>  static void clocksource_watchdog_work(struct work_struct *work);
> -- 
> 2.27.0
> 
