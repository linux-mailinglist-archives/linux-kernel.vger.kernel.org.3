Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125CD4C7E41
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiB1XZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiB1XZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:25:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB02BC3311;
        Mon, 28 Feb 2022 15:24:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B22F478;
        Tue,  1 Mar 2022 00:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646090679;
        bh=GequZV5BwVjpKPb+Q/rQWeSXyCGPG/WT/t2NCTE3e44=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Xi4ptyLzFjcJ0ffGr6xtQG2NQb6Tbk4Id3luptcVQKUalOnq7cbUIgwJlty9rVGMd
         TevFoHW2bEgBDHUj46YHrjIPfOEZY5t5NTiAEOz//i69Gtnx9P0eytbjrV05xq5ocC
         MbG5jVP6lmrsARn2BaUJRbkXne/VCRmLhDAR3bOw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220228183955.25508-1-jose.exposito89@gmail.com>
References: <20220228183955.25508-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: switch to devm_drm_of_get_bridge
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, jonas@kwiboo.se, airlied@linux.ie,
        robert.foss@linaro.org, dri-devel@lists.freedesktop.org,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        jernej.skrabec@gmail.com, thierry.reding@gmail.com,
        Laurent.pinchart@ideasonboard.com, u.kleine-koenig@pengutronix.de,
        =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        lee.jones@linaro.org, maxime@cerno.tech
To:     =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com
Date:   Mon, 28 Feb 2022 23:24:36 +0000
Message-ID: <164609067646.2361501.15747139249939190799@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jos=C3=A9

Quoting Jos=C3=A9 Exp=C3=B3sito (2022-02-28 18:39:54)
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
>=20
> Switch to the new function and reduce boilerplate.
>=20
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index dab8f76618f3..fb8e16ed7e90 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1232,15 +1232,9 @@ static int ti_sn_bridge_probe(struct auxiliary_dev=
ice *adev,
>  {
>         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.parent);
>         struct device_node *np =3D pdata->dev->of_node;
> -       struct drm_panel *panel;
>         int ret;
> =20
> -       ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
> -       if (ret)
> -               return dev_err_probe(&adev->dev, ret,
> -                                    "could not find any panel node\n");
> -
> -       pdata->next_bridge =3D devm_drm_panel_bridge_add(pdata->dev, pane=
l);
> +       pdata->next_bridge =3D devm_drm_of_get_bridge(pdata->dev, np, 1, =
0);

Yikes, I was about to rely on this panel variable to determine if the
device is a panel or a display port connector. (Well, I am relying on
it, and patches are hoping to be reposted this week).

Is there expected to be another way to identify if the next connection
is a panel or a bridge?

Regards

--
Kieran


>         if (IS_ERR(pdata->next_bridge)) {
>                 DRM_ERROR("failed to create panel bridge\n");
>                 return PTR_ERR(pdata->next_bridge);
> --=20
> 2.25.1
>
