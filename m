Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C884FC1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348318AbiDKP4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbiDKP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:56:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752296459;
        Mon, 11 Apr 2022 08:54:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so4876051wma.3;
        Mon, 11 Apr 2022 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmuYtqAwEElb8nxVd+fxQ89gGHmXquxvJjVsYoqHv2Y=;
        b=keocVt8ryOJFNtu5Az/dug++DkTAI4OLWaFHkX4cvSsY1xV/Wskbcl5ImhbUzHtCaE
         4OMIC3t4sUW/61SlvymjUxxHekkkGk8zMK66fM3+/Ff7PxoGkiTMizk0GgsSIZLo/faB
         kLIO1o1ZFqcHSMwQjOHxjyHcqO6AYi7MqD6XDvPzTCtq0xAgBohx+LNW4dE7cbKZg7js
         WdIJ2O1rpMwswpbjOOCj2iLMgUeClP+tOnqgOJc6YJeAyfnjPl7nyIpmEYi7YQvceh2V
         q8elVAXixGrrTSNmOmBdmnykQ14lXvMlgHWhHaASaJrj6SOf2cOsJHVG1CQKSGJ1JfCK
         IUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmuYtqAwEElb8nxVd+fxQ89gGHmXquxvJjVsYoqHv2Y=;
        b=YFOuq/rJLcb6mP4CgGEFKA5mo2vmTI7gEko7hkS+cgrAEgPNZs6ifvvXDSVg9HpW2P
         TKoM+Pt92l59LhiSrGFv01xk+aFI1iefjOx5JD4aafIZdtMKkdNUaygjSwSxE04ooRTj
         ejpZBleUJu5iY/KRdB/W2JacdnXYavgBh3KzkJhegO5rd99+jfJSFxh3aN/g173RCcHf
         /VPdHSkFz2pI98BRLnij2dAItxetKV5vV4JnLWb9C7bB3ko1KP1/N15gD0jMmasCwISs
         UDuhUmR2Heqgjvgo+sQqfIlQLaMdROlI9XDqdgwG6hrv2htgPa0jqsDzTTRDBR0HLMSw
         kICg==
X-Gm-Message-State: AOAM5303+DYc5GU/1I1TOCN0m0NIGc031UWL9/z+HhFFUGwuPJRPkV2v
        20m11gSnErUd/2KrXBxWl7o=
X-Google-Smtp-Source: ABdhPJwKMQkKpncM2rJZD2K2/Z9LaMxbxU3HY7D5aMcEWRGUB8rsH5POeRJ5rWtiP9HOlGX7T5u88w==
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id g12-20020a05600c4ecc00b0038e354d0909mr30666672wmq.33.1649692467942;
        Mon, 11 Apr 2022 08:54:27 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600018a100b00207ab2305d5sm1569272wri.16.2022.04.11.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:54:27 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 10/10] drm/sun4i: Add compatible for D1 display engine
Date:   Mon, 11 Apr 2022 17:54:26 +0200
Message-ID: <1908291.usQuhbGJ8B@kista>
In-Reply-To: <20220411043423.37333-11-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org> <20220411043423.37333-11-samuel@sholland.org>
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

Dne ponedeljek, 11. april 2022 ob 06:34:22 CEST je Samuel Holland napisal(a):
> Now that the various blocks in the D1 display engine pipeline are
> supported, we can enable the overall engine.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/
sun4i_drv.c
> index 6a9ba8a77c77..275f7e4a03ae 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -418,6 +418,7 @@ static const struct of_device_id sun4i_drv_of_table[] = 
{
>  	{ .compatible = "allwinner,sun8i-r40-display-engine" },
>  	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
>  	{ .compatible = "allwinner,sun9i-a80-display-engine" },
> +	{ .compatible = "allwinner,sun20i-d1-display-engine" },
>  	{ .compatible = "allwinner,sun50i-a64-display-engine" },
>  	{ .compatible = "allwinner,sun50i-h6-display-engine" },
>  	{ }
> -- 
> 2.35.1
> 
> 


