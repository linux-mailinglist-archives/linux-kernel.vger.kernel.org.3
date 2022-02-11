Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12994B28BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351230AbiBKPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:08:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351221AbiBKPIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA042309
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644592096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xonPRQVnJi+0YPcuDGy+YT0IDKCipuXLPrLPfAZe99w=;
        b=f2utigNFX2LI6iDXju5xfUTUqtfByLYubq36QkKiXH+CXN1Xp3TZK/G7tfZwWSy5bFYRLs
        FcBQjEXNFYr3UXoxBIq9qSPPC4Tfc2+I6xy+IiSprruTahtQ2mg3bS4pcs3JaRGotobFRc
        1VUMwmvL3gaNdt7wAjmsImceGd7pN1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-aPzRtt6OPrichVePzjoisw-1; Fri, 11 Feb 2022 10:08:13 -0500
X-MC-Unique: aPzRtt6OPrichVePzjoisw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C58E10247AC;
        Fri, 11 Feb 2022 15:08:08 +0000 (UTC)
Received: from [10.22.34.66] (unknown [10.22.34.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A174F5B28A;
        Fri, 11 Feb 2022 15:08:07 +0000 (UTC)
Message-ID: <70ccc7df-d536-5c8f-fd72-0797bb566e07@redhat.com>
Date:   Fri, 11 Feb 2022 10:08:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220118153254.358748-1-longman@redhat.com>
 <YgTms3tGYeQ4HYFZ@hirez.programming.kicks-ass.net>
 <e30a6464-708b-4946-65f0-c9a1e6bf2b35@redhat.com>
 <20220211105106.GS23216@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220211105106.GS23216@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 05:51, Peter Zijlstra wrote:
> On Thu, Feb 10, 2022 at 12:04:59PM -0500, Waiman Long wrote:
>> On 2/10/22 05:19, Peter Zijlstra wrote:
>> I am sorry that I might have stripped out too much for the lockdep splat to
>> make it understandable. Below is the full lockdep splat:
> Right, so please just transcribe the relevant bits instead of including
> this massive splat. It really isn't too complicated.
>
> That can be summarized as:
>
> 	0:		1:		2:
> 	pi_lock		rq->lock	console_sem
> 	  rq->lock	  console_sem	  pi_lock
>
> Which is *much* shorter and *much* easier to read.
>
OK, got it. However, I thought the circular dependency has been 
explained by that part of the lockdep splat:

[ 9776.459905] Chain exists of:
[ 9776.459906]   (console_sem).lock --> &p->pi_lock --> &rq->__lock

[ 9776.459911]  Possible unsafe locking scenario:

[ 9776.459913]        CPU0                    CPU1
[ 9776.459914]        ----                    ----
[ 9776.459914]   lock(&rq->__lock);
[ 9776.459917] 				lock(&p->pi_lock);
[ 9776.459919] 				lock(&rq->__lock);
[ 9776.459921]   lock((console_sem).lock);

This should convey the same information. Though I think I need to describe where those locking sequence happen.

>>> More concerning, that ordering is invalid to begin with, so the above
>>> seems like a very poor justification for this patch.
>> Which lock ordering are you considered invalid?
> 1: above. You cannot take a semaphore inside a (raw) spinlock.
You may have been confused by the name "console_sem". A semaphore is 
basically a count protected by a raw spinlock. So console_sem.lock is 
actually a raw spinlock. It is perfectly legal to take a raw spinlock 
after holding another raw spinlock.
>
>> The stack trace included in the patch description show the
>> (console_sem).lock --> &p->pi_lock --> &rq->__lock sequence because of the
>> wake_up_process() call while holding the console_sem.lock.
>>
>> The reverse &rq->__lock lock may happen when a printk() statement is called
>> while holding the rq lock.
>>
>> In this case, the printk() is triggered by a SCHED_WARN_ON() statement in
>> update_rq_clock() which don't call printk_deferred and so won't have
>> LOGLEVEL_SCHED set. I guess there is alternative way to work around this
>> issue, but moving the process wakeup out from the semaphore spinlock will
>> solve this problem in case there are other corner cases like that.
>>
>> I will update the patch description to include this additional information.
> The right solution is to burn printk_deferred at the stake and most of
> printk along with it (they're working on it).
>
> Hitting that WARN is the real problem, the rest is collateral damage and
> I'm really not interested in fixing that.

Yes, hitting the WARN is the cause of this lockdep splat. In the v2 
patch, I list the alternatives as either banning WARN inside rq lock or 
make a WARN that work with rq lock if we are not going to fix the 
semaphore. So what is your recommendation about handling that?

Cheers,
Longman

