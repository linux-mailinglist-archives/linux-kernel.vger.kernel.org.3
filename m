Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A952216B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347505AbiEJQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347605AbiEJQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:41:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78E5713A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KpwWNreFeTuCcxTdHAMo1S3rKPJF9c1Z0HYV5/yVvCU=; b=ZpY71xKOHtVKQLm2Reos3RHOvW
        fhhdIToMlATcbmUrnAfmmKMwrUZjDI4ZHTysj+Od+ZONGn0d4/eA5x5ySgcw9u7YaZVGZ4rQyNiKg
        AApC3WK5oPERHpO658S/8Ih0LiKhcHF66aHpV3EjoeKyh6aYqleqFKwPbMMoEEeoy/rK8PKpfxYdz
        k6LlUQYv+93jA2P/bsTSVVp5ap89lgYilhnlChQtatXH4KA0FSwEc30MQpSoDRJJEWTeGftCTSkfe
        FWICggNEyMWHQZ0qtimSwCGaXwq3+sDT4nR0BT/Y9TtbCguUzNhJXpVS6/PJL1D+0REzE8QkMh+7R
        FCoh5U+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noSrG-00Ctrb-9M; Tue, 10 May 2022 16:37:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCFAA98100A; Tue, 10 May 2022 18:37:07 +0200 (CEST)
Date:   Tue, 10 May 2022 18:37:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 17/22] sched/core: fix opencoded cpumask_any_but()
Message-ID: <20220510163707.GO76023@worktop.programming.kicks-ass.net>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-18-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154750.212913-18-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:47:45AM -0700, Yury Norov wrote:
> sched_core_cpu_starting() and sched_core_cpu_deactivate() implement
> opencoded cpumask_any_but(). Fix it.
> 
> CC: Ben Segall <bsegall@google.com>
> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Valentin Schneider <vschneid@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/sched/core.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f5ebc392493d..9700001948d0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6125,7 +6125,7 @@ static void queue_core_balance(struct rq *rq)
>  static void sched_core_cpu_starting(unsigned int cpu)
>  {
>  	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> -	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
> +	struct rq *rq = cpu_rq(cpu), *core_rq;
>  	unsigned long flags;
>  	int t;
>  
> @@ -6138,19 +6138,16 @@ static void sched_core_cpu_starting(unsigned int cpu)
>  		goto unlock;
>  
>  	/* find the leader */
> -	for_each_cpu(t, smt_mask) {
> -		if (t == cpu)
> -			continue;
> -		rq = cpu_rq(t);
> -		if (rq->core == rq) {
> -			core_rq = rq;
> -			break;
> -		}
> -	}
> +	t = cpumask_any_but(smt_mask, cpu);
> +	if (t >= nr_cpu_ids)
> +		goto unlock;
>  
> -	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
> +	rq = cpu_rq(t);
> +	if (WARN_ON_ONCE(rq->core != rq)) /* whoopsie */
>  		goto unlock;
>  
> +	core_rq = rq;
> +
>  	/* install and validate core_rq */
>  	for_each_cpu(t, smt_mask) {
>  		rq = cpu_rq(t);

I don't think this is equivalent. Imagine SMT4, with:

  rqN->core_rq = rq0

Now, further suppose smt0-2 are online and we're about to online smt3.
Then t above is free to be smt2, which then results in insta triggering:

+	if (WARN_ON_ONCE(rq->core != rq)) /* whoopsie */

You seem to have lost how the first loop searches for rq->core.

Please, be more careful. Also, all of this is super cold path don't
bother with optimizations. Much of the patches you have in this series
fall under that.
