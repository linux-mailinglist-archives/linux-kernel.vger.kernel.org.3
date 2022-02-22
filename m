Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73974BFE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiBVQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiBVQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39603166A7D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645547146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5DKAI2QnurfF8icsk+5oOpAcBPEJ2KBE+uErSVyHNM=;
        b=YLjCoc8VKmhO4I1+ZPIRFcSdQzJFVw3EkyRlzmuV8PYNwOsoRrmbM/B8zpTl97GgaMfSFq
        sA8HqzxW/1OTTT64yDQWrdfK+veJvcba6w8VdhU03m7zhvGAgcUPAAk0yU4+HrDBEriIbo
        PsDfdUDmoqBHzhzqFEfRM5eCscqO1dU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Mtw25E3AMcSIGnnmyh-vPA-1; Tue, 22 Feb 2022 11:25:43 -0500
X-MC-Unique: Mtw25E3AMcSIGnnmyh-vPA-1
Received: by mail-wm1-f69.google.com with SMTP id ay41-20020a05600c1e2900b0037c5168b3c4so1062889wmb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G5DKAI2QnurfF8icsk+5oOpAcBPEJ2KBE+uErSVyHNM=;
        b=BlSTo4aTd62+Je4tRnCD5W8oZcx6puuEUPI7h6gBoyfZgl6mSxpqAwRbyTwwy9J63c
         xfbG5IxBAfrhgpwHh/6W2CIPM9VHltoRYpO/ASHU3yPIGi82SfPE7tJB53MQ6Vk3z6Gu
         BfM1bUTCkaVFod8NvM8foLpqGJiPZjg0nXAlZALFTZf9V8i/Y4wbyoqPGrdKkqzS3WJ6
         al8LQ4rcvRiH0g2l2cud7yQkP2IroIRxUEc/ZOXS/wi0qtqgMls8nrl0DPwQIJjJoL0A
         Spis1MkjEW1ZyoQ0erdu3GFE58GYZrpa9tcL88Axf0jvwOB50P7wLP03os/610jtTHxJ
         Q1DA==
X-Gm-Message-State: AOAM5322x/HCCDd2v36yheJcwMUk+K4NI3O/vkW3RQZQ3xurKlG1vUV8
        lOhxDpezOcb+D0V1J2fvQWI5XmdoOwTOF6p0r+VokSMZbjMDK7GVM6Et8Sw+9sbEESR0+yaQA15
        4MfRMkrFxBB5mtJwirV9ptTnx
X-Received: by 2002:adf:f283:0:b0:1e4:97a6:e00d with SMTP id k3-20020adff283000000b001e497a6e00dmr19689672wro.20.1645547141980;
        Tue, 22 Feb 2022 08:25:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCJ14GitbETXBru01lUUnumIVt0My9/WmDihIaMAqPtCVNCfykLJYibN+MnXmMpqtTkBNh6Q==
X-Received: by 2002:adf:f283:0:b0:1e4:97a6:e00d with SMTP id k3-20020adff283000000b001e497a6e00dmr19689652wro.20.1645547141735;
        Tue, 22 Feb 2022 08:25:41 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id m5sm404480wrb.13.2022.02.22.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:25:41 -0800 (PST)
Message-ID: <2fed0e484f223cc223c13320e62ea3648d2af227.camel@redhat.com>
Subject: Re: [patch v3] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 22 Feb 2022 17:25:40 +0100
In-Reply-To: <YhUKRzEKxMvlGQ5n@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet> <YhUKRzEKxMvlGQ5n@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 13:07 -0300, Marcelo Tosatti wrote:
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

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Regards,

-- 
Nicolás Sáenz

