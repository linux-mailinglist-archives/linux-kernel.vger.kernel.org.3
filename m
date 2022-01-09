Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59AC488780
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 03:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiAICsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 21:48:33 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56190 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233718AbiAICsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 21:48:32 -0500
X-UUID: aa644fda6f2f4c9294059b61c4946042-20220109
X-UUID: aa644fda6f2f4c9294059b61c4946042-20220109
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 862979138; Sun, 09 Jan 2022 10:48:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 9 Jan 2022 10:48:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:48:27 +0800
Message-ID: <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <yen-chang.chen@mediatek.com>
Date:   Sun, 9 Jan 2022 10:48:27 +0800
In-Reply-To: <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-10-yong.wu@mediatek.com>
         <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 16:55 +0100, AngeloGioacchino Del Regno wrote:
> Il 23/09/21 13:58, Yong Wu ha scritto:
> > The tlb_sync_all is called from these three functions:
> > a) flush_iotlb_all: it will be called for each a iommu HW.
> > b) tlb_flush_range_sync: it already has for_each_m4u.
> > c) in irq: When IOMMU HW translation fault, Only need flush itself.
> > 
> > Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 18 +++++++-----------
> >   1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6f4f6624e3ac..0b4c30baa864 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -206,19 +206,15 @@ static struct mtk_iommu_domain
> > *to_mtk_domain(struct iommu_domain *dom)
> >   
> >   static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> >   {
> > -	struct list_head *head = data->hw_list;
> > -
> > -	for_each_m4u(data, head) {
> > -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > -			continue;
> > +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > +		return;
> >   
> > -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > -			       data->base + data->plat_data-
> > >inv_sel_reg);
> > -		writel_relaxed(F_ALL_INVLD, data->base +
> > REG_MMU_INVALIDATE);
> > -		wmb(); /* Make sure the tlb flush all done */
> > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > +		       data->base + data->plat_data->inv_sel_reg);
> > +	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> > +	wmb(); /* Make sure the tlb flush all done */
> 
> There aren't a lot of writes here - not anymore, since you are no
> longer doing
> this for_each_m4u()...
> ...so, please change writel_relaxed() to writel() calls, allowing you
> to also
> remove the write barrier at the end (since in the non relaxed
> version, order is already ensured).

In the "writel", the "__iowmb()" runs before "write_relaxed". Then how
to guarantee the last register was wrote into the HW. Here the flush
all don't have sync(waiting it complete)

> 
> >   
> > -		pm_runtime_put(data->dev);
> > -	}
> > +	pm_runtime_put(data->dev);
> >   }
> >   
> >   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova,
> > size_t size,
> > 

