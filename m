Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093354BB042
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiBRDdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:33:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiBRDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:33:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E1D36687;
        Thu, 17 Feb 2022 19:32:49 -0800 (PST)
X-UUID: 04b7a3d5f3864f7abe527469b579c0fb-20220218
X-UUID: 04b7a3d5f3864f7abe527469b579c0fb-20220218
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1242618571; Fri, 18 Feb 2022 11:32:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Feb 2022 11:32:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 11:32:43 +0800
Message-ID: <8b63983222a4a304586a7b880379fcf4a7036c4a.camel@mediatek.com>
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
Date:   Fri, 18 Feb 2022 11:32:43 +0800
In-Reply-To: <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
         <20220125093244.18230-3-yong.wu@mediatek.com>
         <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
         <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
         <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-31 at 10:25 +0100, AngeloGioacchino Del Regno wrote:
> Il 28/01/22 10:39, Yong Wu ha scritto:
> > On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 25/01/22 10:32, Yong Wu ha scritto:
> > > > Add mt8186 iommu supports.
> > > > 
> > > > Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >    drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
> > > >    1 file changed, 17 insertions(+)
> > 
> > [snip]
> > 
> > > >    static const struct mtk_iommu_plat_data mt8192_data = {
> > > >    	.m4u_plat       = M4U_MT8192,
> > > >    	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
> > > > OUT_ORDER_WR_EN |
> > > > @@ -1470,6 +1486,7 @@ static const struct of_device_id
> > > > mtk_iommu_of_ids[] = {
> > > >    	{ .compatible = "mediatek,mt8167-m4u", .data =
> > > > &mt8167_data},
> > > >    	{ .compatible = "mediatek,mt8173-m4u", .data =
> > > > &mt8173_data},
> > > >    	{ .compatible = "mediatek,mt8183-m4u", .data =
> > > > &mt8183_data},
> > > > +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
> > > > &mt8186_data_mm},
> > > 
> > > Hello!
> > > 
> > > Is there any particular reason why this compatible is not
> > > "mediatek,mt8186-m4u"?
> > 
> > There is no special reason. In the previous SoC, We only support MM
> > IOMMU, it was called by "m4u". In the lastest SoC, We have the
> > other
> > types IOMMU, like for INFRA masters and APU, thus they are called
> > "mm
> > iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
> > iommu".
> > 
> 
> I suggest, at this point, to change it to "mediatek,mt8186-m4u" for
> naming
> consistency with the other bindings and to avoid any kind of
> confusion.

Understand. But we don't call it "m4u" anymore. I'd not like to use a
outdated name. For readable, I could add a comment like this:

{ .compatible = "mediatek,mt8186-iommu-mm", xx}, /* iommu-mm: m4u */

Is this ok for you?
Thanks.

> Thank you!
> 
> > > 
> > > Thanks,
> > > Angelo
> > > 
> > > >    	{ .compatible = "mediatek,mt8192-m4u", .data =
> > > > &mt8192_data},
> > > >    	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
> > > > &mt8195_data_infra},
> > > >    	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
> > > > &mt8195_data_vdo},
> > > 
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 

