Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623375080E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350565AbiDTGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350332AbiDTGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:17:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EA0B40
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:15:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjqzL1PVlzCrZ3;
        Wed, 20 Apr 2022 14:10:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:15:02 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <david@redhat.com>, <surenb@google.com>, <minchan@kernel.org>,
        <peterx@redhat.com>, <sfr@canb.auug.org.au>,
        <rcampbell@nvidia.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal> <87r15tjy76.fsf@nvdebian.thelocal>
 <e320fb01-7d53-668e-53b5-463312ae0909@huawei.com>
 <87k0bkk2rp.fsf@nvdebian.thelocal>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6cf3726c-d6d0-4255-2deb-3688227c633e@huawei.com>
Date:   Wed, 20 Apr 2022 14:15:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87k0bkk2rp.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/20 8:25, Alistair Popple wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/4/19 15:53, Alistair Popple wrote:
>>> Also in madvise_free_pte_range() you could just remove the swap entry as it's no
>>> longer needed.
>>>
>>
>> This swap entry will be removed in madvise_dontneed_single_vma().
>> And in madvise_free_pte_range(), we may need to keep it as same as
>> hwpoison entry. Or am I supposed to remove it even if hwpoison entry
>> is reused later?
> 
> Why would we need to keep it for MADV_FREE though? It only works on private
> anonymous memory, and once the MADV_FREE operation has succeeded callers can
> expect they might get zero-fill pages if accessing the memory again. Therefore
> it should be safe to delete the entry. I think that applies equally to a
> hwpoison entry too - there's no reason to kill the process if it has called
> MADV_FREE on the range.

I tend to agree. We can drop the swapin error entry and hwpoison entry when MADV_FREE
is called. Should I squash these into the current patch or a separate one is preferred?

Thanks for your suggestion!

> 
>>
>> Thanks!
>>
>>> Alistair Popple <apopple@nvidia.com> writes:
>>>
>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>>
>> ...

