Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1C4B35B1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiBLOpV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Feb 2022 09:45:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiBLOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:45:19 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E9214;
        Sat, 12 Feb 2022 06:45:13 -0800 (PST)
Date:   Sat, 12 Feb 2022 14:44:56 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v14 1/9] drm/ingenic: Add support for JZ4780 and HDMI
 output
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Message-Id: <WY477R.1XWC44S25QIN3@crapouillou.net>
In-Reply-To: <31eff2819f94fefcb01aa5cb23c79ccf302d9238.1644675566.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
        <31eff2819f94fefcb01aa5cb23c79ccf302d9238.1644675566.git.hns@goldelico.com>
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

Hi Nikolaus,

Le sam., févr. 12 2022 at 15:19:19 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> From: Paul Boddie <paul@boddie.org.uk>
> 
> Add support for the LCD controller present on JZ4780 SoCs.
> This SoC uses 8-byte descriptors which extend the current
> 4-byte descriptors used for other Ingenic SoCs.
> 
> Note that plane f0 is not working and disabled to be
> seen from user-space.
> 
> Tested on MIPS Creator CI20 board.

That's not really what the patch does though. It's a fix for a commit 
that has the exact same title and description, and is already merged: 
b807fd2c43fe ("drm/ingenic: Add support for JZ4780 and HDMI output").

Please rewrite the patch's title and description to actually describe 
its purpose.

Cheers,
-Paul

> 
> Signed-off-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c 
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 7f10d6eed549d..dcf44cb00821f 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -65,8 +65,10 @@ struct ingenic_dma_hwdescs {
>  struct jz_soc_info {
>  	bool needs_dev_clk;
>  	bool has_osd;
> +	bool has_alpha;
>  	bool map_noncoherent;
>  	bool use_extended_hwdesc;
> +	bool plane_f0_not_working;
>  	unsigned int max_width, max_height;
>  	const u32 *formats_f0, *formats_f1;
>  	unsigned int num_formats_f0, num_formats_f1;
> @@ -453,7 +455,7 @@ static int ingenic_drm_plane_atomic_check(struct 
> drm_plane *plane,
>  	if (!crtc)
>  		return 0;
> 
> -	if (plane == &priv->f0)
> +	if (priv->soc_info->plane_f0_not_working && plane == &priv->f0)
>  		return -EINVAL;
> 
>  	crtc_state = drm_atomic_get_existing_crtc_state(state,
> @@ -1055,6 +1057,7 @@ static int ingenic_drm_bind(struct device *dev, 
> bool has_components)
>  	long parent_rate;
>  	unsigned int i, clone_mask = 0;
>  	int ret, irq;
> +	u32 osdc = 0;
> 
>  	soc_info = of_device_get_match_data(dev);
>  	if (!soc_info) {
> @@ -1312,7 +1315,10 @@ static int ingenic_drm_bind(struct device 
> *dev, bool has_components)
> 
>  	/* Enable OSD if available */
>  	if (soc_info->has_osd)
> -		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
> +		osdc |= JZ_LCD_OSDC_OSDEN;
> +	if (soc_info->has_alpha)
> +		osdc |= JZ_LCD_OSDC_ALPHAEN;
> +	regmap_write(priv->map, JZ_REG_LCD_OSDC, osdc);
> 
>  	mutex_init(&priv->clk_mutex);
>  	priv->clock_nb.notifier_call = ingenic_drm_update_pixclk;
> @@ -1511,7 +1517,9 @@ static const struct jz_soc_info jz4770_soc_info 
> = {
>  static const struct jz_soc_info jz4780_soc_info = {
>  	.needs_dev_clk = true,
>  	.has_osd = true,
> +	.has_alpha = true,
>  	.use_extended_hwdesc = true,
> +	.plane_f0_not_working = true,	/* REVISIT */
>  	.max_width = 4096,
>  	.max_height = 2048,
>  	.formats_f1 = jz4770_formats_f1,
> --
> 2.33.0
> 


