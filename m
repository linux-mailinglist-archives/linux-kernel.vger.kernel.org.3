Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F903563269
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiGALWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGALWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:22:14 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216F735A3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:22:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220701112211euoutp0171738635c312fb5b94db2e8deecec1e0~9sLVg8V9c1211712117euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:22:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220701112211euoutp0171738635c312fb5b94db2e8deecec1e0~9sLVg8V9c1211712117euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656674531;
        bh=VJDIuRJSLGNpJBHiKMnBNWJCMQpS8+tz8T3OxoNJlC0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=OtW50Zv6xJpj2ZieRuVlRrJMCvwgiGgTM9cloJpks45Z/kcjvA//04l9j9KQMpFk0
         lYT9C2+bR/JPyT/XZBGfSTzYwPmliamDzHaI1Abg32W6zNBf1/wdBXay/vMV/G0YDt
         7Xn8yR2HyxhAyL4apCtmDrUkHQn7TGLVLoyNWDBs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220701112210eucas1p271764c1d40f9bfbd3befc7d6e7b49662~9sLVA_FEf1381613816eucas1p2a;
        Fri,  1 Jul 2022 11:22:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9D.E7.09664.2E8DEB26; Fri,  1
        Jul 2022 12:22:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220701112210eucas1p2d2db45881086f41b73527f7536537aa5~9sLUlnEht0549805498eucas1p25;
        Fri,  1 Jul 2022 11:22:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220701112209eusmtrp12b399df5deff79924fe03264ed388bd4~9sLUk1o1S2094920949eusmtrp1u;
        Fri,  1 Jul 2022 11:22:09 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-7b-62bed8e2b747
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.C4.09095.1E8DEB26; Fri,  1
        Jul 2022 12:22:09 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220701112209eusmtip2a645a32d9bfb3875c2244cba8ae2721f~9sLUK9wP-0970809708eusmtip2V;
        Fri,  1 Jul 2022 11:22:09 +0000 (GMT)
Message-ID: <270b640d-d5e8-b775-9a16-5d5d07f959ff@samsung.com>
Date:   Fri, 1 Jul 2022 13:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/4] kernfs: Change kernfs_notify_list to llist.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, tj@kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220615021059.862643-3-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qPbuxLMni6QsSiefF6Novvk56y
        WlzeNYfN4tfyo4wW5/8eZ3Vg9di0qpPNY//cNeweH5/eYvH4vEnOY9OTt0wBrFFcNimpOZll
        qUX6dglcGRtffGEtuOBeseTMabYGxr/WXYycHBICJhKTd9xl6WLk4hASWMEo8aLrASuE84VR
        4tr3D4wQzmdGieaNZ5hhWq78WgmVWM4o8fPMdijnI6PE/813GEGqeAXsJF4d/gdkc3CwCKhI
        3LnABhEWlDg58wkLiC0qkCxx7uxVsLiwgLvE0uk3wOLMAuISt57MZwKxRQTyJCbNfQ4VV5D4
        dW8TK4jNJmAo0fW2C6yXE2jVo2PbmSFq5CWat85mBrlHQuAMh8TN90cYIa52kfj5dBcLhC0s
        8er4FnYIW0bi9OQeFpA7JQTyJf7OMIYIV0hce70G6mFriTvnfrGBlDALaEqs36UPEXaUuPTs
        MCNEJ5/EjbeCEBfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4nQcvXGKewKg0CylMZiH5fRaSX2Yh
        7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMNWc/nf80w7Gua8+6h1iZOJgPMQo
        wcGsJMLLNm9vkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5O
        qQYmjZ1blnz97XlE2br2e0D46cd796lHd2oGytVt+Gi+1GFl8oMtjb83GJ137dscPVlrkrd8
        0LejExyvM89a8+v67u6gV3GvjZ0D/y0u2pthFiDk+r1r54Npej87PteyVZU2O7yec+fn3bwD
        5o2cvxjMvt++5Fe5J4SXK6vzUMhc/7RWhubbS3XmduapH5vZdvnBTzuZ0hm7Nhmk7tFb9jLw
        9Dklriyne6l6Kab799XoW7I3qed9mjDrGTNThfxX+d0Rmu2cizM+3/R00IkX0tIo1HeP+mTt
        eWb1Sd0tl6vUjjzVNzO0Yb1527D45IsTAXET0zan8/6Jjqq2SvCI5njVt+WRWe8zG8fDQr0S
        XycqsRRnJBpqMRcVJwIA4Xb+8qQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7oPb+xLMli4xNKiefF6Novvk56y
        WlzeNYfN4tfyo4wW5/8eZ3Vg9di0qpPNY//cNeweH5/eYvH4vEnOY9OTt0wBrFF6NkX5pSWp
        Chn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GRtffGEtuOBeseTM
        abYGxr/WXYycHBICJhJXfq1k7GLk4hASWMoo0bD+JDNEQkbi5LQGVghbWOLPtS42iKL3jBJ3
        5m5gBEnwCthJvDr8D8jm4GARUJG4c4ENIiwocXLmExYQW1QgWaJ5yyEmEFtYwF1i6fQbYHFm
        AXGJW0/mM4G0igjkSbxbFwYRVpD4dW8T2FohgUKJiX9PsIPYbAKGEl1vu8DGcwJtfXRsOzNE
        vZlE19YuRghbXqJ562zmCYxCs5BcMQvJtllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9d
        Lzk/dxMjMLq2Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuFlm7c3SYg3JbGyKrUoP76oNCe1+BCj
        KTAkJjJLiSbnA+M7ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
        Sel40I6VPlLTJ7VpeDGU77gSHhj1ZeXUtqK2O48LDksflmDWZ8w9MNUsR9nVU6tBS/SAV/zZ
        ZdxPu05qrC41sjpZrt/7uG7xB4/7BxPW1i9SdXW12pVyusDc25ejwUr467eLng8ZP4kxmfGX
        zA4MVE2Yea7gYu+dM85yC91EFmsFSLLdeRfFsp+n7Nn1W9MYsibf5vu48dubbfyhx+4c37h9
        9v/NTyI2nD+1/EDlk3n8FkfYn4Wbi3dWr6zZx7Y/aOm9glfXqhmfMMp8zXVuLTD+Mk/OOb3J
        /7RE46TZ0pN25P8Ru+th31X4sGHXjtm1R1zDs34sZW83Cz63OqZvTtSbpftf5woXOkw+8K5z
        oRJLcUaioRZzUXEiAIBr+A03AwAA
X-CMS-MailID: 20220701112210eucas1p2d2db45881086f41b73527f7536537aa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220701112210eucas1p2d2db45881086f41b73527f7536537aa5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220701112210eucas1p2d2db45881086f41b73527f7536537aa5
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
        <20220615021059.862643-3-imran.f.khan@oracle.com>
        <CGME20220701112210eucas1p2d2db45881086f41b73527f7536537aa5@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 15.06.2022 04:10, Imran Khan wrote:
> At present kernfs_notify_list is implemented as a singly linked
> list of kernfs_node(s), where last element points to itself and
> value of ->attr.next tells if node is present on the list or not.
> Both addition and deletion to list happen under kernfs_notify_lock.
>
> Change kernfs_notify_list to llist so that addition to list can heppen
> locklessly.
>
> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Acked-by: Tejun Heo <tj@kernel.org>

This patch landed in linux next-20220630 as commit b8f35fa1188b 
("kernfs: Change kernfs_notify_list to llist."). Unfortunately, it 
causes serious regression on my test systems. It can be easily noticed 
in the logs by the following warning:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 34 at fs/kernfs/dir.c:531 kernfs_put.part.0+0x1a4/0x1d8
kernfs_put: console/active: released with incorrect active_ref 0
Modules linked in:
CPU: 1 PID: 34 Comm: kworker/1:4 Not tainted 
5.19.0-rc4-05465-g5732b42edfd1 #12317
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events kernfs_notify_workfn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from __warn+0xc8/0x13c
  __warn from warn_slowpath_fmt+0x90/0xb4
  warn_slowpath_fmt from kernfs_put.part.0+0x1a4/0x1d8
  kernfs_put.part.0 from kernfs_notify_workfn+0x1a0/0x1d0
  kernfs_notify_workfn from process_one_work+0x1ec/0x4cc
  process_one_work from worker_thread+0x58/0x54c
  worker_thread from kthread+0xd0/0xec
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf099dfb0 to 0xf099dff8)
...
---[ end trace 0000000000000000 ]---

then, after some standard kernel messages, booting stops with the 
following log:

rcu: INFO: rcu_sched self-detected stall on CPU
rcu:     1-...!: (2099 ticks this GP) idle=403c/1/0x40000002 
softirq=33/33 fqs=1
  (t=2100 jiffies g=-1135 q=4 ncpus=2)
rcu: rcu_sched kthread starved for 2098 jiffies! g-1135 f0x0 
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now 
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_sched       state:R  running task     stack:    0 pid: 10 
ppid:     2 flags:0x00000000
  __schedule from schedule+0x48/0xb0
  schedule from schedule_timeout+0x84/0x138
  schedule_timeout from rcu_gp_fqs_loop+0x124/0x478
  rcu_gp_fqs_loop from rcu_gp_kthread+0x150/0x1c8
  rcu_gp_kthread from kthread+0xd0/0xec
  kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf088dfb0 to 0xf088dff8)
...
rcu: Stack dump where RCU GP kthread last ran:
NMI backtrace for cpu 1
CPU: 1 PID: 34 Comm: kworker/1:4 Tainted: G        W 
5.19.0-rc4-05465-g5732b42edfd1 #12317
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events kernfs_notify_workfn
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from nmi_cpu_backtrace+0xd0/0x104
  nmi_cpu_backtrace from nmi_trigger_cpumask_backtrace+0xd8/0x120
  nmi_trigger_cpumask_backtrace from 
rcu_check_gp_kthread_starvation+0x138/0x154
  rcu_check_gp_kthread_starvation from rcu_sched_clock_irq+0x664/0x9f4
  rcu_sched_clock_irq from update_process_times+0x6c/0x94
  update_process_times from tick_sched_timer+0x60/0xe8
  tick_sched_timer from __hrtimer_run_queues+0x1b4/0x328
  __hrtimer_run_queues from hrtimer_interrupt+0x124/0x2b0
  hrtimer_interrupt from exynos4_mct_tick_isr+0x44/0x7c
  exynos4_mct_tick_isr from __handle_irq_event_percpu+0x7c/0x1cc
  __handle_irq_event_percpu from handle_irq_event+0x44/0x8c
  handle_irq_event from handle_fasteoi_irq+0x98/0x18c
  handle_fasteoi_irq from generic_handle_domain_irq+0x24/0x34
  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
  generic_handle_arch_irq from call_with_stack+0x18/0x20
  call_with_stack from __irq_svc+0x98/0xb0
Exception stack(0xf099de78 to 0xf099dec0)
...
  __irq_svc from up_write+0x4/0x3c
  up_write from 0xef7cbb00


It was not easy to find this, because bisecting points to commit 
5732b42edfd1 ("Merge branch 'driver-core-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git"). 
This means that there are some non-trivial dependencies between both 
merged branches. I've rebased 5732b42edfd1^2 onto 5732b42edfd1^1 and 
then I've did the bisecting of the rebased commits. Finally I've found 
this one. Then I've confirmed that reverting it on top of 5732b42edfd1 
and then next-20220630 really fixes the issue.

Let me know how I can help fixing this issue. I've observed this issue 
on ARM 32bit kernel compiled from multi_v7_defconfig and following 
boards: Raspberry Pi 3b and 4b as well as Samsung Exynos based Odroid U3 
and XU4. This issue doesn't happen on QEMU's ARM32bit 'virt' machine.


> ---
>   fs/kernfs/file.c       | 47 ++++++++++++++++++------------------------
>   include/linux/kernfs.h |  2 +-
>   2 files changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 706aebcfb8f69..dce654ad2cea9 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -38,18 +38,16 @@ struct kernfs_open_node {
>   	struct list_head	files; /* goes through kernfs_open_file.list */
>   };
>   
> -/*
> - * kernfs_notify() may be called from any context and bounces notifications
> - * through a work item.  To minimize space overhead in kernfs_node, the
> - * pending queue is implemented as a singly linked list of kernfs_nodes.
> - * The list is terminated with the self pointer so that whether a
> - * kernfs_node is on the list or not can be determined by testing the next
> - * pointer for NULL.
> +/**
> + * attribute_to_node - get kernfs_node object corresponding to a kernfs attribute
> + * @ptr:	&struct kernfs_elem_attr
> + * @type:	struct kernfs_node
> + * @member:	name of member (i.e attr)
>    */
> -#define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
> +#define attribute_to_node(ptr, type, member)	\
> +	container_of(ptr, type, member)
>   
> -static DEFINE_SPINLOCK(kernfs_notify_lock);
> -static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
> +static LLIST_HEAD(kernfs_notify_list);
>   
>   /**
>    * kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
> @@ -903,18 +901,16 @@ static void kernfs_notify_workfn(struct work_struct *work)
>   	struct kernfs_node *kn;
>   	struct kernfs_super_info *info;
>   	struct kernfs_root *root;
> +	struct llist_node *free;
> +	struct kernfs_elem_attr *attr;
>   repeat:
>   	/* pop one off the notify_list */
> -	spin_lock_irq(&kernfs_notify_lock);
> -	kn = kernfs_notify_list;
> -	if (kn == KERNFS_NOTIFY_EOL) {
> -		spin_unlock_irq(&kernfs_notify_lock);
> +	free = llist_del_first(&kernfs_notify_list);
> +	if (free == NULL)
>   		return;
> -	}
> -	kernfs_notify_list = kn->attr.notify_next;
> -	kn->attr.notify_next = NULL;
> -	spin_unlock_irq(&kernfs_notify_lock);
>   
> +	attr = llist_entry(free, struct kernfs_elem_attr, notify_next);
> +	kn = attribute_to_node(attr, struct kernfs_node, attr);
>   	root = kernfs_root(kn);
>   	/* kick fsnotify */
>   	down_write(&root->kernfs_rwsem);
> @@ -970,12 +966,14 @@ static void kernfs_notify_workfn(struct work_struct *work)
>   void kernfs_notify(struct kernfs_node *kn)
>   {
>   	static DECLARE_WORK(kernfs_notify_work, kernfs_notify_workfn);
> -	unsigned long flags;
>   	struct kernfs_open_node *on;
>   
>   	if (WARN_ON(kernfs_type(kn) != KERNFS_FILE))
>   		return;
>   
> +	/* Because we are using llist for kernfs_notify_list */
> +	WARN_ON_ONCE(in_nmi());
> +
>   	/* kick poll immediately */
>   	rcu_read_lock();
>   	on = rcu_dereference(kn->attr.open);
> @@ -986,14 +984,9 @@ void kernfs_notify(struct kernfs_node *kn)
>   	rcu_read_unlock();
>   
>   	/* schedule work to kick fsnotify */
> -	spin_lock_irqsave(&kernfs_notify_lock, flags);
> -	if (!kn->attr.notify_next) {
> -		kernfs_get(kn);
> -		kn->attr.notify_next = kernfs_notify_list;
> -		kernfs_notify_list = kn;
> -		schedule_work(&kernfs_notify_work);
> -	}
> -	spin_unlock_irqrestore(&kernfs_notify_lock, flags);
> +	kernfs_get(kn);
> +	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> +	schedule_work(&kernfs_notify_work);
>   }
>   EXPORT_SYMBOL_GPL(kernfs_notify);
>   
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 13f54f078a52a..2dd9c8df0f4f6 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -116,7 +116,7 @@ struct kernfs_elem_attr {
>   	const struct kernfs_ops	*ops;
>   	struct kernfs_open_node __rcu	*open;
>   	loff_t			size;
> -	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
> +	struct llist_node	notify_next;	/* for kernfs_notify() */
>   };
>   
>   /*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

