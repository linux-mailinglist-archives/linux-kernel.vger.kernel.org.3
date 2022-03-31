Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A84ED7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiCaKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiCaKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:49:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1724204AA9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:47:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KTg2V57SQzgYDn;
        Thu, 31 Mar 2022 18:46:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 18:47:50 +0800
Subject: Re: [PATCH 2/8] mm/vmscan: remove unneeded can_split_huge_page check
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-3-linmiaohe@huawei.com>
 <877d8abjoj.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0e84a88d-b97e-6e3b-2d26-07b957d8bcdd@huawei.com>
Date:   Thu, 31 Mar 2022 18:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <877d8abjoj.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/3/31 16:38, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> can_split_huge_page is introduced via commit b8f593cd0896 ("mm, THP, swap:
>> check whether THP can be split firstly") to avoid deleting the THP from
>> the swap cache and freeing the swap cluster when the THP cannot be split.
>> But since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
>> swapped out"), splitting THP is delayed until THP is swapped out. There's
>> no need to delete the THP from the swap cache and free the swap cluster
>> anymore. Thus we can remove this unneeded can_split_huge_page check now to
>> simplify the code logic.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7c1a9713bfc9..09b452c4d256 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1691,9 +1691,6 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  				if (folio_maybe_dma_pinned(folio))
>>  					goto keep_locked;
>>  				if (PageTransHuge(page)) {
>> -					/* cannot split THP, skip it */
>> -					if (!can_split_folio(folio, NULL))
>> -						goto activate_locked;
>>  					/*
>>  					 * Split pages without a PMD map right
>>  					 * away. Chances are some or all of the
> 
> I'm OK with the change itself.  But THP still needs to be split after
> being swapped out.  The reason we don't need to check can_split_folio()

Could you please explain the relevant code path more detailed slightly?
IIUC, if THP is swapped out, it will be freed via destroy_compound_page
after __remove_mapping in shrink_page_list. So THP can be freed without
split. Or am I miss something ?

> is that folio_maybe_dma_pinned() is checked before.  Which will avoid
> the long term pinned pages to be swapped out.  And we can live with
> short term pinned pages.  Without can_split_folio() checking we can
> simplify the code as follows,
> 
> 	/*
> 	 * Split pages without a PMD map right
> 	 * away. Chances are some or all of the
> 	 * tail pages can be freed without IO.
> 	 */
> 	if (PageTransHuge(page) && !compound_mapcount(page) &&
>             split_huge_page_to_list(page, page_list))
> 		goto keep_locked;
>                                                                 
> activate_locked can be changed to keep_locked too, because it's just
> short term pinning.
> 

The change above looks good to me. Many thanks. Should I add a Suggested-by
tag for you?

> Best Regards,
> Huang, Ying

Thanks.

> 
> .
> 
