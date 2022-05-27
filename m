Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AD55356FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbiE0AIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiE0AIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:08:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812AAB7F6;
        Thu, 26 May 2022 17:08:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8QBj4THNz4xXF;
        Fri, 27 May 2022 10:08:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653610126;
        bh=yXc1Vj6Ng/ZkgZVPKtn4790haHxx3QlUg5uPQgSyWig=;
        h=Date:From:To:Cc:Subject:From;
        b=hae/8BwCQdWy1rr+q2J8u5lxnlZEaiX4rnKvcvtp5J+Jjaw59uUgMseKXJ5NJt5Zl
         RfTHFBaTDIHTfhJDCIclxeXlCey2ofsmGegNGm0jeb7idxOOpWtPoY8mt2DSBnna/+
         qGy4AQQYDxJMmBQ0U4VDdj1Q4G1nFdV7ZfCCocUuI5kQB7OfAXo2LuHBzKOzsDwys1
         hZo+fIPD3rQzRVSsLWmTA6+YUwaiI8LHJZOQEmFAG+QMULfC4+/Gqfw/k0LXEy0oSg
         wJMyfS/tlxS2SI099ZWrK5e1oGrJxdCr0AkkInhnqonE5mhwiPC1+cMJorw2ImonCl
         naYYQybXYAaAw==
Date:   Fri, 27 May 2022 10:08:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20220527100844.2f8ded56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LeBg_RW4Rk8ePdqykqaNwe5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LeBg_RW4Rk8ePdqykqaNwe5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  scripts/Makefile.build

between commit:

  753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")

from Linus' tree and commits:

  3eec672cbc9b ("kbuild: do not create *.prelink.o for Clang LTO or IBT")
  7414d89fd7cd ("kbuild: make *.mod rule robust against too long argument e=
rror")

from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc scripts/Makefile.build
index 06400504150b,1754adba7010..000000000000
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@@ -226,23 -226,18 +230,19 @@@ objtool_args =3D							=09
  cmd_objtool =3D $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
  cmd_gen_objtooldep =3D $(if $(objtool-enabled), { echo ; echo '$@: $$(wil=
dcard $(objtool))' ; } >> $(dot-target).cmd)
 =20
 -endif # CONFIG_STACK_VALIDATION
 +endif # CONFIG_OBJTOOL
 =20
- ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
-=20
- # Skip objtool for LLVM bitcode
- $(obj)/%.o: objtool-enabled :=3D
-=20
- else
 =20
  # 'OBJECT_FILES_NON_STANDARD :=3D y': skip objtool checking for a directo=
ry
  # 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'y': skip objtool checking for a =
file
  # 'OBJECT_FILES_NON_STANDARD_foo.o :=3D 'n': override directory skip for =
a file
 =20
- $(obj)/%.o: objtool-enabled =3D $(if $(filter-out y%, \
- 	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)=
n),y)
+ is-standard-object =3D $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_=
$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
 =20
- endif
+ delay-objtool :=3D $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
+=20
+ $(obj)/%.o: objtool-enabled =3D $(if $(is-standard-object),$(if $(delay-o=
bjtool),$(is-single-obj-m),y))
++$(obj)/%.o: linked-object :=3D y
 =20
  ifdef CONFIG_TRIM_UNUSED_KSYMS
  cmd_gen_ksymdeps =3D \
@@@ -421,18 -408,18 +413,19 @@@ $(obj)/modules.order: $(obj-m) FORC
  $(obj)/lib.a: $(lib-y) FORCE
  	$(call if_changed,ar)
 =20
- ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
- quiet_cmd_link_multi-m =3D AR [M]  $@
- cmd_link_multi-m =3D						\
- 	rm -f $@; 						\
- 	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
- else
- quiet_cmd_link_multi-m =3D LD [M]  $@
-       cmd_link_multi-m =3D $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.m=
od,$@)
- endif
+ quiet_cmd_ld_multi_m =3D LD [M]  $@
+       cmd_ld_multi_m =3D $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod=
,$@) $(cmd_objtool)
+=20
+ define rule_ld_multi_m
+ 	$(call cmd_and_savecmd,ld_multi_m)
+ 	$(call cmd,gen_objtooldep)
+ endef
 =20
+ $(multi-obj-m): objtool-enabled :=3D $(delay-objtool)
+ $(multi-obj-m): part-of-module :=3D y
++$(multi-obj-m): linked-object :=3D y
  $(multi-obj-m): %.o: %.mod FORCE
- 	$(call if_changed,link_multi-m)
+ 	$(call if_changed_rule,ld_multi_m)
  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 =20
  targets :=3D $(filter-out $(PHONY), $(targets))

--Sig_/LeBg_RW4Rk8ePdqykqaNwe5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKQFowACgkQAVBC80lX
0GxkdQf9Hd27VcbmwumdyDRaXeXfZKj5YTEbVD3KgyBDFdCokE6MxuCVjtetXWHp
Nzjs4g840rhNyrZu44QalK5uGliNnuGwhViYMfDZNyGf6wlRqUv6KmMq5c0fbBGM
bL605lnA7um9yjaCcXhfd8fU823OywpUdgfu5o6OT2yIMOmg9KihlUrMYrhz+RJE
VjYIeK7X8Ga1ZTo96E2tWmOm9nVSfdBCSqGVOCEOx0Uk1SomCctYWzZrfN1nYPXW
iWLJrnnJjxoodSAkNXXqAFPuIddv70oqE62TRgi2dRLq8LS1E9hzXQABgbngUGNR
Uedr+i3OxAOJheHLj+FGW/KraBvvNA==
=oG2M
-----END PGP SIGNATURE-----

--Sig_/LeBg_RW4Rk8ePdqykqaNwe5--
