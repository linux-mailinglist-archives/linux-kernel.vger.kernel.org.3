Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F277B4F7F20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbiDGMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiDGMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:35:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403415D170
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:33:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c7so7722747wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ji1BfOWlSKILtbfQiPYzrTyuqXnWUOjO5ppz+57Rw9I=;
        b=Xs1YkraY7+65T5ktxyY72dW+2Vi3e3QFczWY+1HRvqstfBeHzgQ9m+ov0YH3FACwL2
         SwFr/vkEsipWcP/LsXelRXgAX5ky8XYUvXO159+gEohIT5uEaAWcBletX8JOvT6xn44V
         yv1IfsmaG7k9eZeYjVgF2IhXp+b90m01dOtloowyYXx+3JFJGMByhoaW5TkeDzIIDDRe
         OXsPMlh+2mMk8XcE3eZwx+oR/4RLpJEGT97YUFYuqCegEhsXwFqcXd/6FsBP/80l685t
         H+RA7DWVv5+w5URobNAkuajZfqQFzisUsRFeHApSoj9QTG+e+lZQbdvS+CUDfJl1mh38
         osig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ji1BfOWlSKILtbfQiPYzrTyuqXnWUOjO5ppz+57Rw9I=;
        b=mOs8ZywUfBVWkXtW9J/xIRq2uV8nNnPaVYAGDB+lpmf52Nl09wC/9vnlpiLQq6rkyX
         9/ib2ENbM0rgbvjNxR6Ls8QOYiACu/+mKVW8L3a6j3Urf3VNieVxgnCOVqR1GFx29J+N
         5TMKXXe9Ae1K1Yhz57WEkTtuhNHqBV0biJ/ZivQ52BYtaI1aKcHZoFvFDHmxluwX3HQc
         XPz0k5R+rSTpDpd+gmQ7ZULlaVz0lXZITNlhi1yBWzwQ6V80+/ErqLR+2v5Qh1+6NWqS
         puhG72MPIp95IGMb6qXw+KxSp5DbrvZ0cP/NhB63nLTuVDP8S38lF0tBNFb2vx45Nr9M
         PaRA==
X-Gm-Message-State: AOAM530jGFHE1rQ56TybL1b5RZl7RvK17V7xTGRRqZH3O01Am3IkwOXI
        bv8cuHzlkXuayqpPuGp94mKUCg==
X-Google-Smtp-Source: ABdhPJz/Wse1u85JwM0PnM7el4sotnHAxRHuwDG81gJSO+6OwDAfn9ysHqIKEW9uVdi6kXhJZOcHSA==
X-Received: by 2002:a5d:47a8:0:b0:204:72:7051 with SMTP id 8-20020a5d47a8000000b0020400727051mr10834956wrb.451.1649334819968;
        Thu, 07 Apr 2022 05:33:39 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 11-20020a056000156b00b002040674fd13sm20847369wrz.38.2022.04.07.05.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:33:39 -0700 (PDT)
Message-ID: <99208349-2166-97b0-4c61-3340232ee1b6@baylibre.com>
Date:   Thu, 7 Apr 2022 14:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v18 2/3] drm/ingenic: Implement proper
 .atomic_get_input_bus_fmts
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>
References: <cover.1649330170.git.hns@goldelico.com>
 <ab25925723cff2f3e773e7137567ef86fff5fdba.1649330171.git.hns@goldelico.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <ab25925723cff2f3e773e7137567ef86fff5fdba.1649330171.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 13:16, H. Nikolaus Schaller wrote:
> From: Paul Cercueil <paul@crapouillou.net>
> 
> The .atomic_get_input_bus_fmts() callback of our top bridge should
> return the possible input formats for a given output format. If the
> requested output format is not supported, then NULL should be returned,
> otherwise the bus format negociation will end with a bus format that the
> encoder does not support.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 28 ++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index a4f5a323f4906..8eb0ad501a7b9 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -833,6 +833,32 @@ static int ingenic_drm_bridge_atomic_check(struct drm_bridge *bridge,
>   	}
>   }
>   
> +static u32 *
> +ingenic_drm_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> +					     struct drm_bridge_state *bridge_state,
> +					     struct drm_crtc_state *crtc_state,
> +					     struct drm_connector_state *conn_state,
> +					     u32 output_fmt,
> +					     unsigned int *num_input_fmts)
> +{
> +	switch (output_fmt) {
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +	case MEDIA_BUS_FMT_RGB888_3X8:
> +	case MEDIA_BUS_FMT_RGB888_3X8_DELTA:
> +		break;
> +	default:
> +		*num_input_fmts = 0;
> +		return NULL;
> +	}
> +
> +	return drm_atomic_helper_bridge_propagate_bus_fmt(bridge, bridge_state,
> +							  crtc_state, conn_state,
> +							  output_fmt,
> +							  num_input_fmts);
> +}
> +
>   static irqreturn_t ingenic_drm_irq_handler(int irq, void *arg)
>   {
>   	struct ingenic_drm *priv = drm_device_get_priv(arg);
> @@ -984,7 +1010,7 @@ static const struct drm_bridge_funcs ingenic_drm_bridge_funcs = {
>   	.atomic_reset		= drm_atomic_helper_bridge_reset,
>   	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
>   	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
> -	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
> +	.atomic_get_input_bus_fmts = ingenic_drm_bridge_atomic_get_input_bus_fmts,
>   };
>   
>   static const struct drm_mode_config_funcs ingenic_drm_mode_config_funcs = {

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
