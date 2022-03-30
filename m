Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAB4EB82D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiC3CGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiC3CGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:06:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC977E614E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:04:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSqQr32ndzBrml;
        Wed, 30 Mar 2022 10:00:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 10:04:55 +0800
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
 <YkMOrjhxkqMx45Es@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4880f7de-625c-1d93-3b65-81f6c849de7b@huawei.com>
Date:   Wed, 30 Mar 2022 10:04:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkMOrjhxkqMx45Es@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/3/29 21:50, Matthew Wilcox wrote:
> On Tue, Mar 29, 2022 at 09:26:14PM +0800, Miaohe Lin wrote:
>> -unsigned long reclaim_pages(struct list_head *page_list)
>> +static inline unsigned int reclaim_page_list(struct list_head *page_list, struct pglist_data *pgdat)
>>  {
>> -	int nid = NUMA_NO_NODE;
>> -	unsigned int nr_reclaimed = 0;
>> -	LIST_HEAD(node_page_list);
>>  	struct reclaim_stat dummy_stat;
>> +	unsigned int nr_reclaimed;
>>  	struct page *page;
>> -	unsigned int noreclaim_flag;
>>  	struct scan_control sc = {
>>  		.gfp_mask = GFP_KERNEL,
>>  		.may_writepage = 1,
>> @@ -2529,6 +2526,24 @@ unsigned long reclaim_pages(struct list_head *page_list)
>>  		.no_demotion = 1,
>>  	};
>>  
>> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
>> +	while (!list_empty(page_list)) {
>> +		page = lru_to_page(page_list);
>> +		list_del(&page->lru);
>> +		putback_lru_page(page);
> 
> Why wouldn't you use a folio here?
> 

I was just wanting to keep the code consistent with the previous one. Am I supposed to
use a folio here ? If so, will do it in V2.

Thanks.

> 
> .
> 

