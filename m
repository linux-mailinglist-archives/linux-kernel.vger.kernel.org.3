Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00AB4CC875
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiCCWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiCCWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:00:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA96DFDC;
        Thu,  3 Mar 2022 13:59:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F0346101E;
        Thu,  3 Mar 2022 22:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646344770;
        bh=tu4nl7oMY6soz2c3whO1qbqCHUSafi/7e+F/6CMnMlM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cWq/k33atmYXJ1snfvtAEUqdVLrTAn7ydpWd8WSMQ3r0ARmExthG9Pj9fyi5pKbFZ
         Zw9bMbWPKPh5XSo3uwY4cYrD020QmAlCtCbjkOOxx1Qep+TMUootcnM/aHvdyXCJkO
         9QJt7pDmZpoYDR2nitPTMIgaRYrm3j56sEWUFuN4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220303183720.GA334969@elementary>
References: <20220228183955.25508-1-jose.exposito89@gmail.com> <164609067646.2361501.15747139249939190799@Monstersaurus> <20220303183720.GA334969@elementary>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: switch to devm_drm_of_get_bridge
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     andrzej.hajda@intel.com, linux-pwm@vger.kernel.org,
        jonas@kwiboo.se, airlied@linux.ie, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org, narmstrong@baylibre.com,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        thierry.reding@gmail.com, Laurent.pinchart@ideasonboard.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        maxime@cerno.tech
To:     =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Date:   Thu, 03 Mar 2022 21:59:26 +0000
Message-ID: <164634476693.3683041.3124143336848085499@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jos=C3=A9 Exp=C3=B3sito (2022-03-03 18:37:20)
> On Mon, Feb 28, 2022 at 11:24:36PM +0000, Kieran Bingham wrote:
> > Hi Jos=C3=A9
> >=20
> > Quoting Jos=C3=A9 Exp=C3=B3sito (2022-02-28 18:39:54)
> > > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > > favor of "devm_drm_of_get_bridge".
> > >=20
> > > Switch to the new function and reduce boilerplate.
> > >=20
> > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > ---
> > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/=
bridge/ti-sn65dsi86.c
> > > index dab8f76618f3..fb8e16ed7e90 100644
> > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > @@ -1232,15 +1232,9 @@ static int ti_sn_bridge_probe(struct auxiliary=
_device *adev,
> > >  {
> > >         struct ti_sn65dsi86 *pdata =3D dev_get_drvdata(adev->dev.pare=
nt);
> > >         struct device_node *np =3D pdata->dev->of_node;
> > > -       struct drm_panel *panel;
> > >         int ret;
> > > =20
> > > -       ret =3D drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
> > > -       if (ret)
> > > -               return dev_err_probe(&adev->dev, ret,
> > > -                                    "could not find any panel node\n=
");
> > > -
> > > -       pdata->next_bridge =3D devm_drm_panel_bridge_add(pdata->dev, =
panel);
> > > +       pdata->next_bridge =3D devm_drm_of_get_bridge(pdata->dev, np,=
 1, 0);
> >=20
> > Yikes, I was about to rely on this panel variable to determine if the
> > device is a panel or a display port connector. (Well, I am relying on
> > it, and patches are hoping to be reposted this week).
> >=20
> > Is there expected to be another way to identify if the next connection
> > is a panel or a bridge?
> >=20
> > Regards
>=20
> Hi Kieran,
>=20
> I'm getting started in the DRM subsystem. I couldn't tell if there is a
> good way to access the panel pointer... I didn't manage to find it, but
> hopefully someone with more experience can point us to a solution.
>=20
> Since you mentioned display port, I'm not sure if in your case checking
> "pdata->next_bridge->type" could be good enough.
>=20
> Anyway, if this patch causes you problems, please go ahead and ignore it.
> I'm sure the series you are working on are more important than removing
> a deprecated function :)

If it's deprecated, I don't want to block it's removal. Hopefully I can
resume my work on this tomorrow so I can check to see what I can parse.
Thanks for the lead on the bridge type, I'm sure I've seen that around
too so hopefully that's enough. If it is, I'll rebase my work on top of
your patch and retest.

--
Kieran


>=20
> Best wishes,
> Jose
