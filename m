Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBF58E393
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiHIXJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiHIXJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD3166C116
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660086557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcsteQl4ar7PXChAGBruymVcxIk27EDsQGmXARV6geM=;
        b=Ji96Z76oe+kc2AGxoMofs1yEiEyTvfDUjhME32pfqYqJtaycXQY7MOajmBXTBjROZzqzMn
        lFEkVxPVLV96xnEvOjnh4Kt/2JCnaEhwPAG9Ewvbn4jCSq1n/wGpIJ/8PXP/2rqr91+zrr
        oa7tLC0CjB2AXsAId8Gmg1tNNa1+Wkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-ADaXgl0AMb2eLfdo21Wc5w-1; Tue, 09 Aug 2022 19:09:09 -0400
X-MC-Unique: ADaXgl0AMb2eLfdo21Wc5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 713C4802D1C;
        Tue,  9 Aug 2022 23:09:06 +0000 (UTC)
Received: from [10.22.18.32] (unknown [10.22.18.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD1140CF8EB;
        Tue,  9 Aug 2022 23:09:06 +0000 (UTC)
Message-ID: <eb01385f-4860-6394-ade5-518e12f70287@redhat.com>
Date:   Tue, 9 Aug 2022 19:09:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] locking: Add __lockfunc to slow path functions
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220808175956.592707-1-namhyung@kernel.org>
 <7b1c463c-c912-ba08-bac4-99d45e45f7e1@redhat.com>
 <CAM9d7ciPHi27JwcCbCWAkHnFBn-6PRbpRjBJ1U=cfDN-UcthjA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAM9d7ciPHi27JwcCbCWAkHnFBn-6PRbpRjBJ1U=cfDN-UcthjA@mail.gmail.com>
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

On 8/9/22 17:13, Namhyung Kim wrote:
> Hello,
>
> On Tue, Aug 9, 2022 at 8:05 AM Waiman Long <longman@redhat.com> wrote:
>> On 8/8/22 13:59, Namhyung Kim wrote:
>>> So that we can skip the functions in the perf lock contention and other
>>> places like /proc/PID/wchan.
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>    kernel/locking/qrwlock.c   | 4 ++--
>>>    kernel/locking/qspinlock.c | 2 +-
>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>>> index 2e1600906c9f..d2ef312a8611 100644
>>> --- a/kernel/locking/qrwlock.c
>>> +++ b/kernel/locking/qrwlock.c
>>> @@ -18,7 +18,7 @@
>>>     * queued_read_lock_slowpath - acquire read lock of a queued rwlock
>>>     * @lock: Pointer to queued rwlock structure
>>>     */
>>> -void queued_read_lock_slowpath(struct qrwlock *lock)
>>> +void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
>>>    {
>>>        /*
>>>         * Readers come here when they cannot get the lock without waiting
>>> @@ -63,7 +63,7 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
>>>     * queued_write_lock_slowpath - acquire write lock of a queued rwlock
>>>     * @lock : Pointer to queued rwlock structure
>>>     */
>>> -void queued_write_lock_slowpath(struct qrwlock *lock)
>>> +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>>>    {
>>>        int cnts;
>>>
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index 65a9a10caa6f..2b23378775fe 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
>>>     * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
>>>     *   queue               :         ^--'                             :
>>>     */
>>> -void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>> +void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>>    {
>>>        struct mcs_spinlock *prev, *next, *node;
>>>        u32 old, tail;
>>
>> For completeness, I think you should also add it to the
>> __pv_queued_spin_unlock() and __pv_queued_spin_unlock_slowpath()
>> function in kernel/locking/qspinlock_paravirt.h. Perhaps even the
>> assembly code in arch/x86/include/asm/qspinlock_paravirt.h.
> Thanks for your comment.  I'm not sure about the asm part, will this be enough?
>
> --- a/arch/x86/include/asm/qspinlock_paravirt.h
> +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> @@ -36,7 +36,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
>    *   rsi = lockval           (second argument)
>    *   rdx = internal variable (set to 0)
>    */
> -asm    (".pushsection .text;"
> +asm    (".pushsection .spinlock.text;"
>          ".globl " PV_UNLOCK ";"
>          ".type " PV_UNLOCK ", @function;"
>          ".align 4,0x90;"
>
That is what I meant. However, you should also a comment saying that the 
use of .spinlock.text section is equivalent to the use of __lockfunc on 
an equivalent C function to make it clear. Also add the __lockfunc to 
the pseudo code in the comment section.

Cheers,
Longman

