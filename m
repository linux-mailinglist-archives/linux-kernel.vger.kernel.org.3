Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF949F687
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347666AbiA1JjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:39:14 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37408 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235076AbiA1JjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:39:13 -0500
X-UUID: e9dc301affb34158a208a53be4e13ed2-20220128
X-UUID: e9dc301affb34158a208a53be4e13ed2-20220128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 506976823; Fri, 28 Jan 2022 17:39:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 17:39:08 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 17:39:07 +0800
Message-ID: <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu/mediatek: Add mt8186 iommu support
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        <yen-chang.chen@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Date:   Fri, 28 Jan 2022 17:39:06 +0800
In-Reply-To: <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
         <20220125093244.18230-3-yong.wu@mediatek.com>
         <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno wrote:
> Il 25/01/22 10:32, Yong Wu ha scritto:
> > Add mt8186 iommu supports.
> > 
> > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)

[snip]

> >   static const struct mtk_iommu_plat_data mt8192_data = {
> >   	.m4u_plat       = M4U_MT8192,
> >   	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
> > OUT_ORDER_WR_EN |
> > @@ -1470,6 +1486,7 @@ static const struct of_device_id
> > mtk_iommu_of_ids[] = {
> >   	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
> >   	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> >   	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> > +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
> > &mt8186_data_mm},
> 
> Hello!
> 
> Is there any particular reason why this compatible is not
> "mediatek,mt8186-m4u"?

There is no special reason. In the previous SoC, We only support MM
IOMMU, it was called by "m4u". In the lastest SoC, We have the other
types IOMMU, like for INFRA masters and APU, thus they are called "mm
iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
iommu".

> 
> Thanks,
> Angelo
> 
> >   	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
> >   	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
> > &mt8195_data_infra},
> >   	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
> > &mt8195_data_vdo},
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

