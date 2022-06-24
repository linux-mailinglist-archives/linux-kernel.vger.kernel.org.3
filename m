Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F55595D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiFXIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:52:33 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515D6E7AA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:52:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHGcxXq_1656060747;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGcxXq_1656060747)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 16:52:28 +0800
Message-ID: <ed072ac6-cc70-9070-4e9d-281b9b60c9a6@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 16:52:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 2/3] mm: Add PUD level pagetable account
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
 <YrMpZlQHMuCy06/m@linux.ibm.com> <YrRqhj3p/KKU73f1@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YrRqhj3p/KKU73f1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2022 9:28 PM, Matthew Wilcox wrote:
> On Wed, Jun 22, 2022 at 09:38:30AM -0500, Mike Rapoport wrote:
>> On Wed, Jun 22, 2022 at 04:58:53PM +0800, Baolin Wang wrote:
>>> +++ b/arch/loongarch/include/asm/pgalloc.h
>>> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>>   {
>>>   	pud_t *pud;
>>> +	struct page *pg;
>>
>> 	struct page *page;
>>
>> looks better IMO.
>>
>>> +
>>> +	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
> 
> GFP_KERNEL does not include __GFP_HIGHMEM, so you can just use
> GFP_KERNEL here.

Yes. Thanks.

> 
>>> +	if (!pg)
>>> +		return NULL;
>>>   
>>> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
>>> -	if (pud)
>>> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>>> +	pgtable_set_and_inc(pg);
>>> +	pud = (pud_t *)page_address(pg);
>>
>> I don't think __get_free_pages() should be replaced with alloc_pages()
>> here, just call pgtable_set_and_inc() with virt_to_page(pud).
> 
> I don't understand why you want that.  Take a look at the implementation
> of __get_free_pages().  Converting back to a struct page after calling
> that seems like a real waste of time to me.

IMO I have no strong preference. The code can be simpler with using 
__get_free_pages(), however like Matthew said it will add more conversion.
