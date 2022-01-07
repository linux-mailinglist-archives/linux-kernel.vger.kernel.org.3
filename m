Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6771748730A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 07:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiAGGWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 01:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiAGGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 01:22:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C4C061245;
        Thu,  6 Jan 2022 22:22:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVY666Qv7z4xsl;
        Fri,  7 Jan 2022 17:22:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641536527;
        bh=nHGeUliebDmEO1ebGGAygpLNK2xu1YUT2hKojM43UWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JvIkye2mopHOr9Jw17Wl+wTizDiw9v4p3xMgcAe7FcoG7pQTs9iDJUkejTZEr/mqj
         b9d/MNPgNx4InjCvgF1k5QLaW2fO82dHaJI2/9Ic8+pktGu3rpYVzniOOYwweCqgB4
         njec+rqRj6KDxZmBOCupcbfVdnnK0lLjRPsRjhbhszw04xvpBUYxgMEBv2/apSGD4E
         6G4K88Z6UlqudQdxffgE3G/ENIEJinxajF6QTzNdhNhQBbK+8UMyIexgdxSAEJjvgj
         V3+Gt7UzuFwQYTpjb3FcFr7tjABH/Crn6F0W16U6eE9jNGLWpZZfjSMJK6L+tP8cZS
         MTbk0HDxnexcg==
Date:   Fri, 7 Jan 2022 17:22:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: much more building going on
Message-ID: <20220107172206.3fbdd09f@canb.auug.org.au>
In-Reply-To: <20220107171319.0afa619a@canb.auug.org.au>
References: <20220107171319.0afa619a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gfnq..WJdAx3hrDrbehH6IR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gfnq..WJdAx3hrDrbehH6IR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Jan 2022 17:13:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Since yesterday, my builds are taking much longer and it seems just
> about everything is being rebuilt when there should be very little done.
>=20
> One example is after mergeing the clockevents tree, the diffstat looks
> like this:
>=20
> $ git diff --stat HEAD^..
>  .../devicetree/bindings/timer/cdns,ttc.yaml        |   3 +
>  .../bindings/timer/mstar,msc313e-timer.yaml        |  46 ++++
>  .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |   6 +-
>  .../devicetree/bindings/timer/renesas,ostm.yaml    |  20 +-
>  .../bindings/timer/rockchip,rk-timer.yaml          |   1 -
>  MAINTAINERS                                        |   1 +
>  drivers/clocksource/Kconfig                        |  12 +-
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/exynos_mct.c                   |  52 +++--
>  drivers/clocksource/renesas-ostm.c                 |  39 +++-
>  drivers/clocksource/timer-imx-sysctr.c             |   6 +-
>  drivers/clocksource/timer-msc313e.c                | 253 +++++++++++++++=
++++++
>  drivers/clocksource/timer-pistachio.c              |   3 +-
>  13 files changed, 411 insertions(+), 32 deletions(-)
>=20
> but my powerpc and arm builds rebuilt basically everything.
>=20
> This happens for a lot of merges - though some do not rebuild very much
> at all.
>=20
> Any ideas about what changed yesterday?  (I directed this to the kbuild
> tree maintainer since the kbuild tree was updated yesterday - though
> that may be a coincidence).

OK, it *may* have something to do with Kconfig file updates for example wit=
h this diffstat:

 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  1 +
 drivers/edac/Kconfig                               |  2 +-
 drivers/edac/amd64_edac.c                          | 36 ++++++++++++++-
 drivers/edac/amd64_edac.h                          |  8 +++-
 drivers/edac/edac_mc.c                             |  2 +
 drivers/edac/sb_edac.c                             |  2 +-
 drivers/edac/sifive_edac.c                         |  2 +-
 drivers/edac/synopsys_edac.c                       | 52 ++++++++++++++++++=
----
 drivers/ras/cec.c                                  |  2 +-
 include/linux/edac.h                               |  6 +++
 10 files changed, 98 insertions(+), 15 deletions(-)

And only this Kconfig change:

$ git diff HEAD^.. drivers/edac/Kconfig
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 2fc4c3f91fd5..58ab63642e72 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
=20
 config EDAC_SYNOPSYS
        tristate "Synopsys DDR Memory Controller"
-       depends on ARCH_ZYNQ || ARCH_ZYNQMP
+       depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
        help
          Support for error detection and correction on the Synopsys DDR
          memory controller.

I noticed that the following files have changed (timestamp at least) in
the object directory:

-rw-r--r-- 1 sfr users    46271 Jan  7 17:09 ./include/config/auto.conf.cmd
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_TCP_C=
ONG
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_INIT
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/BUILD_SALT
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_SYSTOHC_D=
EVICE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_TARGETS
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_IMPLICIT_F=
ALLTHROUGH
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_HCTOSYS_D=
EVICE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_FIRMWARE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_HOSTN=
AME
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_VERSION_TE=
XT
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MODPROBE_PATH
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LOCALVERSION
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/INITRAMFS_SOU=
RCE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/FAT_DEFAULT_I=
OCHARSET
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CMDLINE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/NLS_DEFAULT
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MAGIC_SYSRQ_S=
ERIAL_SEQUENCE
-rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LSM
-rw-r--r-- 1 sfr users    54294 Jan  7 17:09 ./include/generated/autoconf.h
-rw-r--r-- 1 sfr users    39198 Jan  7 17:09 ./include/config/auto.conf

then lots more is rebuilt.
--=20
Cheers,
Stephen Rothwell

--Sig_/gfnq..WJdAx3hrDrbehH6IR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHX3A4ACgkQAVBC80lX
0Gzy5Qf8CwGEMFBySFhGkmnSMraFTI2kyaPxmd7fn75Hd/xKyIkIJp5txKpReDPD
nBA+xrpGP3emNkSSAOcqaeybFY3foddQt8CGCWiyVaJhlY3AOpvNr7e5QZqzIgtD
O1CZFDDVoBwFP/lCbueNY5xRe1Q6vmgDv6SfxERjmOpc39y9B2bZSGyHqlrbw8Od
apeWnvFNmGts6/pnSTkUQuiBrLTXxHmY18fxw/vaQwchozdFQ33iVi/FDdgcIPfu
brZpATo0VFC0d4oCKZ1YyVMaTmJuhL7oT+Ay8wo6TgqeYB5i6GEEgnrOQsokw9Kn
4ZLkwZi+yq9py/GlHUZlmmf+T3B73Q==
=AKR7
-----END PGP SIGNATURE-----

--Sig_/gfnq..WJdAx3hrDrbehH6IR--
