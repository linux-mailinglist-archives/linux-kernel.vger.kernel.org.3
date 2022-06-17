Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146354F21C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380275AbiFQHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380716AbiFQHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9185560AB9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655451817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ReX5+Tea9DeNVBMZAkITRir8x1EyrdX1TO+zxwb4MY=;
        b=NiSS7vbZQ/bQaa8IZURu3CPxo9hdZOSojtHnn32iIPy7K+TNtvFLzpvBZ0w1Op6F7BpSMX
        /lIVbcPANeQvqZS3s9MI3O4IEdXan5gDTwWyCRYDC4YSr+1AT07tCBlb52S0/6SLGAQkkc
        J+hH9rDjv2Y/uE2ZlTtn1XDLr/L25S8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-ARVHon8zOeiNtz1SESdMJw-1; Fri, 17 Jun 2022 03:43:36 -0400
X-MC-Unique: ARVHon8zOeiNtz1SESdMJw-1
Received: by mail-wm1-f70.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so1859697wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7ReX5+Tea9DeNVBMZAkITRir8x1EyrdX1TO+zxwb4MY=;
        b=AF47+wkzmj8hRbzoak+4rfZkrP8tz2HGjXwo8pNMRCxRCoqXYIx3RlrlIQYpKYtSqE
         GIWz5UFYi0BUXvc1ZZkJskpPv+zTcLp+Zh+dxJW0a/dageOZSeHN1qcpykrChRsdwXPV
         8fWi6ATapbC8MCEj7kin7Ll3gevhAED5pHaQHRInrl54Wg39GHmVrPcG81y0S6/AuS7/
         B3nCBLPifvo7wHWXCvKr+j7gT4hkxtYdh1gyJr2TT++uJ8Gxmy+6lTaLsnj0W/zBDBwg
         MeEv1RMiZPymaqT88/l5ydXnVIrfNHnPL67dFU0Qs44DwAt/crNQCn4njTB8CkKokvmI
         GzqQ==
X-Gm-Message-State: AJIora9gcHWryVE2LbEEiafoqPTieaXXfeC3gWBo0qustt4IeMi1gXhU
        2AG8P0s4pA696b+bLSc+oDLbiTLNTqJQK9q3rHg56WrxzbP9eQRq9xTR8tTGUOELSpXfFsLdVwA
        tUd7SUi3L5tH4ooBpfYJs9oNG
X-Received: by 2002:a05:600c:1c88:b0:39d:7299:e295 with SMTP id k8-20020a05600c1c8800b0039d7299e295mr8647691wms.155.1655451815202;
        Fri, 17 Jun 2022 00:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMuSqagueU9Uty34908kiFQvwzEaIjUHGQED46YbY0HAP5x4mQF32qlzPwNjwllIDuTBStrQ==
X-Received: by 2002:a05:600c:1c88:b0:39d:7299:e295 with SMTP id k8-20020a05600c1c8800b0039d7299e295mr8647654wms.155.1655451814763;
        Fri, 17 Jun 2022 00:43:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824? (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de. [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
        by smtp.gmail.com with ESMTPSA id o20-20020a1c7514000000b0039c4ec6fdacsm4549519wmc.40.2022.06.17.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:43:34 -0700 (PDT)
Message-ID: <186924ab-651f-71a1-93d2-3500a67dffee@redhat.com>
Date:   Fri, 17 Jun 2022 09:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqwVTT+50vt5WpeG@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.22 07:46, Oscar Salvador wrote:
> On Thu, Jun 16, 2022 at 09:30:33AM +0200, David Hildenbrand wrote:
>> IIRC, that was used to skip these patches on the offlining path before
>> we provided the ranges to offline_pages().
> 
> Yeah, it was designed for that purpose back then.
> 
>> I'd not mess with PG_reserved, and give them a clearer name, to not
>> confuse them with other, ordinary, vmemmap pages that are not
>> self-hosted (maybe in the future we might want to flag all vmemmap pages
>> with a new type?).
> 
> Not sure whether a new type is really needed, or to put it another way, I
> cannot see the benefit.
> 
>>
>> I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
>> (v)memmap pages with a type PG_memmap. However, the latter would be
>> optional and might not be strictly required
>>
>>
>> So what think could make sense is
>>
>> /* vmemmap pages that are self-hosted and cannot be optimized/freed. */
>> PG_vmemmap_self_hosted = PG_owner_priv_1,
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

VmemmapSelfHosted, then the function names get nicer.

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

Why can't we check the head page directly? Either I need more coffee or
this can be simplified.

> +
> +	if (PageVmemmap_self_hosted(memmap))

Maybe that's the right place for a comment, an ascii art, and how it is
safe to only check the first vmemmap page due to alignment restrictions.

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

I think that comment can be dropped because the code does exactly that.

> +	for (i = 0; i < nr_pages; i++)
> +		SetPageVmemmap_self_hosted(pfn_to_page(pfn + i));
> +
>  	/*
>  	 * It might be that the vmemmap_pages fully span sections. If that is
>  	 * the case, mark those sections online here as otherwise they will be
> 
> 


-- 
Thanks,

David / dhildenb

