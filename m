Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C515075FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355639AbiDSRHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355727AbiDSRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:55 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B94A12AED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650387293; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3keMFx7626/px/N5I87eyXv+dAR6bGNhk8NPvdrTME=;
        b=Qf+J0eiBHYh8QxF1W/WnuHYdLzVtpgzVnCWC+xqIpQRsAulRAHQWbxTdONnbeGAc5CL8YT
        Fh7Kbnq1s2IgEjk5Jj1ho3w4Dk3u8x7bnwRNfcoQ//WJ/DBPMUz1zWcRgiMx6ic0afX9Lk
        2Jzg99jYUGHcLpBMbn0cr8w+qUokBRM=
Date:   Tue, 19 Apr 2022 17:54:43 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: drm: of: Improve error handling in bridge/panel detection
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Message-Id: <7ZILAR.B5RI26D3L60Y1@crapouillou.net>
In-Reply-To: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
References: <20220407093408.1478769-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Le jeu., avril 7 2022 at 11:34:08 +0200, Paul Kocialkowski=20
<paul.kocialkowski@bootlin.com> a =E9crit :
> With the previous rework of drm_of_find_panel_or_bridge only
> -EPROBE_DEFER is returned while previous behavior allowed -ENODEV
> to be returned when the port/endpoint is either missing or=20
> unavailable.
>=20
> Make the default return code of the function -ENODEV to handle this=20
> and
> only return -EPROBE_DEFER in find_panel_or_bridge when the of device=20
> is
> available but not yet registered. Also return the error code whenever
> the remote node exists to avoid checking for child nodes.
>=20
> Checking child nodes could result in -EPROBE_DEFER returned by
> find_panel_or_bridge with an unrelated child node that would overwrite
> a legitimate -ENODEV from find_panel_or_bridge if the remote node from
> the of graph is unavailable. This happens because find_panel_or_bridge
> has no way to distinguish between a legitimate panel/bridge node that
> isn't yet registered and an unrelated node.
>=20
> Add comments around to clarify this behavior.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Fixes: 67bae5f28c89 ("drm: of: Properly try all possible cases for=20
> bridge/panel detection")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

This fixes the ingenic-drm driver, which was broken by the commit this=20
patch addresses.

So:
Tested-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/drm_of.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 8716da6369a6..97ea9d2016ff 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -223,6 +223,9 @@ static int find_panel_or_bridge(struct=20
> device_node *node,
>  				struct drm_panel **panel,
>  				struct drm_bridge **bridge)
>  {
> +	if (!of_device_is_available(node))
> +		return -ENODEV;
> +
>  	if (panel) {
>  		*panel =3D of_drm_find_panel(node);
>  		if (!IS_ERR(*panel))
> @@ -265,7 +268,7 @@ int drm_of_find_panel_or_bridge(const struct=20
> device_node *np,
>  				struct drm_bridge **bridge)
>  {
>  	struct device_node *node;
> -	int ret;
> +	int ret =3D -ENODEV;
>=20
>  	if (!panel && !bridge)
>  		return -EINVAL;
> @@ -282,8 +285,12 @@ int drm_of_find_panel_or_bridge(const struct=20
> device_node *np,
>  			ret =3D find_panel_or_bridge(node, panel, bridge);
>  			of_node_put(node);
>=20
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
>=20
> @@ -296,12 +303,18 @@ int drm_of_find_panel_or_bridge(const struct=20
> device_node *np,
>  		ret =3D find_panel_or_bridge(node, panel, bridge);
>  		of_node_put(node);
>=20
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
>=20
> -	return -EPROBE_DEFER;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);


