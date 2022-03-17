Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7B4DBCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358373AbiCQBva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiCQBv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:51:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B0C15A05
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:50:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJqmq1CjZzfYqR;
        Thu, 17 Mar 2022 09:48:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:50:11 +0800
Subject: Re: [PATCH v2] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
References: <20220314064039.62972-1-linmiaohe@huawei.com>
 <87h78036hl.fsf@email.froward.int.ebiederm.org>
 <82cf5aa8-a721-3ff3-7b09-54a66da0d506@huawei.com>
 <87lexbyslf.fsf@email.froward.int.ebiederm.org>
 <4803adf1-ba98-badc-6820-0948871b0742@huawei.com>
 <87sfri3s32.fsf@email.froward.int.ebiederm.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bb5e67b5-0cf7-08b7-98ac-c49f468c8dec@huawei.com>
Date:   Thu, 17 Mar 2022 09:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87sfri3s32.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 22:11, Eric W. Biederman wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/3/16 2:32, Eric W. Biederman wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> On 2022/3/14 23:21, Eric W. Biederman wrote:
>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>>
>>>>>> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
>>>>>> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
>>>>>> this by resetting allowed to 0.
>>>>>
>>>>> This fix looks correct.  But the ability for people to follow and read
>>>>> the code seems questionable.  I saw in v1 of this patch Hugh originally
>>>>> misread the logic.
>>>>>
>>>>> Could we instead change the code to leave lock_limit at ULONG_MAX aka
>>>>> RLIM_INFINITY, leave initialized to 0, and not even need a special case
>>>>> of RLIM_INFINITY as nothing can be greater that ULONG_MAX?
>>>>>
>>>>
>>>> Many thanks for your advice. This looks good but it seems this results in different
>>>> behavior: When (memlock == LONG_MAX) && !capable(CAP_IPC_LOCK), we would fail now
>>>> while it will always success without this change. We should avoid this difference.
>>>> Or am I miss something? Maybe the origin patch is more suitable and
>>>> simple?
>>>
>>> Interesting.  I think that is an unintended and necessary bug fix.
>>>
>>> When memlock == LONG_MAX that means inc_rlimit_ucounts failed.
>>>
>>> It either failed because at another level the limit was exceeded or
>>> because the counter wrapped.  In either case it is not appropriate to
>>> succeed if inc_rlimit_ucounts detects a failure.
>>>
>>> Which is a long way of saying I think we really want the simplification
>>> because it found and fixed another bug as well.
>>>
>>> Without the simplification I don't think I will be confident the code is
>>> correct.
>>
>> Agree with you. This is a potential bug and you just catch it with the
>> code simplification. :)
>>
>> Am I supposed to do this altogether or will you do this simplification part?
>> Many thanks.
> 
> If you can that would be great, and you can have the credit.
> 
> Otherwise I will make my proposed changes into a proper patch.  At this
> point we just need to dot the i's and cross the t's and get this fix in.

I will try to do this. Many thanks!

> 
> Eric
> 
>>>>> Something like this?
>>>>>
>>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>>> index 8f584eddd305..e7eabf5193ab 100644
>>>>> --- a/mm/mlock.c
>>>>> +++ b/mm/mlock.c
>>>>> @@ -827,13 +827,12 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>>>>  
>>>>>  	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>>>  	lock_limit = rlimit(RLIMIT_MEMLOCK);
>>>>> -	if (lock_limit == RLIM_INFINITY)
>>>>> -		allowed = 1;
>>>>> -	lock_limit >>= PAGE_SHIFT;
>>>>> +	if (lock_limit != RLIM_INFINITY)
>>>>> +		lock_limit >>= PAGE_SHIFT;
>>>>>  	spin_lock(&shmlock_user_lock);
>>>>>  	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>>>>  
>>>>> -	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>>>>> +	if ((memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>>>>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>>>>  		goto out;
>>>>>  	}
>>>>>
>>>>>>
>>>>>> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>> Acked-by: Hugh Dickins <hughd@google.com>
>>>>>> ---
>>>>>> v1->v2:
>>>>>>   correct Fixes tag and collect Acked-by tag
>>>>>>   Thanks Hugh for review!
>>>>>> ---
>>>>>>  mm/mlock.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>>>> index 29372c0eebe5..efd2dd2943de 100644
>>>>>> --- a/mm/mlock.c
>>>>>> +++ b/mm/mlock.c
>>>>>> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>>>>>  	}
>>>>>>  	if (!get_ucounts(ucounts)) {
>>>>>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>>>>> +		allowed = 0;
>>>>>>  		goto out;
>>>>>>  	}
>>>>>>  	allowed = 1;
>>>>>
>>>>> Eric
>>>>> .
>>>>>
>>> .
>>>
> .
> 

