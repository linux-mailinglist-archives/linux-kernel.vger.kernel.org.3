Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC404B7CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbiBPB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbiBPB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:56:28 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656BFABD7;
        Tue, 15 Feb 2022 17:56:16 -0800 (PST)
X-UUID: 3078d079a04c464ea31133e843022fb0-20220216
X-UUID: 3078d079a04c464ea31133e843022fb0-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 891655515; Wed, 16 Feb 2022 09:56:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 09:56:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 09:56:12 +0800
Message-ID: <3691cb945fdec02271d06cdb5fb8fac1350b49c8.camel@mediatek.com>
Subject: Re: [v2,6/6] drm/mediatek: add display support for MT8186
From:   CK Hu <ck.hu@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <airlied@linux.ie>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <yongqiang.niu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fparent@baylibre.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 16 Feb 2022 09:56:12 +0800
In-Reply-To: <20220215075953.3310-7-rex-bc.chen@mediatek.com>
References: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
         <20220215075953.3310-7-rex-bc.chen@mediatek.com>
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

Hi, Rex:

On Tue, 2022-02-15 at 15:59 +0800, Rex-BC Chen wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> - Add driver data for MT8186 in mtk_drm_drv.c.
> - Add mtk-disp-ovl and mt-disp-ovl-2l support for MT8186.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 20 +++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 39
> +++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 2146299e5f52..5fa56c7b9f5f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -456,6 +456,22 @@ static const struct mtk_disp_ovl_data
> mt8183_ovl_2l_driver_data = {
>  	.fmt_rgb565_is_0 = true,
>  };
>  
> +static const struct mtk_disp_ovl_data mt8186_ovl_driver_data = {
> +	.addr = DISP_REG_OVL_ADDR_MT8173,
> +	.gmc_bits = 10,
> +	.layer_nr = 4,
> +	.fmt_rgb565_is_0 = true,
> +	.smi_id_en = true,
> +};


mt8186_ovl_driver_data is identical to  mt8192_ovl_driver_data, so drop
this one and use mt8192_ovl_driver_data instead.

> +
> +static const struct mtk_disp_ovl_data mt8186_ovl_2l_driver_data = {
> +	.addr = DISP_REG_OVL_ADDR_MT8173,
> +	.gmc_bits = 10,
> +	.layer_nr = 2,
> +	.fmt_rgb565_is_0 = true,
> +	.smi_id_en = true,
> +};

Ditto.

Regards,
CK

> +
>  static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
>  	.gmc_bits = 10,
> @@ -479,8 +495,12 @@ static const struct of_device_id
> mtk_disp_ovl_driver_dt_match[] = {
>  	  .data = &mt8173_ovl_driver_data},
>  	{ .compatible = "mediatek,mt8183-disp-ovl",
>  	  .data = &mt8183_ovl_driver_data},
> +	{ .compatible = "mediatek,mt8186-disp-ovl",
> +	  .data = &mt8186_ovl_driver_data},
>  	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
>  	  .data = &mt8183_ovl_2l_driver_data},
> +	{ .compatible = "mediatek,mt8186-disp-ovl-2l",
> +	  .data = &mt8186_ovl_2l_driver_data},
>  	{ .compatible = "mediatek,mt8192-disp-ovl",
>  	  .data = &mt8192_ovl_driver_data},
>  	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6efb423ccc92..754b1be25d0d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -158,6 +158,24 @@ static const enum mtk_ddp_comp_id
> mt8183_mtk_ddp_ext[] = {
>  	DDP_COMPONENT_DPI0,
>  };
>  
> +static const enum mtk_ddp_comp_id mt8186_mtk_ddp_main[] = {
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_COLOR0,
> +	DDP_COMPONENT_CCORR,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_GAMMA,
> +	DDP_COMPONENT_POSTMASK0,
> +	DDP_COMPONENT_DITHER,
> +	DDP_COMPONENT_DSI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt8186_mtk_ddp_ext[] = {
> +	DDP_COMPONENT_OVL_2L0,
> +	DDP_COMPONENT_RDMA1,
> +	DDP_COMPONENT_DPI0,
> +};
> +
>  static const enum mtk_ddp_comp_id mt8192_mtk_ddp_main[] = {
>  	DDP_COMPONENT_OVL0,
>  	DDP_COMPONENT_OVL_2L0,
> @@ -221,6 +239,13 @@ static const struct mtk_mmsys_driver_data
> mt8183_mmsys_driver_data = {
>  	.ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
>  };
>  
> +static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data =
> {
> +	.main_path = mt8186_mtk_ddp_main,
> +	.main_len = ARRAY_SIZE(mt8186_mtk_ddp_main),
> +	.ext_path = mt8186_mtk_ddp_ext,
> +	.ext_len = ARRAY_SIZE(mt8186_mtk_ddp_ext),
> +};
> +
>  static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data =
> {
>  	.main_path = mt8192_mtk_ddp_main,
>  	.main_len = ARRAY_SIZE(mt8192_mtk_ddp_main),
> @@ -463,6 +488,8 @@ static const struct of_device_id
> mtk_ddp_comp_dt_ids[] = {
>  	  .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8183-disp-mutex",
>  	  .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt8186-disp-mutex",
> +	  .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8192-disp-mutex",
>  	  .data = (void *)MTK_DISP_MUTEX },
>  	{ .compatible = "mediatek,mt8173-disp-od",
> @@ -475,14 +502,20 @@ static const struct of_device_id
> mtk_ddp_comp_dt_ids[] = {
>  	  .data = (void *)MTK_DISP_OVL },
>  	{ .compatible = "mediatek,mt8183-disp-ovl",
>  	  .data = (void *)MTK_DISP_OVL },
> +	{ .compatible = "mediatek,mt8186-disp-ovl",
> +	  .data = (void *)MTK_DISP_OVL },
>  	{ .compatible = "mediatek,mt8192-disp-ovl",
>  	  .data = (void *)MTK_DISP_OVL },
>  	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
>  	  .data = (void *)MTK_DISP_OVL_2L },
> +	{ .compatible = "mediatek,mt8186-disp-ovl-2l",
> +	  .data = (void *)MTK_DISP_OVL_2L },
>  	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
>  	  .data = (void *)MTK_DISP_OVL_2L },
>  	{ .compatible = "mediatek,mt8192-disp-postmask",
>  	  .data = (void *)MTK_DISP_POSTMASK },
> +	{ .compatible = "mediatek,mt8186-disp-postmask",
> +	  .data = (void *)MTK_DISP_POSTMASK},
>  	{ .compatible = "mediatek,mt2701-disp-pwm",
>  	  .data = (void *)MTK_DISP_BLS },
>  	{ .compatible = "mediatek,mt8167-disp-pwm",
> @@ -511,12 +544,16 @@ static const struct of_device_id
> mtk_ddp_comp_dt_ids[] = {
>  	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8183-dpi",
>  	  .data = (void *)MTK_DPI },
> +	{ .compatible = "mediatek,mt8186-dpi",
> +	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt2701-dsi",
>  	  .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8173-dsi",
>  	  .data = (void *)MTK_DSI },
>  	{ .compatible = "mediatek,mt8183-dsi",
>  	  .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt8186-dsi",
> +	  .data = (void *)MTK_DSI },
>  	{ }
>  };
>  
> @@ -533,6 +570,8 @@ static const struct of_device_id mtk_drm_of_ids[]
> = {
>  	  .data = &mt8173_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8183-mmsys",
>  	  .data = &mt8183_mmsys_driver_data},
> +	{ .compatible = "mediatek,mt8186-mmsys",
> +	  .data = &mt8186_mmsys_driver_data},
>  	{ .compatible = "mediatek,mt8192-mmsys",
>  	  .data = &mt8192_mmsys_driver_data},
>  	{ }

