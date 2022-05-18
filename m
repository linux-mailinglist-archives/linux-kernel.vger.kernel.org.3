Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779852B0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiERDjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiERDjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:39:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3376AA75
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:39:39 -0700 (PDT)
X-UUID: 6358dcc7e4dd41e68957bd720a839538-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:e7bc5091-a06b-4bbc-97ee-a232cdd72c8d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:e7bc5091-a06b-4bbc-97ee-a232cdd72c8d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:6cba93e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:f28b894eb590,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 6358dcc7e4dd41e68957bd720a839538-20220518
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1139438548; Wed, 18 May 2022 11:39:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 18 May 2022 11:39:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 May 2022 11:39:35 +0800
Message-ID: <1bad78e79feb40a2e1e5b09e70438b15aff379ab.camel@mediatek.com>
Subject: Re: [PATCH v6, 2/4] drm/mediatek: Separate poweron/poweroff from
 enable/disable and define new funcs
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <jitao.shi@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <rex-bc.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 May 2022 11:39:34 +0800
In-Reply-To: <1652337012-9053-3-git-send-email-xinlei.lee@mediatek.com>
References: <1652337012-9053-1-git-send-email-xinlei.lee@mediatek.com>
         <1652337012-9053-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xinlei:

On Thu, 2022-05-12 at 14:30 +0800, xinlei.lee@mediatek.com wrote:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
> In order to match the changes of "Use the drm_panel_bridge API",
> the poweron/poweroff of dsi is extracted from enable/disable and
> defined as new funcs (atomic_pre_enable/atomic_post_disable).
> 
> Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the drm_panel_bridge
> API")
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 53 +++++++++++++++++++---------
> --
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index f880136cec09..d9a6b928dba8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -691,16 +691,6 @@ static void mtk_dsi_poweroff(struct mtk_dsi
> *dsi)
>  	if (--dsi->refcount != 0)
>  		return;
>  
> -	/*
> -	 * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
> -	 * mtk_dsi_stop() should be called after
> mtk_drm_crtc_atomic_disable(),
> -	 * which needs irq for vblank, and mtk_dsi_stop() will disable
> irq.
> -	 * mtk_dsi_start() needs to be called in
> mtk_output_dsi_enable(),
> -	 * after dsi is fully set.
> -	 */
> -	mtk_dsi_stop(dsi);
> -
> -	mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
>  	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_lane0_ulp_mode_enter(dsi);
>  	mtk_dsi_clk_ulp_mode_enter(dsi);
> @@ -715,17 +705,9 @@ static void mtk_dsi_poweroff(struct mtk_dsi
> *dsi)
>  
>  static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
>  {
> -	int ret;
> -
>  	if (dsi->enabled)
>  		return;
>  
> -	ret = mtk_dsi_poweron(dsi);
> -	if (ret < 0) {
> -		DRM_ERROR("failed to power on dsi\n");
> -		return;
> -	}
> -
>  	mtk_dsi_set_mode(dsi);
>  	mtk_dsi_clk_hs_mode(dsi, 1);
>  
> @@ -739,7 +721,16 @@ static void mtk_output_dsi_disable(struct
> mtk_dsi *dsi)
>  	if (!dsi->enabled)
>  		return;
>  
> -	mtk_dsi_poweroff(dsi);
> +	/*
> +	 * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
> +	 * mtk_dsi_stop() should be called after
> mtk_drm_crtc_atomic_disable(),
> +	 * which needs irq for vblank, and mtk_dsi_stop() will disable
> irq.
> +	 * mtk_dsi_start() needs to be called in
> mtk_output_dsi_enable(),
> +	 * after dsi is fully set.
> +	 */
> +	mtk_dsi_stop(dsi);
> +
> +	mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
>  
>  	dsi->enabled = false;
>  }
> @@ -776,13 +767,37 @@ static void mtk_dsi_bridge_atomic_enable(struct
> drm_bridge *bridge,
>  {
>  	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>  
> +	if (dsi->refcount == 0)
> +		return;

This seems not related to pre_enable()/post_disable(). So separate this
to another patch.

Regards,
CK

> +
>  	mtk_output_dsi_enable(dsi);
>  }
>  
> +static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge
> *bridge,
> +					     struct drm_bridge_state
> *old_bridge_state)
> +{
> +	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
> +	int ret;
> +
> +	ret = mtk_dsi_poweron(dsi);
> +	if (ret < 0)
> +		DRM_ERROR("failed to power on dsi\n");
> +}
> +
> +static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge
> *bridge,
> +					       struct drm_bridge_state
> *old_bridge_state)
> +{
> +	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
> +
> +	mtk_dsi_poweroff(dsi);
> +}
> +
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>  	.attach = mtk_dsi_bridge_attach,
>  	.atomic_disable = mtk_dsi_bridge_atomic_disable,
>  	.atomic_enable = mtk_dsi_bridge_atomic_enable,
> +	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
> +	.atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
>  	.mode_set = mtk_dsi_bridge_mode_set,
>  };
>  

