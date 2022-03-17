Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D24DBF07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiCQGNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiCQGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:13:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB922B6DD;
        Wed, 16 Mar 2022 23:03:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KJxQB2vQXz4xgw;
        Thu, 17 Mar 2022 17:02:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647496982;
        bh=helC+++jzqQi70QZ5QorRw4r/De1RHWf4TMymlE5AK8=;
        h=Date:From:To:Cc:Subject:From;
        b=A7cNfq6P5+VB8R1Pjr8lSsYuZ3Kiyq7PtPQJ9xAphqKnX1Cy892yXGGN9bYvNz+f4
         lkK1XGMzP0Vaf4QI9S166s9A0oBcvOb7CbECEorsp5eBYE8+2iKnyAbUuefrsWE6KX
         0h3mt/sYmNODtfzIMAq8rN6CVMVRWBzfUYFF21Wy9r5s/2OtxicLA0YGwl8c1fzbMj
         SPLWAYTR8aIvPE1oVpeZC+PHUbDj6bTpQHm/sHoy8BREGnqSNfiKYUMX9kPLgk5jNc
         5Zyon3b/vbaTDzruZpq0BaznlH8fDqUGhmb8ZnJkiLuNRCmVFF/kw3Qqsuf7NeSFKX
         rhloTVUCkCL2g==
Date:   Thu, 17 Mar 2022 17:02:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20220317170254.0f6e3bac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BPgSHN+3IZml_gI+tb=ng6p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BPgSHN+3IZml_gI+tb=ng6p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Makefile

between commit:

  f67695c9962e ("kbuild: Add environment variables for userprogs flags")

from the kbuild tree and commit:

  e2e7cf27b587 ("Kbuild: add Rust support")

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
index d2269ea42eac,67008a2d964c..000000000000
--- a/Makefile
+++ b/Makefile
@@@ -430,15 -437,32 +437,34 @@@ els
  HOSTCC	=3D gcc
  HOSTCXX	=3D g++
  endif
+ HOSTRUSTC =3D rustc
 =20
 -export KBUILD_USERCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototy=
pes \
 -			      -O2 -fomit-frame-pointer -std=3Dgnu89
 -export KBUILD_USERLDFLAGS :=3D
 +KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototypes=
 \
 +			 -O2 -fomit-frame-pointer -std=3Dgnu11 \
 +			 -Wdeclaration-after-statement
 +KBUILD_USERCFLAGS  :=3D $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
 +KBUILD_USERLDFLAGS :=3D $(USERLDFLAGS)
 =20
+ # These flags apply to all Rust code in the tree, including the kernel and
+ # host programs.
+ export rust_common_flags :=3D --edition=3D2021 \
+ 			    -Zbinary_dep_depinfo=3Dy \
+ 			    -Dunsafe_op_in_unsafe_fn -Drust_2018_idioms \
+ 			    -Dunreachable_pub -Dnon_ascii_idents \
+ 			    -Wmissing_docs \
+ 			    -Drustdoc::missing_crate_level_docs \
+ 			    -Dclippy::correctness -Dclippy::style \
+ 			    -Dclippy::suspicious -Dclippy::complexity \
+ 			    -Dclippy::perf \
+ 			    -Dclippy::let_unit_value -Dclippy::mut_mut \
+ 			    -Dclippy::needless_bitwise_bool \
+ 			    -Dclippy::needless_continue \
+ 			    -Wclippy::dbg_macro
+=20
 -KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCF=
LAGS)
 +KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HO=
STCFLAGS)
  KBUILD_HOSTCXXFLAGS :=3D -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
+ KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
+ 			-Zallow-features=3D $(HOSTRUSTFLAGS)
  KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
  KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 =20
@@@ -517,12 -549,23 +551,23 @@@ KBUILD_CFLAGS   :=3D -Wall -Wundef -Werro
  		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
  		   -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int \
  		   -Werror=3Dreturn-type -Wno-format-security \
 -		   -std=3Dgnu89
 +		   -std=3Dgnu11
  KBUILD_CPPFLAGS :=3D -D__KERNEL__
+ KBUILD_RUSTFLAGS :=3D $(rust_common_flags) \
+ 		    --target=3D$(objtree)/rust/target.json \
+ 		    -Cpanic=3Dabort -Cembed-bitcode=3Dn -Clto=3Dn \
+ 		    -Cforce-unwind-tables=3Dn -Ccodegen-units=3D1 \
+ 		    -Csymbol-mangling-version=3Dv0 \
+ 		    -Crelocation-model=3Dstatic \
+ 		    -Zfunction-sections=3Dn \
+ 		    -Dclippy::float_arithmetic
+=20
  KBUILD_AFLAGS_KERNEL :=3D
  KBUILD_CFLAGS_KERNEL :=3D
+ KBUILD_RUSTFLAGS_KERNEL :=3D
  KBUILD_AFLAGS_MODULE  :=3D -DMODULE
  KBUILD_CFLAGS_MODULE  :=3D -DMODULE
+ KBUILD_RUSTFLAGS_MODULE :=3D --cfg MODULE
  KBUILD_LDFLAGS_MODULE :=3D
  KBUILD_LDFLAGS :=3D
  CLANG_FLAGS :=3D
@@@ -783,9 -858,12 +861,12 @@@ KBUILD_CFLAGS +=3D $(stackp-flags-y
  KBUILD_CFLAGS-$(CONFIG_WERROR) +=3D -Werror
  KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 =20
+ KBUILD_RUSTFLAGS-$(CONFIG_WERROR) +=3D -Dwarnings
+ KBUILD_RUSTFLAGS +=3D $(KBUILD_RUSTFLAGS-y)
+=20
  ifdef CONFIG_CC_IS_CLANG
  KBUILD_CPPFLAGS +=3D -Qunused-arguments
 -# The kernel builds with '-std=3Dgnu89' so use of GNU extensions is accep=
table.
 +# The kernel builds with '-std=3Dgnu11' so use of GNU extensions is accep=
table.
  KBUILD_CFLAGS +=3D -Wno-gnu
  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, a=
s the
  # source of a reference will be _MergedGlobals and not on of the whitelis=
ted names.

--Sig_/BPgSHN+3IZml_gI+tb=ng6p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIyzw4ACgkQAVBC80lX
0GyefQgAieBGh2nAAPUJilnI9hVlKmg3eYr2zwzsGaAD1zwPNVykP8Dr67b9PXx/
LTiYyJbgg2eHDA5OiyRLr0Hf0GkyrxIMsPl7Onw/50oL4kLDww8lgEnEtdg5uvla
CWnGURHzWgmb0x5iVNGN177a/ssoUuXkHSW7eH2Fu8VRhl31VKp88xWGLSVTenwI
+gpSdPXb1A03hoRY2sFhu46oyX5fgdkacxRngjSX9b5FFYzoWHiZmDpFUZu9IDAt
UHXoOlUdekQ+XLWv5B7K37kMATrFGdfDlCzVPIYpu5+mRqsyCZyaV1UP4yupO/9v
JXLWv24edim2b97zGPOdk8bQalko8Q==
=r15x
-----END PGP SIGNATURE-----

--Sig_/BPgSHN+3IZml_gI+tb=ng6p--
