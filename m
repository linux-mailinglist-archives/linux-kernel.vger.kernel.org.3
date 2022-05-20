Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9F52F61F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbiETXZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiETXZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:25:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607A19C387
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:25:09 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so8919026pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dK6aWQ96HxSVfQTqNhYzR/lve/VK/MSeycmkC1UctXs=;
        b=U3DqD7sq1I+MlHxQVk+/siCazWQEsvCDziTc8ngEBK+TX4C3iVEuZFs5Evl1Zng/IA
         2Ep7pVIPdIzkYBEd/GvLbnpHVfHQ2lh2+WPuSVzmz5eyeRH5Z4s1iB0LGmKrYwXB+eSJ
         f0BHeft5hzxYwCUw9hRxOhBFNcaH7lviYHFhpqe0a7JhIsEu9fZI55WkGwWrx4cxs5/P
         h2Ue2pjZGaX8sq+WGcLFIH4OIJapiIOtmYsFHPYDKnwX3PMyO1vLeGyZv9M6BDyGiVFu
         HVXN+C4rrp1L6FUqlyX4/IvQELKdFzZLEPUsT8uKtCG/aGVS7caClbzi3UO5E5DJiIzw
         zKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dK6aWQ96HxSVfQTqNhYzR/lve/VK/MSeycmkC1UctXs=;
        b=iJcNWv3P43UjXiUzsNU5Ki7o9bTqBEgYLtEzDePqihNRKMdpyHiF5n/v2pPchuTk+b
         T+mKn3BQWXe8GQJqXeTWd0Lplp0BjSLsx8th5sS2SqzUXTRowGYxB1C1cVG9Osbt7hLz
         gEMT008bE9ibzB4xb8064IwD8MwMIdZT+kJNH9+VtKNGkYR/Ax5+kYvuOE5n/WGtIEuP
         4cL54SAo6Bql8Z1bKhqCHIWExrBwHhl4uhXuZ7auj0UwlnIo/xp+IvXikd1TSonVXTii
         Nk5wMIOJoYB6pkpUJ9b9DxZf+W8l3Vg9bZ/91KcwIaV/fpcOC4lqs7JOzfUNTD0P0zLV
         aTBQ==
X-Gm-Message-State: AOAM532qxniWDrhZlqbPUryL/LB9wDD6sK76Ioo2fGKCr6x+Ezm35IRm
        DdhcyuQl69qUsFr13otaDv4=
X-Google-Smtp-Source: ABdhPJyE1RaSvSxVHiLM6HeYNaToB3qUV/BKnB2qguGOzUfbtSGaKF1MFfjfYiCgITG+2pP6LZ/i7g==
X-Received: by 2002:a65:6284:0:b0:3f6:298d:dd81 with SMTP id f4-20020a656284000000b003f6298ddd81mr10585451pgv.319.1653089109113;
        Fri, 20 May 2022 16:25:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:828d:ad52:eebc:6659])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902ed9400b0015e8d4eb1f5sm280302plj.63.2022.05.20.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:25:08 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 20 May 2022 16:25:06 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-ID: <YogjUl1IshuqVkjs@google.com>
References: <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:56:31PM -0700, John Hubbard wrote:
> On 5/20/22 15:19, Minchan Kim wrote:
> > The memory offline would be an issue so we shouldn't allow pinning of any
> > pages in *movable zone*.
> > 
> > Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
> > problem to allow pinning on those area. The matter is what target range
> > on alloc_contig_range is backed by CMA or movable zone and usecases.
> > 
> > IOW, movable zone should be never allowed. But CMA case, if pages
> > are used by normal process memory instead of hugeTLB, we shouldn't
> > allow longterm pinning since someone can claim those memory suddenly.
> > However, we are fine to allow longterm pinning if the CMA memory
> > already claimed and mapped at userspace(hugeTLB case IIUC).
> > 
> 
> From Mike's comments and yours, plus a rather quick reading of some
> CMA-related code in mm/hugetlb.c (free_gigantic_page(),
> alloc_gigantic_pages()), the following seems true:
> 
> a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
> 
> b) while hugetlbfs is using those CMA-allocated pages, it is debatable
> whether those pages should be allowed to be long term pinned. That's
> because there are two cases:
> 
>     Case 1: pages are longterm pinned, then released, all while
>             owned by hugetlbfs. No problem.
> 
>     Case 2: pages are longterm pinned, but then hugetlbfs releases the

Longterm pinned means the hugetlbfs page were mapped at userspace and
someone called FOLL_LONGTERM against on the page?

>             pages entirely (via unmounting hugetlbfs, I presume). In

Then, how can FS unmount successfully while something is accessing
on the page of the file in FS? (I expected FS should return -EBUSY).
Does hugetlbfs have something special?


>             this case, we now have CMA page that are long-term pinned,
>             and that's the state we want to avoid.
