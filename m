Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299124B86CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiBPLgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:36:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiBPLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:36:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4ACC513
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:36:05 -0800 (PST)
X-UUID: 82273099cb9f48b98791a9d31a523643-20220216
X-UUID: 82273099cb9f48b98791a9d31a523643-20220216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1334639506; Wed, 16 Feb 2022 19:36:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 19:36:00 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 19:36:00 +0800
Message-ID: <55c380797ef845992c0d1a7f1d15b986eaf478c0.camel@mediatek.com>
Subject: Re: [v11,1/3] drm/dsi: transfer DSI HS packets ending at the same
 time
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <andrzej.hajda@intel.com>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 16 Feb 2022 19:36:00 +0800
In-Reply-To: <20220207045625.17713-2-rex-bc.chen@mediatek.com>
References: <20220207045625.17713-1-rex-bc.chen@mediatek.com>
         <20220207045625.17713-2-rex-bc.chen@mediatek.com>
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

Hello common DRM maintainers,

We have proposed a DSI mode_flag definition in
include/drm/drm_mipi_dsi.h.
The maintainer of bridge chip, Andrzej, also reviewed this patch.

Is there any chance that you can give us some suggestions?
We also need your approvement if this series is acceptable.

Also, if the patch is not proper for you, please let us know.

Thanks for your help.

BRs,
Rex

On Mon, 2022-02-07 at 12:56 +0800, Rex-BC Chen wrote:
> Since a HS transmission is composed of an arbitrary number
> of bytes that may not be an integer multiple of lanes, some
> lanes may run out of data before others.
> (Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)
> 
> However, for some DSI RX devices (for example, anx7625),
> there is a limitation that packet number should be the same
> on all DSI lanes. In other words, they need to end a HS at
> the same time.
> 
> Because this limitation is for some specific DSI RX devices,
> it is more reasonable to put the enable control in these
> DSI RX drivers. If DSI TX driver knows the information,
> they can adjust the setting for this situation.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Acked-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 147e51b6d241..51e09a1a106a 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -137,6 +137,8 @@ struct mipi_dsi_host
> *of_find_mipi_dsi_host_by_node(struct device_node *node);
>  #define MIPI_DSI_CLOCK_NON_CONTINUOUS	BIT(10)
>  /* transmit data in low power */
>  #define MIPI_DSI_MODE_LPM		BIT(11)
> +/* transmit data ending at the same time for all lanes within one
> hsync */
> +#define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
>  
>  enum mipi_dsi_pixel_format {
>  	MIPI_DSI_FMT_RGB888,

