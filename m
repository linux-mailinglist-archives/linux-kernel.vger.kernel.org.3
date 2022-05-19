Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6289E52C97C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiESByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiESByO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:54:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F7C1ED7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:54:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3XtT0Y9JzgYJJ;
        Thu, 19 May 2022 09:52:49 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:54:11 +0800
Subject: Re: [PATCH 08/15] mm/swap: make page_swapcount and
 __lru_add_drain_all
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-9-linmiaohe@huawei.com>
 <YoTAWjTV7Yj8FulM@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0724d13d-685d-d975-65b7-5248013469e8@huawei.com>
Date:   Thu, 19 May 2022 09:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YoTAWjTV7Yj8FulM@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/18 17:46, Oscar Salvador wrote:
> On Mon, May 09, 2022 at 09:14:09PM +0800, Miaohe Lin wrote:
>> Make page_swapcount and __lru_add_drain_all static. They are only used
>> within the file now.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> I think the commit message is missing the "static" word.

Yes, you're right. The commit message should be "mm/swap: make page_swapcount and __lru_add_drain_all static". :)

Hi Andrew,
Could you please help tweak the commit message? Or I will send a new version soon if requested.
Thanks a lot!

> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Many thanks for your review and comment!

> 
>> ---
>>  include/linux/swap.h | 7 -------
>>  mm/swap.c            | 2 +-
>>  mm/swapfile.c        | 2 +-
>>  3 files changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 999c7d79c2d5..8772132d21dc 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -490,7 +490,6 @@ int swap_type_of(dev_t device, sector_t offset);
>>  int find_first_swap(dev_t *device);
>>  extern unsigned int count_swap_pages(int, int);
>>  extern sector_t swapdev_block(int, pgoff_t);
>> -extern int page_swapcount(struct page *);
>>  extern int __swap_count(swp_entry_t entry);
>>  extern int __swp_swapcount(swp_entry_t entry);
>>  extern int swp_swapcount(swp_entry_t entry);
>> @@ -562,12 +561,6 @@ static inline void put_swap_page(struct page *page, swp_entry_t swp)
>>  {
>>  }
>>  
>> -
>> -static inline int page_swapcount(struct page *page)
>> -{
>> -	return 0;
>> -}
>> -
>>  static inline int __swap_count(swp_entry_t entry)
>>  {
>>  	return 0;
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 7e320ec08c6a..6d2c37f781f8 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -748,7 +748,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>>   * Calling this function with cpu hotplug locks held can actually lead
>>   * to obscure indirect dependencies via WQ context.
>>   */
>> -inline void __lru_add_drain_all(bool force_all_cpus)
>> +static inline void __lru_add_drain_all(bool force_all_cpus)
>>  {
>>  	/*
>>  	 * lru_drain_gen - Global pages generation number
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 7b4c99ca2aea..133e03fea104 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1430,7 +1430,7 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
>>   * This does not give an exact answer when swap count is continued,
>>   * but does include the high COUNT_CONTINUED flag to allow for that.
>>   */
>> -int page_swapcount(struct page *page)
>> +static int page_swapcount(struct page *page)
>>  {
>>  	int count = 0;
>>  	struct swap_info_struct *p;
>> -- 
>> 2.23.0
>>
>>
> 

