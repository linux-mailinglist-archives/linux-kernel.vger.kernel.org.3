Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA5536360
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352423AbiE0Nja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbiE0Nj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:39:28 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70A146741
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:39:25 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id j7so4267728vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqlg/w/fu3XfRPgdp6en7FxQt+ggN/0l4WsjVJitcVw=;
        b=E2N132fvML6LrBTQk8CEDkWoE7iy6xHPtSdsWWbkkJ9qx2SDmdbsk/2gZz41g52LIE
         TcZrptshVkbF1zidVo3NqoiA1Uj+rRgGCrItspUx/MsbD65NZ8wCsJ+43tj4gSeOdyJT
         PDceHpT5Vc6O6aiNnu+WO7zRsm/ZUcsQBLdfKAu0+d55JKS4L707dtA0tKPlQhZPO4AQ
         oOFpQsdwi00qCGrzgNViGIUY0Y1RE5lk7BpBlg5pEVPibtdTb9whrFBl5rzaxws2CT+a
         sBxIiY+cNOSyLigrEBXnMpZvAUdhsyip742SYxRJRmSF4QJYeqSgWjShR9cflZxibk0M
         Uodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqlg/w/fu3XfRPgdp6en7FxQt+ggN/0l4WsjVJitcVw=;
        b=AyB24sn5t2FkFSZbK1AsC02C59xYUEty4/YUi6YxB5SmsUxZC6M0Q5QHKJUmrH4rNr
         8wX1VXnHOcKfhh3XGP+sZ7RgMsy7Wfo4C5vu0rvdKNPdcXCC7kxBEM0QeYlnDBkH3dvG
         Do/PnOYMwU2eKJ/JbfRORJ5bOHJHv+fRH2NvJMc6Eg8LKVhGLLvX6yP9PUJM+ZV7Mp2R
         2YKxtypHFftnPOi6zl64rwZAQMC0mA6fViM7QHy27FzO3MQra9TMqQFWVLjeGMaG6moo
         ZGyNOE7JTQHBb5wq4eO35aSwAyBMN+/oWAOI8ZGSQkAOjH+irBMUPHekj2JnB8nahkXL
         67JQ==
X-Gm-Message-State: AOAM530rFMwToG3J0TtDBq4npjHX0IbNqEQuTnf19vYrFme/1Cvtf6ve
        hHSBjVSqypy1AKqIgLsWgu8YcMR43ZP1hfg4b2M=
X-Google-Smtp-Source: ABdhPJySDv0PWTGe7FNJUI4axliR/+waikOZH4xVOoaC6lc/giZe/1RKNxnwujNEmpiXphYOtn97ISHWrkU6BVu3v/M=
X-Received: by 2002:a67:d808:0:b0:337:8cab:6c00 with SMTP id
 e8-20020a67d808000000b003378cab6c00mr14451432vsj.66.1653658764178; Fri, 27
 May 2022 06:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220527032504.30341-1-yee.lee@mediatek.com>
In-Reply-To: <20220527032504.30341-1-yee.lee@mediatek.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Fri, 27 May 2022 21:39:11 +0800
Message-ID: <CAGcnep9B+z8QG4f4kkW8NF+fM1Kgj=NOV=YRhLK4yK74jbqpAw@mail.gmail.com>
Subject: Re: [PATCH] mm: kmemleak: Skip check in kmemleak_*_phys when pfn
 bound is not ready
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org, Kuan-Ying.lee@mediatek.com,
        Andrew.Yang@mediatek.com, Sunny.Kao@mediatek.com,
        chinwen.chang@mediatek.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:25 AM <yee.lee@mediatek.com> wrote:
>
> From: Yee Lee <yee.lee@mediatek.com>
>
> In some archs (arm64), memblock allocates memory in boot time when
> the pfn boundary (max_pfn/min_pfn) is not ready. The lowmen checks in
> kmemleak_*_phys() drop those blocks and cause some false leak alarms
> on common kernel objects.
>
> Kmemleak output: (Qemu/arm64)
> unreferenced object 0xffff0000c0170a00 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294892404 (age 126.208s)
>   hex dump (first 32 bytes):
>     62 61 73 65 00 00 00 00 00 00 00 00 00 00 00 00  base............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<(____ptrval____)>] __kmalloc_track_caller+0x1b0/0x2e4
>     [<(____ptrval____)>] kstrdup_const+0x8c/0xc4
>     [<(____ptrval____)>] kvasprintf_const+0xbc/0xec
>     [<(____ptrval____)>] kobject_set_name_vargs+0x58/0xe4
>     [<(____ptrval____)>] kobject_add+0x84/0x100
>     [<(____ptrval____)>] __of_attach_node_sysfs+0x78/0xec
>     [<(____ptrval____)>] of_core_init+0x68/0x104
>     [<(____ptrval____)>] driver_init+0x28/0x48
>     [<(____ptrval____)>] do_basic_setup+0x14/0x28
>     [<(____ptrval____)>] kernel_init_freeable+0x110/0x178
>     [<(____ptrval____)>] kernel_init+0x20/0x1a0
>     [<(____ptrval____)>] ret_from_fork+0x10/0x20
>
> This patch relaxs the boundary checking in kmemleak_*_phys api
> if max_low_pfn is uninitialzed.
>
> Fixes: 23c2d4 (mm: kmemleak: take a full lowmem check in kmemleak_*_phy)
> Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> ---
>  mm/kmemleak.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a182f5ddaf68..6b2af544aa0f 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
>  void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
>                                gfp_t gfp)
>  {
> -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))

Just skip checking will bring the crash possibility back. Seems it's beyond
these interfaces' handle scope for this situation, since "min_low_pfn" and
"max_low_pfn" are depending on arches.

>                 kmemleak_alloc(__va(phys), size, min_count, gfp);
>  }
>  EXPORT_SYMBOL(kmemleak_alloc_phys);
> @@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
>   */
>  void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>  {
> -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
>                 kmemleak_free_part(__va(phys), size);
>  }
>  EXPORT_SYMBOL(kmemleak_free_part_phys);
> @@ -1158,7 +1158,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
>   */
>  void __ref kmemleak_not_leak_phys(phys_addr_t phys)
>  {
> -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
>                 kmemleak_not_leak(__va(phys));
>  }
>  EXPORT_SYMBOL(kmemleak_not_leak_phys);
> @@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
>   */
>  void __ref kmemleak_ignore_phys(phys_addr_t phys)
>  {
> -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
> +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
>                 kmemleak_ignore(__va(phys));
>  }
>  EXPORT_SYMBOL(kmemleak_ignore_phys);
> --
> 2.18.0
>
