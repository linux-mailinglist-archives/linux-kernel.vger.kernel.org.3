Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A84489DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiAJQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237774AbiAJQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641833477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ese1LCrrv5xPb5Kd02lWVSnWlV9BQ8saU8Zzl+09U3Y=;
        b=hCMcyZmsMSl/Iy+CI6iOZJDdl+ByOlMwYPYwAFUxPC4NCyAMZts+1pZF4jWiDeLrG44/wG
        KS4d3yrmN+83HLyDB/S9F3EhHGAUCFIM0Vm4Pkc0wExVhpmh2Ex13Ue6gRbpjRsRlts0EG
        qVASJQSI9phsGTKjM1zOpQQE7Ui9aFk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Z8DG1LKVOJuolHfLjqwKYQ-1; Mon, 10 Jan 2022 11:51:15 -0500
X-MC-Unique: Z8DG1LKVOJuolHfLjqwKYQ-1
Received: by mail-qv1-f70.google.com with SMTP id o14-20020ad45c8e000000b004112b52fc2cso13633025qvh.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ese1LCrrv5xPb5Kd02lWVSnWlV9BQ8saU8Zzl+09U3Y=;
        b=K0qc2hFMmjxTV77Np5MvKqyxPFOSrBDfXV/N90cCAtUJnN4JBS86MijvSLG5YNibLL
         liCXNe6kYbjVaJrvg6qn1unDT5+mLQzdFKLSlr6TFWNKLBV9ILgyEIswGngGpJt1byCz
         n5xkbXNAq2zWYFYIB5f5IUYRToWpzfzV6jc81vgUJ2k2n3z6IsEEzeZK2/dwvYEfbgUj
         uTDNlAh+tvU2pqjspjL8dNbvZl7VxQ7/gEoUSEJc4FeCRPvG6q7Ppy0Mwyecw1b1l7NN
         jhp7N5e7oXGc5eGMizBApILwjOZEcPWAM+DNq+Y2ZUsyyTWf5LLrqmh9edJG5k9DAddZ
         r8Dw==
X-Gm-Message-State: AOAM53386mgXCZXqA1LqkydwdF40QfgyHUgvYLnyNis6ZKutn//oMMww
        MNG+Qyfa0Xuoar/cHBXRqabE5UPmF+hmO3H06PjpVf+r6QpbaN5EXnWN0sYRBmC4iZ7waJsMDsu
        7Y8E/VE0/a/iuzSfVasz+sLOZ
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr233383qvd.57.1641833474826;
        Mon, 10 Jan 2022 08:51:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9b5sJspoWQ8aaricEO7QsD7NKaxXez1ek/4JxA2u8/d/xa0FMj6majK1GM0QQ3tGQmBJOnA==
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr233363qvd.57.1641833474547;
        Mon, 10 Jan 2022 08:51:14 -0800 (PST)
Received: from localhost.localdomain ([151.29.53.151])
        by smtp.gmail.com with ESMTPSA id t18sm4836143qkp.84.2022.01.10.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:51:14 -0800 (PST)
Date:   Mon, 10 Jan 2022 17:51:09 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <Ydxj/RpR+q5RW0KI@localhost.localdomain>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/01/22 15:49, Frederic Weisbecker wrote:
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

Thanks for this!

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

