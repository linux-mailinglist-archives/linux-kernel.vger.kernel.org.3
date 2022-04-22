Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4250BECE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiDVRim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiDVRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:38:26 -0400
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27915821;
        Fri, 22 Apr 2022 10:35:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 653F8FB04;
        Fri, 22 Apr 2022 19:24:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FUzJat0K8MxW; Fri, 22 Apr 2022 19:24:21 +0200 (CEST)
Date:   Fri, 22 Apr 2022 19:24:15 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: Re: [PATCH resend v8 1/5] drm/bridge: nwl-dsi: Set PHY mode in
 nwl_dsi_mode_set()
Message-ID: <YmLkv4PYsi+XiFr5@qwark.sigxcpu.org>
References: <20220419010852.452169-1-victor.liu@nxp.com>
 <20220419010852.452169-2-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419010852.452169-2-victor.liu@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Apr 19, 2022 at 09:08:48AM +0800, Liu Ying wrote:
> The Northwest Logic MIPI DSI host controller embedded in i.MX8qxp
> works with a Mixel MIPI DPHY + LVDS PHY combo to support either
> a MIPI DSI display or a LVDS display.  So, this patch calls
> phy_set_mode() from nwl_dsi_mode_set() to set PHY mode to MIPI DPHY
> explicitly.
> 
> Cc: Guido Günther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v7->v8:
> * Resend with Andrzej's and Jernej's mail addressed updated.
> 
> v6->v7:
> * No change.
> 
> v5->v6:
> * Rebase the series upon v5.17-rc1.
> * Set PHY mode in ->mode_set() instead of ->pre_enable() in the nwl-dsi
>   bridge driver due to the rebase.
> * Drop Guido's R-b tag due to the rebase.
> 
> v4->v5:
> * No change.
> 
> v3->v4:
> * No change.
> 
> v2->v3:
> * No change.
> 
> v1->v2:
> * Add Guido's R-b tag.
> 
>  drivers/gpu/drm/bridge/nwl-dsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index d5945501a5ee..85bab7372af1 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -666,6 +666,12 @@ static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
>  		return ret;
>  	}
>  
> +	ret = phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
> +	if (ret < 0) {
> +		DRM_DEV_ERROR(dev, "Failed to set DSI phy mode: %d\n", ret);
> +		goto uninit_phy;
> +	}
> +
>  	ret = phy_configure(dsi->phy, phy_cfg);
>  	if (ret < 0) {
>  		DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n",
> ret);

I can't currently test this but it still looks good so

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> -- 
> 2.25.1
> 
