Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925484D2661
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiCIBs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiCIBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:48:17 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB17007A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:47:19 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220308232036euoutp02d43d1f223822d373a6dbcc97a6acc50e~aiyxYHIN80144801448euoutp02q
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:20:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220308232036euoutp02d43d1f223822d373a6dbcc97a6acc50e~aiyxYHIN80144801448euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646781636;
        bh=vVmFhsaYTxX5f8JcRbmKME++nxTa/28N5Hv45HFF8Gc=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Vpt9INo/7LqtdZyFSMycROin8BvlMD2Tgx/6V3fP2WSUaoCQUdzxoGAeX6uNKoxX7
         c7vM71MpCm8QeMkGPaeKT2djwMEgteibfOlMgGfSu+5JV5JsU1O87CmekKFQRcynmb
         4/OQ6ZytsyfaH+RhzSNPFSVSa74yMuoWFh98P/fA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220308232035eucas1p1bd5688cb1ea79ea3da6381095dad535c~aiywl1T0H0715607156eucas1p1u;
        Tue,  8 Mar 2022 23:20:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.AB.09887.3C4E7226; Tue,  8
        Mar 2022 23:20:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f~aiyv40p3A1207812078eucas1p2E;
        Tue,  8 Mar 2022 23:20:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220308232034eusmtrp26c612f4cbdcee882e83035f44d280abb~aiyv4GO1l1125611256eusmtrp2w;
        Tue,  8 Mar 2022 23:20:34 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-33-6227e4c3b2e9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.8D.09522.2C4E7226; Tue,  8
        Mar 2022 23:20:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220308232034eusmtip137b1a8c476e66cecff3f206a11e0398d~aiyvNnmbz0938109381eusmtip1E;
        Tue,  8 Mar 2022 23:20:33 +0000 (GMT)
Message-ID: <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
Date:   Wed, 9 Mar 2022 00:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220220051426.5274-2-zhouchengming@bytedance.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRT2u3f37m1nNteKDpqYpYj08LxeLcOYHcZMnoMxstWV9MBuK2lQ
        YmM9yk4mVh4xYyti203YPNY+lDFtJCZqkGJMWZWaVGK5rkf/fd93zvl95zvzI3GxmT+SjE1M
        YhSJ8ngJIeSVPex1TrY1j48MOVcCdE3Tc4K+YlxGPzPnEXRlq52gaywXMLrimAWj+/QORB+y
        d+N0vfYgj36Z3oXmC2U/Kq8SMtunNlzmfqDFZaaCiTJj0WFC1vDiDiFru/eckHUafcPJ9cK5
        0Ux87E5GERy2SbjlfvoJfPvnwF3uRgOWhtL8NYgkgZoGOQf2aJCQFFMFCNLVpwmOdCGoatLz
        ONKJoLi6CNMgj98Tr/o7EVfQI+iwXcM50vFrvrsMZ7tEVBjYe9x81oNHjQNdQQonD4FHp5t5
        LB5GRcJby3EBi4dSi+GzzYBYjFPe8Kr5PMa+6UW9Q1DXase5whjoe23ks5igQkHj0hAs9qDm
        w8FLJoLrGQ0ZN878XgioTA94mp4v4NZeBC3VmX8iDIWWitI/ug+4b3NuQGUgaHQWCzhyFMGz
        /acQ1zUHGpx9BBsHpwLgujmYkxdAe5UF4y7pCXWuIdwSnqAty8U5WQSH1GKu2x90Fdf+2T54
        UoNnI4luwF10A/LrBsTR/fe9gHhFyJtRKRNiGOWURCY5SClPUKoSY4KitiUY0a/v9fhHRdct
        pG/pCLIijERWBCQu8RK9qR4XKRZFy1N2M4ptEQpVPKO0olEkT+Itioo1yMVUjDyJiWOY7Yzi
        bxUjPUamYeZZ9pKIOL9ShfdKxvRV6yj55lXqEzfIejF5XtV1/sfKBulV89tJWOTNlPziBV8D
        CkV1Jy1rDm+cszUcT7u9KNBRmPpu3eYbY0LUyUFHdo5YLC2pXrh2x/vhpqWZEYasYav2O3Mt
        1tL23lCod6kfRS33b/fz9J1OvL4cUKufstU02jdXOYEpN4SF1trUvp5f7g2eifa9MRm+89UZ
        OWMVLsfZxoxTLkvO1JbJSSq/tv7arFHSpuRdqRu0/c4s06Aj/M7AGWqTtOfTOW190ZKQeOal
        w71Q8KHcR7U6m/8taS+xYUXE8T3Bdand2ZYlVYLe1tl+edLMcrgV3ePSF9w91o9LeMot8tCJ
        uEIp/wnmFIzGzQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7qHnqgnGZz7pm5x6fFVNovVm3wt
        Lu+aw2Zx4vURNotLBxYwWRzvPcBk8Wv5UUaLjiPfmC1uT2plsbjZ+IXRgcvj34k1bB6H37xn
        9vh/cBKzx+YVWh6bVnWyedy5tofN4/2+q2wenzfJBXBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXsb5zIXPBOp+L/ww1MDYwNal2MnBwSAiYS
        t/58Zuxi5OIQEljKKLGnaxkbREJG4uS0BlYIW1jiz7UuNoii94wSjXOvgxXxCthJHPnxH6iI
        g4NFQEVi1opKiLCgxMmZT1hAbFGBJImX2zaCzREWcJN4d3gDI4jNLCAucevJfCaQmSICjxgl
        Lm9/ygSRUJD4dW8TWIOQQKlE94STYIPYBAwlut52ge3lFHCQaF28mQ2i3kyia2sX1FB5ieat
        s5knMArNQnLHLCT7ZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAaN127Ofm
        HYzzXn3UO8TIxMF4iFGCg1lJhPf+eZUkId6UxMqq1KL8+KLSnNTiQ4ymwLCYyCwlmpwPTBd5
        JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mq7cumrBL/dqeRwcS
        D/Ty9/5h8/6//NqGmu7w8x4Vl+71dvcdlo+Xt9zKcFi8pix8odjMBt+M9bwP5F9+tDs5MdIv
        N/LZ3w912Uc59MOtNzQU78oXn2neXp1ayDJ/lU/s1BW93+ZvcWt57Mz8p1psn833r3NsZfb5
        n7PSqqg1NI5bYfJ58fX/ClFSjYuKNF+WKh5Y19a+My59kt0qywrPVM1LWVXXZifrNGTfudjx
        eMW5S6+nFqqeO7THp+hXW39MnZ1Dior77XmvDzzzShCRqS15MCf2Kq/kyU+LQg7lvHGYrLh7
        Arf3G/+VBU1V02YL/3RjTduU/Grplvnlp/d7Zd15ZL7e4F5L5SHRJWVvlFiKMxINtZiLihMB
        /sH+F18DAAA=
X-CMS-MailID: 20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
        <20220220051426.5274-2-zhouchengming@bytedance.com>
        <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
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
> Since cpuacct_charge() is called from the scheduler update_curr(),
> we must already have rq lock held, then the RCU read lock can
> be optimized away.
>
> And do the same thing in it's wrapper cgroup_account_cputime(),
> but we can't use lockdep_assert_rq_held() there, which defined
> in kernel/sched/sched.h.
>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

This patch landed recently in linux-next as commit dc6e0818bc9a 
("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
found that it triggers a following warning in the early boot stage:

Calibrating delay loop (skipped), value calculated using timer 
frequency.. 48.00 BogoMIPS (lpj=240000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre v2: using BPIALL workaround

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
-----------------------------
./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
2 locks held by kthreadd/2:
  #0: c1d7972c (&p->pi_lock){....}-{2:2}, at: task_rq_lock+0x30/0x118
  #1: ef7b52d0 (&rq->__lock){-...}-{2:2}, at: 
raw_spin_rq_lock_nested+0x24/0x34

stack backtrace:
CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.17.0-rc5-00050-gdc6e0818bc9a 
#11458
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from update_curr+0x1bc/0x35c
  update_curr from dequeue_task_fair+0xb0/0x8e8
  dequeue_task_fair from __do_set_cpus_allowed+0x19c/0x258
  __do_set_cpus_allowed from __set_cpus_allowed_ptr_locked+0x130/0x1d8
  __set_cpus_allowed_ptr_locked from __set_cpus_allowed_ptr+0x48/0x64
  __set_cpus_allowed_ptr from kthreadd+0x44/0x16c
  kthreadd from ret_from_fork+0x14/0x2c
Exception stack(0xc1cb9fb0 to 0xc1cb9ff8)
9fa0:                                     00000000 00000000 00000000 
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
CPU0: thread -1, cpu 0, socket 9, mpidr 80000900
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 1 and lim to 1.
Running RCU-tasks wait API self tests
Setting up static identity map for 0x40100000 - 0x40100060
rcu: Hierarchical SRCU implementation.

=============================
WARNING: suspicious RCU usage
5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
-----------------------------
./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 1, debug_locks = 1
1 lock held by migration/0/13:
  #0: ef7b52d0 (&rq->__lock){-...}-{2:2}, at: 
raw_spin_rq_lock_nested+0x24/0x34

stack backtrace:
CPU: 0 PID: 13 Comm: migration/0 Not tainted 
5.17.0-rc5-00050-gdc6e0818bc9a #11458
Hardware name: Samsung Exynos (Flattened Device Tree)
Stopper: 0x0 <- 0x0
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from put_prev_task_stop+0x16c/0x25c
  put_prev_task_stop from __schedule+0x698/0x964
  __schedule from schedule+0x54/0xe0
  schedule from smpboot_thread_fn+0x218/0x288
  smpboot_thread_fn from kthread+0xf0/0x134
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xc1ccffb0 to 0xc1ccfff8)
ffa0:                                     00000000 00000000 00000000 
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
smp: Bringing up secondary CPUs ...
CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
CPU1: Spectre v2: using BPIALL workaround
smp: Brought up 1 node, 2 CPUs
SMP: Total of 2 processors activated (96.00 BogoMIPS).

The above log comes from ARM 32bit Samsung Exnyos4210 based Trats board.

> ---
>   include/linux/cgroup.h | 2 --
>   kernel/sched/cpuacct.c | 4 +---
>   2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 75c151413fda..9a109c6ac0e0 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
>   
>   	cpuacct_charge(task, delta_exec);
>   
> -	rcu_read_lock();
>   	cgrp = task_dfl_cgroup(task);
>   	if (cgroup_parent(cgrp))
>   		__cgroup_account_cputime(cgrp, delta_exec);
> -	rcu_read_unlock();
>   }
>   
>   static inline void cgroup_account_cputime_field(struct task_struct *task,
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 307800586ac8..f79f88456d72 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>   	unsigned int cpu = task_cpu(tsk);
>   	struct cpuacct *ca;
>   
> -	rcu_read_lock();
> +	lockdep_assert_rq_held(cpu_rq(cpu));
>   
>   	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>   		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
> -
> -	rcu_read_unlock();
>   }
>   
>   /*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

