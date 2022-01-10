Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9099F4896DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiAJK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:59:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55386 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244353AbiAJK7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:59:47 -0500
X-UUID: 395cc667b0e14575be2c58eb00d5c3b4-20220110
X-UUID: 395cc667b0e14575be2c58eb00d5c3b4-20220110
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1957887219; Mon, 10 Jan 2022 18:59:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 10 Jan 2022 18:59:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 18:59:42 +0800
Message-ID: <83400d36640fc6256972041c882d080ce9aa5fdd.camel@mediatek.com>
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
        <anan.sun@mediatek.com>, <yen-chang.chen@mediatek.com>
Date:   Mon, 10 Jan 2022 18:59:42 +0800
In-Reply-To: <85987e9a-dfb0-c241-1dde-43c050a78b51@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-10-yong.wu@mediatek.com>
         <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
         <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
         <85987e9a-dfb0-c241-1dde-43c050a78b51@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-10 at 10:16 +0100, AngeloGioacchino Del Regno wrote:
> Il 09/01/22 03:48, Yong Wu ha scritto:
> > On Tue, 2022-01-04 at 16:55 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 23/09/21 13:58, Yong Wu ha scritto:
> > > > The tlb_sync_all is called from these three functions:
> > > > a) flush_iotlb_all: it will be called for each a iommu HW.
> > > > b) tlb_flush_range_sync: it already has for_each_m4u.
> > > > c) in irq: When IOMMU HW translation fault, Only need flush
> > > > itself.
> > > > 
> > > > Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >    drivers/iommu/mtk_iommu.c | 18 +++++++-----------
> > > >    1 file changed, 7 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/mtk_iommu.c
> > > > b/drivers/iommu/mtk_iommu.c
> > > > index 6f4f6624e3ac..0b4c30baa864 100644
> > > > --- a/drivers/iommu/mtk_iommu.c
> > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > @@ -206,19 +206,15 @@ static struct mtk_iommu_domain
> > > > *to_mtk_domain(struct iommu_domain *dom)
> > > >    
> > > >    static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data
> > > > *data)
> > > >    {
> > > > -	struct list_head *head = data->hw_list;
> > > > -
> > > > -	for_each_m4u(data, head) {
> > > > -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > > > -			continue;
> > > > +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > > > +		return;
> > > >    
> > > > -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > > > -			       data->base + data->plat_data-
> > > > > inv_sel_reg);
> > > > 
> > > > -		writel_relaxed(F_ALL_INVLD, data->base +
> > > > REG_MMU_INVALIDATE);
> > > > -		wmb(); /* Make sure the tlb flush all done */
> > > > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> > > > +		       data->base + data->plat_data-
> > > > >inv_sel_reg);
> > > > +	writel_relaxed(F_ALL_INVLD, data->base +
> > > > REG_MMU_INVALIDATE);
> > > > +	wmb(); /* Make sure the tlb flush all done */
> > > 
> > > There aren't a lot of writes here - not anymore, since you are no
> > > longer doing
> > > this for_each_m4u()...
> > > ...so, please change writel_relaxed() to writel() calls, allowing
> > > you
> > > to also
> > > remove the write barrier at the end (since in the non relaxed
> > > version, order is already ensured).
> > 
> > In the "writel", the "__iowmb()" runs before "write_relaxed". Then
> > how
> > to guarantee the last register was wrote into the HW. Here the
> > flush
> > all don't have sync(waiting it complete)
> > 
> 
> That's right, I'm sorry for the invalid proposal.
> 
> Though, there's something else to mention here... if writing
> (F_INVLD_EN1 | F_INVLD_EN0) to inv_sel_reg is *required* to happen
> before
> writing F_ALL_INVLD to REG_MMU_INVALIDATE (which I think is exactly
> the
> case here), then, in order to ensure write ordering, you should still
> use
> writel() instead of the relaxed accessor; after which, since (as you
> mentioned)
> there is no sync readback loop, you can keep that wmb() at the end.

The writel_relaxed also makes sure the order. I did try this:


https://patchwork.kernel.org/project/linux-mediatek/patch/1570627143-29441-3-git-send-email-yong.wu@mediatek.com/

> 
> > > 
> > > >    
> > > > -		pm_runtime_put(data->dev);
> > > > -	}
> > > > +	pm_runtime_put(data->dev);
> > > >    }
> > > >    
> > > >    static void mtk_iommu_tlb_flush_range_sync(unsigned long
> > > > iova,
> > > > size_t size,
> > > > 
> 
> 

