Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C602E462B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbhK3Dvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhK3Dvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:51:52 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892AC061574;
        Mon, 29 Nov 2021 19:48:34 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 642AB8F0;
        Tue, 30 Nov 2021 04:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638244111;
        bh=Ju85iL4hNDoC8/eyKjROgknF4Z5dOgHf2nxHw5W0fyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXXt811b8LE70eYPo2ULKzDpORmN/2tq+qjrkMX1DRvLYrQjfD29lRn/qNJWSsFbG
         sWYocMrPzrwfOTPubgPTN58Nxv3dn4dRXvBGIVZHfcwhQAXqome8QRWRF3dMGG9wpM
         HELbLmvn+QM54/Mzgt9CmknWjsYfTdCrt5E3o4w0=
Date:   Tue, 30 Nov 2021 05:48:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: crtc: Support external DSI dot clock
Message-ID: <YaWe9nOzk+zN9d5u@pendragon.ideasonboard.com>
References: <20211126093514.927340-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126093514.927340-1-kieran.bingham+renesas@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, Nov 26, 2021 at 09:35:14AM +0000, Kieran Bingham wrote:
> On platforms with an external clock, both the group and crtc must be
> handled accordingly to correctly pass through the external clock and
> configure the DU to use the external rate.
> 
> The CRTC support was missed while adding the DSI support on the r8a779a0
> which led to the output clocks being incorrectly determined.
> 
> Ensure that when a CRTC is routed through the DSI encoder, the external
> clock is used without any further divider being applied.
> 
> Fixes: b291fdcf5114 ("drm: rcar-du: Add r8a779a0 device support")
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index 5672830ca184..5236f917cc68 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -261,12 +261,13 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
>  		rcar_du_group_write(rcrtc->group, DPLLCR, dpllcr);
>  
>  		escr = ESCR_DCLKSEL_DCLKIN | div;
> -	} else if (rcdu->info->lvds_clk_mask & BIT(rcrtc->index)) {
> +	} else if (rcdu->info->lvds_clk_mask & BIT(rcrtc->index) ||
> +		   rcdu->info->dsi_clk_mask & BIT(rcrtc->index)) {
>  		/*
> -		 * Use the LVDS PLL output as the dot clock when outputting to
> -		 * the LVDS encoder on an SoC that supports this clock routing
> -		 * option. We use the clock directly in that case, without any
> -		 * additional divider.
> +		 * Use the external LVDS or DSI PLL output as the dot clock when
> +		 * outputting to the LVDS or DSI encoder on an SoC that supports
> +		 * this clock routing option. We use the clock directly in that
> +		 * case, without any additional divider.
>  		 */
>  		escr = ESCR_DCLKSEL_DCLKIN;
>  	} else {

-- 
Regards,

Laurent Pinchart
