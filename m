Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE7553D92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355600AbiFUVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355139AbiFUVXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A6D05FF7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655846015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2ZyEjz/X1rrSRyY38O7XcVSbvfO1EBTiv9ehORRiiM=;
        b=amlFTC61cxaMpJAJOk7D9m9lnlqVWMxEAopTgTXzBpiliSYNg3e53VVgIaN8Pr2Io3QMzU
        CoJ2dAPtBXM36VqI/3/NblxCQnfnJumBNMx1tvsJvWYuwq0J7fXuZAgaKlGQpnIJtUcvtc
        ExI1L3NnvSoBHRS0gJIFtpjpd/X6RNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-hrp6LAabP5WbMd84IijUfg-1; Tue, 21 Jun 2022 17:13:34 -0400
X-MC-Unique: hrp6LAabP5WbMd84IijUfg-1
Received: by mail-wm1-f71.google.com with SMTP id h205-20020a1c21d6000000b0039c96ec500fso8963349wmh.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=p2ZyEjz/X1rrSRyY38O7XcVSbvfO1EBTiv9ehORRiiM=;
        b=2YFa9ag35AUUZk2F79IWPyjDVjZUWO1xT86vRU3bWTgCaIoJEJxsO3BshVdrKdBV0r
         bjbgVl7MZJWwA0N9BIE1e+QIWmcPTd8VmQRlT39YYbJWVIH1Kfg0gtc6jdGeDbNJlUnx
         IWLYTV8E5UnqZM2Ir+38LNFVUI6ZLgnVEliICBZhQSIhmetRGBMqIhwyUAUstQrRmKE2
         B/FNSg0Wzyr2HtV9omMcoR2HNdET+yByqeEM46c2IAdRmOW2BIderoU5lkrXO4uHRmsG
         vXTYiRdpDMremBSMK5lGk5m2B2q2CfNeV7oXvCY0liMrpdWPCJ+rXkk+SG8I3KUgOUrN
         cFUw==
X-Gm-Message-State: AOAM530CuBtDVkzNBk707oFYZG4t61FRTJM3OGH1HjFvUVAWAbuVsIye
        ZbPQaPKHN/5RgB0qT0ZO3h0qcF+FF3ZNdtp8AFtguULck7VsBYRLS3hfK7IUkpyWN96a4HMIhNb
        cgPfFqY2B3FvbxURz6DUJ5QzF
X-Received: by 2002:a05:600c:583:b0:39c:3637:b9f with SMTP id o3-20020a05600c058300b0039c36370b9fmr41890250wmd.79.1655846013138;
        Tue, 21 Jun 2022 14:13:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOeKyTVNcHGO8XIrslQyDEH0amifKDQHgWoO8MHT556YVEyS90MtqIiT8yBXXL779Lr60M4g==
X-Received: by 2002:a05:600c:583:b0:39c:3637:b9f with SMTP id o3-20020a05600c058300b0039c36370b9fmr41890234wmd.79.1655846012925;
        Tue, 21 Jun 2022 14:13:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:bc00:a63c:7e37:6061:1706? (p200300cbc705bc00a63c7e3760611706.dip0.t-ipconnect.de. [2003:cb:c705:bc00:a63c:7e37:6061:1706])
        by smtp.gmail.com with ESMTPSA id 64-20020a1c1943000000b0039c6390730bsm22251249wmz.29.2022.06.21.14.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:13:32 -0700 (PDT)
Message-ID: <5d3bf51b-3bba-3bd4-db1f-1c0a3930a1e4@redhat.com>
Date:   Tue, 21 Jun 2022 23:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-11-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This simplifies the implementation and is faster than using the linked
> list.
> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@oracle.com
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/mmap.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6be7833c781b..d7e6baa2f40f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -675,29 +675,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
>  
>  	return 0;
>  }
> +
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
>  		unsigned long addr, unsigned long end)
>  {
> -	unsigned long nr_pages = 0;
> +	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
> +	unsigned long nr_pages = 0;
>  
> -	/* Find first overlapping mapping */
> -	vma = find_vma_intersection(mm, addr, end);
> -	if (!vma)
> -		return 0;
> -
> -	nr_pages = (min(end, vma->vm_end) -
> -		max(addr, vma->vm_start)) >> PAGE_SHIFT;
> -
> -	/* Iterate over the rest of the overlaps */
> -	for (vma = vma->vm_next; vma; vma = vma->vm_next) {
> -		unsigned long overlap_len;
> -
> -		if (vma->vm_start > end)
> -			break;
> +	for_each_vma_range(vmi, vma, end) {
> +		unsigned long vm_start = max(addr, vma->vm_start);
> +		unsigned long vm_end = min(end, vma->vm_end);

I thought using max_t and min_t was the latest advisory. I might be
wrong and simply kept doing it that way ;)

>  
> -		overlap_len = min(end, vma->vm_end) - vma->vm_start;
> -		nr_pages += overlap_len >> PAGE_SHIFT;
> +		nr_pages += (vm_end - vm_start) / PAGE_SIZE;

PHYS_PFN(vm_end - vm_start)

>  	}
>  
>  	return nr_pages;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

