Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC2579193
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiGSECe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiGSECc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:02:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52520F5A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658203349; x=1689739349;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xn5zlKdJpXyJKONq5d4s1g65KO0LNXOLAzkp0bytQWQ=;
  b=WINMUtT+EpjAIoLze6AH6A93pXeTf/TLdTZA/cYb+741S660foaCK+Yp
   qE+zSRIke1V+qtQTtVJZos1ru3aDabUlZZV0c6J+kX3LtPV6Pwp/KV36s
   ZSULj8F++XxwW1WRoOm/U7+wwY7dz09CBdH3SJdjpJj4O8Eh32RZv3yr6
   nmgw44+90nc+zfEZA2ztoetKe4ncML5sXeXjt22dVJgWJiBTc1ZoWAGAb
   988MCHf6jpoBjhjLzKHREEKzGm+bu1RfkbJRwEIVJtTTX7ybknW1+9jKC
   hGpNKDunJQEgEMCyMUEGXMBopvvlV34xpCjO81XD5OWa+dgQfu5KqG9P0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287125430"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="287125430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 20:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="572680024"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 20:58:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>,
        hanchuanhua <hanchuanhua@oppo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Minchan Kim" <minchan@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>
Subject: Re: [RESEND PATCH v3] arm64: enable THP_SWAP for arm64
References: <20220718090050.2261-1-21cnbao@gmail.com>
        <87mtd62apo.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAGsJ_4zsNNb0mbR7Sm-=Hd7+fW4rXbnivCY1cF-wyio2EeETvA@mail.gmail.com>
        <f2d6ef91-f447-ffb4-2a6e-bc95533e5167@arm.com>
        <87zgh5232o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <416a06f6-ca7d-d4a9-2cda-af0ad6e28261@arm.com>
Date:   Tue, 19 Jul 2022 11:58:23 +0800
In-Reply-To: <416a06f6-ca7d-d4a9-2cda-af0ad6e28261@arm.com> (Anshuman
        Khandual's message of "Tue, 19 Jul 2022 09:04:57 +0530")
Message-ID: <87v8rt21pc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> On 7/19/22 08:58, Huang, Ying wrote:
>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>> 
>>> On 7/19/22 06:53, Barry Song wrote:
>>>> On Tue, Jul 19, 2022 at 12:44 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>
>>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>>
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> THP_SWAP has been proven to improve the swap throughput significantly
>>>>>> on x86_64 according to commit bd4c82c22c367e ("mm, THP, swap: delay
>>>>>> splitting THP after swapped out").
>>>>>> As long as arm64 uses 4K page size, it is quite similar with x86_64
>>>>>> by having 2MB PMD THP. THP_SWAP is architecture-independent, thus,
>>>>>> enabling it on arm64 will benefit arm64 as well.
>>>>>> A corner case is that MTE has an assumption that only base pages
>>>>>> can be swapped. We won't enable THP_SWAP for ARM64 hardware with
>>>>>> MTE support until MTE is reworked to coexist with THP_SWAP.
>>>>>>
>>>>>> A micro-benchmark is written to measure thp swapout throughput as
>>>>>> below,
>>>>>>
>>>>>>  unsigned long long tv_to_ms(struct timeval tv)
>>>>>>  {
>>>>>>       return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>>>>>>  }
>>>>>>
>>>>>>  main()
>>>>>>  {
>>>>>>       struct timeval tv_b, tv_e;;
>>>>>>  #define SIZE 400*1024*1024
>>>>>>       volatile void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>>>>>>                               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>>>>       if (!p) {
>>>>>>               perror("fail to get memory");
>>>>>>               exit(-1);
>>>>>>       }
>>>>>>
>>>>>>       madvise(p, SIZE, MADV_HUGEPAGE);
>>>>>>       memset(p, 0x11, SIZE); /* write to get mem */
>>>>>>
>>>>>>       gettimeofday(&tv_b, NULL);
>>>>>>       madvise(p, SIZE, MADV_PAGEOUT);
>>>>>>       gettimeofday(&tv_e, NULL);
>>>>>>
>>>>>>       printf("swp out bandwidth: %ld bytes/ms\n",
>>>>>>                       SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>>>>>>  }
>>>>>>
>>>>>> Testing is done on rk3568 64bit quad core processor Quad Core
>>>>>> Cortex-A55 platform - ROCK 3A.
>>>>>> thp swp throughput w/o patch: 2734bytes/ms (mean of 10 tests)
>>>>>> thp swp throughput w/  patch: 3331bytes/ms (mean of 10 tests)
>>>>>>
>>>>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>>>>> Cc: Minchan Kim <minchan@kernel.org>
>>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>>> Cc: Hugh Dickins <hughd@google.com>
>>>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>> Cc: Steven Price <steven.price@arm.com>
>>>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>> ---
>>>>>>  -v3:
>>>>>>  * refine the commit log;
>>>>>>  * add a benchmark result;
>>>>>>  * refine the macro of arch_thp_swp_supported
>>>>>>  Thanks to the comments of Anshuman, Andrew, Steven
>>>>>>
>>>>>>  arch/arm64/Kconfig               |  1 +
>>>>>>  arch/arm64/include/asm/pgtable.h |  6 ++++++
>>>>>>  include/linux/huge_mm.h          | 12 ++++++++++++
>>>>>>  mm/swap_slots.c                  |  2 +-
>>>>>>  4 files changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>> index 1652a9800ebe..e1c540e80eec 100644
>>>>>> --- a/arch/arm64/Kconfig
>>>>>> +++ b/arch/arm64/Kconfig
>>>>>> @@ -101,6 +101,7 @@ config ARM64
>>>>>>       select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>>>>>       select ARCH_WANT_LD_ORPHAN_WARN
>>>>>>       select ARCH_WANTS_NO_INSTR
>>>>>> +     select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>>>>>>       select ARCH_HAS_UBSAN_SANITIZE_ALL
>>>>>>       select ARM_AMBA
>>>>>>       select ARM_ARCH_TIMER
>>>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>>>> index 0b6632f18364..78d6f6014bfb 100644
>>>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>>>> @@ -45,6 +45,12 @@
>>>>>>       __flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
>>>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>>>
>>>>>> +static inline bool arch_thp_swp_supported(void)
>>>>>> +{
>>>>>> +     return !system_supports_mte();
>>>>>> +}
>>>>>> +#define arch_thp_swp_supported arch_thp_swp_supported
>>>>>> +
>>>>>>  /*
>>>>>>   * Outside of a few very special situations (e.g. hibernation), we always
>>>>>>   * use broadcast TLB invalidation instructions, therefore a spurious page
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index de29821231c9..4ddaf6ad73ef 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -461,4 +461,16 @@ static inline int split_folio_to_list(struct folio *folio,
>>>>>>       return split_huge_page_to_list(&folio->page, list);
>>>>>>  }
>>>>>>
>>>>>> +/*
>>>>>> + * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
>>>>>> + * limitations in the implementation like arm64 MTE can override this to
>>>>>> + * false
>>>>>> + */
>>>>>> +#ifndef arch_thp_swp_supported
>>>>>> +static inline bool arch_thp_swp_supported(void)
>>>>>> +{
>>>>>> +     return true;
>>>>>> +}
>>>>>
>>>>> How about the following?
>>>>>
>>>>> static inline bool arch_wants_thp_swap(void)
>>>>> {
>>>>>      return IS_ENABLED(ARCH_WANTS_THP_SWAP);
>>>>> }
>>>>
>>>> This looks good. then i'll need to change arm64 to
>>>>
>>>>  +static inline bool arch_thp_swp_supported(void)
>>>>  +{
>>>>  +     return IS_ENABLED(ARCH_WANTS_THP_SWAP) &&  !system_supports_mte();
>>>>  +}
>>>
>>> Why ? CONFIG_THP_SWAP depends on ARCH_WANTS_THP_SWAP. In folio_alloc_swap(),
>>> IS_ENABLED(CONFIG_THP_SWAP) enabled, will also imply ARCH_WANTS_THP_SWAP too
>>> is enabled. Hence checking for ARCH_WANTS_THP_SWAP again does not make sense
>>> either in the generic fallback stub, or in arm64 platform override. Because
>>> without ARCH_WANTS_THP_SWAP enabled, arch_thp_swp_supported() should never
>>> be called in the first place.
>> 
>> For the only caller now, the checking looks redundant.  But the original
>> proposed implementation as follows,
>> 
>> static inline bool arch_thp_swp_supported(void)
>> {
>>      return true;
>> }
>> 
>> will return true even on architectures that don't support/want THP swap.
>
> But the function will never be called on for those platforms.

But the function is defined on these platforms.  We need to make the
function itself correct instead of just working for the only caller now.

>> That will confuse people too.
>
> I dont see how.

From the definition of the function, people will think THP swap is
supported/wanted on the platform.  But in fact, it may be not.

>> 
>> And the "redundant" checking has no run time overhead, because compiler
>> will do the trick.
> I understand that, but dont think this indirection is necessary.

Best Regards,
Huang, Ying
