Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5954D79C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiCNDvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiCNDux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:50:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F42201B0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 20:49:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KH2V66tjbz1GCQ6;
        Mon, 14 Mar 2022 11:44:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 11:49:41 +0800
Subject: Re: [PATCH] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <Herbert.van.den.Bergh@oracle.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220310132417.41189-1-linmiaohe@huawei.com>
 <268b3146-2963-15b6-6d6-95a96853314@google.com>
 <bcfc2048-93ce-b357-8671-7070614db36a@huawei.com>
 <1e758c8f-c87b-50ef-52db-942c8a86a32a@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <291c20b2-0559-5226-0718-2d7bb1571079@huawei.com>
Date:   Mon, 14 Mar 2022 11:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1e758c8f-c87b-50ef-52db-942c8a86a32a@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/14 11:11, Hugh Dickins wrote:
> On Mon, 14 Mar 2022, Miaohe Lin wrote:
>> On 2022/3/14 10:40, Hugh Dickins wrote:
>>> On Thu, 10 Mar 2022, Miaohe Lin wrote:
>>>
>>>> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
>>>> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
>>>> this by resetting allowed to 0.
>>>>
>>>> Fixes: 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>> NAK.  user_shm_lock() remembers to declare "int allowed = 0" on entry.
>>>
>>
>> If lock_limit is RLIM_INFINITY, "allowed" will be set to 1. And if get_ucounts fails
>> in some corner cases, "allowed" will remain to be 1 while the user_shm_lock ops indeed
>> fails. Or am I miss something?
> 
> You are right, I am wrong: sorry.
> Thanks for pointing now to that RLIM_INFINITY case.
> 
> But then the Fixes tag is wrong: it should be
> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
>        which introduced the possibility of error down there.
> 

You're right. commit 5ed44a401ddf ("do not limit locked memory when RLIMIT_MEMLOCK is RLIM_INFINITY")
introduced RLIM_INFINITY and set "allowed" to 1 but there is no possibility of error down there.
Will change this in V2.

> With that,
> Acked-by: Hugh Dickins <hughd@google.com>

Many thanks!

> 
>>
>> Many thanks for comment.
>>
>>>> ---
>>>>  mm/mlock.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/mm/mlock.c b/mm/mlock.c
>>>> index 29372c0eebe5..efd2dd2943de 100644
>>>> --- a/mm/mlock.c
>>>> +++ b/mm/mlock.c
>>>> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>>>>  	}
>>>>  	if (!get_ucounts(ucounts)) {
>>>>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
>>>> +		allowed = 0;
>>>>  		goto out;
>>>>  	}
>>>>  	allowed = 1;
>>>> -- 
>>>> 2.23.0
> .
> 

