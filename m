Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B612546671B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359197AbhLBPuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245536AbhLBPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638460026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QXpG/U1Vsg/4uKa21qXS5jgoVnEShvvUuealgGuJJw=;
        b=g7nMqNmk5NwC55+LfY06dU281dleCQtD1KQmFyjct+1vt6juupKBXLY2iovwUTER5i+O5F
        PbtvQZ6D6lNLedryOckV1GQyvYHVIzk5pgVJ1lhl2KBY2Lc2BnGr2j55UTkk82bFJs4OuZ
        G//zb99vcdN92ZP6oqAmP/zTwXBiYCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-hQDi2Ru_MfqdMskLlbh9bg-1; Thu, 02 Dec 2021 10:46:59 -0500
X-MC-Unique: hQDi2Ru_MfqdMskLlbh9bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9350780A1BF;
        Thu,  2 Dec 2021 15:46:54 +0000 (UTC)
Received: from [10.22.18.96] (unknown [10.22.18.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C2E35D9D5;
        Thu,  2 Dec 2021 15:46:53 +0000 (UTC)
Message-ID: <2f67a2d9-98d6-eabd-fb5e-4c89574ce52c@redhat.com>
Date:   Thu, 2 Dec 2021 10:46:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] locking/mutex: Mark racy reads of owner->on_cpu
Content-Language: en-US
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kasan-dev@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20211202101238.33546-1-elver@google.com>
 <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CANpmjNMvPepakONMjTO=FzzeEtvq_CLjPN6=zF35j10rVrJ9Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 06:53, Marco Elver wrote:
> On Thu, 2 Dec 2021 at 11:13, Marco Elver <elver@google.com> wrote:
>> One of the more frequent data races reported by KCSAN is the racy read
>> in mutex_spin_on_owner(), which is usually reported as "race of unknown
>> origin" without showing the writer. This is due to the racing write
>> occurring in kernel/sched. Locally enabling KCSAN in kernel/sched shows:
>>
>>   | write (marked) to 0xffff97f205079934 of 4 bytes by task 316 on cpu 6:
>>   |  finish_task                kernel/sched/core.c:4632 [inline]
>>   |  finish_task_switch         kernel/sched/core.c:4848
>>   |  context_switch             kernel/sched/core.c:4975 [inline]
>>   |  __schedule                 kernel/sched/core.c:6253
>>   |  schedule                   kernel/sched/core.c:6326
>>   |  schedule_preempt_disabled  kernel/sched/core.c:6385
>>   |  __mutex_lock_common        kernel/locking/mutex.c:680
>>   |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
>>   |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
>>   |  mutex_lock                 kernel/locking/mutex.c:283
>>   |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
>>   |  ...
>>   |
>>   | read to 0xffff97f205079934 of 4 bytes by task 322 on cpu 3:
>>   |  mutex_spin_on_owner        kernel/locking/mutex.c:370
>>   |  mutex_optimistic_spin      kernel/locking/mutex.c:480
>>   |  __mutex_lock_common        kernel/locking/mutex.c:610
>>   |  __mutex_lock               kernel/locking/mutex.c:740 [inline]
>>   |  __mutex_lock_slowpath      kernel/locking/mutex.c:1028
>>   |  mutex_lock                 kernel/locking/mutex.c:283
>>   |  tty_open_by_driver         drivers/tty/tty_io.c:2062 [inline]
>>   |  ...
>>   |
>>   | value changed: 0x00000001 -> 0x00000000
>>
>> This race is clearly intentional, and the potential for miscompilation
>> is slim due to surrounding barrier() and cpu_relax(), and the value
>> being used as a boolean.
>>
>> Nevertheless, marking this reader would more clearly denote intent and
>> make it obvious that concurrency is expected. Use READ_ONCE() to avoid
>> having to reason about compiler optimizations now and in future.
>>
>> Similarly, mark the read to owner->on_cpu in mutex_can_spin_on_owner(),
>> which immediately precedes the loop executing mutex_spin_on_owner().
>>
>> Signed-off-by: Marco Elver <elver@google.com>
> [...]
>
> Kefeng kindly pointed out that there is an alternative, which would
> refactor owner_on_cpu() from rwsem that would address both mutex and
> rwsem:
> https://lore.kernel.org/all/b641f1ea-6def-0fe4-d273-03c35c4aa7d6@huawei.com/
>
> Preferences?

I would like to see owner_on_cpu() extracted out from 
kernel/locking/rwsem.c into include/linux/sched.h right after 
vcpu_is_preempted(), for instance, and with READ_ONCE() added. Then it 
can be used in mutex.c as well. This problem is common to both mutex and 
rwsem.

Cheers,
Longman

Thanks,
-- Marco

