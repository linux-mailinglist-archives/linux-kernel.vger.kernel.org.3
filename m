Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4DA5579FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiFWMHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiFWMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:07:19 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174524B436
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:07:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t1so35459036ybd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACxXBxS9wLm3s0o360W5tadVCtNgAfMCjbW4/7oTcA4=;
        b=SQAHvCcWiZPW2d3TCyD1ucF5/vuJJlyPVHSS/EBGdmL8eX5SUfz3/Ks10JcOSDF4FX
         6NM2LxV3aGPxbmKFW6CymAyrqLU04WuWmUf2W35juuB5SYN+qyur+64ek1GkZNdOxCws
         tTjaOk+a96XPGBxGCBD5TPY35OoLL5ZfevMzMdl7MTdY4Lju9vHRIWrmkL9wOONsxjX1
         O/asGkoOSqI99F3ZdcWFu2tF4TQnWuBOhwiu1f+nogWCWs7sx7Xb7ixvQeYV05cPLDTG
         vGEWDE0n6iE6LBdtk56t/E4aRGQdXA2peo3o93/9OM1CH/Qznz+D7SbjboU23TZ3IHe3
         YhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACxXBxS9wLm3s0o360W5tadVCtNgAfMCjbW4/7oTcA4=;
        b=FEKAfQlaWE2oKHr7oKbaGRsPj1kXSwwNrOLigMjssCXC+0hTf6RoY77ueCcAqIJYHs
         3BuYJPZDQyN1Nqzzv2iSVI6iskZrLy2jdu/OIiZcqLMMTlDfjaknx6IriX35/hTviub2
         rxwMrw741QRbJK3y1uH29/LWaNRAtnNKLzlf6X5rSkoFGw7OGMpxBn3ME+TYDzvleXPN
         2SEBB+LrVd3FYfK/DMIrlXV9x+QdWVVPjrZn4OtkNvO8tI982juQPyWBxS3xWstt7TxD
         PH6kUw1hBcxsu56eqRGRmHDF8ooc9KvBLTczTQpb+4dDay3SW1MyNMS3QDHbhVYHF1JA
         fdUg==
X-Gm-Message-State: AJIora/tYGQq4xoCsW7py+NauVGuYPLZdXzW4gyOIZEvIJvJgwSiUnMp
        iLE4MDk+lfj/TRijoz5HwSocSRNyOFqBca1F13z7nwhH05E=
X-Google-Smtp-Source: AGRyM1so/RVtDJwHhTKgYn+XHelVpXIxpsLsc4tp78gqxCR/ieVCu7jnZAYDuCZ45vtLrLwadNS0nmv5gI6/XxqOHnU=
X-Received: by 2002:a81:1591:0:b0:317:bb1f:fb83 with SMTP id
 139-20020a811591000000b00317bb1ffb83mr10329151ywv.362.1655985635802; Thu, 23
 Jun 2022 05:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220623111937.6491-1-yee.lee@mediatek.com> <20220623111937.6491-2-yee.lee@mediatek.com>
In-Reply-To: <20220623111937.6491-2-yee.lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Jun 2022 13:59:59 +0200
Message-ID: <CANpmjNN-jsZoVmJWD2Dz6O3_YVjy0av6e0iD-+OYXpik1LbLvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: kfence: skip kmemleak alloc in kfence_pool
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org,
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

On Thu, 23 Jun 2022 at 13:20, yee.lee via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> Use MEMBLOCK_ALLOC_NOLEAKTRACE to skip kmemleak registration when
> the kfence pool is allocated from memblock. And the kmemleak_free
> later can be removed too.

Is this purely meant to be a cleanup and non-functional change?

> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
>
> ---
>  mm/kfence/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4e7cd4c8e687..0d33d83f5244 100644
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

This appears to only be a non-functional change if the pool is
allocated early. If the pool is allocated late using page-alloc, then
there'll not be a kmemleak_free() on that memory and we'll have the
same problem.
