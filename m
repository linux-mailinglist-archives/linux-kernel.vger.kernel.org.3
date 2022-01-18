Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42E4916A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 03:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbiARCfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 21:35:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:42298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344205AbiARC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:29:21 -0500
X-UUID: 55fead7361b54f23ab6d7eada7852afd-20220118
X-UUID: 55fead7361b54f23ab6d7eada7852afd-20220118
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1671992361; Tue, 18 Jan 2022 10:29:17 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 18 Jan 2022 10:29:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Jan 2022 10:29:15 +0800
Message-ID: <1bd816c2f26cd8e42debf066a57e24eb5e2f580d.camel@mediatek.com>
Subject: Re: [v9,2/3] drm/mediatek: implement the DSI hs packets aligned
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Date:   Tue, 18 Jan 2022 10:29:15 +0800
In-Reply-To: <86b76e9f-96b0-7d54-bd38-449745e30aa2@intel.com>
References: <20220114092110.12137-1-rex-bc.chen@mediatek.com>
         <20220114092110.12137-3-rex-bc.chen@mediatek.com>
         <4076cb55-4546-6bbd-1a1f-19395dcd9ccd@collabora.com>
         <f858dd4aaa35fa3eb969baf887f038c3593232e5.camel@mediatek.com>
         <86b76e9f-96b0-7d54-bd38-449745e30aa2@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrzej,

Thanks for your review.
I will give the explanation for this in next version.

BRs,
Rex-BC hen

On Fri, 2022-01-14 at 12:11 +0100, Andrzej Hajda wrote:
> On 14.01.2022 11:20, Rex-BC Chen wrote:
> > Hello AngeloGioacchino,
> > 
> > Thanks for your review.
> > I will modify this in next version.
> > 
> > BRs,
> > Rex-BC Chen
> > 
> > On Fri, 2022-01-14 at 10:36 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 14/01/22 10:21, Rex-BC Chen ha scritto:
> > > > Some DSI RX devices require the packets on all lanes aligned at
> > > > the
> > > > end.
> > > > Otherwise, there will be some issues of shift or scroll for
> > > > screen.
> > > > 
> > > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > 
> > > Hello,
> > > thanks for the patch! However, there's something to improve...
> > > 
> > > > ---
> > > >    drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
> > > >    1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > index 5d90d2eb0019..ccdda15f5a66 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > > > @@ -195,6 +195,8 @@ struct mtk_dsi {
> > > >    	struct clk *hs_clk;
> > > >    
> > > >    	u32 data_rate;
> > > > +	/* force dsi line end without dsi_null data */
> > > > +	bool hs_packet_end_aligned;
> > > 
> > > There's no need to introduce a new variable here...
> > > >    
> > > >    	unsigned long mode_flags;
> > > >    	enum mipi_dsi_pixel_format format;
> > > > @@ -500,6 +502,13 @@ static void
> > > > mtk_dsi_config_vdo_timing(struct
> > > > mtk_dsi *dsi)
> > > >    		DRM_WARN("HFP + HBP less than d-phy, FPS will
> > > > under
> > > > 60Hz\n");
> > > >    	}
> > > >    
> > > > +	if (dsi->hs_packet_end_aligned) {
> > > 
> > > You can simply check mode_flags here:
> > > 	if (dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) {
> > > 
> > > > +		horizontal_sync_active_byte =
> > > > roundup(horizontal_sync_active_byte, dsi->lanes) - 2;
> > > > +		horizontal_frontporch_byte =
> > > > roundup(horizontal_frontporch_byte, dsi->lanes) - 2;
> > > > +		horizontal_backporch_byte =
> > > > roundup(horizontal_backporch_byte, dsi->lanes) - 2;
> > > > +		horizontal_backporch_byte -= (vm->hactive *
> > > > dsi_tmp_buf_bpp + 2) % dsi->lanes;
> > > > +	}
> > > > +
> 
> 
> And if you could add comment explaining the magic here it would be
> nice.
> 
> 
> Regards
> 
> Andrzej
> 
> 
> > > >    	writel(horizontal_sync_active_byte, dsi->regs +
> > > > DSI_HSA_WC);
> > > >    	writel(horizontal_backporch_byte, dsi->regs +
> > > > DSI_HBP_WC);
> > > >    	writel(horizontal_frontporch_byte, dsi->regs +
> > > > DSI_HFP_WC);
> > > > @@ -794,6 +803,9 @@ static int mtk_dsi_host_attach(struct
> > > > mipi_dsi_host *host,
> > > >    	dsi->lanes = device->lanes;
> > > >    	dsi->format = device->format;
> > > >    	dsi->mode_flags = device->mode_flags;
> > > > +	dsi->hs_packet_end_aligned = (dsi->mode_flags &
> > > > +				      MIPI_DSI_HS_PKT_END_ALIGN
> > > > ED)
> > > > +				     ? true : false;
> > > 
> > > ...so there's no need for this one, either.
> > > 
> > > >    
> > > >    	return 0;
> > > >    }
> > > > 
> > > 
> > > Regards,
> > > - Angelo
> > > 

