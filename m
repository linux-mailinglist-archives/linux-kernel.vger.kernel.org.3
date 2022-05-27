Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE5535E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbiE0KU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345512AbiE0KU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:20:28 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22D1271B8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:20:27 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id d132so1849485vke.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZKGv1sVPbn33wSFQC2Hq1TTGl51W+KoM8tu8whSa+8=;
        b=QPJBbxLga9z4bh76vDTCdWiIm0fFqSq0xsZaD4/EcFAsk7UUqTJMVgbymVey6Y8rhP
         PboTeGA3VQ2Xk04Jjgj56gdD/R76WekWIn10md8C9xSA6SyQDTYEZQRdiVkTg3+ashWs
         QDz+w0fzSf3U8uVQe8l2oRu9SZfmbHFuRzlVO3JF5DpkGNudYVwnhl0SQRvY9f7YvbI6
         BriJ6JmHW3g8ekfRRYekCrPj7hByDo5qlteqj/chMuFuzMDADe5I+n20pP1VqzgE5IB6
         Thr5+ZRpZYeFE68q86npCR6iptHjCk+ekb5DlLWvC2h5HeIwDjVgExL1HfAwqSK9e1f6
         GoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZKGv1sVPbn33wSFQC2Hq1TTGl51W+KoM8tu8whSa+8=;
        b=yyRwBe9h5QlxsDo/3ygerwH3Hdmu/Qq+cTqCmdRKGO6iqeE1mGp5BZjl0u/LVzakXt
         3L/B72Nv2t25rqSBdqt6mVM9Vhwa8ztgQdGrhnixVXQ5uocGksdA8Hr7dHDtHGEACoQC
         +X6etU9E6RalD9MZ2h2+IKDEyn2W5TewgiV0BV2QQRE13nr+vnYv0jOFOiLLQQNrXJlJ
         R26hiUwfyGxRJL5zwbMod4LhvfYpgW7AE3qxuVGVT3/F/XtvqI3yN85boh2VR6YBGcA1
         Ft4WE+frIQ9qOJ5IqQOGot57uzP/8qaAPHxteDKw++RK2PVBg0RXSUvadF84Y05dGJcd
         MuDA==
X-Gm-Message-State: AOAM533hHbXXvJ44QLL2Ht2HEdnBXzhD7iNoTbQ0aSBdtzoOwkld7tkH
        JloE1kqnSdku7xK9Vh3vV1GSWlhn7ybD9RvAvn3Othh5
X-Google-Smtp-Source: ABdhPJzCvvChTLL1Ij936+gWZfCHT1cI1LarPkF1I6RwV3Pk4C5uy4ku0CQpduox7gHOYLFdtC0zFPW6WdlyCuyLSic=
X-Received: by 2002:a1f:a107:0:b0:357:a962:cef8 with SMTP id
 k7-20020a1fa107000000b00357a962cef8mr9396561vke.10.1653646826292; Fri, 27 May
 2022 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220527032504.30341-1-yee.lee@mediatek.com>
In-Reply-To: <20220527032504.30341-1-yee.lee@mediatek.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Fri, 27 May 2022 18:20:14 +0800
Message-ID: <CAGcnep-t7GRkQxCQw-si0QgnsP9mQepcJ+xuYeQyzJLwc0Xicw@mail.gmail.com>
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

If I understand correctly, if those blocks are dropped, they will
not be added as kmemleak objects. So how could this affect
other objects?

Thanks,
Patrick

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
