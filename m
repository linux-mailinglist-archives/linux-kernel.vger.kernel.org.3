Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3787B4B22F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348842AbiBKKUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:20:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:20:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329192D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CNMmdEHatvvlAuc93SzMHk+jobcoZUNzh5uJwSlrJVQ=; b=nRujZAD6/P+kyYjcVmV4L/e4Aj
        XWbuquLgDL6R+v5XhLdPe3k/oV7dfJnd5vSLh4zFy7Y0d7lL/ydru09KqVuCsow3xEXbSADtU+Pnw
        UN5WOc5UOoQuH80v8GcdAGgk1ti66FA0oK++exWekD+KyoNolUuHKm7QaUVkQzsVTSQSn4gefLi3a
        dgnjBR0aEZfIsZRtV5h9mGu3hq1p5RwGM6sY7+Ic3I2+Ds4Xye1Mh+mES8/11zW5mYxgNfzXy6TBQ
        1ZLsps9PXC6mpBFy1l4TyV+GqUBLP2tQwAumTGHin2LZD3RVDelPhn/fK4MaZ8c8Cd92nzbqWv12Z
        +G2En54g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIT21-00AJ3W-5a; Fri, 11 Feb 2022 10:20:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E75BC9853C7; Fri, 11 Feb 2022 11:19:58 +0100 (CET)
Date:   Fri, 11 Feb 2022 11:19:58 +0100
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
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 22/49] sched: replace cpumask_weight with cpumask_empty
 where appropriate
Message-ID: <20220211101958.GQ23216@worktop.programming.kicks-ass.net>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-23-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-23-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:06PM -0800, Yury Norov wrote:
> In some places, kernel/sched code calls cpumask_weight() to check if
> any bit of a given cpumask is set. We can do it more efficiently with
> cpumask_empty() because cpumask_empty() stops traversing the cpumask as
> soon as it finds first set bit, while cpumask_weight() counts all bits
> unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Neither of these paths are really performance sentitive, but whatever.

Do you want me to take this now, or do you want to merge the whole
series somewere else? In which case:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/sched/core.c     | 2 +-
>  kernel/sched/topology.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 28d1b7af03dc..ed7b392945b7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8711,7 +8711,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>  {
>  	int ret = 1;
>  
> -	if (!cpumask_weight(cur))
> +	if (cpumask_empty(cur))
>  		return ret;
>  
>  	ret = dl_cpuset_cpumask_can_shrink(cur, trial);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..8478e2a8cd65 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -74,7 +74,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>  			break;
>  		}
>  
> -		if (!cpumask_weight(sched_group_span(group))) {
> +		if (cpumask_empty(sched_group_span(group))) {
>  			printk(KERN_CONT "\n");
>  			printk(KERN_ERR "ERROR: empty group\n");
>  			break;
> -- 
> 2.32.0
> 
