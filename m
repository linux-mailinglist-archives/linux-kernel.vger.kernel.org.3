Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59E5AA8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiIBHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:32:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE7A0631;
        Fri,  2 Sep 2022 00:32:22 -0700 (PDT)
X-UUID: 37ba8d69d9544fff83dab4228e52ad2b-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qM1qgq1MV7finP/aae8s5yQZ0OBqyz3rZqiMvkPhvrk=;
        b=G4r3C5h5cHvAVDcRRHHgoPLBhlLRM0Vb4tnJrd/KpEQwrnDgIiM/5pzW4RcEgdoVbJkT3ez4P0ZcOB1hjX2oWRZwlO7/ExPeWm61Y+LPFtIefh41VHAXhpbR7+pWlaAIv0U7NP7YhRZpMaI9OJfwSgs7cRi72eukcsdlrujD/ro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:6c390545-a2b1-498b-ada8-8ac6fa5c2923,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:81f5ec20-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 37ba8d69d9544fff83dab4228e52ad2b-20220902
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1567408428; Fri, 02 Sep 2022 15:32:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 2 Sep 2022 15:32:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 2 Sep 2022 15:32:14 +0800
Message-ID: <8ae888c3f478112bca0ae40543de878f829f2470.camel@mediatek.com>
Subject: Re: [PATCH v17 05/10] drm/mediatek: dp: Add multiple smc commands
 support
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <matthias.bgg@gmail.com>, <deller@gmx.de>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <liangxu.xu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fbdev@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 2 Sep 2022 15:32:14 +0800
In-Reply-To: <20220901044149.16782-6-rex-bc.chen@mediatek.com>
References: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
         <20220901044149.16782-6-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Thu, 2022-09-01 at 12:41 +0800, Bo-Chen Chen wrote:
> The smc commands of eDP and DP are different. We add smc_cmd to the
> device data to define them.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
> b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 2696c1ac1a47..971bd744cdb2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -112,6 +112,7 @@ struct mtk_dp {
>  
>  struct mtk_dp_data {
>  	int bridge_type;
> +	unsigned int smc_cmd;
>  };
>  static const struct mtk_dp_efuse_fmt
> mtk_dp_efuse_data[MTK_DP_CAL_MAX] = {
>  	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
> @@ -945,11 +946,11 @@ static void mtk_dp_video_mute(struct mtk_dp
> *mtk_dp, bool enable)
>  			   VIDEO_MUTE_SW_DP_ENC0_P0);
>  
>  	arm_smccc_smc(MTK_DP_SIP_CONTROL_AARCH32,
> -		      MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE, enable,
> +		      mtk_dp->data->smc_cmd, enable,
>  		      0, 0, 0, 0, 0, &res);
>  
>  	dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: 0x%x, ret: 0x%lx-
> 0x%lx\n",
> -		MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE, enable, res.a0,
> res.a1);
> +		mtk_dp->data->smc_cmd, enable, res.a0, res.a1);
>  }
>  
>  static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
> @@ -1981,6 +1982,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops,
> mtk_dp_suspend, mtk_dp_resume);
>  
>  static const struct mtk_dp_data mt8195_edp_data = {
>  	.bridge_type = DRM_MODE_CONNECTOR_eDP,
> +	.smc_cmd = MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE,
>  };
>  
>  static const struct of_device_id mtk_dp_of_match[] = {

