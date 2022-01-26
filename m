Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA49749C530
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiAZIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:23:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39028 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238350AbiAZIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:23:54 -0500
X-UUID: 1f88ff34afa848b8a35f0d9494550e72-20220126
X-UUID: 1f88ff34afa848b8a35f0d9494550e72-20220126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 306077830; Wed, 26 Jan 2022 16:23:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:23:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:23:50 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 28/31] clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
Date:   Wed, 26 Jan 2022 16:23:50 +0800
Message-ID: <20220126082350.10393-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-29-wenst@chromium.org>
References: <20220122091731.283592-29-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Various small clock controllers only have clock gates, and utilize
> mtk_clk_simple_probe() as their driver probe function.
> 
> Now that we have a matching remove function, hook it up for the relevant
> drivers. This was done with the following command:
> 
> sed -i -e '/mtk_clk_simple_probe/a \
>         .remove = mtk_clk_simple_remove,' drivers/clk/mediatek/clk-mt8195-*.c
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for doing this exmaple, we can apply 
mtk_clk_simple_probe/mtk_clk_simple_remove to other clk-mtxxxx in the future.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mt8195-cam.c          | 1 +
>  drivers/clk/mediatek/clk-mt8195-ccu.c          | 1 +
>  drivers/clk/mediatek/clk-mt8195-img.c          | 1 +
>  drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 1 +
>  drivers/clk/mediatek/clk-mt8195-infra_ao.c     | 1 +
>  drivers/clk/mediatek/clk-mt8195-ipe.c          | 1 +
>  drivers/clk/mediatek/clk-mt8195-mfg.c          | 1 +
>  drivers/clk/mediatek/clk-mt8195-peri_ao.c      | 1 +
>  drivers/clk/mediatek/clk-mt8195-scp_adsp.c     | 1 +
>  drivers/clk/mediatek/clk-mt8195-vdec.c         | 1 +
>  drivers/clk/mediatek/clk-mt8195-venc.c         | 1 +
>  drivers/clk/mediatek/clk-mt8195-vpp0.c         | 1 +
>  drivers/clk/mediatek/clk-mt8195-vpp1.c         | 1 +
>  drivers/clk/mediatek/clk-mt8195-wpe.c          | 1 +
>  14 files changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
> index 3d261fc3848e..e4d00fe6e757 100644
> --- a/drivers/clk/mediatek/clk-mt8195-cam.c
> +++ b/drivers/clk/mediatek/clk-mt8195-cam.c
> @@ -134,6 +134,7 @@ static const struct of_device_id of_match_clk_mt8195_cam[] = {
>  
>  static struct platform_driver clk_mt8195_cam_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-cam",
>  		.of_match_table = of_match_clk_mt8195_cam,
> diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
> index f846f1d73605..4e326b6301ba 100644
> --- a/drivers/clk/mediatek/clk-mt8195-ccu.c
> +++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
> @@ -42,6 +42,7 @@ static const struct of_device_id of_match_clk_mt8195_ccu[] = {
>  
>  static struct platform_driver clk_mt8195_ccu_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-ccu",
>  		.of_match_table = of_match_clk_mt8195_ccu,
> diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
> index 22b52a8f15fe..12f5c436d075 100644
> --- a/drivers/clk/mediatek/clk-mt8195-img.c
> +++ b/drivers/clk/mediatek/clk-mt8195-img.c
> @@ -88,6 +88,7 @@ static const struct of_device_id of_match_clk_mt8195_img[] = {
>  
>  static struct platform_driver clk_mt8195_img_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-img",
>  		.of_match_table = of_match_clk_mt8195_img,
> diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> index 4ab312eb26a5..fbc809d05072 100644
> --- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> +++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
> @@ -58,6 +58,7 @@ static const struct of_device_id of_match_clk_mt8195_imp_iic_wrap[] = {
>  
>  static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-imp_iic_wrap",
>  		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
> diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> index 5f9b69967459..8ebe3b9415c4 100644
> --- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
> @@ -198,6 +198,7 @@ static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
>  
>  static struct platform_driver clk_mt8195_infra_ao_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-infra_ao",
>  		.of_match_table = of_match_clk_mt8195_infra_ao,
> diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
> index fc1d42b6ac84..b0d745cf7752 100644
> --- a/drivers/clk/mediatek/clk-mt8195-ipe.c
> +++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
> @@ -43,6 +43,7 @@ static const struct of_device_id of_match_clk_mt8195_ipe[] = {
>  
>  static struct platform_driver clk_mt8195_ipe_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-ipe",
>  		.of_match_table = of_match_clk_mt8195_ipe,
> diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
> index aca6d9c0837c..9411c556a5a9 100644
> --- a/drivers/clk/mediatek/clk-mt8195-mfg.c
> +++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
> @@ -39,6 +39,7 @@ static const struct of_device_id of_match_clk_mt8195_mfg[] = {
>  
>  static struct platform_driver clk_mt8195_mfg_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-mfg",
>  		.of_match_table = of_match_clk_mt8195_mfg,
> diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
> index 907a92b22de8..2f6b3bb657db 100644
> --- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
> +++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
> @@ -54,6 +54,7 @@ static const struct of_device_id of_match_clk_mt8195_peri_ao[] = {
>  
>  static struct platform_driver clk_mt8195_peri_ao_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-peri_ao",
>  		.of_match_table = of_match_clk_mt8195_peri_ao,
> diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
> index 26b4846c5894..e16c383f631b 100644
> --- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
> +++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
> @@ -39,6 +39,7 @@ static const struct of_device_id of_match_clk_mt8195_scp_adsp[] = {
>  
>  static struct platform_driver clk_mt8195_scp_adsp_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-scp_adsp",
>  		.of_match_table = of_match_clk_mt8195_scp_adsp,
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
> index a1df04f42a90..a1446b666385 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdec.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
> @@ -96,6 +96,7 @@ static const struct of_device_id of_match_clk_mt8195_vdec[] = {
>  
>  static struct platform_driver clk_mt8195_vdec_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-vdec",
>  		.of_match_table = of_match_clk_mt8195_vdec,
> diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
> index 7339851a0856..622f57804f96 100644
> --- a/drivers/clk/mediatek/clk-mt8195-venc.c
> +++ b/drivers/clk/mediatek/clk-mt8195-venc.c
> @@ -61,6 +61,7 @@ static const struct of_device_id of_match_clk_mt8195_venc[] = {
>  
>  static struct platform_driver clk_mt8195_venc_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-venc",
>  		.of_match_table = of_match_clk_mt8195_venc,
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> index c3241466a8d0..bf2939c3a023 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
> @@ -102,6 +102,7 @@ static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
>  
>  static struct platform_driver clk_mt8195_vpp0_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-vpp0",
>  		.of_match_table = of_match_clk_mt8195_vpp0,
> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> index ce0b9a40a179..ffd52c762890 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
> @@ -100,6 +100,7 @@ static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
>  
>  static struct platform_driver clk_mt8195_vpp1_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-vpp1",
>  		.of_match_table = of_match_clk_mt8195_vpp1,
> diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
> index 274d60838d8e..b483fab10e18 100644
> --- a/drivers/clk/mediatek/clk-mt8195-wpe.c
> +++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
> @@ -135,6 +135,7 @@ static const struct of_device_id of_match_clk_mt8195_wpe[] = {
>  
>  static struct platform_driver clk_mt8195_wpe_drv = {
>  	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  	.driver = {
>  		.name = "clk-mt8195-wpe",
>  		.of_match_table = of_match_clk_mt8195_wpe,
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
