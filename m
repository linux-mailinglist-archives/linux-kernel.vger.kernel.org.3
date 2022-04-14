Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D88500477
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbiDNC4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiDNC4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:56:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6DC2C6;
        Wed, 13 Apr 2022 19:54:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kf3vc1VfYz4x7Y;
        Thu, 14 Apr 2022 12:54:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649904861;
        bh=fDOuMrroHlBGTn7iGqRePYiPTvzDieExQ2YVV6a/kDE=;
        h=Date:From:To:Cc:Subject:From;
        b=VaX7MahQsZeO/DFFbnHbgfU/6w581lDRdSTL/EQWyzXVZ8QrmO94KF/oiIaqiOPOi
         XMoy/3xtqKCV4NXpMtDQPwIwCGjElFtd1jA7Izg/lHNnaE0JonkVY4Idn7D7xpfvJu
         +WMow5UhsokdRMi5r/YJvnfz5H/kyECaN84mEuv7pYfYJNCR951IScLSuRyCI4K0B3
         5S9PJ/EAwP2DsnGoXunY8CL/VBkAC77KTCYet+JilxgOF3WsT6wUFqLd+poi6trg8N
         d+9LTS4EUKoIzIn2bMChbeGqTmZbyUX7vlLkFaHTgEtvCGNl77rbArjr6RkYJ4HIwr
         XqgPtjfxiN97Q==
Date:   Thu, 14 Apr 2022 12:54:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the efi tree with the tip tree
Message-ID: <20220414125419.1c2e346d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jR1S7OkN960Cn7djWsJSW5U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jR1S7OkN960Cn7djWsJSW5U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the efi tree got conflicts in:

  drivers/virt/Kconfig
  drivers/virt/Makefile

between commit:

  fce96cf04430 ("virt: Add SEV-SNP guest driver")

from the tip tree and commit:

  cbabf03c3ef3 ("virt: Add efi_secret module to expose confidential computi=
ng secrets")

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

diff --cc drivers/virt/Kconfig
index 7d3273cfab27,c877da072d4d..000000000000
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@@ -48,6 -48,6 +48,8 @@@ source "drivers/virt/nitro_enclaves/Kco
 =20
  source "drivers/virt/acrn/Kconfig"
 =20
 +source "drivers/virt/coco/sevguest/Kconfig"
 +
+ source "drivers/virt/coco/efi_secret/Kconfig"
+=20
  endif
diff --cc drivers/virt/Makefile
index 7b87a7ba1972,067b5427f40f..000000000000
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@@ -9,4 -9,4 +9,5 @@@ obj-y				+=3D vboxguest
 =20
  obj-$(CONFIG_NITRO_ENCLAVES)	+=3D nitro_enclaves/
  obj-$(CONFIG_ACRN_HSM)		+=3D acrn/
 +obj-$(CONFIG_SEV_GUEST)		+=3D coco/sevguest/
+ obj-$(CONFIG_EFI_SECRET)	+=3D coco/efi_secret/

--Sig_/jR1S7OkN960Cn7djWsJSW5U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJXjNsACgkQAVBC80lX
0GxCRAf8CDeqd0Pq8oWyPwkCa8MTyGXN/q2hLZxOlMDqlaCGeVkjW2odEOlAj2tc
eBtYvjlnBx/bBqgVmko1rMyLJKacEcCYE72H6m3tdYJRBvClc/AaFTjDChY3WqEB
rYROqlFrDAwDVm96Ujj9437O+ZJBwmPLsq3tVsEsTAhTL/4uIoaR2gfA4rQrNPr6
QvCKSfCsiauu4oahbFeCshDai8qi0vSiptWcWikibtwxMjpfdP+6iTL9edmq57pv
D7YT1o5DjMa4M6cVHPVAlu//tO71ct6J+jBh7TXNhJTvQEUuGxHiJTP25F3OX8S9
kf3z3oI0z4LwQ8/VzdRpug+GFy0hlQ==
=TvwK
-----END PGP SIGNATURE-----

--Sig_/jR1S7OkN960Cn7djWsJSW5U--
