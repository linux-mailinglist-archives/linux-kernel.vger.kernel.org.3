Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8654D896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbiFPCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFPCpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:45:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D647562
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:45:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d5so167138plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TlLQ7tosji2YkhAul6rILt0FgOyJFX5PDRocyDPTg+Y=;
        b=RI32rOnGwOPA5gsdV4n1uZ8GnPXTgWdA+QXDkeyb0Mp+N7AxQJ5cANlDDv66PpbCNx
         X53He4UMduIQt8iou2s/guBWDRDUHxKF8lNL9GcRrfi9bkRMf5I7tUyOYpW3hIBgkje8
         TlpYwGFECnzsuSBSEWdQth1qLfn+WyYmrL9GdVqyE3Eis93x0tTHwPePBQCTn/VL/Gzb
         z8c7ayKOD8mGj80driftnCEMDYQQNWgQUeCoIIC1ryRf2rOn5RjfQwM0pDycAg/Of8ng
         B1N4qWXr8thkCmsl8KsocD9FKe56EVKbZFr5FcEgvbWWkbRRiRaXQV/VvSgcoBeltqjM
         4WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlLQ7tosji2YkhAul6rILt0FgOyJFX5PDRocyDPTg+Y=;
        b=GK+twUNGELyUhp4LW5uZvUJM7PWd7s6tVOEiEXWOJ8OTqC2xcXfhZIHaJTPM6gotx5
         xiKurI5BXslORBNeTAudWcK0XSYY9N2MSyiDoY/EhYClxnl1ytIWrwT72/UY3pxkNjWY
         s6dSwpambthj1qRisW16qXs7yLWy2mT5owSWO5JBnTXAaKUU8vTxecYgYjO9NLBAW557
         vYah3XxKUZTuvQ0dVC9dOvpoMUf0BhMpq6JB8vvrfo0HN1iBhS1AJElxPfkxRk9jOEHD
         i/dqX5dHGsjjvHZ0JlmzbJ8ninOZpoc0aCJmk6wlyhMR2FgM70e+Cf/A6aQNoc0TPNVK
         LlZw==
X-Gm-Message-State: AJIora/+1pOLDjFBnB7cuk7zdOoDhLOZtZCmDz1DXFPwdRGjCtkIGak0
        yha7rKL7eNuhLv8msEqz5DJS9g==
X-Google-Smtp-Source: AGRyM1sCcm3nUs0MXMRNeFgPdlkO8phixsKPfk6BM/du3+VL+6b8V8UFzHEPRaCM2/QPj94/XqqBdg==
X-Received: by 2002:a17:90a:e7d2:b0:1e8:97ac:da0b with SMTP id kb18-20020a17090ae7d200b001e897acda0bmr13451995pjb.242.1655347520681;
        Wed, 15 Jun 2022 19:45:20 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090aaa1000b001e3351cb7fbsm2514708pjq.28.2022.06.15.19.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 19:45:20 -0700 (PDT)
Date:   Thu, 16 Jun 2022 10:45:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqqZOj+zby1fLGv/@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:51:49AM +0200, David Hildenbrand wrote:
> On 20.05.22 04:55, Muchun Song wrote:
> > For now, the feature of hugetlb_free_vmemmap is not compatible with the
> > feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
> > takes precedence over memory_hotplug.memmap_on_memory. However, someone
> > wants to make memory_hotplug.memmap_on_memory takes precedence over
> > hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
> > succeed memory hotplug in close-to-OOM situations.  So the decision
> > of making hugetlb_free_vmemmap take precedence is not wise and elegant.
> > The proper approach is to have hugetlb_vmemmap.c do the check whether
> > the section which the HugeTLB pages belong to can be optimized.  If
> > the section's vmemmap pages are allocated from the added memory block
> > itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
> > otherwise, do the optimization.  Then both kernel parameters are
> > compatible.  So this patch introduces SECTION_CANNOT_OPTIMIZE_VMEMMAP
> > to indicate whether the section could be optimized.
> > 
> 
> In theory, we have that information stored in the relevant memory block,
> but I assume that lookup in the xarray + locking is impractical.
> 
> I wonder if we can derive that information simply from the vmemmap pages
> themselves, because *drumroll*
> 
> For one vmemmap page (the first one), the vmemmap corresponds to itself
> -- what?!
> 
> 
> [	hotplugged memory	]
> [ memmap ][      usable memory	]
>       |    |                    |
>   ^---     |                    |
>    ^-------                     |
>          ^----------------------
> 
> The memmap of the first page of hotplugged memory falls onto itself.
> We'd have to derive from actual "usable memory" that condition.
>
> 
> We currently support memmap_on_memory memory only within fixed-size
> memory blocks. So "hotplugged memory" is guaranteed to be aligned to
> memory_block_size_bytes() and the size is memory_block_size_bytes().
> 
> If we'd have a page falling into usbale memory, we'd simply lookup the
> first page and test if the vmemmap maps to itself.
>

I think this can work. Should we use this approach in next version?

> 
> Of course, once we'd support variable-sized memory blocks, it would be
> different.
> 
> 
> An easier/future-proof approach might simply be flagging the vmemmap
> pages as being special. We reuse page flags for that, which don't have
> semantics yet (i.e., PG_reserved indicates a boot-time allocation via
> memblock).
>

I think you mean flag vmemmap pages' struct page as PG_reserved if it
can be optimized, right? When the vmemmap pages are allocated in
hugetlb_vmemmap_alloc(), is it valid to flag them as PG_reserved (they
are allocated from buddy allocator not memblock)?

Thanks.

> You'd walk the applicable vmemmap pages you want to optimize and check
> if they are marked as special. You don't have to walk all but can
> optimize: memmap_on_memory uses a vmemmap size that's at least PMD_SIZE.
> So it's sufficient to check a single vmemmap page inside a PMD_SIZE
> vmemmap range.
> 
> 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 22 +++++++++----------
> >  Documentation/admin-guide/sysctl/vm.rst         |  5 ++---
> >  include/linux/memory_hotplug.h                  |  9 --------
> >  include/linux/mmzone.h                          | 17 +++++++++++++++
> >  mm/hugetlb_vmemmap.c                            | 28 ++++++++++++++++++-------
> >  mm/memory_hotplug.c                             | 22 +++++++------------
> >  mm/sparse.c                                     |  8 +++++++
> >  7 files changed, 66 insertions(+), 45 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index c087f578d9d8..5359ffb04a84 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1730,9 +1730,11 @@
> >  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
> >  			the default is on.
> >  
> > -			This is not compatible with memory_hotplug.memmap_on_memory.
> > -			If both parameters are enabled, hugetlb_free_vmemmap takes
> > -			precedence over memory_hotplug.memmap_on_memory.
> > +			Note that the vmemmap pages may be allocated from the added
> > +			memory block itself when memory_hotplug.memmap_on_memory is
> > +			enabled, those vmemmap pages cannot be optimized even if this
> > +			feature is enabled.  Other vmemmap pages not allocated from
> > +			the added memory block itself do not be affected.
> >  
> >  	hung_task_panic=
> >  			[KNL] Should the hung task detector generate panics.
> > @@ -3077,10 +3079,12 @@
> >  			[KNL,X86,ARM] Boolean flag to enable this feature.
> >  			Format: {on | off (default)}
> >  			When enabled, runtime hotplugged memory will
> > -			allocate its internal metadata (struct pages)
> > -			from the hotadded memory which will allow to
> > -			hotadd a lot of memory without requiring
> > -			additional memory to do so.
> > +			allocate its internal metadata (struct pages,
> > +			those vmemmap pages cannot be optimized even
> > +			if hugetlb_free_vmemmap is enabled) from the
> > +			hotadded memory which will allow to hotadd a
> > +			lot of memory without requiring additional
> > +			memory to do so.
> >  			This feature is disabled by default because it
> >  			has some implication on large (e.g. GB)
> >  			allocations in some configurations (e.g. small
> > @@ -3090,10 +3094,6 @@
> >  			Note that even when enabled, there are a few cases where
> >  			the feature is not effective.
> >  
> > -			This is not compatible with hugetlb_free_vmemmap. If
> > -			both parameters are enabled, hugetlb_free_vmemmap takes
> > -			precedence over memory_hotplug.memmap_on_memory.
> > -
> >  	memtest=	[KNL,X86,ARM,M68K,PPC,RISCV] Enable memtest
> >  			Format: <integer>
> >  			default : 0 <disable>
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index 5c9aa171a0d3..d7374a1e8ac9 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -565,9 +565,8 @@ See Documentation/admin-guide/mm/hugetlbpage.rst
> >  hugetlb_optimize_vmemmap
> >  ========================
> >  
> > -This knob is not available when memory_hotplug.memmap_on_memory (kernel parameter)
> > -is configured or the size of 'struct page' (a structure defined in
> > -include/linux/mm_types.h) is not power of two (an unusual system config could
> > +This knob is not available when the size of 'struct page' (a structure defined
> > +in include/linux/mm_types.h) is not power of two (an unusual system config could
> >  result in this).
> >  
> >  Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap pages
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 20d7edf62a6a..e0b2209ab71c 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -351,13 +351,4 @@ void arch_remove_linear_mapping(u64 start, u64 size);
> >  extern bool mhp_supports_memmap_on_memory(unsigned long size);
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> >  
> > -#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> > -bool mhp_memmap_on_memory(void);
> > -#else
> > -static inline bool mhp_memmap_on_memory(void)
> > -{
> > -	return false;
> > -}
> > -#endif
> > -
> >  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 2cf2a76535ab..607a4fcabbd4 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1434,6 +1434,7 @@ extern size_t mem_section_usage_size(void);
> >  	MAPPER(IS_ONLINE)							\
> >  	MAPPER(IS_EARLY)							\
> >  	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
> > +	MAPPER(CANNOT_OPTIMIZE_VMEMMAP, CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)	\
> >  	MAPPER(MAP_LAST_BIT)
> >  
> >  #define __SECTION_SHIFT_FLAG_MAPPER_0(x)
> > @@ -1471,6 +1472,22 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
> >  	return (struct page *)map;
> >  }
> >  
> > +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> > +static inline void section_mark_cannot_optimize_vmemmap(struct mem_section *ms)
> > +{
> > +	ms->section_mem_map |= SECTION_CANNOT_OPTIMIZE_VMEMMAP;
> > +}
> > +
> > +static inline int section_cannot_optimize_vmemmap(struct mem_section *ms)
> > +{
> > +	return (ms && (ms->section_mem_map & SECTION_CANNOT_OPTIMIZE_VMEMMAP));
> > +}
> > +#else
> > +static inline void section_mark_cannot_optimize_vmemmap(struct mem_section *ms)
> > +{
> > +}
> > +#endif
> > +
> >  static inline int present_section(struct mem_section *section)
> >  {
> >  	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index fcd9f7872064..f12170520337 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -97,18 +97,32 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
> >  	return ret;
> >  }
> >  
> > +static unsigned int optimizable_vmemmap_pages(struct hstate *h,
> > +					      struct page *head)
> > +{
> > +	unsigned long pfn = page_to_pfn(head);
> > +	unsigned long end = pfn + pages_per_huge_page(h);
> > +
> > +	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> > +		return 0;
> > +
> > +	for (; pfn < end; pfn += PAGES_PER_SECTION) {
> > +		if (section_cannot_optimize_vmemmap(__pfn_to_section(pfn)))
> > +			return 0;
> > +	}
> > +
> > +	return hugetlb_optimize_vmemmap_pages(h);
> > +}
> > +
> >  void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >  {
> >  	unsigned long vmemmap_addr = (unsigned long)head;
> >  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> >  
> > -	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
> > +	vmemmap_pages = optimizable_vmemmap_pages(h, head);
> >  	if (!vmemmap_pages)
> >  		return;
> >  
> > -	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
> > -		return;
> > -
> >  	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> >  
> >  	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
> > @@ -199,10 +213,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
> >  static __init int hugetlb_vmemmap_sysctls_init(void)
> >  {
> >  	/*
> > -	 * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
> > -	 * crosses page boundaries, the vmemmap pages cannot be optimized.
> > +	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> > +	 * be optimized.
> >  	 */
> > -	if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
> > +	if (is_power_of_2(sizeof(struct page)))
> >  		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> >  
> >  	return 0;
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 3b360eda933f..7309694c4dee 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -43,30 +43,22 @@
> >  #include "shuffle.h"
> >  
> >  #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> > -static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
> > -{
> > -	if (hugetlb_optimize_vmemmap_enabled())
> > -		return 0;
> > -	return param_set_bool(val, kp);
> > -}
> > -
> > -static const struct kernel_param_ops memmap_on_memory_ops = {
> > -	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
> > -	.set	= memmap_on_memory_set,
> > -	.get	= param_get_bool,
> > -};
> > -
> >  /*
> >   * memory_hotplug.memmap_on_memory parameter
> >   */
> >  static bool memmap_on_memory __ro_after_init;
> > -module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
> > +module_param(memmap_on_memory, bool, 0444);
> >  MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> >  
> > -bool mhp_memmap_on_memory(void)
> > +static inline bool mhp_memmap_on_memory(void)
> >  {
> >  	return memmap_on_memory;
> >  }
> > +#else
> > +static inline bool mhp_memmap_on_memory(void)
> > +{
> > +	return false;
> > +}
> >  #endif
> >  
> >  enum {
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index cb3bfae64036..1f353bf9ea6b 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -913,6 +913,14 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >  	ms = __nr_to_section(section_nr);
> >  	set_section_nid(section_nr, nid);
> >  	__section_mark_present(ms, section_nr);
> > +	/*
> > +	 * Mark whole section as non-optimizable once there is a subsection
> > +	 * whose vmemmap pages are allocated from alternative allocator. The
> > +	 * early section is always optimizable since the early section's
> > +	 * vmemmap pages do not consider partially being populated.
> > +	 */
> > +	if (!early_section(ms) && altmap)
> > +		section_mark_cannot_optimize_vmemmap(ms);
> >  
> >  	/* Align memmap to section boundary in the subsection case */
> >  	if (section_nr_to_pfn(section_nr) != start_pfn)
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
