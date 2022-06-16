Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F454DEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359871AbiFPKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376287AbiFPKI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:08:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D35C87B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:08:27 -0700 (PDT)
X-UUID: e955982bf561459ca3abac4e3c4f3206-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:43c09244-0be5-402e-bddc-82ef0c950838,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:ab65be48-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e955982bf561459ca3abac4e3c4f3206-20220616
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1809518143; Thu, 16 Jun 2022 18:08:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 18:08:22 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 18:08:21 +0800
Message-ID: <b2ea919315d0084adb465378e6970dbfa4f0829e.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Thu, 16 Jun 2022 18:08:21 +0800
In-Reply-To: <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
         <20220616054203.11365-3-yong.wu@mediatek.com>
         <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
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

On Thu, 2022-06-16 at 09:59 +0100, Robin Murphy wrote:
> On 2022-06-16 06:42, Yong Wu wrote:
> > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the
> > i+1
> > larb is parsed fail(return -EINVAL), we should of_node_put for the
> > 0..i
> > larbs. In the fail path, one of_node_put matches with
> > of_parse_phandle in
> > it.
> > 
> > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with
> > the MM TYPE")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
> >   1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 3b2489e8a6dd..ab24078938bf 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -1071,12 +1071,12 @@ static int mtk_iommu_mm_dts_parse(struct
> > device *dev, struct component_match **m
> >   
> >   		plarbdev = of_find_device_by_node(larbnode);
> >   		if (!plarbdev) {
> > -			of_node_put(larbnode);
> > -			return -ENODEV;
> > +			ret = -ENODEV;
> > +			goto err_larbnode_put;
> >   		}
> >   		if (!plarbdev->dev.driver) {
> > -			of_node_put(larbnode);
> > -			return -EPROBE_DEFER;
> > +			ret = -EPROBE_DEFER;
> > +			goto err_larbnode_put;
> >   		}
> >   		data->larb_imu[id].dev = &plarbdev->dev;
> >   
> > @@ -1107,9 +1107,20 @@ static int mtk_iommu_mm_dts_parse(struct
> > device *dev, struct component_match **m
> >   			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
> >   	if (!link) {
> >   		dev_err(dev, "Unable to link %s.\n", dev_name(data-
> > >smicomm_dev));
> > -		return -EINVAL;
> > +		ret = -EINVAL;
> > +		goto err_larbnode_put;
> >   	}
> >   	return 0;
> > +
> > +err_larbnode_put:
> > +	while (i--) {
> > +		larbnode = of_parse_phandle(dev->of_node,
> > "mediatek,larbs", i);
> > +		if (larbnode && of_device_is_available(larbnode)) {
> > +			of_node_put(larbnode);
> > +			of_node_put(larbnode);
> > +		}
> 
> This looks a bit awkward - could we not just iterate through 
> data->larb_imu and put dev->of_node for each valid dev?

It should work. Thanks very much.

> 
> Also, of_find_device_by_node() takes a reference on the struct
> device 
> itself, so strictly we should be doing put_device() on those as well
> if we're bailing out.

Thanks for this hint. A new reference for me. I will add it.

> 
> Robin.
> 
> > +	}
> > +	return ret;
> >   }
> >   
> >   static int mtk_iommu_probe(struct platform_device *pdev)

