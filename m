Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88E4F0720
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 05:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiDCDic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 23:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiDCDi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 23:38:28 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F3A2ED59
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 20:36:34 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so1220214ooi.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 20:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/FFMNCxs1rKedJSeaUV6rUpEbYQaPXqMnuaclaOGRRk=;
        b=sfYDlLwdxPLHDhKGhWH11yrlLThw1Jf/JVXgaObu16Brb1ggCE3DIns4wEF6IEm788
         sfbSAKmugjiILjGBo2NrcBQS6awopMY73mL4nu1MZNOXBfMIUHfNUInfvCSKXvKgJqEL
         cMupV1B3TxdmvXt1hDTwS3IJmr3n9UWMPddg1IH0/Z6XKFzD457rZaRVctbbjYfp9FbL
         nQqKcOg15IGI289wznKu2isJbgMKmJ+N08IeAgg6/gErDFPEp6Oey1Ws8lvP3SMVRX3K
         IlHHfPcKJuGNVL7et6iZtChsZax1tXrSo8wzhEmAYnenOzi+L6cSfVz6GYMwjSeQfRtf
         FCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/FFMNCxs1rKedJSeaUV6rUpEbYQaPXqMnuaclaOGRRk=;
        b=ubiKJd0vLRKVBOWBNKXH7sEq9TSAZ3gsi0dKDusqron3quPFLT9zmAjYbCCLHQNDx0
         Oc49uaS0hEAUhFKrVAYhrjfYU2dpQz0ZbNKbSxvnB/VWDoZBM1j+RmijvSORbXXvdEhD
         5F3N7jPlXH/I5KX76EzKKX6mINBDfsgt/jRzmqFYvdvte2vSsBybbewu7I9rkxsDH6X9
         0IAjVu7k2bsf/Neog5350N+fF5RIR7k/olYZ340Pq78wMQo/cKjmWA1cBB4lIDe6W+g5
         PPl4zSyVVD0X3FsnQk9OOXJBuNKjjaV2zpcZGU7HAW/1QShhlo45TP/0JFqo5F+j1L3t
         BCaQ==
X-Gm-Message-State: AOAM532/254xsTbwf8sywANuTPJNeWWXkx82yX02/R8lC3qlJBnSINA7
        QUYfnqyzUDHGJ55gk+w1benn5m/LdNimkg==
X-Google-Smtp-Source: ABdhPJyOk7XfWol7p76026ejNpYTK/RPAAxPk2nIHAk2FVIozKm8v+HJ+5B5+8dpKjImxm4avLV/yg==
X-Received: by 2002:a4a:de16:0:b0:321:3be1:803e with SMTP id y22-20020a4ade16000000b003213be1803emr8866871oot.71.1648956993562;
        Sat, 02 Apr 2022 20:36:33 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t1-20020a056870608100b000e1f296e09csm181752oae.31.2022.04.02.20.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 20:36:32 -0700 (PDT)
Date:   Sat, 2 Apr 2022 20:38:59 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] drm: of: Properly try all possible cases for
 bridge/panel detection
Message-ID: <YkkW028/QOwpYqxD@ripper>
References: <20220329132732.628474-1-paul.kocialkowski@bootlin.com>
 <YkZulslrzeurp43U@ripper>
 <YkatbpubQjwBWOiK@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkatbpubQjwBWOiK@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01 Apr 00:44 PDT 2022, Paul Kocialkowski wrote:

> Hi Bjorn,
> 
> On Thu 31 Mar 22, 20:16, Bjorn Andersson wrote:
> > On Tue 29 Mar 06:27 PDT 2022, Paul Kocialkowski wrote:
> > 
> > > While bridge/panel detection was initially relying on the usual
> > > port/ports-based of graph detection, it was recently changed to
> > > perform the lookup on any child node that is not port/ports
> > > instead when such a node is available, with no fallback on the
> > > usual way.
> > > 
> > > This results in breaking detection when a child node is present
> > > but does not contain any panel or bridge node, even when the
> > > usual port/ports-based of graph is there.
> > > 
> > > In order to support both situations properly, this commit reworks
> > > the logic to try both options and not just one of the two: it will
> > > only return -EPROBE_DEFER when both have failed.
> > > 
> > 
> > Thanks for your patch Paul, it fixed a regression on a device where I
> > have a eDP bridge with an of_graph and a aux-bus defined.
> > 
> > But unfortunately it does not resolve the regression I have for the
> > USB based DisplayPort setup described below.
> > 
> > 
> > In the Qualcomm DisplayPort driver We're calling:
> > 
> > 	devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> > 
> > and with the following DT snippet the behavior changed:
> > 
> > displayport-controller@ae90000 {
> > 	compatible = "qcom,sc8180x-dp";
> > 	...
> > 
> > 	operating-points-v2 = <&dp0_opp_table>;
> > 
> > 	ports {
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 
> > 		port@0 {
> > 			reg = <0>;
> > 			dp0_in: endpoint {
> > 				remote-endpoint = <&display_driver>;
> > 			};
> > 		};
> > 	};
> > 
> > 	dp0_opp_table: opp-table {
> > 		...;
> > 	};
> > };
> > 
> > Prior to the introduction of 80253168dbfd ("drm: of: Lookup if child
> > node has panel or bridge") this would return -ENODEV, so we could
> > differentiate the case when we have a statically defined eDP panel from
> > that of a dynamically attached (over USB) DP panel.
> > 
> > Prior to your change, above case without the opp-table node would have
> > still returned -ENODEV.
> > 
> > But now this will just return -EPROBE_DEFER in both cases.
> 
> Oh that's right, the -ENODEV case was just completely removed by my change.
> Initially this would happen if !of_graph_is_present or if the remote node
> doesn't exist.
> 
> Now that we are also checking for child nodes, we can't just return -ENODEV
> when the graph or remote node is missing: we must also check that there is no
> child node that is a panel/bridge.
> 
> For the graph remote case, we can reliabily return -EPROBE_DEFER when
> of_graph_is_present and the remote exists and of_device_is_available.

Right, if I have a of_graph port@1 which references something that isn't
available we can reliably claim this is -EPROBE_DEFER.

> Otherwise we can go for -ENODEV.

Are you suggesting that if we find a "port" or "ports" we return -ENODEV
if we didn't find the requested port@N?

> I think getting -EPROBE_DEFER at this point
> should stop the drm_of_find_panel_or_bridge process.
> 

I think that makes sense, i.e. if we found an of_graph reference, but
it's not a panel yet.

> On the other hand for the child panel/bridge node case, I don't see how we
> can reliably distinguish between -EPROBE_DEFER and -ENODEV, because
> of_drm_find_panel and of_drm_find_bridge will behave the same if the child
> node is a not-yet-probed panel/bridge or a totally unrelated node.
> So I think we should always return -EPROBE_DEFER in that case.
> 
> As a result you can't get -ENODEV if using the of graph while having any
> (unrelated) child node there, so your issue remains.
> 
> Do you see any way we could make this work?
> 

I'm afraid I don't have any good suggestions on determining if that
child node is a panel/bridge or something else.

> > I thought the appropriate method of referencing the dsi panel was to
> > actually reference that using the of_graph, even though it's a child of
> > the dsi controller - that's at least how we've done it in e.g. [1].
> > I find this to be much nicer than to just blindly define that all
> > children of any sort of display controller must be a bridge or a panel.
> 
> Yes I totally agree. Given that using the child node directly apparently
> can't allow us to distinguish between -EPROBE_DEFER/-ENODEV I would be in
> favor of dropping this mechanism and going with explicit of graph in any case
> (even if it's a child node). I don't see any downside to this approach.
> 
> What do yout think?
> 

The explicit of_graph reference is a little bit clunky, but it's clear
and doesn't rely on "skipping" or only including names based on
particular names etc.

So I am in favour of reverting this back to the explicit reference.

Regards,
Bjorn

> Paul
> 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845-mtp.dts#n436
> > 
> > Regards,
> > Bjorn
> > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > Fixes: 80253168dbfd ("drm: of: Lookup if child node has panel or bridge")
> > > ---
> > > 
> > > Changes since v2:
> > > - Removed unnecessary else statement and added a comment about
> > >   clearing the panel pointer on error.
> > > 
> > > Changes since v1:
> > > - Renamed remote to node;
> > > - Renamed helper to find_panel_or_bridge;
> > > - Cleared bridge pointer early;
> > > - Returned early to make the code more concise;
> > > 
> > > ---
> > >  drivers/gpu/drm/drm_of.c | 99 ++++++++++++++++++++--------------------
> > >  1 file changed, 50 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > > index 9d90cd75c457..8716da6369a6 100644
> > > --- a/drivers/gpu/drm/drm_of.c
> > > +++ b/drivers/gpu/drm/drm_of.c
> > > @@ -219,6 +219,29 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
> > >  
> > > +static int find_panel_or_bridge(struct device_node *node,
> > > +				struct drm_panel **panel,
> > > +				struct drm_bridge **bridge)
> > > +{
> > > +	if (panel) {
> > > +		*panel = of_drm_find_panel(node);
> > > +		if (!IS_ERR(*panel))
> > > +			return 0;
> > > +
> > > +		/* Clear the panel pointer in case of error. */
> > > +		*panel = NULL;
> > > +	}
> > > +
> > > +	/* No panel found yet, check for a bridge next. */
> > > +	if (bridge) {
> > > +		*bridge = of_drm_find_bridge(node);
> > > +		if (*bridge)
> > > +			return 0;
> > > +	}
> > > +
> > > +	return -EPROBE_DEFER;
> > > +}
> > > +
> > >  /**
> > >   * drm_of_find_panel_or_bridge - return connected panel or bridge device
> > >   * @np: device tree node containing encoder output ports
> > > @@ -241,66 +264,44 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
> > >  				struct drm_panel **panel,
> > >  				struct drm_bridge **bridge)
> > >  {
> > > -	int ret = -EPROBE_DEFER;
> > > -	struct device_node *remote;
> > > +	struct device_node *node;
> > > +	int ret;
> > >  
> > >  	if (!panel && !bridge)
> > >  		return -EINVAL;
> > > +
> > >  	if (panel)
> > >  		*panel = NULL;
> > > -
> > > -	/**
> > > -	 * Devices can also be child nodes when we also control that device
> > > -	 * through the upstream device (ie, MIPI-DCS for a MIPI-DSI device).
> > > -	 *
> > > -	 * Lookup for a child node of the given parent that isn't either port
> > > -	 * or ports.
> > > -	 */
> > > -	for_each_available_child_of_node(np, remote) {
> > > -		if (of_node_name_eq(remote, "port") ||
> > > -		    of_node_name_eq(remote, "ports"))
> > > -			continue;
> > > -
> > > -		goto of_find_panel_or_bridge;
> > > +	if (bridge)
> > > +		*bridge = NULL;
> > > +
> > > +	/* Check for a graph on the device node first. */
> > > +	if (of_graph_is_present(np)) {
> > > +		node = of_graph_get_remote_node(np, port, endpoint);
> > > +		if (node) {
> > > +			ret = find_panel_or_bridge(node, panel, bridge);
> > > +			of_node_put(node);
> > > +
> > > +			if (!ret)
> > > +				return 0;
> > > +		}
> > >  	}
> > >  
> > > -	/*
> > > -	 * of_graph_get_remote_node() produces a noisy error message if port
> > > -	 * node isn't found and the absence of the port is a legit case here,
> > > -	 * so at first we silently check whether graph presents in the
> > > -	 * device-tree node.
> > > -	 */
> > > -	if (!of_graph_is_present(np))
> > > -		return -ENODEV;
> > > -
> > > -	remote = of_graph_get_remote_node(np, port, endpoint);
> > > -
> > > -of_find_panel_or_bridge:
> > > -	if (!remote)
> > > -		return -ENODEV;
> > > +	/* Otherwise check for any child node other than port/ports. */
> > > +	for_each_available_child_of_node(np, node) {
> > > +		if (of_node_name_eq(node, "port") ||
> > > +		    of_node_name_eq(node, "ports"))
> > > +			continue;
> > >  
> > > -	if (panel) {
> > > -		*panel = of_drm_find_panel(remote);
> > > -		if (!IS_ERR(*panel))
> > > -			ret = 0;
> > > -		else
> > > -			*panel = NULL;
> > > -	}
> > > -
> > > -	/* No panel found yet, check for a bridge next. */
> > > -	if (bridge) {
> > > -		if (ret) {
> > > -			*bridge = of_drm_find_bridge(remote);
> > > -			if (*bridge)
> > > -				ret = 0;
> > > -		} else {
> > > -			*bridge = NULL;
> > > -		}
> > > +		ret = find_panel_or_bridge(node, panel, bridge);
> > > +		of_node_put(node);
> > >  
> > > +		/* Stop at the first found occurrence. */
> > > +		if (!ret)
> > > +			return 0;
> > >  	}
> > >  
> > > -	of_node_put(remote);
> > > -	return ret;
> > > +	return -EPROBE_DEFER;
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
> > >  
> > > -- 
> > > 2.35.1
> > > 
> 
> -- 
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com


