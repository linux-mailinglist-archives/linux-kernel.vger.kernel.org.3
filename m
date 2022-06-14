Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9254A784
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351054AbiFNDV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiFNDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:21:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F012E6BB;
        Mon, 13 Jun 2022 20:21:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMYd31mvlz4xXD;
        Tue, 14 Jun 2022 13:21:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655176907;
        bh=U1fiJE5uYUJHX5vWt77/jkly7Dzg8cdL+qVh4DmoqX0=;
        h=Date:From:To:Cc:Subject:From;
        b=F2gmenyvpyPjtl5BYJDSPp07d113YEtls4S9SPpof1gStCmsPjurcvQ6FUXjCSTqS
         PyhXaxHpUDqup+A09wWHsir72mCp6C5046UM0A1dJcPaGg4TbWYSTPJV0cwwRFt0f6
         9l1WhjLunQPwP8DoQD45Rakvt6C7WLTeHIMEmMllQg6d7IAof9/bllbLmDk9OvHiHj
         /sz/JxNsCMqPdt4yUYvVEM+NjWaJrZcgZe6skdPbOKDd4t1Bxa6m9iAbUeNl5Ln1/4
         3PeojNXrp2Fzzmu10Q9ywL/rAD73hbfoddE2UeMkyLu1gQw+7lpAPWDqiOt61aZZQc
         NKxaAN1w1NnxQ==
Date:   Tue, 14 Jun 2022 13:21:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
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
Subject: linux-next: manual merge of the rust tree with the block tree
Message-ID: <20220614132141.2422079e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9VMqfqiVIsv_3E_iNTMUkHA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9VMqfqiVIsv_3E_iNTMUkHA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  197c5e8c9541 ("io_uring: move to separate directory")

from the block tree and commit:

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
index f4c1c37c0be6,ce17ec71f89b..000000000000
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
@@@ -788,9 -867,11 +868,12 @@@ stackp-flags-$(CONFIG_STACKPROTECTOR_ST
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
@@@ -806,11 -887,9 +889,12 @@@ endi
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
@@@ -1097,7 -1180,7 +1186,8 @@@ export MODULES_NSDEPS :=3D $(extmod_prefi
  ifeq ($(KBUILD_EXTMOD),)
  core-y			+=3D kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
  core-$(CONFIG_BLOCK)	+=3D block/
 +core-$(CONFIG_IO_URING)	+=3D io_uring/
+ core-$(CONFIG_RUST)	+=3D rust/
 =20
  vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \

--Sig_/9VMqfqiVIsv_3E_iNTMUkHA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKn/sYACgkQAVBC80lX
0Gz98Qf/Ywf1rQrouxv2rNNgNm6/vB8o4VLn2ej7EKW/giTJv6noydpoHXE58SJk
0wXzMNFmbe8/TBEUYdVlPQnW84vuciVfh+It3oj7L41+adyE5RSmwd8ioUb8QlS/
lSoES8u8RjVgMqxGr96YQWlvd6UUQL+4+5MJLU9SrLO8CRJIJpKkhACsqyeBHqcx
7UmghIx+bSSwlZ5gcU7A85NNmcnx7/1ihMtqtl7Xc91HWXdWjwVRmpikVSQmGHeK
RntZ6ro7F2v1tsLpv0hnYXqSfIzFxWRGH9cS9SzTqIDjq9+dqb8kHUK8jmsD5I3j
pXh1azc1vCPKCYjDKLBxLEgE+Iwekg==
=wjd7
-----END PGP SIGNATURE-----

--Sig_/9VMqfqiVIsv_3E_iNTMUkHA--
