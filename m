Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF914DBAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbiCPXZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCPXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:25:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D6EA8;
        Wed, 16 Mar 2022 16:24:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C6BED493;
        Thu, 17 Mar 2022 00:24:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1647473050;
        bh=FewMdmi8qEg2S9b7MWGLnLAfszTXPWwFEMPvKBys6OM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wFX2XoKNsVfKJ9PnzNU5gr5EEIx/VnqBXfatkHwxQUWIk0vQs39KntBZbIIEcT+Fy
         ileRxcJbLsynYWYtRRa75qONDrxoKggzSm3Fclt7HWgVSRRcqkaxsmWEkTrwy68B1A
         EmF7rV00/epJR/t7+umRyqSDwv34FFjU8CoMQzcw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=UcfrWLQdCOx5dCfjvjrLzkdLDeoAROmMtqFWB_X90rwQ@mail.gmail.com>
References: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com> <20220310152227.2122960-3-kieran.bingham+renesas@ideasonboard.com> <CAD=FV=UcfrWLQdCOx5dCfjvjrLzkdLDeoAROmMtqFWB_X90rwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi86: Implement bridge connector operations
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To:     Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Mar 2022 23:24:08 +0000
Message-ID: <164747304840.11309.8075169187883378445@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Quoting Doug Anderson (2022-03-10 23:10:20)
> Hi,
>=20
> On Thu, Mar 10, 2022 at 7:22 AM Kieran Bingham
> <kieran.bingham+renesas@ideasonboard.com> wrote:
> >
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > Implement the bridge connector-related .get_edid() operation, and report
> > the related bridge capabilities and type.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> > Changes since v1:
> >
> > - The connector .get_modes() operation doesn't rely on EDID anymore,
> >   __ti_sn_bridge_get_edid() and ti_sn_bridge_get_edid() got merged
> >   together
> >  - Fix on top of Sam Ravnborg's DRM_BRIDGE_STATE_OPS
> >
> > Changes since v2: [Kieran]
> >  - Only support EDID on DRM_MODE_CONNECTOR_DisplayPort modes.
> >
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 93b54fcba8ba..d581c820e5d8 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -1135,10 +1135,24 @@ static void ti_sn_bridge_atomic_post_disable(st=
ruct drm_bridge *bridge,
> >         pm_runtime_put_sync(pdata->dev);
> >  }
> >
> > +static struct edid *ti_sn_bridge_get_edid(struct drm_bridge *bridge,
> > +                                         struct drm_connector *connect=
or)
> > +{
> > +       struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> > +       struct edid *edid;
> > +
> > +       pm_runtime_get_sync(pdata->dev);
> > +       edid =3D drm_get_edid(connector, &pdata->aux.ddc);
> > +       pm_runtime_put_autosuspend(pdata->dev);
>=20
> I'm 99% sure that the pm_runtime calls here are not needed and can be
> removed.. The AUX transfer function handles the pm_runtime_get_sync()
> and it also does the "put" with autosuspend so that the whole EDID can
> be read without constantly powering the bridge up and down again.

Yes, digging through I agree - It does look like this may be the case.

ti_sn_aux_transfer() certainly looks like it handles the pm_runtime_
calls, and drm_get_edid() looks like it goes through there from the core
using the standard i2c interface, with nothing else expected to touch
the hw between.

So that more or less simplifies this function to just=20
	return drm_get_edid(connector, &pdata->aux.ddc);

Thanks
--
Kieran
