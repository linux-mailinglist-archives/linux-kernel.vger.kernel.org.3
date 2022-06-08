Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262B5432B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiFHOg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbiFHOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:36:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2691562
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:36:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d14so19645958wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=khBUE53X9QuO6dWoSeEXJmXd2fMLigTEjdoQDhHw9mU=;
        b=Zygb11Po3xDFIHW2f+svcZVUL+ZvG2ZRBoGgdGzKTr0Kbk0U0KLEHUhPGDjn9UDod4
         8YdMOQoEFnHaWsA9c5BtdfJEyOk8qA79OEExEabcm92kdN2REqzYhAYxAIChyKgBKBJv
         xrbalNL9qXh0cL+SlrXMWypEq4ZFjxKCenwUsuTr/6K5Z+dSWKaDcVR/mNHdUZzcM5Lz
         68FzKB6yp9pt75OTd1dPBnsuNgW7aiCn7Nk2BfEaBgWn9U1tT+btkuzh3xO0izONkRPh
         WLU3dkz0/JaRYem8VX/l+AWseou10xPiimxGawgdHEPTjDJunaaRhJf58Y6PIua/vQAk
         z0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khBUE53X9QuO6dWoSeEXJmXd2fMLigTEjdoQDhHw9mU=;
        b=4ww+dDC852JkmF1r5XRfOVvAywFEAt0sqPHAWZHBWoXc665HUEldJIjouRuz+GIHZ3
         Puxlwwi48es2oqHEO0lZz50sNuRAySCEF9F1jMGjCRjSqY+eT543tspAwF9M5cBHBIxa
         8izyen5NjBFfbEp6d3KDC1ehcn/tXnlyYdLJGuCaW+j+Ykj7C+71zV4FWpqsmj2Nb2Aj
         3+2mksOriid/Z1VZa+g1FLxPBozQwhRZZY/u+wcHElrnU7oNdM/yhJ4FWM8WriMVDbvL
         OZ4Rp3Fw/5PlburKp5b9D8kEfsux0mEChqs2mYf2ZicH6E5fvwkueOXGBPtojy7pKBWz
         8isQ==
X-Gm-Message-State: AOAM531BQN1pfZC6TRpxju9LopTwHKYRQvdHC4Ffz+nX/cpRDcVVOjE0
        IQ3hq73pluYUvFVp/rGV8ejAiw==
X-Google-Smtp-Source: ABdhPJyihLbbU649/VAE29N/msO4G2EkXgHbveOzoAedQSvWja/dqHMy6G3ndT8k+NvEQCDLvtz6Vg==
X-Received: by 2002:a5d:6d8b:0:b0:218:4de1:25a0 with SMTP id l11-20020a5d6d8b000000b002184de125a0mr10508544wrs.8.1654699005239;
        Wed, 08 Jun 2022 07:36:45 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b0020c5253d8fcsm21942007wrv.72.2022.06.08.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:36:44 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:36:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] backlight: tosa: Use backlight helper
Message-ID: <20220608143643.km7eainfqvttuoqe@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-5-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:25PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

... and, wowzer, the code before your change wasn't much fun to read!


>  static int tosa_bl_update_status(struct backlight_device *dev)
>  {
> -	struct backlight_properties *props = &dev->props;
>  	struct tosa_bl_data *data = bl_get_data(dev);
> -	int power = max(props->power, props->fb_blank);
> -	int brightness = props->brightness;
> -
> -	if (power)
> -		brightness = 0;
> +	int brightness = backlight_get_brightness(dev);
>  
>  	tosa_bl_set_backlight(data, brightness);


Daniel.
