Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE155A36F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiFXVYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFXVYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:24:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA45965A1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:24:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id f190so1700792wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=TY91t5mhlKD7MYp01AMZisxRF/RKLLy+kI9Ftq5Wnag=;
        b=YvvOOru75EsrbxRoKjDVHf9dUfSjLWGxSW87AyemI3U2kkeJBQ7wSduAOnaivCINNs
         ChyRlmg5R5lBl5fE4q+CJ6Eryqn0tySMqLbAHATizCoG8VFT9ZVTMQGsjjFkMBoF4o1x
         4KGUPbt5ZGIe4Ijj/fST6nHbcj8Xs7Q+mx8Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=TY91t5mhlKD7MYp01AMZisxRF/RKLLy+kI9Ftq5Wnag=;
        b=oDC2OLd0KPZvSAqZfYUu/zKx280uVutSgRQyo9tdcqfAFsAckSMRfUrVu53/tl9ZhB
         B1NGySRz5hjpAbzS1Q2CeTZkeFpLgrNi5o34VpUZ89C2xTvX/ARbd74c8+x6+uiG49jU
         7NWyrnabuUAftRd7MLuXFCz7YrbVuFMX/CYNAg5S/SVI2BnusALMhXW9W+TeBr7604Y1
         bXEY+yrkix9XAi6975OfvpbrCMTBz32QFIhQnGCe1Oh0ZRSOQt02rstg8ehvxkp29z3l
         3kT8yRGANMxIcYUb+J3qb6XJFRU/CrjlFTXYOzdnReiCO5AHrQSKvbNe6St1rvOddE1v
         PMzg==
X-Gm-Message-State: AJIora8pUdp7318De0bOSD3lx5ESdKYd4qGqdLHbo5/LMQ6AIXVGwGvU
        zLhAjBlt65B9GWj6cjuDFye1y8ialaAuow==
X-Google-Smtp-Source: AGRyM1vWoThmCT79q08CiCtAnf+ERQGsRYLjLU8PdRFr7HsfPedccZ72xqljT6mBV/LP3zhTiRvtjQ==
X-Received: by 2002:a05:600c:4f14:b0:39c:8612:a95e with SMTP id l20-20020a05600c4f1400b0039c8612a95emr5845716wmq.107.1656105855357;
        Fri, 24 Jun 2022 14:24:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b003a02f957245sm8248663wmq.26.2022.06.24.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 14:24:14 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:24:12 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bo Liu <liubo03@inspur.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: Remove usage of the deprecated
 ida_simple_xxx API
Message-ID: <YrYrfPkSLNjS5CqW@phenom.ffwll.local>
Mail-Followup-To: Bo Liu <liubo03@inspur.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220617082319.7599-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617082319.7599-1-liubo03@inspur.com>
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

On Fri, Jun 17, 2022 at 04:23:19AM -0400, Bo Liu wrote:
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Thanks for your patch, applied to drm-misc-next.
-Daniel
> ---
>  drivers/gpu/drm/drm_connector.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 1c48d162c77e..cfba71724f84 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -250,7 +250,7 @@ int drm_connector_init(struct drm_device *dev,
>  	connector->funcs = funcs;
>  
>  	/* connector index is used with 32bit bitmasks */
> -	ret = ida_simple_get(&config->connector_ida, 0, 32, GFP_KERNEL);
> +	ret = ida_alloc_max(&config->connector_ida, 31, GFP_KERNEL);
>  	if (ret < 0) {
>  		DRM_DEBUG_KMS("Failed to allocate %s connector index: %d\n",
>  			      drm_connector_enum_list[connector_type].name,
> @@ -262,7 +262,7 @@ int drm_connector_init(struct drm_device *dev,
>  
>  	connector->connector_type = connector_type;
>  	connector->connector_type_id =
> -		ida_simple_get(connector_ida, 1, 0, GFP_KERNEL);
> +		ida_alloc_min(connector_ida, 1, GFP_KERNEL);
>  	if (connector->connector_type_id < 0) {
>  		ret = connector->connector_type_id;
>  		goto out_put_id;
> @@ -322,10 +322,10 @@ int drm_connector_init(struct drm_device *dev,
>  	connector->debugfs_entry = NULL;
>  out_put_type_id:
>  	if (ret)
> -		ida_simple_remove(connector_ida, connector->connector_type_id);
> +		ida_free(connector_ida, connector->connector_type_id);
>  out_put_id:
>  	if (ret)
> -		ida_simple_remove(&config->connector_ida, connector->index);
> +		ida_free(&config->connector_ida, connector->index);
>  out_put:
>  	if (ret)
>  		drm_mode_object_unregister(dev, &connector->base);
> @@ -479,11 +479,10 @@ void drm_connector_cleanup(struct drm_connector *connector)
>  	list_for_each_entry_safe(mode, t, &connector->modes, head)
>  		drm_mode_remove(connector, mode);
>  
> -	ida_simple_remove(&drm_connector_enum_list[connector->connector_type].ida,
> +	ida_free(&drm_connector_enum_list[connector->connector_type].ida,
>  			  connector->connector_type_id);
>  
> -	ida_simple_remove(&dev->mode_config.connector_ida,
> -			  connector->index);
> +	ida_free(&dev->mode_config.connector_ida, connector->index);
>  
>  	kfree(connector->display_info.bus_formats);
>  	drm_mode_object_unregister(dev, &connector->base);
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
