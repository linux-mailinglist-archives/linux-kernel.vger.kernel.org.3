Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DD34FCCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbiDLCuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDLCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:50:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5120F78
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:47:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcqrT1ZZ7z1HBn2;
        Tue, 12 Apr 2022 10:47:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 10:47:53 +0800
Subject: Re: [PATCH 3/3] mm/memory-failure.c: dissolve truncated hugetlb page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220407130352.15618-1-linmiaohe@huawei.com>
 <20220407130352.15618-4-linmiaohe@huawei.com>
 <20220411131344.GA3188122@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bc3284a7-1e02-996e-10b5-dd7cc983134e@huawei.com>
Date:   Tue, 12 Apr 2022 10:47:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220411131344.GA3188122@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 21:13, HORIGUCHI NAOYA(堀口 直也) wrote:
> Hi Miaohe,
> 
> On Thu, Apr 07, 2022 at 09:03:52PM +0800, Miaohe Lin wrote:
>> If me_huge_page meets a truncated huge page, hpage won't be dissolved
> 
> I might not understand correctly what "truncated huge page" means.  If it
> means the page passed to me_huge_page() and truncate_error_page() is called
> on it, the else branch you're trying to update is not chosen, so maybe it
> sounds irrelevant to me?  Could you elaborate it or share the procedure to
> reproduce the case you care about?

Sorry for making confusing. What 'truncated hugetlb page' means is that a hugepage is
truncated but still on the way to free. So HPageMigratable is still set and we might
come across it here. Does this make sense for you?

> 
>> even if we hold the last refcnt. It's because the truncated huge page
>> has NULL page_mapping while it's not anonymous page too. Thus we lose
>> the last chance to dissolve it into buddy to save healthy subpages.
>> Remove PageAnon check to handle these huge pages too.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index bd563f47630c..3f054dbb169d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1046,8 +1046,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>>  		 * hugepage, so we can free and dissolve it into buddy to
>>  		 * save healthy subpages.
>>  		 */
>> -		if (PageAnon(hpage))
>> -			put_page(hpage);
> 
> I think that the reason of this "if (PageAnon(hpage))" is to not remove
> hugepages for hugetlbfs files.  Unlike anonymous hugepage, it can be
> accessed from file after error handling, so we can't simply dissolve it
> because otherwise another process reading the hugepage sees zeroed one
> without knowing the memory error.

In this branch, we have precondition that page_mapping is NULL. So it can't be hugepages
for hugetlbfs files. It should be anonymous hugepages in most cases. If it's not anonymous
hugepages too, i.e. (!page_mapping(hpage) && !PageAnon(hpage)), it could be free hugepages
or 'truncated hugetlb page'. But we have already handled the free hugepages case, it should
be 'truncated hugetlb page' here. Since it's on the way to free, we should put the refcnt
to increase the chance that we can free and dissolve it into buddy to save healthy subpages.
Or am I miss something?

Thanks!

> 
> Thanks,
> Naoya Horiguchi
> 
>> +		put_page(hpage);
>>  		if (__page_handle_poison(p)) {
>>  			page_ref_inc(p);
>>  			res = MF_RECOVERED;
>> -- 
>> 2.23.0

