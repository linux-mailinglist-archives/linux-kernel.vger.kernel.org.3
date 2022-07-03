Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA415647A8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiGCOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiGCOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:06:49 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989E6144
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:06:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIBhorZ_1656857188;
Received: from 30.0.187.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIBhorZ_1656857188)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 22:06:28 +0800
Message-ID: <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 22:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
 <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
 <YsEPwvgUd0sIjso/@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsEPwvgUd0sIjso/@casper.infradead.org>
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



On 7/3/2022 11:40 AM, Matthew Wilcox wrote:
> On Fri, Jul 01, 2022 at 04:04:21PM +0800, Baolin Wang wrote:
>>> Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
>>> consistent with what we currently have for PTEs and PMDs.
>>>
>>> This applies to all the additions of pgtable_page_dec() and
>>> pgtable_page_inc().
>>
>> OK. I can add pgtable_pud_page_ctor() and pgtable_pud_page_dtor() helpers to
>> keep consistent, which are just wrappers of pgtable_page_inc() and
>> pgtable_page_dec().
> 
> I think you misunderstand Mike.
> 
> Don't add pgtable_page_inc() and pgtable_page_dec().  Just add
> pgtable_pud_page_ctor() and pgtable_pud_page_dtor().  At least, that
> was what I said last time yo uposted these patches.

My concern is that I need another helpers for kernel page table 
allocation helpers, if only adding pgtable_pud_page_ctor() and 
pgtable_pud_page_dtor() like below:

static inline void pgtable_pud_page_ctor(struct page *page)
{
	__SetPageTable(page);
	inc_lruvec_page_state(page, NR_PAGETABLE);
}

static inline void pgtable_pud_page_dtor(struct page *page)
{
	__ClearPageTable(page);
	dec_lruvec_page_state(page, NR_PAGETABLE);
}

So for kernel pte page table allocation, I need another similar helpers 
like below. However they do the samething with 
pgtable_pud_page_ctor/pgtable_pud_page_dtor, so I am not sure this is 
good for adding these duplicate code.

static inline void pgtable_kernel_pte_page_ctor(struct page *page)
{
	__SetPageTable(page);
	inc_lruvec_page_state(page, NR_PAGETABLE);
}

static inline void pgtable_kernel_pte_page_dtor(struct page *page)
{
	__ClearPageTable(page);
	dec_lruvec_page_state(page, NR_PAGETABLE);
}

Instead adding a common helpers seems more readable to me, which can 
also simplify original pgtable_pmd_page_dtor()/pgtable_pmd_page_ctor(). 
Something like below.

static inline void pgtable_page_inc(struct page *page)
{
	__SetPageTable(page);
	inc_lruvec_page_state(page, NR_PAGETABLE);
}

static inline void pgtable_page_dec(struct page *page)
{
	__ClearPageTable(page);
	dec_lruvec_page_state(page, NR_PAGETABLE);
}

static inline void pgtable_pud_page_ctor(struct page *page)
{
	pgtable_page_inc(page);
}

static inline void pgtable_pud_page_dtor(struct page *page)
{
	pgtable_page_dec(page);
}

For kernel pte page table, we can just use 
pgtable_page_inc/pgtable_page_dec(), or adding 
pgtable_kernel_pte_page_ctor/pgtable_kernel_pte_page_dtor, which just 
wrappers of pgtable_page_inc() and pgtable_page_dec().

Matthew and Mike, how do you think? Thanks.
