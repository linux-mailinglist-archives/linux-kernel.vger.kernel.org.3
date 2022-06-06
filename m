Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F653EE75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiFFTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiFFTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:21:24 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E814087A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=bsO7yZsq6WgHwa/T9Pr5gaYQAXZ8gtEznFx8SQx+qfc=;
        b=L1gfAqSV85PV28u4ZNw6sT2fasgTWDxl2bTVb3LAc/SPW4xmkuuNovf1Ap1YuVS0Bgwjr9nn8ZXsl
         +f1tySHn5617WNbkacDt1JRWggSMyDDXhUxRrT5zTzZBN/OiWcAYt/hmbf7owIFJog8akkFSJunS3h
         EZn1pS5EXxJr6LuuAcd3Aq44MjR/x/ELx5PaLTzALwQhuDgzYFF7IfAuUVjmysatFCknd+N0HnMLtT
         ahDR5ANGsErMFpHH6L7n8zeh+SlqvcxKr5kHQM4GNbc77Lb4jcLaJF3oTA3TXFTAOL0Q4QsjQJuzB4
         La20QzQQe+H1M92fN9X3Ms7A4E4BBJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=bsO7yZsq6WgHwa/T9Pr5gaYQAXZ8gtEznFx8SQx+qfc=;
        b=TC4IXbo7to2hzL84wxc32MVECmma+pMj8vVtBtEoAbkthCYrWvrAYbZC+msb1ku1sZNZIFVgC6QaA
         FtLAj3GAQ==
X-HalOne-Cookie: a8c49c672b514c0c53227159aa925696221cf6c8
X-HalOne-ID: c3449a73-e5cd-11ec-a6bf-d0431ea8a283
Received: from mailproxy3.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id c3449a73-e5cd-11ec-a6bf-d0431ea8a283;
        Mon, 06 Jun 2022 19:20:45 +0000 (UTC)
Date:   Mon, 6 Jun 2022 21:20:43 +0200
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
Subject: Re: [PATCH v4 1/8] drm/panel: Add an API drm_panel_get_orientation()
 to return panel orientation
Message-ID: <Yp5Ti3ov/fnw0xeQ@ravnborg.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
 <20220606152431.1889185-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606152431.1889185-2-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,
On Mon, Jun 06, 2022 at 11:24:24PM +0800, Hsin-Yi Wang wrote:
> Panels usually call drm_connector_set_panel_orientation(), which is
> later than drm/kms driver calling drm_dev_register(). This leads to a
> WARN().
> 
> The orientation property is known earlier. For example, some panels
> parse the property through device tree during probe.
> 
> Add an API to return the property from panel to drm/kms driver, so the
> drivers are able to call drm_connector_set_panel_orientation() before
> drm_dev_register().
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v3->v4: Add a blank line.
> ---
>  drivers/gpu/drm/drm_panel.c |  9 +++++++++
>  include/drm/drm_panel.h     | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..e12056cfeca8 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -223,6 +223,15 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
>  
> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel)
const as mentioned by Stephen.

> +{
> +	if (panel && panel->funcs && panel->funcs->get_orientation)
> +		return panel->funcs->get_orientation(panel);
> +
> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +EXPORT_SYMBOL(drm_panel_get_orientation);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_panel - look up a panel using a device tree node
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index d279ee455f01..5dadbf3b0370 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -133,6 +133,15 @@ struct drm_panel_funcs {
>  	 * Allows panels to create panels-specific debugfs files.
>  	 */
>  	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
> +
> +	/**
> +	 * @get_orientation:
> +	 *
> +	 * Return the panel orientation set by device tree or EDID.
> +	 *
> +	 * This function is optional.
> +	 */
> +	enum drm_panel_orientation (*get_orientation)(struct drm_panel *panel);

Please move this up so it is together with the other get_* methods, in
alphabetic order. That is, right after get_modes(), and then this also
matches the order in the .c file with is extra bonus.

With the two fixes:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

>  };
>  
>  /**
> @@ -202,6 +211,7 @@ int drm_panel_enable(struct drm_panel *panel);
>  int drm_panel_disable(struct drm_panel *panel);
>  
>  int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
> +enum drm_panel_orientation drm_panel_get_orientation(struct drm_panel *panel);
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
>  struct drm_panel *of_drm_find_panel(const struct device_node *np);
> -- 
> 2.36.1.255.ge46751e96f-goog
