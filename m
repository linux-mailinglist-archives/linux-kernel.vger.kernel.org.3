Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7C53527A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiEZRUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348266AbiEZRT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:19:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668D64E392
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653585598; x=1685121598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I8qvPIhJrelQBmUBJt9wVIVcH5zRa9yRvTKgT+WjOS8=;
  b=sqEmD9cBWq0LIy0RsKosobpIDqUYiGza/oqVGtAjojuFNjU64MimU2D2
   SFM+5yv+SzNfIWp3y9e/k4FHUZYLx+i1srl+zNGXTsi7wSzKJoUAYiWkH
   X1NhqL9JnU0bDyAyTBUQEk6KxtNGOoQNXSpzvEpm/i9und9VXZB0xf2hw
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 10:19:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 10:19:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 10:19:42 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 10:19:41 -0700
Date:   Thu, 26 May 2022 13:19:38 -0400
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
Message-ID: <Yo+2qqHqSdpE5l7m@qian>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220512085043.5234-1-mgorman@techsingularity.net>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
> 
> Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
> 	and when it is storing per-cpu pages.
> 
> Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
> 	this is not necessary but it avoids per_cpu_pages consuming another
> 	cache line.
> 
> Patch 3 is a preparation patch to avoid code duplication.
> 
> Patch 4 is a simple micro-optimisation that improves code flow necessary for
> 	a later patch to avoid code duplication.
> 
> Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
> 	relying on local_lock to prevent migration, stabilise the pcp
> 	lookup and prevent IRQ reentrancy.
> 
> Patch 6 remote drains per-cpu pages directly instead of using a workqueue.

Mel, we saw spontanous "mm_percpu_wq" crash on today's linux-next tree
while running CPU offlining/onlining, and wondering if you have any
thoughts?

 WARNING: CPU: 31 PID: 173 at kernel/kthread.c:524 __kthread_bind_mask
 CPU: 31 PID: 173 Comm: kworker/31:0 Not tainted 5.18.0-next-20220526-dirty #127
 Workqueue:  0x0
  (mm_percpu_wq)

 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __kthread_bind_mask
 lr : __kthread_bind_mask
 sp : ffff800018667c50
 x29: ffff800018667c50
  x28: ffff800018667d20
  x27: ffff083678bc2458
 x26: 1fffe1002f5b17a8
  x25: ffff08017ad8bd40
  x24: 1fffe106cf17848b
 x23: 1ffff000030ccfa0 x22: ffff0801de2d1ac0
  x21: ffff0801de2d1ac0
 x20: ffff07ff80286f08 x19: ffff0801de2d1ac0
  x18: ffffd6056a577d1c
 x17: ffffffffffffffff
  x16: 1fffe0fff158eb18
  x15: 1fffe106cf176138
 x14: 000000000000f1f1
  x13: 00000000f3f3f3f3 x12: ffff7000030ccf3b
 x11: 1ffff000030ccf3a x10: ffff7000030ccf3a x9 : dfff800000000000
 x8 : ffff8000186679d7
  x7 : 0000000000000001
  x6 : ffff7000030ccf3a
 x5 : 1ffff000030ccf39 x4 : 1ffff000030ccf4e x3 : 0000000000000000
 x2 : 0000000000000000
  x1 : ffff07ff8ac74fc0 x0 : 0000000000000000
 Call trace:
  __kthread_bind_mask
  kthread_bind_mask
  create_worker
  worker_thread
  kthread
  ret_from_fork
 irq event stamp: 146
 hardirqs last  enabled at (145):  _raw_spin_unlock_irqrestore
 hardirqs last disabled at (146):  el1_dbg
 softirqs last  enabled at (0):  copy_process
 softirqs last disabled at (0):  0x0

 WARNING: CPU: 31 PID: 173 at kernel/kthread.c:593 kthread_set_per_cpu
 CPU: 31 PID: 173 Comm: kworker/31:0 Tainted: G        W         5.18.0-next-20220526-dirty #127
 Workqueue:  0x0 (mm_percpu_wq)
 pstate: 10400009 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : kthread_set_per_cpu
 lr : worker_attach_to_pool
 sp : ffff800018667be0
 x29: ffff800018667be0 x28: ffff800018667d20 x27: ffff083678bc2458
 x26: 1fffe1002f5b17a8 x25: ffff08017ad8bd40 x24: 1fffe106cf17848b
 x23: 1fffe1003bc5a35d x22: ffff0801de2d1aec x21: 0000000000000007
 x20: ffff4026d8adae00 x19: ffff0801de2d1ac0 x18: ffffd6056a577d1c
 x17: ffffffffffffffff x16: 1fffe0fff158eb18 x15: 1fffe106cf176138
 x14: 000000000000f1f1 x13: 00000000f3f3f3f3 x12: ffff7000030ccf53
 x11: 1ffff000030ccf52 x10: ffff7000030ccf52 x9 : ffffd60563f9a038
 x8 : ffff800018667a97 x7 : 0000000000000001 x6 : ffff7000030ccf52
 x5 : ffff800018667a90 x4 : ffff7000030ccf53 x3 : 1fffe1003bc5a408
 x2 : 0000000000000000 x1 : 000000000000001f x0 : 0000000000208060
 Call trace:
  kthread_set_per_cpu
  worker_attach_to_pool at kernel/workqueue.c:1873
  create_worker
  worker_thread
  kthread
  ret_from_fork
 irq event stamp: 146
 hardirqs last  enabled at (145):  _raw_spin_unlock_irqrestore
 hardirqs last disabled at (146):  el1_dbg
 softirqs last  enabled at (0):  copy_process
 softirqs last disabled at (0):  0x0

 Unable to handle kernel paging request at virtual address dfff800000000003
 KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 [dfff800000000003] address between user and kernel address ranges
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 CPU: 83 PID: 23994 Comm: kworker/31:2 Not tainted 5.18.0-next-20220526-dirty #127
 pstate: 104000c9 (nzcV daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __lock_acquire
 lr : lock_acquire.part.0
 sp : ffff800071777ac0
 x29: ffff800071777ac0 x28: ffffd60563fa6380
  x27: 0000000000000018
 x26: 0000000000000080 x25: 0000000000000018 x24: 0000000000000000
 x23: ffff0801de2d1ac0 x22: ffffd6056a66a7e0
  x21: 0000000000000000
 x20: 0000000000000000 x19: 0000000000000000
  x18: 0000000000000767
 x17: 0000000000000000 x16: 1fffe1003bc5a473
  x15: 1fffe806c88e9338
 x14: 000000000000f1f1
  x13: 00000000f3f3f3f3
  x12: ffff0801de2d1ac8
 x11: 1ffffac0ad4aefa3
  x10: ffffd6056a577d18 x9 : 0000000000000000
 x8 : 0000000000000003
  x7 : ffffd60563fa6380
  x6 : 0000000000000000
 x5 : 0000000000000080
  x4 : 0000000000000001
  x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000003
  x0 : dfff800000000000

 Call trace:
  __lock_acquire at kernel/locking/lockdep.c:4923
  lock_acquire
  _raw_spin_lock_irq
  worker_thread at kernel/workqueue.c:2389
  kthread
  ret_from_fork
 Code: d65f03c0 d343ff61 d2d00000 f2fbffe0 (38e06820)
 ---[ end trace 0000000000000000 ]---
 1424.464630][T23994] Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: 0x56055bdf0000 from 0xffff800008000000
 PHYS_OFFSET: 0x80000000
 CPU features: 0x000,0042e015,19801c82
 Memory Limit: none
