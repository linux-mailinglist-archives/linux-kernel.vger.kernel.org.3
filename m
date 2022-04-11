Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A54FC118
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348084AbiDKPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348186AbiDKPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:42:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603A93A727;
        Mon, 11 Apr 2022 08:40:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t1so5932266wra.4;
        Mon, 11 Apr 2022 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kURCqWE8pomFkfYFiXr4O15/fAJHColFs2BDAs5/sSY=;
        b=JtoaVvLTXvRhY3gYKm77KhSxq+xb1+GNAnVO3CZFzO9gm8QRx1cDg3BS7TrSiYd6sP
         NQJFtUPhw9/KvCsKvJv+9LmViJLY1/vOcRqH9UVoS4nrkacZGUr+QMzjX9vSzAKYT0r/
         ZNwbY1n6vQCPWLPbZgQ2PmigGmGzuglGmfX8wxSMW6sFPo6+ad/HNxr1nObKLDhVznyw
         14BVrHCXdbAZ6CIUMpFt7lClsNf5WkZxiL41emF5hIIzgbI82zNPcubfwP2ZcJc9SHJ7
         QOXzF2p5wih7tlA+wCqGhR0sbcXPQZVO9BMe10mNM+OhIG9BAjICICEStMJA0HeXCIls
         HPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kURCqWE8pomFkfYFiXr4O15/fAJHColFs2BDAs5/sSY=;
        b=eXUOY8cKN3+a1xuX3W2PUhGikfdRBmjOe8RaJNI4N1J4lQFbVWsIF7lLAPszxEruSX
         Pi3GQnoEO/VcXzkPifPqHs3rkN/vxU6d0/80rohXwAWM2p19oUeUdv8lgJ72of5aMz+W
         a+1T3j1aNGUH0fSRQgf7yXhlzpe2d9vES++RnrR0ti2g7KmnE2fzvgRpm50i2D9c6UtI
         rQG/4oAasvmqr2HcUHdc8tZRFuxK50zr5tgdKf6Chfn+71sRjrjbQcs/DJnJMpcW3Cu0
         yiTfDEvlbOzB/MamnM3puXq8vSZGOGC6ZI8ezisE4WAGUcVr2oBwctS6a0XuzHAlYgoE
         bvBQ==
X-Gm-Message-State: AOAM5334AIRwtnGYFQzvWAptMZNjunGNQGnHHXPLrCTZwcWAXRfqebtm
        ewqd/ABu/QSv3cODkGBmp/c=
X-Google-Smtp-Source: ABdhPJw+7iaYzPWSZQx3m2FbTZmDAGdYmIThnu0ups3wQnpV0ymEdmrs+11yOe3CNNLF+7H6a6WQwQ==
X-Received: by 2002:adf:dd8a:0:b0:207:9e5f:fd0a with SMTP id x10-20020adfdd8a000000b002079e5ffd0amr9290217wrl.94.1649691639887;
        Mon, 11 Apr 2022 08:40:39 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm4710207wrq.81.2022.04.11.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:40:39 -0700 (PDT)
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
Subject: Re: [PATCH 05/10] drm/sun4i: csc: Add support for the new MMIO layout
Date:   Mon, 11 Apr 2022 17:40:38 +0200
Message-ID: <21425699.EfDdHjke4D@kista>
In-Reply-To: <20220411043423.37333-6-samuel@sholland.org>
References: <20220411043423.37333-1-samuel@sholland.org> <20220411043423.37333-6-samuel@sholland.org>
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

Dne ponedeljek, 11. april 2022 ob 06:34:17 CEST je Samuel Holland napisal(a):
> D1 changes the MMIO address offset for the CSC blocks in the first
> mixer. The ccsc field value is used as an index into the ccsc_base
> array; allocate the next available value to represent the new variant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/gpu/drm/sun4i/sun8i_csc.c   | 3 ++-
>  drivers/gpu/drm/sun4i/sun8i_csc.h   | 1 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.h | 6 ++++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.c b/drivers/gpu/drm/sun4i/
sun8i_csc.c
> index 9bd62de0c288..1ed10c6447a3 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_csc.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_csc.c
> @@ -8,9 +8,10 @@
>  #include "sun8i_csc.h"
>  #include "sun8i_mixer.h"
>  
> -static const u32 ccsc_base[2][2] = {
> +static const u32 ccsc_base[][2] = {
>  	{CCSC00_OFFSET, CCSC01_OFFSET},
>  	{CCSC10_OFFSET, CCSC11_OFFSET},
> +	{CCSC00_OFFSET, CCSC01_OFFSET_D1},
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/sun4i/sun8i_csc.h b/drivers/gpu/drm/sun4i/
sun8i_csc.h
> index 022cafa6c06c..bd54166b2bcc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_csc.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_csc.h
> @@ -13,6 +13,7 @@ struct sun8i_mixer;
>  /* VI channel CSC units offsets */
>  #define CCSC00_OFFSET 0xAA050
>  #define CCSC01_OFFSET 0xFA050
> +#define CCSC01_OFFSET_D1 0xFA000
>  #define CCSC10_OFFSET 0xA0000
>  #define CCSC11_OFFSET 0xF0000
>  
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/
sun8i_mixer.h
> index 5b3fbee18671..22f1b7ef9225 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -151,8 +151,10 @@
>   *	scaler and 2 UI channels with scaler, bitmask would be 0xC.
>   * @ccsc: select set of CCSC base addresses
>   *	Set value to 0 if this is first mixer or second mixer with VEP 
support.
> - *	Set value to 1 if this is second mixer without VEP support. Other 
values
> - *	are invalid.
> + *	Set value to 1 if this is second mixer without VEP support.
> + *	Set value to 2 if this is first mixer or second mixer with VEP 
support,
> + *	and the SoC uses the MMIO layout found in the D1 SoC.
> + *	Other values are invalid.

It would be better to introduce some kind of enum. Number 2 is completely 
arbitrary.

Best regards,
Jernej

>   * @mod_rate: module clock rate that needs to be set in order to have
>   *	a functional block.
>   * @is_de3: true, if this is next gen display engine 3.0, false otherwise.
> -- 
> 2.35.1
> 
> 


