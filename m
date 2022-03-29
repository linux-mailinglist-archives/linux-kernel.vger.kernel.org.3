Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E7D4EAE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiC2N3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiC2N3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:29:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8E1F89F5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:27:19 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSVj168RZz1GD3s;
        Tue, 29 Mar 2022 21:27:01 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 21:27:18 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 21:27:17 +0800
Message-ID: <65501e99-0839-5f08-8a69-95e3c77c64ac@huawei.com>
Date:   Tue, 29 Mar 2022 21:27:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 2/2] mm: fix contiguous memmap assumptions about
 alloc/free pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
References: <20220329130928.266323-1-chenwandun@huawei.com>
 <20220329130928.266323-3-chenwandun@huawei.com>
 <YkMEyH9QB8MyzW37@casper.infradead.org>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <YkMEyH9QB8MyzW37@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
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



on 2022/3/29 21:08, Matthew Wilcox wrote:
> On Tue, Mar 29, 2022 at 09:09:28PM +0800, Chen Wandun wrote:
>> +#define page_nth(head, tail)	(page_to_pfn(tail) - page_to_pfn(head))
> Could we avoid reintroducing page_nth()?  It is a terrible name.
how about compound_index ?
>> @@ -1213,7 +1213,7 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
>>   		ret = 0;
>>   		goto out;
>>   	}
>> -	switch (page - head_page) {
>> +	switch (page_nth(head_page, page)) {
>>   	case 1:
>>   		/* the first tail page: ->mapping may be compound_mapcount() */
>>   		if (unlikely(compound_mapcount(page))) {
> This is the only place you use it.  I'd suggest free_tail_pages_check()
> should take 'i' as its second parameter instead of 'page + i', then
> there's no need to convert back to i.
OK， I will send v2， but I'm not sure whether similar function like 
page_nth is needed elsewhere

>
> .

