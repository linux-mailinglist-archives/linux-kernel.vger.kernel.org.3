Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968F5770CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGPSnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:43:22 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A313EB2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:43:20 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id n2so4559882qkk.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsEhwdLdNfwHR9LCxaWkzLk9jCaKVkk47P3wBYbLRH0=;
        b=k/Eyk5Aqnev5dHm/HZO7ZktvGtHfaXF9BbhwZH9QJyH9fLF9C7wROz9o1aWxQvKYeW
         +Jl0JfZ+Bl/NDYLsuwB57QsSJTK2nNTovwhIm3tvHkHQXOpgZX5EYrrVe8FUzPj336YB
         0qTIqD4ChuuK4nNC7Yld5JxjrX01gPFkxFwoc+cL1OaGJ1C1/ZckCwTVoDPUPwqmNc+U
         lvk0wsk681s0iJR74Z/baidJuipv+l4KIRzaflh4GaQGIgsqKlYM//mjZXMDfnypl86J
         kn9Z14MISvP7s6oMnaRq+DUZUNIgUPhXougJEhpoH3o3k6gPV+oBNtLSAqulMEqeC3qh
         AE4Q==
X-Gm-Message-State: AJIora9EdPaaEuNMlY9fsU1SqRCMwte2yS2B1m4ANBvQAWzX/w93BmbL
        k47pnQSv1V80pcLq3FDLtVwuLd/9NgVk6A==
X-Google-Smtp-Source: AGRyM1sUsnEM4/8trGrVVSVAV4792uw4N46VY+iNOs2YqaO2vpQIyO1N5A0LsJi5nwGQ6BO1Ra7qIA==
X-Received: by 2002:a37:6544:0:b0:6b5:bc75:1058 with SMTP id z65-20020a376544000000b006b5bc751058mr11711153qkb.248.1657996998976;
        Sat, 16 Jul 2022 11:43:18 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b0069fe1dfbeffsm7192630qkp.92.2022.07.16.11.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 11:43:18 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 6so13885827ybc.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:43:18 -0700 (PDT)
X-Received: by 2002:a05:6902:1246:b0:66e:ea31:8d05 with SMTP id
 t6-20020a056902124600b0066eea318d05mr20988380ybu.89.1657996997798; Sat, 16
 Jul 2022 11:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220628113714.7792-1-yee.lee@mediatek.com> <20220628113714.7792-2-yee.lee@mediatek.com>
 <CAMuHMdX=MTsmo5ZVa8ya3xmr4Mx7f0PB3gvFF42pdaTYB6-u5A@mail.gmail.com> <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
In-Reply-To: <20220715163305.e70c8542d5e7d96c5fd87185@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 16 Jul 2022 20:43:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
Message-ID: <CAMuHMdWSsibmL=LauLm+OTn0SByLA4tGsbhbMsnvSRdb381RTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: kfence: apply kmemleak_ignore_phys on early
 allocated pool
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     yee.lee@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KFENCE" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sat, Jul 16, 2022 at 1:33 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 15 Jul 2022 10:17:43 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jun 28, 2022 at 1:42 PM <yee.lee@mediatek.com> wrote:
> > > From: Yee Lee <yee.lee@mediatek.com>
> > >
> > > This patch solves two issues.
> > >
> > > (1) The pool allocated by memblock needs to unregister from
> > > kmemleak scanning. Apply kmemleak_ignore_phys to replace the
> > > original kmemleak_free as its address now is stored in the phys tree.
> > >
> > > (2) The pool late allocated by page-alloc doesn't need to unregister.
> > > Move out the freeing operation from its call path.
> > >
> > > Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> >
> > Thank you, this fixes the storm of
> >
> >     BUG: KFENCE: invalid read in scan_block+0x78/0x130
> >     BUG: KFENCE: use-after-free read in scan_block+0x78/0x130
> >     BUG: KFENCE: out-of-bounds read in scan_block+0x78/0x130
> >
> > messages I was seeing on arm64.
>
> Thanks, but...
>
> - It would be great if we could identify a Fixes: for this.

IIRC, I started seeing the issue with "[PATCH v4 3/4] mm:
kmemleak: add rbtree and store physical address for objects
allocated with PA" (i.e. commit 0c24e061196c21d5 ("mm: kmemleak:
add rbtree and store physical address for objects allocated
with PA")) of series "[PATCH v4 0/4] mm: kmemleak: store objects
allocated with physical address separately and check when scan"
(https://lore.kernel.org/all/20220611035551.1823303-1-patrick.wang.shcn@gmail.com),
in an arm64 config that had enabled kfence.
So I think this patch is sort of a dependency for that series.

I had cherry-picked that series after bisecting a regression to
commit 23c2d497de21f258 ("mm: kmemleak: take a full lowmem check in
kmemleak_*_phys()") in v5.18-rc3, and having a look around.

> - This patch has been accused of crashing the kernel:
>
>         https://lkml.kernel.org/r/YsFeUHkrFTQ7T51Q@xsang-OptiPlex-9020
>
>   Do we think that report is bogus?

I think all of this is highly architecture-specific...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
