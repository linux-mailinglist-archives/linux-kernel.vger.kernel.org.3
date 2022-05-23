Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807A65308FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiEWFsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiEWFsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:48:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED8524F37;
        Sun, 22 May 2022 22:48:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L65vz57zfz4xYY;
        Mon, 23 May 2022 15:47:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653284880;
        bh=2vbo8dVhOWsS3T/T45k7TXjX4PO3epNeie4gRP2qiWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQIUg7SdDCPN09lVSVL82p7NyxA0OQaQPm5Fm/QDCfblXjoW4L3zhs9xMxFZeYwiq
         Kko4kGOFwLCn+61kC64ZNxjOuXnnT+ZP9WFElyHZyiqSvjrJgDCDf5DlK233p/gb7Y
         JCJAspwhfAG5j/or8+l8TisvAwXnHf5xJMHK4GcnlLQQ6RWKEZZSsVlcF+rZ6sPDqV
         IDhH41SFm6liaovTXQyitYWHgWFi7OfOdNIcvYC2nuo0+FO7ZnbZWJCVOyCk/r5hjG
         9NV/qZ7lKdTMPU7u7doN9jX04vFpnTnksfETKCyoX3Wmbg8Tt1x7eRKMpIhteBarKw
         NZmumd989cmlw==
Date:   Mon, 23 May 2022 15:47:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220523154758.11668628@canb.auug.org.au>
In-Reply-To: <20220523142431.10ff2f77@canb.auug.org.au>
References: <20220523142431.10ff2f77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r=uakva=tlJuhr8mplG/2nv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r=uakva=tlJuhr8mplG/2nv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 May 2022 14:24:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   scripts/Makefile.build
>=20
> between commit:
>=20
>   0212301af7bb ("kbuild: do not create *.prelink.o for Clang LTO or IBT")
>=20
> from the kbuild tree and commit:
>=20
>   753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")
>=20
> from the tip tree.
>=20
> I am not sure if I fixed this up correctly, please check the final result
> when linux-next is released.
>=20
> I fixed it up (I used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

That produced may warnings :-(   so I tried the below resolution instead.

--=20
Cheers,
Stephen Rothwell

70023a983b831421d2bac71f46b94bce024a147b
diff --cc scripts/Makefile.build
index 48712bfc8740,f89d3fcff39f..cbe9b45e7b7d
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@@ -226,18 -244,23 +230,19 @@@ objtool_args =3D							=09
  cmd_objtool =3D $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
  cmd_gen_objtooldep =3D $(if $(objtool-enabled), { echo ; echo '$@: $$(wil=
dcard $(objtool))' ; } >> $(dot-target).cmd)
 =20
- endif # CONFIG_STACK_VALIDATION
+ endif # CONFIG_OBJTOOL
 =20
 -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 -
 -# Skip objtool for LLVM bitcode
 -$(obj)/%.o: objtool-enabled :=3D
 -
 -else
 =20
  # 'OBJECT_FILES_NON_STANDARD :=3D y': skip objtool checking for a directo=
ry
  # 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'y': skip objtool checking for a =
file
  # 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'n': override directory skip for =
a file
 =20
 -$(obj)/%.o: objtool-enabled =3D $(if $(filter-out y%, \
 -	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)=
n),y)
 +is-standard-object =3D $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_=
$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
 =20
 -endif
 +delay-objtool :=3D $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
 +
 +$(obj)/%.o: objtool-enabled =3D $(if $(is-standard-object),$(if $(delay-o=
bjtool),$(is-single-obj-m),y))
++$(obj)/%.o: linked-object :=3D y
 =20
  ifdef CONFIG_TRIM_UNUSED_KSYMS
  cmd_gen_ksymdeps =3D \
@@@ -404,24 -464,32 +409,25 @@@ $(obj)/modules.order: $(obj-m) FORC
  #
  # Rule to compile a set of .o files into one .a file (with symbol table)
  #
 -quiet_cmd_ar_lib =3D AR      $@
 -      cmd_ar_lib =3D $(cmd_update_lto_symversions); $(cmd_ar)
 =20
  $(obj)/lib.a: $(lib-y) FORCE
 -	$(call if_changed,ar_lib)
 -
 -# NOTE:
 -# Do not replace $(filter %.o,^) with $(real-prereqs). When a single obje=
ct
 -# module is turned into a multi object module, $^ will contain header file
 -# dependencies recorded in the .*.cmd file.
 -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 -quiet_cmd_link_multi-m =3D AR [M]  $@
 -cmd_link_multi-m =3D						\
 -	$(cmd_update_lto_symversions);				\
 -	rm -f $@; 						\
 -	$(AR) cDPrsT $@ $(filter %.o,$^)
 -else
 -quiet_cmd_link_multi-m =3D LD [M]  $@
 -      cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
 -endif
 +	$(call if_changed,ar)
 +
 +quiet_cmd_ld_multi_m =3D LD [M]  $@
 +      cmd_ld_multi_m =3D $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod=
,$@) $(cmd_objtool)
 +
 +define rule_ld_multi_m
 +	$(call cmd_and_savecmd,ld_multi_m)
 +	$(call cmd,gen_objtooldep)
 +endef
 =20
 -$(multi-obj-m): FORCE
 -	$(call if_changed,link_multi-m)
 +$(multi-obj-m): objtool-enabled :=3D $(delay-objtool)
 +$(multi-obj-m): part-of-module :=3D y
++$(multi-obj-m): linked-object :=3D y
 +$(multi-obj-m): %.o: %.mod FORCE
 +	$(call if_changed_rule,ld_multi_m)
  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 =20
 -targets +=3D $(multi-obj-m)
  targets :=3D $(filter-out $(PHONY), $(targets))
 =20
  # Add intermediate targets:

--Sig_/r=uakva=tlJuhr8mplG/2nv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLIA4ACgkQAVBC80lX
0GzgFAf/YsLs4lF4Wy0WQ0L4S1SiJAJ2ZwZkORz6oOL5r+9Dme7ov8fGamHFFD/e
O5VCjluO06DURxrQKHRtGkinP+NmjyEIX/1NFlVbR924AhEOZGocs302R+63Tfcy
cbEAjIKY8FVGnZ/kcUr7pC4PqQqW/LgHW/wdKI1RljDlGjWISt9Tj7enhjpQMQnc
fngP5s0VT3M1CPZwVQt5DeSyer0+mrK/E39orSepVxcgKwiy/eANJMQF+0NgPajN
tu9B2+yULakxnV0tRTCYKnloMXz0KdGBYwVLdyaU8RCfYDjQSDtZQGy81TChhSB/
oiu4Rf0uawimFK+bgJRSui6Mc6jYJw==
=dfAm
-----END PGP SIGNATURE-----

--Sig_/r=uakva=tlJuhr8mplG/2nv--
