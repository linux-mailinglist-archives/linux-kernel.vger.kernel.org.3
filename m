Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76A54DC61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359578AbiFPH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359454AbiFPH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:59:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D25D661
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:59:47 -0700 (PDT)
X-UUID: 6dadf92a336c44c6a8c71b01b263b41d-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:4ed39cf7-ba7c-4993-affd-a02a0d8b52b3,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:6e7775f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 6dadf92a336c44c6a8c71b01b263b41d-20220616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1466956298; Thu, 16 Jun 2022 15:59:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 15:59:38 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 16 Jun 2022 15:59:36 +0800
From:   <yf.wang@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <Libo.Kang@mediatek.com>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <will@kernel.org>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>, <yong.wu@mediatek.com>
Subject: Re: [PATCH v9 3/3] iommu/mediatek: Allow page table PA up to 35bit
Date:   Thu, 16 Jun 2022 15:52:46 +0800
Message-ID: <20220616075246.11076-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <81b55048-a6f1-660f-95b0-6798aa4efc38@arm.com>
References: <81b55048-a6f1-660f-95b0-6798aa4efc38@arm.com>
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

On Wed, 2022-06-15 at 18:25 +0100, Robin Murphy wrote:
> On 2022-06-15 17:12, yf.wang--- via iommu wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So
> > add
> > the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and
> > level 2
> > pgtable support at most 35bit PA.
> 
> I'm not sure how this works in practice, given that you don't seem to
> be 
> setting the IOMMU's own DMA masks to more than 32 bits, so the DMA 
> mapping in io-pgtable is going to fail if you ever do actually
> allocate 
> a pagetable page above 4GB :/
> 

Hi Robin,
About DMA masks, the master device has set dma mask, when iommu do dma map,
it will check the dam_mask of the master dev to determine which range the
address of the iova alloc is in.

Add the quirk ARM_MTK_TTBR_EXT to let pgtable support larger phys memory.
Do actually test work fine, example:
pgtable phys address:0x12054006a, encoded to 32 bits ttbr:0x20540001


> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 3d62399e8865..4dbc33758711 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -138,6 +138,7 @@
> >   /* PM and clock always on. e.g. infra iommu */
> >   #define PM_CLK_AO			BIT(15)
> >   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> > +#define PGTABLE_PA_35_EN		BIT(17)
> >   
> >   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
> >   				((((pdata)->flags) & (mask)) == (_x))
> > @@ -240,6 +241,7 @@ struct mtk_iommu_data {
> >   struct mtk_iommu_domain {
> >   	struct io_pgtable_cfg		cfg;
> >   	struct io_pgtable_ops		*iop;
> > +	u32				ttbr;
> >   
> >   	struct mtk_iommu_bank_data	*bank;
> >   	struct iommu_domain		domain;
> > @@ -596,6 +598,9 @@ static int mtk_iommu_domain_finalise(struct
> > mtk_iommu_domain *dom,
> >   		.iommu_dev = data->dev,
> >   	};
> >   
> > +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
> > +		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
> > +
> >   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
> >   		dom->cfg.oas = data->enable_4GB ? 33 : 32;
> >   	else
> > @@ -684,8 +689,8 @@ static int mtk_iommu_attach_device(struct
> > iommu_domain *domain,
> >   			goto err_unlock;
> >   		}
> >   		bank->m4u_dom = dom;
> > -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> > -		       bank->base + REG_MMU_PT_BASE_ADDR);
> > +		bank->m4u_dom->ttbr = MTK_IOMMU_ADDR(dom-
> > >cfg.arm_v7s_cfg.ttbr);
> > +		writel(bank->m4u_dom->ttbr, data->base +
> > REG_MMU_PT_BASE_ADDR);
> 
> To add to my comment on patch #1, having to make this change here 
> further indicates that you're using it the wrong way.
> 
> Thanks,
> Robin.
> 

Hi Robin,
According to your Path#1's suggestion, next version will keep ttbr to encoded 32 bits,
then will don't need to modify it.

Thanks,
Yunfei.
