Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3A5ACFCC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiIEKT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiIEKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:19:19 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05156B88
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nGjgsqGfJ0L+5KqUZMoJ4DGF2/kaGZuM3mOBrnObORY=; b=GuFH49lIq7dXPIMGs2vx4oc3BR
        e4YS/7YXDJgB9v/zgketZQx9j+ssn++8p5j5K3bgQHeAgYXYvDb4xMsOlhPfqz7vlqzPscXDqPiDp
        TuZk6qPEaf9gEEvSTnRfIOwWc95dRQfj//0k4w1VdwEkrGqBd9ai/8uZRyhuSxUeSOOObjAaIyW6B
        2x5vmyH3jI24qzuKuKEcC/2jq+sAieA5uyVJr0iVO0oz10Maa9WzNwr34UsF7CYZqJWlbCMUkDiex
        HCn3YQ35Mqkh6eFmO3/78uayPkQngfVpngj7+TknlebgMGDtZ5dq9zlx9rs99wN7jTx7Ln6187TRI
        kHjBOxRA==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=59939)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oV9BW-00065d-5J; Mon, 05 Sep 2022 12:18:30 +0200
Message-ID: <ae5932bf-c34d-8e11-c71f-f470e03822e4@tronnes.org>
Date:   Mon, 5 Sep 2022 12:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/41] drm/connector: Add TV standard property
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
 <20220728-rpi-analog-tv-properties-v2-9-459522d653a7@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-9-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.08.2022 15.11, skrev Maxime Ripard:
> The TV mode property has been around for a while now to select and get the
> 
> current TV mode output on an analog TV connector.
> 
> 
> 
> Despite that property name being generic, its content isn't and has been
> 
> driver-specific which makes it hard to build any generic behaviour on top
> 
> of it, both in kernel and user-space.
> 
> 
> 
> Let's create a new bitmask tv norm property, that can contain any of the
> 
> analog TV standards currently supported by kernel drivers. Each driver can
> 
> then pass in a bitmask of the modes it supports.
> 
> 
> 
> We'll then be able to phase out the older tv mode property.
> 
> 
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> 
> 

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c

> +/**
> 
> + * drm_mode_create_tv_properties - create TV specific connector properties
> 
> + * @dev: DRM device
> 
> + * @supported_tv_modes: Bitmask of TV modes supported (See DRM_MODE_TV_MODE_*)
> 
> +
> 
> + * Called by a driver's TV initialization routine, this function creates
> 
> + * the TV specific connector properties for a given device.  Caller is
> 
> + * responsible for allocating a list of format names and passing them to
> 
> + * this routine.
> 
> + *
> 
> + * Returns:
> 
> + * 0 on success or a negative error code on failure.
> 
> + */
> 
> +int drm_mode_create_tv_properties(struct drm_device *dev,
> 
> +				  unsigned int supported_tv_modes)
> 
> +{
> 
> +	struct drm_prop_enum_list tv_mode_list[DRM_MODE_TV_MODE_MAX];
> 
> +	struct drm_property *tv_mode;
> 
> +	unsigned int i, len = 0;
> 
> +
> 

Can you add a check here like in the legacy version:

	if (dev->mode_config.tv_mode_property)
		return 0;

This way it's possible to call this multiple times. Like in drm/gud
during connector init if there are multiple TV connectors or if a device
with multiple IP blocks should show up.

Noralf.

> +	for (i = 0; i < DRM_MODE_TV_MODE_MAX; i++) {
> 
> +		if (!(supported_tv_modes & BIT(i)))
> 
> +			continue;
> 
> +
> 
> +		tv_mode_list[len].type = i;
> 
> +		tv_mode_list[len].name = drm_get_tv_mode_name(i);
> 
> +		len++;
> 
> +	}
> 
> +
> 
> +	tv_mode = drm_property_create_enum(dev, 0, "TV mode",
> 
> +					   tv_mode_list, len);
> 
> +	if (!tv_mode)
> 
> +		return -ENOMEM;
> 
> +
> 
> +	dev->mode_config.tv_mode_property = tv_mode;
> 
> +
> 
> +	return drm_mode_create_tv_properties_legacy(dev, 0, NULL);
> 
> +}
> 
> +EXPORT_SYMBOL(drm_mode_create_tv_properties);
> 
