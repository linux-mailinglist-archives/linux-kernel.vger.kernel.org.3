Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F35A868B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiHaTPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHaTO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:14:56 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA77B5F6D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lFykXXuh414AMHOUrkjMCmREYuLQabBQPnrg6lAfPPY=; b=ZZ198Xf6PPUp/l53rhljFuGMcF
        4zuRseMWeZpoj311RIFnjrUYtADjn9wuJNnEsMO5CjZC+xEdH2c5qjeG0ILG3eq0DkS+/UAuBjtmA
        lj9MawJD7bAGX1645naLEYPOhTdWjb1DKDqwDt5sCid+4EKbwJJ+m1nntHZqZTCOwtH2m0Y9w0pvq
        ypgdce4iD49nSDTQOHr/OQAfe1DigWSkskMg6tndHXcqQjah9nFLMqXz3YF7rBpOLW1ZK9v7rG2Lt
        fwCHewKIgkfbPSZuTdFO+kk9VvsODXV4OOvjxUHa5qpzXfN6R8L2vlOWdmejD3IUudqW/Bg3YIvS9
        NvG7WR9A==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=57178)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oTTAj-0002O5-TA; Wed, 31 Aug 2022 21:14:45 +0200
Message-ID: <dab9899b-b3e5-b99f-7219-9b5efa3a3591@tronnes.org>
Date:   Wed, 31 Aug 2022 21:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 18/41] drm/connector: Add a function to lookup a TV
 mode by its name
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
 <20220728-rpi-analog-tv-properties-v2-18-459522d653a7@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-18-459522d653a7@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.08.2022 15.11, skrev Maxime Ripard:
> As part of the command line parsing rework coming in the next patches,
> 
> we'll need to lookup drm_connector_tv_mode values by their name, already
> 
> defined in drm_tv_mode_enum_list.
> 
> 
> 
> In order to avoid any code duplication, let's do a function that will
> 
> perform a lookup of a TV mode name and return its value.
> 
> 
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> 
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> 
> index b1fcacd150e8..0fe01a1c20ad 100644
> 
> --- a/drivers/gpu/drm/drm_connector.c
> 
> +++ b/drivers/gpu/drm/drm_connector.c
> 
> @@ -1003,6 +1003,30 @@ static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
> 
>  };
> 
>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
> 
>  
> 
> +/**
> 
> + * drm_get_tv_mode_from_name - Translates a TV mode name into its enum value
> 
> + * @name: TV Mode name we want to convert
> 
> + * @len: Length of @name
> 
> + *
> 
> + * Translates @name into an enum drm_connector_tv_mode.
> 
> + *
> 
> + * Returns: the enum value on success, a negative errno otherwise.
> 
> + */
> 
> +int drm_get_tv_mode_from_name(const char *name, size_t len)
> 
> +{
> 
> +	unsigned int i;
> 
> +
> 
> +	for (i = 0; i < ARRAY_SIZE(drm_tv_mode_enum_list); i++) {
> 
> +		const struct drm_prop_enum_list *item = &drm_tv_mode_enum_list[i];
> 
> +
> 
> +		if (strlen(item->name) == len && !strncmp(item->name, name, len))
> 
> +			return item->type;
> 
> +	}
> 
> +
> 
> +	return -EINVAL;
> 
> +}
> 
> +EXPORT_SYMBOL(drm_get_tv_mode_from_name)

Missing semicolon.

Noralf.

> 
> +
> 
>  static const struct drm_prop_enum_list drm_tv_select_enum_list[] = {
> 
>  	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
> 
>  	{ DRM_MODE_SUBCONNECTOR_Composite, "Composite" }, /* TV-out */
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> 
> index bb39d2bb806e..49d261977d4e 100644
> 
> --- a/include/drm/drm_connector.h
> 
> +++ b/include/drm/drm_connector.h
> 
> @@ -1943,6 +1943,8 @@ const char *drm_get_dp_subconnector_name(int val);
> 
>  const char *drm_get_content_protection_name(int val);
> 
>  const char *drm_get_hdcp_content_type_name(int val);
> 
>  
> 
> +int drm_get_tv_mode_from_name(const char *name, size_t len);
> 
> +
> 
>  int drm_mode_create_dvi_i_properties(struct drm_device *dev);
> 
>  void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector);
> 
>  
> 
> 
> 
