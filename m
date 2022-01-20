Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9394956EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378286AbiATXW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbiATXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:22:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B17C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:22:13 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e28so2772670pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=egMwIptYpGbsC4XxY+2pETIXKwRmweD4aAOClQc8FOg=;
        b=j4GGCU1LW7aQgvrd+Lz43oPyrQTqCIyQoc6damDU85BEiX4EjPHox+J6XMEr6p37Ug
         FUVyNP5vcpMg6VQVjWSQsAXBlSyyHvX1azVDGc6U6R65pQjxW9MeXOI5KViTR8vEFY8o
         ANrlB37o2SeyYSXsKBblX32sWYT9tDRU319IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=egMwIptYpGbsC4XxY+2pETIXKwRmweD4aAOClQc8FOg=;
        b=0Qvrmx5LaPbIIQme/h/I5FHgrfB3fcg+ddtXTBPfSXfL8CaJgelgmWpWJ27aGfGtT5
         KjT7b5vNpUeAb6MT/3hlZ/5pxblkMT88vuSb97zIYCwBIfP61x3/mT7KwTM/odxVB8UK
         xtbbmAUxmKZskSrNH4sDm90sK+KugC+pu29B9G7ZdtjQh56nkblGe78y7sQITYKwaI5h
         nszd3huhsnCwewujvwEWFJT4WgPi0rZhb5STQUUD2HANO8UeTlhIy0nI1Ac6N+webhfC
         ATVV5/DXC5Aln13bttgz+Fa711Q6S1cdjzUqJMhZRe/iP86rPwbdK65Q8aAROIP9LdAn
         vmGQ==
X-Gm-Message-State: AOAM532Azmd4jaOXONvkP8lh+jwXuv6LZ7Zb5rQbXSyI2EdyFE/JzCsv
        tM4J/20ZwcKPYWDUWYJSvEksxg==
X-Google-Smtp-Source: ABdhPJym1c+5Elx/jqSx5/twwAq6/wX0UlB8jSjMP5BZBOA7fq0C2i3GvWJv84TUYMV6NEMTCS4VFg==
X-Received: by 2002:a63:1d7:: with SMTP id 206mr840156pgb.111.1642720932694;
        Thu, 20 Jan 2022 15:22:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm3202700pgj.41.2022.01.20.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:22:12 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:22:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] ALSA: usb-audio: scarlett2: Use struct_size()
 helper in scarlett2_usb()
Message-ID: <202201201522.5E744C15E9@keescook>
References: <20220120211600.GA28841@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120211600.GA28841@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:16:00PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> sound/usb/mixer_scarlett_gen2.c:1064:28: warning: using sizeof on a flexible structure
> sound/usb/mixer_scarlett_gen2.c:1065:29: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Changes in v2:
>  - Use correct format specifier %zu for type size_t argument.
> 
>  sound/usb/mixer_scarlett_gen2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
> index 53ebabf42472..7ff8a4817c67 100644
> --- a/sound/usb/mixer_scarlett_gen2.c
> +++ b/sound/usb/mixer_scarlett_gen2.c
> @@ -1061,9 +1061,9 @@ static int scarlett2_usb(
>  {
>  	struct scarlett2_data *private = mixer->private_data;
>  	struct usb_device *dev = mixer->chip->dev;
> -	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
> -	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
>  	struct scarlett2_usb_packet *req, *resp = NULL;
> +	size_t req_buf_size = struct_size(req, data, req_size);
> +	size_t resp_buf_size = struct_size(resp, data, resp_size);
>  	int err;
>  
>  	req = kmalloc(req_buf_size, GFP_KERNEL);
> @@ -1111,7 +1111,7 @@ static int scarlett2_usb(
>  		usb_audio_err(
>  			mixer->chip,
>  			"Scarlett Gen 2/3 USB response result cmd %x was %d "
> -			"expected %d\n",
> +			"expected %zu\n",
>  			cmd, err, resp_buf_size);
>  		err = -EINVAL;
>  		goto unlock;
> -- 
> 2.27.0
> 

-- 
Kees Cook
