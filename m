Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C139154C51B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbiFOJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFOJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A3E84990E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655286714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzhK/uM75+iNlTxTq2fOYQKWjpeiMBa4/XrK5IXG+tQ=;
        b=TVREx2Vr+OkBqfRe596mQtvS/z5N6/3aIQGX936uTUCUh96K79GqM0uglFD7N/IZL13uEJ
        RWKyCEOMIj1sgOsQiWDhoLewH9S+IMvWGYypxZNYfOrZedAONfRgC5cbX0X+8y513bmCme
        38vRowjoTXVxMUycOVJN7f59BoKp65g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-fsVyqWwyOwe8LmTrEzryOA-1; Wed, 15 Jun 2022 05:51:52 -0400
X-MC-Unique: fsVyqWwyOwe8LmTrEzryOA-1
Received: by mail-wr1-f71.google.com with SMTP id w8-20020adfde88000000b00213b7fa3a37so1693988wrl.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pzhK/uM75+iNlTxTq2fOYQKWjpeiMBa4/XrK5IXG+tQ=;
        b=yv8edPvc3mEdJdVYZPxVOMVFETXNPM9/g/0e3BVXobvQ6EXRL4Pq+Cftk/zipv5LBn
         BWMXhpGtH8M8D47oq1wpPtJRAvZ21o1rTGcuJMdIZU/u4Spjgudp/byECu+LyJWzlUw5
         TsCJCruEVqi2xdc3GlA5CMIg1/tMF5QFV6zyjVZdjoySkBdUauy9IABa5EYN7p9LO0Fp
         9kUpYMW6h9r9halVC3SCn1/v2lyu0SHH6qiUP/rJcWc/f3R4m3j3TijiRpbRho/otlkx
         QnLD9xQ5h5w3oK6mXw2R36MLYzGsp2iRMhqhJ4mJ6MKwYplQxmDyJNvBLCgN8dnFBImR
         vk3g==
X-Gm-Message-State: AJIora88qAGp5SPzdXNu5GFDilDZXMqFyMXvQfhS+6GesRyu1SaDmBvr
        a4CZAZrqHQvbRKiF8OIPQx8o6jLLBLDmCLgjiWBQrnBw20wX+xmQ0/8ITMYCtSKgJW06swSFf5E
        LCI77dxVFLSx3RasMr7U64oRO
X-Received: by 2002:a5d:4849:0:b0:218:3f35:5336 with SMTP id n9-20020a5d4849000000b002183f355336mr8992671wrs.26.1655286711426;
        Wed, 15 Jun 2022 02:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1td2l7DmivUZFqhaBVgslciRsFUwlBqKE6ez7RhO+Tx+JKUWQH74nVvrfQ1z09zQSXkD/zBVA==
X-Received: by 2002:a5d:4849:0:b0:218:3f35:5336 with SMTP id n9-20020a5d4849000000b002183f355336mr8992629wrs.26.1655286711005;
        Wed, 15 Jun 2022 02:51:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id q185-20020a1c43c2000000b0039c3056c3dfsm2119000wma.27.2022.06.15.02.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:51:50 -0700 (PDT)
Message-ID: <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
Date:   Wed, 15 Jun 2022 11:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
In-Reply-To: <20220520025538.21144-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.22 04:55, Muchun Song wrote:
> For now, the feature of hugetlb_free_vmemmap is not compatible with the
> feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
> takes precedence over memory_hotplug.memmap_on_memory. However, someone
> wants to make memory_hotplug.memmap_on_memory takes precedence over
> hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
> succeed memory hotplug in close-to-OOM situations.  So the decision
> of making hugetlb_free_vmemmap take precedence is not wise and elegant.
> The proper approach is to have hugetlb_vmemmap.c do the check whether
> the section which the HugeTLB pages belong to can be optimized.  If
> the section's vmemmap pages are allocated from the added memory block
> itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
> otherwise, do the optimization.  Then both kernel parameters are
> compatible.  So this patch introduces SECTION_CANNOT_OPTIMIZE_VMEMMAP
> to indicate whether the section could be optimized.
> 

In theory, we have that information stored in the relevant memory block,
but I assume that lookup in the xarray + locking is impractical.

I wonder if we can derive that information simply from the vmemmap pages
themselves, because *drumroll*

For one vmemmap page (the first one), the vmemmap corresponds to itself
-- what?!


[	hotplugged memory	]
[ memmap ][      usable memory	]
      |    |                    |
  ^---     |                    |
   ^-------                     |
         ^----------------------

The memmap of the first page of hotplugged memory falls onto itself.
We'd have to derive from actual "usable memory" that condition.


We currently support memmap_on_memory memory only within fixed-size
memory blocks. So "hotplugged memory" is guaranteed to be aligned to
memory_block_size_bytes() and the size is memory_block_size_bytes().

If we'd have a page falling into usbale memory, we'd simply lookup the
first page and test if the vmemmap maps to itself.


Of course, once we'd support variable-sized memory blocks, it would be
different.


An easier/future-proof approach might simply be flagging the vmemmap
pages as being special. We reuse page flags for that, which don't have
semantics yet (i.e., PG_reserved indicates a boot-time allocation via
memblock).

You'd walk the applicable vmemmap pages you want to optimize and check
if they are marked as special. You don't have to walk all but can
optimize: memmap_on_memory uses a vmemmap size that's at least PMD_SIZE.
So it's sufficient to check a single vmemmap page inside a PMD_SIZE
vmemmap range.


> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 22 +++++++++----------
>  Documentation/admin-guide/sysctl/vm.rst         |  5 ++---
>  include/linux/memory_hotplug.h                  |  9 --------
>  include/linux/mmzone.h                          | 17 +++++++++++++++
>  mm/hugetlb_vmemmap.c                            | 28 ++++++++++++++++++-------
>  mm/memory_hotplug.c                             | 22 +++++++------------
>  mm/sparse.c                                     |  8 +++++++
>  7 files changed, 66 insertions(+), 45 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c087f578d9d8..5359ffb04a84 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1730,9 +1730,11 @@
>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>  			the default is on.
>  
> -			This is not compatible with memory_hotplug.memmap_on_memory.
> -			If both parameters are enabled, hugetlb_free_vmemmap takes
> -			precedence over memory_hotplug.memmap_on_memory.
> +			Note that the vmemmap pages may be allocated from the added
> +			memory block itself when memory_hotplug.memmap_on_memory is
> +			enabled, those vmemmap pages cannot be optimized even if this
> +			feature is enabled.  Other vmemmap pages not allocated from
> +			the added memory block itself do not be affected.
>  
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
> @@ -3077,10 +3079,12 @@
>  			[KNL,X86,ARM] Boolean flag to enable this feature.
>  			Format: {on | off (default)}
>  			When enabled, runtime hotplugged memory will
> -			allocate its internal metadata (struct pages)
> -			from the hotadded memory which will allow to
> -			hotadd a lot of memory without requiring
> -			additional memory to do so.
> +			allocate its internal metadata (struct pages,
> +			those vmemmap pages cannot be optimized even
> +			if hugetlb_free_vmemmap is enabled) from the
> +			hotadded memory which will allow to hotadd a
> +			lot of memory without requiring additional
> +			memory to do so.
>  			This feature is disabled by default because it
>  			has some implication on large (e.g. GB)
>  			allocations in some configurations (e.g. small
> @@ -3090,10 +3094,6 @@
>  			Note that even when enabled, there are a few cases where
>  			the feature is not effective.
>  
> -			This is not compatible with hugetlb_free_vmemmap. If
> -			both parameters are enabled, hugetlb_free_vmemmap takes
> -			precedence over memory_hotplug.memmap_on_memory.
> -
>  	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
>  			Format: <integer>
>  			default : 0 <disable>
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 5c9aa171a0d3..d7374a1e8ac9 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -565,9 +565,8 @@ See Documentation/admin-guide/mm/hugetlbpage.rst
>  hugetlb_optimize_vmemmap
>  ========================
>  
> -This knob is not available when memory_hotplug.memmap_on_memory (kernel parameter)
> -is configured or the size of 'struct page' (a structure defined in
> -include/linux/mm_types.h) is not power of two (an unusual system config could
> +This knob is not available when the size of 'struct page' (a structure defined
> +in include/linux/mm_types.h) is not power of two (an unusual system config could
>  result in this).
>  
>  Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 20d7edf62a6a..e0b2209ab71c 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -351,13 +351,4 @@ void arch_remove_linear_mapping(u64 start, u64 size);
>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
> -#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> -bool mhp_memmap_on_memory(void);
> -#else
> -static inline bool mhp_memmap_on_memory(void)
> -{
> -	return false;
> -}
> -#endif
> -
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 2cf2a76535ab..607a4fcabbd4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1434,6 +1434,7 @@ extern size_t mem_section_usage_size(void);
>  	MAPPER(IS_ONLINE)							\
>  	MAPPER(IS_EARLY)							\
>  	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
> +	MAPPER(CANNOT_OPTIMIZE_VMEMMAP, CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	\
>  	MAPPER(MAP_LAST_BIT)
>  
>  #define __SECTION_SHIFT_FLAG_MAPPER_0(x)
> @@ -1471,6 +1472,22 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  	return (struct page *)map;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +static inline void section_mark_cannot_optimize_vmemmap(struct mem_section *ms)
> +{
> +	ms->section_mem_map |= SECTION_CANNOT_OPTIMIZE_VMEMMAP;
> +}
> +
> +static inline int section_cannot_optimize_vmemmap(struct mem_section *ms)
> +{
> +	return (ms && (ms->section_mem_map & SECTION_CANNOT_OPTIMIZE_VMEMMAP));
> +}
> +#else
> +static inline void section_mark_cannot_optimize_vmemmap(struct mem_section *ms)
> +{
> +}
> +#endif
> +
>  static inline int present_section(struct mem_section *section)
>  {
>  	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fcd9f7872064..f12170520337 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -97,18 +97,32 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
>  	return ret;
>  }
>  
> +static unsigned int optimizable_vmemmap_pages(struct hstate *h,
> +					      struct page *head)
> +{
> +	unsigned long pfn = page_to_pfn(head);
> +	unsigned long end = pfn + pages_per_huge_page(h);
> +
> +	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> +		return 0;
> +
> +	for (; pfn < end; pfn += PAGES_PER_SECTION) {
> +		if (section_cannot_optimize_vmemmap(__pfn_to_section(pfn)))
> +			return 0;
> +	}
> +
> +	return hugetlb_optimize_vmemmap_pages(h);
> +}
> +
>  void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
>  
> -	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
> +	vmemmap_pages = optimizable_vmemmap_pages(h, head);
>  	if (!vmemmap_pages)
>  		return;
>  
> -	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> -		return;
> -
>  	static_branch_inc(&hugetlb_optimize_vmemmap_key);
>  
>  	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
> @@ -199,10 +213,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
>  static __init int hugetlb_vmemmap_sysctls_init(void)
>  {
>  	/*
> -	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
> -	 * crosses page boundaries, the vmemmap pages cannot be optimized.
> +	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> +	 * be optimized.
>  	 */
> -	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
> +	if (is_power_of_2(sizeof(struct page)))
>  		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
>  
>  	return 0;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 3b360eda933f..7309694c4dee 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -43,30 +43,22 @@
>  #include "shuffle.h"
>  
>  #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> -static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
> -{
> -	if (hugetlb_optimize_vmemmap_enabled())
> -		return 0;
> -	return param_set_bool(val, kp);
> -}
> -
> -static const struct kernel_param_ops memmap_on_memory_ops = {
> -	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
> -	.set	= memmap_on_memory_set,
> -	.get	= param_get_bool,
> -};
> -
>  /*
>   * memory_hotplug.memmap_on_memory parameter
>   */
>  static bool memmap_on_memory __ro_after_init;
> -module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
> +module_param(memmap_on_memory, bool, 0444);
>  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
>  
> -bool mhp_memmap_on_memory(void)
> +static inline bool mhp_memmap_on_memory(void)
>  {
>  	return memmap_on_memory;
>  }
> +#else
> +static inline bool mhp_memmap_on_memory(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  enum {
> diff --git a/mm/sparse.c b/mm/sparse.c
> index cb3bfae64036..1f353bf9ea6b 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -913,6 +913,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>  	ms = __nr_to_section(section_nr);
>  	set_section_nid(section_nr, nid);
>  	__section_mark_present(ms, section_nr);
> +	/*
> +	 * Mark whole section as non-optimizable once there is a subsection
> +	 * whose vmemmap pages are allocated from alternative allocator. The
> +	 * early section is always optimizable since the early section's
> +	 * vmemmap pages do not consider partially being populated.
> +	 */
> +	if (!early_section(ms) && altmap)
> +		section_mark_cannot_optimize_vmemmap(ms);
>  
>  	/* Align memmap to section boundary in the subsection case */
>  	if (section_nr_to_pfn(section_nr) != start_pfn)


-- 
Thanks,

David / dhildenb

