Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2292B4F9587
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbiDHMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDHMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:22:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4C33D0F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:20:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m67-20020a1ca346000000b0038e6a1b218aso5438106wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Tm3844p3tyj2hoHmI7W25/vDNLRVfKVH7ujOGYxkyIE=;
        b=SQ4QXeiefAStQE0uIiuq5fbTmB6dqaolONV3x2vWJ/d61seFNX6BK/GfTHcpkaABjv
         fN90oNIkgoBZXoioj+sQt2X7JdgL1a4QbcIKAtSVIqnkUK6DdA0oTRa3fxKiNaOYSwav
         E0OUcFQLy5tttayTwrU4ht2Z6VjzGjpbDOhmKEVf3ug5gh+jzOlXvIfbyDj0Cp7quIv9
         0rV7CEzteB98W5wJu/75nOqNpENOjVFuZwd7LycBEGWPvFpQx5RpQ3B2YvAW0+ZId6eh
         WiQud2cf5ykiV6P4hyCUzQfaEES8MCcWGxwJcG0Nl80x01UqH/kh4K/BnH85E+ODKxup
         hmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Tm3844p3tyj2hoHmI7W25/vDNLRVfKVH7ujOGYxkyIE=;
        b=hbHZSCsSFfxrFLtH/24Ui5Je6geJYA+UeOatnO57HXpjhFFQW66CdM5V5fUiUquxXd
         P4pvrJZx4ImjO0TmYJDop8HIpQTCRNkzPopLufprhIULmT49RtGZjx1jhbo9kylbCV2G
         WzkehRgproWzJd5dS463Mp+daJtrcBJuJNlOU8mUiY4/9k5oIib7K0WLhStRvyA7Zyg4
         IkvKPvc/h1u9KNI5LWqFmetqz+w13IUu4J9tVckHhB66/DWsdFRT2cvXIS4G0tD1SQlZ
         a6EWimX5jWH5TsRGhqtLtQ+vtDYBYTs1lW2YhfQWb7gN9BHCJP12xfCWl4U/VzpFHHtl
         Qxig==
X-Gm-Message-State: AOAM533a4hWflla9N4li1sbHPe0PuvMquOArnPKrTHja21Zt5jktVn9f
        1kW7xdLwulOmewkqDp8A40D1pw==
X-Google-Smtp-Source: ABdhPJyGLvOJ/1FtA8a81Q6gFsU03e8HUiyv0If0DZiyYPgTULh2Nj1Yr/DOO3WhVFFKZf93TjeeVw==
X-Received: by 2002:a05:600c:5021:b0:38c:70c0:80e9 with SMTP id n33-20020a05600c502100b0038c70c080e9mr16445209wmr.91.1649420451363;
        Fri, 08 Apr 2022 05:20:51 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id j3-20020adfd203000000b0020616cddfd5sm11134751wrh.7.2022.04.08.05.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:20:50 -0700 (PDT)
Message-ID: <50460cf7-34e9-7c8e-131b-6866f43ec2da@baylibre.com>
Date:   Fri, 8 Apr 2022 14:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/5] drm: bridge: dw_hdmi: default enable workaround to
 clear the overflow
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
References: <cover.1649412256.git.Sandor.yu@nxp.com>
 <39592fee39610c544058e6b8f9af4b4ea8dc4cdc.1649412256.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <39592fee39610c544058e6b8f9af4b4ea8dc4cdc.1649412256.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:32, Sandor Yu wrote:
> i.MX8MPlus (v2.13a) has verified need the workaround to clear the
> overflow with one iteration.
> Only i.MX6Q(v1.30a) need the workaround with 4 iterations,
> the others versions later than v1.3a have been identified as needing
> the workaround with a single iteration.
> 
> Default enable the workaround with one iteration for all versions
> later than v1.30a.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 4befc104d220..02d8f7e08814 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2086,30 +2086,21 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>   	 * then write one of the FC registers several times.
>   	 *
>   	 * The number of iterations matters and depends on the HDMI TX revision
> -	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
> -	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
> -	 * as needing the workaround, with 4 iterations for v1.30a and 1
> -	 * iteration for others.
> -	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
> -	 * the workaround with a single iteration.
> -	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
> -	 * been identified as needing the workaround with a single iteration.
> +	 * (and possibly on the platform).
> +	 * 4 iterations for i.MX6Q(v1.30a) and 1 iteration for others.
> +	 * i.MX6DL (v1.31a), Allwinner SoCs (v1.32a), Rockchip RK3288 SoC (v2.00a),
> +	 * Amlogic Meson GX SoCs (v2.01a), RK3328/RK3399 SoCs (v2.11a)
> +	 * and i.MX8MPlus (v2.13a) have been identified as needing the workaround
> +	 * with a single iteration.
>   	 */
>   
>   	switch (hdmi->version) {
>   	case 0x130a:
>   		count = 4;
>   		break;
> -	case 0x131a:
> -	case 0x132a:
> -	case 0x200a:
> -	case 0x201a:
> -	case 0x211a:
> -	case 0x212a:
> +	default:
>   		count = 1;
>   		break;
> -	default:
> -		return;
>   	}
>   
>   	/* TMDS software reset */

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
