Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC603591EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbiHNHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiHNHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:55:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E176AE6E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:55:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so6117126edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4w/IYgas/KEaZkPoBOHl3Ktyf22rgljFAdRahUvKw0Q=;
        b=UaWwx7RnKoZFY+QQJBrqa+xaqrw/tCuv3/g+xWnkqhFoJGTh69vG0NArr2XQRv8x+p
         +EBxr2Zk3u9+qZb3Se2Q5tvrdwUuLjHTVQgRuqM4hXkSYULVUasoVlq+ndPaPdTlvr1n
         UUjJQxboMElsZjt22ig/3PHvYoaB+UwaUxzAG6E0u3ysPcHCmCM5qh4Rni21oT7HSWVw
         Bf1QfjxPo+ZQYix7mT8680yEBF34q12q9tjJdNlVJDeg+PMzkW7o+e5hI6Vi9Tk9Ml0R
         /yuLOWaqGJwIsnLDi3g4+E6sXV2s8AXRUAmBDbwlsGGQnzqS4u63yFQaKzdH7A+5HG39
         tB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4w/IYgas/KEaZkPoBOHl3Ktyf22rgljFAdRahUvKw0Q=;
        b=JPPkCjcnXSlFTQE2b/qKxXdn/XcNjuzL1ghtTcD3/uHoK3s+Th2RviMyc+jN/ekvbw
         wpAiVZJ7leurPjhS3JkzkNDmhNHDg7tTepXONOWGfIjzd4TK0Zlt5iWUwioWE5zV64qB
         ZYF4E2cKJLLm+arg5ghpO6YWFjrWt7fo1MpxJqCA1EBa/+0klrA9ZrgRyNzBrvqWn0cU
         Q6HYQxl01iGaolmQH7ePS7hYVc9NGzfjDPW6hUx/hR1jd0FFUeqh1d/pmij17mADntCT
         xL41JLBt2lS6+tj0QcupCZYyWB73IYoSw3TTpRvdxLxArD9inWrnz4foBAyc68vzACLX
         6u7w==
X-Gm-Message-State: ACgBeo0RO8nhhx5Qa491kH/9Cui5r62/WB2zNi9p6runsAEQWxr+cBIA
        d2XGFaATPbjXenRsZt++7wA=
X-Google-Smtp-Source: AA6agR4LrdbCnhUUan6ufYrpIzRk/yYg41zWcRstMORxRKeVEKoCnJr0E5pWZQnEgn8DdH/0WeSdaA==
X-Received: by 2002:a05:6402:27c6:b0:43d:6fab:146e with SMTP id c6-20020a05640227c600b0043d6fab146emr10006225ede.376.1660463715968;
        Sun, 14 Aug 2022 00:55:15 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7d482000000b0043a6df72c11sm4279953edr.63.2022.08.14.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 00:55:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: dsi: Prevent underflow when computing packet sizes
Date:   Sun, 14 Aug 2022 09:55:14 +0200
Message-ID: <8100632.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20220812031623.34057-1-samuel@sholland.org>
References: <20220812031623.34057-1-samuel@sholland.org>
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

Dne petek, 12. avgust 2022 ob 05:16:23 CEST je Samuel Holland napisal(a):
> Currently, the packet overhead is subtracted using unsigned arithmetic.
> With a short sync pulse, this could underflow and wrap around to near
> the maximal u16 value. Fix this by using signed subtraction. The call to
> max() will correctly handle any negative numbers that are produced.
> 
> Apply the same fix to the other timings, even though those subtractions
> are less likely to underflow.
> 
> Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller
> support") Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c index b4dfa166eccd..34234a144e87
> 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -522,77 +522,77 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi
> *dsi, SUN6I_DSI_PIXEL_PF1_CRC_INIT_LINE0(0xffff) |
>  		     SUN6I_DSI_PIXEL_PF1_CRC_INIT_LINEN(0xffff));
> 
>  	regmap_write(dsi->regs, SUN6I_DSI_PIXEL_CTL0_REG,
>  		     SUN6I_DSI_PIXEL_CTL0_PD_PLUG_DISABLE |
>  		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
>  }
> 
>  static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  				    struct drm_display_mode 
*mode)
>  {
>  	struct mipi_dsi_device *device = dsi->device;
> -	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 
8;
> +	int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;

Nit: mipi_dsi_pixel_format_to_bpp() can return -EINVAL in case of unsupported 
format. Would it make sense to check it?

In any case:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  	u16 hbp = 0, hfp = 0, hsa = 0, hblk = 0, vblk = 0;
>  	u32 basic_ctl = 0;
>  	size_t bytes;
>  	u8 *buffer;
> 
>  	/* Do all timing calculations up front to allocate buffer space */
> 
>  	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
>  		hblk = mode->hdisplay * Bpp;
>  		basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
>  			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
>  			    SUN6I_DSI_BASIC_CTL_HBP_DIS;
> 
>  		if (device->lanes == 4)
>  			basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL 
|
>  				     
SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
>  	} else {
>  		/*
>  		 * A sync period is composed of a blanking packet (4
>  		 * bytes + payload + 2 bytes) and a sync event packet
>  		 * (4 bytes). Its minimal size is therefore 10 bytes
>  		 */
>  #define HSA_PACKET_OVERHEAD	10
> -		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
> +		hsa = max(HSA_PACKET_OVERHEAD,
>  			  (mode->hsync_end - mode->hsync_start) * 
Bpp - HSA_PACKET_OVERHEAD);
> 
>  		/*
>  		 * The backporch is set using a blanking packet (4
>  		 * bytes + payload + 2 bytes). Its minimal size is
>  		 * therefore 6 bytes
>  		 */
>  #define HBP_PACKET_OVERHEAD	6
> -		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
> +		hbp = max(HBP_PACKET_OVERHEAD,
>  			  (mode->htotal - mode->hsync_end) * Bpp - 
HBP_PACKET_OVERHEAD);
> 
>  		/*
>  		 * The frontporch is set using a sync event (4 bytes)
>  		 * and two blanking packets (each one is 4 bytes +
>  		 * payload + 2 bytes). Its minimal size is therefore
>  		 * 16 bytes
>  		 */
>  #define HFP_PACKET_OVERHEAD	16
> -		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
> +		hfp = max(HFP_PACKET_OVERHEAD,
>  			  (mode->hsync_start - mode->hdisplay) * Bpp 
- HFP_PACKET_OVERHEAD);
> 
>  		/*
>  		 * The blanking is set using a sync event (4 bytes)
>  		 * and a blanking packet (4 bytes + payload + 2
>  		 * bytes). Its minimal size is therefore 10 bytes.
>  		 */
>  #define HBLK_PACKET_OVERHEAD	10
> -		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
> +		hblk = max(HBLK_PACKET_OVERHEAD,
>  			   (mode->htotal - (mode->hsync_end - mode-
>hsync_start)) * Bpp -
>  			   HBLK_PACKET_OVERHEAD);
> 
>  		/*
>  		 * And I'm not entirely sure what vblk is about. The 
driver in
>  		 * Allwinner BSP is using a rather convoluted 
calculation
>  		 * there only for 4 lanes. However, using 0 (the !4 
lanes
>  		 * case) even with a 4 lanes screen seems to work...
>  		 */
>  		vblk = 0;
>  	}




