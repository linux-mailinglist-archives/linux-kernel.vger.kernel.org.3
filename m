Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6F34D5817
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbiCKCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiCKCYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:24:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2032F1066D2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE289B829BB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8ADC340EB;
        Fri, 11 Mar 2022 02:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646965407;
        bh=EZzrBJ4hQDIygZtNGzoC1Q6zoHDCYzlMFZolsDUGoBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BpsWv5p4wyLA24xXf09Mn3kdws6vC92Grfbi28n+jFypV7W9p/VoGTOjmpsTqG9YK
         DWu473+2nsyjRjNKRB4bNvGBqx4QXjWpyZ6uqS8xAtkT8pEmcxsl9h/pzd+mi+/Bey
         G8sNA4Y2ZD2BAK5gaEGIgjpnKq8PV2pwIQUqkyfE=
Date:   Thu, 10 Mar 2022 18:23:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-Id: <20220310182326.5b375da6b86e95f7e71acd90@linux-foundation.org>
In-Reply-To: <Yin7hDxdt0s/x+fp@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
        <YhUKRzEKxMvlGQ5n@fuller.cnet>
        <YiI+a9gTr/UBCf0X@fuller.cnet>
        <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
        <Yin7hDxdt0s/x+fp@fuller.cnet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 10:22:12 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:

> 
> On systems that run FIFO:1 applications that busy loop,
> any SCHED_OTHER task that attempts to execute
> on such a CPU (such as work threads) will not
> be scheduled, which leads to system hangs.
> 
> Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU
> pagevec during the migration temporarily") relies on
> queueing work items on all online CPUs to ensure visibility
> of lru_disable_count.
> 
> To fix this, replace the usage of work items with synchronize_rcu,
> which provides the same guarantees.
> 
> Readers of lru_disable_count are protected by either disabling
> preemption or rcu_read_lock:
> 
> preempt_disable, local_irq_disable  [bh_lru_lock()]
> rcu_read_lock                       [rt_spin_lock CONFIG_PREEMPT_RT]
> preempt_disable                     [local_lock !CONFIG_PREEMPT_RT]
> 
> Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
> preempt_disable() regions of code. So any CPU which sees
> lru_disable_count = 0 will have exited the critical
> section when synchronize_rcu() returns.

Permitting a realtime thread to hang the entire system warrants a
-stable backport, I think.  That's just rude.

I'm inclined to send this upstream for 5.18-rc1, with that -stable tag.

But if agreeable, how far can we backport this?  Paul, do we know which
kernel version(s) have the desired synchronize_rcu() behaviour?

Now, we don't want -stable people backporting this into kernels where
synchronize_rcu() doesn't do what we want it to do.  So a sneaky thing
we could do is to identify the change which added the desired
synchronize_rcu() behaviour and make this patch Fixes:thatpatch.  That
should prevent people from backporting it too far.

