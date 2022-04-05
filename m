Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B944F211A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiDEDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiDEDQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:16:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A377414020;
        Mon,  4 Apr 2022 20:14:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXXmj2Llfz4xXt;
        Tue,  5 Apr 2022 13:14:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649128456;
        bh=KBuiQEmterFTPPldXufIwLpX/nw+FNXbdbxT2HKR7Lo=;
        h=Date:From:To:Cc:Subject:From;
        b=KNiSWF0ygUeIiVASCvtp4LcqbShEwPZ7zpPbwcVvcVpFThMsA+jHIbNU/YMhIJy6m
         BWHfGkPIvtCaBbvRrMRpYIxwJe0RYcZHGKGo0SqltnPMmSSi5JoyZxTnjleJVOgSU0
         pml1qDDZoNRpv1rxXI2kGSK9tKfUsX2JV3P7LImbQFHVsaO9jWV6+jNFgOwgNsEXxR
         oV/b7VmDrdDXHEbkHoCoObXW5foba7s9OaumF1bvoAyUwpBu23pF/LhVVsHlq84BOe
         MdZsWEn5I1tIRHnzWlUvjnDzgTxU/8UGKwmIVYqge5Lh41fq8roYgd1JfG3X/H/MOC
         amiiuyRqjXGIg==
Date:   Tue, 5 Apr 2022 13:14:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Chun-Tse Shao <ctshao@google.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20220405131412.381b8a97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QaTbaPSIQKm2oYtkqwbmX_w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QaTbaPSIQKm2oYtkqwbmX_w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  703f8d8fad36 ("kbuild: Allow kernel installation packaging to override pk=
g-config")

from the kbuild tree and commit:

  241608fc4d70 ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Makefile
index d9336e783be3,40182fcc211a..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -436,7 -443,7 +443,8 @@@ els
  HOSTCC	=3D gcc
  HOSTCXX	=3D g++
  endif
 +HOSTPKG_CONFIG	=3D pkg-config
+ HOSTRUSTC =3D rustc
 =20
  KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototypes=
 \
  			 -O2 -fomit-frame-pointer -std=3Dgnu11 \
@@@ -534,7 -578,23 +579,23 @@@ KBUILD_LDFLAGS_MODULE :
  KBUILD_LDFLAGS :=3D
  CLANG_FLAGS :=3D
 =20
+ ifeq ($(KBUILD_CLIPPY),1)
+ 	RUSTC_OR_CLIPPY_QUIET :=3D CLIPPY
+ 	RUSTC_OR_CLIPPY =3D $(CLIPPY_DRIVER)
+ else
+ 	RUSTC_OR_CLIPPY_QUIET :=3D RUSTC
+ 	RUSTC_OR_CLIPPY =3D $(RUSTC)
+ endif
+=20
+ ifdef RUST_LIB_SRC
+ 	export RUST_LIB_SRC
+ endif
+=20
+ export RUSTC_BOOTSTRAP :=3D 1
+=20
 -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMP=
ILE LD CC
 +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMP=
ILE LD CC HOSTPKG_CONFIG
+ export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGE=
N CARGO
+ export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX =
YACC AWK INSTALLKERNEL
  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD

--Sig_/QaTbaPSIQKm2oYtkqwbmX_w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLtAQACgkQAVBC80lX
0GxY4Af/XU0Ei0CRfR4gxT1/1B1cr+7e926vN1zR76EKwV/v3Daou3MmwWgSJPhD
1T728yLzQZGVhJwtkx43GOxasc7kzY6d4Y3CeL+EGZ/d3zlPAsvnR0bK+tEJqKCB
P7cW24l7gU71WgzY0lMoiXLHSdAiAv+J21PP08017lxBXC9pYVfFxZ8iaCIY+okQ
IIKw3qNQdKP8/ify2gSKSbK939IPJhJUuyisYbxyaZ9BoeEKaH5FtC+BmCGsgt0A
QOAwNePh+XJ3d9aTdZJln1l+k+fAdo3seVB5tfA6u/MRSh7g/dtgByoenNrU2/Xa
iB7La8ZA7Xm0dPJ3Awne5jWlljThjQ==
=yVY2
-----END PGP SIGNATURE-----

--Sig_/QaTbaPSIQKm2oYtkqwbmX_w--
