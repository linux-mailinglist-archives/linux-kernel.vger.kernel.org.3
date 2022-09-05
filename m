Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B55ACB26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiIEGl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiIEGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:41:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB262B633
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:41:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q3so7531003pjg.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0lsWKnNMUYQpswdbSARQqcTNkoBT/Xy2870yz+ZHYx8=;
        b=Qt9ndQU0hR4GMLxatU1jJ4U3z7b/onkxh61IBl4XfAhlfhiRY+S/HKy1M2fK2JgloF
         j0mVdeiiiCA4BTqaUX5bK/7Fkr2/0CgpTcenb48Vh4+Lzh3z7TSniLc+6vgaRhbVa72n
         p983Wy4k4WtOO2kBmqgLaF/+e2Fom/2wUcNPfPPrac/3BxqAeh8O3U99rcKEQAR0N3iQ
         4qnPzSKOUEc9tcSoERL4HZ3s5V3zz65m8Q5Z2qXVTuu/MEtTCU8hDBssxcjryUhbYrHh
         CmEiYERq65l8vcwuqtlOceDP362ydT78e/hqY96fEZdivk3a2IacU6oHgIeG4pXFwbJo
         whGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0lsWKnNMUYQpswdbSARQqcTNkoBT/Xy2870yz+ZHYx8=;
        b=ApbQ2Ha2CINdORAWej+2PuwQX3j1eMb9pWnf6p+oSxjrtZ8eBxJdBQTJ8xmjfXmh+x
         6X9eclgIcPEO656cq9j+0xvrFlhrtaag7iptYR+kvqi8eN5O1JF5B2QZf/29KxcfNPAi
         1cDTNK5dlJ6HynhIWbHUftlywxCL91CAOzRyHXg9EIBujf6BUQcdBdiKuJ4OH24gKwJk
         NcuCsraOCcLOcwMNbRmS4xhJZ1J6MUheB2Iq/EcNjgQkAzRt0w7aZ8NNrOu/zzYzM95C
         KArOvIeLS2NMoa42G9u2QRI5VfIXzVSo//azRziW+7CN0taPMUYZF6FVD9CFYq5tsnc3
         H+ww==
X-Gm-Message-State: ACgBeo0cP+jFFDpSqu2fGDfz/4jKN52Le87uWpSfTljS5oCLF47CmS87
        yN7AC6s4E5giS3P3/VDcaaXqDw==
X-Google-Smtp-Source: AA6agR5cp6csmaWmNSo8hJ6odgH5C8uJk7SuNySbA1DXTFRUwj/e190F/KjgP2ErG7Vtx583ggCEmw==
X-Received: by 2002:a17:90b:4b8b:b0:1fb:2e2c:c88d with SMTP id lr11-20020a17090b4b8b00b001fb2e2cc88dmr17862294pjb.86.1662360112080;
        Sun, 04 Sep 2022 23:41:52 -0700 (PDT)
Received: from [10.255.159.85] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001744018def7sm6510595plg.90.2022.09.04.23.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 23:41:51 -0700 (PDT)
Message-ID: <f16cd8cd-ce91-46a3-7180-855b762b34c0@bytedance.com>
Date:   Mon, 5 Sep 2022 14:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH] kernel/sched: fix KMSAN uninit-value error
Content-Language: en-US
To:     Bernard Zhao <bernard@vivo.com>
Cc:     zhaojunkui2008@126.com, Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220905023715.1920088-1-bernard@vivo.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220905023715.1920088-1-bernard@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/5 10:37, Bernard Zhao wrote:
> This patch try to fix syzbot error:
> =====================================================
> BUG: KMSAN: uninit-value in update_triggers kernel/sched/psi.c:525 [inline]
> BUG: KMSAN: uninit-value in psi_poll_work kernel/sched/psi.c:626 [inline]
> BUG: KMSAN: uninit-value in psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648

Hello,

Did you test with the latest PSI code using linux-next branch that include
the commit 2b97cf76289a ("sched/psi: Zero the memory of struct psi_group")?

Thanks.


>  update_triggers kernel/sched/psi.c:525 [inline]
>  psi_poll_work kernel/sched/psi.c:626 [inline]
>  psi_poll_worker+0x972/0x16a0 kernel/sched/psi.c:648
>  kthread+0x31b/0x430 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
> 
> Uninit was stored to memory at:
>  collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
>  psi_poll_work kernel/sched/psi.c:604 [inline]
>  psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
>  kthread+0x31b/0x430 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
> 
> Uninit was stored to memory at:
>  collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
>  psi_poll_work kernel/sched/psi.c:604 [inline]
>  psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
>  kthread+0x31b/0x430 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
> 
> Uninit was stored to memory at:
>  collect_percpu_times+0x193d/0x19a0 kernel/sched/psi.c:355
>  psi_poll_work kernel/sched/psi.c:604 [inline]
>  psi_poll_worker+0x587/0x16a0 kernel/sched/psi.c:648
>  kthread+0x31b/0x430 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slab.h:732 [inline]
>  slab_alloc_node mm/slub.c:3258 [inline]
>  slab_alloc mm/slub.c:3266 [inline]
>  kmem_cache_alloc_trace+0x696/0xdf0 mm/slub.c:3297
>  kmalloc include/linux/slab.h:600 [inline]
>  psi_cgroup_alloc+0x83/0x250 kernel/sched/psi.c:960
>  cgroup_create kernel/cgroup/cgroup.c:5430 [inline]
>  cgroup_mkdir+0x10a3/0x3080 kernel/cgroup/cgroup.c:5550
>  kernfs_iop_mkdir+0x2ba/0x520 fs/kernfs/dir.c:1185
>  vfs_mkdir+0x62a/0x870 fs/namei.c:4013
>  do_mkdirat+0x466/0x7b0 fs/namei.c:4038
>  __do_sys_mkdirat fs/namei.c:4053 [inline]
>  __se_sys_mkdirat fs/namei.c:4051 [inline]
>  __x64_sys_mkdirat+0xc4/0x120 fs/namei.c:4051
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> syzbot link:
> https://syzkaller.appspot.com/bug?id=d04c5407207d11e46007775517b97764174bc45d
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  kernel/sched/psi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index ecb4b4ff4ce0..46f048121520 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -195,6 +195,9 @@ static void group_init(struct psi_group *group)
>  	init_waitqueue_head(&group->poll_wait);
>  	timer_setup(&group->poll_timer, poll_timer_fn, 0);
>  	rcu_assign_pointer(group->poll_task, NULL);
> +	memset(group->avg_total, 0, sizeof(group->avg_total));
> +	memset(group->total, 0, sizeof(group->total));
> +	memset(group->avg, 0, sizeof(group->avg));
>  }
>  
>  void __init psi_init(void)
