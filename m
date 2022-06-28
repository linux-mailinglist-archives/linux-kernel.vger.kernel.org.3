Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8155CFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbiF1FsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiF1FsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:48:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD6027148
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:47:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556C8152B;
        Mon, 27 Jun 2022 22:47:37 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DB383F5A1;
        Mon, 27 Jun 2022 22:47:34 -0700 (PDT)
Message-ID: <397f73f7-14d6-ee0c-af42-39e193df030c@arm.com>
Date:   Tue, 28 Jun 2022 11:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
 <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
 <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
 <d68572c8-a12b-1e3a-09d4-7a971ff305d6@bytedance.com>
 <8b4eba5d-545e-c2a4-e4cf-fd5dd6634265@arm.com>
 <Yrm/+UoOtDY7G5bi@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yrm/+UoOtDY7G5bi@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/22 20:04, Matthew Wilcox wrote:
> On Mon, Jun 27, 2022 at 01:05:00PM +0530, Anshuman Khandual wrote:
>>> For the swap entry of hugetlb, we need to remember that we should
>>> call set_huge_swap_pte_at() instead of set_huge_pte_at() every
>>
>> Which is intuitive, so what is the problem ?
> 
> The problem is that HugeTLB is DIFFERENT from the rest of the VM.

Agreed.

> This has a huge cost in programmer time, which is infinitely more
> valuable than the cycle shaving you're quibbling over.  We should take
> any and every opportunity to make huge pages work the same way as THP
> and order-0 pages.

Got it.
