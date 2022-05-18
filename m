Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27C352C1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbiERSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiERSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F709344F3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652896848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uRSjnnvJryZVWYf6M7LCjtH2BWC65H+7nO7Y0CFrMDg=;
        b=RBCjTQNsSVdM43ZqmneBENDB95UPtS20Xz0WLmflAtWiVCxY1j+418omB6xfnkGCmsd0P+
        /YPPPJUM2E0JbjP3A8VMeEs4XGC30ZQsEdeYwHq94v5rZ78Bp8h0nhv7X1ICca42h8mBEn
        1tb8SmfQKXWfa51urVqkB2p4T6wvRuQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-bbdNzgP6OZ2MpwAnUHp3YA-1; Wed, 18 May 2022 14:00:45 -0400
X-MC-Unique: bbdNzgP6OZ2MpwAnUHp3YA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ABAD185A7BA;
        Wed, 18 May 2022 18:00:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 476E6492C14;
        Wed, 18 May 2022 18:00:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2433D41C3A1F; Wed, 18 May 2022 14:44:44 -0300 (-03)
Date:   Wed, 18 May 2022 14:44:44 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <YoUwjHqPEHASOGkh@fuller.cnet>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220517233507.GA423@qian>
 <YoUsMIlWvczo3J24@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUsMIlWvczo3J24@fuller.cnet>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:26:08PM -0300, Marcelo Tosatti wrote:
> On Tue, May 17, 2022 at 07:35:07PM -0400, Qian Cai wrote:
> > On Thu, May 12, 2022 at 09:50:37AM +0100, Mel Gorman wrote:
> > > Changelog since v2
> > > o More conversions from page->lru to page->[pcp_list|buddy_list]
> > > o Additional test results in changelogs
> > > 
> > > Changelog since v1
> > > o Fix unsafe RT locking scheme
> > > o Use spin_trylock on UP PREEMPT_RT
> > > 
> > > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > > per-cpu lists drain support" -- avoid interference of a high priority
> > > task due to a workqueue item draining per-cpu page lists. While many
> > > workloads can tolerate a brief interruption, it may be cause a real-time
> > > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > > the draining in non-deterministic.
> > > 
> > > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > > The local_lock on its own prevents migration and the IRQ disabling protects
> > > from corruption due to an interrupt arriving while a page allocation is
> > > in progress. The locking is inherently unsafe for remote access unless
> > > the CPU is hot-removed.
> > > 
> > > This series adjusts the locking. A spinlock is added to struct
> > > per_cpu_pages to protect the list contents while local_lock_irq continues
> > > to prevent migration and IRQ reentry. This allows a remote CPU to safely
> > > drain a remote per-cpu list.
> > > 
> > > This series is a partial series. Follow-on work should allow the
> > > local_irq_save to be converted to a local_irq to avoid IRQs being
> > > disabled/enabled in most cases. Consequently, there are some TODO comments
> > > highlighting the places that would change if local_irq was used. However,
> > > there are enough corner cases that it deserves a series on its own
> > > separated by one kernel release and the priority right now is to avoid
> > > interference of high priority tasks.
> > 
> > Reverting the whole series fixed an issue that offlining a memory
> > section blocking for hours on today's linux-next tree.
> > 
> >  __wait_rcu_gp
> >  synchronize_rcu at kernel/rcu/tree.c:3915
> >  lru_cache_disable at mm/swap.c:886
> >  __alloc_contig_migrate_range at mm/page_alloc.c:9078
> >  isolate_single_pageblock at mm/page_isolation.c:405
> >  start_isolate_page_range
> >  offline_pages
> >  memory_subsys_offline
> >  device_offline
> >  online_store
> >  dev_attr_store
> >  sysfs_kf_write
> >  kernfs_fop_write_iter
> >  new_sync_write
> >  vfs_write
> >  ksys_write
> >  __arm64_sys_write
> >  invoke_syscall
> >  el0_svc_common.constprop.0
> >  do_el0_svc
> >  el0_svc
> >  el0t_64_sync_handler
> >  el0t_64_sync
> > 
> > For full disclosure, I have also reverted the commit 0d523026abd4
> > ("mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()"), so the
> > series can be reverted cleanly. But, I can't see how the commit
> > 0d523026abd4 could cause this issue at all.
> 
> Hi Qian,
> 
> The issue is probably due to lack of the following:
> 
> https://lore.kernel.org/linux-mm/YmrWK%2FKoU1zrAxPI@fuller.cnet/
> 
> Can you please give the patch on the URL a try? 
> 
> Thanks!

Oops, sorry don't think the above URL has anything to do with this
problem.


