Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70C74784D8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhLQGRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:17:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0BC061574;
        Thu, 16 Dec 2021 22:17:13 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFf056MXRz4xgr;
        Fri, 17 Dec 2021 17:17:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639721831;
        bh=Sxk9pSOVUWGlx6aw6yoTNNFNvpVzVzRtcwo+ZsVFB70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMwRibMOpoWYaQhnUxJvEW0Z2LgsS5nvAXjUqoIHnj0BW0F3acUydDBHX3Q18D3Gn
         PJsMArtmLjTEq+lPFLzDcm+vYbNbToEwLQHc7vRXJD+vw4Lu2MwLuBpQxGT0Mz8sVd
         88ZLLmm5CKNsDda12kVZ570KJZtaU0S+eIbVoOz26SGALJQfE+pi0qC2nNfH6eSi4e
         f8odj4E7JxRx1H58rPGvDH40K9mptJm9Uq50l/nwEYHRR5dXgFrmezpK3BU1uEIpL1
         ULs3OS+u467DdhU+RATh+tqMN9+rSRaS1/X4wb4JCKTAxfHgcbZOn5GlC8NIXE58rz
         zc2Iqg8REo7Nw==
Date:   Fri, 17 Dec 2021 17:17:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     broonie@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20211217171709.622cbb1d@canb.auug.org.au>
In-Reply-To: <b7f4804a-01dd-9dd9-01f1-2187a955cb13@gmail.com>
References: <20211213203112.969238-1-broonie@kernel.org>
        <b7f4804a-01dd-9dd9-01f1-2187a955cb13@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JMOMWxIWYEyzJYbLZ/l4LtD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JMOMWxIWYEyzJYbLZ/l4LtD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 13 Dec 2021 19:12:05 -0800 Florian Fainelli <f.fainelli@gmail.com> =
wrote:
>
> On 12/13/2021 12:31 PM, broonie@kernel.org wrote:
> > Hi all,
> >=20
> > After merging the gpio-brgl tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > /tmp/next/build/drivers/gpio/gpio-bcm-kona.c:508:34: error: duplicate '=
const' declaration specifier [-Werror=3Dduplicate-decl-specifier]
> >    508 | static const struct of_device_id const bcm_kona_gpio_of_match[=
] =3D {
> >        |                                  ^~~~~
> > cc1: all warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >    19784a059cf47b ("gpio: bcm-kona: add const to of_device_id")
> >=20
> > I used the tree from yesterday instead. =20
>=20
> Doh! Should have double checked the code as the diff was not giving
> enough context. This patch should simply be dropped, not even build
> tested by Xiang it seems.

Today, I have reverted that commit.  Please remove or revert it ASAP.

--=20
Cheers,
Stephen Rothwell

--Sig_/JMOMWxIWYEyzJYbLZ/l4LtD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8K2UACgkQAVBC80lX
0Gx85AgAiXE/zaVw9y3mL9K0gEfhwhW9iaulOhjVMO1gjRtGKyYfNhaf3V8U5qEF
4LrcFceFSeu/O6TmuVWsVzE+40059NIf53/7GieKp76M4lR6C4FwgF0zgGRPHL53
7WGwcW4AVX2RmTWcyLuyayLJuJ4e6eRVlFvpfPkgBHxSaLYB1bDoiUDTAB1QlWme
bR3oJ9/CLU6nElBJ7jwBIFJ+xaW5QF4WXqZ2ohSvGjE73BYVHP/zR9gqEIPuiMU2
V6PEnGxGe/fY88cIneLxXGM2lxATQbWDU9T1rXNaj4zVz3l6PB73PVobkuQDwrX7
uYLJTQkpYhBPor2VNCntWH2GMGhz/Q==
=Ad90
-----END PGP SIGNATURE-----

--Sig_/JMOMWxIWYEyzJYbLZ/l4LtD--
