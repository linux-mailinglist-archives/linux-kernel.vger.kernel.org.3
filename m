Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BBA4D1F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349222AbiCHRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiCHRmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:42:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384653B66
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:41:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o23so17056719pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdTk4aYquZTIk9aPhP7DqM2Gxsxd3HuYNcTcih9MUlU=;
        b=iMAOKf3zl4qCHt1XZ0nGKGE65C8mjYz3b1xzdmyGig1ijiRkXw+4jB2MGTAUm4tfnd
         UebN0kQ9pXWaqUsDbrYmAaPJWO1+HvZJkI8QOuxs/8ND/tN1/23iPiiTr0yPnryDF0ZE
         IyaVTR3zBl1juxUvIaoC3IwfcyvgsYVm/8mJSlvDkPPg6cN4MBc4et4NxXb1yGSlvzCj
         hw9WcGUTWkvDQSUqLvOXTrp/ukeJklvFREOvYGC2d9yUOONeIjk+JM0v9zx17FR1dq33
         oH4KG4rQHNlC7O3RsTowLVcorX42fFu6vfaCQRIEYnd8CndREhcUyNfXJ9OTXajpKST6
         GjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fdTk4aYquZTIk9aPhP7DqM2Gxsxd3HuYNcTcih9MUlU=;
        b=WnrhM+wGefsgL0HVhEJqv7s4G6dMXj2mdCZxz+Ja7fyYDCA04+3MiI4mCE8BAITS6z
         A+VzGMWa3zGIX1Fyyra0NJmUbOPLPZZxbIpdNLFKw7fLhVrMB5RhJcFB08EFe+lBG91z
         pRwCQ18++P+lT5dpdkBD/BdAoU1PSBdc91lhRuAoH8KwJGgRrsilDBGeIl63BwMnJVqj
         TE0Ogaolwd0pRO9RHgFAdjWjZSQMbCb5vx0pm02hA0Vf73K7/5MFA1U5ubNTBvVI3umh
         Ac23UiYoYoTObmicl0huXPZQyIp3athkXZVDhchgxN8pX7cgc6BbXcAQSMlzW/ac8swZ
         WQ/Q==
X-Gm-Message-State: AOAM532x68joQ7K8ri0Pkh8ODJIPQhSGaj4W0nsZayQraTqYKI/Pgkl5
        VCr0SbWdzFDUyZlKkZt5NM94mSZSVJU=
X-Google-Smtp-Source: ABdhPJxXnwJGrLzNZwn6eQDyYjwzGGbh7RRKQ6ybShnYyN9Ay7t+rlTEHlZLzMTpuo+6FqqBqVQvPA==
X-Received: by 2002:a63:ef4f:0:b0:375:6898:f6b8 with SMTP id c15-20020a63ef4f000000b003756898f6b8mr15186903pgk.59.1646761272552;
        Tue, 08 Mar 2022 09:41:12 -0800 (PST)
Received: from google.com ([2620:15c:211:201:ec3e:a6ab:7b5b:ed81])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm22161988pfl.148.2022.03.08.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:41:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 8 Mar 2022 09:41:09 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch v4] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <YieVNcmxV/xAdmiz@google.com>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiI+a9gTr/UBCf0X@fuller.cnet>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 01:29:31PM -0300, Marcelo Tosatti wrote:
>  
> On systems that run FIFO:1 applications that busy loop 
> on isolated CPUs, executing tasks on such CPUs under
> lower priority is undesired (since that will either
> hang the system, or cause longer interruption to the
> FIFO task due to execution of lower priority task 
> with very small sched slices).
> 
> Commit d479960e44f27e0e52ba31b21740b703c538027c ("mm: disable LRU 
> pagevec during the migration temporarily") relies on 
> queueing work items on all online CPUs to ensure visibility
> of lru_disable_count.
> 
> However, its possible to use synchronize_rcu which will provide the same
> guarantees (see comment this patch modifies on lru_cache_disable).
> 
> Fixes:
> 
> [ 1873.243925] INFO: task kworker/u160:0:9 blocked for more than 622 seconds.
> [ 1873.243927]       Tainted: G          I      --------- ---  5.14.0-31.rt21.31.el9.x86_64 #1
> [ 1873.243929] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1873.243929] task:kworker/u160:0  state:D stack:    0 pid:    9 ppid:     2 flags:0x00004000
> [ 1873.243932] Workqueue: cpuset_migrate_mm cpuset_migrate_mm_workfn
> [ 1873.243936] Call Trace:
> [ 1873.243938]  __schedule+0x21b/0x5b0
> [ 1873.243941]  schedule+0x43/0xe0
> [ 1873.243943]  schedule_timeout+0x14d/0x190
> [ 1873.243946]  ? resched_curr+0x20/0xe0
> [ 1873.243953]  ? __prepare_to_swait+0x4b/0x70
> [ 1873.243958]  wait_for_completion+0x84/0xe0
> [ 1873.243962]  __flush_work.isra.0+0x146/0x200
> [ 1873.243966]  ? flush_workqueue_prep_pwqs+0x130/0x130
> [ 1873.243971]  __lru_add_drain_all+0x158/0x1f0
> [ 1873.243978]  do_migrate_pages+0x3d/0x2d0
> [ 1873.243985]  ? pick_next_task_fair+0x39/0x3b0
> [ 1873.243989]  ? put_prev_task_fair+0x1e/0x30
> [ 1873.243992]  ? pick_next_task+0xb30/0xbd0
> [ 1873.243995]  ? __tick_nohz_task_switch+0x1e/0x70
> [ 1873.244000]  ? raw_spin_rq_unlock+0x18/0x60
> [ 1873.244002]  ? finish_task_switch.isra.0+0xc1/0x2d0
> [ 1873.244005]  ? __switch_to+0x12f/0x510
> [ 1873.244013]  cpuset_migrate_mm_workfn+0x22/0x40
> [ 1873.244016]  process_one_work+0x1e0/0x410
> [ 1873.244019]  worker_thread+0x50/0x3b0
> [ 1873.244022]  ? process_one_work+0x410/0x410
> [ 1873.244024]  kthread+0x173/0x190
> [ 1873.244027]  ? set_kthread_struct+0x40/0x40
> [ 1873.244031]  ret_from_fork+0x1f/0x30
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Looks like great to me. 

Acked-by: Minchan Kim <minchan@kernel.org>

While I reviewed it, it seems I found a bug that br_lru_install
needs to check lru_cache_disabled under bh_lru_lock. Let me
cook the patch.

Thanks!
