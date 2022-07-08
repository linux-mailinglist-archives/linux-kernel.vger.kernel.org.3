Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3A56BB0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiGHNlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiGHNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:41:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DBC2A703;
        Fri,  8 Jul 2022 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZG0X/u2bNGrOSRwgd/Cf/2JtluWVYNjaS55/gTNyDxw=; b=pbDHg+nEKoKVOqF3TDDxJ06kJ3
        O4m88Cjk7bksbzNMCeGew8G7e2Hjr8fVMkoZDD/pkMPvQ3nxTa8P2zg/tOn6UIBc1NIdhJ8jYBQB5
        RcLDzyJhnsNeSaTLJTqYsPzOcHhw32jtpe/le3spGQ+LNOw+iUqd/lnm/0k2wi2h5sdrG6Ss4IgtI
        nK2orJW28DkUW9K/yE2HB0T2vXWgwYw8V5L0nPxtecVVyKHbgnVpo3xI+LAisa7SSxOkVbVflgSX7
        aU7REpWJ38CcLNgQ+RS9HLx5+oV7kqlMmWu46iR8rKreOQlf07ufehyKaih8NJyqtjTuAGTm9mbBC
        caYJn+Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9oE2-001kOL-UQ; Fri, 08 Jul 2022 13:40:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCE2598007C; Fri,  8 Jul 2022 15:31:59 +0200 (CEST)
Date:   Fri, 8 Jul 2022 15:31:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: Add macros for possible
 sysctl_perf_event_paranoid values
Message-ID: <Ysgxzxl0N7+J8Vbt@worktop.programming.kicks-ass.net>
References: <20220701063949.1769434-1-anshuman.khandual@arm.com>
 <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9da8d22-6896-68a3-b4e5-e8fd7b82b711@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 10:10:15AM +0100, James Clark wrote:
> 
> 
> On 01/07/2022 07:39, Anshuman Khandual wrote:
> > sysctl_perf_event_paranoid can have values from [-1, 0, 1, 2] which decides
> > on perf event restrictions for unprivileged users. But using them directly
> > makes it difficult to correlate exact restriction level they might impose.
> > This just adds macros for those numerical restriction values, making them
> > clear and improving readability.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/perf_event.h | 22 ++++++++++++++++++----
> >  kernel/events/core.c       |  9 +--------
> >  kernel/kallsyms.c          |  3 ++-
> >  3 files changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index da759560eec5..78156b9154df 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1359,14 +1359,28 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
> >  #define PERF_SECURITY_KERNEL		2
> >  #define PERF_SECURITY_TRACEPOINT	3
> >  
> > +/*
> > + * perf event paranoia level:
> > + *  -1 - not paranoid at all
> > + *   0 - disallow raw tracepoint access for unpriv
> > + *   1 - disallow cpu events for unpriv
> > + *   2 - disallow kernel profiling for unpriv
> > + */
> > +enum {
> > +	PERF_EVENT_DISALLOW_NONE	= -1,
> > +	PERF_EVENT_DISALLOW_TRACE,
> > +	PERF_EVENT_DISALLOW_CPU,
> > +	PERF_EVENT_DISALLOW_KERNEL
> > +};
> > +
> >  static inline int perf_is_paranoid(void)
> >  {
> > -	return sysctl_perf_event_paranoid > -1;
> > +	return sysctl_perf_event_paranoid > PERF_EVENT_DISALLOW_NONE;
> >  }
> >  
> 
> Hi Anshuman,
> 
> There are quite a few other instances of integers left in the tools code.
> If you search for perf_event_paranoid_check() and perf_event_paranoid()
> you will find them.
> 
> I'm also wondering if it makes sense to return your new enum from all of
> the helper functions instead of an int and make it explicit that it's
> an instance of this new type? Although the compiler doesn't seem to warn
> about using integers so maybe it's not worth doing this.

so I don't see the point of all this; it's already wrapped in these
helper functions that have a descriptive name, why do we need more muck
on top?
