Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F44EDAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiCaNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCaNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:54:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6E216A70
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:52:51 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 877151EC0535;
        Thu, 31 Mar 2022 15:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648734766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f0b47ts2VheeKS+3ncRDbOuaDfRJ+I8108gtQgFa0aM=;
        b=LTUp+g4rs1ac0r9x/TD4H6FmSRcqezk1vUXbkASKLxk9n3Dwb+JcE1jOW3oFj1bpEhuFei
        AtQJ1OhZuF94JpMgzup2A8m+nbK69gAkatr0QlQ1lsvNgVIshFIEbnfwcdMrn+1f1fIJN8
        n+Zf3KtyAVMI5GBQR+Q59kTk5VBX0KI=
Date:   Thu, 31 Mar 2022 15:52:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
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
Message-ID: <YkWyLaom/r7jXgbA@zn.tnic>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yin7hDxdt0s/x+fp@fuller.cnet>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
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
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Acked-by: Minchan Kim <minchan@kernel.org>

Someone pointed me at this:

https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom

which says this one causes a performance regression with stress-ng's
NUMA test...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
