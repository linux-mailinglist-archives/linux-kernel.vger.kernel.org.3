Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9629C4FD992
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391278AbiDLJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357401AbiDLITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:19:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33C222B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:43:41 -0700 (PDT)
X-UUID: cadb30c01bd247c69b4ac5647a7994d9-20220412
X-UUID: cadb30c01bd247c69b4ac5647a7994d9-20220412
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 254130138; Tue, 12 Apr 2022 15:43:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 12 Apr 2022 15:43:34 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 15:43:34 +0800
Message-ID: <3c9140fbba123550b5532f9917dae4ef10ed5611.camel@mediatek.com>
Subject: Re: [PATCH v4, 3/4] drm/mediatek: keep dsi as LP00 before dcs cmds
 transfer
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jitao.shi@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 12 Apr 2022 15:43:34 +0800
In-Reply-To: <7a4e5afb-6947-ed7f-8555-c7402aaa3a29@collabora.com>
References: <1649644308-8455-1-git-send-email-xinlei.lee@mediatek.com>
         <1649644308-8455-4-git-send-email-xinlei.lee@mediatek.com>
         <7a4e5afb-6947-ed7f-8555-c7402aaa3a29@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 11:07 +0200, AngeloGioacchino Del Regno wrote:
> Il 11/04/22 04:31, xinlei.lee@mediatek.com ha scritto:
> > From: Jitao Shi <jitao.shi@mediatek.com>
> > 
> > To comply with the panel sequence, hold the mipi signal to LP00
> > before the dcs cmds transmission,
> > and pull the mipi signal high from LP00 to LP11 until the start of
> > the dcs cmds transmission.
> > The normal panel timing is :
> > (1) pp1800 DC pull up
> > (2) avdd & avee AC pull high
> > (3) lcm_reset pull high -> pull low -> pull high
> > (4) Pull MIPI signal high (LP11) -> initial code -> send video
> > data(HS mode)
> > The power-off sequence is reversed.
> > If dsi is not in cmd mode, then dsi will pull the mipi signal high
> > in the mtk_output_dsi_enable function.
> > 
> > Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the
> > drm_panel_bridge API")
> > 
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > ---
> >   drivers/gpu/drm/mediatek/mtk_dsi.c | 28 +++++++++++++++++++++--
> > -----
> >   1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index cf76c53a1af6..9ad6f08c8bfe 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -203,6 +203,7 @@ struct mtk_dsi {
> >   	struct mtk_phy_timing phy_timing;
> >   	int refcount;
> >   	bool enabled;
> > +	bool lanes_ready;
> >   	u32 irq_data;
> >   	wait_queue_head_t irq_wait_queue;
> >   	const struct mtk_dsi_driver_data *driver_data;
> > @@ -654,13 +655,6 @@ static int mtk_dsi_poweron(struct mtk_dsi
> > *dsi)
> >   	mtk_dsi_config_vdo_timing(dsi);
> >   	mtk_dsi_set_interrupt_enable(dsi);
> >   
> > -	mtk_dsi_rxtx_control(dsi);
> > -	usleep_range(30, 100);
> > -	mtk_dsi_reset_dphy(dsi);
> > -	mtk_dsi_clk_ulp_mode_leave(dsi);
> > -	mtk_dsi_lane0_ulp_mode_leave(dsi);
> > -	mtk_dsi_clk_hs_mode(dsi, 0);
> > -
> >   	return 0;
> >   err_disable_engine_clk:
> >   	clk_disable_unprepare(dsi->engine_clk);
> > @@ -689,6 +683,23 @@ static void mtk_dsi_poweroff(struct mtk_dsi
> > *dsi)
> >   	clk_disable_unprepare(dsi->digital_clk);
> >   
> >   	phy_power_off(dsi->phy);
> > +
> > +	dsi->lanes_ready = false;
> > +}
> > +
> > +static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
> > +{
> > +	if (!dsi->lanes_ready) {
> > +		dsi->lanes_ready = true;
> > +		mtk_dsi_rxtx_control(dsi);
> > +		usleep_range(30, 100);
> > +		mtk_dsi_reset_dphy(dsi);
> > +		mtk_dsi_clk_ulp_mode_leave(dsi);
> > +		mtk_dsi_lane0_ulp_mode_leave(dsi);
> > +		mtk_dsi_clk_hs_mode(dsi, 0);
> > +		msleep(20);
> 
> This is a very long sleep, which wasn't present before this change.
> Please document the reasons why we need this 20ms sleep with a
> comment
> in the code.
> 
> Regards,
> Angelo
> 
> 

Hello Xinlei,

As Angelo mentioned.
I think you should add this in commit message and driver comments.
(Your reply in v3.)
"The 20ms delay in mtk_dsi_lane_ready() is because dsi needs to give
dsi_rx(panel) a reaction time after pulling up the mipi signal."

BRs,
Rex

