Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131A04872F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiAGGNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:13:23 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:43737 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiAGGNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:13:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVXw00M05z4xgr;
        Fri,  7 Jan 2022 17:13:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641536000;
        bh=A927bVRXwBXXxEsts/5DH5buJWWCuz3mbafKAfATYyE=;
        h=Date:From:To:Cc:Subject:From;
        b=E00kYVQmYFz9wkftQxBh2GMDc7F8C6aCe0Bp/QOlwREun537vr9iDOZ0Kw5RKYvtX
         iKvXWLwwnSdMyCFZAakfMeuv2bWyRGW+3GWhrPfKHbLyuR3vKAwauM67KQFOYONdAO
         lbhtJC+esiy/JOo8XR5lXpYYKZwz2XX+5BSDDZOybQfRwwi6asJ4yT2HCfEWvd4jr9
         AEsnujFOCP11aHRhw0TX5XiYUDr7gior4UgDIaQWo+QO7YIjdCFqmGfaAKk/iThRgx
         ACtKH0gUdhNJtusrdowPAPpx2/S5cxdQgHeMuA0Kd/3kRP09FLflxsJK6xRQ91HfPz
         iVWNEzUGUN79Q==
Date:   Fri, 7 Jan 2022 17:13:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: much more building going on
Message-ID: <20220107171319.0afa619a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1opUu0NXt2aqNS/fkR1G5Cy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1opUu0NXt2aqNS/fkR1G5Cy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Since yesterday, my builds are taking much longer and it seems just
about everything is being rebuilt when there should be very little done.

One example is after mergeing the clockevents tree, the diffstat looks
like this:

$ git diff --stat HEAD^..
 .../devicetree/bindings/timer/cdns,ttc.yaml        |   3 +
 .../bindings/timer/mstar,msc313e-timer.yaml        |  46 ++++
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |   6 +-
 .../devicetree/bindings/timer/renesas,ostm.yaml    |  20 +-
 .../bindings/timer/rockchip,rk-timer.yaml          |   1 -
 MAINTAINERS                                        |   1 +
 drivers/clocksource/Kconfig                        |  12 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/exynos_mct.c                   |  52 +++--
 drivers/clocksource/renesas-ostm.c                 |  39 +++-
 drivers/clocksource/timer-imx-sysctr.c             |   6 +-
 drivers/clocksource/timer-msc313e.c                | 253 +++++++++++++++++=
++++
 drivers/clocksource/timer-pistachio.c              |   3 +-
 13 files changed, 411 insertions(+), 32 deletions(-)

but my powerpc and arm builds rebuilt basically everything.

This happens for a lot of merges - though some do not rebuild very much
at all.

Any ideas about what changed yesterday?  (I directed this to the kbuild
tree maintainer since the kbuild tree was updated yesterday - though
that may be a coincidence).

--=20
Cheers,
Stephen Rothwell

--Sig_/1opUu0NXt2aqNS/fkR1G5Cy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHX2f8ACgkQAVBC80lX
0GxkewgAjaNbjopp+6M6VjBa1CMaKyMUwqdCdqZ4OPFVJ0ivFsAyPz43D0hNjoGW
M3ppCo4021dxfjcO3n9QyUDZjaJwdi5d+aRatrAGYbpEHqgRNms63cExj/j/Q49a
onnpohWIdttdQOtEv+GCpCRIAXh+e+vcdSfPV/CN4XkLn6PoFRawEk+vS0PitlW2
jcT45K10+zWOBQr8MXBNpHcqSsMM7mKutjn+IyQ0PgUjNn5766j5Noli9eRZINsm
YOFqpWg2CgDy48kUZo9CKIbqA4qJUy4qLuTcpZ7BrgqB8M3FYEIzfCPYHevZszHQ
gr96telH4kOlMd2WIJAYV4limjpajw==
=Xw6I
-----END PGP SIGNATURE-----

--Sig_/1opUu0NXt2aqNS/fkR1G5Cy--
