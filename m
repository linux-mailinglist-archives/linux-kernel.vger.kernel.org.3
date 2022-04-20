Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E324A508101
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiDTGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiDTGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:24:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0DC3A197
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:21:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KjrBz4shRz1J9q9;
        Wed, 20 Apr 2022 14:20:43 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:21:27 +0800
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
To:     Peter Xu <peterx@redhat.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <david@redhat.com>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <sfr@canb.auug.org.au>,
        <rcampbell@nvidia.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <Yl8rZkhU/B0iE2ob@xz-m1.local>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8e01e276-c956-2486-c55f-c689f33a9106@huawei.com>
Date:   Wed, 20 Apr 2022 14:21:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yl8rZkhU/B0iE2ob@xz-m1.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/4/20 5:36, Peter Xu wrote:
> On Sat, Apr 16, 2022 at 11:05:49AM +0800, Miaohe Lin wrote:
>> @@ -1797,6 +1797,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>  		goto out;
>>  	}
>>  
>> +	if (unlikely(!PageUptodate(page))) {
>> +		pte_t pteval;
>> +
>> +		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>> +		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
>> +		set_pte_at(vma->vm_mm, addr, pte, pteval);
>> +		swap_free(entry);
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>>  	/* See do_swap_page() */
>>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
> 
> Totally off-topic, but.. today when I was looking at the unuse path I just
> found that the swp bits could have got lost for either soft-dirty and
> uffd-wp here?  A quick patch attached.

Am I supposed to test-and-send this patch? The patch looks good to me except the
build error pointed out by kernel test robot.

> 
> Maybe at some point we should start to have some special helpers for
> set_pte_at() when we're converting between present/non-present ptes, so as
> to make sure all these will always be taken care of properly.

That will be helpful. There are many places doing the similar thing.

> 

Thanks!
