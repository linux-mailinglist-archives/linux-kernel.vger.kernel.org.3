Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C70588712
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiHCF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCF5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07B52E01E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659506252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syL/2eT8W871dMcS7JXPVuHY+ucOOO9cLIJgDqnS+3w=;
        b=hSwqls5+kpKUxfYEqTxh8BhKdy+kiYWA3KoHjKW6sQsWiXiTs/luj2pKVt8ozWQwqHQzzQ
        odn9Eg0hFqDlHUGSFLrMyySy6zViyrOOZmSBu3ddGmgEA2DqymmHqPb9O+7AzftxLA7zMq
        AVXml/xZ8F4kmWrfWOlHTLhMRD1qOb0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-Y_lb_pEMP9q16nJQsWFPMQ-1; Wed, 03 Aug 2022 01:57:30 -0400
X-MC-Unique: Y_lb_pEMP9q16nJQsWFPMQ-1
Received: by mail-qt1-f199.google.com with SMTP id hf13-20020a05622a608d00b003214b6b3777so7527373qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 22:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=syL/2eT8W871dMcS7JXPVuHY+ucOOO9cLIJgDqnS+3w=;
        b=EzXQfUaUskZxOjABDLQAFcPcXAJxkUNuff2hd5o93EFdmbXDxFvTpOozvjvLR5QuYp
         l3BC+9kLHa9e2cNL+rZurmFstmRiXBZPbkqD40RnlQX+pefUbgPyS0MRK45JU3JVM+MS
         9uypeFht4LRpCfM6saR067UKtN0d+dFdws/V/ZWNMxy9dmNDIvIfKwdO1eM8J5h8P4s9
         ney4FtUAlShtvQ1/JOSIQNxAytYLurkGQ3bOYGtidoDPMZiyJavjy1qhSAU4M31nzn7s
         uRCKulO3VhN9KocyURVKgvB2lkoBMMc7HC4QE7PATMx8enaAExEBINbx5x72kwCPkQ8u
         DL9A==
X-Gm-Message-State: ACgBeo0XL8ROKQPKkX1hItifrF1o9O0KHITpT85/BsXFNtKlRD3fyzwE
        3+E1d6WT5WF69iiqNdxumIY3hs6fHUDqQbUHtT7j89jY5ySQr2Mr0XhJPr8YVw91s9FRvvU1FIj
        BGR3VkRDHffAKwF+0I+/JwdEH
X-Received: by 2002:a05:620a:126e:b0:6b8:e049:ced3 with SMTP id b14-20020a05620a126e00b006b8e049ced3mr2692034qkl.480.1659506250211;
        Tue, 02 Aug 2022 22:57:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7M652KpGiAZvnK7jxc22YqWZgmt/8LElqDQL5jyBtI7LxpkkaZB6bpmgVTEEhbva0N5GhNuQ==
X-Received: by 2002:a05:620a:126e:b0:6b8:e049:ced3 with SMTP id b14-20020a05620a126e00b006b8e049ced3mr2692013qkl.480.1659506249945;
        Tue, 02 Aug 2022 22:57:29 -0700 (PDT)
Received: from localhost.localdomain ([151.29.52.6])
        by smtp.gmail.com with ESMTPSA id ca21-20020a05622a1f1500b0031eb51dd72csm10410853qtb.85.2022.08.02.22.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 22:57:29 -0700 (PDT)
Date:   Wed, 3 Aug 2022 07:57:21 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, cpuset: Fix dl_cpu_busy() panic due to empty
 cs->cpus_allowed
Message-ID: <YuoOQRiZH4R0UZ6q@localhost.localdomain>
References: <20220803015451.2219567-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803015451.2219567-1-longman@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/08/22 21:54, Waiman Long wrote:
> With cgroup v2, the cpuset's cpus_allowed mask can be empty indicating
> that the cpuset will just use the effective cpus of its parent. So
> cpuset_can_attach() can call task_can_attach() with an empty mask.
> This can lead to cpumask_any_and() returns nr_cpu_ids causing the call
> to dl_bw_of() to crash due to percpu value access of an out of bound
> cpu value. For example,
> 
> [80468.182258] BUG: unable to handle page fault for address: ffffffff8b6648b0
>   :
> [80468.191019] RIP: 0010:dl_cpu_busy+0x30/0x2b0
>   :
> [80468.207946] Call Trace:
> [80468.208947]  cpuset_can_attach+0xa0/0x140
> [80468.209953]  cgroup_migrate_execute+0x8c/0x490
> [80468.210931]  cgroup_update_dfl_csses+0x254/0x270
> [80468.211898]  cgroup_subtree_control_write+0x322/0x400
> [80468.212854]  kernfs_fop_write_iter+0x11c/0x1b0
> [80468.213777]  new_sync_write+0x11f/0x1b0
> [80468.214689]  vfs_write+0x1eb/0x280
> [80468.215592]  ksys_write+0x5f/0xe0
> [80468.216463]  do_syscall_64+0x5c/0x80
> [80468.224287]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fix that by using effective_cpus instead. For cgroup v1, effective_cpus
> is the same as cpus_allowed. For v2, effective_cpus is the real cpumask
> to be used by tasks within the cpuset anyway.
> 
> Also update task_can_attach()'s 2nd argument name to cs_effective_cpus to
> reflect the change. In addition, a check is added to task_can_attach()
> to guard against the possibility that cpumask_any_and() may return a
> value >= nr_cpu_ids.
> 
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Looks good to me. Thanks for looking into it!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

