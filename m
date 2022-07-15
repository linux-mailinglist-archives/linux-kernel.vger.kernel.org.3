Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18C575CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiGOHr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGOHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BE8776E87
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657871229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvUIvaAb68ta9xs2cebppc30SHEKCMbivCeyU2f0Fdg=;
        b=dvn7LXu6asx0WX8CLmmKyB5HeT00uKwmqs07vyiTI7ESIAbRqQkJdLL8ENlr9ZlWq/POlM
        AU1D9ptMPUJFvBI4ADX4SGtGoDCX8VCV4HbojMzklnfuS4qRQiyRSwvi9PmNOAKw0dEgod
        ds9tje8t3mZ4uIE0340teT777cVGdCc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-AN8iSn74NoeIuKLMr_L-eQ-1; Fri, 15 Jul 2022 03:47:08 -0400
X-MC-Unique: AN8iSn74NoeIuKLMr_L-eQ-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so1558393wmp.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RvUIvaAb68ta9xs2cebppc30SHEKCMbivCeyU2f0Fdg=;
        b=d+EZL/7eZsjc9bAu6r0ul4WxHaU6Am5rez4Zt31d9g1XPzyJ/1ZMXcVOs9T4Zsk0ez
         xJaMoBGoz83ufKioFvUEJb7G7TFcgvxI9h/91HovJlJL/UfxnjLl+5DKO0SSYXiJFvPM
         cVGjqwHt6nIB9j3bX4B23mS8kAUSNw1EzzFKp522fHjLLZ1Sv4qyEzmBjACeL8U1QcQo
         ITRsxdbJqPsEqoB9EUe0xid9zhnOuYHTSNmTveP+i94ki9u+DjLWRzAO4ia/bYPIWwUN
         QJ+1EHW/ixREkxzi9SF7kGcIODeocBsoQrX9g9lciOxfDZKn2X9L+BCfBA+LD6cJjiKe
         EB6Q==
X-Gm-Message-State: AJIora83zgh5PoTX+Kv+FbTB7B7vOvhpJExjyUvah9BVzyCAbA87xAa9
        vs2ZLi7OMexTmMGngXVMwRnsips8v3ocnUJ/MBwce2ZSf9o3pLsaMU25XoD7lYAzDCBqsxpnQ6O
        P6QY9rYMnLoYQplF93IloYOx9
X-Received: by 2002:a05:600c:ce:b0:3a2:e02b:bd8e with SMTP id u14-20020a05600c00ce00b003a2e02bbd8emr18753997wmm.123.1657871226935;
        Fri, 15 Jul 2022 00:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWi6WDtLC4iRG0UKo6+d6zAXgsOzpYyYaohC57Jn2ZI7lsJknnQyPLMW5GQFvH5BH6xzUhMw==
X-Received: by 2002:a05:600c:ce:b0:3a2:e02b:bd8e with SMTP id u14-20020a05600c00ce00b003a2e02bbd8emr18753964wmm.123.1657871226663;
        Fri, 15 Jul 2022 00:47:06 -0700 (PDT)
Received: from localhost.localdomain ([151.29.55.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d4ecf000000b0021b9416fa13sm3758184wrv.90.2022.07.15.00.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:47:05 -0700 (PDT)
Date:   Fri, 15 Jul 2022 09:47:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sharan Turlapati <sturlapati@vmware.com>,
        Him Kalyan Bordoloi <bordoloih@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Srivatsa Bhat <srivatsab@vmware.com>
Subject: Re: [PATCH] sched/deadline: Fix BUG_ON condition for deboosted tasks
Message-ID: <YtEbd2WjIOB6nXvr@localhost.localdomain>
References: <20220713075014.411739-1-juri.lelli@redhat.com>
 <806a86d3-5204-145e-af46-023bf0142aa8@csail.mit.edu>
 <Ys/FiJ3tgc0CYDcu@localhost.localdomain>
 <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5F4086A-AD87-4CCB-B926-25713BBF00ED@vmware.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/07/22 04:49, Ankit Jain wrote:

[...]

> Hi Juri,
> 
> I tried the patch but it still hit the BUG_ON.
> 
> [  163.094094] ------------[ cut here ]------------
> [  163.094095] kernel BUG at kernel/sched/deadline.c:1525!
> [  163.094103] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  163.094105] CPU: 0 PID: 5494 Comm: stalld/34 Not tainted 4.19.247-rt108-10.ph3-rt #1-photon
> [  163.094107] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/03/2018
> [  163.094113] RIP: 0010:enqueue_task_dl+0x35d/0x9d0
> [  163.094115] Code: 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 8b 56 74 85 d2 0f 88 91 fd ff ff 80 a6 0c 03 00 00 fe 41 83 e5 20 0f 85
> [  163.094116] RSP: 0018:ffff9b9286537e40 EFLAGS: 00010046
> [  163.094118] RAX: ffffffff840bded0 RBX: ffff8dda07c48000 RCX: 0000000000002000
> [  163.094119] RDX: 0000000000000078 RSI: ffff8dda07c48000 RDI: ffff8dddb79a87c0
> [  163.094120] RBP: ffff9b9286537e78 R08: 0000000000000000 R09: 000000000000007f
> [  163.094121] R10: ffff9b9286537e68 R11: 0000000000000000 R12: ffff9b9286537ef0
> [  163.094121] R13: 0000000000000000 R14: ffff8dddb79a87c0 R15: ffff8dda07c482b8
> [  163.094123] FS:  00007f81a27e4700(0000) GS:ffff8ddbb7600000(0000) knlGS:0000000000000000
> [  163.094124] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  163.094125] CR2: 00007f85e6cfc4c0 CR3: 0000000233744004 CR4: 00000000007606b0
> [  163.094176] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  163.094177] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  163.094177] PKRU: 55555554
> [  163.094178] Call Trace:
> [  163.094183]  ? dequeue_task_dl+0x38/0x1d0
> [  163.094188]  __sched_setscheduler+0x2e2/0x8e0
> [  163.094191]  __x64_sys_sched_setattr+0x74/0xb0
> [  163.094194]  do_syscall_64+0x60/0x1b0
> [  163.094200]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  163.094201] RIP: 0033:0x7f81b6ffe319
> [  163.094202] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c
> [  163.094203] RSP: 002b:00007f81a27e3e28 EFLAGS: 00000206 ORIG_RAX: 000000000000013a
> [  163.094205] RAX: ffffffffffffffda RBX: 000000000000150a RCX: 00007f81b6ffe319
> [  163.094205] RDX: 0000000000000000 RSI: 00007f81a27e3e50 RDI: 000000000000150a
> [  163.094206] RBP: 000000000000150a R08: 0000000000000000 R09: 0000000000000030
> [  163.094207] R10: 00007f80f0002090 R11: 0000000000000206 R12: 0000556306de7a20
> [  163.094208] R13: 0000000000000002 R14: 0000556306ba3570 R15: 00007f81a27e4700
> [  163.094210] Modules linked in: ipt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter bridge stp
> [  163.099512] ---[ end trace 0000000000000002 ]--- 
> 
> 
> In enqueue_task_dl():
> 
> } else if (!dl_prio(p->normal_prio)) {
>   …
>   BUG_ON(!(flags & ENQUEUE_REPLENISH));
>   return;
> }
> 
> I observe flags value as (ENQUEUE_RESTORE |  ENQUEUE_NOCLOCK)

Thanks for testing!

However, it looks like 4.19-rt is at least missing commit 46fcc4b00c3cc
("sched/deadline: Fix stale throttling on de-/boosted tasks") and commit
2279f540ea7d0 ("sched/deadline: Fix priority inheritance with multiple
scheduling classes") that might be playing also a role here.

Best,
Juri

