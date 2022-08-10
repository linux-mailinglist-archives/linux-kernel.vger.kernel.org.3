Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66E358EB86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiHJLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHJLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:51:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505F26C770
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:51:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so17504542wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=LDfEYb5ujn1T+y8ZdrYflg44hRzKk8763KEYo/Jqooc=;
        b=VsfOftKCJHPLqJmZsbYKzFsC5wiVuqV/8JCiYAVptPF/YYd4ipgoyhzI0tuqldHgzH
         Ha0LF8Pybi7f5hyNzZO0APTqTQNuLpyB6F/dytyZsNhJNqrIqH+9NgHgqta8zn5/fan6
         gFqzx8Yco8TA6ivlfRBarvt+OEzZ4TOS10urY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=LDfEYb5ujn1T+y8ZdrYflg44hRzKk8763KEYo/Jqooc=;
        b=UTZeVJNYUuUdhPzy0KALJVyXT5aT28ZlcisGk63i+CEGF9Xm/rcWfvTCPEDHGIF/kU
         pOUv/5BW4sfXZanrg/n9dMu7NwFjEd4X8k60IygH68gOfPxTz+rbPqR17sDWR7s7/Ucd
         8SXsM9H88TNfaqjLNKCbYL5skh4aheztbCLjSU6Hr+Tm9+vN8v6UKetlNWZige9C6D55
         LaFeJUDa5vhgHH4kXdHHbqaXkZUiqN91v+SejjBEq6oG+m+hZk+mGMJydOxONDBJdUT2
         SLmCVbytkk0ggNm5ml/XUResVY2RSQq+QnbuUQZ/hyz4TE2NOK0JgUbeJEZHzRIdrDp7
         A+rA==
X-Gm-Message-State: ACgBeo3sJkWnJmzsUi+ZjaKfwh4lj2ZHeACGzV+hsYKkkau1tHO6VyX2
        qCQlmhBRBn7l/UYDiOKePLq49Q==
X-Google-Smtp-Source: AA6agR5l9QMtWYfltZKz7qPF62egv4G39OHczeBaxjZ9CRWiL1TB75raui6OQT3z6KcXev2/EWNGFw==
X-Received: by 2002:a05:6000:61c:b0:220:6425:c113 with SMTP id bn28-20020a056000061c00b002206425c113mr17742344wrb.612.1660132282843;
        Wed, 10 Aug 2022 04:51:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b0021edb2d07bbsm15588661wrn.33.2022.08.10.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:51:22 -0700 (PDT)
Date:   Wed, 10 Aug 2022 13:51:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        gustavo@padovan.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linaro-mm-sig] [PATCH] dma-buf/sync_file: use strscpy to
 replace strlcpy
Message-ID: <YvObuLevnEWEITnS@phenom.ffwll.local>
Mail-Followup-To: XueBing Chen <chenxuebing@jari.cn>,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        gustavo@padovan.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <6aad3bff.d1a.181b982d1b1.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aad3bff.d1a.181b982d1b1.Coremail.chenxuebing@jari.cn>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 07:26:07PM +0800, XueBing Chen wrote:
> 
> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.
> 
> Signed-off-by: XueBing Chen <chenxuebing@jari.cn>

I don't think there's an impact here since we don't check the error return
value, but also doesn't hurt.

Thanks for your patch, applied to drm-misc-next.
-Daniel

> ---
>  drivers/dma-buf/sync_file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> index 3ebec19a8e02..af57799c86ce 100644
> --- a/drivers/dma-buf/sync_file.c
> +++ b/drivers/dma-buf/sync_file.c
> @@ -132,7 +132,7 @@ EXPORT_SYMBOL(sync_file_get_fence);
>  char *sync_file_get_name(struct sync_file *sync_file, char *buf, int len)
>  {
>  	if (sync_file->user_name[0]) {
> -		strlcpy(buf, sync_file->user_name, len);
> +		strscpy(buf, sync_file->user_name, len);
>  	} else {
>  		struct dma_fence *fence = sync_file->fence;
>  
> @@ -172,7 +172,7 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
>  		return NULL;
>  	}
>  	sync_file->fence = fence;
> -	strlcpy(sync_file->user_name, name, sizeof(sync_file->user_name));
> +	strscpy(sync_file->user_name, name, sizeof(sync_file->user_name));
>  	return sync_file;
>  }
>  
> @@ -262,9 +262,9 @@ static long sync_file_ioctl_merge(struct sync_file *sync_file,
>  static int sync_fill_fence_info(struct dma_fence *fence,
>  				 struct sync_fence_info *info)
>  {
> -	strlcpy(info->obj_name, fence->ops->get_timeline_name(fence),
> +	strscpy(info->obj_name, fence->ops->get_timeline_name(fence),
>  		sizeof(info->obj_name));
> -	strlcpy(info->driver_name, fence->ops->get_driver_name(fence),
> +	strscpy(info->driver_name, fence->ops->get_driver_name(fence),
>  		sizeof(info->driver_name));
>  
>  	info->status = dma_fence_get_status(fence);
> -- 
> 2.25.1
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
