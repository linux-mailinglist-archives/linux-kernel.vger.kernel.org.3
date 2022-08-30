Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3518B5A5F57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiH3J0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiH3J0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:26:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB407C755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:26:15 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MH1zv5517z1N7dQ;
        Tue, 30 Aug 2022 17:22:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 17:26:13 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 17:26:13 +0800
Message-ID: <3ddec0af-c58a-518c-8156-4e111057e522@huawei.com>
Date:   Tue, 30 Aug 2022 17:26:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] mm: memory-failure: kill __soft_offline_page()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220819033402.156519-1-wangkefeng.wang@huawei.com>
 <20220819033402.156519-2-wangkefeng.wang@huawei.com>
 <20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/30 15:15, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, Aug 19, 2022 at 11:34:02AM +0800, Kefeng Wang wrote:
>> Squash the __soft_offline_page() into soft_offline_in_use_page() and
>> kill __soft_offline_page().
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   mm/memory-failure.c | 24 +++++++++---------------
>>   1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 1a7d6548ccb2..5b368124956d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2432,11 +2432,11 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
>>   }
>>   
>>   /*
>> - * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
>> + * soft_offline_in_use_page handles hugetlb-pages and non-hugetlb pages.
>>    * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
>>    * If the page is mapped, it migrates the contents over.
>>    */
>> -static int __soft_offline_page(struct page *page)
>> +static int soft_offline_in_use_page(struct page *page)
>>   {
>>   	long ret = 0;
>>   	unsigned long pfn = page_to_pfn(page);
>> @@ -2449,6 +2449,13 @@ static int __soft_offline_page(struct page *page)
>>   		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>>   	};
>>   
>> +	if (!huge && PageTransHuge(hpage)) {
>> +		if (try_to_split_thp_page(page)) {
>> +			pr_info("soft offline: %#lx: thp split failed\n", pfn);
>> +			return -EBUSY;
>> +		}
> I've found that this change causes a regression. After the thp is
> successfully split here, hpage no longer points to a proper page.
> So hpage should be updated to point to the raw error page.
>
> +		hpage = page;
Sorry for the regression,  will update.
>
> Could you update the patch?
>
> Thanks,
> Naoya Horiguchi
