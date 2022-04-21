Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D51E50A07A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiDUNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiDUNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D7D05FB3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650546800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzWrq6wADG8fls2g3YNi2KBRby6mI91KD1aPFaOuBgg=;
        b=Cxy08UKum7P9xslT/jElSs2AVTM/pnmJbyyoUnTk9AaIg/K2/kg+c7BtTU0hSAfIaVllUu
        oN74jA284bKGMQ284bwEtuJsVn9puPOqa6viBWAogc2ONMwqiTY1ohibVl7iqh0Ncc+gsv
        Sl6BRp0mwVq6xywiNdaZMGiW3N2bA6Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-6e6PqXzjNUyVLXyur_wKag-1; Thu, 21 Apr 2022 09:13:16 -0400
X-MC-Unique: 6e6PqXzjNUyVLXyur_wKag-1
Received: by mail-wr1-f71.google.com with SMTP id f2-20020a056000036200b00207a14a1f96so1123088wrf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=FzWrq6wADG8fls2g3YNi2KBRby6mI91KD1aPFaOuBgg=;
        b=oC+ejs4POMnshVMefGmXw9fILSm7oiqIesjF7blspzYDXAoWHp9MUHYHSrTEHEOkwx
         rECoN4YMM6tKaLjyK6JnEFAbAMTQqoH8CFO4pzpc5Oky8noRR7Lze5YNwl++qESVVFQ3
         /wqamq1uxiuBgNVbLjAVTtr/uKfh7MOEQwlWXNHbTaq20as0VCk9+Q9l+rlmVgoAyAM6
         lQe/qsVKw3FqVXnPss+VKlXy5Cs9JHLbHg6/Kgl9fYJj4xhOJJN2EoVhYaYaJV9gXiUy
         NWVJabzTtPVxBi2awOa+QFAemo7comskYKvZjS7S4IW9wvoNLVpA/BUKitNVg000eXOc
         WKTg==
X-Gm-Message-State: AOAM533XmGSoGyYHAYE4zZzDAiz4d8HwGBV9BrzwB/95DDR7A75kPhrJ
        sA011gv6Qj20Sbj47FbVSTAWYRfjKEyFqARoLC2c/kH1lquKFY87g9pFOS17fW0CHN9E2ZEQ27B
        4o9cfCL6+O8IMZGcZeabFRXRO
X-Received: by 2002:a5d:604a:0:b0:20a:8145:ad04 with SMTP id j10-20020a5d604a000000b0020a8145ad04mr19085021wrt.255.1650546795372;
        Thu, 21 Apr 2022 06:13:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb38/K7fR5vGj0BbR2nbDRw0aq+8b3KsKUW8o45emQVthbAQ8YqAtEFEH0t8BYy5sf4flfXA==
X-Received: by 2002:a5d:604a:0:b0:20a:8145:ad04 with SMTP id j10-20020a5d604a000000b0020a8145ad04mr19085000wrt.255.1650546795119;
        Thu, 21 Apr 2022 06:13:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm2764840wri.45.2022.04.21.06.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:13:14 -0700 (PDT)
Message-ID: <67fc9368-0876-b931-14c2-ffa4dac35b6d@redhat.com>
Date:   Thu, 21 Apr 2022 15:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 2/3] mm/swapfile: Fix lost swap bits in unuse_pte()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220421125348.62483-1-linmiaohe@huawei.com>
 <20220421125348.62483-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220421125348.62483-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.22 14:53, Miaohe Lin wrote:
> This is observed by code review only but not any real report.
> 
> When we turn off swapping we could have lost the bits stored in the swap
> ptes. The new rmap-exclusive bit is fine since that turned into a page
> flag, but not for soft-dirty and uffd-wp. Add them.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 95b63f69f388..332ccfc76142 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1783,7 +1783,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	struct page *swapcache;
>  	spinlock_t *ptl;
> -	pte_t *pte;
> +	pte_t *pte, new_pte;
>  	int ret = 1;
>  
>  	swapcache = page;
> @@ -1832,8 +1832,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		page_add_new_anon_rmap(page, vma, addr);
>  		lru_cache_add_inactive_or_unevictable(page, vma);
>  	}
> -	set_pte_at(vma->vm_mm, addr, pte,
> -		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
> +	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
> +	if (pte_swp_soft_dirty(*pte))
> +		new_pte = pte_mksoft_dirty(new_pte);
> +	if (pte_swp_uffd_wp(*pte)) {
> +		new_pte = pte_mkuffd_wp(new_pte);
> +		new_pte = pte_wrprotect(new_pte);

The wrprotect shouldn't be necessary, we don't do a pte_mkwrite(). Note
that in do_swap_page() we might have done a
maybe_mkwrite(pte_mkdirty(pte)), which is why the pte_wrprotect() is
required there.

-- 
Thanks,

David / dhildenb

