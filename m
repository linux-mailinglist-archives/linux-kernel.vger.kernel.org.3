Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A4508063
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359375AbiDTFIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiDTFIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:08:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DE9324BF6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:05:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C227E23A;
        Tue, 19 Apr 2022 22:05:18 -0700 (PDT)
Received: from [192.168.225.231] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E53D3F5A1;
        Tue, 19 Apr 2022 22:05:11 -0700 (PDT)
Message-ID: <16a2620e-986a-6a8f-24eb-d0f7e9c91f24@arm.com>
Date:   Wed, 20 Apr 2022 10:35:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com>
 <073cb6a6-3dbc-75d4-dbfe-a5299a6b0510@arm.com>
 <CA+CK2bCPrQ=F0jNRxcVZ9f18Rm-kAATO3xFE79TZDoWQ99GC4Q@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CA+CK2bCPrQ=F0jNRxcVZ9f18Rm-kAATO3xFE79TZDoWQ99GC4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 18:49, Pasha Tatashin wrote:
> On Tue, Apr 19, 2022 at 6:22 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>> On 4/18/22 09:14, Tong Tiangen wrote:
>>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>>> +static inline bool pte_user_accessible_page(pte_t pte)
>>> +{
>>> +     return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
>>> +}
>>> +
>>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>>> +{
>>> +     return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>> +}
>>> +
>>> +static inline bool pud_user_accessible_page(pud_t pud)
>>> +{
>>> +     return pud_present(pud) && pud_user(pud);
>>> +}
>>> +#endif
>> Wondering why check for these page table entry states when init_mm
>> has already being excluded ? Should not user page tables be checked
>> for in entirety for all updates ? what is the rationale for filtering
>> out only pxx_user_access_page entries ?
> 
> The point is to prevent false sharing and memory corruption issues.
> The idea of PTC to be simple and relatively independent  from the MM
> state machine that catches invalid page sharing. I.e. if an R/W anon

Right, this mechanism here is truly interdependent validation, which is
orthogonal to other MM states. Although I was curious, if mm_struct is
not 'init_mm', what percentage of its total page table mapped entries
will be user accessible ? These new helpers only filter out entries that
could potentially create false sharing leading upto memory corruption ?

I am wondering if there is any other way such filtering could have been
applied without adding all these new page table helpers just for page
table check purpose.

> page is accessible by user land, that page can never be mapped into
> another process (internally shared anons are treated as named
> mappings).

Right.

> 
> Therefore, we try not to rely on MM states, and ensure that when a
> page-table entry is accessible by user it meets the required
> assumptions: no false sharing, etc.

Right, filtering reduces the page table entries that needs interception
during update (set/clear), but was just curious is there another way of
doing it, without adding page table check specific helpers on platforms
subscribing PAGE_TABLE_CHECK ?

> 
> For example, one bug that was caught with PTC was where a driver on an
> unload would put memory on a freelist but memory is still mapped in
> user page table.

Should not page's refcount (that it is being used else where) prevented
releases into free list ? But page table check here might just detect
such scenarios even before page gets released.
