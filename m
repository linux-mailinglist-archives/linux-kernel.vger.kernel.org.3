Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DCC4AC960
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiBGTWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiBGTV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:21:59 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA7C0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:21:58 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id k4so12188834qvt.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MpROwmI6Qnm2emkziisG5aDXgeJvPxSLNV0Lic7ckQs=;
        b=OaiSuWRoTh89hqFli2OaM/99731kyVjifGW/6GRnhqIbNkn4rqP5cCBkUjKmhiONGA
         DRfaWqoDUSS3IuMSZybn6CxVSz9gReIWR5zHG2jjk1KjqYVDa/9CCxg0tFF3xZ3AN4KM
         IWW23EV/8VVY2qGl9kiFU+8+HFL3FZ5X6K6By2RBakx/Ghc4c95TqRKVwgL78FFsnybj
         gOmsu8PRvUOA7lJpZIzHdbR6U2MiJsL97ZsWs6lb+AZn8w27xJatWjWCvHlr0v+nfzrq
         5FEXre/2zFc0NgKQwTEa1qY6KjXxjGFFZdTM7G5gNDX+6knlEUNvM1LWH4Y4kbABTlQ9
         MW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpROwmI6Qnm2emkziisG5aDXgeJvPxSLNV0Lic7ckQs=;
        b=IRSNa08blOmoFGnJeoeN823cG424rmpmc1SihD6AzhPSq8Pc40p4xhjJZjpdpJaWN+
         Bag4kkafni0C7CKMWUFHKupawXrgVXeUgI9a9ZIP9X9m1XSSP/RKe+LiRR9MWYwc8Tmb
         Q0SJJ84JzXKYEjbKr0Z9KowZeaABCR6nwLndtmB04+XKXEukTYlsbPl61VrSeUgfUKG6
         /esl66kD1CGUBLo3gNdw9GSxSH04hTcumMISOh+yKjqWeMdIgv9R1kti6gBErObyQSwu
         8NihJeEgUIWNb4ePod/HED6p9S/4lIwBhSAI788m+y4wb1uYXM3FGnuz2cB3FopuJ9Lm
         /fGg==
X-Gm-Message-State: AOAM530eZgSQSpAL5bLWWslXgXT18qB7Xfe5jjB64PgzadkKsTaDdUnD
        CmkShKjB2SZZsq7M7t5gDkc6Ww==
X-Google-Smtp-Source: ABdhPJxhzWQ+13BW3b7rMAkbC+gsglkVidW/xLtoMpCgPLxkDjpi1/nh8Ncg8X/Gh7aVJ+bLlWGexw==
X-Received: by 2002:a05:6214:248a:: with SMTP id gi10mr727781qvb.99.1644261717527;
        Mon, 07 Feb 2022 11:21:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id y20sm5819031qta.9.2022.02.07.11.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 11:21:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nH9aF-000Hph-TJ; Mon, 07 Feb 2022 15:21:55 -0400
Date:   Mon, 7 Feb 2022 15:21:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
Message-ID: <20220207192155.GB49147@ziepe.ca>
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207063249.1833066-8-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:32:48AM +0100, Christoph Hellwig wrote:
> ZONE_DEVICE struct pages have an extra reference count that complicates
> the code for put_page() and several places in the kernel that need to
> check the reference count to see that a page is not being used (gup,
> compaction, migration, etc.). Clean up the code so the reference count
> doesn't need to be treated specially for ZONE_DEVICE pages.
> 
> Note that this excludes the special idle page wakeup for fsdax pages,
> which still happens at refcount 1.  This is a separate issue and will
> be sorted out later.  Given that only fsdax pages require the
> notifiacation when the refcount hits 1 now, the PAGEMAP_OPS Kconfig
> symbol can go away and be replaced with a FS_DAX check for this hook
> in the put_page fastpath.
> 
> Based on an earlier patch from Ralph Campbell <rcampbell@nvidia.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c       |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  1 -
>  drivers/gpu/drm/nouveau/nouveau_dmem.c   |  1 -
>  fs/Kconfig                               |  1 -
>  include/linux/memremap.h                 | 12 +++--
>  include/linux/mm.h                       |  6 +--
>  lib/test_hmm.c                           |  1 -
>  mm/Kconfig                               |  4 --
>  mm/internal.h                            |  2 +
>  mm/memcontrol.c                          | 11 ++---
>  mm/memremap.c                            | 57 ++++++++----------------
>  mm/migrate.c                             |  6 ---
>  mm/swap.c                                | 16 ++-----
>  13 files changed, 36 insertions(+), 83 deletions(-)

It looks like a good next step to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  struct dev_pagemap_ops {
>  	/*
> -	 * Called once the page refcount reaches 1.  (ZONE_DEVICE pages never
> -	 * reach 0 refcount unless there is a refcount bug. This allows the
> -	 * device driver to implement its own memory management.)
> +	 * Called once the page refcount reaches 0.  The reference count will be
> +	 * reset to one by the core code after the method is called to prepare
> +	 * for handing out the page again.

I did prefer Ralph's version of this that kept the refcount at 0 while
the page was on the free-list. I hope we can get there again after
later series :)

Jason
