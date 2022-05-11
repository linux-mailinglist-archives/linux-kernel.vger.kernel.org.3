Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32352334F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbiEKMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiEKMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53902403D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652273101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9/wFzrl521hVqOZzEvHnymagNHWPHuPsHDMhxgbQrE=;
        b=N/HakxEcBUr5Tx58a8vlho0ltMyIzDcZss8amCwlht5KK6ejyMsgD6Mv424D5+pbKcyFbv
        rm3z1VECsm22e6792uuQ5GEl/H+nkK+fmRuFiQk7TRN101GsJcm7T4iJF84sgxR0jRq2Bd
        bquXbzJmsv/d1txMwUxwa7XEnNsDziw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-cKJWm6LsOo-jKqwpJ58zWg-1; Wed, 11 May 2022 08:44:57 -0400
X-MC-Unique: cKJWm6LsOo-jKqwpJ58zWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 592E18117B0;
        Wed, 11 May 2022 12:44:56 +0000 (UTC)
Received: from [10.22.16.235] (unknown [10.22.16.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB3A740C1244;
        Wed, 11 May 2022 12:44:55 +0000 (UTC)
Message-ID: <7eff9889-56fe-503c-94ea-376054c6579b@redhat.com>
Date:   Wed, 11 May 2022 08:44:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20220510192134.434753-1-longman@redhat.com>
 <20220510192134.434753-2-longman@redhat.com>
 <20220511083036.GY76023@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220511083036.GY76023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 04:30, Peter Zijlstra wrote:
> On Tue, May 10, 2022 at 03:21:34PM -0400, Waiman Long wrote:
>> Even though qrwlock is supposed to be a fair lock, it does allow readers
>> from interrupt context to spin on the lock until it can acquire it making
>> it not as fair. This exception was added due to the requirement to allow
>> recursive read lock in interrupt context. This can also be achieved by
>> just ignoring the writer waiting bit without spinning on the lock.
>>
>> By making this change, we make qrwlock a bit more fair and eliminating
>> the problem of cacheline bouncing for rwlocks that are used heavily in
>> interrupt context, like the networking stack. This should also reduce
>> the chance of lock starvation for those interrupt context rwlocks.
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index 2e1600906c9f..d52d13e95600 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -18,21 +18,16 @@
>>    * queued_read_lock_slowpath - acquire read lock of a queued rwlock
>>    * @lock: Pointer to queued rwlock structure
>>    */
>> -void queued_read_lock_slowpath(struct qrwlock *lock)
>> +void queued_read_lock_slowpath(struct qrwlock *lock, int cnts)
>>   {
>>   	/*
>> -	 * Readers come here when they cannot get the lock without waiting
>> +	 * Readers come here when they cannot get the lock without waiting.
>> +	 * Readers in interrupt context can steal the lock immediately
>> +	 * if the writer is just waiting (not holding the lock yet).
>>   	 */
>> -	if (unlikely(in_interrupt())) {
>> -		/*
>> -		 * Readers in interrupt context will get the lock immediately
>> -		 * if the writer is just waiting (not holding the lock yet),
>> -		 * so spin with ACQUIRE semantics until the lock is available
>> -		 * without waiting in the queue.
>> -		 */
>> -		atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>> +	if (unlikely(!(cnts & _QW_LOCKED) && in_interrupt()))
>>   		return;
>> -	}
>> +
>>   	atomic_sub(_QR_BIAS, &lock->cnts);
>>   
>>   	trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
> I'm confused; prior to this change:
>
> 	CPU0			CPU1
>
> 	write_lock_irq(&l)
> 				read_lock(&l)
> 				<INRQ>
> 				  read_lock(&l)
> 				  ...
>
> was not deadlock, but now it would AFAICT.

Oh you are right. I missed that scenario in my analysis. My bad.

Please scrap this patch. Patch 1 is just an update to the comment and so 
is still applicable.

Thanks,
Longman

