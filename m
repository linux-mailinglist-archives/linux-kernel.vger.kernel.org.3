Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B589E507BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357582AbiDSVjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiDSVj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBBA0BF6B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y1OMUarmNaiBCBgO4xStYD+V6CFsC/z3nX/OYUoRozY=;
        b=R+rpI71RyR5erfQ6fD6FAcyOlx+n6KNLT0gY0h5bUnQo4MAKvrQJAJUJu879/6AV6Et7Mq
        MSacR01n86vuEGux/9ovB2OpTlUZ7ox5cqh1ewDyBSljc9+gtDJWMyDBwU3TPw/REzrTmJ
        fvl/Ft1PT1oHDU0ee/v4BroTR2QX5nk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-GodjmMU5P-idahbdPaUhfw-1; Tue, 19 Apr 2022 17:36:41 -0400
X-MC-Unique: GodjmMU5P-idahbdPaUhfw-1
Received: by mail-io1-f69.google.com with SMTP id m8-20020a0566022e8800b00654992238ceso5000527iow.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1OMUarmNaiBCBgO4xStYD+V6CFsC/z3nX/OYUoRozY=;
        b=yv27gj05hSSJTDXX2MGa67UAFYngWF/ZMLE1v0nMw4AytUR4+F3mP7PeNA/wOG5Cpf
         +HeEEu/G1BJcSY0itRKr+ayDfU3vZBDEKYTMFlVVYmajn4GxTP2NQZ2Hg7p7E1+blw9d
         fM6hFc6w7Am+IYZxUho968fZWZQVf3vmAGW5O7XT+EHDjKinCDxOfLGg1PdDOGH9+grH
         TbbtZy6QnVzr+1F2iTTgWygLTpEY++FiNe/JNMAZc4JXf5Wh7HX3fxXIivmi8dnqrBIy
         xDGVhk25fAIwOVvo7hXEcFtDFuuh0IXPGpBt8Zd03aRxcMm567CxR2Gi3r2ICpOn6OL9
         Ey8Q==
X-Gm-Message-State: AOAM532q3bsoWIvh7ArQyyDGPa6A6kTeokT8zh/aDcs8CxB5nFlKFI6S
        9mH05WsIQ3SbU+zt5rKxz1fE92uBZr7r9qtxllVr451q43oCtQJg6JKanXMkr50yc535vZOWpdM
        1uTtJP8yIMhy5PijXVwWjtqvx
X-Received: by 2002:a02:b899:0:b0:328:522b:9417 with SMTP id p25-20020a02b899000000b00328522b9417mr8939522jam.79.1650404200733;
        Tue, 19 Apr 2022 14:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH5Y/aPGi4NZ84/m6rGW0w2H8bGBJbiRYCkyQ8jM+/YBa52IUoO3Lxx0cgJYIQuN5XCExYxg==
X-Received: by 2002:a02:b899:0:b0:328:522b:9417 with SMTP id p25-20020a02b899000000b00328522b9417mr8939512jam.79.1650404200532;
        Tue, 19 Apr 2022 14:36:40 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id p11-20020a056e0206cb00b002cc23fe596esm4292296ils.21.2022.04.19.14.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:36:39 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:36:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, david@redhat.com,
        apopple@nvidia.com, surenb@google.com, minchan@kernel.org,
        sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Message-ID: <Yl8rZkhU/B0iE2ob@xz-m1.local>
References: <20220416030549.60559-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4l5E6+oouBxra33V"
Content-Disposition: inline
In-Reply-To: <20220416030549.60559-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4l5E6+oouBxra33V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Apr 16, 2022 at 11:05:49AM +0800, Miaohe Lin wrote:
> @@ -1797,6 +1797,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		goto out;
>  	}
>  
> +	if (unlikely(!PageUptodate(page))) {
> +		pte_t pteval;
> +
> +		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
> +		set_pte_at(vma->vm_mm, addr, pte, pteval);
> +		swap_free(entry);
> +		ret = 0;
> +		goto out;
> +	}
> +
>  	/* See do_swap_page() */
>  	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
>  	BUG_ON(PageAnon(page) && PageAnonExclusive(page));

Totally off-topic, but.. today when I was looking at the unuse path I just
found that the swp bits could have got lost for either soft-dirty and
uffd-wp here?  A quick patch attached.

Maybe at some point we should start to have some special helpers for
set_pte_at() when we're converting between present/non-present ptes, so as
to make sure all these will always be taken care of properly.

-- 
Peter Xu

--4l5E6+oouBxra33V
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-swap-Fix-lost-swap-bits-in-unuse_pte.patch"

From 60ba535f73f7a7aeab2275d370bf8291cf53755e Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Apr 2022 17:28:34 -0400
Subject: [PATCH] mm/swap: Fix lost swap bits in unuse_pte()
Content-type: text/plain

This is observed by code review only but not any real report.

When we turn off swapping we could have lost the bits stored in the swap
ptes.  The new rmap-exclusive bit is fine since that turned into a page
flag, but not for soft-dirty and uffd-wp.  Add them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/swapfile.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9398e915b36b..eaea7a1f000b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1783,7 +1783,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	struct page *swapcache;
 	spinlock_t *ptl;
-	pte_t *pte;
+	pte_t *pte, newpte;
 	int ret = 1;
 
 	swapcache = page;
@@ -1821,8 +1821,12 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		page_add_new_anon_rmap(page, vma, addr);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
-	set_pte_at(vma->vm_mm, addr, pte,
-		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
+	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
+	if (pte_swp_soft_dirty(*pte))
+		pte = pte_mksoft_dirty(new_pte);
+	if (pte_swp_uffd_wp(*pte))
+		pte = pte_mkuffd_wp(new_pte);
+	set_pte_at(vma->vm_mm, addr, pte, new_pte);
 	swap_free(entry);
 out:
 	pte_unmap_unlock(pte, ptl);
-- 
2.32.0


--4l5E6+oouBxra33V--

