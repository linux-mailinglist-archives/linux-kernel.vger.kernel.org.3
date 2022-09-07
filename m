Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87ED5AFCF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIGG7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIGG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:59:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9678A0332
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:58:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b16so18295172edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=2gNmFVx2TEGLFSa4zBsixSZnh9eQ9z4yWeNaVxeeK4g=;
        b=W21X+LhexAUdAxr0oCHGTu0WjIq9/9ifNfTdMem+fhK3ovuwekY+R+r90ao/dkY7Sj
         P0zLYZpzxzk9eXKsS+UJ98ZBJThUTvpxzz3LE7umfDyr2DGmyZqnjfkUxeaFsbHZRg4R
         1csIwITrYbgJBed3YN+F5CraQ27nrZ+BOGAgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2gNmFVx2TEGLFSa4zBsixSZnh9eQ9z4yWeNaVxeeK4g=;
        b=54ZRXK5c83aYf/mbYJp4Zr36J51RYUzGbIy6wFBY6S75QDVhyeWpLgEGBVhInvDrEb
         RX8PnDjCPylG9ji47TK16+pwPeXu7GVq9crjmisdhSYVGUPxq3IZ7G3/Z+b01rR/BiR+
         sCEC5g5VU9zoL7XhPkTYWp3kAWdTUxs2N/t/6Lp9vcwLDza9ZuDwIprD6ZtneYlbCl6v
         rHk+h6qtjcif9F7QbT5RTcj57bb2zD9x2ISH69vtmxQDcVOB2RKpx+ObWWSNGb71SxxY
         JxJcOD5yOte2qMfXbUACDOo3leHs+uNrxdQgFzfeVxD5msnQpfoy5tdob7j8UGGOQxBU
         9b6A==
X-Gm-Message-State: ACgBeo10w21Ky0NYt8VI+RwZOmVMxCBSVjfipxtuqPArJI7WgKhj7KEG
        h3o/Z4VllhYmzL6/gwgCsk/ZtPV4nnR+VQ==
X-Google-Smtp-Source: AA6agR6Bvdxs9YoqSNE/Ldg1MqBjgM4kjkwuFObt3RQhUXcm4Ke86+QgppVIrbZOW1cascVYGteqjA==
X-Received: by 2002:aa7:dc13:0:b0:443:3f15:8440 with SMTP id b19-20020aa7dc13000000b004433f158440mr1808846edu.274.1662533935396;
        Tue, 06 Sep 2022 23:58:55 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id t25-20020aa7db19000000b0044e7c20d7a9sm5849339eds.37.2022.09.06.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:58:54 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:58:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 02/11] drm/udl: Add reset_resume
Message-ID: <YxhBLVyRmeUcxPIj@phenom.ffwll.local>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220906073951.2085-1-tiwai@suse.de>
 <20220906073951.2085-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906073951.2085-3-tiwai@suse.de>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:39:42AM +0200, Takashi Iwai wrote:
> From: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Implement the reset_resume callback of struct usb_driver. Set the
> standard channel when called.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_drv.c  | 11 +++++++++++
>  drivers/gpu/drm/udl/udl_drv.h  |  1 +
>  drivers/gpu/drm/udl/udl_main.c |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> index 5703277c6f52..0ba88e5472a9 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c
> @@ -32,6 +32,16 @@ static int udl_usb_resume(struct usb_interface *interface)
>  	return drm_mode_config_helper_resume(dev);
>  }
>  
> +static int udl_usb_reset_resume(struct usb_interface *interface)
> +{
> +	struct drm_device *dev = usb_get_intfdata(interface);
> +	struct udl_device *udl = to_udl(dev);
> +
> +	udl_select_std_channel(udl);
> +
> +	return drm_mode_config_helper_resume(dev);

Bit a bikeshed, but in the driver load case it would be neat to put the
call to udl_select_std_channel right above the call to
drm_mode_config_reset. But that is _really_ a bikeshed :-)

Also thanks for sending me on a bit a wild goose chase trying to figure
out what this reset_resume hook actually does and why.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +}
> +
>  /*
>   * FIXME: Dma-buf sharing requires DMA support by the importing device.
>   *        This function is a workaround to make USB devices work as well.
> @@ -140,6 +150,7 @@ static struct usb_driver udl_driver = {
>  	.disconnect = udl_usb_disconnect,
>  	.suspend = udl_usb_suspend,
>  	.resume = udl_usb_resume,
> +	.reset_resume = udl_usb_reset_resume,
>  	.id_table = id_table,
>  };
>  module_usb_driver(udl_driver);
> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> index 28aaf75d71cf..37c14b0ff1fc 100644
> --- a/drivers/gpu/drm/udl/udl_drv.h
> +++ b/drivers/gpu/drm/udl/udl_drv.h
> @@ -95,6 +95,7 @@ int udl_render_hline(struct drm_device *dev, int log_bpp, struct urb **urb_ptr,
>  		     u32 byte_offset, u32 device_byte_offset, u32 byte_width);
>  
>  int udl_drop_usb(struct drm_device *dev);
> +int udl_select_std_channel(struct udl_device *udl);
>  
>  #define CMD_WRITE_RAW8   "\xAF\x60" /**< 8 bit raw write command. */
>  #define CMD_WRITE_RL8    "\xAF\x61" /**< 8 bit run length command. */
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index fdafbf8f3c3c..7d1e6bbc165c 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -92,7 +92,7 @@ static int udl_parse_vendor_descriptor(struct udl_device *udl)
>  /*
>   * Need to ensure a channel is selected before submitting URBs
>   */
> -static int udl_select_std_channel(struct udl_device *udl)
> +int udl_select_std_channel(struct udl_device *udl)
>  {
>  	static const u8 set_def_chn[] = {0x57, 0xCD, 0xDC, 0xA7,
>  					 0x1C, 0x88, 0x5E, 0x15,
> -- 
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
