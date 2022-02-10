Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC54B03D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiBJDPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:15:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiBJDPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:15:53 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E341EAEA;
        Wed,  9 Feb 2022 19:15:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvMMW0fwqz4xcZ;
        Thu, 10 Feb 2022 14:15:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644462954;
        bh=YEYZ9rdVdAY9trR21mrgYWCNGNapNz8GMzdkDsXSNXA=;
        h=Date:From:To:Cc:Subject:From;
        b=WGYren9rWmTLXYiJ0k4pkuQOH/Df/a6u8oEKe/mPfGhE4LyWF/GfB6IKwozVkCuTU
         P1EHlGgXXFZTgLvx5L75pktQWi/8e/rrMCYkTGkpweC1SiXrC/USr9ZOVwWo+9Srfo
         5cmIPapTIkhHz9v0OOagA20k1lRPS/MISXxsQg5FOEVCn4WYidyOHDUJRqBaYgxVYs
         VSHaJmRb++QjruHn2RvUnEgfB4g35uU5/4moANewRVlknobZamHEErgoAJ2zkMcYM5
         866EqMhUe9vzExWSgd9zDDDIcujQUPcJDKsaeZxoms6J7ZfOWDg5NoGM7sv7aGcicc
         vFXVoOxYmBvng==
Date:   Thu, 10 Feb 2022 14:15:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Michal Simek <monstr@monstr.eu>
Cc:     David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: linux-next: manual merge of the usb tree with the xilinx tree
Message-ID: <20220210141550.56359523@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fy3+0PX1DoNv9IYfv3B555E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fy3+0PX1DoNv9IYfv3B555E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  arch/arm64/boot/dts/xilinx/zynqmp.dtsi

between commit:

  eceb6f8677d3 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")

from the xilinx tree and commit:

  d8b1c3d0d700 ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 056761c974fd,ba68fb8529ee..000000000000
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@@ -823,6 -824,8 +822,7 @@@
  				interrupt-parent =3D <&gic>;
  				interrupt-names =3D "dwc_usb3", "otg";
  				interrupts =3D <0 65 4>, <0 69 4>;
+ 				clock-names =3D "bus_early", "ref";
 -				#stream-id-cells =3D <1>;
  				iommus =3D <&smmu 0x860>;
  				snps,quirk-frame-length-adjustment =3D <0x20>;
  				/* dma-coherent; */
@@@ -849,6 -851,8 +848,7 @@@
  				interrupt-parent =3D <&gic>;
  				interrupt-names =3D "dwc_usb3", "otg";
  				interrupts =3D <0 70 4>, <0 74 4>;
+ 				clock-names =3D "bus_early", "ref";
 -				#stream-id-cells =3D <1>;
  				iommus =3D <&smmu 0x861>;
  				snps,quirk-frame-length-adjustment =3D <0x20>;
  				/* dma-coherent; */
--=20
Cheers,
Stephen Rothwell

--Sig_/fy3+0PX1DoNv9IYfv3B555E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEg2YACgkQAVBC80lX
0GyQyAgAjW4GZ0U3SydpR+bqSSnGsMP7XxYhEs4iEI+BYobsVQF7CpxltltIsEdU
KdhUz+NwDfnoxa2pv3A9JEfTYDZDw2MIraFiZ6vM8CfiWeGDjTXsvcvQDnKTvR3Y
IX3WENv0I5V863hyJtgd0iJLY90Ww/h9UvXlGqV9S8F1BHK90LGLGqjWkI9v9CDQ
q5sT4qfQe07cwJ9x8Ni+0Nr78tXPdSoMCQB38JmoailgxVHufIXQC1/B7H2ysj30
MZvGYUPX8ADMLQ1UDSH07e6MT7EpINydKBZDbWXvaYNrrwZM5nZAZTlBIB8kucAJ
64fGrpkZ/llMvMWHF+fRI8VWwMQbPA==
=8QhC
-----END PGP SIGNATURE-----

--Sig_/fy3+0PX1DoNv9IYfv3B555E--
