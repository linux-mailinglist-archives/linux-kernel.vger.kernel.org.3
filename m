Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE98A5456AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbiFIVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiFIVoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D210663DE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654811045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fagLn1QORtw1CmMdNHS/I/NOn/mH/sycRvPzvG14xuw=;
        b=QF+oTifpw2n/RsokUwBX/jHFPt31dZTyq7+fIrvkOeiEUNSJvBtWeHW/Be+E/0Xk9eJVLA
        ISD9GhTbJIHbzOsQJNorMipx1docD2r3h/mQcEPxQqmbF/JQdTXXSD00cycUP/J7rz8vyZ
        t7ldJEo25x1eiCaIyVv40nSVFuNjO6k=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-rm9QH1VyMe23W4EKdlR-rA-1; Thu, 09 Jun 2022 17:44:02 -0400
X-MC-Unique: rm9QH1VyMe23W4EKdlR-rA-1
Received: by mail-il1-f200.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso18422741ilo.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 14:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fagLn1QORtw1CmMdNHS/I/NOn/mH/sycRvPzvG14xuw=;
        b=h3PChJf54d/1aROs2saAaz12y0nNLrpR+MQ90jsr+aC/utmeQcPWShPLyeIJGWgG6T
         Q858L8zKlkPdjWXSEY81+BjD1K2uhmPtk763jLvFmN/0uqU/GweWFQPoGfJsL9NtfZoA
         FEVScZsJYaesBs7GZCHPvS48rcSEtSNsyjhOdd/4TlsB8Z9oQT8Sz3fCAxkQAs9PW55h
         uYOCHPKDV9XFxOkCUgGlavPWgltq5PVIwMvjTd2KYb0Lc+j1zEecC8+pMdHEdKGTftq5
         4vfIWs2+zXn6knJpaY14t7lwbsRgLb1mM6IAbfVfKTrtbdinF+SmhA2gt/8VzpKmzdQw
         0kiQ==
X-Gm-Message-State: AOAM533YWEBSzPGse3MHOrMOMcJuYvQ2MHYNEu4LhqFv38emsWoxYlVI
        nZ+hByrxu5d/UDeRTbA6Mrs9zMb729y3M5OJaF5gdDNzW8qfuMyn4rLFMHYER/kvZycNNEotxcx
        KrB94k56LMu9iYp03PHPBqqro
X-Received: by 2002:a05:6638:2481:b0:331:e12a:5e32 with SMTP id x1-20020a056638248100b00331e12a5e32mr6646717jat.90.1654811041620;
        Thu, 09 Jun 2022 14:44:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXpLojQTJVnS0FPF/WE2W5OAqAKBEdOtdJTiKvakBu2zBlPA0HwTGpzdUEAFTkkUhX7Qtmbw==
X-Received: by 2002:a05:6638:2481:b0:331:e12a:5e32 with SMTP id x1-20020a056638248100b00331e12a5e32mr6646712jat.90.1654811041399;
        Thu, 09 Jun 2022 14:44:01 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g2-20020a92c7c2000000b002d0fb2aab24sm11032990ilk.8.2022.06.09.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 14:44:00 -0700 (PDT)
Date:   Thu, 9 Jun 2022 17:43:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: userfaultfd: fix UFFDIO_CONTINUE on fallocated shmem
 pages
Message-ID: <YqJpny7cU+tBa093@xz-m1.local>
References: <20220603205741.12888-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220603205741.12888-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Axel,

Sorry to read this late.

On Fri, Jun 03, 2022 at 01:57:41PM -0700, Axel Rasmussen wrote:
> When fallocate() is used on a shmem file, the pages we allocate can end
> up with !PageUptodate.
> 
> Since UFFDIO_CONTINUE tries to find the existing page the user wants to
> map with SGP_READ, we would fail to find such a page, since
> shmem_getpage_gfp returns with a "NULL" pagep for SGP_READ if it
> discovers !PageUptodate. As a result, UFFDIO_CONTINUE returns -EFAULT,
> as it would do if the page wasn't found in the page cache at all.
> 
> This isn't the intended behavior. UFFDIO_CONTINUE is just trying to find
> if a page exists, and doesn't care whether it still needs to be cleared
> or not. So, instead of SGP_READ, pass in SGP_NOALLOC. This is the same,
> except for one critical difference: in the !PageUptodate case,
> SGP_NOALLOC will clear the page and then return it. With this change,
> UFFDIO_CONTINUE works properly (succeeds) on a shmem file which has been
> fallocated, but otherwise not modified.
> 
> Fixes: 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 4f4892a5f767..c156f7f5b854 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -246,7 +246,7 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
>  	struct page *page;
>  	int ret;
>  
> -	ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> +	ret = shmem_getpage(inode, pgoff, &page, SGP_NOALLOC);
>  	if (ret)
>  		goto out;
>  	if (!page) {

It all looks sane if the page is !uptodate as you described.  Though I've a
question on what'll happen if the page is actually missing rather than just
!PageUptodate().

My reading is previously it'll keep returning 0 on shmem_getpage_gfp() for
both cases, but now for the missing page shmem_getpage_gfp() will return
-ENOENT instead.

This reminded me on whether this will errornously let __mcopy_atomic() go
into the special path to copy the page without mmap lock, please see this
commit:

b6ebaedb4cb1 ("userfaultfd: avoid mmap_sem read recursion in mcopy_atomic", 2015-09-04)

Would that be a problem?  Or could I read it wrong?

This also reminded me that whether we'd better need some protection in the
-ENOENT handling in __mcopy_atomic() to be always safe.

Thanks,

-- 
Peter Xu

