Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C44F5FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiDFNKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiDFNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:10:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FDE2BFC1B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:39:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KY7y7322fzdZTR;
        Wed,  6 Apr 2022 10:39:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 10:39:53 +0800
Subject: Re: [PATCH] filemap: remove obsolete comment in lock_page
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <dhowells@redhat.com>,
        <william.kucharski@oracle.com>, <vbabka@suse.cz>,
        <kirill.shutemov@linux.intel.com>, <hannes@cmpxchg.org>,
        <agruenba@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220402062218.30709-1-linmiaohe@huawei.com>
 <YksPkskcR6AdMaZf@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c728cb4c-6a87-94b6-b087-bbf2b55af35c@huawei.com>
Date:   Wed, 6 Apr 2022 10:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YksPkskcR6AdMaZf@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/4 23:32, Matthew Wilcox wrote:
> On Sat, Apr 02, 2022 at 02:22:18PM +0800, Miaohe Lin wrote:
>> lock_page needs the caller to have a reference on the page->mapping inode
>> due to sync_page. Also lock_page_nosync is introduced which does not do a
>> sync_page via commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()").
>> But commit 7eaceaccab5f ("block: remove per-queue plugging") kills off the
>> old plugging along with aops->sync_page() and lock_page_nosync. So there
>> is no need to have a reference on the page->mapping inode when calling
>> lock_page anymore. Remove this obsolete and confusing comment.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks.  I'll fix up the changelog (some of the tenses are a little
> strange) and take this through my pagecache tree.

Many thanks for doing this. :)

> 
>>  include/linux/pagemap.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index 993994cd943a..8dfe8e49c427 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
>>  		__folio_lock(folio);
>>  }
>>  
>> -/*
>> - * lock_page may only be called if we have the page's inode pinned.
>> - */
>>  static inline void lock_page(struct page *page)
>>  {
>>  	struct folio *folio;
>> -- 
>> 2.23.0
>>
> 
> .
> 

