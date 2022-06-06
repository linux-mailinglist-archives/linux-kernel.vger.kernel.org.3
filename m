Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC62A53EE8D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiFFTZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiFFTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:25:17 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB150E06
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6Cg1ugMW2sgR40fh9Scahx5XXbaDSIss/S9MBAp8xq8=;
        b=ETNremb0uLGQKMa9jdGQJ2mGNnyNkXO2sPf08r/Z0bnFUkACFuvUBKMu1U6HNCSky8IqzL9AxavKd
         aoNnlzE6w67Kc8H5HUsEATZ50YDG1B0LFEy7qZCgP5xSdJbXT1TpeX5qI2okHWTEZptwbDhCdPm2H4
         IgOhPgdmwcFXNTT0Gw//7ajYP+ppdFccxK/S7Ney+1dWDHWMDL3laztIiI295Z4mM+i+TsAJ0xGXPa
         pClgkifJLS2q8tYRURntTr5T2lROayoQf/OUEqIcN/IZy+bGvKE8/CgYKgTrjyhFXHfORBjekidJMf
         uFxsoG5ADMIyWwXWOXg++N4MGQ41qeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6Cg1ugMW2sgR40fh9Scahx5XXbaDSIss/S9MBAp8xq8=;
        b=H4W1sEEIyckKy4ictTk9wQBkyCsvmPLwtpavm6fJMLh5D2dGa+zCB5sMBBKOPDG4Cwf4Ul/oZeZlX
         sy8p4T8CQ==
X-HalOne-Cookie: d1498cb72ad0f58e22308cc44230f2d4a7b4d137
X-HalOne-ID: 62ba285a-e5ce-11ec-a911-d0431ea8a290
Received: from mailproxy4.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 62ba285a-e5ce-11ec-a911-d0431ea8a290;
        Mon, 06 Jun 2022 19:25:13 +0000 (UTC)
Date:   Mon, 6 Jun 2022 21:25:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/8] drm/panel: panel-simple: Implement
 .get_orientation callback
Message-ID: <Yp5Ul/ODUB/sQ0Jf@ravnborg.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
 <20220606152431.1889185-6-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606152431.1889185-6-hsinyi@chromium.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Mon, Jun 06, 2022 at 11:24:28PM +0800, Hsin-Yi Wang wrote:
> To return the orientation property to drm/kms driver.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 4a2e580a2f7b..f232b8cf4075 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -411,7 +411,12 @@ static int panel_simple_get_modes(struct drm_panel *panel,
>  	/* add hard-coded panel modes */
>  	num += panel_simple_get_non_edid_modes(p, connector);
>  
> -	/* set up connector's "panel orientation" property */
> +	/*
> +	 * drm drivers are expected to call drm_panel_get_orientation() to get
> +	 * panel's orientation then drm_connector_set_panel_orientation() to
> +	 * set the property before drm_dev_register(). Otherwise there will be
> +	 * a WARN_ON if orientation is set after drm is registered.
> +	 */

This comment is not really relevant here. If we need to explain this
then put it in drm_panel.c/h - as this applies for all panels and not
just the panel_simple.
Keep in mind, this is the source new panels often use a inspiration and
no need to have this copied around.

>  	drm_connector_set_panel_orientation(connector, p->orientation);
>  
>  	return num;
> @@ -434,6 +439,14 @@ static int panel_simple_get_timings(struct drm_panel *panel,
>  	return p->desc->num_timings;
>  }
>  
> +static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
> +{
> +       struct panel_simple *p = to_panel_simple(panel);
> +
> +       return p->orientation;
> +}
> +
> +
>  static const struct drm_panel_funcs panel_simple_funcs = {
>  	.disable = panel_simple_disable,
>  	.unprepare = panel_simple_unprepare,
> @@ -441,6 +454,7 @@ static const struct drm_panel_funcs panel_simple_funcs = {
>  	.enable = panel_simple_enable,
>  	.get_modes = panel_simple_get_modes,
>  	.get_timings = panel_simple_get_timings,
> +	.get_orientation = panel_simple_get_orientation,

I like the order in this list to match the order in the .h file.
So my OCD would like you to move it up right after get_modes,
but feel free to ignore this.

With the suggested changes:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

>  };
>  
>  static struct panel_desc panel_dpi;
> -- 
> 2.36.1.255.ge46751e96f-goog
