Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF694CA381
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbiCBLXI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 06:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbiCBLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:22:54 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3487657;
        Wed,  2 Mar 2022 03:22:11 -0800 (PST)
Date:   Wed, 02 Mar 2022 10:40:07 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 3/3] drm/panel : innolux-ej030na and abt-y030xx067a :
 add .enable and .disable
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-Id: <VM548R.0I9BAN681OS83@crapouillou.net>
In-Reply-To: <20220301153122.20660-4-cbranchereau@gmail.com>
References: <20220301153122.20660-1-cbranchereau@gmail.com>
        <20220301153122.20660-4-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Le mar., mars 1 2022 at 16:31:22 +0100, Christophe Branchereau 
<cbranchereau@gmail.com> a écrit :
> Following the introduction of bridge_atomic_enable in the ingenic
> drm driver, the crtc is enabled between .prepare and .enable, if
> it exists.
> 
> Add it so the backlight is only enabled after the crtc is, to avoid
> graphical issues.
> 
> Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 23 ++++++++++++--
>  drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31 
> ++++++++++++++++---
>  2 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c 
> b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> index f043b484055b..b5736344e3ec 100644
> --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> @@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel 
> *panel)
>  		goto err_disable_regulator;
>  	}
> 
> -	msleep(120);
> -
>  	return 0;
> 
>  err_disable_regulator:
> @@ -202,6 +200,25 @@ static int y030xx067a_unprepare(struct drm_panel 
> *panel)
>  	return 0;
>  }
> 
> +static int y030xx067a_enable(struct drm_panel *panel)
> +{
> +	if (panel->backlight) {
> +		/* Wait for the picture to be ready before enabling backlight */
> +		msleep(120);
> +	}
> +
> +	return 0;
> +}
> +
> +static int y030xx067a_disable(struct drm_panel *panel)
> +{
> +	struct y030xx067a *priv = to_y030xx067a(panel);
> +
> +	regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);

Shouldn't that be balanced by a regmap_set_bits() in the .enable() 
function?

Cheers,
-Paul

> +
> +	return 0;
> +}
> +
>  static int y030xx067a_get_modes(struct drm_panel *panel,
>  				struct drm_connector *connector)
>  {
> @@ -239,6 +256,8 @@ static int y030xx067a_get_modes(struct drm_panel 
> *panel,
>  static const struct drm_panel_funcs y030xx067a_funcs = {
>  	.prepare	= y030xx067a_prepare,
>  	.unprepare	= y030xx067a_unprepare,
> +	.enable		= y030xx067a_enable,
> +	.disable	= y030xx067a_disable,
>  	.get_modes	= y030xx067a_get_modes,
>  };
> 
> diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c 
> b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> index c558de3f99be..6de7370185cd 100644
> --- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> +++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> @@ -80,8 +80,6 @@ static const struct reg_sequence 
> ej030na_init_sequence[] = {
>  	{ 0x47, 0x08 },
>  	{ 0x48, 0x0f },
>  	{ 0x49, 0x0f },
> -
> -	{ 0x2b, 0x01 },
>  };
> 
>  static int ej030na_prepare(struct drm_panel *panel)
> @@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel 
> *panel)
>  		goto err_disable_regulator;
>  	}
> 
> -	msleep(120);
> -
>  	return 0;
> 
>  err_disable_regulator:
> @@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel 
> *panel)
>  	return 0;
>  }
> 
> +static int ej030na_enable(struct drm_panel *panel)
> +{
> +	struct ej030na *priv = to_ej030na(panel);
> +
> +	/* standby off */
> +	regmap_write(priv->map, 0x2b, 0x01);
> +
> +	if (panel->backlight) {
> +		/* Wait for the picture to be ready before enabling backlight */
> +		msleep(120);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ej030na_disable(struct drm_panel *panel)
> +{
> +	struct ej030na *priv = to_ej030na(panel);
> +
> +	/* standby on */
> +	regmap_write(priv->map, 0x2b, 0x00);
> +
> +	return 0;
> +}
> +
>  static int ej030na_get_modes(struct drm_panel *panel,
>  			     struct drm_connector *connector)
>  {
> @@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel 
> *panel,
>  static const struct drm_panel_funcs ej030na_funcs = {
>  	.prepare	= ej030na_prepare,
>  	.unprepare	= ej030na_unprepare,
> +	.enable		= ej030na_enable,
> +	.disable	= ej030na_disable,
>  	.get_modes	= ej030na_get_modes,
>  };
> 
> --
> 2.34.1
> 


