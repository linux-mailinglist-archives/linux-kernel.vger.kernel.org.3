Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C04D2FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiCINLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCINLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7178104A44
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646831419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iAU44weXti04FLi2etjzVw+K+va7nBLkmB5FdNWAcI0=;
        b=Ciuwj6fWM1jqbyzxXo1RPRtJ0/v2aReVAEb140djTOujZbHUmvBy1uJAIkllfzh0GLWEcs
        PV6aR0BW0fgLGBSs/sjUwSVPw79JF3t5i0WhCWuxwWGON0yrTAUnK3TH1qp5O6nE2Mxsw9
        7RjZ44cdsetl7AUqT+yLvxetOpDt28o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-sMjWc_EYP5a9QBkGPYd2lQ-1; Wed, 09 Mar 2022 08:10:18 -0500
X-MC-Unique: sMjWc_EYP5a9QBkGPYd2lQ-1
Received: by mail-wr1-f72.google.com with SMTP id p18-20020adfba92000000b001e8f7697cc7so743594wrg.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAU44weXti04FLi2etjzVw+K+va7nBLkmB5FdNWAcI0=;
        b=Lo9XGGbSFiZGL3Wcqgj4kkZytEzdNL7SeQLVmukk5NQM2YcnquZhfZMXwLS2/1TjHr
         au+1QoCpqXdQAXv3K8djav3Kgzf07uh5zxZeQwnlvdr1SvRqBd+rLJm4jfBQEymo4Vt7
         A+pk+dTvB1t6Owqz0ubIfPLzVcRnv+sfla1a1y3ToCjTdFSf6NP/HSsT93eGrDgGzPSX
         Hxy+sZGzOjp/KaSFt1fkGXLEhqjKXCpsmvFSdhU+qctnnSFxopU3MumAN5gOlmkGk6WY
         FbYAmxhqbqrM2jfH5YIY8TO0YXYLUuufEcEUewlca+/zldfx1IL0FEQeQn4ucdmWTdAV
         1dBg==
X-Gm-Message-State: AOAM533qmusSHP9X0paUc+xMp1PO2gtDcDnP/G+KsN4I8RIiwIiKr44u
        Nt4sVhHgg2ELI3Eto7KeQoYbnCgQSKpPmjhvct/cBu3qkKKTox5SZ/AUZ97rnTsj+31Fn3WL8BY
        EJsHz1FjmwebJWEXLPl1g7CW5
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr15765175wru.212.1646831417442;
        Wed, 09 Mar 2022 05:10:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvX2Au00DweT17gWXJkTfHnd/3tQIRGysI0fVMgShhCARC1khCEjjWT3sGgGyIigEkQZnnNQ==
X-Received: by 2002:a5d:4dc5:0:b0:1f0:73e4:2cd9 with SMTP id f5-20020a5d4dc5000000b001f073e42cd9mr15765152wru.212.1646831417244;
        Wed, 09 Mar 2022 05:10:17 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm422698wry.78.2022.03.09.05.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:10:16 -0800 (PST)
Message-ID: <355f94c7-fc8a-7d92-5979-5b1b49c1d738@redhat.com>
Date:   Wed, 9 Mar 2022 14:10:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/10] drm/fb-helper: Add support for DRM_FORMAT_C[124]
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <c665d6ba072f3debb3fa0a139454fefef6a55011.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <c665d6ba072f3debb3fa0a139454fefef6a55011.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> Add support for color-indexed frame buffer formats with two, four, and
> sixteen colors to the DRM framebuffer helper functions:
>   1. Add support for 1, 2, and 4 bits per pixel to the damage helper,
>   2. For color-indexed modes, the length of the color bitfields must be
>      set to the color depth, else the logo code may pick a logo with too
>      many colors.  Drop the incorrect DAC width comment, which
>      originates from the i915 driver.
>   3. Accept C[124] modes when validating or filling in struct
>      fb_var_screeninfo, and use the correct number of bits per pixel.
>   4. Set the visual to FB_VISUAL_PSEUDOCOLOR for all color-indexed
>      modes.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

[snip]

>  static void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
> -				   uint32_t depth)
> +				   bool is_color_indexed)
>  {
>  	info->fix.type = FB_TYPE_PACKED_PIXELS;
> -	info->fix.visual = depth == 8 ? FB_VISUAL_PSEUDOCOLOR :
> -		FB_VISUAL_TRUECOLOR;
> +	info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
> +					    : info->fix.visual;

Shouldn't this be the following instead ?

  +	info->fix.visual = is_color_indexed ? FB_VISUAL_PSEUDOCOLOR
  +					    : FB_VISUAL_TRUECOLOR;

Other than that the patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

