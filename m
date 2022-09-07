Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC75AFA68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIGDIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIGDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:08:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E9589808
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:08:18 -0700 (PDT)
X-UUID: e165945259534340ba26ebc6a7892780-20220907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VkcihY9ABi04XqXVV22kyb/oL68WO+uzwQnvKJrjdU8=;
        b=ibO1SJX8+yDFWg5f9V+JoYcmF8wLZyzTrHDL/tJHxJXvjF9QfxS/vTB1u6CPWB+IjaiHHu8/FzNg401qIYlhYHvk31ilPYKWX75kpCmm33oQZCzVua9bpsvgOHvnSxk17EWbvSJpItVTl/qC7w8xFN0otgL2Kk2GADiGGlCGAJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:ecebd88c-f886-4732-83e0-61300462c671,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:ecebd88c-f886-4732-83e0-61300462c671,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:00ee6e21-1c20-48a5-82a0-25f9c331906d,C
        OID:8f337ed2212a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e165945259534340ba26ebc6a7892780-20220907
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1942156582; Wed, 07 Sep 2022 11:08:10 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Sep 2022 11:08:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 7 Sep 2022 11:08:06 +0800
Message-ID: <c5eca9b0154adf5a201ab89f3a9fa120b4519d25.camel@mediatek.com>
Subject: Re: [PATCH v4 3/6] iommu/mediatek: Add error path for loop of
 mm_dts_parse
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed, 7 Sep 2022 11:08:05 +0800
In-Reply-To: <f0cc5ea8-9fd8-dc77-e595-33973e315d28@collabora.com>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
         <20220824064306.21495-4-yong.wu@mediatek.com>
         <f0cc5ea8-9fd8-dc77-e595-33973e315d28@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-30 at 10:14 +0200, AngeloGioacchino Del Regno wrote:
> Il 24/08/22 08:43, Yong Wu ha scritto:
> > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the
> > i+1
> > larb is parsed fail, we should put_device for the 0..i larbs.
> > 
> > There are two places need to comment:
> > 1) The larbid may be not linear mapping, we should loop whole
> >     the array in the error path.
> > 2) I move this line position: "data->larb_imu[id].dev = &plarbdev-
> > >dev;"
> >     That means set data->larb_imu[id].dev before the error path.
> >     then we don't need "platform_device_put(plarbdev)" again while
> >     probe_defer case. All depend on "put_device" in the error path
> > in error
> >     cases.
> > 
> > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with
> > the MM TYPE")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++++++++++----
> > -------
> >   1 file changed, 30 insertions(+), 12 deletions(-)

[...]

> > +
> > +err_larbdev_put:
> > +	/* id may be not linear mapping, loop whole the array */
> > +	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> 
> Since there may be a case in which the mapping is linear and we're
> doing teardown,
> I think it would be sensible to loop the other way around instead,
> from
> MTK_LARB_NR_MAX to 0.

Thanks very much. I will change from MTK_LARB_NR_MAX to 0.

> 
> Everything else looks good to me.
> 
> Cheers,
> Angelo
> 
> > +		if (!data->larb_imu[i].dev)
> > +			continue;
> > +		put_device(data->larb_imu[i].dev);
> > +	}
> > +	return ret;
> >   }
> >   
> >   static int mtk_iommu_probe(struct platform_device *pdev)
> 
> 

