Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479C24B35F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiBLPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiBLPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:50:27 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECDB240AC;
        Sat, 12 Feb 2022 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644681013;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=IdS2QAviQYspg0Ww5TTCvAHcJJtpXKbwyF+95baAn64=;
    b=AKgnoXpnbkpWFz+c0XV/zf9gpMR37hCSLDHSZsVBNHSNAQZ/I1IFF+buNbgTwT35MF
    oS69gCfqcHF9MUTj7NpQYXj2b0YzkAtYd2IfhSx44WgSfowJn48dhza6L7nQI96jGd2T
    69fJhNx3qHf/XvcVosLvEPaq3KiQmH8tbfqPUOlA9gT4+ZN254NB0DfcbRKRNyF1EcVH
    12snh2S2L6MmbysLJh85MKBxTF8p9Md1GE6HrLgZDfrd3DxkznWyngCORxwTDZVSdBxg
    tWTTNSGrbu5X+8UNL4f72dSXjGuOglZY1XJDN1ZuhySs+g1ON8k7T0kl3wYwJ4TDB3qF
    daGQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NIGH/jrwDaqyA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CFoCswi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 16:50:12 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v14 5/9] drm/bridge: dw-hdmi: repair interworking with
 hdmi-connector for jz4780
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <7Y577R.WAL64FW8KJZJ1@crapouillou.net>
Date:   Sat, 12 Feb 2022 16:50:12 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AF73F85-8384-413C-8E2E-004E6DD75AAD@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
 <8703a3e48574c09e8756b79e8f69be7d84926fe9.1644675566.git.hns@goldelico.com>
 <7Y577R.WAL64FW8KJZJ1@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 12.02.2022 um 16:06 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
>=20
> Le sam., f=C3=A9vr. 12 2022 at 15:19:23 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Commit 7cd70656d1285b ("drm/bridge: display-connector: implement bus =
fmts callbacks")
>> introduced a new mechanism to negotiate bus formats between hdmi =
connector
>> and the synopsys hdmi driver inside the jz4780.
>> By this, the dw-hdmi is no longer the only bridge and sets up a list
>> of formats in dw_hdmi_bridge_atomic_get_output_bus_fmts().
>> This includes MEDIA_BUS_FMT_UYVY8_1X16 which is chosen for the jz4780 =
but only
>> produces a black screen.
>=20
> Neil pushed a fix yesterday that looks like it could fix your issue.
> The fix is: 1528038385c0 ("drm/bridge: dw-hdmi: use safe format when =
first in bridge chain")
>=20
> Could you try if it does indeed fix your issue?

Sure.

Would have been nice and is a fix addressing same base commit, but is =
not a replacement for my attempt :(

Fortunately we can have both.

>=20
> Cheers,
> -Paul
>=20
>> This fix is based on the observation that max_bpc =3D 0 when running =
this
>> function while info->bpc =3D 8. Since the formats checks before this =
always test
>> for max_bpc >=3D info->pbc indirectly my assumption is that we must =
check it
>> here as well.
>> Adding the proposed patch makes the CI20/jz4780 panel work again in
>> MEDIA_BUS_FMT_RGB888_1X24 mode.
>> Fixes: 7cd70656d1285b ("drm/bridge: display-connector: implement bus =
fmts callbacks")
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index b0d8110dd412c..826a055a7a273 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2620,10 +2620,10 @@ static u32 =
*dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>> 		output_fmts[i++] =3D MEDIA_BUS_FMT_RGB101010_1X30;
>> 	}
>> -	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
>> +	if (max_bpc >=3D info->bpc && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR422)
>> 		output_fmts[i++] =3D MEDIA_BUS_FMT_UYVY8_1X16;
>> -	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
>> +	if (max_bpc >=3D info->bpc && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR444)
>> 		output_fmts[i++] =3D MEDIA_BUS_FMT_YUV8_1X24;
>> 	/* Default 8bit RGB fallback */
>> --
>> 2.33.0
>=20
>=20

