Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5EB497A00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiAXIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbiAXIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:07:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A56C061744
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wV3SNZJt019Z8eknUHkpxEDgSZUD0nuuRc3+d39hdr0=; b=Q6PD5OPjKjQCu4KgAV3mY8DoM2
        8JmtpdNX5ydY2gti/ah6ib99vAF8oQgWSbUO/ZWln2rM54eQMIcxRxdDeFJtAXL+3xfu8sA5E2yA4
        /7iWBZ799RSa2r1gDs3w1Z0PdjqTtgAVCWUiGRGk+t7cX412VWnhPP5tl5hXjjsFCs1H/ZRLcwGJh
        mAfhkEIkALZ14KK7XnVFmu4ROB2jluLNiTBYPrvoFCUtOw75FyHHReBnrmDQtN3NSXjDSmi/zMR2q
        JyoytrPtPghvw1lAIYVueNsDyfuxseF6MtODoC2R0gjQgRJt4m0HP3H4j4d2QhfiDR0o45LbqtdzZ
        nou8xg9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBuN6-000JI7-E5; Mon, 24 Jan 2022 08:06:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4177598624A; Mon, 24 Jan 2022 09:06:39 +0100 (CET)
Date:   Mon, 24 Jan 2022 09:06:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 48/54] kernel/time: replace cpumask_weight with
 cpumask_weight_eq where appropriate
Message-ID: <20220124080639.GK20638@worktop.programming.kicks-ass.net>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-49-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-49-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:19AM -0800, Yury Norov wrote:
> tick_cleanup_dead_cpu() calls cpumask_weight() to compare the weight
> of cpumask with a given number. We can do it more efficiently with
> cpumask_weight_eq() because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is met.

But again, nobody gives a crap about performance here..

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/time/clockevents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 003ccf338d20..32d6629a55b2 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -648,7 +648,7 @@ void tick_cleanup_dead_cpu(int cpu)
>  	 */
>  	list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
>  		if (cpumask_test_cpu(cpu, dev->cpumask) &&
> -		    cpumask_weight(dev->cpumask) == 1 &&
> +		    cpumask_weight_eq(dev->cpumask, 1) &&
>  		    !tick_is_broadcast_device(dev)) {
>  			BUG_ON(!clockevent_state_detached(dev));
>  			list_del(&dev->list);
> -- 
> 2.30.2
> 
