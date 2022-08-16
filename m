Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E15596076
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiHPQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbiHPQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:40:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6137F10E;
        Tue, 16 Aug 2022 09:39:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D446106F;
        Tue, 16 Aug 2022 09:40:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.44.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99633F67D;
        Tue, 16 Aug 2022 09:39:57 -0700 (PDT)
Date:   Tue, 16 Aug 2022 17:39:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
Message-ID: <YvvIWmDBWdIUCMZj@FVFF77S0Q05N>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
 <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
 <Yvuvm7Onw3pmB9Z6@FVFF77S0Q05N>
 <Yvu4TyFmeOd/rJ8t@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvu4TyFmeOd/rJ8t@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:31:27PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 03:54:19PM +0100, Mark Rutland wrote:
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index ee8b9ecdc03b..d4d53b9ba71e 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -631,7 +631,12 @@ struct pmu_event_list {
> > >  	struct list_head	list;
> > >  };
> > >  
> > > +/*
> > > + * Iterating the sibling list requires this list to be stable; by ensuring IRQs
> > > + * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
> > > + */
> > >  #define for_each_sibling_event(sibling, event)			\
> > > +	lockdep_assert_irqs_disabled();				\
> > >  	if ((event)->group_leader == (event))			\
> > >  		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
> > >  
> > 
> > I had a go with v6.0-rc1 and Vince's perf fuzzer immediately triggered a bunch
> > of cases (dump below).
> > 
> > I had thought holding the context mutex protected some of these cases, even
> > with IRQs unmasked?
> 
> Ah yes.. duh. How's this then?
> 
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..4d9cf508c510 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -631,7 +631,21 @@ struct pmu_event_list {
>  	struct list_head	list;
>  };
>  
> +#ifdef CONFIG_LOCKDEP
> +#define LOCKDEP_ASSERT_EVENT_CTX(event)				\
> +	WARN_ON_ONCE(__lockdep_enabled &&			\
> +		     (this_cpu_read(hardirqs_enabled) ||	\
> +		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))

Uh, should that `||` be `&&`, or am I missing the plot?

This'll warn if IRQs are enabled regardless of whether the mutex is held.

Thanks,
Mark.

> +#else
> +#define LOCKDEP_ASSERT_EVENT_CTX(event)
> +#endif
> +
> +/*
> + * Iterating the sibling list requires this list to be stable; by ensuring IRQs
> + * are disabled IPIs from perf_{install_in,remove_from}_context() are held off.
> + */
>  #define for_each_sibling_event(sibling, event)			\
> +	LOCKDEP_ASSERT_EVENT_CTX(event);			\
>  	if ((event)->group_leader == (event))			\
>  		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
>  
