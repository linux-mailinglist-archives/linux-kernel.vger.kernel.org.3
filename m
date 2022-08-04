Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB4589FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbiHDRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiHDRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:44:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDA11758A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:44:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o3so498137ple.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/ppL5FkBSrChQnljuBdNYbX2wAl9Ivpv6wHBOwZJkEM=;
        b=mxw+F/7z3YXIMcgO7ctt+zVucnEskLncvgAK2HJeOmAnYh6Cph2ZRwfxDM1CRaSTOi
         iVzoLZzyS7etkgfM34YtE8JSjm9mqUzPZfnK+MZguv/duKOEV9jPlCLA5kAziuFnPkge
         bvWaLalW2JFcojyhfq6AO1gwrvtni8dZX3mZbSXLx4TPoTpRIs6cMvFu5wMgOVud8Rsn
         igo7++jcY0Q/pFvz5iEzmM+BK4VN/kLapf4xHAX+IGgt2tyh/sG8JoV4iUZq6wkeLMhR
         +n3po08Nut7agW9E9IMHR/bSt/ITrdC06VY7sAHjmKlx4Jy3RfINmQ3Fjpbzwv5k0PKS
         vS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/ppL5FkBSrChQnljuBdNYbX2wAl9Ivpv6wHBOwZJkEM=;
        b=7e1KKUweF67DzhZ08EDSHH3xRCuE8qynn85mj6iUsL0iNVIxaxUwzZfqbB53i4YE9D
         215tu+Q3UFLlaIogiZUePpsyIrGYj7RRmllOkL8rKT0c0Jo6546p9tn1Uik0dgQg+o2g
         I9VKxzKPccShg2AA1wC3gC+vtgOTFOqGBqEeOOVi7/PfSE32Xrdz8og8IuKokfaMHzq3
         0ACxebfMywDl74/g98Isz9WbPSFhC0HrP1YdqCwlep/9dFLbVsafDx9pBLTmphUgVssX
         a8wVWnShsL+b45fRMdleHCXK5H75kZIWih2tXCoIjg5gucgiaC0/E7qHRyDeLu93NAWe
         DfEg==
X-Gm-Message-State: ACgBeo1k0z61c4re2/i+QHRhEsSNmugvpVls72QL07RPuhCzuc4gbYzu
        w7bC0rOg5yUVjZAE1gpyNbLmh2Uux059zocPpJU=
X-Google-Smtp-Source: AA6agR7xuV+991n6wMtC1ouAKAX7cI9gnY4rfxk9Dx/AvAaj9pYd/kwMVjbYwLgCyuGOWyg0bJBA+anG/BFDOzPSwxQ=
X-Received: by 2002:a17:90b:1b45:b0:1f3:1974:eb8 with SMTP id
 nv5-20020a17090b1b4500b001f319740eb8mr3231740pjb.200.1659635039717; Thu, 04
 Aug 2022 10:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220803220329.46299-1-peterx@redhat.com>
In-Reply-To: <20220803220329.46299-1-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 4 Aug 2022 10:43:47 -0700
Message-ID: <CAHbLzkoztB1LNOtNWa=8GPABF5xConGox2D1ebdD97467Ykb1A@mail.gmail.com>
Subject: Re: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 3:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> These bits should only be valid when the ptes are present.  Introducing two
> booleans for it and set it to false when !pte_present().
>
> Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 2012-05-31)
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9913f3be9fd2..482f91577f8c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>         struct vm_area_struct *vma = walk->vma;
>         bool locked = !!(vma->vm_flags & VM_LOCKED);
>         struct page *page = NULL;
> -       bool migration = false;
> +       bool migration = false, young = false, dirty = false;
>
>         if (pte_present(*pte)) {
>                 page = vm_normal_page(vma, addr, *pte);
> +               young = pte_young(*pte);
> +               dirty = pte_dirty(*pte);
>         } else if (is_swap_pte(*pte)) {
>                 swp_entry_t swpent = pte_to_swp_entry(*pte);
>
> @@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>         if (!page)
>                 return;
>
> -       smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
> -                     locked, migration);
> +       smaps_account(mss, page, false, young, dirty, locked, migration);
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> --
> 2.32.0
>
