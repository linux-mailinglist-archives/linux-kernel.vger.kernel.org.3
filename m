Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC35335D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiEYD2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiEYD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:28:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FEA7A44F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:28:19 -0700 (PDT)
X-UUID: 01a910ce870243ac929270e8b9848174-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c4016c45-e276-4a22-b8f1-b1a8da546e26,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:56
X-CID-INFO: VERSION:1.1.5,REQID:c4016c45-e276-4a22-b8f1-b1a8da546e26,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:56
X-CID-META: VersionHash:2a19b09,CLOUDID:b7f01fb8-3c45-407b-8f66-25095432a27a,C
        OID:bf78fb8f7416,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 01a910ce870243ac929270e8b9848174-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1293842912; Wed, 25 May 2022 11:28:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 25 May 2022 11:28:12 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 25 May 2022 11:28:10 +0800
From:   <yf.wang@mediatek.com>
To:     <miles.chen@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <Yong.Wu@mediatek.com>,
        <iommu@lists.linux-foundation.org>, <isaacm@codeaurora.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <ning.li@mediatek.com>, <quic_c_gdjako@quicinc.com>,
        <robin.murphy@arm.com>, <sven@svenpeter.dev>, <will@kernel.org>,
        <wsd_upstream@mediatek.com>, <yf.wang@mediatek.com>
Subject: Re: [PATCH v5 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
Date:   Wed, 25 May 2022 11:21:33 +0800
Message-ID: <20220525032133.29053-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220519062756.14447-1-miles.chen@mediatek.com>
References: <20220519062756.14447-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 14:27 +0800, Miles Chen wrote:
> Hi Yunfei,
> 
> > The calling to kmem_cache_alloc for level 2 pgtable allocation may
> > run
> > in atomic context, and it fails sometimes when DMA32 zone runs out
> > of
> > memory.
> > 
> > Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> > so add a quirk to allow the PA of pgtables support up to bit35.
> > 
> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 56 ++++++++++++++++++++++--
> > ------
> >  include/linux/io-pgtable.h         | 15 +++++---
> >  2 files changed, 52 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-
> > pgtable-arm-v7s.c
> 
> ...snip...
> 
> > +     gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
> >       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >       struct device *dev = cfg->iommu_dev;
> >       phys_addr_t phys;
> > @@ -241,9 +251,11 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >       size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
> >       void *table = NULL;
> > 
> > +     if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +             gfp_l1 = __GFP_ZERO;
> 
> __GFP_ZERO is an action modifier, if we do not want
> ARM_V7S_TABLE_GFP_DMA (GFP_DMA/GFP_DMA32), use gfp_l1 = (GFP_KERNEL |
> __GFP_ZERO)
> 

Hi Miles,
Thanks for the suggestion, we will update it in the next version.

Thanks,
Yunfei.

> > +
> >       if (lvl == 1)
> > -             table = (void *)__get_free_pages(
> > -                     __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA,
> > get_order(size));
> > +             table = (void *)__get_free_pages(gfp_l1,
> > get_order(size));
> >       else if (lvl == 2)
> >               table = kmem_cache_zalloc(data->l2_tables, gfp);
> > 
