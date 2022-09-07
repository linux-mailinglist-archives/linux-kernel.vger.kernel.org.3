Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49B65B1020
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIGXBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:01:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDAAF49D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:01:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MNHmg2Rkyz4x1d;
        Thu,  8 Sep 2022 09:01:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662591669;
        bh=1wst7Xpv4YpN5d2XSCKrsJPTTDlZ8FFJBBI/7ix5MqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D7QwTp1R7NMG6eKndfx6T+gbhvz56bW4QmdyXGoz1a10YLfBg0QQ3YBZ0HxbyJ0q0
         vELme/yMIpbK0CHHfvwoJfA71XcLgenMADVHriYPWAKj3u5biQ4M7QRibmofrH9dk8
         LRHucWdEFOR1y036NBS1wOHP9hsK2Jsm6zvdeTg+JB+KZ5as7Re5P93HSd99SRalNF
         xydq1OFQwZcotQIx9ewuzNhLPpExUNurA2MrAAuJZd7pcMGWenRMSsdYvEV6rIkOh6
         BGWaoTl1343XvuSi2C29/EhfEE4g4k8sxy/ZR7G+P5P34PYe4bNpID1efGUGSfBdI0
         jhRtGlVf5/t1Q==
Date:   Thu, 8 Sep 2022 09:01:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joe Perches <joe@perches.com>
Cc:     Philippe Schenker <dev@pschenker.ch>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH] checkpatch: add check for fixes: tag
Message-ID: <20220908090100.155b9b26@canb.auug.org.au>
In-Reply-To: <1125e8a68a709e18b594f74fc9b25b9992b1582f.camel@perches.com>
References: <20220907123547.138646-1-dev@pschenker.ch>
        <1125e8a68a709e18b594f74fc9b25b9992b1582f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4QkMvq3jH8bTS8yvUfk=d4X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4QkMvq3jH8bTS8yvUfk=d4X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joe,

On Wed, 07 Sep 2022 08:18:31 -0700 Joe Perches <joe@perches.com> wrote:
>
> I think the test better if it checks for a SHA1 after fixes.
>=20
> And IMO
>=20
> 	!(foo =3D~ /bar.../)
>=20
> is better written as
>=20
> 	foo !~ /bar.../
>=20
> so
>=20
> 		if ($in_commit_log &&
> 		    $line =3D~ /^\s*Fixes:?\s*[0-9a-f]{5,}\b/i &&
> 		    $line !~ /^Fixes: [0-9a-f]{12,40} \(\".*\"\)/)) {
>=20
> Though it's arguable that the SHA1 should _only_ be length 12
> and not longer.

It should be allowed to be longer - eventaully we will need to move on
from 12 as the repo gets bigger.  Also, any line matching /^\s*Fixes:/i
should be checked, because people do add extra words before the SHA1
and sometimes just other text.  You will get some hits that are not
meant to be Fixes tags, but very few.

--=20
Cheers,
Stephen Rothwell

--Sig_/4QkMvq3jH8bTS8yvUfk=d4X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMZIqwACgkQAVBC80lX
0GxfEAgAlmSKNCC4+GTKCuPH2rpvpobiLBlnVyFGAJymO53KD9GKtRPWU/W2aRsa
PzynD1DkVxlwYhSyIwejvmuMUiEvpfLYxDGhXGU/EJwBB8CZIX6ZKcSBA6W0iDgN
o6r26Dx9pb4vACBGJKTEKprWURRsb2VVxYxE75G3vpsq5trfgvTh3qJeWD5KpyuM
Rdkg5hrsTwrgzDoEkKfrEffk/7GXxoU8GXrxnf0lBjg12/XVqCL1SDO0r5iNT+O7
aFnR9lO01UEcv3Vj8Q9Cl6yF6bYGrWQqLv/yXf8HBld7jH6tEzT60ibGkxFQuYJp
qnEeQhfQaP9TuMcZjSwoxMxU82fp0Q==
=JT6S
-----END PGP SIGNATURE-----

--Sig_/4QkMvq3jH8bTS8yvUfk=d4X--
