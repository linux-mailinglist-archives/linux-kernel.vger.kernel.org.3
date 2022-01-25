Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D174D49BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiAYWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:51:04 -0500
Received: from elvis.franken.de ([193.175.24.41]:40123 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234546AbiAYWuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:50:25 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nCUdn-00055K-00; Tue, 25 Jan 2022 23:50:19 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C55C2C10E8; Tue, 25 Jan 2022 20:05:31 +0100 (CET)
Date:   Tue, 25 Jan 2022 20:05:31 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 38/54] arch/mips: replace cpumask_weight with
 cpumask_weight_{eq, ...} where appropriate
Message-ID: <20220125190531.GA31998@alpha.franken.de>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-39-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-39-yury.norov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:09AM -0800, Yury Norov wrote:
> Mips code uses calls cpumask_weight() to compare the weight of
> cpumask with a given number. We can do it more efficiently with
> cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/cavium-octeon/octeon-irq.c | 4 ++--
>  arch/mips/kernel/crash.c             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 844f882096e6..914871f15fb7 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -763,7 +763,7 @@ static void octeon_irq_cpu_offline_ciu(struct irq_data *data)
>  	if (!cpumask_test_cpu(cpu, mask))
>  		return;
>  
> -	if (cpumask_weight(mask) > 1) {
> +	if (cpumask_weight_gt(mask, 1)) {
>  		/*
>  		 * It has multi CPU affinity, just remove this CPU
>  		 * from the affinity set.
> @@ -795,7 +795,7 @@ static int octeon_irq_ciu_set_affinity(struct irq_data *data,
>  	 * This removes the need to do locking in the .ack/.eoi
>  	 * functions.
>  	 */
> -	if (cpumask_weight(dest) != 1)
> +	if (!cpumask_weight_eq(dest, 1))
>  		return -EINVAL;
>  
>  	if (!enable_one)
> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> index 81845ba04835..5b690d52491f 100644
> --- a/arch/mips/kernel/crash.c
> +++ b/arch/mips/kernel/crash.c
> @@ -72,7 +72,7 @@ static void crash_kexec_prepare_cpus(void)
>  	 */
>  	pr_emerg("Sending IPI to other cpus...\n");
>  	msecs = 10000;
> -	while ((cpumask_weight(&cpus_in_crash) < ncpus) && (--msecs > 0)) {
> +	while (cpumask_weight_lt(&cpus_in_crash, ncpus) && (--msecs > 0)) {
>  		cpu_relax();
>  		mdelay(1);
>  	}
> -- 
> 2.30.2

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
