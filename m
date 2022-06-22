Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9029E5540ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356132AbiFVDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFVDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:31:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E92C338A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:31:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q140so14914604pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zIckZjx7nBE8+LrtkYIITkN+RjWFo0BrzsFyrHjWsuE=;
        b=HR2ehh1THOUQ/7sVD3IxlsNn5X9iiusHdkvQi2v7mCXaSiOlWuubLTsBInnuZSMIV1
         yyrPoOAP2Ojg4Swx91s1XU/1zn/eLXNS8RszKuPDGFC8Iy92YzlnXAxGZOZR7QoG0sak
         7M2SFRlLE3VXFhvX6AL9tDSdfz1SVkR6ozIAbwvGN6mXDiBDFtpnB0e1h4PXCUfpyaRx
         Yhdv5wCO8sko56NAT6PKlZFhgDksALXFs3i3B5fU5SUnV9PjVtQvJkk00GU+tcuQYfJo
         5VOUrjb0Gl+GWLXK46LHl20wuH6c/vfxp0U7E7RUTtvHxQL3Cvv9uxzcA3Wd9Iv1winU
         V90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIckZjx7nBE8+LrtkYIITkN+RjWFo0BrzsFyrHjWsuE=;
        b=4B7it/+qbXCJhjlQSciaiHK9wjAv/rXZoieWhBkpuywyH5xgE2BuKTiM3HnWIe2zAB
         livYTLBW4tNrN9NGTKJXQs9gCuHAFQITb5/LE4xqvldAoVeYZNGdOtQtgLo/4COFkQKQ
         /fpBSKuiLK2wQT3xUWq4OQZR79FCnKH2PL4fbTw1GNoN3XrrB4AdGrJSZuLx5l8I2+eB
         tomOI1CZlVdexz3j7TaIHJih9FQXVlixJk5fJAmlozxojuWg/LwsX3FxVdm2e3RUreOd
         kNOraTsluTsMNHl+pQdg+03c56/6ze0V2/Y+VqkiMqWz4N9Hu1E4w4q2+K1c8pQ+ERk9
         20Ww==
X-Gm-Message-State: AJIora9xRGhm6C+ue3qJu35jgtNXp2iLCKp+X+sZWH/KrZdOQouG+8oY
        azrVSkVicUOXaNQSUSugR0BQxQ==
X-Google-Smtp-Source: AGRyM1t0+4a7W1b88iaY0mq5xGeMqBK/vj1Q19dBpqEycB3mZ15nOpLahQdSlpV+QlmyxdO9MwebXA==
X-Received: by 2002:a63:8341:0:b0:40d:268f:d8ed with SMTP id h62-20020a638341000000b0040d268fd8edmr1145053pge.232.1655868685123;
        Tue, 21 Jun 2022 20:31:25 -0700 (PDT)
Received: from localhost ([2404:9dc0:cd01::13])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090a951400b001d903861194sm13194409pjo.30.2022.06.21.20.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 20:31:24 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:31:21 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, david@redhat.com, mike.kravetz@oracle.com,
        osalvador@suse.de, paulmck@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 0/2] make hugetlb_optimize_vmemmap compatible with
 memmap_on_memory
Message-ID: <YrKNCRHg6PCXzg3K@FVFYT0MHHV2J.usts.net>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
 <20220621135313.ae6fbc28338f1220328694f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621135313.ae6fbc28338f1220328694f7@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 01:53:13PM -0700, Andrew Morton wrote:
> On Mon, 20 Jun 2022 19:06:14 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > This series makes hugetlb_optimize_vmemmap compatible with memmap_on_memory
> > and is based on mm-stable.  The reason refers to the patch 2's commit log.
> > 
> > v5:
> >  - Replace enum to defines per David.
> >  - Walk vmemmap page tables to avoid false-positive.
> 
> I can't see this second change in the v3->v5 deltas? 
> 

My changlog is not clear, Let me clarify it here.

v3: Drop a section flag SECTION_CANNOT_OPTIMIZE_VMEMMAP and introduce a page
    flag PageVmemmapSelfHosted to make both parameters compatible.
v4: Fix compiling error when !CONFIG_MEMORY_HOTPLUG and a bug when memory block
    spans multiple sections.
v5: Fix a bug which PageVmemmapSelfHosted() check can be false-positive.

Thanks.

> From: Muchun Song <songmuchun@bytedance.com>
> Subject: mm-memory_hotplug-enumerate-all-supported-section-flags-v5
> Date: Mon, 20 Jun 2022 19:06:15 +0800
> 
> replace enum with defines per David
>  
> Link: https://lkml.kernel.org/r/20220620110616.12056-2-songmuchun@bytedance.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/mmzone.h |   13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/mmzone.h~mm-memory_hotplug-enumerate-all-supported-section-flags-v5
> +++ a/include/linux/mmzone.h
> @@ -1439,16 +1439,13 @@ enum {
>  	SECTION_MAP_LAST_BIT,
>  };
>  
> -enum {
> -	SECTION_MARKED_PRESENT		= BIT(SECTION_MARKED_PRESENT_BIT),
> -	SECTION_HAS_MEM_MAP		= BIT(SECTION_HAS_MEM_MAP_BIT),
> -	SECTION_IS_ONLINE		= BIT(SECTION_IS_ONLINE_BIT),
> -	SECTION_IS_EARLY		= BIT(SECTION_IS_EARLY_BIT),
> +#define SECTION_MARKED_PRESENT		BIT(SECTION_MARKED_PRESENT_BIT)
> +#define SECTION_HAS_MEM_MAP		BIT(SECTION_HAS_MEM_MAP_BIT)
> +#define SECTION_IS_ONLINE		BIT(SECTION_IS_ONLINE_BIT)
> +#define SECTION_IS_EARLY		BIT(SECTION_IS_EARLY_BIT)
>  #ifdef CONFIG_ZONE_DEVICE
> -	SECTION_TAINT_ZONE_DEVICE	= BIT(SECTION_TAINT_ZONE_DEVICE_BIT),
> +#define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
>  #endif
> -};
> -
>  #define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
>  #define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
>  
> _
> 
> 
> 
> 
> From: Muchun Song <songmuchun@bytedance.com>
> Subject: mm-memory_hotplug-make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory-v5
> Date: Mon, 20 Jun 2022 19:06:16 +0800
> 
> walk vmemmap page tables to avoid false-positive
> 
> Link: https://lkml.kernel.org/r/20220620110616.12056-3-songmuchun@bytedance.com
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Co-developed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/hugetlb_vmemmap.c |   69 ++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 25 deletions(-)
> 
> --- a/mm/hugetlb_vmemmap.c~mm-memory_hotplug-make-hugetlb_optimize_vmemmap-compatible-with-memmap_on_memory-v5
> +++ a/mm/hugetlb_vmemmap.c
> @@ -10,6 +10,7 @@
>   */
>  #define pr_fmt(fmt)	"HugeTLB: " fmt
>  
> +#include <linux/memory.h>
>  #include "hugetlb_vmemmap.h"
>  
>  /*
> @@ -99,34 +100,52 @@ int hugetlb_vmemmap_alloc(struct hstate
>  static unsigned int vmemmap_optimizable_pages(struct hstate *h,
>  					      struct page *head)
>  {
> -	struct mem_section *ms;
> -	struct page *vmemmap_page;
> -	unsigned long pfn = page_to_pfn(head);
> -
>  	if (READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF)
>  		return 0;
>  
> -	ms = __pfn_to_section(pfn);
> -	vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
> -					     pfn_to_section_nr(pfn));
> -	/*
> -	 * Only the vmemmap pages' vmemmap may be marked as VmemmapSelfHosted.
> -	 *
> -	 * Due to HugeTLB alignment requirements, and the vmemmap pages being
> -	 * at the start of the hotplugged memory region. Checking any vmemmap
> -	 * page's vmemmap is fine.
> -	 *
> -	 * [      hotplugged memory     ]
> -	 * [ vmemmap ][  usable memory  ]
> -	 *   ^   |      |            |
> -	 *   +---+      |            |
> -	 *     ^        |            |
> -	 *     +--------+            |
> -	 *         ^                 |
> -	 *         +-----------------+
> -	 */
> -	if (PageVmemmapSelfHosted(vmemmap_page))
> -		return 0;
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
> +		pmd_t *pmdp, pmd;
> +		struct page *vmemmap_page;
> +		unsigned long vaddr = (unsigned long)head;
> +
> +		/*
> +		 * Only the vmemmap page's vmemmap page can be self-hosted.
> +		 * Walking the page tables to find the backing page of the
> +		 * vmemmap page.
> +		 */
> +		pmdp = pmd_off_k(vaddr);
> +		/*
> +		 * The READ_ONCE() is used to stabilize *pmdp in a register or
> +		 * on the stack so that it will stop changing under the code.
> +		 * The only concurrent operation where it can be changed is
> +		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
> +		 * operation).
> +		 */
> +		pmd = READ_ONCE(*pmdp);
> +		if (pmd_leaf(pmd))
> +			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
> +		else
> +			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));
> +		/*
> +		 * Due to HugeTLB alignment requirements and the vmemmap pages
> +		 * being at the start of the hotplugged memory region in
> +		 * memory_hotplug.memmap_on_memory case. Checking any vmemmap
> +		 * page's vmemmap page if it is marked as VmemmapSelfHosted is
> +		 * sufficient.
> +		 *
> +		 * [                  hotplugged memory                  ]
> +		 * [        section        ][...][        section        ]
> +		 * [ vmemmap ][              usable memory               ]
> +		 *   ^   |     |                                        |
> +		 *   +---+     |                                        |
> +		 *     ^       |                                        |
> +		 *     +-------+                                        |
> +		 *          ^                                           |
> +		 *          +-------------------------------------------+
> +		 */
> +		if (PageVmemmapSelfHosted(vmemmap_page))
> +			return 0;
> +	}
>  
>  	return hugetlb_optimize_vmemmap_pages(h);
>  }
> _
> 
> 
