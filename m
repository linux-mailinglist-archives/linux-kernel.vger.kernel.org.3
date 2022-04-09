Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BB4FA1EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiDIDLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiDIDLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:11:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2839143
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:09:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so7374070otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 20:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxPCpHexqnNtAJVlj16bK37rc7h72VmvhvA88nM3U7Q=;
        b=duWICNi7qLMVElsG2CKWu54PWDCEQoNwB1gZAWM1iVTDQH4RhkbHLPhfGvKx2/Dj/d
         QHVtSBwZBu0yeKOT2xkzqEADMV7QJxLXzst8ahAOUyfDMFGLB8LcYwpQcWpB2QRjDBC+
         IJaUu7vETEjQ/jQPH88rWISgCRq2Tw6DWrahJuJzR7AxkGhJSxFjpRSmYNYxgaNI2r0S
         A4J9xlGQ287noaT4n4HrVl7TFGBxlHVw14y6BaNTpWevvCmHs4RsCSKCS841CFkkKZLw
         W6zDs79uioEL+fs1Rqg/pJWNij9oFo9HJno23MmszaWNN0m3oipEMd4no4rW8PH/6sHu
         8aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxPCpHexqnNtAJVlj16bK37rc7h72VmvhvA88nM3U7Q=;
        b=MNRIonZX1KfyIjTd89lgtAJE5ehcgp3SgCinRWufi0UUjDVxjjZB5bDieqwuryCDOi
         cNc0b7MmZAS6w1kXhxasPHtAY1a7Tj6paUD6YIqEl9kYWQQ/H0QxJk3RATNgTV/Sj2Lq
         KexsA2gyciVA4U3Yvcgm97IcZmIfuCq3aaJ8eMj9Pzb1SE4tq71Oga2zXsZFwiK7jWqm
         tPJUOPFoE2USQzESbPOKzr3PkjyoPhfXGiqnj4WKYCy/KWB96HKbVM1WZz2lMTvKOQEe
         Lnuq5V0qgVYHnyjzZPdbFPhtqWOwXQ6VmIyPJNbxKM6y357JmZ+3RXwmEPoKX07dV2pw
         ZEEw==
X-Gm-Message-State: AOAM532Wl3LnJsBlXmWxlWS0hKImszNVY2sT2siPw/YlkZ+zbXM5XUgZ
        m1e005Rz4tSM9HMgOWPLjewCQw==
X-Google-Smtp-Source: ABdhPJxngGkyKU/8kRA6FG88JV2nKDjmD0XlyprMh3Fr7ob0NJdDl8r5t0JR4smKithiB4rW8Oye/A==
X-Received: by 2002:a9d:4d8c:0:b0:5c9:5737:3358 with SMTP id u12-20020a9d4d8c000000b005c957373358mr7752148otk.259.1649473758428;
        Fri, 08 Apr 2022 20:09:18 -0700 (PDT)
Received: from yoga.lan ([2600:1700:a0:3dc8:3a35:9080:1468:a9f8])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm9306434oie.1.2022.04.08.20.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:09:17 -0700 (PDT)
Date:   Fri, 8 Apr 2022 22:09:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] drm: of: Improve error handling in bridge/panel detection
Message-ID: <YlD4235/tGsQqede@yoga.lan>
References: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Apr 04:34 CDT 2022, Paul Kocialkowski wrote:

> With the previous rework of drm_of_find_panel_or_bridge only
> -EPROBE_DEFER is returned while previous behavior allowed -ENODEV
> to be returned when the port/endpoint is either missing or unavailable.
> 
> Make the default return code of the function -ENODEV to handle this and
> only return -EPROBE_DEFER in find_panel_or_bridge when the of device is
> available but not yet registered. Also return the error code whenever
> the remote node exists to avoid checking for child nodes.
> 
> Checking child nodes could result in -EPROBE_DEFER returned by
> find_panel_or_bridge with an unrelated child node that would overwrite
> a legitimate -ENODEV from find_panel_or_bridge if the remote node from
> the of graph is unavailable. This happens because find_panel_or_bridge
> has no way to distinguish between a legitimate panel/bridge node that
> isn't yet registered and an unrelated node.
> 
> Add comments around to clarify this behavior.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Fixes: 67bae5f28c89 ("drm: of: Properly try all possible cases for bridge/panel detection")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> 

Thanks for your patch, this does seem to solve the first problem I
reported, where I have a DisplayPort bridge with the following content:

sn65dsi86: bridge@2c {
	compatible = "ti,sn65dsi86";
	...;

	ports {
		port@0 {
			reg = <0>;
			sn65dsi86_in_a: endpoint {
				remote-endpoint = <&dsi0_out>;
			};
		};

		port@1 {
			reg = <1>;
			sn65dsi86_out: endpoint {
				remote-endpoint = <&panel_in_edp>;
			};
		};
	};

	aux-bus {
		panel: panel {
			compatible = "boe,nv133fhm-n61";
			backlight = <&backlight>;

			port {
				panel_in_edp: endpoint {
					remote-endpoint = <&sn65dsi86_out>;
				};
			};
		};
	};
};

The code now finds a match on of_graph_get_remote_node() and returns 0
or -EPROBE_DEFER from find_panel_or_bridge(?, 1, ?). And we return this,
before failing to resolve the "aux-bus" as a panel.


But my other case still doesn't work:

mdss_dp: displayport-controller@ae90000 {
	compatible = "qcom,sm8350-dp";
	...;
	operating-points-v2 = <&dp_opp_table>;

	ports {
		port@0 {
			reg = <0>;
			dp_in: endpoint {
				remote-endpoint = <&dpu_intf0_out>;
			};
		};
	};

	dp_opp_table: opp-table {
		...
	};
};

port@1 may be a reference to a DisplayPort panel, but in this particular
case the output is a USB Type-c connector (compatible
"usb-c-connector"). So I'm not able to specify this link, given that it
will not be a bridge or panel...ever...

So this does not find a match on of_graph_get_remote_node(np, 1, ?), so
we move ahead and look at all children not named "port" or "ports". We
find the opp-table and concludes that this not a panel. At this point
ret is overwritten and we end up returning -EPROBE_DEFER.



I think it's worth reverting back to the explicit of_graph link to the
panel, even in the case that it's an immediate child node. It avoids the
problem of specifying that all future display nodes must only have
children of type ports, port or panel. We might be able to come up with
something that works for my case, but it seems fragile and not very
future proof. The explicit port is a little bit clunky, but it doesn't
have this problem.

Regards,
Bjorn

> ---
>  drivers/gpu/drm/drm_of.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 8716da6369a6..97ea9d2016ff 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -223,6 +223,9 @@ static int find_panel_or_bridge(struct device_node *node,
>  				struct drm_panel **panel,
>  				struct drm_bridge **bridge)
>  {
> +	if (!of_device_is_available(node))
> +		return -ENODEV;
> +
>  	if (panel) {
>  		*panel = of_drm_find_panel(node);
>  		if (!IS_ERR(*panel))
> @@ -265,7 +268,7 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>  				struct drm_bridge **bridge)
>  {
>  	struct device_node *node;
> -	int ret;
> +	int ret = -ENODEV;
>  
>  	if (!panel && !bridge)
>  		return -EINVAL;
> @@ -282,8 +285,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>  			ret = find_panel_or_bridge(node, panel, bridge);
>  			of_node_put(node);
>  
> -			if (!ret)
> -				return 0;
> +			/*
> +			 * If the graph/remote node is present we consider it
> +			 * to be the legitimate candidate here and return
> +			 * whatever code we got from find_panel_or_bridge.
> +			 */
> +			return ret;
>  		}
>  	}
>  
> @@ -296,12 +303,18 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>  		ret = find_panel_or_bridge(node, panel, bridge);
>  		of_node_put(node);
>  
> -		/* Stop at the first found occurrence. */
> +		/*
> +		 * Note that an unrelated (available) child node will cause
> +		 * find_panel_or_bridge to return -EPROBE_DEFER because there
> +		 * is no way to distinguish the node from a legitimate
> +		 * panel/bridge that didn't register yet. Keep iterating nodes
> +		 * and only return on the first found occurrence.
> +		 */
>  		if (!ret)
>  			return 0;
>  	}
>  
> -	return -EPROBE_DEFER;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
>  
> -- 
> 2.35.1
> 
