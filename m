Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD65511C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiFTHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiFTHr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF91F101C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655711246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swx0F31MzBfg+ngtrAShbFu1C4KdMojB34uimCkyvcw=;
        b=gYXpE8v3SD3GVWOaIHYKiPNL7SseJiL7ploc7GQT4yBNs7hYzuurBrZrp9oZqcFlqGSuU1
        U97yo7sioX+mFepvLGo5KoV1+ZdRz9WyR0tQFlz44pVFE1pnF295ztlVUYvk0FYzh4/X+m
        V5qU9Wjv84s/6C0NOWYfokCZHw6zKaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-tZT6zmAOMJmKWtdkC0P_Pg-1; Mon, 20 Jun 2022 03:47:25 -0400
X-MC-Unique: tZT6zmAOMJmKWtdkC0P_Pg-1
Received: by mail-wr1-f72.google.com with SMTP id j14-20020adfa54e000000b0021b8c8204easo819624wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Swx0F31MzBfg+ngtrAShbFu1C4KdMojB34uimCkyvcw=;
        b=E0Vtlp/pike8MXs8OIDu4i4kTHApvyWhZUOswSpQdm0T4fS6dZXiPIR9vjIM8/Y2Sq
         H3u3fwFxecBmh4FdHXeXDU0s0n0oST4wFUCh05ai+BU0vZTEkQy6A3UpW+BRZGokiuX8
         ewTCaxKdQTWwzQYy/n6YobDaYALuuvNE/W6plLn9efWR+D9IvZA/vV8082R1JmBSlknh
         4wlcpf0HEwareWvx/Mfo5KBB17jZJw5tz/0PPY/y5+SxGXlVFDGV2Q3JnOBnjc63sjUw
         ppoQEiZA/oI5Y26TLGZE/pFWaYXBFFAGUBrP0/3VPG58ua5zQGJ4rgSaRyD9Nm11Dpx9
         3RtA==
X-Gm-Message-State: AJIora8744ZRxFcwimFVhhw0JevsbHNsFxX2ShpEcZCabyR5VJNKY2js
        cjcNpxd+uROPfIR6VN2Nc+6dKldf4F9D/0elO/IZ59VHtSekiBLLtkhUTiMzT+XSKkfc6Hw+0uR
        +Zskx7JU/SVUa0Z5XVnhONFj+
X-Received: by 2002:a7b:c392:0:b0:39c:4d27:e698 with SMTP id s18-20020a7bc392000000b0039c4d27e698mr23209903wmj.57.1655711244194;
        Mon, 20 Jun 2022 00:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tZHngIz1nmDGjViDYq8dx9T6leMNpILDajZ78iuXxNfTEeSi93ba+gl4fuGlsgBS4IGwA1KA==
X-Received: by 2002:a7b:c392:0:b0:39c:4d27:e698 with SMTP id s18-20020a7bc392000000b0039c4d27e698mr23209868wmj.57.1655711243813;
        Mon, 20 Jun 2022 00:47:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb0c000000b0021b9100b844sm1447006wrr.91.2022.06.20.00.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 00:47:23 -0700 (PDT)
Message-ID: <226243a9-b4f5-182e-1a5b-7b8d5c28f3b3@redhat.com>
Date:   Mon, 20 Jun 2022 09:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, osalvador@suse.de,
        paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-3-songmuchun@bytedance.com>
 <YrAgUtV6wD6CIrad@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YrAgUtV6wD6CIrad@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 09:22, Muchun Song wrote:
> On Sun, Jun 19, 2022 at 09:38:51PM +0800, Muchun Song wrote:
>> For now, the feature of hugetlb_free_vmemmap is not compatible with the
>> feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
>> takes precedence over memory_hotplug.memmap_on_memory. However, someone
>> wants to make memory_hotplug.memmap_on_memory takes precedence over
>> hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
>> succeed memory hotplug in close-to-OOM situations.  So the decision
>> of making hugetlb_free_vmemmap take precedence is not wise and elegant.
>> The proper approach is to have hugetlb_vmemmap.c do the check whether
>> the section which the HugeTLB pages belong to can be optimized.  If
>> the section's vmemmap pages are allocated from the added memory block
>> itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
>> otherwise, do the optimization.  Then both kernel parameters are
>> compatible.  So this patch introduces VmemmapSelfHosted to mask any
>> non-optimizable vmemmap pages. The hugetlb_vmemmap can use this flag
>> to detect if a vmemmap page can be optimized.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Co-developed-by: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 22 +++++------
>>  Documentation/admin-guide/sysctl/vm.rst         |  5 +--
>>  include/linux/memory_hotplug.h                  |  9 -----
>>  include/linux/page-flags.h                      | 11 ++++++
>>  mm/hugetlb_vmemmap.c                            | 52 +++++++++++++++++++++----
>>  mm/memory_hotplug.c                             | 27 ++++++-------
>>  6 files changed, 79 insertions(+), 47 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 8090130b544b..d740e2ed0e61 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1722,9 +1722,11 @@
>>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>>  			the default is on.
>>  
>> -			This is not compatible with memory_hotplug.memmap_on_memory.
>> -			If both parameters are enabled, hugetlb_free_vmemmap takes
>> -			precedence over memory_hotplug.memmap_on_memory.
>> +			Note that the vmemmap pages may be allocated from the added
>> +			memory block itself when memory_hotplug.memmap_on_memory is
>> +			enabled, those vmemmap pages cannot be optimized even if this
>> +			feature is enabled.  Other vmemmap pages not allocated from
>> +			the added memory block itself do not be affected.
>>  
>>  	hung_task_panic=
>>  			[KNL] Should the hung task detector generate panics.
>> @@ -3069,10 +3071,12 @@
>>  			[KNL,X86,ARM] Boolean flag to enable this feature.
>>  			Format: {on | off (default)}
>>  			When enabled, runtime hotplugged memory will
>> -			allocate its internal metadata (struct pages)
>> -			from the hotadded memory which will allow to
>> -			hotadd a lot of memory without requiring
>> -			additional memory to do so.
>> +			allocate its internal metadata (struct pages,
>> +			those vmemmap pages cannot be optimized even
>> +			if hugetlb_free_vmemmap is enabled) from the
>> +			hotadded memory which will allow to hotadd a
>> +			lot of memory without requiring additional
>> +			memory to do so.
>>  			This feature is disabled by default because it
>>  			has some implication on large (e.g. GB)
>>  			allocations in some configurations (e.g. small
>> @@ -3082,10 +3086,6 @@
>>  			Note that even when enabled, there are a few cases where
>>  			the feature is not effective.
>>  
>> -			This is not compatible with hugetlb_free_vmemmap. If
>> -			both parameters are enabled, hugetlb_free_vmemmap takes
>> -			precedence over memory_hotplug.memmap_on_memory.
>> -
>>  	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
>>  			Format: <integer>
>>  			default : 0 <disable>
>> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
>> index 5c9aa171a0d3..d7374a1e8ac9 100644
>> --- a/Documentation/admin-guide/sysctl/vm.rst
>> +++ b/Documentation/admin-guide/sysctl/vm.rst
>> @@ -565,9 +565,8 @@ See Documentation/admin-guide/mm/hugetlbpage.rst
>>  hugetlb_optimize_vmemmap
>>  ========================
>>  
>> -This knob is not available when memory_hotplug.memmap_on_memory (kernel parameter)
>> -is configured or the size of 'struct page' (a structure defined in
>> -include/linux/mm_types.h) is not power of two (an unusual system config could
>> +This knob is not available when the size of 'struct page' (a structure defined
>> +in include/linux/mm_types.h) is not power of two (an unusual system config could
>>  result in this).
>>  
>>  Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>> index 20d7edf62a6a..e0b2209ab71c 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -351,13 +351,4 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>>  #endif /* CONFIG_MEMORY_HOTPLUG */
>>  
>> -#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
>> -bool mhp_memmap_on_memory(void);
>> -#else
>> -static inline bool mhp_memmap_on_memory(void)
>> -{
>> -	return false;
>> -}
>> -#endif
>> -
>>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index e66f7aa3191d..2aa5dcbfe468 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -193,6 +193,11 @@ enum pageflags {
>>  
>>  	/* Only valid for buddy pages. Used to track pages that are reported */
>>  	PG_reported = PG_uptodate,
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +	/* For self-hosted memmap pages */
>> +	PG_vmemmap_self_hosted = PG_owner_priv_1,
>> +#endif
>>  };
>>  
>>  #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
>> @@ -628,6 +633,12 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
>>   */
>>  __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
>>  
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
>> +#else
>> +PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>> +#endif
>> +
>>  /*
>>   * On an anonymous page mapped into a user virtual memory area,
>>   * page->mapping points to its anon_vma, not to a struct address_space;
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 1089ea8a9c98..73bfbb47f6a4 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -10,7 +10,7 @@
>>   */
>>  #define pr_fmt(fmt)	"HugeTLB: " fmt
>>  
>> -#include <linux/memory_hotplug.h>
>> +#include <linux/memory.h>
>>  #include "hugetlb_vmemmap.h"
>>  
>>  /*
>> @@ -97,18 +97,54 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>>  	return ret;
>>  }
>>  
>> +static unsigned int vmemmap_optimizable_pages(struct hstate *h,
>> +					      struct page *head)
>> +{
>> +	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
>> +		return 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
>> +		unsigned long pfn = page_to_pfn(head);
>> +
>> +		/*
>> +		 * Due to HugeTLB alignment requirements and the vmemmap pages
>> +		 * being at the start of the hotplugged memory region in
>> +		 * memory_hotplug.memmap_on_memory case. Checking the first
>> +		 * vmemmap page's vmemmap if it is marked as VmemmapSelfHosted
>> +		 * is sufficient.
>> +		 *
>> +		 * [                  hotplugged memory                  ]
>> +		 * [        section        ][...][        section        ]
>> +		 * [ vmemmap ][              usable memory               ]
>> +		 *   ^   |     |                                        |
>> +		 *   +---+     |                                        |
>> +		 *     ^       |                                        |
>> +		 *     +-------+                                        |
>> +		 *          ^                                           |
>> +		 *          +-------------------------------------------+
>> +		 *
>> +		 * Hotplugged memory block never has non-present sections, while
>> +		 * boot memory block can have one or more. So pfn_valid() is
>> +		 * used to filter out the non-present section which also cannot
>> +		 * be memmap_on_memory.
>> +		 */
>> +		pfn = ALIGN_DOWN(pfn, PHYS_PFN(memory_block_size_bytes()));
>> +		if (pfn_valid(pfn) && PageVmemmapSelfHosted(pfn_to_page(pfn)))
> 
> Although it works, I think PageVmemmapSelfHosted() check for the 1st pfn's
> vmemmap page is not always reliable.  Since we reused PG_owner_priv_1
> as PG_vmemmap_self_hosted, the test is noly reliable for vmemmap page's
> vmemmap page.  Other non-vmemmap page can be flagged with PG_owner_priv_1.
> So this check can be false-positive. Maybe the following code snippet is
> the solution.

How could that happen for pages used for backing a vmemmap?

> 
> Any thoughts? Oscar or David.

First of all, I think you should really avoid using
memory_block_size_bytes(); when using memory_block_size_bytes(), you
wouldn't need PageVmemmapSelfHosted(), you can just check if the vmemmap
of the page is itself. But I think we should try making this independent
of the memory block size.

If virt_to_page(page) doesn't work, maybe just traverse the direct map
to find the page backing page directly?

-- 
Thanks,

David / dhildenb

