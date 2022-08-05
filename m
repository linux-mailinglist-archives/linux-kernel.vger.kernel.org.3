Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A171258A6CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiHEHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiHEHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:11:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3D774CE3;
        Fri,  5 Aug 2022 00:11:05 -0700 (PDT)
X-UUID: edbf0bb746ee424298d601a3ac16ac96-20220805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KItryM5rJCMELCueh9zyNBcyx34Z/KHfpqfgCOXw9Oc=;
        b=eWG4Rbp9aBLk88zV5dwt62PSJ+ylbzgti5IGonvDjRj0uZSTsLRfc3yJ5IqJhZ0i7/dRUMd3xpajvM7lKNv5xZbNgqclMSQkW/O9lUfJZ0TmZ6eFaAJYycpBaf+FokLAbyJnGiTnuSCuR1uf9CWwpTTjn0ftLrjOaFwcaYNsNys=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:40b86431-2295-40ca-af88-5ba7e68b0a8a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:d5abce48-f57f-4088-93dd-066979cdb4e6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: edbf0bb746ee424298d601a3ac16ac96-20220805
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1894121297; Fri, 05 Aug 2022 15:11:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 5 Aug 2022 15:10:59 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 5 Aug 2022 15:10:59 +0800
Message-ID: <9617939ab04741daaf7d1f966bf8dd02fe3a114d.camel@mediatek.com>
Subject: Re: [PATCH v15 07/11] drm/mediatek: Add retry to prevent
 misjudgment for sink devices
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <ck.hu@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 5 Aug 2022 15:10:59 +0800
In-Reply-To: <22cd8a6807385941c55e75b390d31424936ae8c4.camel@mediatek.com>
References: <20220727045035.32225-1-rex-bc.chen@mediatek.com>
         <20220727045035.32225-8-rex-bc.chen@mediatek.com>
         <ce46e9b2-8e34-b6cd-d802-35b3ae66e02d@collabora.com>
         <22cd8a6807385941c55e75b390d31424936ae8c4.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I will drop this modification becaus after we testing current drivers,
the issue described in commit message does not occur.

BRs,
Bo-Chen

On Thu, 2022-07-28 at 17:40 +0800, Rex-BC Chen wrote:
> On Wed, 2022-07-27 at 11:40 +0200, AngeloGioacchino Del Regno wrote:
> > Il 27/07/22 06:50, Bo-Chen Chen ha scritto:
> > > For some DP dungles, we need to train more than onece to confirm
> > > that we
> > > don't misjudge the status of sink device.
> > 
> > Please fix the typos in your commit title and description.
> > title: misjudgment -> misjudgement
> > desc: dungles->dongles; onece->once
> > 
> > > 
> > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >   drivers/gpu/drm/mediatek/mtk_dp.c | 21 ++++++++++++++++++---
> > >   1 file changed, 18 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
> > > b/drivers/gpu/drm/mediatek/mtk_dp.c
> > > index ce817cb59445..80d7d6488105 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> > > @@ -42,6 +42,7 @@
> > >   #define MTK_DP_CHECK_SINK_CAP_TIMEOUT_COUNT 3
> > >   #define MTK_DP_TBC_BUF_READ_START_ADDR 0x08
> > >   #define MTK_DP_TRAIN_DOWNSCALE_RETRY 8
> > > +#define MTK_DP_TRAIN_CLEAR_RETRY 50
> > >   
> > >   struct mtk_dp_train_info {
> > >   	bool tps3;
> > > @@ -1431,11 +1432,25 @@ static int mtk_dp_video_config(struct
> > > mtk_dp *mtk_dp)
> > >   
> > >   static int mtk_dp_training(struct mtk_dp *mtk_dp)
> > >   {
> > > +	short max_retry = MTK_DP_TRAIN_CLEAR_RETRY;
> > >   	int ret;
> > >   
> > > -	ret = mtk_dp_train_start(mtk_dp);
> > > -	if (ret)
> > > -		return ret;
> > > +	/*
> > > +	 * We do retry to confirm that we don't misjudge the sink
> > > status.
> > > +	 * If it is still failed, we can confirm there are some issues
> > > for the
> > > +	 * sink device.
> > > +	 */
> > > +	do {
> > > +		ret = mtk_dp_train_start(mtk_dp);
> > > +		if (!ret)
> > > +			break;
> > > +	} while (--max_retry);
> > > +
> > > +	dev_info(mtk_dp->dev, "dp training clear retry times: %d\n",
> > > +		 MTK_DP_TRAIN_CLEAR_RETRY - max_retry);
> > 
> > dev_dbg() here.
> > 
> > ...after which,
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > 
> 
> Hello Angelo,
> 
> Thanks for your review.
> I will modify these in next version.
> 
> BRs,
> Bo-Chen
> 
> > > +
> > > +	if (!max_retry)
> > > +		return -ETIMEDOUT;
> > >   
> > >   	ret = mtk_dp_video_config(mtk_dp);
> > >   	if (ret)
> > 
> > 
> 
> 

