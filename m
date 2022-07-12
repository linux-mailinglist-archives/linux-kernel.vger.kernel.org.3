Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F0571338
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGLHkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiGLHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:40:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92C9966D;
        Tue, 12 Jul 2022 00:40:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lht274lStz4xD9;
        Tue, 12 Jul 2022 17:39:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657611604;
        bh=EcH3yxBVzgEJkTCZgw9/TvBpp0hFRVgmuU1QfJUbTI8=;
        h=Date:From:To:Cc:Subject:From;
        b=mieC3keKz2nCrYWJJuY7qZxQ5bgN22bk3/BQneofhWi3evi4pI9SMK4pH41VIgwn/
         iATFYHfyQgumxcdWRor/r8e+gDzZwweEz0ZgaUd9hpjUB13b11JH3n3YgsVMQ56Obp
         2+p2ID3lqDSFpKAWY352FaHtiIpawl6ZJYEQqg38PhVbNJmvbAtN1hWV4Wi5HRULGE
         ndZ6P2uRp0M5D2SOCQTuVh+Q+kENa1XVt9tyPCdGsU1+LARdr1eCgX8m2L8QPXLOC/
         AR1bgi3KnObRhCsEKnOTUfgCSG5n0D5yvZXNXfkAVVLbieM+26NxU4UCzX03jcaM0u
         j7KiS2xHyRbDg==
Date:   Tue, 12 Jul 2022 17:39:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the block and kbuild
 trees
Message-ID: <20220712173956.540d3baa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7=sBkLwJ/gULgrXoA7AXD_V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7=sBkLwJ/gULgrXoA7AXD_V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  239b2db7c7ca ("io_uring: move to separate directory")

from the block tree, commit:

  b63a0c3e51a4 ("kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANC=
E_O3")

from the kbuild tree and commit:

  0ea4b9a1bece ("Kbuild: add Rust support")

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
index ffc170d3d0ce,ce17ec71f89b..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -436,7 -445,7 +445,8 @@@ els
  HOSTCC	=3D gcc
  HOSTCXX	=3D g++
  endif
 +HOSTPKG_CONFIG	=3D pkg-config
+ HOSTRUSTC =3D rustc
 =20
  KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototypes=
 \
  			 -O2 -fomit-frame-pointer -std=3Dgnu11 \
@@@ -534,7 -580,23 +581,23 @@@ KBUILD_LDFLAGS_MODULE :
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
@@@ -755,9 -818,27 +819,24 @@@ KBUILD_CFLAGS	+=3D $(call cc-disable-warn
 =20
  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
  KBUILD_CFLAGS +=3D -O2
+ KBUILD_RUSTFLAGS_OPT_LEVEL_MAP :=3D 2
 -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
 -KBUILD_CFLAGS +=3D -O3
 -KBUILD_RUSTFLAGS_OPT_LEVEL_MAP :=3D 3
  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
  KBUILD_CFLAGS +=3D -Os
- endif
+ KBUILD_RUSTFLAGS_OPT_LEVEL_MAP :=3D s
+ endif
+=20
+ # Always set `debug-assertions` and `overflow-checks` because their defau=
lt
+ # depends on `opt-level` and `debug-assertions`, respectively.
+ KBUILD_RUSTFLAGS +=3D -Cdebug-assertions=3D$(if $(CONFIG_RUST_DEBUG_ASSER=
TIONS),y,n)
+ KBUILD_RUSTFLAGS +=3D -Coverflow-checks=3D$(if $(CONFIG_RUST_OVERFLOW_CHE=
CKS),y,n)
+ KBUILD_RUSTFLAGS +=3D -Copt-level=3D$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_SIMILAR_AS_CHOSEN_FOR_C),$(KBUILD_RUSTFLAGS=
_OPT_LEVEL_MAP))$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_0),0)$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_1),1)$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_2),2)$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_3),3)$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_S),s)$\
+ 	$(if $(CONFIG_RUST_OPT_LEVEL_Z),z)
 =20
  # Tell gcc to never replace conditional load with a non-conditional one
  ifdef CONFIG_CC_IS_GCC
@@@ -786,9 -867,11 +865,12 @@@ stackp-flags-$(CONFIG_STACKPROTECTOR_ST
  KBUILD_CFLAGS +=3D $(stackp-flags-y)
 =20
  KBUILD_CFLAGS-$(CONFIG_WERROR) +=3D -Werror
 +KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) +=3D -Wno-array-bounds
  KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 =20
+ KBUILD_RUSTFLAGS-$(CONFIG_WERROR) +=3D -Dwarnings
+ KBUILD_RUSTFLAGS +=3D $(KBUILD_RUSTFLAGS-y)
+=20
  ifdef CONFIG_CC_IS_CLANG
  KBUILD_CPPFLAGS +=3D -Qunused-arguments
  # The kernel builds with '-std=3Dgnu11' so use of GNU extensions is accep=
table.
@@@ -804,11 -887,9 +886,12 @@@ endi
  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-but-set-variable)
  KBUILD_CFLAGS +=3D $(call cc-disable-warning, unused-const-variable)
 =20
 +# These result in bogus false positives
 +KBUILD_CFLAGS +=3D $(call cc-disable-warning, dangling-pointer)
 +
  ifdef CONFIG_FRAME_POINTER
  KBUILD_CFLAGS	+=3D -fno-omit-frame-pointer -fno-optimize-sibling-calls
+ KBUILD_RUSTFLAGS +=3D -Cforce-frame-pointers=3Dy
  else
  # Some targets (ARM with Thumb2, for example), can't be built with frame
  # pointers.  For those, we don't have FUNCTION_TRACER automatically
@@@ -1095,7 -1180,7 +1183,8 @@@ export MODULES_NSDEPS :=3D $(extmod_prefi
  ifeq ($(KBUILD_EXTMOD),)
  core-y			+=3D kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
  core-$(CONFIG_BLOCK)	+=3D block/
 +core-$(CONFIG_IO_URING)	+=3D io_uring/
+ core-$(CONFIG_RUST)	+=3D rust/
 =20
  vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \

--Sig_/7=sBkLwJ/gULgrXoA7AXD_V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLNJUwACgkQAVBC80lX
0GyCyAf/fppBTj0/vBshvRg18VgE9Akjn965TMgLrokt3sE1+3YkX27DLBJw0AwH
fOkBVnrY1+pl4MvS5WcxCIGDr+oH2xGv9j7wYHQWDuVJKfrJQfmckCDqKiEXeOsk
bTqDRneHRSMGIS6Kp8qWqmzBNKajiswgABZBsH3DnrncoKZ++D4BzofvKqVwKgkM
p5xm5EOyUMtzRLb7gWwzL2JrI9N7DA/QTuK74T2BmvRr2sGGPSBDmWjSHCRL5GGa
knQx/Lg4kJ91QvIWWWOPokBQ82hMVhIZ1oePaSmt/OFc8k7+GAFyUzSC+YONBNAK
75kQOi+KxmL56KeC07ZRJoVk8k8bUg==
=b0SA
-----END PGP SIGNATURE-----

--Sig_/7=sBkLwJ/gULgrXoA7AXD_V--
