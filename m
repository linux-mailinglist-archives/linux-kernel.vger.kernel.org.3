Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D394A4B2321
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbiBKKbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiBKKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:30:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EB2E88
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:30:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A081D106F;
        Fri, 11 Feb 2022 02:30:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D08C3F73B;
        Fri, 11 Feb 2022 02:30:44 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:30:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 33/49] perf: replace bitmap_weight with bitmap_weight_eq
 for ThunderX2
Message-ID: <YgY6zb7FT/lifZfd@FVFF77S0Q05N>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-34-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-34-yury.norov@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:17PM -0800, Yury Norov wrote:
> tx2_uncore_event_start() calls bitmap_weight() to compare the weight
> of bitmap with a given number. We can do it more efficiently with
> bitmap_weight_eq because conditional bitmap_weight may stop traversing
> the bitmap earlier, as soon as condition is (or can't be) met.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Given the max counters value is either 4 or 8 I doubt this should matter, but
for consistenct this is fine, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I now see bitmap_weight_eq() is introduced within this series, so I assume you
need to queue that and its users together, and will want to take the prior
drivers/perf/ bit together with that.

Thanks,
Mark.

> ---
>  drivers/perf/thunderx2_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> index 1edb9c03704f..97d5b39778fa 100644
> --- a/drivers/perf/thunderx2_pmu.c
> +++ b/drivers/perf/thunderx2_pmu.c
> @@ -623,8 +623,8 @@ static void tx2_uncore_event_start(struct perf_event *event, int flags)
>  		return;
>  
>  	/* Start timer for first event */
> -	if (bitmap_weight(tx2_pmu->active_counters,
> -				tx2_pmu->max_counters) == 1) {
> +	if (bitmap_weight_eq(tx2_pmu->active_counters,
> +				tx2_pmu->max_counters, 1)) {
>  		hrtimer_start(&tx2_pmu->hrtimer,
>  			ns_to_ktime(tx2_pmu->hrtimer_interval),
>  			HRTIMER_MODE_REL_PINNED);
> -- 
> 2.32.0
> 
