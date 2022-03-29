Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5744EA4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiC2CPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiC2CPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:15:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CE62DE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:13:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSCgM1bGYz9spN;
        Tue, 29 Mar 2022 10:09:35 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 10:13:36 +0800
Subject: Re: [PATCH v3] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <kosaki.motohiro@jp.fujitsu.com>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220322104345.36379-1-linmiaohe@huawei.com>
 <20220325172907.57dd381b746563be5dc77097@linux-foundation.org>
 <c8625168-4a40-1f6c-47b1-2c9194d3d4b3@huawei.com>
 <20220328142629.6ab7c5312d9ec154ccc502b2@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8575a7af-eacf-db06-4e48-b825f37575db@huawei.com>
Date:   Tue, 29 Mar 2022 10:13:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220328142629.6ab7c5312d9ec154ccc502b2@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/3/29 5:26, Andrew Morton wrote:
> On Sat, 26 Mar 2022 14:46:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2022/3/26 8:29, Andrew Morton wrote:
>>> On Tue, 22 Mar 2022 18:43:45 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>
>>>> If mpol_new is allocated but not used in restart loop, mpol_new will be
>>>> freed via mpol_put before returning to the caller.  But refcnt is not
>>>> initialized yet, so mpol_put could not do the right things and might leak
>>>> the unused mpol_new. This would happen if mempolicy was updated on the
>>>> shared shmem file while the sp->lock has been dropped during the memory
>>>> allocation.
>>>>
>>>> This issue could be triggered easily with the below code snippet if there
>>>> are many processes doing the below work at the same time:
>>>>
>>>>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>>>>   shm = shmat(shmid, 0, 0);
>>>>   loop many times {
>>>>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>>>>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
>>>>           maxnode, 0);
>>>>   }
>>>>
>>>> ...
>>>>
>>>> --- a/mm/mempolicy.c
>>>> +++ b/mm/mempolicy.c
>>>> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>>>>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>>>>  	if (!mpol_new)
>>>>  		goto err_out;
>>>> +	refcount_set(&mpol_new->refcnt, 1);
>>>>  	goto restart;
>>>>  }
>>>
>>> Two other sites in this file do
>>>
>>> 	atomic_set(&policy->refcnt, 1);
>>>
>>>
>>> Could we please instead have a little helper function which does the
>>> kmem_cache_alloc()+refcount_set()?> .
>>
>> There are usecases like below:
>>
>> 	struct mempolicy *new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>> 	*new = *old;
>> 	^^^^^^^^^^^^
>> 	refcount_set(&new->refcnt, 1);
>>
>> If we use helper function to do kmem_cache_alloc()+refcount_set() above, separate
>> refcount_set(&new->refcnt, 1) is still needed as old is copied to new and overwrites
>> the refcnt field. So that little helper function might not work. Or am I miss something?
>>
> 
> Hm, spose so.  I guess the helper doesn't add much in that case.
> 
> Can we please redo this on mainline?  I'm not happy with the bloat
> which refcnt_t adds and I think I'll drop
> mm-mempolicy-convert-from-atomic_t-to-refcount_t-on-mempolicy-refcnt.patch.

Will do this soon. Many thanks.

> .
> 

