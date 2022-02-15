Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08834B616A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiBODOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:14:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBODOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:14:21 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E763AC910
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:14:11 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JyR0D5TqHz1FDBC;
        Tue, 15 Feb 2022 11:09:48 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 11:14:08 +0800
Subject: Re: [PATCH 4/8] mm/memory-failure.c: remove unneeded orig_head
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-5-linmiaohe@huawei.com> <20220214145019.GD2624914@u2004>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f19c8477-c352-c1e1-74a4-3298511f10cf@huawei.com>
Date:   Tue, 15 Feb 2022 11:14:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220214145019.GD2624914@u2004>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/14 22:50, Naoya Horiguchi wrote:
> On Thu, Feb 10, 2022 at 10:17:29PM +0800, Miaohe Lin wrote:
>> orig_head is used to check whether the page have changed compound pages
>> during the locking. But it's always equal to hpage. So we can use hpage
>> directly and remove this redundant one.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 2dd7f35ee65a..4370c2f407c5 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1691,7 +1691,6 @@ int memory_failure(unsigned long pfn, int flags)
>>  {
>>  	struct page *p;
>>  	struct page *hpage;
>> -	struct page *orig_head;
>>  	struct dev_pagemap *pgmap;
>>  	int res = 0;
>>  	unsigned long page_flags;
>> @@ -1737,7 +1736,7 @@ int memory_failure(unsigned long pfn, int flags)
>>  		goto unlock_mutex;
>>  	}
>>
>> -	orig_head = hpage = compound_head(p);
>> +	hpage = compound_head(p);
>>  	num_poisoned_pages_inc();
>>
>>  	/*
>> @@ -1821,7 +1820,7 @@ int memory_failure(unsigned long pfn, int flags)
>>  	 * The page could have changed compound pages during the locking.
>>  	 * If this happens just bail out.
>>  	 */
>> -	if (PageCompound(p) && compound_head(p) != orig_head) {
>> +	if (PageCompound(p) && compound_head(p) != hpage) {
> 
> I think that this if-check was intended to detect the case that page p
> belongs to a thp when memory_failure() is called and belongs to a compound
> page in different size (like slab or some driver page) after the thp is
> split.  But your suggestion makes me aware that the page p could be embedded
> on a thp again after thp split.  I think this might be rare, but if it

IIUC, this page can't be embedded on a thp again after thp split because memory_failure hold
an __extra__ page refcnt. I think there exist below race windows:

memory_failure
  orig_head = hpage = compound_head(p); -- page is Non-compound yet
  < -- Page becomes compound page, like thp, slab, some driver page and even hugetlb page -- >
  get_hwpoison_page
  failed to split thp page, as hpage is Non-compound ...
  lock_page

> happens the current if-check (or suggested one) cannot detect it.
> So I feel that simply dropping compound_head() check might be better?
> 
> -	if (PageCompound(p) && compound_head(p) != orig_head) {
> +	if (PageCompound(p)) {

However this change could also catch the above race correctly. In fact, we can't handle
compound page here. But is it enough to just return -EBUSY here as it's really rare or
we should do more things (like split thp, retry if in PageHuge case)?

> 
> This should ensure the assumption (mentioned in 8/8 patch) more that
> the error page never belongs to compound page after taking page lock.

Agree, this really helps.

>> Thanks,
> Naoya Horiguchi
> .
> 

Many thanks.
