Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0445656ABD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiGGTZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGGTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A638417A97
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657221942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TV6DG0ZvFM8J9dBaCP3o8wlufBttfQc7HepH4J2ctXY=;
        b=ELZgaN+RnLGLUR0hKamT3YS8daWaAqsu8gaKaGZNV3gl+7+sDuUoPyaeKcv8LuHETnyO/R
        R5G1FiWU6DGJoVbnSEsLbVj/6b8K7cKr1/mEhBJI5iThSSUfUWGzATBZQgZd9XmljJ0eU0
        TF5AOtdtkAdMrH7n/nMaFxILrMYakdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-ImaUdo5uOTC45OBW9zBOqQ-1; Thu, 07 Jul 2022 15:25:37 -0400
X-MC-Unique: ImaUdo5uOTC45OBW9zBOqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E3AA3C0F380;
        Thu,  7 Jul 2022 19:25:37 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAE1C2166B26;
        Thu,  7 Jul 2022 19:25:36 +0000 (UTC)
Message-ID: <cf3c6ae1-e454-b880-e8cc-57d6862f9cd8@redhat.com>
Date:   Thu, 7 Jul 2022 15:25:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220706135916.980580-1-longman@redhat.com>
 <f3051cbb-313c-ba88-66c9-3f8f8d88d806@redhat.com>
 <YsckV+iWLxPC+eH5@boqun-archlinux>
 <3e43bc07-053f-80d0-7ea1-93a2897ef03e@redhat.com>
 <YscuLP2PuMEnMh35@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YscuLP2PuMEnMh35@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 15:04, Boqun Feng wrote:
> On Thu, Jul 07, 2022 at 02:45:10PM -0400, Waiman Long wrote:
>> On 7/7/22 14:22, Boqun Feng wrote:
>>> On Wed, Jul 06, 2022 at 10:03:10AM -0400, Waiman Long wrote:
>>>> On 7/6/22 09:59, Waiman Long wrote:
>>>>> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
>>>>> stealing") allows unlimited number of lock stealing's for non-RT
>>>>> tasks. That can lead to lock starvation of non-RT top waiter tasks if
>>>>> there is a constant incoming stream of non-RT lockers. This can cause
>>>>> rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
>>>>> For example,
>>>>>
>>>>> [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
>>>>> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
>>>>>
>>>>> Avoiding this problem and ensuring forward progress by limiting the
>>>>> number of times that a lock can be stolen from each waiter. This patch
>>>>> sets a threshold of 32. That number is arbitrary and can be changed
>>>>> if needed.
>>>>>
>>>>> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>     kernel/locking/rtmutex.c        | 9 ++++++---
>>>>>     kernel/locking/rtmutex_common.h | 8 ++++++++
>>>>>     2 files changed, 14 insertions(+), 3 deletions(-)
>>>>>
>>>>>     [v3: Increase threshold to 32 and add rcu_preempt self-detected stall]
>>>> Note that I decided to increase the threshold to 32 from 10 to reduce the
>>>> potential performance impact of this change, if any. We also found out that
>>>> this patch can fix some of the rcu_preempt self-detected stall problems that
>>>> we saw with the PREEMPT_RT kernel. So I added that information in the patch
>>>> description.
>>>>
>>> Have you considered (and tested) whether we can set the threshold
>>> directly proportional to nr_cpu_ids? Because IIUC, the favorable case
>>> for lock stealing is that every CPU gets a chance to steal once. If one
>>> CPU can steal twice, 1) either there is a context switch between two
>>> tasks, which costs similarly as waking up the waiter, or 2) a task drops
>>> and re-graps a lock, which means the task wants to yield to other
>>> waiters of the lock.
>> There is no inherent restriction on not allowing the same cpu stealing the
>> lock twice or more. With rtmutex, the top waiter may be sleeping and the
> Well, I'm not saying we need to restrict the same cpu to steal a lock
> twice or more. Think about this, when there is a task running on CPU 1
> already steals a lock once, for example:
>
> 	<lock release>
> 	{task C is the top waiter}
>
> 	CPU 1
> 	=====
> 	<now task A running>
> 	lock(); // steal the lock
> 	...
> 	unlock():
> 	  // set owner to NULL
> 	  <switch task B> // similar cost to wake up A
> 	  lock(); // steal the lock
>
> , which means if a CPU steals a lock twice or more, it's almost certain
> that a context happened between two steals ("almost" because there could
> be a case where task A lock()+unlock() twice, but as I said, it
> means that task A is willing to yield.).
>
> Therefore if there are @nr_cpu_ids lock steals, it means either there is
> a context switch somewhere or a task has been willing to yield. And I
> think it's a reasonable signal to stop lock stealing.
>
> Thoughts?

The reality is that a task can acquire the same lock multiple times 
before a context switch. So I believe stealing a lock from the same 
sleeping top waiter multiple times can certainly happen. For a large SMP 
systems with hundred or even thousands of cpus, allowing that many lock 
stealing may significantly increase the lock acquisition latency for the 
unfortunate tasks.

Another alternative that I have done in the past is to put in a time 
stamp where a task become the top waiter and refrained from stealing the 
lock when the elapsed time from the time stamp exceeds a certain limit. 
That will limit the max lock acquisition latency of a non-RT task as 
long as there are no other RT tasks competing with it for the lock.

Cheers,
Longman

