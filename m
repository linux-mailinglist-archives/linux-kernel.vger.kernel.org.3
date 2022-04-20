Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E6509379
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383147AbiDTXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383141AbiDTXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:19:55 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA818E03
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:17:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5e433d66dso3647533fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vliR5m4+9Io2lsKOoIVUBS6H3HJfYGUKUnCPcRHXbHc=;
        b=Mm8xHxm1KXW4R/PQpGJk73bpm/m/PPNPif5efxIB2A29vM2A729AeTgLcO1pxSY4Ho
         IDMq+0HIKx68vqPrTIqetfJ8vr8WY3YrMod3KzVfUaVD6YGerW/LFzspcu+asS+e8RS+
         9fH8g/9ka+g7i4zNk0SyrHzPEOGRqTAnImxZ2cxdldUSXhtVHzwPmbNWbj8YaBgzvES+
         yoWbfmncvhFPSKRSlAHcsEP4/w5apAK0GJ2eYmzt/I1NxVVM2u+B2LaF0Cu6c3OmWf7A
         QYHylq4xftIkatQZCbAjzfoLFKFEUg/sziSNL286M+BK1EDOc1JyIzDs+pXQ/LW9MDBv
         ymKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vliR5m4+9Io2lsKOoIVUBS6H3HJfYGUKUnCPcRHXbHc=;
        b=3fv0/YJvgljhjun6RLZSaWRcHjoFHp3GMevmEXZBPK4dolVSupZwnV4TmYlOXNL3Mp
         WGkn7e9UVv43EDtwzMs2K/LiMpSv2DPcukj8iHalTWEANyASV2/SLvP9kZByDh53wvco
         8drVhznYzcd13SxIdz5X47acdp4CiNjAROz7q//w/WyFoVCNzqDEvqQ4jAPLdQM0AREv
         gfLPtsRylvDEk5LNQsKsQy/orwCV/cUfkVrMBM+6d4A9nFY9/94L2PaSatc7sQ30B7jB
         +nuCXqGStFJUvpGqQ9WViKLiKX13DrMiKC0Up4gLMsveM6Ws+1XI0hnriq3oRPd3aNec
         AAJg==
X-Gm-Message-State: AOAM5332XIusLzK1RfF9kcu8pEkzg8YC0Ti/CNzfZrUXD6Sm6JDG75aA
        KpTAHk5Q/lyRS3kROJL/6ZWCrw==
X-Google-Smtp-Source: ABdhPJxo5jgjf2YdQ3EWrP/Sx4Xzsr3pB+WFBSX++5bjBY9vN8gA6ZqMT/9awz/BK2ls1V17owxGcw==
X-Received: by 2002:a05:6870:fba0:b0:e5:ad3c:32d7 with SMTP id kv32-20020a056870fba000b000e5ad3c32d7mr2506634oab.144.1650496626144;
        Wed, 20 Apr 2022 16:17:06 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a7505000000b0033a47bb6a74sm2552361ooc.47.2022.04.20.16.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 16:17:05 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:19:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "drm: of: Properly try all possible cases for
 bridge/panel detection"
Message-ID: <YmCU7YLx/+ILPptK@ripper>
References: <20220420231230.58499-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420231230.58499-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Apr 16:12 PDT 2022, Bjorn Andersson wrote:

Sorry, I missed Jagan and Linus, author and reviewer of the reverted
patch 2, among the recipients.

Regards,
Bjorn

> Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> bridge")' introduced the ability to describe a panel under a display
> controller without having to use a graph to connect the controller to
> its single child panel (or bridge).
> 
> The implementation of this would find the first non-graph node and
> attempt to acquire the related panel or bridge. This prevents cases
> where any other child node, such as a aux bus for a DisplayPort
> controller, or an opp-table to find the referenced panel.
> 
> Commit '67bae5f28c89 ("drm: of: Properly try all possible cases for
> bridge/panel detection")' attempted to solve this problem by not
> bypassing the graph reference lookup before attempting to find the panel
> or bridge.
> 
> While this does solve the case where a proper graph reference is
> present, it does not allow the caller to distinguish between a
> yet-to-be-probed panel or bridge and the absence of a reference to a
> panel.
> 
> One such case is a DisplayPort controller that on some boards have an
> explicitly described reference to a panel, but on others have a
> discoverable DisplayPort display attached (which doesn't need to be
> expressed in DeviceTree).
> 
> This reverts commit '67bae5f28c89 ("drm: of: Properly try all possible
> cases for bridge/panel detection")', as a step towards reverting commit
> '80253168dbfd ("drm: of: Lookup if child node has panel or bridge")'.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/drm_of.c | 99 ++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index f4df344509a8..026e4e29a0f3 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -214,29 +214,6 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
>  }
>  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
>  
> -static int find_panel_or_bridge(struct device_node *node,
> -				struct drm_panel **panel,
> -				struct drm_bridge **bridge)
> -{
> -	if (panel) {
> -		*panel = of_drm_find_panel(node);
> -		if (!IS_ERR(*panel))
> -			return 0;
> -
> -		/* Clear the panel pointer in case of error. */
> -		*panel = NULL;
> -	}
> -
> -	/* No panel found yet, check for a bridge next. */
> -	if (bridge) {
> -		*bridge = of_drm_find_bridge(node);
> -		if (*bridge)
> -			return 0;
> -	}
> -
> -	return -EPROBE_DEFER;
> -}
> -
>  /**
>   * drm_of_find_panel_or_bridge - return connected panel or bridge device
>   * @np: device tree node containing encoder output ports
> @@ -259,44 +236,66 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>  				struct drm_panel **panel,
>  				struct drm_bridge **bridge)
>  {
> -	struct device_node *node;
> -	int ret;
> +	int ret = -EPROBE_DEFER;
> +	struct device_node *remote;
>  
>  	if (!panel && !bridge)
>  		return -EINVAL;
> -
>  	if (panel)
>  		*panel = NULL;
> -	if (bridge)
> -		*bridge = NULL;
> -
> -	/* Check for a graph on the device node first. */
> -	if (of_graph_is_present(np)) {
> -		node = of_graph_get_remote_node(np, port, endpoint);
> -		if (node) {
> -			ret = find_panel_or_bridge(node, panel, bridge);
> -			of_node_put(node);
> -
> -			if (!ret)
> -				return 0;
> -		}
> -	}
>  
> -	/* Otherwise check for any child node other than port/ports. */
> -	for_each_available_child_of_node(np, node) {
> -		if (of_node_name_eq(node, "port") ||
> -		    of_node_name_eq(node, "ports"))
> +	/**
> +	 * Devices can also be child nodes when we also control that device
> +	 * through the upstream device (ie, MIPI-DCS for a MIPI-DSI device).
> +	 *
> +	 * Lookup for a child node of the given parent that isn't either port
> +	 * or ports.
> +	 */
> +	for_each_available_child_of_node(np, remote) {
> +		if (of_node_name_eq(remote, "port") ||
> +		    of_node_name_eq(remote, "ports"))
>  			continue;
>  
> -		ret = find_panel_or_bridge(node, panel, bridge);
> -		of_node_put(node);
> +		goto of_find_panel_or_bridge;
> +	}
> +
> +	/*
> +	 * of_graph_get_remote_node() produces a noisy error message if port
> +	 * node isn't found and the absence of the port is a legit case here,
> +	 * so at first we silently check whether graph presents in the
> +	 * device-tree node.
> +	 */
> +	if (!of_graph_is_present(np))
> +		return -ENODEV;
> +
> +	remote = of_graph_get_remote_node(np, port, endpoint);
> +
> +of_find_panel_or_bridge:
> +	if (!remote)
> +		return -ENODEV;
> +
> +	if (panel) {
> +		*panel = of_drm_find_panel(remote);
> +		if (!IS_ERR(*panel))
> +			ret = 0;
> +		else
> +			*panel = NULL;
> +	}
> +
> +	/* No panel found yet, check for a bridge next. */
> +	if (bridge) {
> +		if (ret) {
> +			*bridge = of_drm_find_bridge(remote);
> +			if (*bridge)
> +				ret = 0;
> +		} else {
> +			*bridge = NULL;
> +		}
>  
> -		/* Stop at the first found occurrence. */
> -		if (!ret)
> -			return 0;
>  	}
>  
> -	return -EPROBE_DEFER;
> +	of_node_put(remote);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
>  
> -- 
> 2.35.1
> 
