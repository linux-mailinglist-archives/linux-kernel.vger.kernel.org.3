Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D758564792
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiGCNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCNsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:48:14 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D55F8E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 06:48:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIBbN6O_1656856088;
Received: from 30.0.187.160(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIBbN6O_1656856088)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 21:48:09 +0800
Message-ID: <fedd6409-9bdb-1c1d-5fcd-28fc10f4e5b4@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 21:48:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3 1/3] mm: Factor out the pagetable pages account
 into new helper function
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2vFQVPUWX3t9RB@linux.ibm.com>
 <13b2cc16-fb1a-eeb8-7a15-d20f4ba42a48@linux.alibaba.com>
 <YsAaxFg7w3OpY7eE@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YsAaxFg7w3OpY7eE@linux.ibm.com>
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



On 7/2/2022 6:15 PM, Mike Rapoport wrote:
> On Fri, Jul 01, 2022 at 04:00:59PM +0800, Baolin Wang wrote:
>>
>>
>> On 6/30/2022 10:11 PM, Mike Rapoport wrote:
>>> On Thu, Jun 30, 2022 at 07:11:14PM +0800, Baolin Wang wrote:
>>>> Factor out the pagetable pages account into new helper functions to avoid
>>>> duplicated code. Meanwhile these helper functions also will be used to
>>>> account pagetable pages which do not need split pagetale lock.
>>>>
>>>> Meanwhile convert to use mod_lruvec_page_state() in case of non-order-0
>>>> page table allocation.
>>>
>>> These are *very* rare. I think only parisc may have non-order-0 pmd and pud
>>> tables.
>>
>> s390 also has non-order-0 page table allocation, but they both do not use
>> the generic page table allocation now.
>>
>>> With that, I'd suggest making use of compound_nr() build time opt-in.
>>
>> After more thinking, I'd prefer to change back to use
>> inc_lruvec_page_state()/dec_lruvec_page_state(), since now no architecures
>> will need non-order-0 page table allocation.
>>
>> After this patchset, I plan to convert parisc and s390 to use generic
>> pagetable allocation, then I will add non-order-0 page table allocation
>> support. Like Matthew suggested, maybe I need change the API to pass the
>> number of pages.
> 
> I think it would be simpler to add proper accounting to s390 and parisc
> versions than make them use the generic allocation functions. Moreover, API
> change to support these cases feels like unnecessary churn to me.

Got it. Thanks.
