Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4D580FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiGZJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiGZJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:16:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F060F24F32
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:16:03 -0700 (PDT)
X-UUID: e8ee800c05ff41459e7984d877b1f0f6-20220726
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:55bed568-d55e-4f2d-9247-14b2fc126e32,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:c32787b3-06d2-48ef-b2dd-540836705165,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e8ee800c05ff41459e7984d877b1f0f6-20220726
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1719183704; Tue, 26 Jul 2022 17:15:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 26 Jul 2022 17:15:55 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 26 Jul 2022 17:15:54 +0800
Message-ID: <9385f8642e6ad5491a036360c644dc21b9a3f009.camel@mediatek.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Support HDMI_I2S audio format
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <bliang@analogixsemi.com>, <qwen@analogixsemi.com>,
        <hsinyi@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jul 2022 17:15:54 +0800
In-Reply-To: <20220726033058.403715-1-xji@analogixsemi.com>
References: <20220726033058.403715-1-xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-26 at 11:30 +0800, Xin Ji wrote:
> 1. Support HDMI_I2S audio format.
> 2. Return 0 if there is no sink connection in .hw_param callback.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 23 +++++++++++++++++--
> ----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
Acked-by: Jiaxin Yu<jiaxin.yu@mediatek.com>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
> b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 79fc7a50b497..c74b5df4cade 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1797,8 +1797,13 @@ static int anx7625_audio_hw_params(struct
> device *dev, void *data,
>  	int wl, ch, rate;
>  	int ret = 0;
>  
> -	if (fmt->fmt != HDMI_DSP_A) {
> -		DRM_DEV_ERROR(dev, "only supports DSP_A\n");
> +	if (anx7625_sink_detect(ctx) == connector_status_disconnected)
> {
> +		DRM_DEV_DEBUG_DRIVER(dev, "DP not connected\n");
> +		return 0;
> +	}
> +
> +	if (fmt->fmt != HDMI_DSP_A && fmt->fmt != HDMI_I2S) {
> +		DRM_DEV_ERROR(dev, "only supports DSP_A & I2S\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1806,10 +1811,16 @@ static int anx7625_audio_hw_params(struct
> device *dev, void *data,
>  			     params->sample_rate, params->sample_width,
>  			     params->cea.channels);
>  
> -	ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> -				    AUDIO_CHANNEL_STATUS_6,
> -				    ~I2S_SLAVE_MODE,
> -				    TDM_SLAVE_MODE);
> +	if (fmt->fmt == HDMI_DSP_A)
> +		ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +					   AUDIO_CHANNEL_STATUS_6,
> +					   ~I2S_SLAVE_MODE,
> +					   TDM_SLAVE_MODE);
> +	else
> +		ret = anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +					   AUDIO_CHANNEL_STATUS_6,
> +					   ~TDM_SLAVE_MODE,
> +					   I2S_SLAVE_MODE);
>  
>  	/* Word length */
>  	switch (params->sample_width) {

