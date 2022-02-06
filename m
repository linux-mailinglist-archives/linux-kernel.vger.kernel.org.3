Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D44AB263
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiBFVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBFVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:33:15 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1EC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:33:13 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 87b6f5d4-8794-11ec-b20b-0050568c148b;
        Sun, 06 Feb 2022 21:34:14 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id F280B194BAB;
        Sun,  6 Feb 2022 22:33:11 +0100 (CET)
Date:   Sun, 6 Feb 2022 22:33:09 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robert.foss@linaro.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kieran.bingham@ideasonboard.com,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent.pinchart@ideasonboard.com, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH v3] drm/bridge: dw-hdmi: use safe format when first in
 bridge chain
Message-ID: <YgA+lcSNaQ2x4Wef@ravnborg.org>
References: <20220204143337.89221-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204143337.89221-1-narmstrong@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neail,

On Fri, Feb 04, 2022 at 03:33:37PM +0100, Neil Armstrong wrote:
> When the dw-hdmi bridge is in first place of the bridge chain, this
> means there is no way to select an input format of the dw-hdmi HW
> component.
> 
> Since introduction of display-connector, negotiation was broken since
> the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
> in last position of the bridge chain or behind another bridge also
> supporting input & output format negotiation.
> 
> Commit 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks")
> was introduced to make negotiation work again by making display-connector
> act as a pass-through concerning input & output format negotiation.
> 
> But in the case where the dw-hdmi is single in the bridge chain, for
> example on Renesas SoCs, with the display-connector bridge the dw-hdmi
> is no more single, breaking output format.

I have forgotten all the details during my leave from drm, so I
may miss something obvious.
This fix looks like it papers over some general thingy with the
format negotiation.

We do not want to see the below in all display drivers, so
I assume the right fix is to stuff it in somewhere in the framework.

Or do I miss something?

	Sam


> 
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Fixes: 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks").
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
> Changes since v2:
> - Add rob's r-b
> - Fix invalid Fixes commit hash
> 
> Changes since v1:
> - Remove bad fix in dw_hdmi_bridge_atomic_get_input_bus_fmts
> - Fix typos in commit message
> 
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 54d8fdad395f..97cdc61b57f6 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>  	if (!output_fmts)
>  		return NULL;
>  
> -	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
> -	if (list_is_singular(&bridge->encoder->bridge_chain)) {
> +	/* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
> +	if (list_is_singular(&bridge->encoder->bridge_chain) ||
> +	    list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
>  		*num_output_fmts = 1;
>  		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>  
> -- 
> 2.25.1
