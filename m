Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97C4B6921
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiBOKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:21:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiBOKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:21:32 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8307DFEF;
        Tue, 15 Feb 2022 02:21:20 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7C24D240006;
        Tue, 15 Feb 2022 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644920479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLuRTwKMKPpkSVGsT7HVqc5YDmNB2qRgXNbTQnh8ZQ8=;
        b=T9eefH1khM1C9SPie7G6ia1yNtnvILoerbDmEcmSUNtl3vgx7ThQlv6pLqBpK7Ogfl4hN9
        k6a7oSOyFGXRlVFmK8PuXZxsc+eFYyt4NQCVtadhr7Bt1BcRxnI6BKZ/6F37AOIAmS4I+4
        G/ozpQgijSvt1Xcng0MJcRT0IMO82I12iVxX8++yvAr2wB7rmShDmWB7vBppSFWtKhHDUa
        a/iBd+1Tgdew3Ho4c5u4NQVwd1HP0tzBTT50uAG13vi/LdntjO7dM8l+P+8NlzEN6ET2SW
        vLM9FHJDG21EfrmdWDYmTNNVrVB4T26FKOgunJY0V/bSuhn7nfT352LHMNmzZA==
Date:   Tue, 15 Feb 2022 11:21:17 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 37/66] media: sun6i-csi: Move power management to
 runtime pm in capture
Message-ID: <Ygt+nZJrZMNXV4Cl@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
 <YgqftcDgfrsZfTdF@paasikivi.fi.intel.com>
 <Ygt4xh2Mq0qStyKs@aptenodytes>
 <Ygt6vwydxg9/WuDH@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x0S1xJjs6wRADgc6"
Content-Disposition: inline
In-Reply-To: <Ygt6vwydxg9/WuDH@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x0S1xJjs6wRADgc6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Tue 15 Feb 22, 12:04, Laurent Pinchart wrote:
> Hi Paul,
>=20
> On Tue, Feb 15, 2022 at 10:56:22AM +0100, Paul Kocialkowski wrote:
> > On Mon 14 Feb 22, 20:30, Sakari Ailus wrote:
> > > On Sat, Feb 05, 2022 at 07:54:00PM +0100, Paul Kocialkowski wrote:
> > > > Let's just enable the module when we start using it (at stream on)
> > > > and benefit from runtime pm instead of enabling it at first open.
> > > >=20
> > > > Also reorder the call to v4l2_pipeline_pm_get.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > >=20
> > > Nice patch!
> >=20
> > Thanks!
> >=20
> > > Do you still need v4l2_pipeline_pm_put()? Removing it would be a sepa=
rate
> > > patch of course.
> >=20
> > My understanding is that this is still useful if there are drivers in t=
he
> > pipeline that rely on s_power instead of rpm (a typical case could be an
> > old sensor driver). So that's why this is kept around, but all other co=
mponents
> > of the pipeline (isp/csi/mipi csi-2) are using rpm now.
>=20
> If that's not the case on your test platforms, I think it would be
> better to drop support for this old API, and convert drivers that still
> use .s_power() if someone needs to use one on an Allwinner platform.

I agree this is the path to follow but it feels like we're not quite there
yet and a bunch of driver were not converted at this point, including some
popular ones like ov5640, which I know for sure is used with Allwinner devi=
ces.

Honestly I'd be happy to get rid of these legacy functions as soon as the
transition is done, but doing it now would mean breaking a significant numb=
er
of use cases (which I'm trying to avoid here despite all the changes).

I definitely wouldn't be confident making that transition here and it
probably wouldn't be a good idea to make that a requirement to merge this
(already quite big) series.

What do you think?

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--x0S1xJjs6wRADgc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmILfp0ACgkQ3cLmz3+f
v9Gm2Qf/W/ZTXFzamMW7hvV8qcmAZpXwCKekASY4Lpa4JwvvhyI4DtfX2n+AvXQV
w4y54EHfcIAFtOkEIOsj4zirpI4p4tgA/uvgLyHmEu9CcbzvuwYe9zd/Ozeo/AEG
OlwSWF+MhD1kawGki9ikCPG5QwDLt/rzeJHUPh0aT5Oxae3NMBSgcCizJVoN2Inh
4j5Zkj99rX2h2ed0e+TjPsB76WuSJaJVNoyAgD1w3PB7YueruHIkq+s7CTHtaQKj
KtAoegyMomsRUSp20VUJiPdqouUox5HLU5cvxrh4enbYDqNaZelVFp2/R+wghUVi
XwIhQQwXYZ2hmsCFJ/pjIAM4JgYblw==
=tEm8
-----END PGP SIGNATURE-----

--x0S1xJjs6wRADgc6--
