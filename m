Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC24EDA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiCaNTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiCaNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:19:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB982102B5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:17:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZug1-0008LA-05; Thu, 31 Mar 2022 15:17:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZug0-0007dG-P2; Thu, 31 Mar 2022 15:17:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZufy-000FO7-IV; Thu, 31 Mar 2022 15:17:22 +0200
Date:   Thu, 31 Mar 2022 15:17:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/2] mfd: twlx030: i2c remove callback cleanup
Message-ID: <20220331131722.wt5uik3izzr7kewq@pengutronix.de>
References: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k7bb3avtwrjcunmo"
Content-Disposition: inline
In-Reply-To: <20220113101430.12869-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k7bb3avtwrjcunmo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 11:14:28AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> the remove paths of the twl4030 chip can fail and then returns an error
> code in twl_remove() early. This isn't a good thing, because the device
> will still go away with some resources not freed.
> For the twl6030 this cannot happen, and the first patch is just a small
> cleanup. For the twl4030 the situation is improved a bit: When the
> failure happens, the dummy slave devices are removed now.
>=20
> Note that twl4030_exit_irq() is incomplete. The irq isn't freed and
> maybe some more cleanup is missing which might boom if an irq triggers
> after the device is removed. Not sure that twl6030_exit_irq() is better
> in this regard.
>=20
> I noticed this issue because I work on making i2c_driver::remove return
> void as returning a value !=3D 0 there is almost always an error attached
> to wrong expectations.

It's one merge window ago now that I sent these two patches and didn't
get any feedback. Did this series fell through the cracks?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--k7bb3avtwrjcunmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJFqd8ACgkQwfwUeK3K
7AnLdwgAjHkq22/YPazauz9li4T4Gglucux/NLvOBjrtwIyk/K6zn7623YCWSdlK
NyV358wdTE69ID/SzlfwOFXzUyLx6XuH94galV4v/TDb0/SkpquraC6Q1R/EvnYJ
s1WrijKXQhlcfpv5pJQ/dIyJKiqi14uPhMuBWjNuF4UbXAWwBMLY+4h9KbpiS8xh
IyafzqeexB/3lcRDPOAwfREqMC72lkpCkLJJDkOidnkzmDsz5UUASXF2FD0nTEZN
+qjglyOImwcCE3S6+chwceGxLdo+wFmUO7/6Xow8UPhbQqEUCZPUx5Eh9JTIVSNC
SdDZDBX6BtI5fXXQLc84Kq/1gVBoYQ==
=xLPR
-----END PGP SIGNATURE-----

--k7bb3avtwrjcunmo--
