Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03A55C4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiF1MLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbiF1MK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:10:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701BA34673
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:10:55 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id l11so21800808ybu.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kivkjIcW/dBwtKQGxzqBhqyQNzFDh/iWcq1jAKuPzjQ=;
        b=CLRflZYyQbg2Iw8XCTaSt3HhmxKw/xrafgduTJjfhqjN2UgMgl+t/Gw4w6ILs6K9J4
         MiBhpvtp9dwuJoICS/Nb1ZrtA3RQX7LEA7Mz5j+bBQgqJZtt6/ayHu+r5Hhb3qNZ4MWa
         hFjTG4fGYnkRgTZZBBgzYCRgfxmHlPzv/4ipJqE4P/j7/2M+hTvxyKMHh77AZQv+DXXp
         HhfG34tq68ucJafyFKHbBlkKZIavzOm2MyDj5K6/Q7swKn5I+xF/JVEwmlCwkvsZvZHr
         w9cyP8LjUEu4elAD/I0i18jI8ov478QkOC5jYowuBKa+OZLBRkMIuuXZdJu9woKbWYNY
         OIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kivkjIcW/dBwtKQGxzqBhqyQNzFDh/iWcq1jAKuPzjQ=;
        b=Bly5R69UUccL2PvWv3qobDovVUTsIwIFIFIKFuNa84N90DmAeRo2/y0rz3kZkzAQsX
         wFv2USASqYmz3CWlqwnZmlj7fjrUBGaFZOmd99HvkydwR9n/YuDLDCx7CfGfAnXkspiG
         WmdG5AL/MlMv9p+iMFQCA0nxlQl/WNnjHMHnZFVeC5WdfJoOrwf7sxrQC667H4PYExVL
         fTUxMwSm9xPVinFr6u+mnEDLPDiNz1X5wKOVhbDFZD7+7f2tftq1pViGnm011O32DoAB
         5RyxkzqVnvb8R/4lzuw12B1SkT21slbGncqDrtwOg6wOvbYgoX9NkgxM/WjO+RJ1iK3d
         FLvg==
X-Gm-Message-State: AJIora8mJB9lmEb1fYo+P3v/prQBeNTYiuPf5dC/jutWuuPsVidDJOZh
        yg+Z49VUddlYIsm6bMGY7tF8wdg5Xgv8NWxDhXsQ60OK+NHcqg==
X-Google-Smtp-Source: AGRyM1smrNVxZFq8RnZCs9l8cbaNFOI8pfYR4MykJ5KZXRx6x1Zw9wNjdz4oF5DQdShpdaP6Z1l8ckzfBHZHCRervgg=
X-Received: by 2002:a25:cc56:0:b0:66c:d0f6:2f0e with SMTP id
 l83-20020a25cc56000000b0066cd0f62f0emr10988742ybf.168.1656418254817; Tue, 28
 Jun 2022 05:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220628113714.7792-1-yee.lee@mediatek.com> <20220628113714.7792-2-yee.lee@mediatek.com>
In-Reply-To: <20220628113714.7792-2-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 14:10:18 +0200
Message-ID: <CANpmjNNSHEksMq+xR62mV5dzb0ZO7UPhUzt2ghSbqcR-Bsm_2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
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

On Tue, 28 Jun 2022 at 13:37, yee.lee via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> This patch solves two issues.
>
> (1) The pool allocated by memblock needs to unregister from
> kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> original kmemleak_free as its address now is stored in the phys tree.
>
> (2) The pool late allocated by page-alloc doesn't need to unregister.
> Move out the freeing operation from its call path.
>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>

Reviewed-by: Marco Elver <elver@google.com>

Does this want a Fixes tag?

> ---
>  mm/kfence/core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4e7cd4c8e687..32a4a75e820c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -600,14 +600,6 @@ static unsigned long kfence_init_pool(void)
>                 addr += 2 * PAGE_SIZE;
>         }
>
> -       /*
> -        * The pool is live and will never be deallocated from this point on.
> -        * Remove the pool object from the kmemleak object tree, as it would
> -        * otherwise overlap with allocations returned by kfence_alloc(), which
> -        * are registered with kmemleak through the slab post-alloc hook.
> -        */
> -       kmemleak_free(__kfence_pool);
> -
>         return 0;
>  }
>
> @@ -620,8 +612,16 @@ static bool __init kfence_init_pool_early(void)
>
>         addr = kfence_init_pool();
>
> -       if (!addr)
> +       if (!addr) {
> +               /*
> +                * The pool is live and will never be deallocated from this point on.
> +                * Ignore the pool object from the kmemleak phys object tree, as it would
> +                * otherwise overlap with allocations returned by kfence_alloc(), which
> +                * are registered with kmemleak through the slab post-alloc hook.
> +                */
> +               kmemleak_ignore_phys(__pa(__kfence_pool));
>                 return true;
> +       }
>
>         /*
>          * Only release unprotected pages, and do not try to go back and change
> --
> 2.18.0
