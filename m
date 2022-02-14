Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D34B4CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiBNKuY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 05:50:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349339AbiBNKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:49:47 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9B652CE;
        Mon, 14 Feb 2022 02:13:54 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:13:37 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v15 1/7] drm/ingenic: Fix support for JZ4780 HDMI output
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Message-Id: <PQHA7R.CIX6XS4CFLMM3@crapouillou.net>
In-Reply-To: <9d3a2000d2bb014f1afb0613537bdc523202135d.1644681054.git.hns@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
        <9d3a2000d2bb014f1afb0613537bdc523202135d.1644681054.git.hns@goldelico.com>
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

Hi,

Le sam., févr. 12 2022 at 16:50:49 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> From: Paul Boddie <paul@boddie.org.uk>
> 
> We have to make sure that
> - JZ_LCD_OSDC_ALPHAEN is set
> - plane f0 is disabled and not seen from user-space

Actually it will still be seen from user-space, but it won't be 
possible to use it. So before applying I'll change this to:
"plane f0 is disabled as it's not working yet"

If that's OK with you.

Cheers,
-Paul

> 
> Tested on MIPS Creator CI20 board.
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


