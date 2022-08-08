Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A3F58CB24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbiHHPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbiHHPP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:15:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E8DE85
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:15:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bz13so6689136qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=E1+RvZYFttA7KfQ1mW79F5z6+egwwtoFoB1XJg6ELSg=;
        b=AVe6sQGfMehOZihPIbKsmijDAmaC5j5gxtf6YiZ/i0CXOHmjNIvvLExq+5iQpAR4DI
         P5DY+hFJA2HzBv+wDHOFHS7NSaos3RXOq7py448i+ZAXrVe7aFKE2r8k/zmowAuqTZwD
         hwoZlNL9LzMiK4LG+7IGDmKI0xBT410HNXjKJ0U3uBqd7S2RqEkgtFwJJvaa0Wkj46DZ
         nk+IE8HveFCZ7FcpI5vflC4tJtjEScQyWfy+b2BMiL2RpdfBxfb+8jqP+2qehmbkYT9k
         He3aFjobz40m+4nbM8CrNGFgYcKNbVCAVmywpjoMw0SYIONh+a6ApTXe60gtFRzwjAUi
         AE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=E1+RvZYFttA7KfQ1mW79F5z6+egwwtoFoB1XJg6ELSg=;
        b=Dmdtg7fRWuawz4xwoqakH0F4wHis16majfhsSzR/mVlB3+3UojqsYEQVUT61WBa0k/
         acdnNuIFke2D7ZLDmq8EdKvoAwuUxMKOwE57YT3gdM9JjHL1we8qSwtRl+0Ha/5oA1XY
         W+ehCR+VsAX4WPvnqdtHoDXl24DVCoOkeZKlq6LlZWpy0iBR9L7352XtcJrr5XCpwChv
         4pCom0/LC4frbxFudVxaKFB+MtpgWrNmaeRtRH4/qjDLjby7d2C83FUE98+lVW9XbCeJ
         6oDRvzMD2o2w9mOMHA2gx62cjvZvvohk3l6TGnwikWPzMR+9qmnwuagc6KzzSHAqegOb
         IxwA==
X-Gm-Message-State: ACgBeo2xmdlpU8nPzOvqFBPlvMB1sLwNdgqTrXQuF3wQ21uvSVDqcQrb
        hZhKjmH47EIv5EhEZ/rllcODag==
X-Google-Smtp-Source: AA6agR7SOgQH4fepgo2aG4rek0z8+vmrQqc5LwnlMyHAfnP6b2yJV3xT2ATVcuuOBXYLMID2C5CEHA==
X-Received: by 2002:ac8:5e4c:0:b0:343:423:e736 with SMTP id i12-20020ac85e4c000000b003430423e736mr1111801qtx.490.1659971723666;
        Mon, 08 Aug 2022 08:15:23 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b8e7afe20bsm9836458qkb.123.2022.08.08.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:15:22 -0700 (PDT)
Date:   Mon, 8 Aug 2022 15:15:22 +0000
From:   Sean Paul <sean@poorly.run>
To:     Jim Shargo <jshargo@chromium.org>
Cc:     jshargo@google.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/vkms: Support registering configfs devices
Message-ID: <YvEoiiJi24xR0Xiz@art_vandelay>
References: <20220722213214.1377835-1-jshargo@chromium.org>
 <20220722213214.1377835-6-jshargo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220722213214.1377835-6-jshargo@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 05:32:13PM -0400, Jim Shargo wrote:
> VKMS now supports creating virtual cards and registering them to create
> real drm devices.
> 
> In addition to the registration logic, this commit also prevents users
> from adding new objects once a card is registered.
> 
> Signed-off-by: Jim Shargo <jshargo@chromium.org>
> ---
>  drivers/gpu/drm/vkms/vkms_configfs.c |  27 +++-
>  drivers/gpu/drm/vkms/vkms_drv.c      |  21 ++-
>  drivers/gpu/drm/vkms/vkms_drv.h      |   3 +
>  drivers/gpu/drm/vkms/vkms_output.c   | 227 ++++++++++++++++++++++++---
>  4 files changed, 251 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index fa0d8700258e..6f0f4e39864a 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -326,8 +326,15 @@ static struct config_item_type plane_type = {
>  static struct config_group *connectors_group_make(struct config_group *group,
>  						  const char *name)
>  {
> -	struct vkms_config_connector *connector =
> -		kzalloc(sizeof(struct vkms_config_connector), GFP_KERNEL);
> +	struct vkms_configfs *configfs =
> +		container_of(group, struct vkms_configfs, connectors_group);
> +	struct vkms_config_connector *connector;
> +
> +	if (configfs->card) {

I think it would be better to assign configfs->card in
card_is_registered_store() after successful call to vkms_card_init(). My
reasoning is that the functions in this file care about configfs->card, and not
vkms_drv.c. As a bonus, you can also eliminate the if (configfs) check before
the assignment which is necessary in vkms_card_init() but not
card_is_registered_store().

> +		return ERR_PTR(EBUSY);

Nit: Negative errno please (applies elsewhere through the patch as well).

> +	}

Nit: remove braces

> +
> +	connector = kzalloc(sizeof(struct vkms_config_connector), GFP_KERNEL);

Nit: sizeof(*connector) could be handy here and elsewhere below.

It's a bit awkward to make use of devres elsewhere and not here. I guess the
devres group doesn't exist at this point and perhaps card destruction and
config_group destruction aren't strictly ordered. ¯\_(ツ)_/¯

>  	if (!connector)
>  		return ERR_PTR(ENOMEM);
>  
> @@ -368,6 +375,9 @@ static struct config_group *crtcs_group_make(struct config_group *group,
>  						     VKMS_MAX_OUTPUT_OBJECTS);
>  	struct vkms_config_crtc *crtc;
>  
> +	if (configfs->card)

It really feels like we should have some locking protecting us from races
between adding new components and registration.

> +		return ERR_PTR(EBUSY);
> +
>  	if (next_idx == VKMS_MAX_OUTPUT_OBJECTS) {
>  		DRM_ERROR("Unable to allocate another CRTC.");
>  		return ERR_PTR(ENOMEM);
> @@ -413,6 +423,9 @@ static struct config_group *encoders_group_make(struct config_group *group,
>  		&configfs->allocated_encoders, VKMS_MAX_OUTPUT_OBJECTS);
>  	struct vkms_config_encoder *encoder;
>  
> +	if (configfs->card)
> +		return ERR_PTR(EBUSY);
> +
>  	if (next_idx == VKMS_MAX_OUTPUT_OBJECTS) {
>  		DRM_ERROR("Unable to allocate another encoder.");
>  		return ERR_PTR(ENOMEM);
> @@ -454,8 +467,14 @@ static struct config_item_type encoders_group_type = {
>  static struct config_group *make_plane_group(struct config_group *group,
>  					     const char *name)
>  {
> -	struct vkms_config_plane *plane =
> -		kzalloc(sizeof(struct vkms_config_plane), GFP_KERNEL);
> +	struct vkms_configfs *configfs =
> +		container_of(group, struct vkms_configfs, planes_group);
> +	struct vkms_config_plane *plane;
> +
> +	if (configfs->card)
> +		return ERR_PTR(EBUSY);
> +
> +	plane = kzalloc(sizeof(struct vkms_config_plane), GFP_KERNEL);
>  	if (!plane)
>  		return ERR_PTR(ENOMEM);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 37b95ca28672..4e00f3b0de7d 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -216,7 +216,7 @@ struct vkms_card *vkms_card_init(const char *name, struct vkms_configfs *configf
>  		goto out_release_group;
>  	}
>  
> -	ret = drm_vblank_init(&card->drm, 1);
> +	ret = drm_vblank_init(&card->drm, vkms_card_crtc_count(card));

I wonder if you could re-order this below vkms_modeset_init() and use
card->output.num_crtcs instead of the new function?

>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
>  		goto out_release_group;
> @@ -231,7 +231,7 @@ struct vkms_card *vkms_card_init(const char *name, struct vkms_configfs *configf
>  	ret = drm_dev_register(&card->drm, 0);
>  	if (ret) {
>  		DRM_ERROR("Unable to register card");
> -		return ERR_PTR(ret);
> +		goto out_modeset;

Not sure if this is the one I commented on in the previous patch, but at the
risk of duplicate comments, this cleanup feels like it belongs in an earlier patch.

>  	}
>  
>  	drm_fbdev_generic_setup(&card->drm, 0);
> @@ -245,6 +245,8 @@ struct vkms_card *vkms_card_init(const char *name, struct vkms_configfs *configf
>  
>  	return card;
>  
> +out_modeset:
> +	vkms_output_clear(card);
>  out_release_group:
>  	devres_release_group(&pdev->dev, grp);
>  out_platform_device:
> @@ -264,6 +266,21 @@ void vkms_card_destroy(struct vkms_card *card)

I feel like vkms_card_destroy() should also be calling vkms_output_clear() or it
should have the same cleanup procedure as the error handling code in
vkms_card_init().

>  	}
>  }
>  
> +int vkms_card_crtc_count(struct vkms_card *card)

AFAICT this isn't used outside vkms_drv.c so it should be static.

> +{
> +	struct list_head *item;
> +	int count = 0;
> +
> +	if (card->is_default)
> +		return 1;
> +
> +	BUG_ON(!card->configfs);
> +	list_for_each(item, &card->configfs->crtcs_group.cg_children) {

Do you need any locking here? 

> +		count += 1;
> +	}
> +	return count;
> +}
> +
>  static int __init vkms_init(void)
>  {
>  	struct vkms_card *card;
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index f43e4c563863..2e6bfed890f9 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -222,11 +222,14 @@ struct vkms_card *vkms_card_init(const char *name,
>  				 struct vkms_configfs *configfs);
>  void vkms_card_destroy(struct vkms_card *card);
>  
> +int vkms_card_crtc_count(struct vkms_card *card);
> +
>  /* CRTC */
>  struct vkms_crtc *vkms_crtc_init(struct vkms_card *card, struct drm_plane *primary, struct drm_plane *cursor);
>  
>  int vkms_output_init_default(struct vkms_card *card, int index);
>  int vkms_output_init(struct vkms_card *card, int index);
> +void vkms_output_clear(struct vkms_card *card);
>  
>  struct vkms_plane *vkms_plane_init(struct vkms_card *card,
>  				   enum drm_plane_type type);
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index e343a9c1f311..857cd8593dce 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -4,6 +4,10 @@
>  #include <linux/kernel.h>
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_plane.h>

It makes sense that we would need these, but I'm not sure why it's now and not
earlier in the patchset.

>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
> @@ -46,7 +50,7 @@ static struct drm_connector *vkms_connector_init(struct vkms_card *card)
>  
>  	connector = &card->output.connectors[card->output.num_connectors++];
>  	ret = drm_connector_init(&card->drm, connector, &vkms_connector_funcs,
> -			   DRM_MODE_CONNECTOR_VIRTUAL);
> +				 DRM_MODE_CONNECTOR_VIRTUAL);

Nit: This indent was introduced in patch 3, if you fix it there it'll drop out of here.


>  	if (ret) {
>  		memset(connector, 0, sizeof(*connector));
>  		card->output.num_connectors -= 1;
> @@ -79,7 +83,6 @@ static struct drm_encoder *vkms_encoder_init(struct vkms_card *card)
>  int vkms_output_init_default(struct vkms_card *card, int index)

How feasible would it be to initialize the default device in configfs with the
module config and then call vkms_output_init() to initialize it instead of
duplicating all of this init? As a bonus, we could probably turf some of the
if(default) logic sprinkled around.

>  {
>  	const struct vkms_config *config = &card->vkms_device->config;
> -	struct vkms_output *output = &card->output;
>  	struct drm_device *dev = &card->drm;
>  	struct drm_connector *connector;
>  	struct drm_encoder *encoder;
> @@ -99,7 +102,7 @@ int vkms_output_init_default(struct vkms_card *card, int index)
>  				vkms_plane_init(card, DRM_PLANE_TYPE_OVERLAY);
>  			if (IS_ERR(overlay)) {
>  				ret = PTR_ERR(overlay);
> -				goto err_planes;
> +				goto cleanup_output;
>  			}
>  		}
>  	}
> @@ -108,7 +111,7 @@ int vkms_output_init_default(struct vkms_card *card, int index)
>  		cursor = vkms_plane_init(card, DRM_PLANE_TYPE_CURSOR);
>  		if (IS_ERR(cursor)) {
>  			ret = PTR_ERR(cursor);
> -			goto err_planes;
> +			goto cleanup_output;
>  		}
>  	}
>  
> @@ -117,7 +120,7 @@ int vkms_output_init_default(struct vkms_card *card, int index)
>  	if (IS_ERR(vkms_crtc)) {
>  		DRM_ERROR("Failed to init crtc\n");
>  		ret = PTR_ERR(vkms_crtc);
> -		goto err_planes;
> +		goto cleanup_output;
>  	}
>  
>  	for (int i = 0; i < card->output.num_planes; i++) {
> @@ -129,22 +132,21 @@ int vkms_output_init_default(struct vkms_card *card, int index)
>  	if (IS_ERR(connector)) {
>  		DRM_ERROR("Failed to init connector\n");
>  		ret = PTR_ERR(connector);
> -		goto err_connector;
> +		goto cleanup_output;
>  	}
>  
>  	encoder = vkms_encoder_init(card);
>  	if (IS_ERR(encoder)) {
>  		DRM_ERROR("Failed to init encoder\n");
>  		ret = PTR_ERR(encoder);
> -		goto err_encoder;
> +		goto cleanup_output;
>  	}
>  	encoder->possible_crtcs |= drm_crtc_mask(&vkms_crtc->base);
>  
> -

Nit: This blank line was introduced in patch 3, perhaps remove it from there and
it'll drop out here.

>  	ret = drm_connector_attach_encoder(connector, encoder);
>  	if (ret) {
>  		DRM_ERROR("Failed to attach connector to encoder\n");
> -		goto err_attach;
> +		goto cleanup_output;
>  	}
>  
>  	if (config->writeback) {
> @@ -157,26 +159,209 @@ int vkms_output_init_default(struct vkms_card *card, int index)
>  
>  	return 0;
>  
> -err_attach:
> -	drm_encoder_cleanup(encoder);
> +cleanup_output:
> +	vkms_output_clear(card);
> +	return ret;
> +}
>  
> -err_encoder:
> -	drm_connector_cleanup(connector);
> +static bool is_object_linked(struct vkms_config_links *links, unsigned long idx)
> +{
> +	return links->linked_object_bitmap & (1 << idx);

Nit: You could use some of the bit helpers available (and avoid the implicit
cast):

return FIELD_GET(BIT(idx), links->linked_object_bitmap) != 0;

> +}
>  
> -err_connector:
> -	drm_crtc_cleanup(&vkms_crtc->base);
> +int vkms_output_init(struct vkms_card *card, int index)
> +{
> +	struct drm_device *dev = &card->drm;
> +	struct vkms_configfs *configfs = card->configfs;
> +	struct vkms_output *output = &card->output;
> +	struct plane_map {
> +		struct vkms_config_plane *config_plane;
> +		struct vkms_plane *plane;
> +	} plane_map[VKMS_MAX_OUTPUT_OBJECTS] = { 0 };
> +	struct encoder_map {
> +		struct vkms_config_encoder *config_encoder;
> +		struct drm_encoder *encoder;
> +	} encoder_map[VKMS_MAX_OUTPUT_OBJECTS] = { 0 };
> +	struct config_item *item;
> +	int i, ret;
> +
> +	i = 0;
> +	list_for_each_entry (item, &configfs->planes_group.cg_children,
> +			     ci_entry) {
> +		struct vkms_config_plane *config_plane =
> +			item_to_config_plane(item);
> +		struct vkms_plane *plane =
> +			vkms_plane_init(card, config_plane->type);
> +
> +		if (IS_ERR(plane)) {
> +			DRM_ERROR("Unable to init plane from config: %s",
> +				  item->ci_name);

It'd be nice to print the return value here.

> +			ret = PTR_ERR(plane);
> +			goto cleanup_output;
> +		}
>  
> -err_planes:
> -	for (int i = 0; i < output->num_planes; i++) {
> -		drm_plane_cleanup(&output->planes[i].base);
> +		plane_map[i].config_plane = config_plane;
> +		plane_map[i].plane = plane;
> +		i += 1;

Instead of tracking with i, you could use "output->num_planes - 1"? Same comment
below for different "num_blah"

> +	}
> +
> +	i = 0;
> +	list_for_each_entry (item, &configfs->encoders_group.cg_children,
> +			     ci_entry) {
> +		struct vkms_config_encoder *config_encoder =
> +			item_to_config_encoder(item);
> +		struct drm_encoder *encoder = vkms_encoder_init(card);
> +
> +		if (IS_ERR(encoder)) {
> +			DRM_ERROR("Failed to init config encoder: %s",
> +				  item->ci_name);
> +			ret = PTR_ERR(encoder);
> +			goto cleanup_output;
> +		}
> +		encoder_map[i].config_encoder = config_encoder;
> +		encoder_map[i].encoder = encoder;
> +		i += 1;
> +	}
> +
> +	list_for_each_entry (item, &configfs->connectors_group.cg_children,
> +			     ci_entry) {
> +		struct vkms_config_connector *config_connector =
> +			item_to_config_connector(item);
> +		struct drm_connector *connector = vkms_connector_init(card);
> +
> +		if (IS_ERR(connector)) {
> +			DRM_ERROR("Failed to init connector from config: %s",
> +				  item->ci_name);
> +			ret = PTR_ERR(connector);
> +			goto cleanup_output;
> +		}
> +
> +		for (int j = 0; j < output->num_connectors; j++) {
> +			struct encoder_map *encoder = &encoder_map[j];
> +
> +			if (is_object_linked(
> +				    &config_connector->possible_encoders,
> +				    encoder->config_encoder
> +					    ->encoder_config_idx)) {
> +				drm_connector_attach_encoder(connector,
> +							     encoder->encoder);
> +			}
> +		}
> +	}
> +
> +	list_for_each_entry (item, &configfs->crtcs_group.cg_children,
> +			     ci_entry) {
> +		struct vkms_config_crtc *config_crtc =
> +			item_to_config_crtc(item);
> +		struct vkms_crtc *vkms_crtc;
> +		struct drm_plane *primary = NULL, *cursor = NULL;
> +
> +		for (int j = 0; j < output->num_planes; j++) {
> +			struct plane_map *plane_entry = &plane_map[j];
> +			struct drm_plane *plane = &plane_entry->plane->base;
> +
> +			if (!is_object_linked(
> +				    &plane_entry->config_plane->possible_crtcs,
> +				    config_crtc->crtc_config_idx)) {
> +				continue;
> +			}

Nit: Braces

> +
> +			if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
> +				if (primary) {
> +					DRM_WARN(
> +						"Too many primary planes found for crtc %s.",
> +						item->ci_name);

Nit: drm_dbg()

> +					ret = EINVAL;
> +					goto cleanup_output;
> +				}
> +				primary = plane;
> +			} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
> +				if (cursor) {
> +					DRM_WARN(
> +						"Too many cursor planes found for crtc %s.", 
> +						item->ci_name);
> +					ret = EINVAL;
> +					goto cleanup_output;
> +				}
> +				cursor = plane;
> +			}
> +		}
> +
> +		if (!primary) {
> +			DRM_WARN("No primary plane configured for crtc %s", item->ci_name);
> +			ret = EINVAL;
> +			goto cleanup_output;
> +		}
> +
> +		// TODO add names to helper

Mind expanding on this?

> +		vkms_crtc = vkms_crtc_init(card, primary, cursor);
> +		if (IS_ERR(vkms_crtc)) {
> +			DRM_WARN("Unable to init crtc from config: %s",
> +				 item->ci_name);
> +			ret = PTR_ERR(vkms_crtc);
> +			goto cleanup_output;
> +		}
> +
> +		for (int j = 0; j < output->num_planes; j++) {
> +			struct plane_map *plane_entry = &plane_map[j];
> +
> +			if (!plane_entry->plane)
> +				break;
> +
> +			if (is_object_linked(
> +				    &plane_entry->config_plane->possible_crtcs,
> +				    config_crtc->crtc_config_idx)) {
> +				plane_entry->plane->base.possible_crtcs |=
> +					drm_crtc_mask(&vkms_crtc->base);
> +			}
> +		}
> +
> +		for (int j = 0; j < output->num_encoders; j++) {
> +			struct encoder_map *encoder_entry = &encoder_map[j];
> +
> +			if (is_object_linked(&encoder_entry->config_encoder
> +						      ->possible_crtcs,
> +					     config_crtc->crtc_config_idx)) {
> +				encoder_entry->encoder->possible_crtcs |=
> +					drm_crtc_mask(&vkms_crtc->base);
> +			}
> +		}
> +
> +		if (card->vkms_device->config.writeback) {
> +			ret = vkms_enable_writeback_connector(card, vkms_crtc);
> +			if (ret)
> +				DRM_WARN(
> +					"Failed to init writeback connector for config crtc: %s",
> +					item->ci_name);

Nit: drm_dbg and please print the error message.

> +		}
>  	}
>  
> -	memset(output, 0, sizeof(struct vkms_output));
> +	drm_mode_config_reset(dev);
> +
> +	return 0;
>  
> +cleanup_output:
> +	vkms_output_clear(card);
> +	resume_device_irqs(); // REMOVE

REMOVE?

>  	return ret;
>  }
>  
> -int vkms_output_init(struct vkms_card *card, int index)
> +void vkms_output_clear(struct vkms_card *card)
>  {
> -	return -ENOTSUPP;
> +	struct vkms_output *output = &card->output;
> +
> +	for (int i = 0; i < output->num_crtcs; i++) {
> +		drm_crtc_cleanup(&output->crtcs[i].base);
> +	}
> +	for (int i = 0; i < output->num_encoders; i++) {
> +		drm_encoder_cleanup(&output->encoders[i]);
> +	}
> +	for (int i = 0; i < output->num_connectors; i++) {
> +		drm_connector_cleanup(&output->connectors[i]);
> +	}
> +	for (int i = 0; i < output->num_planes; i++) {
> +		drm_plane_cleanup(&output->planes[i].base);
> +	}

Nit: braces for all of these

> +
> +	memset(output, 0, sizeof(*output));

Same concerns about memset as before.

>  }
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
