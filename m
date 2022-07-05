Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0A5662C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiGEF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGEF3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:29:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63B12AE7;
        Mon,  4 Jul 2022 22:29:46 -0700 (PDT)
X-UUID: 551616c1e6934500ae8ad6638285b090-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0931eb02-0cc3-4bb3-8f00-9e27de93aeca,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:0931eb02-0cc3-4bb3-8f00-9e27de93aeca,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:7cb09fd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:31d19f6e7bdc,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 551616c1e6934500ae8ad6638285b090-20220705
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1992025857; Tue, 05 Jul 2022 13:29:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 5 Jul 2022 13:29:39 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jul 2022 13:29:39 +0800
Message-ID: <b126b455927dabad2e2f1dc07beefd4a44ce975f.camel@mediatek.com>
Subject: Re: [PATCH v15 16/16] drm/mediatek: dpi: Add dp_intf support
From:   CK Hu <ck.hu@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <xinlei.lee@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 5 Jul 2022 13:29:39 +0800
In-Reply-To: <20220701035845.16458-17-rex-bc.chen@mediatek.com>
References: <20220701035845.16458-1-rex-bc.chen@mediatek.com>
         <20220701035845.16458-17-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bo-Chen:

On Fri, 2022-07-01 at 11:58 +0800, Bo-Chen Chen wrote:
> From: Guillaume Ranquet <granquet@baylibre.com>
> 
> Dpintf is the displayport interface hardware unit. This unit is
> similar
> to dpi and can reuse most of the code.
> 
> This patch adds support for mt8195-dpintf to this dpi driver. Main
> differences are:
>  - 4 pixels for one iteration for dp_intf while dpi is 1 pixel for
> one
>    iteration. Therefore, we add a new config "pixels_per_iter" to
> control
>    quantity of transferred pixels per iteration.
>  - Input of dp_intf is two pixels per iteration, so we add a new
> config
>    "input_2pixel" to control this.
>  - Some register contents differ slightly between the two components.
> To
>    work around this I added register bits/masks with a DPINTF_ prefix
>    and use them where different.
> 
> Based on a separate driver for dpintf created by
> Jitao shi <jitao.shi@mediatek.com>.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c          | 65
> ++++++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h     | 12 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  4 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  3 +
>  5 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index be039474cf26..1072e94d2f2f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -125,12 +125,15 @@ struct mtk_dpi_yc_limit {
>   * @swap_input_support: Support input swap function.
>   * @color_fmt_trans_support: Enable color format transfer.
>   * @support_direct_pin: IP supports direct connection to dpi panels.
> + * @input_2pixel: Input pixel of dp_intf is 2 pixel per round, so
> enable this
> + *		  config to enable this feature.
>   * @dimension_mask: Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and
> VSYNC_PORCH
>   *		    (no shift).
>   * @hvsize_mask: Mask of HSIZE and VSIZE mask (no shift).
>   * @channel_swap_shift: Shift value of channel swap.
>   * @yuv422_en_bit: Enable bit of yuv422.
>   * @csc_enable_bit: Enable bit of CSC.
> + * @pixels_per_iter: Quantity of transferred pixels per iteration.
>   */
>  struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
> @@ -143,11 +146,13 @@ struct mtk_dpi_conf {
>  	bool swap_input_support;
>  	bool color_fmt_trans_support;
>  	bool support_direct_pin;
> +	bool input_2pixel;

Separate input_2pixel to an independent patch.

>  	u32 dimension_mask;
>  	u32 hvsize_mask;
>  	u32 channel_swap_shift;
>  	u32 yuv422_en_bit;
>  	u32 csc_enable_bit;
> +	u32 pixels_per_iter;

Separate pixels_per_iter to an independent patch.

Regards,
CK

>  };
>  
> 

