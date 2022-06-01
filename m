Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF72353A057
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351019AbiFAJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350682AbiFAJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE87C81485
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654075729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZ/lvSCNGKwkVe2wsWpi8yI8USf1ro7j7LezDFEoQgQ=;
        b=CkqwVHx42NhfexwyQuWv4NvQSlVaGN1DrL9KfJ3e1DdTa7m6MVD9kgPcYiR6fZDjZp46tC
        atE8V6boHW4+Vl/JvOSu4GsNjXp5TJ0ewRseAAow0EjH6V8JTEaHL3y581yYxMhdN6ebzH
        Cy0mVnIdMNDlFACWgr33FDeDzAmasgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-ArtyUR24N5mkN-SPbti5Cg-1; Wed, 01 Jun 2022 05:28:47 -0400
X-MC-Unique: ArtyUR24N5mkN-SPbti5Cg-1
Received: by mail-wm1-f70.google.com with SMTP id v126-20020a1cac84000000b00396fe5959d2so639187wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=CZ/lvSCNGKwkVe2wsWpi8yI8USf1ro7j7LezDFEoQgQ=;
        b=UtC+U1cws7X3Up8Odzsjsc+SgwNg4m2vPwMfCl7Vg1iVWw3i9mHTOv8dk1GL1AFJo1
         rvAIS+fBpKKABzyHhiLI0SL0Yv7M5SmkVudxBIbDUxZv4+e0DNz+nf8rN/+kS34UGcLF
         NWNsSO6FfCUjjkDWEdGIgsm2dRnMJaqrKiUljA3jJlJwb4vdtXNVafuQ7OPOp+9/7uEO
         kwTumjUhhyby2jBBZSOnpwWcwVnK9w3hdDtclZ9+0UwzODkjb+9gLBe/j5obCjws2IK0
         QpXdJHP1U/olX39MegvVuNU4hGZJMgjCIbzze0s+6AyaM58QRZaSYlP+SVXN+TNCKYv9
         9EzA==
X-Gm-Message-State: AOAM530LW6ZoTZUFLjhCcoD4KKn8+o9rystwwpmiygmujiHGTrH453ki
        bLvMbeLmTfUg7o2NurTt+oCGS/GP/qXQglhho4ERzZM0rOwuYw3TgZevnmfBb/GQbm2Dl8+/cA9
        ltLxbWo1sqE06jZpReeEpzW+m
X-Received: by 2002:adf:f110:0:b0:210:78bd:7ea5 with SMTP id r16-20020adff110000000b0021078bd7ea5mr1516588wro.459.1654075726652;
        Wed, 01 Jun 2022 02:28:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwHC46RTpBbXTxs+XEWWNK3dgFTWEHhLja0iruHFAge2nPCDwffOVtRLUjv6aul8gfXQkFmQ==
X-Received: by 2002:adf:f110:0:b0:210:78bd:7ea5 with SMTP id r16-20020adff110000000b0021078bd7ea5mr1516575wro.459.1654075726403;
        Wed, 01 Jun 2022 02:28:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id o34-20020a05600c512200b003944821105esm1592684wms.2.2022.06.01.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:28:45 -0700 (PDT)
Message-ID: <087817e3-98ce-09f6-9ae9-68e544f43775@redhat.com>
Date:   Wed, 1 Jun 2022 11:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related
 functions
In-Reply-To: <20220404074652.68024-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.22 09:46, Muchun Song wrote:
> The word of "free" is not expressive enough to express the feature of optimizing
> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> And some function names are prefixed with "huge_page" instead of "hugetlb", it is
> easily to be confused with THP.  In this patch , cheanup related functions to make
> code more clear and expressive.

No strong opinion (I remember I kicked of the discussion), but I was
wondering if instead of alloc vs. free we could be using something like
optimize vs. restore/rollback.

E.g., hugetlb_vmemmap_optimize() vs. hugetlb_vmemmap_restore().


Maybe there are other suggestions?

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |  2 +-
>  mm/hugetlb.c            | 10 +++++-----
>  mm/hugetlb_vmemmap.c    | 42 ++++++++++++++++++++----------------------
>  mm/hugetlb_vmemmap.h    | 20 ++++++++++----------
>  4 files changed, 36 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53c1b6082a4c..c16fbb1228a3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -618,7 +618,7 @@ struct hstate {
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -	unsigned int nr_free_vmemmap_pages;
> +	unsigned int optimize_vmemmap_pages;

I suggest converting that into a bool and just calling it

"bool optimize_vmemmap_pages".

You can easily compute what hugetlb_vmemmap_init() at runtime from the
page and RESERVE_VMEMMAP_NR, right?

At least the calculation in alloc_huge_page_vmemmap() and
free_huge_page_vmemmap() become *less* weird for me if the magic value
RESERVE_VMEMMAP_NR isn't used explicitly for vmemmap_addr but implicitly
for vmemmap_end.

>  #endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd642cfc538b..1f9fbdddc86b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1540,7 +1540,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> -	if (alloc_huge_page_vmemmap(h, page)) {
> +	if (hugetlb_vmemmap_alloc(h, page)) {
>  		spin_lock_irq(&hugetlb_lock);
>  		/*
>  		 * If we cannot allocate vmemmap pages, just refuse to free the
> @@ -1617,7 +1617,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>  
>  static inline void flush_free_hpage_work(struct hstate *h)
>  {
> -	if (free_vmemmap_pages_per_hpage(h))
> +	if (hugetlb_optimize_vmemmap_pages(h))

It might be reasonable to call that hugetlb_should_optimize_vmemmap()
then, letting it return a bool.



-- 
Thanks,

David / dhildenb

