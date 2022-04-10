Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178D4FAD2B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiDJKXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDJKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:23:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31840916
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:21:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso8278863wmz.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ohIuOdM6DzJDhbBlT7yQBBise/yXXw2K/gzL9jVclM=;
        b=hq3T+QZbJGzqXy1RTjkX6lJuyGFt12NpBY5omJXC8yM3Bj3LRiIq2LH71J4pURY7/Y
         vGTdytP1PjwMyFd4tHzAy06DGN+e7LAP2XKAkzorOO3oJSEDu15/f1V1X7jmWs6rCwC4
         cQGAaO+4HGtE2b2mXvT2QBAKCmmSfMuerSQSZCLwEMAahd3HuWCca4Tl3dulQ8dLN2+b
         vAWDNpK5ssYlt4eLB6lUATK3+sd2AQXePzBXasTO2ab6JZgDUXnpUV1f7g3hm5FXjtve
         sgUqt3gkgpfYKV2N7DaZ3CkOPIxyqiSYxByY02ZZukkFzEl+L4aoCTror9yakfiy5W4g
         kjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ohIuOdM6DzJDhbBlT7yQBBise/yXXw2K/gzL9jVclM=;
        b=YS/xutkuthOlVGh/v0njtwFmWhQwzejnIaRShUZcBW7Z1lzehHFHAeZA+qHK9MeuVt
         hMUYt9hwjgHAraPqh/1+vMi4AxiO2n4VrNc0pswaeS0AOGmSv7eRuUP5GchXScBFz0VI
         ImHtK1z2oQgHD3NagUERMSWRBVPWa7GJim27kfL0eUj6Dlf3oQ4nXYgFBPC5TZMEo0yl
         7e4KO0DM7Z88Jg1c1aK6wnKgVPZ0fJsL28S4V6IZ8yBtSFv0Spf+S8joXAUFQ6Ns4Irh
         K9Uv9ePOAsdTZYLzkyIs5Rn4WMyet38dx6mfN6SHeKKKustpkUYWnR4qgk9Erx/bNIz1
         Dx1w==
X-Gm-Message-State: AOAM531cjeZcy1xdVAsFTJa2d2cfdz16oqHnICDzgcnhJWfOMl0LpTN7
        lcUDx0UUWjGvJdDNfjDZYhq70ao6B7Sptw==
X-Google-Smtp-Source: ABdhPJxnZBhyOuKv7rt3TbuLfT5xeuF09Ok0dSyFkx/h4GqX91irFb+b5FiBQjHDhSxAMKCbNZTD2Q==
X-Received: by 2002:a7b:cd03:0:b0:37b:fc83:a4e2 with SMTP id f3-20020a7bcd03000000b0037bfc83a4e2mr24599840wmj.193.1649586061290;
        Sun, 10 Apr 2022 03:21:01 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id a11-20020a056000188b00b00204109f7826sm26818620wri.28.2022.04.10.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:21:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, hverkuil-cisco@xs4all.nl,
        Sandor Yu <Sandor.yu@nxp.com>
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com
Subject: Re: [PATCH v2 2/5] drm: bridge: dw_hdmi: default enable workaround to clear the overflow
Date:   Sun, 10 Apr 2022 12:20:59 +0200
Message-ID: <8087050.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <39592fee39610c544058e6b8f9af4b4ea8dc4cdc.1649412256.git.Sandor.yu@nxp.com>
References: <cover.1649412256.git.Sandor.yu@nxp.com> <39592fee39610c544058e6b8f9af4b4ea8dc4cdc.1649412256.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. april 2022 ob 12:32:25 CEST je Sandor Yu napisal(a):
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
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> 4befc104d220..02d8f7e08814 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2086,30 +2086,21 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> *hdmi) * then write one of the FC registers several times.
>  	 *
>  	 * The number of iterations matters and depends on the HDMI TX 
revision
> -	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
> -	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been 
identified
> -	 * as needing the workaround, with 4 iterations for v1.30a and 1
> -	 * iteration for others.
> -	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as 
needing
> -	 * the workaround with a single iteration.
> -	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs 
(v2.11a) have
> -	 * been identified as needing the workaround with a single 
iteration.
> +	 * (and possibly on the platform).
> +	 * 4 iterations for i.MX6Q(v1.30a) and 1 iteration for others.
> +	 * i.MX6DL (v1.31a), Allwinner SoCs (v1.32a), Rockchip RK3288 SoC
> (v2.00a), +	 * Amlogic Meson GX SoCs (v2.01a), RK3328/RK3399 SoCs (v2.11a)
> +	 * and i.MX8MPlus (v2.13a) have been identified as needing the 
workaround
> +	 * with a single iteration.
>  	 */

It would be easier to read and modify later if platforms/controllers/variants 
are given as list, one per line, but it could be done later.

Best regards,
Jernej

> 
>  	switch (hdmi->version) {
>  	case 0x130a:
>  		count = 4;
>  		break;
> -	case 0x131a:
> -	case 0x132a:
> -	case 0x200a:
> -	case 0x201a:
> -	case 0x211a:
> -	case 0x212a:
> +	default:
>  		count = 1;
>  		break;
> -	default:
> -		return;
>  	}
> 
>  	/* TMDS software reset */




