Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7257A216
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiGSOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbiGSOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:44:11 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Jul 2022 07:42:38 PDT
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4BAFCB;
        Tue, 19 Jul 2022 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2ud6nsluqSsKTO9Z0i1MLYe01IcSu66ta8TyQvTI8QI=; b=FDYK2qx4o9VfiSKX4kjtfYaK5d
        CuD34rsqF62M3zMoNqL8juQGVRzEcrLAIraI4aeB1HMVVtlyYKga86QnXJOREm7oSq+j0WLFtD5Zs
        L5HyL2l1RuRLjJbrhHNW3oUF8ytDTnYjhBi9Rc0DN5VoIAugUh0iSrq2O/crqeBL2OmO2s6ELWB1h
        N9V3Gtd5kfj8uZT9etsQ6MMoAAsvk5S9KgTe3dJIFW9Mn4Aib7nsPrlfA5kzNA99tTpoiCuWOkxAm
        afxAmnw+oCgm/4cViLsIstPfylUadQt6qYCFWW4woG80X02NwBHp15NZRPIaA/hSwMPugvNka1r+L
        OVQXiPnA==;
Received: from [2a01:799:961:d200:4408:c06b:bee8:b0a3] (port=52255)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oDoO6-0003Mu-Dz; Tue, 19 Jul 2022 16:39:50 +0200
Message-ID: <59b18586-f53f-9ad3-02a7-d629e4c19b81@tronnes.org>
Date:   Tue, 19 Jul 2022 16:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/gud: Fix endianness in gud_xrgb8888_to_color()
 helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1657300532.git.geert@linux-m68k.org>
 <b47589ed5d8ca44e0956684412e3f16f3227f887.1657300532.git.geert@linux-m68k.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <b47589ed5d8ca44e0956684412e3f16f3227f887.1657300532.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 08.07.2022 20.21, skrev Geert Uytterhoeven:
> DRM formats are defined to be little-endian, unless the
> DRM_FORMAT_BIG_ENDIAN flag is set.  Hence when converting from one
> format to another, multi-byte pixel values loaded from memory must be
> converted from little-endian to host-endian.  Conversely, multi-byte
> pixel values written to memory must be converted from host-endian to
> little-endian.  Currently only drm_fb_xrgb8888_to_rgb332_line() includes
> endianness handling.
> 
> Fix gud_xrgb8888_to_color() on big-endian platforms by adding the
> missing endianness handling.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.
> 
> Interestingly, drm_fb_xrgb8888_to_rgb332() was introduced for GUD,
> and always had correct endiannes handling...

RGB332 support was added later and by that time I had understood that
the framebuffer was little endian and not host endian as I first assumed
(there's a fixme comment in gud_pipe.c that BE is probably broken but I
haven't got any hw to test on so I haven't tried to fix it).

Thanks for fixing this, pathces 2 and 3 tested on drm/gud and applied to
drm-misc-next.

Noralf.

> ---
>  drivers/gpu/drm/gud/gud_pipe.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 4873f9799f412e04..d42592f6daab8b2a 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -105,7 +105,8 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
>  	unsigned int bits_per_pixel = 8 / block_width;
>  	u8 r, g, b, pix, *block = dst; /* Assign to silence compiler warning */
>  	unsigned int x, y, width;
> -	u32 *pix32;
> +	__le32 *sbuf32;
> +	u32 pix32;
>  	size_t len;
>  
>  	/* Start on a byte boundary */
> @@ -114,8 +115,8 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
>  	len = drm_format_info_min_pitch(format, 0, width) * drm_rect_height(rect);
>  
>  	for (y = rect->y1; y < rect->y2; y++) {
> -		pix32 = src + (y * fb->pitches[0]);
> -		pix32 += rect->x1;
> +		sbuf32 = src + (y * fb->pitches[0]);
> +		sbuf32 += rect->x1;
>  
>  		for (x = 0; x < width; x++) {
>  			unsigned int pixpos = x % block_width; /* within byte from the left */
> @@ -126,9 +127,10 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
>  				*block = 0;
>  			}
>  
> -			r = *pix32 >> 16;
> -			g = *pix32 >> 8;
> -			b = *pix32++;
> +			pix32 = le32_to_cpu(*sbuf32++);
> +			r = pix32 >> 16;
> +			g = pix32 >> 8;
> +			b = pix32;
>  
>  			switch (format->format) {
>  			case GUD_DRM_FORMAT_XRGB1111:
