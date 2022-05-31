Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDC5393A2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiEaPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiEaPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:07:30 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7682551E7C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:07:29 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id az25so5176429vkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S9GnfEHaSBA3h8Z8c3Ga5zWpFlXSYvFHz3qXRMFx33A=;
        b=RHaSGOpQtN8fHKsZoAdjCPk0ydta8EnxZfEIRUYF+QGxY7uMWVArGeqLiHv7alh+iQ
         i5xgibjzMKCHru2f/jV7YNkrzuJbi4lEagEUwtbIXahnHixtkzXBl3uOAvxugCfg2PH3
         r5qyxchTsFJgUfZ429zdcsgyHape4XS1G4i6LPol5ObgYMw9RniuKJS9HLHsuz4lehF8
         LYlcDaEEqV2CJIDT8r54NnXoi0B0AAoVyD25J37i96IeiHyXVm+clE8vUOcFIZk8iFnN
         w7YM4aa+GiHwh8wwbvZlV+ED6C8Wu6rW+8maOZj8PQVtrGN45xZVUKB/kEjs2pDbAqNC
         k0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S9GnfEHaSBA3h8Z8c3Ga5zWpFlXSYvFHz3qXRMFx33A=;
        b=n7L40awSqzgPjRsKO+lZmmOVHsgd+3tPMr8Tg2bJQPP0H0IasX/KBitVMjnA9AXgpS
         tOjWA5WcBVZXrU2phpm6m7l6+naT3guaKzGPaEAtAexqQLtCC2EKS49ib3rOXtpNy7qz
         2+tfEa/JzzrN8BeBC/WUugKDq1b2nmoplftNrUKME9OIwVZmGKOZbouG1ebrR29Ye7qs
         U9kCDF67ZeMorei4U5ibetsZgOAl28u4S8kWJp7S8KJLkFnelg9UNAdvrE1TUWBE5bD8
         GjRQ+2t02jnu6vqcN1PvmvkTExMNxlpdUWNVCAOylSGE9P7A3pbln+lx4WiaJ9dpVXVB
         +1Nw==
X-Gm-Message-State: AOAM532C5sgJomb1xiSBWmmXqRdWGE/EM/hYKmTqE2aUqGXJZWP5lx4h
        Az/UbahCdPSpkv4q6lr4M67pMa9kyBDSQM61XfY=
X-Google-Smtp-Source: ABdhPJxkpe2eweO03GnAdVw6MTsZhaesQdgnccVMHj/rdeXRTqToErbZ8HpgVo4GMXEnS+x8MC4xe4DyBZ86efyJaCk=
X-Received: by 2002:a05:6122:2089:b0:357:d4b4:e02f with SMTP id
 i9-20020a056122208900b00357d4b4e02fmr15592420vkd.35.1654009648432; Tue, 31
 May 2022 08:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220527032504.30341-1-yee.lee@mediatek.com> <CAGcnep9B+z8QG4f4kkW8NF+fM1Kgj=NOV=YRhLK4yK74jbqpAw@mail.gmail.com>
 <05cfaf936a0c5f37f2e7ba779a8a1b0a6252be96.camel@mediatek.com>
 <64281aab-0301-7237-d72c-b7ab41bf50e4@gmail.com> <YpTbO/z1n0UYswBf@arm.com>
In-Reply-To: <YpTbO/z1n0UYswBf@arm.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Tue, 31 May 2022 23:07:16 +0800
Message-ID: <CAGcnep-d6+Np6+MK4XwOmpr_MA7VVSrhXv0p+GsJqENyCrTyAg@mail.gmail.com>
Subject: Re: [PATCH] mm: kmemleak: Skip check in kmemleak_*_phys when pfn
 bound is not ready
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Yee Lee <yee.lee@mediatek.com>, linux-kernel@vger.kernel.org,
        Kuan-Ying.lee@mediatek.com, Andrew.Yang@mediatek.com,
        Sunny.Kao@mediatek.com, chinwen.chang@mediatek.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 10:57 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Hi Patrick,
>
> On Mon, May 30, 2022 at 09:32:18PM +0800, Patrick Wang wrote:
> > On 2022/5/30 10:27, Yee Lee wrote:
> > > On Fri, 2022-05-27 at 21:39 +0800, patrick wang wrote:
> > > > On Fri, May 27, 2022 at 11:25 AM <yee.lee@mediatek.com> wrote:
> > > > > From: Yee Lee <yee.lee@mediatek.com>
> > > > >
> > > > > In some archs (arm64), memblock allocates memory in boot time whe=
n
> > > > > the pfn boundary (max_pfn/min_pfn) is not ready. The lowmen check=
s in
> > > > > kmemleak_*_phys() drop those blocks and cause some false leak ala=
rms
> > > > > on common kernel objects.
> > > > >
> > > > > Kmemleak output: (Qemu/arm64)
> > > > > unreferenced object 0xffff0000c0170a00 (size 128):
> > > > >    comm "swapper/0", pid 1, jiffies 4294892404 (age 126.208s)
> > > > >    hex dump (first 32 bytes):
> > > > >      62 61 73 65 00 00 00 00 00 00 00 00 00 00 00 00  base.......=
.....
> > > > >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ...........=
.....
> > > > >    backtrace:
> > > > >      [<(____ptrval____)>] __kmalloc_track_caller+0x1b0/0x2e4
> > > > >      [<(____ptrval____)>] kstrdup_const+0x8c/0xc4
> > > > >      [<(____ptrval____)>] kvasprintf_const+0xbc/0xec
> > > > >      [<(____ptrval____)>] kobject_set_name_vargs+0x58/0xe4
> > > > >      [<(____ptrval____)>] kobject_add+0x84/0x100
> > > > >      [<(____ptrval____)>] __of_attach_node_sysfs+0x78/0xec
> > > > >      [<(____ptrval____)>] of_core_init+0x68/0x104
> > > > >      [<(____ptrval____)>] driver_init+0x28/0x48
> > > > >      [<(____ptrval____)>] do_basic_setup+0x14/0x28
> > > > >      [<(____ptrval____)>] kernel_init_freeable+0x110/0x178
> > > > >      [<(____ptrval____)>] kernel_init+0x20/0x1a0
> > > > >      [<(____ptrval____)>] ret_from_fork+0x10/0x20
> > > > >
> > > > > This patch relaxs the boundary checking in kmemleak_*_phys api
> > > > > if max_low_pfn is uninitialzed.
> > > > >
> > > > > Fixes: 23c2d4 (mm: kmemleak: take a full lowmem check in kmemleak=
_*_phy)
>
> BTW, please use at least 12 characters for the git sha1, the above is
> ambiguous.
>
> > > > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > > > > ---
> > > > >   mm/kmemleak.c | 8 ++++----
> > > > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > > > > index a182f5ddaf68..6b2af544aa0f 100644
> > > > > --- a/mm/kmemleak.c
> > > > > +++ b/mm/kmemleak.c
> > > > > @@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
> > > > >   void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, i=
nt min_count,
> > > > >                                 gfp_t gfp)
> > > > >   {
> > > > > -       if (PHYS_PFN(phys) >=3D min_low_pfn && PHYS_PFN(phys) < m=
ax_low_pfn)
> > > > > +       if (!max_low_pfn || (PHYS_PFN(phys) >=3D min_low_pfn && P=
HYS_PFN(phys) < max_low_pfn))
> > > >
> > > > Just skip checking will bring the crash possibility back. Seems
> > > > it's beyond these interfaces' handle scope for this situation,
> > > > since "min_low_pfn" and "max_low_pfn" are depending on arches.
> > >
> > > Yes, for the cases beyond the pfn guard, users have to take care the
> > > boundary by themselves.
> >
> > Could we record these early calling and deal with them when it's
> > ready? Is this appropriate?
> >
> > I have an implementation based on this approach. Could you please
> > help to have a test on your machine as well? And someone to take
> > a look or review?
>
> We had something similar until 5.4, removed by commit c5665868183f ("mm:
> kmemleak: use the memory pool for early allocations"). It was a bit
> painful as we never had the right buffer, so I'm not keen on adding it
> back.

Agreed.

> > From 82cae75dfaa78f414faf85bb49133e95159c041a Mon Sep 17 00:00:00 2001
> > From: Patrick Wang <patrick.wang.shcn@gmail.com>
> > Date: Mon, 30 May 2022 18:38:23 +0800
> > Subject: [PATCH] mm: kmemleak: record early operations and handle later
> >
> > The kmemleak_*_phys() interface uses "min_low_pfn" and
> > "max_low_pfn" to check address. But on some architectures,
> > kmemleak_*_phys() is called before those two variables
> > initialized. Record these early operations and handle them
> > when kmemleak_*_phys() are ready.
>
> Could we instead record everything (no checks) but later avoid scanning
> if below min or above max_low_pfn? We can add an OBJECT_PHYS flag to all
> objects allocated via kmemleak_*_phys() and always check the
> virt_to_phys() boundaries at scan time. It may actually help with this
> problem as well:
>
> https://lore.kernel.org/r/9dd08bb5-f39e-53d8-f88d-bec598a08c93@gmail.com

Check in kmemleak_*_phys()  even recorded early operations, the condition
still relies on archs somewhat and is not that clear. Checking at scan
time should
be a proper direction. So that kmemleak doesn't have to rely on archs.

I have implemented it in this direction, and I believe it=E2=80=98s also
helpful for the above
false positive report.

Thanks,
Patrick

>
> --
> Catalin
