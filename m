Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC0A59FE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiHXPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiHXPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D374B8C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661355556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YDz+MpPZkiheMede1adKNb3LxgK1j3sRTyEv4HMpL0=;
        b=RaieSkTP/iLRgo2CPANS4528Brz6Z+98pB0KGlHVYnrU9MlFCO2epS62+gA2LCaem025GU
        dRHvaTKcyZI1UL7v5PMdFE9+nz/Vt0fsTmM8a1r2m4XpdBNWXj3QplFpmg6abx1anxHnBK
        /AbOXcVFPSu+1c+fIGKpdSlxvotFu8k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-fdZXjs3zMqee9Uc2QyGVoQ-1; Wed, 24 Aug 2022 11:39:14 -0400
X-MC-Unique: fdZXjs3zMqee9Uc2QyGVoQ-1
Received: by mail-qv1-f69.google.com with SMTP id k3-20020a05621414e300b00496e11f8d8aso5681257qvw.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4YDz+MpPZkiheMede1adKNb3LxgK1j3sRTyEv4HMpL0=;
        b=pTufwzHzgR3ICQl3KM62BUIVOFAmgypywxiLtA6rZ3gICdlk1k1VKSfNJ1kfmVzffC
         PVx+RekFzclz3Rhf2Wh3m8nyV4Yq9wHAYWO2rd40wpHsbAxLuUWqEN9u0/A0Y/aK3qeO
         qWCenvh+mqxPs+eCE36jz3253JVfhD7j3oY8L7fDhsKcuBE2MtHIoUzqPI7DawDr6Gnc
         ua1hakZ0En/RukFgM4Mhv2ITLNGV9FoejAkUBfehjEtTFlPJweYgVubZq/TEfusFmHRL
         T1iSfObcZ2OxV0tfbDFveWFbJlIajPaeunAP/RzdyGTKlgv55IYMBtB/Yq4/OY7u8bG2
         Gtww==
X-Gm-Message-State: ACgBeo3P4yt/ga+vvIKgSDm/aboqRVUA85gXR53bHORJ/ialaSGXn5cr
        M2pdfLPKKxUQ9NF8KSUlv1KnWC0ICe3r58dMAqyDDYYtREE7jR+WfINZpG8md3/4PwY97f2lenV
        zBsNsehWS+SLoUsObqzD7GOl9
X-Received: by 2002:ad4:5ae8:0:b0:496:f1c9:7bd with SMTP id c8-20020ad45ae8000000b00496f1c907bdmr10727642qvh.125.1661355554385;
        Wed, 24 Aug 2022 08:39:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lRAWqwQD0sX2sud09VmJ+0QpTsPmTlUS5jZn09b1qgoiwGEQmQlz8zOomOo+cNaaUWHVmfg==
X-Received: by 2002:ad4:5ae8:0:b0:496:f1c9:7bd with SMTP id c8-20020ad45ae8000000b00496f1c907bdmr10727612qvh.125.1661355554146;
        Wed, 24 Aug 2022 08:39:14 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87764000000b0034355a352d1sm12681683qtu.92.2022.08.24.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 08:39:13 -0700 (PDT)
Date:   Wed, 24 Aug 2022 11:39:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3 2/3] mm/migrate_device.c: Copy pte dirty bit to page
Message-ID: <YwZGHyYJiJ+CGLn2@xz-m1.local>
References: <3b01af093515ce2960ac39bb16ff77473150d179.1661309831.git-series.apopple@nvidia.com>
 <ffbc824af5daa2c44b91c66834a341894fba4ce6.1661309831.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffbc824af5daa2c44b91c66834a341894fba4ce6.1661309831.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 01:03:38PM +1000, Alistair Popple wrote:
> migrate_vma_setup() has a fast path in migrate_vma_collect_pmd() that
> installs migration entries directly if it can lock the migrating page.
> When removing a dirty pte the dirty bit is supposed to be carried over
> to the underlying page to prevent it being lost.
> 
> Currently migrate_vma_*() can only be used for private anonymous
> mappings. That means loss of the dirty bit usually doesn't result in
> data loss because these pages are typically not file-backed. However
> pages may be backed by swap storage which can result in data loss if an
> attempt is made to migrate a dirty page that doesn't yet have the
> PageDirty flag set.
> 
> In this case migration will fail due to unexpected references but the
> dirty pte bit will be lost. If the page is subsequently reclaimed data
> won't be written back to swap storage as it is considered uptodate,
> resulting in data loss if the page is subsequently accessed.
> 
> Prevent this by copying the dirty bit to the page when removing the pte
> to match what try_to_migrate_one() does.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reported-by: Huang Ying <ying.huang@intel.com>
> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
> Cc: stable@vger.kernel.org
> 
> ---
> 
> Changes for v3:
> 
>  - Defer TLB flushing
>  - Split a TLB flushing fix into a separate change.
> 
> Changes for v2:
> 
>  - Fixed up Reported-by tag.
>  - Added Peter's Acked-by.
>  - Atomically read and clear the pte to prevent the dirty bit getting
>    set after reading it.
>  - Added fixes tag
> ---
>  mm/migrate_device.c |  9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 6a5ef9f..51d9afa 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -7,6 +7,7 @@
>  #include <linux/export.h>
>  #include <linux/memremap.h>
>  #include <linux/migrate.h>
> +#include <linux/mm.h>
>  #include <linux/mm_inline.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/oom.h>
> @@ -196,7 +197,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>  			if (anon_exclusive) {
>  				flush_cache_page(vma, addr, pte_pfn(*ptep));
> -				ptep_clear_flush(vma, addr, ptep);
> +				pte = ptep_clear_flush(vma, addr, ptep);
>  
>  				if (page_try_share_anon_rmap(page)) {
>  					set_pte_at(mm, addr, ptep, pte);
> @@ -206,11 +207,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  					goto next;
>  				}
>  			} else {
> -				ptep_get_and_clear(mm, addr, ptep);
> +				pte = ptep_get_and_clear(mm, addr, ptep);
>  			}

I remember that in v2 both flush_cache_page() and ptep_get_and_clear() are
moved above the condition check so they're called unconditionally.  Could
you explain the rational on why it's changed back (since I think v2 was the
correct approach)?

The other question is if we want to split the patch, would it be better to
move the tlb changes to patch 1, and leave the dirty bit fix in patch 2?

>  
>  			migrate->cpages++;
>  
> +			/* Set the dirty flag on the folio now the pte is gone. */
> +			if (pte_dirty(pte))
> +				folio_mark_dirty(page_folio(page));
> +
>  			/* Setup special migration page table entry */
>  			if (mpfn & MIGRATE_PFN_WRITE)
>  				entry = make_writable_migration_entry(
> -- 
> git-series 0.9.1
> 

-- 
Peter Xu

