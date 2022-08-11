Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC059046C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiHKQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbiHKQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:44:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93376AB4DA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:17:01 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a89so23598669edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=FKiZACvkKw9LJYBJ2h3jlaGgAsQU1bwnXLwRDR9yT3I=;
        b=CKb5yp5AlsHOzRnjW6gGGKOXnJHJFuoFfFWlOYaU+zjwicn+RgMPO4SmLrqrOTi2Ep
         zNC3p5ZCmouBZEqqCEHTpqpjfsJLyLKU90h6yE+U7CNoNRiOd1N7lRwUhUXlgQeVUlbc
         hLil7mpA+SEHHDIhGNsQkU1pfPKKLmBOGJH7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=FKiZACvkKw9LJYBJ2h3jlaGgAsQU1bwnXLwRDR9yT3I=;
        b=SrFcBFYHFYsDv1x9nNjvkXmbKznpr9pbX63PyZPu0t0Ld/rf5XOE6pV1JwNb67wtuI
         Wsnm4U0V0T93+eVsIa2AIKcrcZTyGhKgKXYXCpyePHjBz4pXGkajDeUPcyxNwq+allCZ
         rVQyuCCDERjnSCxwoFsnTR5I52EtHAzfqVrHdMqccXZJ/T+JuDDO9JQDGKuvWBcDV0jp
         wikJcG5/8+KmzYRnpoMxraGMTLV+n5oXOrTjw8hgmWRzYc61LScPSL1gNfxqC3ybfuiz
         6l0JnMrWk5Ybhb/Z4mnoZozodHxu/pioUFmHLyEapR2VlpDpLpR9dGTKiC9jLksWV3ni
         LIrg==
X-Gm-Message-State: ACgBeo2IC3UQPP7aS8c+9r4iE/Vu7mrDJlDzKsRDmtCdIRs5YayvapOd
        CjBW1GK0/oNcqDVnA6FzEsou2g==
X-Google-Smtp-Source: AA6agR4WXsL0j3WbG+fDyqOnb9nTbr1O3ieXgLW+b78d3bIIny4GyRZsyNatCGfGS9ZuSMQgwou8Dw==
X-Received: by 2002:aa7:db44:0:b0:43d:267c:edd9 with SMTP id n4-20020aa7db44000000b0043d267cedd9mr31885768edt.385.1660234619848;
        Thu, 11 Aug 2022 09:16:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o15-20020aa7dd4f000000b0043bba5ed21csm9261609edw.15.2022.08.11.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:16:58 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:16:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/virtio: kms: use drm managed resources
Message-ID: <YvUrefus4/EoCV2J@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@redhat.com>, airlied@linux.ie,
        kraxel@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220714130028.2127858-1-dakr@redhat.com>
 <20220714130028.2127858-3-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714130028.2127858-3-dakr@redhat.com>
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

On Thu, Jul 14, 2022 at 03:00:28PM +0200, Danilo Krummrich wrote:
> Allocate driver structures with drm managed resource allocators in order
> to cleanup/simplify the drm driver .release callback.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

On both patches:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm assuming you have commits rights or know someone who does :-)
-Daniel


> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 3313b92db531..63ebe63ef409 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -28,6 +28,7 @@
>  #include <linux/virtio_ring.h>
>  
>  #include <drm/drm_file.h>
> +#include <drm/drm_managed.h>
>  
>  #include "virtgpu_drv.h"
>  
> @@ -66,10 +67,11 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>  {
>  	int i, ret;
>  	bool invalid_capset_id = false;
> +	struct drm_device *drm = vgdev->ddev;
>  
> -	vgdev->capsets = kcalloc(num_capsets,
> -				 sizeof(struct virtio_gpu_drv_capset),
> -				 GFP_KERNEL);
> +	vgdev->capsets = drmm_kcalloc(drm, num_capsets,
> +				      sizeof(struct virtio_gpu_drv_capset),
> +				      GFP_KERNEL);
>  	if (!vgdev->capsets) {
>  		DRM_ERROR("failed to allocate cap sets\n");
>  		return;
> @@ -94,7 +96,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>  
>  		if (ret == 0 || invalid_capset_id) {
>  			spin_lock(&vgdev->display_info_lock);
> -			kfree(vgdev->capsets);
> +			drmm_kfree(drm, vgdev->capsets);
>  			vgdev->capsets = NULL;
>  			spin_unlock(&vgdev->display_info_lock);
>  			return;
> @@ -126,7 +128,7 @@ int virtio_gpu_init(struct drm_device *dev)
>  	if (!virtio_has_feature(dev_to_virtio(dev->dev), VIRTIO_F_VERSION_1))
>  		return -ENODEV;
>  
> -	vgdev = kzalloc(sizeof(struct virtio_gpu_device), GFP_KERNEL);
> +	vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
>  	if (!vgdev)
>  		return -ENOMEM;
>  
> @@ -257,7 +259,6 @@ int virtio_gpu_init(struct drm_device *dev)
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>  err_vqs:
>  	dev->dev_private = NULL;
> -	kfree(vgdev);
>  	return ret;
>  }
>  
> @@ -296,9 +297,6 @@ void virtio_gpu_release(struct drm_device *dev)
>  
>  	if (vgdev->has_host_visible)
>  		drm_mm_takedown(&vgdev->host_visible_mm);
> -
> -	kfree(vgdev->capsets);
> -	kfree(vgdev);
>  }
>  
>  int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
> -- 
> 2.36.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
