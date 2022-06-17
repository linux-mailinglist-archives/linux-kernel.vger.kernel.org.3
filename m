Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA254F1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380648AbiFQH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380635AbiFQH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:28:31 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494542EC1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:28:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y196so3488226pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b+rfEXZ4GLjjuoJrw+X3apDxL7fB3SJwlxuDhP2gRLw=;
        b=leZzHlDaC8chjBI7eid/Y9ny7U2cJ+x+zmGOgrvGGE1xkxPQkQTRxjqbgsVMU8d61S
         MJURzbBcc6/juGlbN4N35Yz7V4IVU3RwsYfHHbaSPNuMyF5n9cGP8pel686dKGoM+wXb
         ys2D6FHgNTZht3H6j/QNYqVT6BGCYsS7NN75/SV9tAvqbwxa/0M9zyAeo6DcAD7CrohQ
         tA/3kMuObtUuAiWO0fgRHs+Yd3ctpmZtMVfA5UPwMV0bn4ENYe0PEPEQQa67p3MkbGXI
         LlEdU9OxqmO92e4s5x0A3zmS9OLwPBmB3mNuFLxuc4WkggOpzJHGS1vEGrrAeaWVlV6D
         E96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+rfEXZ4GLjjuoJrw+X3apDxL7fB3SJwlxuDhP2gRLw=;
        b=RqS1vrzTxePofHFMejOeNnS2XItfB45+1+1Q+/Bz+aZRnIun1gXylzIqAboxIji2WU
         TkFMkQkRdR4dK7Llg13jiwaZNaDWZFY85+0TBM0xLfb3Ly3PGZtcoXbWeJzGNfsxAEUf
         N+dBd8PL9v/zhS9+qnRGnoq5sqqh0zqYNYZ6MJNwKRFWVQX3rfVHphF8gBgHlHSiSJVF
         j59WsngvI6SZwDREwBvCEIWDi8CXYPKNfyCkGo+HBRwWQfyWDhHo/fgZgc5OfEduPQ5X
         vMoltLm6YeYT/fXWxaHf9sGAPHRQq1Op8dE35hvqLQIQn7upXJKOSmzwSIoZ5h61KVv7
         J4qw==
X-Gm-Message-State: AJIora+rbItxTbGUsNMaYuY6wlU3Jus2iLgSfhg6DOrVVsHVNkr3JCXD
        YaQZHtkcgsSosWEZlFSAv/dJRg==
X-Google-Smtp-Source: AGRyM1vPPlph1s3ty+1w5MCA25O8Zvoml/8ArR/MhH1gDvCSAS1ZGO+v2FWHyehTw4AAB+zn8ryF4Q==
X-Received: by 2002:a63:8648:0:b0:3fd:980d:8de4 with SMTP id x69-20020a638648000000b003fd980d8de4mr7767738pgd.198.1655450896206;
        Fri, 17 Jun 2022 00:28:16 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p15-20020a170903248f00b00163c6ac211fsm584071plw.111.2022.06.17.00.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:28:14 -0700 (PDT)
Date:   Fri, 17 Jun 2022 15:28:10 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqwtCu2Ura+skV3B@FVFYT0MHHV2J.usts.net>
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

I think it works and fits my requirement.

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
> +	struct page *memmap;
> +
> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> +				       pfn_to_section_nr(page_to_pfn(head)));
> +
> +	if (PageVmemmap_self_hosted(memmap))
> +		return;

I think here needs a loop if it is a 1GB page (spans multiple sections).
Right?  Here is an implementation based on another approach. But I think
your implementation is more simpler and efficient.  Would you mind me
squash your diff into my patch and with your "Co-developed-by"?

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fcd9f7872064..46d637acc15e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,7 +10,7 @@
  */
 #define pr_fmt(fmt)    "HugeTLB: " fmt

-#include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include "hugetlb_vmemmap.h"

 /*
@@ -97,18 +97,79 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
        return ret;
 }

+/*
+ * The vmemmap of the first page of hotplugged memory falls onto itself when
+ * memory_hotplug.memmap_on_memory is enabled, and the vmemmap pages cannot be
+ * optimized in this case.  We can simply lookup the first page and test if
+ * the vmemmap maps to itself to detect if memory_hotplug.memmap_on_memory is
+ * enabled for this memory block.
+ *
+ * [      hotplugged memory     ]
+ * [ vmemmap ][  usable memory  ]
+ *   ^   |      |            |
+ *   +---+      |            |
+ *     ^        |            |
+ *     +--------+            |
+ *         ^                 |
+ *         +-----------------+
+ */
+static bool memory_block_vmemmap_optimizable(unsigned long start_pfn)
+{
+       pmd_t *pmdp, pmd;
+       unsigned long pfn, vaddr;
+
+       vaddr = (unsigned long)pfn_to_page(start_pfn);
+       pmdp = pmd_off_k(vaddr);
+       /*
+        * The READ_ONCE() is used to stabilize *pmdp in a register or on
+        * the stack so that it will stop changing under the code.
+        */
+       pmd = READ_ONCE(*pmdp);
+
+       if (pmd_large(pmd))
+               pfn = pmd_pfn(pmd);
+       else
+               pfn = pte_pfn(*pte_offset_kernel(pmdp, vaddr));
+
+       return pfn != start_pfn;
+}
+
+static unsigned int optimizable_vmemmap_pages(struct hstate *h,
+                                             struct page *head)
+{
+       unsigned long size = memory_block_size_bytes();
+       unsigned long pfn = page_to_pfn(head);
+       unsigned long start = ALIGN_DOWN(pfn, size);
+       unsigned long end = start + pages_per_huge_page(h);
+
+       if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
+               return 0;
+
+       for (; start < end; start += size) {
+               /*
+                * Fast path. The early section is always optimizable since the
+                * early section's vmemmap pages do not allocated from the added
+                * memory block itself.
+                */
+               if (early_section(__pfn_to_section(start + (pfn & PAGE_SECTION_MASK))))
+                       continue;
+
+               if (!memory_block_vmemmap_optimizable(start))
+                       return 0;
+       }
+
+       return hugetlb_optimize_vmemmap_pages(h);
+}
+
 void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 {
        unsigned long vmemmap_addr = (unsigned long)head;
        unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;

-       vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
+       vmemmap_pages = optimizable_vmemmap_pages(h, head);
        if (!vmemmap_pages)
                return;

-       if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
-               return;
-
        static_branch_inc(&hugetlb_optimize_vmemmap_key);

        vmemmap_addr    += RESERVE_VMEMMAP_SIZE;
@@ -199,10 +260,10 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 static __init int hugetlb_vmemmap_sysctls_init(void)
 {
        /*
-        * If "memory_hotplug.memmap_on_memory" is enabled or "struct page"
-        * crosses page boundaries, the vmemmap pages cannot be optimized.
+        * If "struct page" crosses page boundaries, the vmemmap pages cannot
+        * be optimized.
         */
-       if (!mhp_memmap_on_memory() && is_power_of_2(sizeof(struct page)))
+       if (is_power_of_2(sizeof(struct page)))
                register_sysctl_init("vm", hugetlb_vmemmap_sysctls);

        return 0;

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
