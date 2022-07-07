Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1E56AAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiGGSp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiGGSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B54CB2ED69
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657219523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHInCIkQUugLccZbd+xrohtB+C3yl1Vr9TS2L4m9vhM=;
        b=FBs9QS2vJ+9vQYtFbsAw7hr49T+W3Ph25GxmxsgRZ9nkj06vrB41LeujXMO4BcOL8VqhW6
        HqiWXHBcSh1IdP9UoQMYa91h4szfPtjcBJ5ga/xA/IRrlUFd6WyBN68XWot1Tp4UIiq20y
        IIVTvXS7/s2PjHzco0Pj36w1qYdrUls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-bU6Tbu2hNLmzKiKfwE428g-1; Thu, 07 Jul 2022 14:45:20 -0400
X-MC-Unique: bU6Tbu2hNLmzKiKfwE428g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C67A101A54E;
        Thu,  7 Jul 2022 18:45:20 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDEB6492C3B;
        Thu,  7 Jul 2022 18:45:19 +0000 (UTC)
Message-ID: <3e43bc07-053f-80d0-7ea1-93a2897ef03e@redhat.com>
Date:   Thu, 7 Jul 2022 14:45:10 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YsckV+iWLxPC+eH5@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 14:22, Boqun Feng wrote:
> On Wed, Jul 06, 2022 at 10:03:10AM -0400, Waiman Long wrote:
>> On 7/6/22 09:59, Waiman Long wrote:
>>> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
>>> stealing") allows unlimited number of lock stealing's for non-RT
>>> tasks. That can lead to lock starvation of non-RT top waiter tasks if
>>> there is a constant incoming stream of non-RT lockers. This can cause
>>> rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
>>> For example,
>>>
>>> [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
>>> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
>>>
>>> Avoiding this problem and ensuring forward progress by limiting the
>>> number of times that a lock can be stolen from each waiter. This patch
>>> sets a threshold of 32. That number is arbitrary and can be changed
>>> if needed.
>>>
>>> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>    kernel/locking/rtmutex.c        | 9 ++++++---
>>>    kernel/locking/rtmutex_common.h | 8 ++++++++
>>>    2 files changed, 14 insertions(+), 3 deletions(-)
>>>
>>>    [v3: Increase threshold to 32 and add rcu_preempt self-detected stall]
>> Note that I decided to increase the threshold to 32 from 10 to reduce the
>> potential performance impact of this change, if any. We also found out that
>> this patch can fix some of the rcu_preempt self-detected stall problems that
>> we saw with the PREEMPT_RT kernel. So I added that information in the patch
>> description.
>>
> Have you considered (and tested) whether we can set the threshold
> directly proportional to nr_cpu_ids? Because IIUC, the favorable case
> for lock stealing is that every CPU gets a chance to steal once. If one
> CPU can steal twice, 1) either there is a context switch between two
> tasks, which costs similarly as waking up the waiter, or 2) a task drops
> and re-graps a lock, which means the task wants to yield to other
> waiters of the lock.

There is no inherent restriction on not allowing the same cpu stealing 
the lock twice or more. With rtmutex, the top waiter may be sleeping and 
the wakeup latency can be considerable. By allowing another ready lock 
waiter to steal the lock for productive use, it can improve system 
throughput. There is no fairness in lock stealing and I don't believe it 
is a worthwhile goal to allow each cpu to steal the lock once. It will 
just complicate the code.

On the other hand, unlimited lock stealing is bad and we have a put a 
limit somehow to ensure forward progress.

Cheers,
Longman

