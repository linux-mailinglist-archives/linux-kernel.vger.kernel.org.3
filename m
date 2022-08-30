Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D0A5A6C52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH3ShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiH3ShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:37:02 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4B6FA08
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jpEYN07ng1p1k4JMUOjV6laIOSRv7F+n3Ots9iXgaiI=; b=P5mpqSBO2bmeMCABz1L/7uZ1rK
        KXueoPKIqk3NZ/awAOvafdjGp/1wJnjdkkxFIcDfuVZWVFeyrdvtdinB23o/BX1y3uNPmPrcq+U+4
        4u+p8NTm8pomQcLkfRhAYNp2J2QbywiIoQEEGpfTZOtAxsfvA9baPJwO3xplisnqFXdXZEP5GE5W2
        CKOqzs1/u9hN6RU0gp3IeYL7JIYUvlI7b8vjIhCYipEyxo960qBRd7XTSZmv4vt4eNRPbNKiQErGJ
        HQ3F9UJzCly7+02p26u/sjZ1OvXv/G0w5ZSOvV8CAjO92/jAJ87abobBMUPYEvEJbrShsdJ6NgX+l
        g1ayhYdA==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=62540)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oT66c-0006sf-4N; Tue, 30 Aug 2022 20:36:58 +0200
Message-ID: <24d5ee78-ccd1-1427-691b-152cb734a188@tronnes.org>
Date:   Tue, 30 Aug 2022 20:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 29/41] drm/vc4: vec: Switch for common modes
To:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-29-459522d653a7@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-29-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.08.2022 15.11, skrev Maxime Ripard:
> Now that the core has a definition for the 525 and 625 lines analog TV
> 
> modes, let's switch to it for vc4.
> 
> 
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> 
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> 
> index d1d40b69279e..63e4e617e321 100644
> 
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> 
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> 
> @@ -224,38 +224,24 @@ static const struct debugfs_reg32 vec_regs[] = {
> 
>  	VC4_REG32(VEC_DAC_MISC),
> 
>  };
> 
>  
> 
> -static const struct drm_display_mode ntsc_mode = {
> 
> -	DRM_MODE("720x480", DRM_MODE_TYPE_DRIVER, 13500,
> 
> -		 720, 720 + 14, 720 + 14 + 64, 720 + 14 + 64 + 60, 0,
> 
> -		 480, 480 + 7, 480 + 7 + 6, 525, 0,
> 
> -		 DRM_MODE_FLAG_INTERLACE)
> 
> -};
> 
> -
> 
> -static const struct drm_display_mode pal_mode = {
> 
> -	DRM_MODE("720x576", DRM_MODE_TYPE_DRIVER, 13500,
> 
> -		 720, 720 + 20, 720 + 20 + 64, 720 + 20 + 64 + 60, 0,
> 
> -		 576, 576 + 4, 576 + 4 + 6, 625, 0,
> 
> -		 DRM_MODE_FLAG_INTERLACE)
> 
> -};
> 
> -
> 
>  static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] = {
> 
>  	[VC4_VEC_TV_MODE_NTSC] = {
> 
> -		.mode = &ntsc_mode,
> 
> +		.mode = &drm_mode_480i,
> 

I can't find drm_mode_480i anywhere, maybe the compiler doesn't complain
since you remove the reference in a later patch?

Noralf.

>  		.config0 = VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN,
> 
>  		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
> 
>  	},
> 
>  	[VC4_VEC_TV_MODE_NTSC_J] = {
> 
> -		.mode = &ntsc_mode,
> 
> +		.mode = &drm_mode_480i,
> 
>  		.config0 = VEC_CONFIG0_NTSC_STD,
> 
>  		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
> 
>  	},
> 
>  	[VC4_VEC_TV_MODE_PAL] = {
> 
> -		.mode = &pal_mode,
> 
> +		.mode = &drm_mode_576i,
> 
>  		.config0 = VEC_CONFIG0_PAL_BDGHI_STD,
> 
>  		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
> 
>  	},
> 
>  	[VC4_VEC_TV_MODE_PAL_M] = {
> 
> -		.mode = &pal_mode,
> 
> +		.mode = &drm_mode_576i,
> 
>  		.config0 = VEC_CONFIG0_PAL_BDGHI_STD,
> 
>  		.config1 = VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
> 
>  		.custom_freq = 0x223b61d1,
> 
> 
> 
