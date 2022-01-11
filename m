Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7AB48B048
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbiAKPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244170AbiAKPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641913480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D71TOijj/AaLdV4YKK2S1vulUsaeY97bR41W9OoZ9Ow=;
        b=ahSCpm7iv1sTyU7iZK1WERHrpcSUSUsrWJEmOMzS5k8iCBiNe9CAII/hKt8lXVNcOe9LzZ
        iWK6JQSon48wbwqz00qtWth63rh751qtItiFVX33whetPwOnzjWihzTbSRejN4YLfN61+X
        BLD3lTvFJJuPMiPW2tNLHMlZjUn8fRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-J8WF9aDANEyieIRi0fbUog-1; Tue, 11 Jan 2022 10:04:37 -0500
X-MC-Unique: J8WF9aDANEyieIRi0fbUog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B570284BA54;
        Tue, 11 Jan 2022 15:04:35 +0000 (UTC)
Received: from [10.22.11.115] (unknown [10.22.11.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8E797EDA0;
        Tue, 11 Jan 2022 15:04:33 +0000 (UTC)
Message-ID: <86891228-9c91-09f1-0e2d-0a3392649d52@redhat.com>
Date:   Tue, 11 Jan 2022 10:04:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] f2fs: move f2fs to use reader-unfair rwsems
Content-Language: en-US
To:     Tim Murray <timmurray@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
 <9efbbcb7-29cd-a8ab-0632-01986edc862f@redhat.com>
 <CAEe=Sx=C8e7=A6ziy8dYC+FvkWvVYZ+o=XMCP_4vX0efsUPT4Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAEe=Sx=C8e7=A6ziy8dYC+FvkWvVYZ+o=XMCP_4vX0efsUPT4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/11/22 01:53, Tim Murray wrote:
> On Mon, Jan 10, 2022 at 8:15 PM Waiman Long <longman@redhat.com> wrote:
>> That is not how rwsem works. A reader which fails to get the lock
>> because it is write-locked will remove its reader count before going to
>> sleep. So the reader count will be zero eventually. Of course, there is
>> a short period of time where the reader count will be non-zero until the
>> reader removes its own reader count. So if a new writer comes in at that
>> time, it will fail its initial trylock and probably go to optimistic
>> spinning mode. If the writer that owns the lock release it at the right
>> moment, the reader may acquire the read lock.
> Thanks for the correction, that makes sense. I haven't spent too much
> time on rwsem internals and I'm not confident about when flags are set
> and cleared in sem->count; is there a case where sem->count after
> up_write() could be nonzero?
>
> An example from one trace:
>
> 1. Low-priority userspace thread 4764 is blocked in f2fs_unlink,
> probably at f2fs_lock_op, which is a wrapper around
> down_read(cp_rwsem).
> 2. f2fs-ckpt runs at t=0ms and wakes thread 4764, making it runnable.
> 3. At t=1ms, f2fs-ckpt enters uninterruptible sleep and blocks at
> rwsem_down_write_slowpath per sched_blocked_reason.
> 4. At t=26ms, thread 4764 runs for the first time since being made
> runnable. Within 40us, thread 4764 unblocks f2fs-ckpt and makes it
> runnable.
>
> Since thread 4764 is awakened by f2fs-ckpt but never runs before it
> unblocks f2fs-ckpt in down_write_slowpath(), the only idea I had is
> that cp_rwsem->count is nonzero after f2fs-ckpt's up_write() in step 2
> (maybe because of rwsem_mark_wake()?).
>
>> I do have a question about the number of readers in such a case compared
>> with the number of writers. Are there a large number of low priority
>> hanging around? What is an average read lock hold time?
>>
>> Blocking for 9.7s for a write lock is quite excessive and we need to
>> figure out how this happen.,
> Just to be 100% clear, it's not a single 9.7s stall, it's many smaller
> stalls of 10-500+ms in f2fs-ckpt that add up to 9.7s over that range.
>
> f2fs is not my area of expertise, but my understanding is that
> cp_rwsem in f2fs has many (potentially unbounded) readers and a single
> writer. Arbitrary userspace work (fsync, creating/deleting/truncating
> files, atomic writes) may grab the read lock, but assuming the
> merge_checkpoint option is enabled, only f2fs-ckpt will ever grab the
> write lock during normal operation. However, in this particular
> example, it looks like there may have been 5-10 threads blocked on
> f2fs-ckpt that were awakened alongside thread 4764 in step 2.
>
> I'll defer to the f2fs experts on the average duration that the read
> lock is held.

Thanks for the explanation.

Another question that I have is whether the test result is based on the 
latest upstream kernel or earlier kernel version. We used to allow 
reader optimistic spinning which was then removed in later kernel. 
Reader optimistic spinning may further increase writer wait time.

Anyway, AFAICS, this patch keeps readers out of the rwsem wait queue and 
so only writers can go into it. We can make an unfair rwsem to give 
preference to writers in the wait queue and wake up readers only if 
there is no more writers in the wait queue or even in the optimistic 
spinning queue. That should achieve the same effect as this patch.

Cheers,
Longman

