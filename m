Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00E572BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiGMDDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGMDDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E81ADD64F9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657681380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKCW1VIPhBlGLtHiDdo2L+Ie0mqV5EcOVK4BKO6iRIQ=;
        b=dSv47E/zuiuRvIbPP6S55Ck/+nRY6oDmlicfj0du0igGKgDE+nlxg3+dj66CN7JDxfNq5n
        7orTMQQxu+lZG0PQSySqHezsa1GvQma1N56KegFg8+6SGGZAmAEKshFS/WBTeu1VD+2uKZ
        g9dZO1rxdHHLxfQX3PF8w+LkVV5a5Vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-PczGRwZgMKekaN68QBXEBA-1; Tue, 12 Jul 2022 23:02:50 -0400
X-MC-Unique: PczGRwZgMKekaN68QBXEBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FAE2101A586;
        Wed, 13 Jul 2022 03:02:50 +0000 (UTC)
Received: from [10.22.10.179] (unknown [10.22.10.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB571400DC12;
        Wed, 13 Jul 2022 03:02:48 +0000 (UTC)
Message-ID: <a51a0a2e-d50d-c172-9403-034b13dff1a4@redhat.com>
Date:   Tue, 12 Jul 2022 23:02:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu> <YsyO9GM9mCydaybo@slm.duckdns.org>
 <20220711171130.6390600b@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220711171130.6390600b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 17:11, Steven Rostedt wrote:
> On Mon, 11 Jul 2022 10:58:28 -1000
> Tejun Heo <tj@kernel.org> wrote:
>
>> I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
>> unfortunately.
>>
>>> AFAIU:
>>>
>>>
>>> CPU0                                     CPU1                                   CPU2
>>>
>>> // attach task to a different
>>> // cpuset cgroup via sysfs
>>> __acquire(cgroup_threadgroup_rwsem)
>>>
>>>                                           // pring up CPU2 online
>>>                                           __acquire(cpu_hotplug_lock)
>>>                                           // wait for CPU2 to come online
> Should there be some annotation here that tells lockdep that CPU1 is now
> blocked on CPU2?
>
> Then this case would be caught by lockdep.
>
> -- Steve
>
>
>>>                                                                                  // bringup cpu online
>>>                                                                                  // call cpufreq_online() which tries to create sugov kthread
>>> __acquire(cpu_hotplug_lock)                                                     copy_process()
>>>                                                                                     cgroup_can_fork()
>>>                                                                                        cgroup_css_set_fork()
>>>                                                                                        __acquire(cgroup_threadgroup_rwsem)
>>> // blocks forever                        // blocks forever                            // blocks forever

Actually, the dependency can probably be coded by calling 
lockdep_acquire_cpus_lock() in cpu2 (task 2) before acquiring 
cgroup_threadgroup_rwsem to indicate the dependency between CPU1 and 
CPU2 (task 1 and task 2). lockdep_release_cpus_lock() can then called 
after release the rwsem.

Cheers,
Longman

