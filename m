Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE7597EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243646AbiHRGts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiHRGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:49:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5A61D71
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:49:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOZLN-0001pt-8l; Thu, 18 Aug 2022 08:49:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOZLK-000Sbn-HV; Thu, 18 Aug 2022 08:49:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oOZLJ-00CTRO-V2; Thu, 18 Aug 2022 08:49:25 +0200
Date:   Thu, 18 Aug 2022 08:49:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the icc tree
Message-ID: <20220818064922.fejqbxpvc6epuqfr@pengutronix.de>
References: <20220818115326.407aa3e0@canb.auug.org.au>
 <47aa5e68-a41c-bb22-bce6-ab11a33b3d9c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnrsn66jea5kvek7"
Content-Disposition: inline
In-Reply-To: <47aa5e68-a41c-bb22-bce6-ab11a33b3d9c@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vnrsn66jea5kvek7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 18, 2022 at 08:00:51AM +0300, Georgi Djakov wrote:
> On 18.08.22 4:53, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the icc tree, today's linux-next build (x86_64 allmodconf=
ig)
> > failed like this:
> >=20
> > drivers/interconnect/imx/imx8mp.c: In function 'imx8mp_icc_remove':
> > drivers/interconnect/imx/imx8mp.c:245:16: error: void value not ignored=
 as it ought to be
> >    245 |         return imx_icc_unregister(pdev);
> >        |                ^~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/interconnect/imx/imx8mp.c:246:1: error: control reaches end of =
non-void function [-Werror=3Dreturn-type]
> >    246 | }
> >        | ^
> >=20
> > Caused by commit
> >=20
> >    d761e0e9c8f2 ("interconnect: imx: Make imx_icc_unregister() return v=
oid")
> >=20
> > I have used the icc tree from next-20220817 for today.

I tried to understand what went wrong here. The problem is that the
patch "interconnect: imx: Make imx_icc_unregister() return void" was
developed on top of v5.19-rc1, which doesn't contain
drivers/interconnect/imx/imx8mp.c. This was only introduced in

	c14ec5c93dc8 ("interconnect: imx: Add platform driver for imx8mp")

for v6.0-rc1.

> Thanks Stephen! Fixed.

The history in the icc tree now looks as follows:

$ git lgg linus/master..FETCH_HEAD
*   8c9b6a59edb7 Merge branch 'icc-ignore-return-val' into icc-next
|\
| * f62e3f595c5f interconnect: imx: Make imx_icc_unregister() return void
* |   c86cfdbaf8e3 Merge branch 'icc-ignore-return-val' into icc-next
|\ \
| * | d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
| |/
| * 680f8666baf6 interconnect: Make icc_provider_del() return void
| * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider_=
del() in .remove()
| * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider_=
del() in .remove()
| * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provider=
_del() in .remove()
| * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provide=
r_del() in .remove()
| * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provider=
_del() in .remove()
| * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_del=
() in .remove()
|/
o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1

So the commit that doesn't build is still included and might annoy
bisection. Also in my eyes it's kind of ugly to have two commits with
identical commit log and nearly identical content in the same tree.

I don't know your preferences about not rewriting your tree once it was
exposed to the public, but if you are willing to rewrite your tree to
improve, the possibilities (in order of my preference) are:

 - Drop the broken commit and only include the fixed
   icc-ignore-return-val branch.

 - On top of the broken branch add a commit that only fixes the problem
   but doesn't duplicate most of d761e0e9c8f2, yielding something like:

	*   bcdefghijlkm Merge branch 'icc-ignore-return-val' into icc-next
	|\
	| * abcdefghijkl interconnect: imx: Fix imx8mp build
	| * d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
	| * 680f8666baf6 interconnect: Make icc_provider_del() return void
	| * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider=
_del() in .remove()
	| * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider=
_del() in .remove()
	| * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provide=
r_del() in .remove()
	| * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provid=
er_del() in .remove()
	| * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provide=
r_del() in .remove()
	| * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_de=
l() in .remove()
	|/
	o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1

   or

	* abcdefghijkm interconnect: imx: Fix imx8mp build
	*   c86cfdbaf8e3 Merge branch 'icc-ignore-return-val' into icc-next
	|\
	| * d761e0e9c8f2 interconnect: imx: Make imx_icc_unregister() return void
	| * 680f8666baf6 interconnect: Make icc_provider_del() return void
	| * fa80a2994d35 interconnect: sm8450: Ignore return value of icc_provider=
_del() in .remove()
	| * f221bd781f25 interconnect: osm-l3: Ignore return value of icc_provider=
_del() in .remove()
	| * 919d4e1a207e interconnect: msm8974: Ignore return value of icc_provide=
r_del() in .remove()
	| * 4681086c9bec interconnect: icc-rpmh: Ignore return value of icc_provid=
er_del() in .remove()
	| * 8ef2ca20754d interconnect: icc-rpm: Ignore return value of icc_provide=
r_del() in .remove()
	| * 7ec26b8dcc5c interconnect: imx: Ignore return value of icc_provider_de=
l() in .remove()
	|/
	o 568035b01cfb (tag: v6.0-rc1) Linux 6.0-rc1

 - At least point out in the fixed variant, what and why it was
   necessary to redo the commit.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vnrsn66jea5kvek7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL94PAACgkQwfwUeK3K
7Amf0ggAhMnZ5UcAWq8LvwHlH/3lEGGkC3XGGDsPL4xcFgp5OJF+WYjrzyRPqQb0
oW+DCcvznVWN4M/90Lmocgi8FNRiVGxJxz9fWoy+2EvnMcktT76bA4Gurasb8p++
FsSxMGK3+NUsGPo6s+lJFLR4rWje+xWBBVStnHr+2NEvC24rzDOLtUVGpdpTQz+U
pYk6z2qLc7prhqHzPW7T4vjqA+qKOGCfiWS49ox15c/ODBCxkxTZ4vYJ47Jzva6/
EVnS6z6FuBjs4en+wWGDzxGAeT4XKY6wcPWIX4n9kF7qPN5afkGnzIwL0ZH1JJS2
kdQhiLC7rVgud/QsSLROtZlZL4a02Q==
=qYIV
-----END PGP SIGNATURE-----

--vnrsn66jea5kvek7--
