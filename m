Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AB4DA26D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbiCOSeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiCOSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:34:08 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2312733
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:32:54 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43500)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUByW-004bza-N6; Tue, 15 Mar 2022 12:32:52 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37806 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUByV-00DZm9-EB; Tue, 15 Mar 2022 12:32:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
References: <20220314064039.62972-1-linmiaohe@huawei.com>
        <87h78036hl.fsf@email.froward.int.ebiederm.org>
        <82cf5aa8-a721-3ff3-7b09-54a66da0d506@huawei.com>
Date:   Tue, 15 Mar 2022 13:32:28 -0500
In-Reply-To: <82cf5aa8-a721-3ff3-7b09-54a66da0d506@huawei.com> (Miaohe Lin's
        message of "Tue, 15 Mar 2022 20:17:57 +0800")
Message-ID: <87lexbyslf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUByV-00DZm9-EB;;;mid=<87lexbyslf.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18FfFa8rTN4mQyugIlm4nCio3vDraMI37o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miaohe Lin <linmiaohe@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 714 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 13 (1.8%), b_tie_ro: 11 (1.5%), parse: 1.93
        (0.3%), extract_message_metadata: 18 (2.5%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-1000: 8 (1.1%), tests_pri_-950: 1.58 (0.2%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 268 (37.5%), check_bayes:
        261 (36.6%), b_tokenize: 12 (1.6%), b_tok_get_all: 9 (1.3%),
        b_comp_prob: 3.3 (0.5%), b_tok_touch_all: 232 (32.5%), b_finish: 1.26
        (0.2%), tests_pri_0: 382 (53.5%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 3.4 (0.5%), poll_dns_idle: 0.91 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 13 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/3/14 23:21, Eric W. Biederman wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
>>> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
>>> this by resetting allowed to 0.
>> 
>> This fix looks correct.  But the ability for people to follow and read
>> the code seems questionable.  I saw in v1 of this patch Hugh originally
>> misread the logic.
>> 
>> Could we instead change the code to leave lock_limit at ULONG_MAX aka
>> RLIM_INFINITY, leave initialized to 0, and not even need a special case
>> of RLIM_INFINITY as nothing can be greater that ULONG_MAX?
>> 
>
> Many thanks for your advice. This looks good but it seems this results in different
> behavior: When (memlock == LONG_MAX) && !capable(CAP_IPC_LOCK), we would fail now
> while it will always success without this change. We should avoid this difference.
> Or am I miss something? Maybe the origin patch is more suitable and
> simple?

Interesting.  I think that is an unintended and necessary bug fix.

When memlock == LONG_MAX that means inc_rlimit_ucounts failed.

It either failed because at another level the limit was exceeded or
because the counter wrapped.  In either case it is not appropriate to
succeed if inc_rlimit_ucounts detects a failure.

Which is a long way of saying I think we really want the simplification
because it found and fixed another bug as well.

Without the simplification I don't think I will be confident the code is
correct.

Eric


> Thanks.
>
>> Something like this?
>> 
>> diff --git a/mm/mlock.c b/mm/mlock.c
>> index 8f584eddd305..e7eabf5193ab 100644
>> --- a/mm/mlock.c
>> +++ b/mm/mlock.c
>> @@ -827,13 +827,12 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>  
>>  	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>  	lock_limit = rlimit(RLIMIT_MEMLOCK);
>> -	if (lock_limit == RLIM_INFINITY)
>> -		allowed = 1;
>> -	lock_limit >>= PAGE_SHIFT;
>> +	if (lock_limit != RLIM_INFINITY)
>> +		lock_limit >>= PAGE_SHIFT;
>>  	spin_lock(&shmlock_user_lock);
>>  	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>  
>> -	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>> +	if ((memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>  		goto out;
>>  	}
>> 
>>>
>>> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Acked-by: Hugh Dickins <hughd@google.com>
>>> ---
>>> v1->v2:
>>>   correct Fixes tag and collect Acked-by tag
>>>   Thanks Hugh for review!
>>> ---
>>>  mm/mlock.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>> index 29372c0eebe5..efd2dd2943de 100644
>>> --- a/mm/mlock.c
>>> +++ b/mm/mlock.c
>>> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>>  	}
>>>  	if (!get_ucounts(ucounts)) {
>>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>> +		allowed = 0;
>>>  		goto out;
>>>  	}
>>>  	allowed = 1;
>> 
>> Eric
>> .
>> 
