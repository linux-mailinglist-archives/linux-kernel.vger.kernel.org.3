Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62518550923
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbiFSHaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiFSHaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:30:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A63565CE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:30:11 -0700 (PDT)
X-UUID: 467df242ed2e434197a67fd43fc07c74-20220619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:00889421-7991-4d22-a604-bd46a60722b6,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:50
X-CID-INFO: VERSION:1.1.6,REQID:00889421-7991-4d22-a604-bd46a60722b6,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:50
X-CID-META: VersionHash:b14ad71,CLOUDID:f0070e49-4c92-421c-ad91-b806c0f58b2a,C
        OID:1f6750c707f5,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 467df242ed2e434197a67fd43fc07c74-20220619
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1385577186; Sun, 19 Jun 2022 15:30:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 19 Jun 2022 15:30:03 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 19 Jun 2022 15:30:02 +0800
Message-ID: <fbcafb3c519c4d6a914254d8958633a922267cf6.camel@mediatek.com>
Subject: Re: [PATCH v4] soc: mediatek: Add support always on flag
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Min Guo <min.guo@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Sun, 19 Jun 2022 15:30:02 +0800
In-Reply-To: <eb498209-3d5f-b60a-b596-4d3f46b5f9b1@gmail.com>
References: <20220617095841.23031-1-chunfeng.yun@mediatek.com>
         <eb498209-3d5f-b60a-b596-4d3f46b5f9b1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-17 at 13:52 +0200, Matthias Brugger wrote:
> 
> On 17/06/2022 11:58, Chunfeng Yun wrote:
> > There is a t-phy shared by PCIe and USB3 on mt8195, if the t-phy is
> > used by PCIe, when power off its mtcmos, need software reset it
> > (workaround way, usually hardware do it, but has an issue on
> > mt8195),
> > but it has side effect to USB2 phy(works with USB3 phy to support
> > USB3.2 Gen1), so add support GENPD_FLAG_ALWAYS_ON flag, and make
> > its
> > power always on;
> > Another reason is that USB3.2 Gen1/2 need keep power always on when
> > support runtime-pm due to hardware limitation until now;
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> I changed the subject line to add pm-domains to it. Also Reviewed-by
> tags come 
> under the patch author Signed-off-by tag.
> 
> For the next time, please try to get a better commit message. It's
> difficult to 
> understand when reading the first time.
Got it, thanks a lot

> 
> Applied, thanks!
> 
> > ---
> > v4: add reviewed-by AngeloGioacchino
> > 
> > v3: make always-on flag exclusive with defualt-off flag
> > 
> > v2: keep active_wakeup flag for mt8195
> > ---
> >   drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
> >   drivers/soc/mediatek/mtk-pm-domains.c    | 3 +++
> >   drivers/soc/mediatek/mtk-pm-domains.h    | 2 ++
> >   3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h
> > b/drivers/soc/mediatek/mt8195-pm-domains.h
> > index 938f4d51f5ae..0529d130b675 100644
> > --- a/drivers/soc/mediatek/mt8195-pm-domains.h
> > +++ b/drivers/soc/mediatek/mt8195-pm-domains.h
> > @@ -67,7 +67,7 @@ static const struct scpsys_domain_data
> > scpsys_domain_data_mt8195[] = {
> >   		.ctl_offs = 0x334,
> >   		.pwr_sta_offs = 0x174,
> >   		.pwr_sta2nd_offs = 0x178,
> > -		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> > +		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_ALWAYS_ON,
> >   	},
> >   	[MT8195_POWER_DOMAIN_CSI_RX_TOP] = {
> >   		.name = "csi_rx_top",
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.c
> > b/drivers/soc/mediatek/mtk-pm-domains.c
> > index 5ced254b082b..a3dae391a38a 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.c
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> > @@ -428,6 +428,9 @@ generic_pm_domain *scpsys_add_one_domain(struct
> > scpsys *scpsys, struct device_no
> >   			dev_err(scpsys->dev, "%pOF: failed to power on
> > domain: %d\n", node, ret);
> >   			goto err_put_subsys_clocks;
> >   		}
> > +
> > +		if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
> > +			pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
> >   	}
> >   
> >   	if (scpsys->domains[id]) {
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
> > b/drivers/soc/mediatek/mtk-pm-domains.h
> > index daa24e890dd4..7d3c0c36316c 100644
> > --- a/drivers/soc/mediatek/mtk-pm-domains.h
> > +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> > @@ -8,6 +8,8 @@
> >   #define MTK_SCPD_SRAM_ISO		BIT(2)
> >   #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
> >   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
> > +/* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
> > +#define MTK_SCPD_ALWAYS_ON		BIT(5)
> >   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
> >   
> >   #define SPM_VDE_PWR_CON			0x0210

