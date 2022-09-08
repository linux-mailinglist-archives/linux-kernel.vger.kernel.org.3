Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F135B1254
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIHCEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHCE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:04:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D91134
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:04:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNMnv02qvzHnbw;
        Thu,  8 Sep 2022 10:02:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 10:04:21 +0800
Subject: Re: [PATCH 6/8] hugetlb: add vma based lock for pmd sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-7-mike.kravetz@oracle.com>
 <47cc90bf-d616-5004-555d-b3d7e9b09bd1@huawei.com> <Yw08j5m62is7kqSg@monkey>
 <YxkEJhTzglEfo+Tp@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a4b3ff7-a25f-d1c2-0300-c28c8577eae7@huawei.com>
Date:   Thu, 8 Sep 2022 10:04:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YxkEJhTzglEfo+Tp@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/8 4:50, Mike Kravetz wrote:
> On 08/29/22 15:24, Mike Kravetz wrote:
>> On 08/27/22 17:30, Miaohe Lin wrote:
>>> On 2022/8/25 1:57, Mike Kravetz wrote:
>>>> Allocate a rw semaphore and hang off vm_private_data for
>>>> synchronization use by vmas that could be involved in pmd sharing.  Only
>>>> add infrastructure for the new lock here.  Actual use will be added in
>>>> subsequent patch.
>>>>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>
>>> <snip>
>>>
>>>> +static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>>>> +{
>>>> +	/*
>>>> +	 * Only present in sharable vmas.  See comment in
>>>> +	 * __unmap_hugepage_range_final about the neeed to check both
>>>
>>> s/neeed/need/
>>>
>>>> +	 * VM_SHARED and VM_MAYSHARE in free path
>>>
>>> I think there might be some wrong checks around this patch. As above comment said, we
>>> need to check both flags, so we should do something like below instead?
>>>
>>> 	if (!(vma->vm_flags & (VM_MAYSHARE | VM_SHARED) == (VM_MAYSHARE | VM_SHARED)))
>>>
>>>> +	 */
>>
>> Thanks.  I will update.
>>
>>>> +	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
>>>> +		return;
> 
> I think you misunderstood the comment which I admit was not very clear.  And,
> I misunderstood your suggestion.  I believe the code is correct as it.  Here
> is the proposed update comment/code:
> 
> 	/*
> 	 * Only present in sharable vmas.  See comment in
> 	 * __unmap_hugepage_range_final about how VM_SHARED could
> 	 * be set without VM_MAYSHARE.  As a result, we need to
> 	 * check if either is set in the free path.
> 	 */
> 	if (!vma || !(vma->vm_flags & (VM_MAYSHARE | VM_SHARED)))
> 		return;
> 
> Hopefully, that makes more sense.

Somewhat confusing. Thanks for clarifying, Mike.

Thanks,
Miaohe Lin

