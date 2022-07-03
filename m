Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5704656484C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiGCPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGCPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:07:50 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4205F67
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:07:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIBrIff_1656860863;
Received: from 30.0.187.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIBrIff_1656860863)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 23:07:44 +0800
Message-ID: <68a5286b-7ff3-2c4e-1ab2-305e7860a2f3@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 23:07:47 +0800
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
 <17df0d3c-caaf-ee34-f702-1d4e7674887f@linux.alibaba.com>
 <YsGtPnfB4/A8pFhA@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsGtPnfB4/A8pFhA@casper.infradead.org>
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



On 7/3/2022 10:52 PM, Matthew Wilcox wrote:
> On Sun, Jul 03, 2022 at 10:06:32PM +0800, Baolin Wang wrote:
>> So for kernel pte page table allocation, I need another similar helpers like
>> below. However they do the samething with
>> pgtable_pud_page_ctor/pgtable_pud_page_dtor, so I am not sure this is good
>> for adding these duplicate code.
> 
> Why do we want to account kernel PTE page tables in NR_PAGETABLE?
> I think that's confusing.

Why this will confuse you? I think it is inconsistent that kernel PTE 
page tables are not accounted, because we will account PMD/PUD level 
page tables no matter they are userspace pagetable pages or kernel 
pagetable pages.

Moreover the the vmalloc()/vmap() can consume some kernel pagetable 
pages, which should be accounted.
