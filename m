Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01946741C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350990AbhLCJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351014AbhLCJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:35:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94639C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:31:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20D70A59;
        Fri,  3 Dec 2021 10:31:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638523911;
        bh=cueI/YmVV/YcT/iLZPnRyFUh3veKPm4QBnkcjYX8A3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhKtUnfEKlw/BTbF1zxMBA9RD4jepX7WZ/vTULQ1H0c+w4SAx+iknrYmwZs59o/bo
         VoplPT7WzwmSP2VVjX8CWuZdEDb/Ob4Fv7ofGJQRjB7oCwGuTgd9TRPwkh7UKFbMFA
         spztBVLy+No/t6y8XJWb+vbtXm8TnHJAV5UWKdSM=
Date:   Fri, 3 Dec 2021 11:31:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yannick Fertre <yannick.fertre@foss.st.com>
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: remove error message for EPROBE_DEFER in
 bridge_attach
Message-ID: <Yanj7O9Kktw8PPY1@pendragon.ideasonboard.com>
References: <20211203085931.11693-1-yannick.fertre@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203085931.11693-1-yannick.fertre@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannick,

Thank you for the patch.

On Fri, Dec 03, 2021 at 09:59:31AM +0100, Yannick Fertre wrote:
> Probe deferred is not an error, don't print it.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index c96847fc0ebc..cef0a62ef5d0 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -288,11 +288,13 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  	list_del(&bridge->chain_node);
>  
>  #ifdef CONFIG_OF
> -	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> -		  bridge->of_node, encoder->name, ret);
> +	if (ret != -EPROBE_DEFER)
> +		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> +			  bridge->of_node, encoder->name, ret);
>  #else
> -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> -		  encoder->name, ret);
> +	if (ret != -EPROBE_DEFER)
> +		DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> +			  encoder->name, ret);

It's useful to know about what caused a probe deferral though. There's
now a dev_err_probe() function that prints the message as an dev_err if
the error code is not -EPROBE_DEFER, and as dev_dbg otherwise. It's
meant for probe time only though, so I don't think it can be used here,
but a similar feature could be useful. Or dev_err_probe() could be
extended to support non-probe use cases, but that would be more
difficult.

>  #endif
>  
>  	return ret;

-- 
Regards,

Laurent Pinchart
