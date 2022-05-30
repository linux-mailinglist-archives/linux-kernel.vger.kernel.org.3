Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA664537391
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiE3C1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiE3C1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:27:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EBDF8A
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 19:27:15 -0700 (PDT)
X-UUID: a82fa2f341ab42669dca4aad750b12ac-20220530
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:952290ef-46a6-4d98-92b1-d73fe5bc5953,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:6817b2b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: a82fa2f341ab42669dca4aad750b12ac-20220530
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1959788512; Mon, 30 May 2022 10:27:12 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 30 May 2022 10:27:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 May 2022 10:27:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 30 May 2022 10:27:10 +0800
Message-ID: <05cfaf936a0c5f37f2e7ba779a8a1b0a6252be96.camel@mediatek.com>
Subject: Re: [PATCH] mm: kmemleak: Skip check in kmemleak_*_phys when pfn
 bound is not ready
From:   Yee Lee <yee.lee@mediatek.com>
To:     patrick wang <patrick.wang.shcn@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <Kuan-Ying.lee@mediatek.com>,
        <Andrew.Yang@mediatek.com>, <Sunny.Kao@mediatek.com>,
        <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 30 May 2022 10:27:10 +0800
In-Reply-To: <CAGcnep9B+z8QG4f4kkW8NF+fM1Kgj=NOV=YRhLK4yK74jbqpAw@mail.gmail.com>
References: <20220527032504.30341-1-yee.lee@mediatek.com>
         <CAGcnep9B+z8QG4f4kkW8NF+fM1Kgj=NOV=YRhLK4yK74jbqpAw@mail.gmail.com>
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

On Fri, 2022-05-27 at 21:39 +0800, patrick wang wrote:
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
> 
> Just skip checking will bring the crash possibility back. Seems it's
> beyond
> these interfaces' handle scope for this situation, since
> "min_low_pfn" and
> "max_low_pfn" are depending on arches.
> 
Yes, for the cases beyond the pfn guard, users have to take care the
boundary by themselves. 

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

