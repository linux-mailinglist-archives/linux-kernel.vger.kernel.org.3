Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C70E4ED166
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352356AbiCaBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352350AbiCaBrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:47:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C150483AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:45:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KTR152ccSzgYCL;
        Thu, 31 Mar 2022 09:44:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 09:45:48 +0800
Subject: Re: [PATCH 3/8] mm/vmscan: introduce helper function
 reclaim_page_list()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-4-linmiaohe@huawei.com>
 <YkMOrjhxkqMx45Es@casper.infradead.org>
 <4880f7de-625c-1d93-3b65-81f6c849de7b@huawei.com>
 <YkSD/2g75i/v2VMW@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8d29ed79-6160-5766-da95-93dd2de94f52@huawei.com>
Date:   Thu, 31 Mar 2022 09:45:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkSD/2g75i/v2VMW@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
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

On 2022/3/31 0:23, Matthew Wilcox wrote:
> On Wed, Mar 30, 2022 at 10:04:54AM +0800, Miaohe Lin wrote:
>> On 2022/3/29 21:50, Matthew Wilcox wrote:
>>>> +	while (!list_empty(page_list)) {
>>>> +		page = lru_to_page(page_list);
>>>> +		list_del(&page->lru);
>>>> +		putback_lru_page(page);
>>>
>>> Why wouldn't you use a folio here?
>>>
>>
>> I was just wanting to keep the code consistent with the previous one. Am I supposed to
>> use a folio here ? If so, will do it in V2.
> 
> The distinction we're trying to make (and obviously we have a long way
> to go before we're finished) is between the structure that describes
> PAGE_SIZE bytes of memory and the structure that manages the memory
> allocation.  This function is clearly handling the entire memory
> allocation, so it should be using a folio.  Eventually, page->lru

I see. Thanks for clarifying.

> should disappear, but there's 180 places to figure out what we need to
> do instead.
> 
> 
> .
> 

