Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB325A7A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiHaJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiHaJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:21:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFE58B7D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kK+XMJV0/YhfpKPZbd/s30ctUurPa+Zo75M/EKpbi9g=; b=kQT7uZVeKfy20tzN+44Y8c2Ff2
        aJYcOYSGZ2w6qw7KQ2Eku43WznOwfPP52lqOzQyzMZ9vINDeNLi3bzL0sVAgjHdfRgRRuifmUZ5aa
        M9uxdejuMLW26kadxVeQ+fWR5lsXiEMqoROvMFBk/2q3KdRgoJYN5rNlC9K0imlhhAxszxXPa4KiH
        VEmkng+3UUqIQZHyBvPn7nLXBJr/otiNtdi1SnPxtDbWuAbQqKmEJY68uFH4LVWHYm2+NloPkBFdf
        At+jQ778YPTx+KvVnHGSxC6NwzJ8jcVpqPxtkrPbUb1CjnDwZlrPqyPtwzrvhSlEemg7fMu9EA3pb
        lT1vr6GQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTJu9-004xg6-NB; Wed, 31 Aug 2022 09:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3768A3002AF;
        Wed, 31 Aug 2022 11:21:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B4422B846314; Wed, 31 Aug 2022 11:21:00 +0200 (CEST)
Date:   Wed, 31 Aug 2022 11:21:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 3/5] sched: Enforce user requested affinity
Message-ID: <Yw8n/Ef1NWnwmHYW@hirez.programming.kicks-ass.net>
References: <20220826010119.1265764-1-longman@redhat.com>
 <20220826010119.1265764-4-longman@redhat.com>
 <Yw8nXttOnNjK/1y4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw8nXttOnNjK/1y4@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:18:22AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 09:01:17PM -0400, Waiman Long wrote:
> 
> > @@ -9352,6 +9381,11 @@ int sched_cpu_activate(unsigned int cpu)
> >  		sched_update_numa(cpu, true);
> >  		sched_domains_numa_masks_set(cpu);
> >  		cpuset_cpu_active();
> > +		/*
> > +		 * Preallocated scratch cpumask
> > +		 */
> > +		if (!rq->scratch_mask)
> > +			rq->scratch_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> >  	}
> 
> this is too late; I think you'll have to add a sched_cpu_prepare() and
> simply fail the cpu-up when the allocation fails.

Alternatively, waste some more memory and add yet another per-cpu
cpumask.
