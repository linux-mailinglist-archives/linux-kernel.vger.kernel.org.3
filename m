Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA357FB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbiGYIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:33:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C23BA5;
        Mon, 25 Jul 2022 01:33:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrtbG71qWz4x1b;
        Mon, 25 Jul 2022 18:32:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658737980;
        bh=P9lT9eCsmo9nwgTTK4ek/ReishLdjhBIXxrsysClNMc=;
        h=Date:From:To:Cc:Subject:From;
        b=udwEHMMI2jTV9e8MZWkaXVQlYb8gipVKuJBLBLyOJaOCYTX2d+ygZvl+3rfeRcbh3
         UyqhbUHmQZ6kwsy5sYwFnosdEtnLWT3IF2qNbRwoKf45gWb4LVlGGZIq4mFwattGYR
         pbHehnvoxu46FspLhuWYj5wFiyrRdDmMoyuVMpyt2DUs+gf9lp3p+M40rjNSWahBMX
         hSDOpSRxT3jwc3EOk0nAx0O6Vr8xXs3c0Im2gjtTMndnjI48F/+9BCIgjbXiHOqJE3
         BjHklDwBmOrnWUK/y8gqe7fVTEzzTq5/efMDKI2SVOaQ03xE2t98xAe5qLLP5Z+ncP
         D938AvVjtnnDQ==
Date:   Mon, 25 Jul 2022 18:32:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the efi tree with the arm-soc tree
Message-ID: <20220725183257.670f4cd0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/80xpxgTL.uSaVsjqxcOGn+Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/80xpxgTL.uSaVsjqxcOGn+Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got a conflict in:

  arch/arm/configs/milbeaut_m10v_defconfig

between commit:

  2002f3968714 ("ARM: refresh defconfig files")

from the arm-soc tree and commit:

  0f5b2c69a4cb ("efi: vars: Remove deprecated 'efivars' sysfs interface")

from the efi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/milbeaut_m10v_defconfig
index 37739b61b0c3,9b4789af0201..000000000000
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@@ -44,7 -44,7 +44,6 @@@ CONFIG_ARM_CPUIDLE=3D
  CONFIG_VFP=3Dy
  CONFIG_NEON=3Dy
  CONFIG_KERNEL_MODE_NEON=3Dy
- CONFIG_EFI_VARS=3Dm
 -CONFIG_EFI_CAPSULE_LOADER=3Dm
  CONFIG_ARM_CRYPTO=3Dy
  CONFIG_CRYPTO_SHA1_ARM_NEON=3Dm
  CONFIG_CRYPTO_SHA1_ARM_CE=3Dm

--Sig_/80xpxgTL.uSaVsjqxcOGn+Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLeVTkACgkQAVBC80lX
0GyMZQf+Ja6K5Vm5pK9TnpyoyHFDDlM/l9hJ+0Tix7oiv5QBb/rVJXfYIwt8tKjf
K8Y26eBXjwSwo/WieOXjBZ1cTK82+nY6bPh54R5S0IrVFPHMw2q1+jKfbBK8v/Lf
9GdV32aTQWzrDYMLccRlmg6KNvhd138209j0gja1yyOE3PzTusBnx3zKSJGbnytE
WE+MFyHtgbmED6dhPFYkr2+qMK61nkQneTSwjPVos6+EvbPC60YsQSV/5axo+jTM
VXChn0XdM0WDbt0Lq7DPVsxYW9QQS+dI1b4e/GW0ed96dO7XsOaKJ1GEV2Lc3bHz
fmWaoERE6HyLfCdV/O/QMeOf3CyGOA==
=vTiM
-----END PGP SIGNATURE-----

--Sig_/80xpxgTL.uSaVsjqxcOGn+Y--
