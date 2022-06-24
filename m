Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90455953C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiFXIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiFXIUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:20:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3A6F492
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:20:27 -0700 (PDT)
X-UUID: 753c42cefd3c4672b525df6e5332f283-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:bc71351e-462f-4ee6-be3e-29355e27aa92,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.6,REQID:bc71351e-462f-4ee6-be3e-29355e27aa92,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:b14ad71,CLOUDID:562678d8-850a-491d-a127-60d9309b2b3e,C
        OID:810ffcbf3856,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 753c42cefd3c4672b525df6e5332f283-20220624
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 709302985; Fri, 24 Jun 2022 16:20:21 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 16:20:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jun 2022 16:20:20 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 24 Jun 2022 16:20:20 +0800
Message-ID: <bdfd039fbde06113071f773ae6d5635ff4664e2c.camel@mediatek.com>
Subject: Re: [PATCH 1/1] mm: kfence: skip kmemleak alloc in kfence_pool
From:   Yee Lee <yee.lee@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     <linux-kernel@vger.kernel.org>,
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
Date:   Fri, 24 Jun 2022 16:20:20 +0800
In-Reply-To: <CANpmjNN-jsZoVmJWD2Dz6O3_YVjy0av6e0iD-+OYXpik1LbLvg@mail.gmail.com>
References: <20220623111937.6491-1-yee.lee@mediatek.com>
         <20220623111937.6491-2-yee.lee@mediatek.com>
         <CANpmjNN-jsZoVmJWD2Dz6O3_YVjy0av6e0iD-+OYXpik1LbLvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-23 at 13:59 +0200, Marco Elver wrote:
> On Thu, 23 Jun 2022 at 13:20, yee.lee via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > 
> > From: Yee Lee <yee.lee@mediatek.com>
> > 
> > Use MEMBLOCK_ALLOC_NOLEAKTRACE to skip kmemleak registration when
> > the kfence pool is allocated from memblock. And the kmemleak_free
> > later can be removed too.
> 
> Is this purely meant to be a cleanup and non-functional change?
> 
> > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > 
> > ---
> >  mm/kfence/core.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 4e7cd4c8e687..0d33d83f5244 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -600,14 +600,6 @@ static unsigned long kfence_init_pool(void)
> >                 addr += 2 * PAGE_SIZE;
> >         }
> > 
> > -       /*
> > -        * The pool is live and will never be deallocated from this
> > point on.
> > -        * Remove the pool object from the kmemleak object tree, as
> > it would
> > -        * otherwise overlap with allocations returned by
> > kfence_alloc(), which
> > -        * are registered with kmemleak through the slab post-alloc 
> > hook.
> > -        */
> > -       kmemleak_free(__kfence_pool);
> 
> This appears to only be a non-functional change if the pool is
> allocated early. If the pool is allocated late using page-alloc, then
> there'll not be a kmemleak_free() on that memory and we'll have the
> same problem.

Do you mean the kzalloc(slab_is_available) in memblock_allc()? That
implies that MEMBLOCK_ALLOC_NOLEAKTRACE has no guarantee skipping
kmemleak_alloc from this. (Maybe add it?)

If so, we cannot identify later the block is stored in the phys
tree(memblock) or the virt tree(page_alloc).


