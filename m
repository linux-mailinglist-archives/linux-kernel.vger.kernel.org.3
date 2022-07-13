Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7C572B73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiGMCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGMCuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25EADD216F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657680604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRRaJtjNCuDIggYig77nuZAc2jFfrjbfbHSc4r6FyJI=;
        b=gFbtWH6JhFQ7PFN3GcEt7fPiT9MizBO/i/LRLLvb3Brx9n8wfYspaJKAdXktmfI9aK4ASA
        o5nH4wgAHoS7txKi8ZFMdmESiEBck+XbiGlueCp2zjlMmRemdBckoFOxp4QmV2OpTM62FM
        YCaD9M3iyRaPxolw0WiS2WZGVrKUN5Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-Tn5LV_pxP8G6P0MjUDAlYw-1; Tue, 12 Jul 2022 22:49:59 -0400
X-MC-Unique: Tn5LV_pxP8G6P0MjUDAlYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF94A38164C8;
        Wed, 13 Jul 2022 02:49:58 +0000 (UTC)
Received: from [10.22.10.179] (unknown [10.22.10.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC62C28100;
        Wed, 13 Jul 2022 02:49:57 +0000 (UTC)
Message-ID: <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
Date:   Tue, 12 Jul 2022 22:49:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu> <YsyO9GM9mCydaybo@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YsyO9GM9mCydaybo@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/22 16:58, Tejun Heo wrote:
> (cc'ing Waiman)
>
> On Mon, Jul 11, 2022 at 06:46:29PM +0100, Qais Yousef wrote:
>> Have you tried running with PROVE_LOCKDEP enabled? It'll help print a useful
>> output about the DEADLOCK. But your explanation was good and clear to me.
> I don't think lockdep would be able to track CPU1 -> CPU2 dependency here
> unfortunately.

That is the case AFAIK. Lockdep only track individually the locks taken 
by each task.


>> AFAIU:
>>
>>
>> CPU0                                     CPU1                                   CPU2
>>
>> // attach task to a different
>> // cpuset cgroup via sysfs
>> __acquire(cgroup_threadgroup_rwsem)
>>
>>                                           // pring up CPU2 online
>>                                           __acquire(cpu_hotplug_lock)
>>                                           // wait for CPU2 to come online
>>                                                                                  // bringup cpu online
>>                                                                                  // call cpufreq_online() which tries to create sugov kthread
>> __acquire(cpu_hotplug_lock)                                                     copy_process()
>>                                                                                     cgroup_can_fork()
>>                                                                                        cgroup_css_set_fork()
>>                                                                                        __acquire(cgroup_threadgroup_rwsem)
>> // blocks forever                        // blocks forever                            // blocks forever
>>
>>
>> Is this a correct summary of the problem?
>>
>> The locks are held in reverse order and we end up with a DEADLOCK.
>>
>> I believe the same happens on offline it's just the path to hold the
>> cgroup_threadgroup_rwsem on CPU2 is different.
>>
>> This will be a tricky one. Your proposed patch might fix it for this case, but
>> if there's anything else that creates a kthread when a cpu goes online/offline
>> then we'll hit the same problem again.
>>
>> I haven't reviewed your patch to be honest, but I think worth seeing first if
>> there's something that can be done at the 'right level' first.
>>
>> Needs head scratching from my side at least. This is the not the first type of
>> locking issue between hotplug and cpuset :-/
> Well, the only thing I can think of is always grabbing cpus_read_lock()
> before grabbing threadgroup_rwsem. Waiman, what do you think?

That is a possible solution as cpus_read_lock() is rather lightweight. 
It is a good practice to acquire it first.

Cheers,
Longman

>
> Thanks.
>

