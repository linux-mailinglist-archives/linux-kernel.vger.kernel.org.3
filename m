Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED95B16EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiIHI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiIHIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:25:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42E895D5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:25:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWCr3-00018X-Va; Thu, 08 Sep 2022 10:25:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWCr1-004auW-8t; Thu, 08 Sep 2022 10:25:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oWCr2-00Gsa9-6j; Thu, 08 Sep 2022 10:25:44 +0200
Date:   Thu, 8 Sep 2022 10:25:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/9] pwm: lpss: Deduplicate board info data structures
Message-ID: <20220908082544.vhcwffikm6xpsjwf@pengutronix.de>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220907090412.kqvbmgfgeb4toz5n@pengutronix.de>
 <YxiqSiP4dTa2bhUh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3inb7slan4u4p6ty"
Content-Disposition: inline
In-Reply-To: <YxiqSiP4dTa2bhUh@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3inb7slan4u4p6ty
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 05:27:22PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 07, 2022 at 11:04:12AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 06, 2022 at 10:57:27PM +0300, Andy Shevchenko wrote:
> > > With help of __maybe_unused, that allows to avoid compilation warning=
s,
> > > move the board info structures from the C files to the common header
> > > and hence deduplicate configuration data.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/pwm/pwm-lpss-pci.c      | 29 -----------------------------
> > >  drivers/pwm/pwm-lpss-platform.c | 23 -----------------------
> > >  drivers/pwm/pwm-lpss.h          | 30 ++++++++++++++++++++++++++++++
> >=20
> > Given that both the pci driver and the platform driver alread depend on
> > pwm-lpss.o, I'd prefer something like the patch below to really
> > deduplicate the data.
>=20
> Why not? I can use yours in v2. Can I get your SoB tag?

Sure:

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> > One thing to note is that the two pwm_lpss_bsw_info are not identical. I
> > didn't check how that is relevant. Did you check that?
>=20
> Yes, ACPI version should be used. Because switch to ACPI/PCI is done in B=
IOS
> while quite likely the rest of AML code is the same, meaning similar issue
> might be observed. The no bug report is due to no PCI enabled device in t=
he
> wild, I think, and only reference boards can be tested, so nobody really =
cares
> about PCI Braswell case.

I'm willing to believe that; please mention that in the commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3inb7slan4u4p6ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMZpwUACgkQwfwUeK3K
7AlGlQf+Mvid7EtJBez73pTjqsiZKkRYw8V664rQvM4FZQ34SE4cRHzCC4fncp9G
PmAuoMXZ1CFWw47RHfWUkX1tkRhiAEktAwATlXKY06AMhif+0vy5xCwb12EBtyEa
WB6lTTsBSIKCYqmmFTxOYMdGJPswoaBaPsDne0bAZretcGEu3Vz4az6CkdxQig5M
RJGuVu6O2Uf3cTAIpDZUwF6TNSM2yRnS2ziwjovqOlrj2nxoGGhGzJQd7lvIfWBl
e+8qKIRLj1yKjzaLMHTtbMM4bQBsprLFyi5UjXAdpPT47m/2l5L0futGGH2MeyZi
Cs7fdAcCnSPbF2JpNQl28zi5hjx2SQ==
=FL0c
-----END PGP SIGNATURE-----

--3inb7slan4u4p6ty--
