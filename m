Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4B57B967
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiGTPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:17:28 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151DE509FF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=zjG1XWzkA20vuBygMH18SAY8CwTCprtH16amnZE1QMw=;
        b=FdAU8fjjjyvzd0oC80Njb6hh5j2BDDEVW/JWQjVJ6/jRv25ZU6yQ29LZL9jlkKookWqys/t+yYPUk
         M7WqzLA6i1c5TrJ+/+TX9Jf1iAegIRRKR43uot9BwlayKq/26A4NiG912Ij6YeEpxVPy0n0bNSmtmX
         qViZTtgObK1iXFKtiUUmB1uF2584hz7/SXiprDQKVUtcrMSQ8N1Ku4s5EUz9LAcObgb9Tau3l9Nact
         QwgCAkfp8wCefWph4D2N87kmdkXwWN0rpYkYWtSo8aFrx0PQnrKzkaEpaSqKWDMtINE7iSW/EF7wRy
         PX8eOZgesc3CRyFYiLqv8nB4Ejuvi+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=zjG1XWzkA20vuBygMH18SAY8CwTCprtH16amnZE1QMw=;
        b=3KcAmnHd48zCC/NRe+A5PZZsdlVYhhvLBT5fAIAis8MB/Po+mZ+Ncv+ge0l8ambYrhndM8+wQKUAG
         7VmcsGgDA==
X-HalOne-Cookie: 092ff6973dd1dffa75fbcc92e936cabae426a920
X-HalOne-ID: 0e33c82a-083f-11ed-a6c8-d0431ea8a283
Received: from mailproxy4.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 0e33c82a-083f-11ed-a6c8-d0431ea8a283;
        Wed, 20 Jul 2022 15:17:23 +0000 (UTC)
Date:   Wed, 20 Jul 2022 17:17:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND 1/2] drm/virtio: plane: use drm managed resources
Message-ID: <YtgcgovHX6jAqbt8@ravnborg.org>
References: <20220720140214.199492-1-dakr@redhat.com>
 <20220720140214.199492-2-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720140214.199492-2-dakr@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

thanks for submitting this patch.

On Wed, Jul 20, 2022 at 04:02:13PM +0200, Danilo Krummrich wrote:
> Use drm managed resource allocation (drmm_universal_plane_alloc()) in
> order to cleanup/simplify drm plane .destroy callback.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 30 +++++++-------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 6d3cc9e238a4..3008551d6a05 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -67,16 +67,10 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
>  	return format;
>  }
>  
> -static void virtio_gpu_plane_destroy(struct drm_plane *plane)
> -{
> -	drm_plane_cleanup(plane);
> -	kfree(plane);
> -}
> -
>  static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
>  	.update_plane		= drm_atomic_helper_update_plane,
>  	.disable_plane		= drm_atomic_helper_disable_plane,
> -	.destroy		= virtio_gpu_plane_destroy,
> +	.destroy		= drm_plane_cleanup,

From the documentation of drmm_universal_plane_alloc:

    The @drm_plane_funcs.destroy hook must be NULL.

So the above assignment looks wrong.

The rest of this patch looks OK.

	Sam


>  	.reset			= drm_atomic_helper_plane_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> @@ -379,11 +373,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  	const struct drm_plane_helper_funcs *funcs;
>  	struct drm_plane *plane;
>  	const uint32_t *formats;
> -	int ret, nformats;
> -
> -	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
> -	if (!plane)
> -		return ERR_PTR(-ENOMEM);
> +	int nformats;
>  
>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>  		formats = virtio_gpu_cursor_formats;
> @@ -394,17 +384,13 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>  		nformats = ARRAY_SIZE(virtio_gpu_formats);
>  		funcs = &virtio_gpu_primary_helper_funcs;
>  	}
> -	ret = drm_universal_plane_init(dev, plane, 1 << index,
> -				       &virtio_gpu_plane_funcs,
> -				       formats, nformats,
> -				       NULL, type, NULL);
> -	if (ret)
> -		goto err_plane_init;
> +
> +	plane = drmm_universal_plane_alloc(dev, struct drm_plane, dev,
> +					   1 << index, &virtio_gpu_plane_funcs,
> +					   formats, nformats, NULL, type, NULL);
> +	if (IS_ERR(plane))
> +		return plane;
>  
>  	drm_plane_helper_add(plane, funcs);
>  	return plane;
> -
> -err_plane_init:
> -	kfree(plane);
> -	return ERR_PTR(ret);
>  }
> -- 
> 2.36.1
