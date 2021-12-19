Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56F447A2E1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbhLSWkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbhLSWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404DEC061747;
        Sun, 19 Dec 2021 14:40:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHHjT3yDTz4xdH;
        Mon, 20 Dec 2021 09:40:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639953615;
        bh=u1QIMzFJjeo2TDuR7/RJnTeCZHoL50v4M8TcY2DkEok=;
        h=Date:From:To:Cc:Subject:From;
        b=a2gW7wHIswVypPuz8XA1MsqsVu3Nx5UgSIqYD4//uwtJBl5VjR2cKUB9TKkxw6Tm9
         qfxMtJ5yintjwLNM/IAbrh159WkJ/mL0FBASiTX8RukI/QQ/Dgdd1Z3d9pKceUfvKR
         aJeRq+un24EBKbjBJZUuVBDF0JrEPz3ST/6VebsWUtrI+YDGXImQdYS4ddUeJBdKis
         QqNhPmY0rMw2FcigeExWheImyrv8oiawvqSHQc9sn4Vs0GRodMkRcLl3kJfH7+vpmR
         4QNA+MfSjV5bn7kMuVejvRnFRJcv8jaS/1EaL/l4Cu1/2DPEU6NBZOXbf522MtEBmH
         YL7awQ14QYJig==
Date:   Mon, 20 Dec 2021 09:40:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: linux-next: manual merge of the samsung-krzk tree with the arm tree
Message-ID: <20211220094012.5a340d45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4NcU5WhHtKqIZLOSq4=O6jS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4NcU5WhHtKqIZLOSq4=O6jS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm/Kconfig

between commit:

  54f481a2308e ("ARM: remove old-style irq entry")

from the arm tree and commit:

  3ac5f9db26bb ("ARM: samsung: Remove HAVE_S3C2410_I2C and use direct depen=
dencies")

from the samsung-krzk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/Kconfig
index 15bc7fba0761,391f07c17096..000000000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -471,7 -478,7 +471,6 @@@ config ARCH_S3C24X
  	select CLKSRC_SAMSUNG_PWM
  	select GPIO_SAMSUNG
  	select GPIOLIB
- 	select HAVE_S3C2410_I2C if I2C
 -	select GENERIC_IRQ_MULTI_HANDLER
  	select NEED_MACH_IO_H
  	select S3C2410_WATCHDOG
  	select SAMSUNG_ATAGS

--Sig_/4NcU5WhHtKqIZLOSq4=O6jS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/tMwACgkQAVBC80lX
0Gy1OQf/Zo5EfHJD8GpoWB5acbe+GRft89GnFvo2DEvjQK11jUzfrsxRQSle5jF6
la4k5L1nRdF6EFStNf4WkD/x3xjHKUx4p2/mw7nuKcMr7u3sLrD5mjFDFBritrnU
TEx6C8Lo2G4tCSBlbOLv9HBMBkZ+lTtgUfSljC1zh+sVKMwCS3CT0c3upAufBcKR
jr4vDIZUb9WlMFNgRE2c5/YP8ihlOcjsbIN5EDziaNy0taLNLYYdrlYDER/Ptepk
eH97RA541+MUGaXzADrwUG6QAY0CG/UlyBuUmSQiL940AjwhbbICGWOlhxNYZZld
LlGRK4Z9lf8V6TW5wN7WcURT8vweAg==
=vNu/
-----END PGP SIGNATURE-----

--Sig_/4NcU5WhHtKqIZLOSq4=O6jS--
