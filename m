Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5155B4B684B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiBOJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:56:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:56:47 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D617091D;
        Tue, 15 Feb 2022 01:56:33 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 741E31BF20F;
        Tue, 15 Feb 2022 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644918992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4eFwye/okRxi/68ri8yTsBWvX0g8mH2JLrxCqUzQBc=;
        b=Pkgq0hGmhZqbfwp1twud8hwRV3Xuarr8FHjsMyWaqUwul9fbk3t4vO12uPMdpnKoqB3lXK
        HQIbML8TtlXXedlVag+9NJlfaflzKTnv9pqzoZsTdj7Vnz9/ZJKYAJlFgbjKYqIaCA7Q0A
        a3QcjuVTrAKiDj0s67KrOgfSKnGQP50Vb8qRoJhrmO22RHhav6FQJLFhEy53bVmhts29Lz
        3sF7W6vwVVzjBAiw5HzgGZ42tvgIx1FCl9vQpEZvnQCQQucXS60ydZZcvDuKTUdP5RdFom
        E/3L6/QjdSOJYb6Xv7FzfDMR5HejitXXdQKH0Qqao4ClUDYzlCWSNU4ysNQYVQ==
Date:   Tue, 15 Feb 2022 10:56:22 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 37/66] media: sun6i-csi: Move power management to
 runtime pm in capture
Message-ID: <Ygt4xh2Mq0qStyKs@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
 <YgqftcDgfrsZfTdF@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tOB2i1/qfUMuc0i4"
Content-Disposition: inline
In-Reply-To: <YgqftcDgfrsZfTdF@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tOB2i1/qfUMuc0i4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon 14 Feb 22, 20:30, Sakari Ailus wrote:
> Hi Paul,
>=20
> On Sat, Feb 05, 2022 at 07:54:00PM +0100, Paul Kocialkowski wrote:
> > Let's just enable the module when we start using it (at stream on)
> > and benefit from runtime pm instead of enabling it at first open.
> >=20
> > Also reorder the call to v4l2_pipeline_pm_get.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Nice patch!

Thanks!

> Do you still need v4l2_pipeline_pm_put()? Removing it would be a separate
> patch of course.

My understanding is that this is still useful if there are drivers in the
pipeline that rely on s_power instead of rpm (a typical case could be an
old sensor driver). So that's why this is kept around, but all other compon=
ents
of the pipeline (isp/csi/mipi csi-2) are using rpm now.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--tOB2i1/qfUMuc0i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmILeMYACgkQ3cLmz3+f
v9E5sAf/akvNvNPsCxPYxGv+fJr3ZwwX2cWQuFu6Am+wwNsKyXuxoMHRnyG1rANG
OVaJVCgFR3vPnDKUsTC/grEH/PdeNUHy9DT+gnEnjsIepnMV5/VAG4YBgonHBDoC
Nk1fMad5oTd+W+kpLqdQ7JEABUhW+TZL9TAv2C24Xg4DupIwH2HDcYCepM83ySy8
q5Q6Jo8gYGAWzdWJLr5u3Xexgd2W7n4kQ7VBXVNesTQOgvihW8xTFcAft/Sf4Qig
FHhb+EWRL6Pl9v74gev2rUQMWABOgVFHlcPmHQgrFIHC/u9fHP0auvZzS09i6A0C
hcYntRVNBMGqmJTHoPZjIucw/JtAgw==
=CYCh
-----END PGP SIGNATURE-----

--tOB2i1/qfUMuc0i4--
