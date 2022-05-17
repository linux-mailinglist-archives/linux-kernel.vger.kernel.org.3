Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A152AEB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiEQXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiEQXgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:36:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A0BC0B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652830551; x=1684366551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUOiDeh7EH02CIozxQKBpiv/aZ59cUoQ05kZcZ9BhXc=;
  b=A/xvRLc4dQFtPrEg5mKY0+drKSYW3SHiy8sn5ojCGkwiYoqshCtxLC/Q
   8aRUSHe9X3R6ZOS68+EWY7+7Lubw+KOJZ3YCdAXroUQrGfJ41utv3BJjz
   9ySeVAF7UeEKDR58a0drBMhOct5WaSig9Aeyvp1h1uoyZUfp9rwtpAnEu
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 17 May 2022 16:35:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:35:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 16:35:08 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 16:35:07 -0700
Date:   Tue, 17 May 2022 19:35:07 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 0/6] Drain remote per-cpu directly v3
Message-ID: <20220517233507.GA423@qian>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:50:37AM +0100, Mel Gorman wrote:
> Changelog since v2
> o More conversions from page->lru to page->[pcp_list|buddy_list]
> o Additional test results in changelogs
> 
> Changelog since v1
> o Fix unsafe RT locking scheme
> o Use spin_trylock on UP PREEMPT_RT
> 
> This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> per-cpu lists drain support" -- avoid interference of a high priority
> task due to a workqueue item draining per-cpu page lists. While many
> workloads can tolerate a brief interruption, it may be cause a real-time
> task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> the draining in non-deterministic.
> 
> Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> The local_lock on its own prevents migration and the IRQ disabling protects
> from corruption due to an interrupt arriving while a page allocation is
> in progress. The locking is inherently unsafe for remote access unless
> the CPU is hot-removed.
> 
> This series adjusts the locking. A spinlock is added to struct
> per_cpu_pages to protect the list contents while local_lock_irq continues
> to prevent migration and IRQ reentry. This allows a remote CPU to safely
> drain a remote per-cpu list.
> 
> This series is a partial series. Follow-on work should allow the
> local_irq_save to be converted to a local_irq to avoid IRQs being
> disabled/enabled in most cases. Consequently, there are some TODO comments
> highlighting the places that would change if local_irq was used. However,
> there are enough corner cases that it deserves a series on its own
> separated by one kernel release and the priority right now is to avoid
> interference of high priority tasks.

Reverting the whole series fixed an issue that offlining a memory
section blocking for hours on today's linux-next tree.

 __wait_rcu_gp
 synchronize_rcu at kernel/rcu/tree.c:3915
 lru_cache_disable at mm/swap.c:886
 __alloc_contig_migrate_range at mm/page_alloc.c:9078
 isolate_single_pageblock at mm/page_isolation.c:405
 start_isolate_page_range
 offline_pages
 memory_subsys_offline
 device_offline
 online_store
 dev_attr_store
 sysfs_kf_write
 kernfs_fop_write_iter
 new_sync_write
 vfs_write
 ksys_write
 __arm64_sys_write
 invoke_syscall
 el0_svc_common.constprop.0
 do_el0_svc
 el0_svc
 el0t_64_sync_handler
 el0t_64_sync

For full disclosure, I have also reverted the commit 0d523026abd4
("mm/page_alloc: fix tracepoint mm_page_alloc_zone_locked()"), so the
series can be reverted cleanly. But, I can't see how the commit
0d523026abd4 could cause this issue at all.
