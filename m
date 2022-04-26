Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB051510A53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355005AbiDZUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354931AbiDZUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7361C25EBD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651004492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmLzEVWrBDCrxfyFD58JArlc8gsPQQZmV7OPlHR0Cfc=;
        b=XU5oCaCYwdplyTtdPLPQ877rx7h+JA4XgDioFxSuRrDCOophZY0D8kVrW9h8kpke0PFy0J
        ktiGvzyhTnK7OSUJFbWmrRSrUcbMJOHUjkusN2eeSaMmxfEcLsUslfztk2i0U7uaNbY6dL
        9LS9OT1cJEdpdF9tJLRJxfMBHFTmw2A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-c0p56BeQNjO-iboOrlJzvA-1; Tue, 26 Apr 2022 16:21:27 -0400
X-MC-Unique: c0p56BeQNjO-iboOrlJzvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B521299E762;
        Tue, 26 Apr 2022 20:21:26 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19DB914682C3;
        Tue, 26 Apr 2022 20:21:26 +0000 (UTC)
Message-ID: <020aef66-6911-77e7-fd1a-25506dfcd3df@redhat.com>
Date:   Tue, 26 Apr 2022 16:21:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     john.p.donnelly@oracle.com,
        chenguanyou <chenguanyou9338@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org, sashal@kernel.org
References: <20211116012912.723980-1-longman@redhat.com>
 <20220214154741.12399-1-chenguanyou@xiaomi.com>
 <3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com>
 <e873727e-22db-3330-015d-bd6581a2937a@redhat.com>
 <31178c33-e25c-c3e8-35e2-776b5211200c@oracle.com>
 <161c2e25-3d26-4dd7-d378-d1741f7bcca8@redhat.com>
 <2b6ed542-b3e0-1a87-33ac-d52fc0e0339c@oracle.com>
 <eae41639-cbca-4ea6-417f-f9b34a7138ea@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <eae41639-cbca-4ea6-417f-f9b34a7138ea@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 09:55, john.p.donnelly@oracle.com wrote:
> On 4/12/22 11:28 AM, john.p.donnelly@oracle.com wrote:
>> On 4/11/22 4:07 PM, Waiman Long wrote:
>>>
>>> On 4/11/22 17:03, john.p.donnelly@oracle.com wrote:
>>>>
>>>>>>
>>>>>> I have reached out to Waiman and he suggested this for our next 
>>>>>> test pass:
>>>>>>
>>>>>>
>>>>>> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>>>>>> out_nolock path
>>>>>
>>>>> Does this commit help to avoid the lockup problem?
>>>>>
>>>>> Commit 1ee326196c6658 fixes a potential missed wakeup problem when 
>>>>> a reader first in the wait queue is interrupted out without 
>>>>> acquiring the lock. It is actually not a fix for commit 
>>>>> d257cc8cb8d5. However, this commit changes the out_nolock path 
>>>>> behavior of writers by leaving the handoff bit set when the wait 
>>>>> queue isn't empty. That likely makes the missed wakeup problem 
>>>>> easier to reproduce.
>>>>>
>>>>> Cheers,
>>>>> Longman
>>>>>
>>>>
>>>> Hi,
>>>>
>>>>
>>>> We are testing now
>>>>
>>>> ETA for fio soak test completion is  ~15hr from now.
>>>>
>>>> I wanted to share the stack traces for future reference + occurrences.
>>>>
>>> I am looking forward to your testing results tomorrow.
>>>
>>> Cheers,
>>> Longman
>>>
>> Hi
>>
>>   Our 24hr fio soak test with :
>>
>>   1ee326196c6658 locking/rwsem: Always try to wake waiters in 
>> out_nolock path
>>
>>
>>   applied to 5.15.30  passed.
>>
>>   I suggest you append  1ee326196c6658 with :
>>
>>
>>   cc: stable
>>
>>    Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling 
>> more consistent")
>>
>>
>> I'll leave the implementation details up to the core maintainers how 
>> to do that ;-)
>>
>> ...
>>
>> Thank you
>>
>> John.
>
> Hi ,
>
>
>  We have observed another panic with :
>
>  1ee326196c6658 locking/rwsem: Always try to wake waiters in out_nolock
>  path
>
>  Applied to 5.15.30 :
>
>
Sorry for the late reply as I was busy with other important tasks.

When you said panic, you mean a system hang, not an actual panic. Right?


> PID: 3789   TASK: ffff900fc409b300  CPU: 29  COMMAND: "dio/dm-0"
>  #0 [fffffe00006bce50] crash_nmi_callback at ffffffff97c772c3
>  #1 [fffffe00006bce58] nmi_handle at ffffffff97c40778
>  #2 [fffffe00006bcea0] default_do_nmi at ffffffff988161e2
>  #3 [fffffe00006bcec8] exc_nmi at ffffffff9881648d
>  #4 [fffffe00006bcef0] end_repeat_nmi at ffffffff98a0153b
>     [exception RIP: _raw_spin_lock_irq+35]
>     RIP: ffffffff98827333  RSP: ffffa9320917fc78  RFLAGS: 00000046
>     RAX: 0000000000000000  RBX: ffff900fc409b300  RCX: 0000000000000000
>     RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
>     RBP: ffffa9320917fd20   R8: 0000000000000000   R9: 0000000000000000
>     R10: 0000000000000000  R11: 0000000000000000  R12: ffff90006259546c
>     R13: ffffa9320917fcb0  R14: ffff900062595458  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #5 [ffffa9320917fc78] _raw_spin_lock_irq at ffffffff98827333
>  #6 [ffffa9320917fc78] rwsem_down_write_slowpath at ffffffff97d25d49
>  #7 [ffffa9320917fd28] ext4_map_blocks at ffffffffc104b6dc [ext4]
>  #8 [ffffa9320917fd98] ext4_convert_unwritten_extents at 
> ffffffffc10369e0 [ext4]
>  #9 [ffffa9320917fdf0] ext4_dio_write_end_io at ffffffffc103b2aa [ext4]
> #10 [ffffa9320917fe18] iomap_dio_complete at ffffffff98013f45
> #11 [ffffa9320917fe48] iomap_dio_complete_work at ffffffff98014047
> #12 [ffffa9320917fe60] process_one_work at ffffffff97cd9191
> #13 [ffffa9320917fea8] rescuer_thread at ffffffff97cd991b
> #14 [ffffa9320917ff10] kthread at ffffffff97ce11f7
> #15 [ffffa9320917ff50] ret_from_fork at ffffffff97c04cf2
> crash>
>
>
> The failure is observed running "fio test suite"  as a 24 hour soak 
> test  on an LVM composed of four NVME devices, Intel 72 core server. 
> The test cycles through a variety of file-system types.
>
>
> This kernel has these commits
>
> 1ee326196c6658 locking/rwsem: Always try to wake waiters in 
> out_nolock  path
>
> d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
>
> In earlier testing I had reverted d257cc8cb8d5 and did not observe 
> said panics.  I still feel d257cc8cb8d5 is  still the root cause.

So it is possible that 1ee326196c6658 does not completely eliminate the 
missed wakeup situation.

Regards,
Longman

