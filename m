Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5FC559595
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFXIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFXIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:41:46 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6506B8C4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:41:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VHGOxn4_1656060101;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGOxn4_1656060101)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 16:41:42 +0800
Message-ID: <1db60157-9f26-cc09-9a8d-2813a3a3ac95@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 16:41:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 1/3] mm: Factor out the pagetable pages account
 into new helper function
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <e094c4a2e07ff66708f7a3a9f6b86eb694f33cf0.1655887440.git.baolin.wang@linux.alibaba.com>
 <YrSPsqJHJTRcCmph@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YrSPsqJHJTRcCmph@casper.infradead.org>
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



On 6/24/2022 12:07 AM, Matthew Wilcox wrote:
> On Wed, Jun 22, 2022 at 04:58:52PM +0800, Baolin Wang wrote:
>> +static inline void pgtable_set_and_inc(struct page *page)
>> +{
>> +	__SetPageTable(page);
>> +	inc_lruvec_page_state(page, NR_PAGETABLE);
>> +}
> 
> I don't like the names.  The accounting is also wrong for non-order-0
> allocations.  It should be
> 
> 	mod_lruvec_page_state(page, NR_PAGETABLE, compound_nr(page))

Yes, seems need another patch to convert using compound_nr().

> 
> but it's probably better to change the API to pass in the number of
> pages instead of recalculating it.

Lots of callers will not calculate the number of pages, so I think we 
can just add the compound_nr() in the API firstly, which also can avoid 
changing lots of callers.

> I can't think of a good name.  What's wrong with just adding
> 
> static inline bool pgtable_pud_page_ctor(struct page *page)
> 
> to go along with the pte and pmd variants?

IMHO that means we will need another function like 
pgtable_kernel_pte_page_ctor/dtor() to account kernel pagetable, however 
they do the same thing. So a common function which only do 
'__SetPageTable' and account pagetable will be more helpful.

So how about pgtable_page_inc()/pgtable_page_dec()?
