Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC3482D90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiACCfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 21:35:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229647AbiACCf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 21:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641177328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFOXzREcf/RQoYNbR4RTXyttiXsYe3f0oGTWtZ8iKMU=;
        b=HPY/6KETuYv5dGaFqz18UXXGygI6dSpwD+JET40cg1LZ6vAS9noE6pI9BOq8kQyGUtr5zz
        HOi3cxfBLVg/NV/kSx0+khirP/AjUCCjZKI4cw6gHWU35KfvonLuWf8dhE9iAjXMTQzPZ8
        UfFTUw6bmqi2ldiNWVEsa3zOyotMH+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-VAn2OO2dPSiZ_nj2TikPhg-1; Sun, 02 Jan 2022 21:35:25 -0500
X-MC-Unique: VAn2OO2dPSiZ_nj2TikPhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AFDB801ADB;
        Mon,  3 Jan 2022 02:35:24 +0000 (UTC)
Received: from [10.22.16.91] (unknown [10.22.16.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FD2310246F1;
        Mon,  3 Jan 2022 02:35:23 +0000 (UTC)
Message-ID: <41f2809e-459c-a179-b5b1-62d5a0821574@redhat.com>
Date:   Sun, 2 Jan 2022 21:35:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [lockdep] UAF read in print_name().
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp>
 <015af849-3571-e9ac-692f-d803aa19f566@redhat.com>
 <f80074eb-58bc-7db7-d945-ef18f7617c4e@i-love.sakura.ne.jp>
 <843bffdd-6c5b-2869-e089-01d180f36a76@redhat.com>
In-Reply-To: <843bffdd-6c5b-2869-e089-01d180f36a76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/22 13:02, Waiman Long wrote:
> On 12/30/21 10:09, Tetsuo Handa wrote:
>> On 2021/12/29 12:25, Waiman Long wrote:
>>> On 12/28/21 05:49, Tetsuo Handa wrote:
>>>> Hello.
>>>>
>>>> I found using linux-next-20211210 that reading /proc/lockdep after 
>>>> lockdep splat
>>>> triggers UAF read access. I think this is a side effect of zapping 
>>>> dependency
>>>> information when loop driver's WQ is destroyed. You might want to 
>>>> xchg() the pointer
>>>> with a dummy struct containing a static string.
>>>>
>>>> difference before lockdep splat and after lockdep splat
>>>> ----------------------------------------
>>>> 8635c8636
>>>> < ffff88811561cd28 OPS:      26 FD:  122 BD:    1 +.+.: 
>>>> (wq_completion)loop0
>>>> ---
>>>>> ffff88811561cd28 OPS:      31 FD: 439 BD:    1 +.+.:  
>>>>> M>^MM-^AM-^HM-^?M-^?
>>> Thanks for reporting.
>>>
>>> Yes, listing locking classes by /proc/lockdep is racy as 
>>> all_lock_classes is accessed
>>> without lock protection. OTOH, we probably can't fix this race as 
>>> lock hold time will be
>>> too long for this case. Atomically xchg the class name is a possible 
>>> workaround, but we
>>> also need to add additional checks as the iteration may also be 
>>> redirected to
>>> free_lock_classes leading to an endless iteration loop.
>> Thanks for responding. But is this bug really unfixable?
> I am not saying that it is unfixable. I am just saying that we cannot 
> guarantee a consistent output of /proc/lockdep as internal data may 
> change in the middle of dumping the output.
>>
>> Please see the following result.
>>
>> ----------------------------------------
>> [root@localhost ~]# uname -r
>> 5.16.0-rc4-next-20211210
>> [root@localhost ~]# grep loop /proc/lockdep
>> [root@localhost ~]# truncate -s 100m testfile
>> [root@localhost ~]# losetup -f testfile
>> [root@localhost ~]# grep loop /proc/lockdep
>> ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
>> ffff888106fb0528 OPS:     114 FD:  183 BD:    1 +.+.: 
>> (wq_completion)loop0
>> [root@localhost ~]# losetup -D
>> [root@localhost ~]# grep loop /proc/lockdep
>> ffffffffa02b73c8 OPS:      17 FD:   34 BD:    1 +.+.: loop_ctl_mutex
>> ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: 
>> loop_validate_mutex
>> [root@localhost ~]# losetup -f testfile
>> [root@localhost ~]# grep loop /proc/lockdep
>> ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
>> ffffffffa02b7328 OPS:       1 FD:    1 BD:    1 +.+.: 
>> loop_validate_mutex
>> ffff888106fb1128 OPS:     118 FD:  183 BD:    1 +.+.: 
>> (wq_completion)loop0
>> [root@localhost ~]# losetup -D
>> [root@localhost ~]# grep loop /proc/lockdep
>> ffffffffa02b73c8 OPS:      18 FD:   34 BD:    1 +.+.: loop_ctl_mutex
>> ffffffffa02b7328 OPS:       2 FD:    1 BD:    1 +.+.: 
>> loop_validate_mutex
>> [root@localhost ~]# grep debug_locks /proc/lockdep_stats
>>   debug_locks:                             1
>> [root@localhost ~]#
>> ----------------------------------------
>>
>> We can confirm that the "(wq_completion)loop0" entry disappears when 
>> WQ for /dev/loop0 is destroyed.
>>
>> Then, please see the following reproducer for this lockdep problem. 
>> As you can see, there is 10
>> seconds between lockdep complained and /proc/lockdep is read. 10 
>> seconds should be enough time
>> for erasing the "(wq_completion)loop0" entry.
>
> Thanks for the reproducer.

Your reproducer can always reproduce the problem. It turns out that it 
is not really a race condition. The UAF problem is caused by the failure 
of lockdep to properly zap the "(wq_completion)loop0" lock class. I am 
going to send out a patch to address this bug.

Cheers,
Longman

