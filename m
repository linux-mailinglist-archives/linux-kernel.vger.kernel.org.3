Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1E577BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiGRGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRGtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:49:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BD3886
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:49:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LmXZ52934zjX3l;
        Mon, 18 Jul 2022 14:46:53 +0800 (CST)
Received: from [10.174.178.157] (10.174.178.157) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 14:49:34 +0800
Message-ID: <9a4e42af-a354-2947-5088-436df2b4cc9f@huawei.com>
Date:   Mon, 18 Jul 2022 14:49:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/huge_memory: Return from zap_huge_pmd after WARN_ONCE.
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <zi.yan@cs.rutgers.edu>
References: <20220715092238.22663-1-zhouguanghui1@huawei.com>
 <YtGo7GS5l4WxZA/R@casper.infradead.org>
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
In-Reply-To: <YtGo7GS5l4WxZA/R@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/16 1:50, Matthew Wilcox wrote:
> On Fri, Jul 15, 2022 at 09:22:38AM +0000, Zhou Guanghui wrote:
>> After WARN_ONCE is processed, the subsequent page judgment results
>> in NULL pointer access. It is more reasonable to return from the
>> function here.
> 
> I'm not sure this is a good idea.  Probably better to crash than
> continue.

Except present pmd and pmd migration entry, there should be no other possible scenarios. Whether crash or warn is unnecessary. However, the current process that crashes after a warning is reported is not reasonable.

Like this:
if (pmd_present(orig_pmd)) {
	xxx
} else {
	swp_entry_t entry;

	VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
	entry = pmd_to_swp_entry(orig_pmd);
	page = pfn_to_page(swp_offset(entry));
	flush_needed = 0;
}

Thanks.

> 
>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>> ---
>>  mm/huge_memory.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 834f288b3769..7f5ccca6792a 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1601,8 +1601,11 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  			entry = pmd_to_swp_entry(orig_pmd);
>>  			page = pfn_swap_entry_to_page(entry);
>>  			flush_needed = 0;
>> -		} else
>> +		} else {
>> +			spin_unlock(ptl);
>>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>> +			return 1;
>> +		}
>>  
>>  		if (PageAnon(page)) {
>>  			zap_deposited_table(tlb->mm, pmd);
>> -- 
>> 2.17.1
>>
>>
> 
> .
