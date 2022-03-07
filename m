Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE84D06F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiCGSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiCGSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:54:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08D0F6A05E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP3Z04R2ENiiCiT1sP6xPbXB81WvAx5IRO6MwOlOi5Y=;
        b=aOxrk4AuBRM4HMKtgEBENadp9WPPKsJezDI9rSEOb5f+Kl5YvSL47+zAWoz5a5MeIhUsN/
        5I6yF/47nzkFx8ex+7Z5v1xMVX+dSt6TkZX/p4XR+yi3WNtcvaGDF3+UMVQSa08ENTLB7a
        U0ozxQfFIHisScPJue8S0+5bM2ua6/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-p9U_p9tIO_O6KctzzHFnpA-1; Mon, 07 Mar 2022 13:53:22 -0500
X-MC-Unique: p9U_p9tIO_O6KctzzHFnpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548001091DA0;
        Mon,  7 Mar 2022 18:53:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1184292307;
        Mon,  7 Mar 2022 18:53:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 305A4416CE5D; Mon,  7 Mar 2022 15:52:43 -0300 (-03)
Date:   Mon, 7 Mar 2022 15:52:43 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch v4] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <YiZUewMgjIt1as25@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:35:54PM -0800, Andrew Morton wrote:
> On Fri, 4 Mar 2022 13:29:31 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> >  
> > On systems that run FIFO:1 applications that busy loop 
> > on isolated CPUs, executing tasks on such CPUs under
> > lower priority is undesired (since that will either
> > hang the system, or cause longer interruption to the
> > FIFO task due to execution of lower priority task 
> > with very small sched slices).
> > 
> > Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU 
> > pagevec during the migration temporarily") relies on 
> > queueing work items on all online CPUs to ensure visibility
> > of lru_disable_count.
> > 
> > However, its possible to use synchronize_rcu which will provide the same
> > guarantees (see comment this patch modifies on lru_cache_disable).
> > 
> > Fixes:
> > 
> > ...
> >
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -831,8 +831,7 @@ inline void __lru_add_drain_all(bool force_all_cpus)
> >  	for_each_online_cpu(cpu) {
> >  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
> >  
> > -		if (force_all_cpus ||
> > -		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
> > +		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
> 
> Please changelog this alteration?

It should be now. Are you OK with this changelog ?
(if not, please let me know what should be improved).

On systems that run FIFO:1 applications that busy loop,
any SCHED_OTHER task that attempts to execute
on such a CPU (such as work threads) will not
be scheduled, which leads to system hangs.

Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU
pagevec during the migration temporarily") relies on
queueing work items on all online CPUs to ensure visibility
of lru_disable_count.

To fix this, replace the usage of work items with synchronize_rcu,
which provides the same guarantees:

Readers of lru_disable_count are protected by either disabling
preemption or rcu_read_lock:

preempt_disable, local_irq_disable  [bh_lru_lock()]
rcu_read_lock                       [rt_spin_lock CONFIG_PREEMPT_RT]
preempt_disable                     [local_lock !CONFIG_PREEMPT_RT]

Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
preempt_disable() regions of code. So any CPU which sees
lru_disable_count = 0 will have exited the critical
section when synchronize_rcu() returns.

Fixes:
...

Thanks.

