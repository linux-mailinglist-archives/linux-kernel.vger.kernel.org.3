Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE350838C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbiDTIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbiDTIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:39:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7452A242
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:37:07 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kjv7D3rd1zCrbG;
        Wed, 20 Apr 2022 16:32:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 16:37:05 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <surenb@google.com>, <minchan@kernel.org>, <peterx@redhat.com>,
        <sfr@canb.auug.org.au>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal> <87r15tjy76.fsf@nvdebian.thelocal>
 <e320fb01-7d53-668e-53b5-463312ae0909@huawei.com>
 <87k0bkk2rp.fsf@nvdebian.thelocal>
 <6cf3726c-d6d0-4255-2deb-3688227c633e@huawei.com>
 <e2352989-959d-2969-40e4-2d92eb8a5f9b@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4d14dcfc-0053-bfd6-433e-f264d22069d0@huawei.com>
Date:   Wed, 20 Apr 2022 16:37:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e2352989-959d-2969-40e4-2d92eb8a5f9b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/20 15:07, David Hildenbrand wrote:
> On 20.04.22 08:15, Miaohe Lin wrote:
>> On 2022/4/20 8:25, Alistair Popple wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> On 2022/4/19 15:53, Alistair Popple wrote:
>>>>> Also in madvise_free_pte_range() you could just remove the swap entry as it's no
>>>>> longer needed.
>>>>>
>>>>
>>>> This swap entry will be removed in madvise_dontneed_single_vma().
>>>> And in madvise_free_pte_range(), we may need to keep it as same as
>>>> hwpoison entry. Or am I supposed to remove it even if hwpoison entry
>>>> is reused later?
>>>
>>> Why would we need to keep it for MADV_FREE though? It only works on private
>>> anonymous memory, and once the MADV_FREE operation has succeeded callers can
>>> expect they might get zero-fill pages if accessing the memory again. Therefore
>>> it should be safe to delete the entry. I think that applies equally to a
>>> hwpoison entry too - there's no reason to kill the process if it has called
>>> MADV_FREE on the range.
>>
>> I tend to agree. We can drop the swapin error entry and hwpoison entry when MADV_FREE
>> is called. Should I squash these into the current patch or a separate one is preferred?
>>
> 
> That should go into a separate patch.

Will do. Many thanks for your suggestion.

> 

