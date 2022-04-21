Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9950A100
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387308AbiDUNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiDUNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:43:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583962BB18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650548438; x=1682084438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kb/kfLaKYMZAbGLZYV5H19kevDDVjtLh3lr2MybQ66I=;
  b=R6e1IEdkyB1uhJLesTCFWigh6RmbPzBa5IQLeVm+MQCv7KcDXxIKeEiG
   ZlAi2TNKtDLdbFAqqy2ktftNywUT4Fri5wc+gRhZZr2gT+CAh/rfWt69j
   Hr+k/kyR7iwIle7+NYP4wB0xSnHrQbIluNBLMJqQrMe0GHlqNW6GfmwR9
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Apr 2022 06:40:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:40:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Apr 2022 06:40:36 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 06:40:35 -0700
Date:   Thu, 21 Apr 2022 09:40:33 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <zhangyinan2019@email.szu.edu.cn>,
        <yejiajian2018@email.szu.edu.cn>,
        <hanshenghong2019@email.szu.edu.cn>,
        <zhaochongxi2019@email.szu.edu.cn>
Subject: Re: [PATCH] mm/page_owner.c: use get_task_comm() to record task
 command name with the protection of task_lock()
Message-ID: <20220421134033.GA74@qian>
References: <20220420122817.67181-1-caoyixuan2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220420122817.67181-1-caoyixuan2019@email.szu.edu.cn>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 08:28:17PM +0800, Yixuan Cao wrote:
> I noticed that it is advised to access task command name with
> [gs]et_task_comm() in the comment of task_struct->comm,
> which is safer with the protection of task_lock().
> 
> Relative comment in include/linux/sched.h is as follows:
> 
> /*
>  * executable name, excluding path.
>  *
>  * - normally initialized setup_new_exec()
>  * - access it with [gs]et_task_comm()
>  * - lock it with task_lock()
> */
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  mm/page_owner.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 2743062e92c2..bda8fe2660c0 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -171,8 +171,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  		page_owner->pid = current->pid;
>  		page_owner->tgid = current->tgid;
>  		page_owner->ts_nsec = local_clock();
> -		strlcpy(page_owner->comm, current->comm,
> -			sizeof(page_owner->comm));
> +		get_task_comm(page_owner->comm, current);

We can't call that thing here.

 WARNING: inconsistent lock state
 5.18.0-rc3-next-20220421-dirty #22 Not tainted
 --------------------------------
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
 swapper/4/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
 ffff07ff89ad87f8 (&p->alloc_lock){+.?.}-{2:2}, at: __get_task_comm
 {SOFTIRQ-ON-W} state was registered at:
   __lock_acquire
   lock_acquire.part.0
   lock_acquire
   _raw_spin_lock
   __set_task_comm
   kthreadd
   ret_from_fork
 irq event stamp: 50532
 hardirqs last  enabled at (50532):  seqcount_lockdep_reader_access
 hardirqs last disabled at (50531):  seqcount_lockdep_reader_access
 softirqs last  enabled at (50306):  __do_softirq
 softirqs last disabled at (50313):  __irq_exit_rcu

  other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&p->alloc_lock);
   <Interrupt>
     lock(&p->alloc_lock);

                *** DEADLOCK ***

 1 lock held by swapper/4/0:
  #0: ffffce91c3d81da0 (rcu_callback){....}-{0:0}, at: rcu_do_batch

               stack backtrace:
 CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.18.0-rc3-next-20220421-dirty #22
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  print_usage_bug.part.0
  mark_lock_irq
  mark_lock
  mark_usage
  __lock_acquire
  lock_acquire.part.0
  lock_acquire
  _raw_spin_lock
  __get_task_comm
  __get_task_comm at fs/exec.c:1221
  __set_page_owner
  arch___set_bit at include/asm-generic/bitops/non-atomic.h:22
  (inlined by) __set_page_owner_handle at mm/page_owner.c:175
  (inlined by) __set_page_owner at mm/page_owner.c:192
  post_alloc_hook
  get_page_from_freelist
  __alloc_pages
  alloc_pages
  allocate_slab
  new_slab
  ___slab_alloc
  __slab_alloc.constprop.0
  kmem_cache_alloc
  fill_pool
  __debug_object_init
  debug_object_activate
  call_rcu
  put_object
  __delete_object
  kmemleak_free
  slab_free_freelist_hook
  kmem_cache_free
  file_free_rcu
  rcu_do_batch
  rcu_core
  rcu_core_si
  __do_softirq
  __irq_exit_rcu
  irq_exit_rcu
  el1_interrupt
  el1h_64_irq_handler
  el1h_64_irq
  arch_local_irq_enable
  default_idle_call
  cpuidle_idle_call
  do_idle
  cpu_startup_entry
  secondary_start_kernel
  __secondary_switched
