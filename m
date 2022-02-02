Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269494A766C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbiBBREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:04:33 -0500
Received: from smtp1.de.opalstack.com ([46.165.236.26]:59668 "EHLO
        smtp1.de.opalstack.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiBBRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:04:28 -0500
Received: from jason.localnet (host-37-191-188-128.lynet.no [37.191.188.128])
        by smtp1.de.opalstack.com (Postfix) with ESMTPSA id 5995A5C2DD;
        Wed,  2 Feb 2022 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boddie.org.uk;
        s=dkim; t=1643821466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnJUfpdhCrHTOx13kz3/o6wTUJabC+pt0tnb31dRByk=;
        b=dLZQQQKJNTmOf1/SXik0MBFTfwUKyAk72K5FMVtvlJgfM3HUBVonJ9c7lmcRud9T7e6Xw/
        B4/HqrlAGiGkSuB64WJhMCF4/e8ZyKd8O2sxLCsVNr5j+BYEWdJ9btC3FxhDBxZ9UTfkpB
        12F8QV9bTbZxGMSsqJiEcwUHQl24gjo=
From:   Paul Boddie <paul@boddie.org.uk>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v12 2/9] drm/ingenic: Add support for JZ4780 and HDMI output
Date:   Wed, 02 Feb 2022 18:04:20 +0100
Message-ID: <4456843.HuvP5PFhKd@jason>
In-Reply-To: <XKGO6R.LTTYDEGZ8RJH3@crapouillou.net>
References: <cover.1643632014.git.hns@goldelico.com> <78F51BD7-112A-458D-8FCE-6A67572A182B@goldelico.com> <XKGO6R.LTTYDEGZ8RJH3@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=1.90
X-Spam-Level: *
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2 February 2022 13:41:21 CET Paul Cercueil wrote:
> Le mer., f=E9vr. 2 2022 at 13:33:15 +0100, H. Nikolaus Schaller>=20
<hns@goldelico.com> a =E9crit :
> >>  Am 02.02.2022 um 13:28 schrieb Paul Cercueil <paul@crapouillou.net>:
> >> =20
> >>  Note that there are other things not working with your current
> >>=20
> >> implementation, for instance you cannot set the X/Y start position
> >> of the f1 plane, which means it's only really usable for fullscreen
> >> desktop/windows.
> >=20
> > Is setting x/y possible for the other SoC?
>=20
> Yes. They support different x/y positions, sizes, and pixel format for
> both f0, f1 and IPU planes.

One thing worth noting about the JZ4780 is that a lot of the registers that=
=20
might otherwise be used for the above purposes appear to be read-only, at=20
least for the different fields concerned.

=46or example, those affecting ingenic_drm_plane_config:

Control Register (LCDCTRL) - specifically the BPP0 field
OSD Control Register (LCDOSDCTRL)
=46oreground 0 XY Position Register (LCDXYP0)
=46oreground 1 XY Position Register (LCDXYP1)
=46oreground 0 Size Register (LCDSIZE0)
=46oreground 1 Size Register (LCDSIZE1)

These require changes to the extended descriptor members instead, and I am=
=20
fairly sure I mentioned the implications for pixel depth configuration=20
previously. So, as far as I can tell, we would need to update the descripto=
rs,=20
not the registers, to support the operations mentioned above.

As for the f0 plane "not working", I am not aware of any limitation around=
=20
using only f0 (assuming it corresponds to what the manual calls fg0) or onl=
y=20
f1 (again, assuming fg1 in the manual) or both. My assumption was that for=
=20
this particular driver, f0 was reserved for some kind of overlay and that f=
1=20
was to be used for the normal non-overlay display for products where the OS=
D=20
peripheral is provided.

=46rom the definition of struct ingenic_drm:

        /*
         * f1 (aka. foreground1) is our primary plane, on top of which
         * f0 (aka. foreground0) can be overlayed. Z-order is fixed in
         * hardware and cannot be changed.
         */

So, as I understood it, the driver would configure f1 in the case of the=20
JZ4780 for basic display support. Configuring f0 as an overlay should be=20
entirely possible, but I imagine that it needs to change the descriptors, n=
ot=20
the registers, to have a chance of actually working.

I hope this is somewhat useful information. I honestly don't know if, say, =
the=20
JZ4770 has a similar arrangement with regard to configuration via descripto=
rs,=20
as opposed to registers, but I think it is an important distinction between=
=20
devices in this particular family that needs to be accommodated in the driv=
er,=20
and we obviously want to determine how this might best be achieved.

Paul


