Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0F48D239
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiAMGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:06:07 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:38242 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231205AbiAMGGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:06:06 -0500
X-UUID: ccfd07641bb4491a9d856d3e5b2f3b67-20220113
X-UUID: ccfd07641bb4491a9d856d3e5b2f3b67-20220113
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1129358751; Thu, 13 Jan 2022 14:06:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 14:06:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 14:05:59 +0800
Message-ID: <18d7e049adc69f4b7f0ecfdf8520a02bd6e17149.camel@mediatek.com>
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <lc.kan@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Thu, 13 Jan 2022 14:05:59 +0800
In-Reply-To: <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
         <20220111063904.7583-5-yong.wu@mediatek.com>
         <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-11 at 10:10 +0100, AngeloGioacchino Del Regno wrote:
> Il 11/01/22 07:39, Yong Wu ha scritto:
> > The successful return value for clk_bulk_prepare_enable is 0,
> > rather than
> > "< 0". Fix this.
> > 
> 
> Hello! Thanks for this commit!
> However, there are a few comments...
> 
> This description is a bit confusing, please reword it, something
> like...
> 
> "Function clk_bulk_prepare_enable() returns 0 for success or a
> negative
> number for error. Fix this code style issue."

Thanks for your quickly reviewing.

I will use this in next version and remove the "Fixes" tag.

> 
> In any case, you're not fixing any bad logic issue here, as the
> function
> will never return anything > 0.
> 
> What you're fixing is a common pattern usage issue, so the Fixes tag
> can be
> removed since it's not really useful to schedule this commit for
> backport
> over older stable versions.
> 
> 
> After the requested changes:
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 
> > Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/memory/mtk-smi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index b883dcc0bbfa..e7b1a22b12ea 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -480,7 +480,7 @@ static int __maybe_unused
> > mtk_smi_larb_resume(struct device *dev)
> >   	int ret;
> >   
> >   	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb-
> > >smi.clks);
> > -	if (ret < 0)
> > +	if (ret)
> >   		return ret;
> >   
> >   	/* Configure the basic setting for this larb */
> > 
> 
> 

