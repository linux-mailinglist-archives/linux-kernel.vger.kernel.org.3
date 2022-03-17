Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4408A4DC2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiCQJf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiCQJfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:35:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32C49690
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:34:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK21v0TQRz9sgy;
        Thu, 17 Mar 2022 17:30:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 17:34:32 +0800
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <kosaki.motohiro@jp.fujitsu.com>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
 <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
 <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
 <YjCwYpTbGzAj9kmg@dhcp22.suse.cz>
 <24b2a9ef-eea0-09bd-6842-121d8436e56a@huawei.com>
 <YjG0PsF25wpAEOY3@dhcp22.suse.cz>
 <6ebebfd6-6356-e956-4fbc-0abaa58308ff@huawei.com>
 <YjL5Y6ZrZ2eLnnTv@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <207bbd69-6678-5120-3760-e2bcd9803a14@huawei.com>
Date:   Thu, 17 Mar 2022 17:34:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YjL5Y6ZrZ2eLnnTv@dhcp22.suse.cz>
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

On 2022/3/17 17:03, Michal Hocko wrote:
> On Thu 17-03-22 10:05:08, Miaohe Lin wrote:
>> On 2022/3/16 17:56, Michal Hocko wrote:
>>> On Wed 16-03-22 14:39:37, Miaohe Lin wrote:
>>>> On 2022/3/15 23:27, Michal Hocko wrote:
>>>>> On Tue 15-03-22 21:42:29, Miaohe Lin wrote:
>>>>>> On 2022/3/15 0:44, Michal Hocko wrote:
>>>>>>> On Fri 11-03-22 17:36:24, Miaohe Lin wrote:
>>>>>>>> If mpol_new is allocated but not used in restart loop, mpol_new will be
>>>>>>>> freed via mpol_put before returning to the caller. But refcnt is not
>>>>>>>> initialized yet, so mpol_put could not do the right things and might
>>>>>>>> leak the unused mpol_new.
>>>>>>>
>>>>>>> The code is really hideous but is there really any bug there? AFAICS the
>>>>>>> new policy is only allocated in if (n->end > end) branch and that one
>>>>>>> will set the reference count on the retry. Or am I missing something?
>>>>>>>
>>>>>>
>>>>>> Many thanks for your comment.
>>>>>> IIUC, new policy is allocated via the below code:
>>>>>>
>>>>>> shared_policy_replace:
>>>>>> 	alloc_new:
>>>>>> 		write_unlock(&sp->lock);
>>>>>> 		ret = -ENOMEM;
>>>>>> 		n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
>>>>>> 		if (!n_new)
>>>>>> 			goto err_out;
>>>>>> 		mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>>>>>> 		if (!mpol_new)
>>>>>> 			goto err_out;
>>>>>> 		goto restart;
>>>>>>
>>>>>> And mpol_new' reference count will be set before used in n->end > end case. But
>>>>>> if that is "not" the case, i.e. mpol_new is not inserted into the rb_tree, mpol_new
>>>>>> will be freed via mpol_put before return:
>>>>>
>>>>> One thing I have missed previously is that the lock is dropped during
>>>>> the allocation so I guess the memory policy could have been changed
>>>>> during that time. Is this possible? Have you explored this possibility?
>>>>> Is this a theoretical problem or it can be triggered intentionally.
>>>>>
>>>>
>>>> This is found via code investigation. I think this could be triggered if there
>>>> are many concurrent mpol_set_shared_policy in place. But the user-visible effect
>>>> might be obscure as only sizeof(struct mempolicy) bytes leaks possiblely every time.
>>>>
>>>>> These details would be really interesting for the changelog so that we
>>>>> can judge how important this would be.
>>>>
>>>> This might not be that important as this issue should have been well-concealed for
>>>> almost ten years (since commit 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")).
>>>
>>> I think it is really worth to drill down to the bottom of the issue.
>>> While theoretically possible can be a good enough to justify the change
>>> it is usually preferred to describe the underlying problem for future
>>> maintainability. 
>>
>> This issue mainly causes mpol_new memory leaks and this is pointed out in the commit log.
>> Am I supposed to do something more to move forward this patch ? Could you point that out
>> for me?
> 
> Sorry if I was not really clear. My main request is to have a clear
> insight whether this is a theretical issue or the leak could be really
> triggered. If the later we need to mark it properly and backport to
> older kernels because memory leaks can lead to DoS when they are
> reasonably easy to trigger.
> 
> Is this more clear now?

I see. Many thanks. I would have a try to trigger this. :)

> 

