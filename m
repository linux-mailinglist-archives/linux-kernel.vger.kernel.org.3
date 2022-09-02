Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3863F5AB984
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIBUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiIBUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15AFAC7B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662151148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xJ0Qu9XWFO4UUk4rWqs9r8O8v+oRQvUvbXP0h2FgBJE=;
        b=fy32uSQtGMMe/jFzTwIBoHADAehqWGesHZ1piQgsCXRXSLywAMz4hsYplhk+xylOXgAXAu
        23tacLZYw5fjh0LUpOMKajoNeeiOCneMG77PD150smqk+BAvjcZbF3G936RV4+nRWh4Ye0
        rCNq3/HPw+i98JPVbnQk4KGcI7Dsn+g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-OIVzxzlyNJCHqRVmYac2Vw-1; Fri, 02 Sep 2022 16:39:07 -0400
X-MC-Unique: OIVzxzlyNJCHqRVmYac2Vw-1
Received: by mail-qt1-f200.google.com with SMTP id h19-20020ac85493000000b00343408bd8e5so2392610qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 13:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xJ0Qu9XWFO4UUk4rWqs9r8O8v+oRQvUvbXP0h2FgBJE=;
        b=2CkqVDj2KFAZFhSVKkLlSpYC7/owsVjdwfRiI/alUns8IvTVRniKR1L/xxHF8Fb7GP
         GgyjEwpMX/Btk9YPhZREDopJ8MvMCwcOY3Ku+x/4SDe/VGFQEUVyvvg+cB9UdUj+pzlL
         shWkJU7lV6sj2IEReyOW+b0nsgNSvKWaFN4wjobfb1L1IcLjiNRl/ZolnLlmPcqAQ9bY
         V98F7aiNyvlUAbQ0GGwaCq7d8LoCDeS7od7OWSsQoaQso3jNKNShfTWWrf5sdj5x1eV+
         tTJqdlqF6+L1L3musG27Z0TTbBEhE26jmfWugkfRGLF2liE4dV4bAaTaj0PCbfrYOprH
         lu5A==
X-Gm-Message-State: ACgBeo1OdYQagnuwWiSloz8aL3+WxQ0S2JnBncPqgv7ZB6Rv2bCqgLsI
        zA1UxbVlBQNpSGhEog/TtyrR4HU2yck452ahHwX1AWSsmW5i1c3oK5vADQeSmg7crT4Ebs2pjSk
        0LnkPChMEx3Acfk3Z8Cc/PWF6
X-Received: by 2002:a05:6214:4005:b0:474:3c94:cdc2 with SMTP id kd5-20020a056214400500b004743c94cdc2mr30020608qvb.17.1662151147433;
        Fri, 02 Sep 2022 13:39:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7YMrtikm013gR4JTLQQoN5gVOE4hUudLnV6FSgJBznRd/8l8hCsLr/ALJPQCQnci+l7e2+tQ==
X-Received: by 2002:a05:6214:4005:b0:474:3c94:cdc2 with SMTP id kd5-20020a056214400500b004743c94cdc2mr30020592qvb.17.1662151147191;
        Fri, 02 Sep 2022 13:39:07 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id l3-20020ac80783000000b00342fcdc2d46sm1725995qth.56.2022.09.02.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:39:06 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:39:04 -0400
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
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mm/migrate_device.c: Add missing
 flush_cache_page()
Message-ID: <YxJp6GiGjHZ+ehyf@xz-m1.local>
References: <9f801e9d8d830408f2ca27821f606e09aa856899.1662078528.git-series.apopple@nvidia.com>
 <5676f30436ab71d1a587ac73f835ed8bd2113ff5.1662078528.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5676f30436ab71d1a587ac73f835ed8bd2113ff5.1662078528.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:35:52AM +1000, Alistair Popple wrote:
> Currently we only call flush_cache_page() for the anon_exclusive case,
> however in both cases we clear the pte so should flush the cache.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 8c3328f1f36a ("mm/migrate: migrate_vma() unmap page from vma while collecting pages")
> Cc: stable@vger.kernel.org

This is the patch to start collide with David's.

David's patch has also unified both paths with ptep_get_and_clear(), but
this patch itself is also correct to me.

It'll probably just become no-diff after rebase, though.. I'm not sure how
the ordering would be at last, but anyway I think this patch stands as its
own too..

Acked-by: Peter Xu <peterx@redhat.com>

Thanks for tolerant with my nitpickings,

> 
> ---
> 
> New for v4
> ---
>  mm/migrate_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 6a5ef9f..4cc849c 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -193,9 +193,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			bool anon_exclusive;
>  			pte_t swp_pte;
>  
> +			flush_cache_page(vma, addr, pte_pfn(*ptep));
>  			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
>  			if (anon_exclusive) {
> -				flush_cache_page(vma, addr, pte_pfn(*ptep));
>  				ptep_clear_flush(vma, addr, ptep);
>  
>  				if (page_try_share_anon_rmap(page)) {
> -- 
> git-series 0.9.1
> 

-- 
Peter Xu

