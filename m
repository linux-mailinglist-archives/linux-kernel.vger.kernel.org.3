Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE0535F19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351252AbiE0LRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiE0LRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:17:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B3122B61
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:17:48 -0700 (PDT)
X-UUID: edc55d0acafa4a9c981f9c0f8070a9de-20220527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:d9dbc11a-506e-45c6-a732-5ef9c533a063,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:381bbc47-4fb1-496b-8f1d-39e733fed1ea,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: edc55d0acafa4a9c981f9c0f8070a9de-20220527
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 135672329; Fri, 27 May 2022 19:17:43 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 27 May 2022 19:17:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 27 May 2022 19:17:42 +0800
Message-ID: <3b1542b95a3d322b798bf212b22c6c3567a76c13.camel@mediatek.com>
Subject: Re: [PATCH] mm: kmemleak: Skip check in kmemleak_*_phys when pfn
 bound is not ready
From:   Yee Lee <yee.lee@mediatek.com>
To:     patrick wang <patrick.wang.shcn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <Kuan-Ying.lee@mediatek.com>,
        <Andrew.Yang@mediatek.com>, <Sunny.Kuo@mediatek.com>,
        <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 27 May 2022 19:17:42 +0800
In-Reply-To: <CAGcnep-t7GRkQxCQw-si0QgnsP9mQepcJ+xuYeQyzJLwc0Xicw@mail.gmail.com>
References: <20220527032504.30341-1-yee.lee@mediatek.com>
         <CAGcnep-t7GRkQxCQw-si0QgnsP9mQepcJ+xuYeQyzJLwc0Xicw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 18:20 +0800, patrick wang wrote:
> On Fri, May 27, 2022 at 11:25 AM <yee.lee@mediatek.com> wrote:
> > 
> > From: Yee Lee <yee.lee@mediatek.com>
> > 
> > In some archs (arm64), memblock allocates memory in boot time when
> > the pfn boundary (max_pfn/min_pfn) is not ready. The lowmen checks
> > in
> > kmemleak_*_phys() drop those blocks and cause some false leak
> > alarms
> > on common kernel objects.
> 
> If I understand correctly, if those blocks are dropped, they will
> not be added as kmemleak objects. So how could this affect
> other objects?
> 
> Thanks,
> Patrick

Yes, in fact, memblock needs those areas never reported as leaks and
add them as grey blocks. More detailed comments can be found inside
memblock_alloc_range_nid. 

> 
> > 
> > Kmemleak output: (Qemu/arm64)
> > unreferenced object 0xffff0000c0170a00 (size 128):
> >   comm "swapper/0", pid 1, jiffies 4294892404 (age 126.208s)
> >   hex dump (first 32 bytes):
> >     62 61 73 65 00 00 00 00 00 00 00 00 00 00 00
> > 00  base............
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00  ................
> >   backtrace:
> >     [<(____ptrval____)>] __kmalloc_track_caller+0x1b0/0x2e4
> >     [<(____ptrval____)>] kstrdup_const+0x8c/0xc4
> >     [<(____ptrval____)>] kvasprintf_const+0xbc/0xec
> >     [<(____ptrval____)>] kobject_set_name_vargs+0x58/0xe4
> >     [<(____ptrval____)>] kobject_add+0x84/0x100
> >     [<(____ptrval____)>] __of_attach_node_sysfs+0x78/0xec
> >     [<(____ptrval____)>] of_core_init+0x68/0x104
> >     [<(____ptrval____)>] driver_init+0x28/0x48
> >     [<(____ptrval____)>] do_basic_setup+0x14/0x28
> >     [<(____ptrval____)>] kernel_init_freeable+0x110/0x178
> >     [<(____ptrval____)>] kernel_init+0x20/0x1a0
> >     [<(____ptrval____)>] ret_from_fork+0x10/0x20
> > 
> > This patch relaxs the boundary checking in kmemleak_*_phys api
> > if max_low_pfn is uninitialzed.
> > 
> > Fixes: 23c2d4 (mm: kmemleak: take a full lowmem check in
> > kmemleak_*_phy)
> > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > ---
> >  mm/kmemleak.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index a182f5ddaf68..6b2af544aa0f 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
> >  void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int
> > min_count,
> >                                gfp_t gfp)
> >  {
> > -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> > max_low_pfn)
> > +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn &&
> > PHYS_PFN(phys) < max_low_pfn))
> >                 kmemleak_alloc(__va(phys), size, min_count, gfp);
> >  }
> >  EXPORT_SYMBOL(kmemleak_alloc_phys);
> > @@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
> >   */
> >  void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
> >  {
> > -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> > max_low_pfn)
> > +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn &&
> > PHYS_PFN(phys) < max_low_pfn))
> >                 kmemleak_free_part(__va(phys), size);
> >  }
> >  EXPORT_SYMBOL(kmemleak_free_part_phys);
> > @@ -1158,7 +1158,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
> >   */
> >  void __ref kmemleak_not_leak_phys(phys_addr_t phys)
> >  {
> > -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> > max_low_pfn)
> > +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn &&
> > PHYS_PFN(phys) < max_low_pfn))
> >                 kmemleak_not_leak(__va(phys));
> >  }
> >  EXPORT_SYMBOL(kmemleak_not_leak_phys);
> > @@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
> >   */
> >  void __ref kmemleak_ignore_phys(phys_addr_t phys)
> >  {
> > -       if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) <
> > max_low_pfn)
> > +       if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn &&
> > PHYS_PFN(phys) < max_low_pfn))
> >                 kmemleak_ignore(__va(phys));
> >  }
> >  EXPORT_SYMBOL(kmemleak_ignore_phys);
> > --
> > 2.18.0
> > 

