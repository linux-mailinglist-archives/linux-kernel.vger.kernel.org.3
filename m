Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B64550315
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 07:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiFRFtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 01:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiFRFtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:49:09 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C946856C0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:49:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h192so5708863pgc.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 22:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ey5exUmFRK1EBLYrIr/8Le4r0ZlEmcblqFLjan/EQU=;
        b=3trnpp7gnxXdd07NtREkPkifSZfhUPggdO3A3d5umtQACRp2hX6rB0Jbrt85B+bFcX
         1MmfHiM+WJsIs7vUX7XB/NNnDpWYIvAMyqoxe6oUmeyNe4KmozlhLLo3alEPxZCCsfi8
         D7gxU/qeaxN/YZ09SbaVPlHulzTwEEJjM7SwFLAVebJRMt8IfDaPs65zZqUWtWRLA84P
         XCCJwfHPBALX/wC1h/HeyBst3P5j9QTQ9Ewr/G/dtINKF7Yc4n4UStusf7UIVKboXMqF
         DqHzcfsGjhX5CwEY3iz7Eknrd9sl7Q9m7kiLAy7/zj+ZwJtR0Zb1jCeVBk4ZkVoKo16q
         ESdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ey5exUmFRK1EBLYrIr/8Le4r0ZlEmcblqFLjan/EQU=;
        b=3xTYmCwWwjWPD9M8TSaqYXpprFbXVikDYwtLev2MWfCM9tlMBacUiRnBc3O4mMPmlU
         V1hDRRpF4FTeO+tcCz3t1OgdTxSW8JCzYM8XWEHR2KxRyHD+dChXQG/IjCtunyEMHA9i
         QNrcKAWD5sCzDq3VVJVC10MNuOz0be3hwv2SOznsz4kPDRZKU0ABFGolcqDYxWfffM9L
         W6qfs9PPMSZLE0pGFRPj6Vn3R8zic9v/1cv29zRVck1I9aI2sracXpe3WVYNnzlpR1mV
         GV0A+5IYxD+E7Gi/Gxv/eTiydXGbO7yT1QcKXK2B6ZC36RvXGmk9eoWgTcaOZhrUwe8I
         AHag==
X-Gm-Message-State: AJIora83Yh+NQTZxqyKqhHcTKqsLS+01qaFoVFJ0rC6gXC+43+ds0nVi
        FDUSdEstFSZF8zHNWZnX4+AOdA==
X-Google-Smtp-Source: AGRyM1uGmRCoiNjp2FulI+PX/HjGuvp4rAZlBLfQ5Q2r8Y1WjwmXV61Q58S/hipD/k5u6ADkhhqTdQ==
X-Received: by 2002:a63:6c06:0:b0:3fd:ae53:387f with SMTP id h6-20020a636c06000000b003fdae53387fmr12026279pgc.536.1655531346147;
        Fri, 17 Jun 2022 22:49:06 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903120200b00168c523032fsm4465908plh.269.2022.06.17.22.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 22:49:05 -0700 (PDT)
Date:   Sat, 18 Jun 2022 13:49:01 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <Yq1nTaV5B1WMFRtf@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqwVTT+50vt5WpeG@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 07:46:53AM +0200, Oscar Salvador wrote:
> On Thu, Jun 16, 2022 at 09:30:33AM +0200, David Hildenbrand wrote:
> > IIRC, that was used to skip these patches on the offlining path before
> > we provided the ranges to offline_pages().
> 
> Yeah, it was designed for that purpose back then.
> 
> > I'd not mess with PG_reserved, and give them a clearer name, to not
> > confuse them with other, ordinary, vmemmap pages that are not
> > self-hosted (maybe in the future we might want to flag all vmemmap pages
> > with a new type?).
> 
> Not sure whether a new type is really needed, or to put it another way, I
> cannot see the benefit.
> 
> > 
> > I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
> > (v)memmap pages with a type PG_memmap. However, the latter would be
> > optional and might not be strictly required
> > 
> > 
> > So what think could make sense is
> > 
> > /* vmemmap pages that are self-hosted and cannot be optimized/freed. */
> > PG_vmemmap_self_hosted = PG_owner_priv_1,
> 
> Sure, I just lightly tested the below, and seems to work, but not sure
> whether that is what you are referring to.
> @Munchun: thoughts?
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa3191d..a4556afd7bda 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -193,6 +193,11 @@ enum pageflags {
>  
>  	/* Only valid for buddy pages. Used to track pages that are reported */
>  	PG_reported = PG_uptodate,
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	/* For self-hosted memmap pages */
> +	PG_vmemmap_self_hosted = PG_owner_priv_1,
> +#endif
>  };
>  
>  #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
> @@ -628,6 +633,10 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
>   */
>  __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +PAGEFLAG(Vmemmap_self_hosted, vmemmap_self_hosted, PF_ANY)
> +#endif
> +
>  /*
>   * On an anonymous page mapped into a user virtual memory area,
>   * page->mapping points to its anon_vma, not to a struct address_space;
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 1089ea8a9c98..e2de7ed27e9e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));

Hi Oscar,

After more thinkging, I think here should be:

  struct mem_section *ms = __pfn_to_section(ALIGN_DOWN(page_to_pfn(head), memory_block_size_bytes()));

Why?

[                  hotplugged memory                  ]
[        section        ][...][        section        ]
[ vmemmap ][              usable memory               ]
  ^   |      |                                      |
  +---+      |                                      |
    ^        |                                      |
    +--------+                                      |
        ^                                           |
        +-------------------------------------------+

The page_to_pfn(head) can falls onto the non-1st section, actually, we desire 
1st section which ->section_mem_map is the start vmemmap of the vmemmap.
If we align the page_to_pfn(head) with the start pfn of the hotplugged memory,
then we can simplify the code further.

  unsigned long size = memory_block_size_bytes();
  unsigned long pfn = ALIGN_DOWN(page_to_pfn(head), size);

  if (pfn_valid(pfn) && PageVmemmapSelfHosted(pfn_to_page(pfn)))
          return;

Hotplugged memory block never has non-present sections, while boot memory block
can have one or more. So pfn_valid() is used to filter out the first section if
it is non-present.

Hopefully I am not wrong.

Thanks.

> +	struct page *memmap;
> +
> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> +				       pfn_to_section_nr(page_to_pfn(head)));
> +
> +	if (PageVmemmap_self_hosted(memmap))
> +		return;
>  
>  	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
>  	if (!vmemmap_pages)
> @@ -199,10 +207,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
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
> index 1213d0c67a53..863966c2c6f1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -45,8 +45,6 @@
>  #ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
>  static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
>  {
> -	if (hugetlb_optimize_vmemmap_enabled())
> -		return 0;
>  	return param_set_bool(val, kp);
>  }
>  
> @@ -1032,6 +1030,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>  {
>  	unsigned long end_pfn = pfn + nr_pages;
>  	int ret;
> +	int i;
>  
>  	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
>  	if (ret)
> @@ -1039,6 +1038,12 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
>  
>  	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
>  
> +	/*
> +	 * Let us flag self-hosted memmap
> +	 */
> +	for (i = 0; i < nr_pages; i++)
> +		SetPageVmemmap_self_hosted(pfn_to_page(pfn + i));
> +
>  	/*
>  	 * It might be that the vmemmap_pages fully span sections. If that is
>  	 * the case, mark those sections online here as otherwise they will be
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 
