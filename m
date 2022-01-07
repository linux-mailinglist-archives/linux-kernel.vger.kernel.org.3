Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992E4487965
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347947AbiAGPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347926AbiAGPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641567601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dxL2UWiHy8dK2ML86RN61guOi9HfUG9Ov992Oazdqws=;
        b=hdMqcWymmwOG/yBdN+B13e8oEhrYtxN6Tqm3mh1n3zVzifLT7tvcDdZz3hObULdL1BfdL5
        dcLHL5acnsJiF2/xjatDIw028S4m+6jRKhR1DP7PDdN1FK897LKo82fnlYCsjQaKXNqjyf
        pzEBvyfJdwvTY6ECmDvxBCypRMGWWzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-1Q6K5Gf9NCiHIgkMy7FTkw-1; Fri, 07 Jan 2022 09:59:57 -0500
X-MC-Unique: 1Q6K5Gf9NCiHIgkMy7FTkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED49760C7;
        Fri,  7 Jan 2022 14:59:56 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.18.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A44FA2B5A9;
        Fri,  7 Jan 2022 14:59:41 +0000 (UTC)
Date:   Fri, 7 Jan 2022 09:59:39 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 0/8] sched/isolation: Split housekeeping cpumask
Message-ID: <YdhVW+PbfzIyQKPz@lorien.usersys.redhat.com>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:49:36PM +0100 Frederic Weisbecker wrote:
> Hi,
> 
> To prepare for extending cpusets to control CPU isolation features
> (nohz_full, rcu_nocbs, unbound timers, workqueues, kthreads affinity...),
> we need to split the global housekeeping_mask to one cpumask per isolation
> feature.
> 
> Doing so is quite a chunk already so I'm working on that as a standalone
> patchset. Once that get merged, the next step is to finally provide a
> cpuset interface for one of these isolation features: rcu_nocb could
> be interesting to handle first as nohz_full depends on it.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	isolation/split
> 
> HEAD: 2c07a16ff50d1e722babee28b926d70522e6bd3e
> 
> Thanks,
> 	Frederic
> ---

This is excellent, thanks!

Reviewed-by: Phil Auld <pauld@redhat.com>


> 
> Frederic Weisbecker (8):
>       pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
>       workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
>       net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
>       sched/isolation: Use single feature type while referring to housekeeping cpumask
>       sched/isolation: Consolidate check for housekeeping minimum service
>       sched/isolation: Consolidate error handling
>       sched/isolation: Fix housekeeping_mask memory leak
>       sched/isolation: Split housekeeping cpumask per isolation features
> 
> 
>  arch/x86/kernel/cpu/aperfmperf.c |   6 +-
>  arch/x86/kvm/x86.c               |   2 +-
>  drivers/base/cpu.c               |   2 +-
>  drivers/pci/pci-driver.c         |  21 +++--
>  include/linux/sched/isolation.h  |  43 ++++++-----
>  kernel/cgroup/cpuset.c           |   6 +-
>  kernel/cpu.c                     |   4 +-
>  kernel/irq/cpuhotplug.c          |   4 +-
>  kernel/irq/manage.c              |   4 +-
>  kernel/kthread.c                 |   4 +-
>  kernel/rcu/tasks.h               |   2 +-
>  kernel/rcu/tree_plugin.h         |   2 +-
>  kernel/sched/core.c              |  12 +--
>  kernel/sched/fair.c              |  10 +--
>  kernel/sched/isolation.c         | 162 +++++++++++++++++++++++++--------------
>  kernel/sched/topology.c          |   8 +-
>  kernel/watchdog.c                |   2 +-
>  kernel/workqueue.c               |   4 +-
>  net/core/net-sysfs.c             |   6 +-
>  19 files changed, 180 insertions(+), 124 deletions(-)
> 

-- 

