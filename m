Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE4E47A4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhLTFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:51:11 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58205 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhLTFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:51:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHTGg1hYvz4xbt;
        Mon, 20 Dec 2021 16:51:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639979468;
        bh=SQpFKznPA/gDpqjGwY9lgXYhYku+ATtyjagJj+hoPsE=;
        h=Date:From:To:Cc:Subject:From;
        b=P3g8O6ui3/QzllMkwgECt3j/tD5eL+6de8FA/W5hkR8FQMu85CXYqJ+wpySaWLbkz
         Y9jbbgeXZu9QHOa+b8UpMNzuWiNzzpiECp2LE+733AOE3Gfex/kFtE7eK4N5ChpsrD
         uxZh94MMh8mwV9DohUFMruianPv77XjpnR5EeEXhAxJd4oPyKguhOwjrfEgre26XcQ
         ZyQs9UO+SSbRKilvDuq3865KK6cHNUU02PP7sWOZMTFkJM/9IaW3txrUDYykZYdwqo
         edODHPBajwGuDjfYZxbVBpsWbKeJOA4AhBEwXDENr2KSYaVpXTlfRSNayW99Ebe5Lp
         VEP82eJfcjXBA==
Date:   Mon, 20 Dec 2021 16:51:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20211220165103.0d75d56d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_HQ.Dfg=R1B6SVp=n9agSUG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_HQ.Dfg=R1B6SVp=n9agSUG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpio/gpio-rda.c: In function 'rda_gpio_probe':
drivers/gpio/gpio-rda.c:200:22: error: unused variable 'np' [-Werror=3Dunus=
ed-variable]
  200 |  struct device_node *np =3D pdev->dev.of_node;
      |                      ^~
cc1: all warnings being treated as errors

Caused by commit

  448cf90513d9 ("gpio: Get rid of duplicate of_node assignment in the drive=
rs")

I have used the gpio-brgl tree from next-20211217 (with the revert) for tod=
ay.
--=20
Cheers,
Stephen Rothwell

--Sig_/_HQ.Dfg=R1B6SVp=n9agSUG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHAGcgACgkQAVBC80lX
0GwXcgf+Muw3SHEIiLns36gH7NiRlc7z3b/AXtKy7EyQPtnsafh9B/AVC5n2Hjkj
Ke9lPgZowliYJO091HwBtt1e1yv9kiVm+RSSVPjlX3qV7GrV6fKPzkNVx5GIyaEY
nocPj0XjZIX8Nm9jyPW94AY9dOQAwnG/heml6CmB5CH2gp+Bj98BbOPQdX6vKF0F
5J6MjxoAkFBszRLJakn+v5+YAp7Xh0I8dGKTEv9nxMIsVUyfGmaAzNOIl1iWkEcn
ke3jDHI+oyEmINnyZu0VycM+lrPjha9B1DsddjjenAstrJh0rhtUema9Q3BNtEOE
imt1SNCONO18m2jYXXGMW/Hhcf7CiQ==
=EQX3
-----END PGP SIGNATURE-----

--Sig_/_HQ.Dfg=R1B6SVp=n9agSUG--
