Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DB14D252A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiCIBHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiCIBHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:18 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4508D680
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:47:20 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220308233108euoutp02fd0f4139e91f58cddb1fc74449e17f20~ai7_dp4Ob1098810988euoutp02m
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220308233108euoutp02fd0f4139e91f58cddb1fc74449e17f20~ai7_dp4Ob1098810988euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646782268;
        bh=hxt0oEOL+8dAN9OFyoXMZdSm3MLICWq5jHyztscK0DM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HwZkfCKpIzA7XzlzrUODsyJ1QEEaj8mKPBiWC/k85WOcNOpaHQ7vEiRxmgOKYooG+
         6c8j9ORgaK8nS2eAgM/+1TKBK01T97iYrUG8JNIfZbA72np+ccNvoC0vUeF8hxLbC6
         rsrerm3LJoHCUfbcSGwLjaU/Kk2RQawphgAVDBCc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220308233108eucas1p27b68346e72b7d4262a46bd340c1b4c9e~ai79-mbtU0413704137eucas1p2Y;
        Tue,  8 Mar 2022 23:31:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.CB.09887.C37E7226; Tue,  8
        Mar 2022 23:31:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220308233107eucas1p119a2f5a8d4f5b5eec38ea8dde92b3368~ai79W4JTc3116231162eucas1p1y;
        Tue,  8 Mar 2022 23:31:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220308233107eusmtrp1216e72b3bbea265094bd61812bcfcf0b~ai79VZ9Nv2863028630eusmtrp1H;
        Tue,  8 Mar 2022 23:31:07 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-01-6227e73ceba2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.B0.09404.B37E7226; Tue,  8
        Mar 2022 23:31:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220308233107eusmtip24d885dbe7a8f03df51d78d94562f3082~ai78v56L51842518425eusmtip2E;
        Tue,  8 Mar 2022 23:31:06 +0000 (GMT)
Message-ID: <1be5f15e-a9eb-b6c1-81fa-5b8322ebb229@samsung.com>
Date:   Wed, 9 Mar 2022 00:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 3/3] sched/cpuacct: remove redundant RCU read lock
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220220051426.5274-3-zhouchengming@bytedance.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87o2z9WTDPpuC1lcenyVzWL1Jl+L
        y7vmsFmceH2EzeLSgQVMFsd7DzBZ/Fp+lNGi48g3Zovbk1pZLG42fmF04PL4d2INm8fhN++Z
        Pf4fnMTssXmFlsemVZ1sHneu7WHzeL/vKpvH501yARxRXDYpqTmZZalF+nYJXBm/529jL/is
        WXHyxiKWBsabyl2MnBwSAiYS9z8tZu1i5OIQEljBKHF6zRw2COcLo8SU5ZNYIJzPjBJ//15h
        hmmZc+86E0RiOaPEya6bjBDOR0aJX48esIFU8QrYSWxdNJkFxGYRUJFYun4pE0RcUOLkzCdg
        cVGBJIkHB/rYQWxhAU+Jl78vgcWZBcQlbj2ZD7ZBROARo8SN10eYIRIKEr/ubWIFsdkEDCW6
        3naBLeMUcJD40noYqkZeonnrbGaQZgmBdk6Jubf2Am3gAHJcJK7e5YB4QVji1fEt7BC2jMTp
        yT0sEPXNjBIPz61lh3B6GCUuN81ghKiylrhz7hcbyCBmAU2J9bv0IcKOEo9fL4Kazydx460g
        xA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqWWUjen4Xkm1kIexcwsqxiFE8t
        Lc5NTy02ykst1ytOzC0uzUvXS87P3cQITF+n/x3/soNx+auPeocYmTgYDzFKcDArifDeP6+S
        JMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoEpf03b9R0P
        XPQZ1WQZ5d/drzmxvaa69mKAy0lPq8LdnAzvVrB/DV+xZ1XwVfP0j/P3O6jWa36U3L5MTTW8
        ty/QaMKzGWnO0Rs73kxIYat2Wv5uHvOxnfWmF8+v6ri5Nddz0+9FfqYsfg/ud3wSr3jAsv7s
        1TuRz4N3r34UfWnX2XW60tI7XeaGVJfHrhBQutWl+8NtnpbNhqcxxttZXq34JxuZmav8+NPy
        QJlIs2rn80k3zm++3FzV+03rdfcSpbq1rB2THjvULLwQrmHVWrj+y2+BeW2n8j9Py6zu3Fd1
        peWpyoIbXyssVnQob1ySEXhMtm/d3m7bsjMBO/wEn819tbfU8u30usxKUy0fiZ8zlViKMxIN
        tZiLihMBn54ASc4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7rWz9WTDE4sUba49Pgqm8XqTb4W
        l3fNYbM48foIm8WlAwuYLI73HmCy+LX8KKNFx5FvzBa3J7WyWNxs/MLowOXx78QaNo/Db94z
        e/w/OInZY/MKLY9NqzrZPO5c28Pm8X7fVTaPz5vkAjii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+z9/GXvBZs+LkjUUsDYw3lbsYOTkkBEwk
        5ty7ztTFyMUhJLCUUWLN76uMEAkZiZPTGlghbGGJP9e62CCK3jNKfLl6kwUkwStgJ7F10WQw
        m0VARWLp+qVMEHFBiZMzn4DFRQWSJF5u2wg2SFjAU+Ll70tgcWYBcYlbT+aDbRYReMQocXn7
        UyaIhILEr3ubwBqEBEolbs66AmazCRhKdL0FuYKTg1PAQeJL62FmiHozia6tXYwQtrxE89bZ
        zBMYhWYhuWMWkn2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmC8bjv2c8sO
        xpWvPuodYmTiYDzEKMHBrCTCe/+8SpIQb0piZVVqUX58UWlOavEhRlNgYExklhJNzgcmjLyS
        eEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqZY9mf30p98Dl1bePa8
        9TUrhuPHC0/LWvw+fqYpsPHqCxP2cvsW+8Xv85I7DJ1EQ4unL9za6/7w3qV/OftkZhio7pKU
        rAzqPH9fNz3n1q1TWz0qlplGLHe8JbvNuXB2NNdew7vSNzm4jCY7BH/m3B6ruG2f7lHDMNH7
        a015ikIOh+lJT32wnuP4vQWnb1y2LVjyzN/l2uHEfkaPdW+a5L4EF/ysEll2xVNQ8mv7VpkZ
        Wr7lTz8pOuytY7PJMjjBm/oq/UKwSuaZ9kYh4Z1fH07me+Wtt/nVpxeZEm9L2tf1PG36MV80
        v2KdNTPPkZM8Pvcmzjph5/TR9e2zaVtWH68yux/8evHfuRavbwY+3NCtxFKckWioxVxUnAgA
        Ru+rrmADAAA=
X-CMS-MailID: 20220308233107eucas1p119a2f5a8d4f5b5eec38ea8dde92b3368
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308233107eucas1p119a2f5a8d4f5b5eec38ea8dde92b3368
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308233107eucas1p119a2f5a8d4f5b5eec38ea8dde92b3368
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
        <20220220051426.5274-3-zhouchengming@bytedance.com>
        <CGME20220308233107eucas1p119a2f5a8d4f5b5eec38ea8dde92b3368@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.2022 06:14, Chengming Zhou wrote:
> The cpuacct_account_field() and it's cgroup v2 wrapper
> cgroup_account_cputime_field() is only called from cputime
> in task_group_account_field(), which is already in RCU read-side
> critical section. So remove these redundant RCU read lock.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

This patch landed recently in linux-next as commit 3eba0505d03a 
("sched/cpuacct: Remove redundant RCU read lock"). On my test systems I 
found that it triggers a following warning in the early boot stage:

Calibrating delay loop (skipped), value calculated using timer 
frequency.. 48.00 BogoMIPS (lpj=240000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround
CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
cblist_init_generic: Setting adjustable number of callback queues.

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00052-g167ee9b08bed #11459 Not tainted
-----------------------------
./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
no locks held by swapper/0/1.

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5-00052-g167ee9b08bed 
#11459
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from account_system_index_time+0x13c/0x148
  account_system_index_time from account_system_time+0x78/0xa0
  account_system_time from update_process_times+0x50/0xc4
  update_process_times from tick_handle_periodic+0x1c/0x94
  tick_handle_periodic from exynos4_mct_tick_isr+0x30/0x38
  exynos4_mct_tick_isr from __handle_irq_event_percpu+0x74/0x3ac
  __handle_irq_event_percpu from handle_irq_event_percpu+0xc/0x38
  handle_irq_event_percpu from handle_irq_event+0x38/0x5c
  handle_irq_event from handle_fasteoi_irq+0xc4/0x180
  handle_fasteoi_irq from generic_handle_domain_irq+0x44/0x88
  generic_handle_domain_irq from gic_handle_irq+0x88/0xac
  gic_handle_irq from generic_handle_arch_irq+0x58/0x78
  generic_handle_arch_irq from __irq_svc+0x54/0x88
Exception stack(0xc1cafea0 to 0xc1cafee8)
fea0: 00000000 c0f33ac4 00000001 00000129 60000053 c127b458 00000008 
2e64e000
fec0: ef7bd5fc c127af84 c1209048 c1208f10 00000000 c1cafef0 c0b7e25c 
c0b8976c
fee0: 20000053 ffffffff
  __irq_svc from _raw_spin_unlock_irqrestore+0x2c/0x60
  _raw_spin_unlock_irqrestore from 
cblist_init_generic.constprop.14+0x298/0x328
  cblist_init_generic.constprop.14 from rcu_init_tasks_generic+0x18/0x110
  rcu_init_tasks_generic from kernel_init_freeable+0xa0/0x214
  kernel_init_freeable from kernel_init+0x18/0x12c
  kernel_init from ret_from_fork+0x14/0x2c
Exception stack(0xc1caffb0 to 0xc1cafff8)
ffa0:                                     00000000 00000000 00000000 
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
cblist_init_generic: Setting shift to 1 and lim to 1.
Running RCU-tasks wait API self tests
Setting up static identity map for 0x40100000 - 0x40100060
rcu: Hierarchical SRCU implementation.
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
CPU1: Spectre v2: using BPIALL workaround
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (96.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.

The above log comes from ARM 32bit Samsung Exnyos4210 based Trats board. 
To get above log I reverted commit dc6e0818bc9a ("sched/cpuacct: 
Optimize away RCU read lock"), because it triggered a similar warning.

> ---
>   include/linux/cgroup.h | 2 --
>   kernel/sched/cpuacct.c | 2 --
>   2 files changed, 4 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 9a109c6ac0e0..1e356c222756 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -804,11 +804,9 @@ static inline void cgroup_account_cputime_field(struct task_struct *task,
>   
>   	cpuacct_account_field(task, index, delta_exec);
>   
> -	rcu_read_lock();
>   	cgrp = task_dfl_cgroup(task);
>   	if (cgroup_parent(cgrp))
>   		__cgroup_account_cputime_field(cgrp, index, delta_exec);
> -	rcu_read_unlock();
>   }
>   
>   #else	/* CONFIG_CGROUPS */
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index f79f88456d72..d269ede84e85 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -352,10 +352,8 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
>   {
>   	struct cpuacct *ca;
>   
> -	rcu_read_lock();
>   	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
>   		__this_cpu_add(ca->cpustat->cpustat[index], val);
> -	rcu_read_unlock();
>   }
>   
>   struct cgroup_subsys cpuacct_cgrp_subsys = {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

