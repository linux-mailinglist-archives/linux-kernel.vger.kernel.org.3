Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CB4881CE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiAHGOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 01:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiAHGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 01:14:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B1C061574;
        Fri,  7 Jan 2022 22:14:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JW8tp4Fslz4xZ1;
        Sat,  8 Jan 2022 17:14:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641622466;
        bh=VlbUS0YFLzM/+xUK70jWJdSjwW9tB9L5ujY3XHpJa1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=olc3XfDjpgRqTqCJd12QJ9KESCKlNQrGPWU15SmY5eS0jJXaozwVmG0o4Tp/yy/Ml
         oUQC9nTjV2Ng9h/1TWDD8kftkA3xwp5ckU806bQEeJY6M/3kTBd/VrYSq08CVWvev3
         LnIXqqpxxvduDRnzuKQvGyim4DxZyjQQ5xRIGqAGpWJ8EJRTDioAcXcfLGASLSaHPu
         /wrL4mrZO9/oZ+SpkYLPQYqfECY9MGgX6uXb2JJtJeqx58z8hE/rIEMsqNniKWNVNb
         G4vMt4euqVCAptMS6vm0dnCR3F31g/fBpDesmq/k8s1H877eZdxepYjuNTZydYgKCh
         DwF2BjmtMJI3Q==
Date:   Sat, 8 Jan 2022 17:14:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: much more building going on
Message-ID: <20220108171424.669e37d6@canb.auug.org.au>
In-Reply-To: <20220107172206.3fbdd09f@canb.auug.org.au>
References: <20220107171319.0afa619a@canb.auug.org.au>
        <20220107172206.3fbdd09f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k4Lxhz0euttgII+Xqj+ro9j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k4Lxhz0euttgII+Xqj+ro9j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Jan 2022 17:22:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Fri, 7 Jan 2022 17:13:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > Since yesterday, my builds are taking much longer and it seems just
> > about everything is being rebuilt when there should be very little done.
> >=20
> > One example is after mergeing the clockevents tree, the diffstat looks
> > like this:
> >=20
> > $ git diff --stat HEAD^..
> >  .../devicetree/bindings/timer/cdns,ttc.yaml        |   3 +
> >  .../bindings/timer/mstar,msc313e-timer.yaml        |  46 ++++
> >  .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |   6 +-
> >  .../devicetree/bindings/timer/renesas,ostm.yaml    |  20 +-
> >  .../bindings/timer/rockchip,rk-timer.yaml          |   1 -
> >  MAINTAINERS                                        |   1 +
> >  drivers/clocksource/Kconfig                        |  12 +-
> >  drivers/clocksource/Makefile                       |   1 +
> >  drivers/clocksource/exynos_mct.c                   |  52 +++--
> >  drivers/clocksource/renesas-ostm.c                 |  39 +++-
> >  drivers/clocksource/timer-imx-sysctr.c             |   6 +-
> >  drivers/clocksource/timer-msc313e.c                | 253 +++++++++++++=
++++++++
> >  drivers/clocksource/timer-pistachio.c              |   3 +-
> >  13 files changed, 411 insertions(+), 32 deletions(-)
> >=20
> > but my powerpc and arm builds rebuilt basically everything.
> >=20
> > This happens for a lot of merges - though some do not rebuild very much
> > at all.
> >=20
> > Any ideas about what changed yesterday?  (I directed this to the kbuild
> > tree maintainer since the kbuild tree was updated yesterday - though
> > that may be a coincidence). =20
>=20
> OK, it *may* have something to do with Kconfig file updates for example w=
ith this diffstat:
>=20
>  .../memory-controllers/synopsys,ddrc-ecc.yaml      |  1 +
>  drivers/edac/Kconfig                               |  2 +-
>  drivers/edac/amd64_edac.c                          | 36 ++++++++++++++-
>  drivers/edac/amd64_edac.h                          |  8 +++-
>  drivers/edac/edac_mc.c                             |  2 +
>  drivers/edac/sb_edac.c                             |  2 +-
>  drivers/edac/sifive_edac.c                         |  2 +-
>  drivers/edac/synopsys_edac.c                       | 52 ++++++++++++++++=
++----
>  drivers/ras/cec.c                                  |  2 +-
>  include/linux/edac.h                               |  6 +++
>  10 files changed, 98 insertions(+), 15 deletions(-)
>=20
> And only this Kconfig change:
>=20
> $ git diff HEAD^.. drivers/edac/Kconfig
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 2fc4c3f91fd5..58ab63642e72 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
> =20
>  config EDAC_SYNOPSYS
>         tristate "Synopsys DDR Memory Controller"
> -       depends on ARCH_ZYNQ || ARCH_ZYNQMP
> +       depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
>         help
>           Support for error detection and correction on the Synopsys DDR
>           memory controller.
>=20
> I noticed that the following files have changed (timestamp at least) in
> the object directory:
>=20
> -rw-r--r-- 1 sfr users    46271 Jan  7 17:09 ./include/config/auto.conf.c=
md
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_TCP=
_CONG
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_INIT
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/BUILD_SALT
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_SYSTOHC=
_DEVICE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_TARGE=
TS
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_IMPLICIT=
_FALLTHROUGH
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_HCTOSYS=
_DEVICE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_FIRMW=
ARE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_HOS=
TNAME
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_VERSION_=
TEXT
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MODPROBE_PA=
TH
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LOCALVERSION
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/INITRAMFS_S=
OURCE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/FAT_DEFAULT=
_IOCHARSET
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CMDLINE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/NLS_DEFAULT
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MAGIC_SYSRQ=
_SERIAL_SEQUENCE
> -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LSM
> -rw-r--r-- 1 sfr users    54294 Jan  7 17:09 ./include/generated/autoconf=
.h
> -rw-r--r-- 1 sfr users    39198 Jan  7 17:09 ./include/config/auto.conf
>=20
> then lots more is rebuilt.

Bisection points to commit

  33c1957574b6 ("kbuild: do not quote string values in include/config/auto.=
conf")

from the kbuild tree and indeed if I revert commits

  ec769168623b ("microblaze: use built-in function to get CPU_{MAJOR,MINOR,=
REV}")
  98bb79d61f0c ("certs: move scripts/extract-cert to certs/")
  33c1957574b6 ("kbuild: do not quote string values in include/config/auto.=
conf")

from the merge of the kbuild tree into linux-next (up to that point),
the problem goes away.

My test case is this:

$ rm -rf ../test
$ mkdir ../test
$ make ARCH=3Dpowerpc O=3D../test -s ppc64_defconfig
$ make ARCH=3Dpowerpc O=3D../test -j40 -O init/main.o
(edit drivers/edac/Kconfig as above)
$ make ARCH=3Dpowerpc O=3D../test -s ppc64_defconfig
$ make ARCH=3Dpowerpc O=3D../test -j40 -O init/main.o

In the good case, none of the files in ../test/include/config
representing CONFIG_ options are changed and init/main.o is not
rebuilt.  In the bad case some of the files above (in
../test/include/config) are touched and init/main.o is rebuilt.

Please see if you can figure out what actually is wrong with
33c1957574b6 or else remove those commits from the kbuild tree (or
revert them).  This extra rebuilding is adding about 7 hours to my day
:-(

--=20
Cheers,
Stephen Rothwell

--Sig_/k4Lxhz0euttgII+Xqj+ro9j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHZK8AACgkQAVBC80lX
0Gwr1wf6AqB7PkbVu6cqb5K5A22VhUJy7s68MvOd+HP8yDXA/Np5q1OM6Vdu4TPG
b4nYKZaMmKJxOnRq6/C+RdFPY2FVc4XIxEclFdSkFRKR6oLzZMwvUeBbh3OWoaQ1
QjksD4i7HDSzCeJ7/XFTzgQxtM2e8WrxQIxq9slCq5rpqH3cgMPoBsW1+UA/S8x8
pJO1UPecHL86SGIHQg/8rNjPPzbL/AhUOoQbrXuBZRE87xJpUUpOxuePEyd/1i7x
vOWmTaXY0RP5xV6RDcmN7Sf2Dcu5h+01R9v8O81oZ7ppNB/W/3m7p8hl28lWsBZg
t7QUWVRnb5vVX7GqGvyhUk8FBPyKVw==
=D188
-----END PGP SIGNATURE-----

--Sig_/k4Lxhz0euttgII+Xqj+ro9j--
