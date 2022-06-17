Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505E154F969
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382848AbiFQOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382845AbiFQOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B9B338BD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655477003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELNIoDd4jGFrzzoRGlYbdPQ/VgoPmPjRtlTV2XWJ2HY=;
        b=HxQfDw+oiPmrR3pm+VDDO0iWBdBTuUUnIHliRwocvF+2LoZxm31SXqI5pkqpkzZ6Hc6iQL
        NyWzdJjVAf2YjpRG7xidW/PJJVWdGn+Mjk4fDX9cs25SN2agT1oY81Cj/hSWz1b7j9MUt7
        a+hcuDuHxJlBMP32fOOFNasTCh9p0s0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-yzMJJcfxPy29hkN2pHmvPw-1; Fri, 17 Jun 2022 10:43:18 -0400
X-MC-Unique: yzMJJcfxPy29hkN2pHmvPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B89E101AA47;
        Fri, 17 Jun 2022 14:43:17 +0000 (UTC)
Received: from [10.22.18.98] (unknown [10.22.18.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 162B7815B;
        Fri, 17 Jun 2022 14:43:17 +0000 (UTC)
Message-ID: <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
Date:   Fri, 17 Jun 2022 10:43:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Shakeel Butt <shakeelb@google.com>
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 08:07, Peter Zijlstra wrote:
> On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
>>   	/*
>>   	 * Readers come here when they cannot get the lock without waiting
>>   	 */
>> -	if (unlikely(in_interrupt())) {
>> -		/*
>> -		 * Readers in interrupt context will get the lock immediately
>> -		 * if the writer is just waiting (not holding the lock yet),
>> -		 * so spin with ACQUIRE semantics until the lock is available
>> -		 * without waiting in the queue.
>> -		 */
>> -		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>> -		return;
>> -	}
>>   	atomic_sub(_QR_BIAS, &lock->cnts);
>>   
>>   	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
> This is known to break tasklist_lock.
>
We certainly can't break the current usage of tasklist_lock.

I am aware of this problem with networking code and is thinking about 
either relaxing the check to exclude softirq or provide a 
read_lock_unfair() variant for networking use. I think tasklist_lock 
isn't taken from softirq context, but I may be wrong. Providing a 
read_lock_unfair() will require quite a bit of work in the supporting 
infrastructure as well.

Cheers,
Longman

