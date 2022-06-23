Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C791557348
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiFWGqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiFWGqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:46:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C9943AE1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:46:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1616680pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x32DqBuUceR8iFLYxI8kSYRj/UC1qePRIp+pYEx+MqI=;
        b=EFvtJkZ/s4HpynzIewEfGe96kqJfJM6rQt8ODyjrXOisdHE5f6Hk6tXlwRNzWPM3ei
         RlBSYgqWIvRPkKpRne3XKfFKsZG25MbstwCvVWH0GOOj4QdYVXd7qJpR0f4jRMGXNdeH
         VtZkm/mgcb6EITsedWykN4KOZ8Ck2MLDdIpsUk9hDyKyd3SD7uBijNYB7w+MICqy42Gh
         3Sc5GWNg3NRy/OR3Fvnduea968hwmNiqOitOojSjlAlnFkdLU4RNDd4ctQqsCuRm1Lh1
         a294dHAoS3yWLrOfH8JS3VJYpivbOcjBWtxPINCsJqys/QnLCyf1enXkgX2+hO2xQmeG
         3FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x32DqBuUceR8iFLYxI8kSYRj/UC1qePRIp+pYEx+MqI=;
        b=7KgrPCpF3HXzchqnLVwoT6IheWIiYfteKEUf2s8ckZQQvnZDDhOxSRfkurTvZK6u0J
         qjKEfxWHS0x/dDk/Y9NYOgXtmXF30Gu7YiJVQNV0/VaLhJWympASKrK74NUfibi/Wcqh
         rI8IHfjz3fbAt9GrjCEGEzcP+Kv4RVKPS6qcJuxvgRmhcLvav+oIRqckmWni6lpkv/4d
         6d36xg2Y4FK0cKBie7mVJh0ATT6tCgZSibA8JFUgtrTHZdYQoYpTO1lW/464k8kTQC9s
         ieZqnigGjjSn2HfNNdHJW+xsQJ76Rvig8RJmTrJIPIewzu0djqXC153CwNTYdzuBEXzR
         QTvg==
X-Gm-Message-State: AJIora8M7i8gzyZSuIk5bxYOE4Eoidh2vzY+k1GdXNigtRwe3+DCek/Y
        sYaQ9x/gLbdCuyIaQT/52H2yig==
X-Google-Smtp-Source: AGRyM1t69oBgD2t12Wc9w/KrrhJUuVoP29N3cBu+zMN6kludrJXg5XyShxODkhRS7PzeUJu4aDEdnA==
X-Received: by 2002:a17:90b:3b4c:b0:1e8:5e53:2796 with SMTP id ot12-20020a17090b3b4c00b001e85e532796mr2396743pjb.184.1655966792405;
        Wed, 22 Jun 2022 23:46:32 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id v1-20020a62c301000000b0052090076426sm15301519pfg.19.2022.06.22.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:46:32 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:46:28 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] mm/huge_memory: rename mmun_start to haddr in
 remove_migration_pmd
Message-ID: <YrQMRJ6PaIR8KkT6@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-7-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-7-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:17AM +0800, Miaohe Lin wrote:
> mmun_start indicates mmu_notifier start address but there's no mmu_notifier

Actually I don't know what "mmun" prefix means. But this change looks good to
me.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> stuff in remove_migration_pmd. This will make it hard to get the meaning of
> mmun_start. Rename it to haddr to avoid confusing readers and also imporve
> readability.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c6302fe6704b..fb5c484dfa39 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3181,7 +3181,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  	struct vm_area_struct *vma = pvmw->vma;
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address = pvmw->address;
> -	unsigned long mmun_start = address & HPAGE_PMD_MASK;
> +	unsigned long haddr = address & HPAGE_PMD_MASK;
>  	pmd_t pmde;
>  	swp_entry_t entry;
>  
> @@ -3204,12 +3204,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>  		if (!is_readable_migration_entry(entry))
>  			rmap_flags |= RMAP_EXCLUSIVE;
>  
> -		page_add_anon_rmap(new, vma, mmun_start, rmap_flags);
> +		page_add_anon_rmap(new, vma, haddr, rmap_flags);
>  	} else {
>  		page_add_file_rmap(new, vma, true);
>  	}
>  	VM_BUG_ON(pmd_write(pmde) && PageAnon(new) && !PageAnonExclusive(new));
> -	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
> +	set_pmd_at(mm, haddr, pvmw->pmd, pmde);
>  
>  	/* No need to invalidate - it was non-present before */
>  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
> -- 
> 2.23.0
> 
> 
