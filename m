Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFC6596009
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiHPQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiHPQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:20:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF1E45
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:20:33 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-32868f43dd6so164568347b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TmDmP2Yh2xB0Nw2rEpzh522PfockFUs65PSBK5ilao8=;
        b=D6VUDRfgjEV6Oks3BCMPo1Apiv37NO/4LwPweuPco56VlT8Dkpc15yJYPfe0l88epI
         jtDgcRRvopVpCNGyxxgN6islo0+kLYv1D2pbOSO1Z0dmBLVZqXVqYmjGrUYHdqp+83+R
         qgO/IqoYiwhEXfQiUSH97ZhgPbUqURr/WKnMAZ/mtB6I4KQJocTq8UzGUuXu3pyLjCab
         DeU96vs0H5pk8wSU5eVOiaOVgtqzw4eHeQAj1bUu65G3GgHfvH92V9Z0/4f5Z6WYV0uj
         Io2kCdpzhTBWwSVWiwlvJm7mwpRYXi7c/gaQYAZD6qZXpw9MSf8JAreaxWigfNad/2db
         urBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TmDmP2Yh2xB0Nw2rEpzh522PfockFUs65PSBK5ilao8=;
        b=y8Z/flfjBzqmOEmXB/6gXbjWzbp+Aak9u7xy1dHHP9p8+8AVMbdbMrDF4W7bSnkZCT
         so0Dyyj7MdtGiTP58PDwqI1xaatoNIkqC6yrBq8zVwnEfWIrjeXlyXhcq6W1K0LAeKnM
         4I5lzHcvt+nAEzyJRK9mwndZVqH+BVJEP17zp9WyqZ/H3VSZmDKSUA4ZptHxpoa7bzC8
         tokMnaCffNX+my6gyt3LfLNxARODRAkdzTsss3ABTT06+PdCXu1ynzEHdd6DJPbiGscn
         bXePqN14FlMb53rKPrzjjGHPDQnB5dPts/EuqQNM1Q0/g3VGsq1IaxavrLaFLrir9kEr
         qUjg==
X-Gm-Message-State: ACgBeo1ZTsSeVq1wIJSlm7qTFBGQR+nWH14pl9FVYzaLvTtDL7E30Ogr
        z+Rr1iV3rwevGQE1x0gjpzba4TJrnxpdajk0o256l9WyntI=
X-Google-Smtp-Source: AA6agR5qmdXdoZCr+yGPN5qQTVnWFQA2x8Hha+7gFg1IeaJ8AIbHz2A3vmkKZRhZChq8hd/F8cICoN5YPl8eTT/Bo98=
X-Received: by 2002:a25:828c:0:b0:68f:6fd6:56b3 with SMTP id
 r12-20020a25828c000000b0068f6fd656b3mr1106642ybk.611.1660666832507; Tue, 16
 Aug 2022 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220816142529.1919543-1-elver@google.com>
In-Reply-To: <20220816142529.1919543-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 16 Aug 2022 18:19:56 +0200
Message-ID: <CANpmjNNFkU4QEmk7ULGsNzwK=dnyhP7zeCGdu9mevwwLNAD0cg@mail.gmail.com>
Subject: Re: [PATCH] kfence: free instead of ignore pool from kmemleak
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Max Schulze <max.schulze@online.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yee Lee <yee.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Catalin's comment in
https://lore.kernel.org/all/Yvu4bBmykYr+0CXk@arm.com/T/#u
this patch should be ignored, because 6.0-rc1 is fine. We just have to
fix 5.19 by reverting 07313a2b29ed from it.


On Tue, 16 Aug 2022 at 16:25, Marco Elver <elver@google.com> wrote:
>
> Due to recent changes to kmemleak and how memblock allocated memory is
> stored in the phys object tree of kmemleak, 07313a2b29ed ("mm: kfence:
> apply kmemleak_ignore_phys on early allocated pool") tried to fix KFENCE
> compatibility.
>
> KFENCE's memory can't simply be ignored, but must be freed completely
> due to it being handed out on slab allocations, and the slab post-alloc
> hook attempting to insert the object to the kmemleak object tree.
>
> Without this fix, reports like the below will appear during boot, and
> kmemleak is effectively rendered useless when KFENCE is enabled:
>
>  | kmemleak: Cannot insert 0xffffff806e24f000 into the object search tree (overlaps existing)
>  | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-v8-0815+ #5
>  | Hardware name: Raspberry Pi Compute Module 4 Rev 1.0 (DT)
>  | Call trace:
>  |  dump_backtrace.part.0+0x1dc/0x1ec
>  |  show_stack+0x24/0x80
>  |  dump_stack_lvl+0x8c/0xb8
>  |  dump_stack+0x1c/0x38
>  |  create_object.isra.0+0x490/0x4b0
>  |  kmemleak_alloc+0x3c/0x50
>  |  kmem_cache_alloc+0x2f8/0x450
>  |  __proc_create+0x18c/0x400
>  |  proc_create_reg+0x54/0xd0
>  |  proc_create_seq_private+0x94/0x120
>  |  init_mm_internals+0x1d8/0x248
>  |  kernel_init_freeable+0x188/0x388
>  |  kernel_init+0x30/0x150
>  |  ret_from_fork+0x10/0x20
>  | kmemleak: Kernel memory leak detector disabled
>  | kmemleak: Object 0xffffff806e24d000 (size 2097152):
>  | kmemleak:   comm "swapper", pid 0, jiffies 4294892296
>  | kmemleak:   min_count = -1
>  | kmemleak:   count = 0
>  | kmemleak:   flags = 0x5
>  | kmemleak:   checksum = 0
>  | kmemleak:   backtrace:
>  |      kmemleak_alloc_phys+0x94/0xb0
>  |      memblock_alloc_range_nid+0x1c0/0x20c
>  |      memblock_alloc_internal+0x88/0x100
>  |      memblock_alloc_try_nid+0x148/0x1ac
>  |      kfence_alloc_pool+0x44/0x6c
>  |      mm_init+0x28/0x98
>  |      start_kernel+0x178/0x3e8
>  |      __primary_switched+0xc4/0xcc
>
> Reported-by: Max Schulze <max.schulze@online.de>
> Fixes: 07313a2b29ed ("mm: kfence: apply kmemleak_ignore_phys on early allocated pool")
> Fixes: 0c24e061196c ("mm: kmemleak: add rbtree and store physical address for objects allocated with PA")
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Yee Lee <yee.lee@mediatek.com>
> ---
>
> Note: This easily reproduces on v5.19, but on 6.0-rc1 the issue is
> hidden by yet more kmemleak changes, but properly freeing the pool is
> the correct thing to do either way, given the post-alloc slab hooks.
> ---
>  mm/kfence/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index c252081b11df..9e52f2b87374 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -617,12 +617,13 @@ static bool __init kfence_init_pool_early(void)
>
>         if (!addr) {
>                 /*
> -                * The pool is live and will never be deallocated from this point on.
> -                * Ignore the pool object from the kmemleak phys object tree, as it would
> -                * otherwise overlap with allocations returned by kfence_alloc(), which
> -                * are registered with kmemleak through the slab post-alloc hook.
> +                * The pool is live and will never be deallocated from this
> +                * point on. Remove the pool object from the kmemleak phys
> +                * object tree, as it would otherwise overlap with allocations
> +                * returned by kfence_alloc(), which are registered with
> +                * kmemleak through the slab post-alloc hook.
>                  */
> -               kmemleak_ignore_phys(__pa(__kfence_pool));
> +               kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
>                 return true;
>         }
>
> --
> 2.37.1.595.g718a3a8f04-goog
>
