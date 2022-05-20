Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C50D52E2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiETDQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiETDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:16:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E75A585
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:16:46 -0700 (PDT)
X-UUID: 47cab836a08545368238e1f151768730-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:e9a855ad-0a6d-421f-a7e9-6ec088449316,OB:0,LO
        B:20,IP:0,URL:5,TC:0,Content:14,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:64
X-CID-INFO: VERSION:1.1.5,REQID:e9a855ad-0a6d-421f-a7e9-6ec088449316,OB:0,LOB:
        20,IP:0,URL:5,TC:0,Content:14,EDM:0,RT:0,SF:45,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:64
X-CID-META: VersionHash:2a19b09,CLOUDID:04d0f179-5ef6-470b-96c9-bdb8ced32786,C
        OID:f8a408ea6a3f,Recheck:0,SF:28|17|19|48,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 47cab836a08545368238e1f151768730-20220520
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1735188894; Fri, 20 May 2022 11:16:42 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 11:16:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 11:16:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 11:16:40 +0800
Message-ID: <a65669e0f66bc61490abcaa733a85cecd40200ce.camel@mediatek.com>
Subject: Re: [PATCH v7,1/4] drm/mediatek: Modify dsi funcs to atomic
 operations
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>
Date:   Fri, 20 May 2022 11:16:40 +0800
In-Reply-To: <1653012007-11854-2-git-send-email-xinlei.lee@mediatek.com>
References: <1653012007-11854-1-git-send-email-xinlei.lee@mediatek.com>
         <1653012007-11854-2-git-send-email-xinlei.lee@mediatek.com>
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

On Fri, 2022-05-20 at 10:00 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Because .enable & .disable are deprecated.
> Use .atomic_enable & .atomic_disable instead.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index bd3f5b485085..f880136cec09 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -763,14 +763,16 @@ static void mtk_dsi_bridge_mode_set(struct
> drm_bridge *bridge,
>  	drm_display_mode_to_videomode(adjusted, &dsi->vm);
>  }
>  
> -static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
> +static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					  struct drm_bridge_state
> *old_bridge_state)
>  {
>  	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>  
>  	mtk_output_dsi_disable(dsi);
>  }
>  
> -static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
> +static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_bridge_state
> *old_bridge_state)
>  {
>  	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>  
> @@ -779,8 +781,8 @@ static void mtk_dsi_bridge_enable(struct
> drm_bridge *bridge)
>  
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>  	.attach = mtk_dsi_bridge_attach,
> -	.disable = mtk_dsi_bridge_disable,
> -	.enable = mtk_dsi_bridge_enable,
> +	.atomic_disable = mtk_dsi_bridge_atomic_disable,
> +	.atomic_enable = mtk_dsi_bridge_atomic_enable,
>  	.mode_set = mtk_dsi_bridge_mode_set,
>  };
>  

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

