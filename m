Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE5513B27
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350691AbiD1SEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiD1SDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B95F6D4E6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651168834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucwNfXo7EC2ylMgnQC7a+XOsq8PpBGOXOmGWl4N0p00=;
        b=Ub8y+cF/Ob2mvSHWzJ+NB6xna0mKAsE7KPdxh6Tcl7Qaw1PKDt7joAFakF1qScUlW4wE/O
        b2Tohq4Ly6/rycJkRDpGCgH7xLPzkNyxJgwEJP8EqNE54Cmz69qbf90OuvkT84pX9iXjWt
        Bg3aBj4UJdEs6dzsoJgcjrzUr1smmTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-qnTGZa2qOT6-Ig4cwWNmKQ-1; Thu, 28 Apr 2022 14:00:31 -0400
X-MC-Unique: qnTGZa2qOT6-Ig4cwWNmKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C0AC1014A63;
        Thu, 28 Apr 2022 18:00:30 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEA08401474;
        Thu, 28 Apr 2022 18:00:29 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D51B7416F5C3; Thu, 28 Apr 2022 15:00:11 -0300 (-03)
Date:   Thu, 28 Apr 2022 15:00:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, michael@michaellarabel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <YmrWK/KoU1zrAxPI@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet>
 <YkWyLaom/r7jXgbA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkWyLaom/r7jXgbA@zn.tnic>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:52:45PM +0200, Borislav Petkov wrote:
> On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
> > 
> > On systems that run FIFO:1 applications that busy loop,
> > any SCHED_OTHER task that attempts to execute
> > on such a CPU (such as work threads) will not
> > be scheduled, which leads to system hangs.
> > 
> > Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU
> > pagevec during the migration temporarily") relies on
> > queueing work items on all online CPUs to ensure visibility
> > of lru_disable_count.
> > 
> > To fix this, replace the usage of work items with synchronize_rcu,
> > which provides the same guarantees.
> > 
> > Readers of lru_disable_count are protected by either disabling
> > preemption or rcu_read_lock:
> > 
> > preempt_disable, local_irq_disable  [bh_lru_lock()]
> > rcu_read_lock                       [rt_spin_lock CONFIG_PREEMPT_RT]
> > preempt_disable                     [local_lock !CONFIG_PREEMPT_RT]
> > 
> > Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
> > preempt_disable() regions of code. So any CPU which sees
> > lru_disable_count = 0 will have exited the critical
> > section when synchronize_rcu() returns.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Someone pointed me at this:
> 
> https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom
> 
> which says this one causes a performance regression with stress-ng's
> NUMA test...

Michael,

This is probably do_migrate_pages that is taking too long due to
synchronize_rcu().

Switching to synchronize_rcu_expedited() should probably fix it...
Can you give it a try, please?

diff --git a/mm/swap.c b/mm/swap.c
index bceff0cb559c..04a8bbf9817a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -879,7 +879,7 @@ void lru_cache_disable(void)
 	 * lru_disable_count = 0 will have exited the critical
 	 * section when synchronize_rcu() returns.
 	 */
-	synchronize_rcu();
+	synchronize_rcu_expedited();
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else



