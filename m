Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356F850880E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378502AbiDTM0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbiDTM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:26:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212363A71A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:23:39 -0700 (PDT)
X-UUID: 63e924ed9ce74d97bf03f3c9ee80405b-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f7b8aa47-61bc-4004-a2b8-62bdb08e4030,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:6f1a5cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 63e924ed9ce74d97bf03f3c9ee80405b-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1360268970; Wed, 20 Apr 2022 20:23:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 20:23:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 20:23:31 +0800
Message-ID: <91c52b76872e6339cce3bd671f4ae1143251e2c3.camel@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: dpi: Use mt8183 output formats for
 mt8192
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <kernel@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <ck.hu@mediatek.com>
Date:   Wed, 20 Apr 2022 20:23:31 +0800
In-Reply-To: <20220408013950.674477-1-nfraprado@collabora.com>
References: <20220408013950.674477-1-nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-07 at 21:39 -0400, Nícolas F. R. A. Prado wrote:
> The configuration for mt8192 was incorrectly using the output formats
> from mt8173. Since the output formats for mt8192 are instead the same
> ones as for mt8183, which require two bus samples per pixel, the
> pixelclock and DDR edge setting were misconfigured. This made
> external
> displays unable to show the image.
> 
> Fix the issue by correcting the output format for mt8192 to be the
> same
> as for mt8183, fixing the usage of external displays for mt8192.
> 
> Fixes: be63f6e8601f ("drm/mediatek: dpi: Add output bus formats to
> driver data")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v2:
> - Added Fixes tag
> 
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 4554e2de1430..e61cd67b978f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -819,8 +819,8 @@ static const struct mtk_dpi_conf mt8192_conf = {
>  	.cal_factor = mt8183_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
>  	.max_clock_khz = 150000,
> -	.output_fmts = mt8173_output_fmts,
> -	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
> +	.output_fmts = mt8183_output_fmts,
> +	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
>  };
>  
>  static int mtk_dpi_probe(struct platform_device *pdev)

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Hello CK,

Gentle ping for this patch.
This patch is confirmed by Xinlei and Jitao.

BRs,
Rex

