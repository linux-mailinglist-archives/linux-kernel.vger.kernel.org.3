Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51A95B2586
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiIHSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIHSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78394E558D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662661256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fq82aHZbVB5eLHvyHBC7VyGWz1mPN6C6p69Q0sIwiJE=;
        b=Jdg7hteE2GW1jzLMg3bGE6unosjCddE05UsNLD2ikl8z5T/wgOM1NlTkLEnbfDb1hWDebS
        wfH89vbCQeR4TNCBaITq6UXOkCWcvL7eDwKgfDBaS/SaWoOHnx6TrmP5dEYcsx5Hx31TVf
        /6SN6uln+KMcmPYgRy0Lw559mSsid10=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-63-rN3g7_9fOwKQuBfFP3j5NQ-1; Thu, 08 Sep 2022 14:20:54 -0400
X-MC-Unique: rN3g7_9fOwKQuBfFP3j5NQ-1
Received: by mail-qt1-f199.google.com with SMTP id bq11-20020a05622a1c0b00b003434f125b77so15348891qtb.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Fq82aHZbVB5eLHvyHBC7VyGWz1mPN6C6p69Q0sIwiJE=;
        b=R9ngYB2T+fXii98SOd8/vevSBHcyWsOjdzvrq8p8IuTvAfEAeQGDR9MqxRVc2D2J0u
         UffHH8p7F99n6uMaKNx/1N4Qb0EYDCILwZ+Y4phRl6QH5C2xqZ4bl0YLrLjRXrIGwsfV
         cWnuSm+XfIWVZHDVP3lPGG/a4E4GSERt9LhSxclJncaIbl5vVGKiMFIsKDEDgojWZ0pH
         SZphbwXr7uLEqT20T/0uM2AVuBjTy05LPPJrag5ovZkKWJcHr4zCMw+Z+pW4sqqJ8s74
         yO2+Sl3W7QdWz4lnun/VvBm0pMKSYvM0Cny7kS07dSNz3aZVAnEYKQf0314Ume076HVf
         34dA==
X-Gm-Message-State: ACgBeo0HYIk/NaVArE9efscnR74Mq7V3q9vMH6XDt+G7DfsL7+1zXjI1
        uinzs3kzLBvux4RhUEairIrTPj2JjN7zrpk8Ya4FgLfuNmhFIdUQt8gYDX5B1gV1Bs+4amADQfn
        DRYf5fwOeliefUhMKK20XaWKO
X-Received: by 2002:a05:620a:2451:b0:6cb:b4db:a3ad with SMTP id h17-20020a05620a245100b006cbb4dba3admr5570207qkn.216.1662661254449;
        Thu, 08 Sep 2022 11:20:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UyQ8BldktqUXf3NND++hWgTsT32ASuiVTrEFM97vuCDpMTfuI2lGAwnelYvjmwScRjX2i7Q==
X-Received: by 2002:a05:620a:2451:b0:6cb:b4db:a3ad with SMTP id h17-20020a05620a245100b006cbb4dba3admr5570182qkn.216.1662661254188;
        Thu, 08 Sep 2022 11:20:54 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id e5-20020ac80105000000b00342b7e4241fsm15385553qtg.77.2022.09.08.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:20:53 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:20:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 11/26] hugetlb: add hugetlb_walk_to to do PT walks
Message-ID: <YxoyhDiNDqmJQfFi@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-12-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220624173656.2033256-12-jthoughton@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 05:36:41PM +0000, James Houghton wrote:
> This adds it for architectures that use GENERAL_HUGETLB, including x86.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h |  2 ++
>  mm/hugetlb.c            | 45 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e7a6b944d0cc..605aa19d8572 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -258,6 +258,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long addr, unsigned long sz);
>  pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz);
> +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		    unsigned long addr, unsigned long sz, bool stop_at_none);
>  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  				unsigned long *addr, pte_t *ptep);
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 557b0afdb503..3ec2a921ee6f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6981,6 +6981,51 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *)pmd;
>  }
>  
> +int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		    unsigned long addr, unsigned long sz, bool stop_at_none)
> +{
> +	pte_t *ptep;
> +
> +	if (!hpte->ptep) {
> +		pgd_t *pgd = pgd_offset(mm, addr);
> +
> +		if (!pgd)
> +			return -ENOMEM;
> +		ptep = (pte_t *)p4d_alloc(mm, pgd, addr);
> +		if (!ptep)
> +			return -ENOMEM;
> +		hugetlb_pte_populate(hpte, ptep, P4D_SHIFT);
> +	}
> +
> +	while (hugetlb_pte_size(hpte) > sz &&
> +			!hugetlb_pte_present_leaf(hpte) &&
> +			!(stop_at_none && hugetlb_pte_none(hpte))) {
> +		if (hpte->shift == PMD_SHIFT) {
> +			ptep = pte_alloc_map(mm, (pmd_t *)hpte->ptep, addr);

I had a feeling that the pairing pte_unmap() was lost.

I think most distros are not with CONFIG_HIGHPTE at all, but still..

> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PAGE_SHIFT;
> +			hpte->ptep = ptep;
> +		} else if (hpte->shift == PUD_SHIFT) {
> +			ptep = (pte_t *)pmd_alloc(mm, (pud_t *)hpte->ptep,
> +						  addr);
> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PMD_SHIFT;
> +			hpte->ptep = ptep;
> +		} else if (hpte->shift == P4D_SHIFT) {
> +			ptep = (pte_t *)pud_alloc(mm, (p4d_t *)hpte->ptep,
> +						  addr);
> +			if (!ptep)
> +				return -ENOMEM;
> +			hpte->shift = PUD_SHIFT;
> +			hpte->ptep = ptep;
> +		} else
> +			BUG();
> +	}
> +	return 0;
> +}
> +
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  
>  #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 

-- 
Peter Xu

