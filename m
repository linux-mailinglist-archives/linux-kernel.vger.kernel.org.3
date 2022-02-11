Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCC84B2945
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbiBKPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:44:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbiBKPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:44:02 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8548FD82;
        Fri, 11 Feb 2022 07:43:59 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8D1D240002;
        Fri, 11 Feb 2022 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644594235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8aMFMOxt3wpyHmG3yssB5XfL03jGxKhpyI3oWsfXL7Y=;
        b=i4aEFxwFLtu1GXs7z7xfAitkEU3hGcEI+mu83hBlSsl0YRIQugktUhswkyIxTqEbcZzLXZ
        x39h5ceyKPn8xje/cg/Vm+s8MVXxz6+o57LYVN44VCs6ffEDlLDL4MFPDJBnwSOZ+Yy1MZ
        K1TYDMG06ztndhrohKC4lSeHy6YQHAir1b++VQJbmjluK2HDsBHntNMEBom2CHIwmHoHhl
        XMDcGB+ClMTfy40+/kdQxiUng1jvvfnbEapyiWs1WpPJ2jmmf4Lsr+5o+uNe4PEoCCUuDx
        ++0b15Ag82zDNSnDYRABre6JrCucNWxCSrEzcrE/7gISHB8cyvdW1sTQSh6XFA==
Date:   Fri, 11 Feb 2022 16:43:51 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 30/66] media: sun6i-csi: Add bridge v4l2 subdev with
 port management
Message-ID: <YgaEN0ziZx5X7tQe@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-31-paul.kocialkowski@bootlin.com>
 <20220209092419.i3kver4f2am7mnow@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XHw3N8UqH38RVSoa"
Content-Disposition: inline
In-Reply-To: <20220209092419.i3kver4f2am7mnow@houat>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XHw3N8UqH38RVSoa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 09 Feb 22, 10:24, Maxime Ripard wrote:
> On Sat, Feb 05, 2022 at 07:53:53PM +0100, Paul Kocialkowski wrote:
> > Introduce a bridge v4l2 subdev to prepare for separation between the
> > processing part (bridge) and the dma engine, which is required to
> > properly support ths isp workflow later on.
> >=20
> > Currently the bridge just manages fwnode mapping to media pads,
> > using an async notifier (which was previously in the main code).
> > The s_stream video op just forwards to the connected v4l2 subdev
> > (sensor or MIPI CSI-2 bridge).
> >=20
> > The video capture device is now registered after the bridge and
> > attaches to it with a media link.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> There's a bunch of checkpatch --strict warnings that need to be fixed

Yes so it turns out these are adaptations to the existing video code
which has these warnings already merged. They are cleaned up later on
in a dedicated commit, but since it's not the topic of this change
(which is a logic change) I kept the code as it is.

What do you think?

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--XHw3N8UqH38RVSoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmIGhDcACgkQ3cLmz3+f
v9HxbggAkL1iOyWpL7H+lZcb/umUFS3DskOwQqsJ28ib87Q2czErTSd1f+9YJdCa
EHq30lRWyVOiGhNk+e2MzCZEEXWs4uwyrzwreGCK/8qHY7Rc4feneC1McKFsqLAP
k90LC5AwjohCmVpGl6s4AIwoGuqC3sDYkF+My9u22p5I8uCN7FgScIOA7t89vAz3
W7c/HZvofFbm94MWHksrFVOckKJHU5Ord3hFLZ9aN2WPTtPCtAwno2hU+lXY73BH
bc6dopUiS4v4G3loMEQRTLhAq+Ni97+dcBR3avT0uHe01PsAd7ftmED1xuCY9thK
uqhmv8PCDGd011l8Kb6eLcZ1accYnw==
=xWX0
-----END PGP SIGNATURE-----

--XHw3N8UqH38RVSoa--
