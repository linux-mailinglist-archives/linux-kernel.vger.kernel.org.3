Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3B4871DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbiAGEnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:43:12 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58451 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAGEnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:43:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVVvy0RpWz4xts;
        Fri,  7 Jan 2022 15:43:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641530590;
        bh=qPGhPR+Z+Z92noDv8k9SKWIIl+jHtp1XlEUwg7LNDTs=;
        h=Date:From:To:Cc:Subject:From;
        b=eIXXPvokUXnnraNUNNXhUX7dEjVOya6V+mOVF3EsUJbyjO1c3+PKSureViSHzS+FS
         MlAR/1E3JCuovO1yozW6eHd4MQlzGjIJSQw0gihbz5sRROhVR1KO8cBMA/Nq+MuE+X
         i7FnX5JtL4WGAQJn0LM4NPOh7ClFgSpqoSFuvbrOgGnlouzp4ChXe5PXbi1SyfbtIt
         d6z+/AFcC+AmVbq/PH8XfirAYLIddJv18cVd7r7c5uCA4X4kfe7DwLh0yDTy9SdK1a
         I3BdooU/RiDUs/wm2RAPqsMuQBTbFHAV8GxeAnFqCvY9efgFOucJd9V9LEpc52MhgA
         tRqdOlbrzeDmw==
Date:   Fri, 7 Jan 2022 15:43:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?B?bg==?= 
        <mic@linux.microsoft.com>
Subject: linux-next: manual merge of the tpmdd tree with the kbuild tree
Message-ID: <20220107154309.287d658a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.WxI_cplo/pHnJakss.Mclc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.WxI_cplo/pHnJakss.Mclc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tpmdd tree got a conflict in:

  certs/Makefile

between commits:

  33c1957574b6 ("kbuild: do not quote string values in include/config/auto.=
conf")
  41f431290557 ("certs: refactor file cleaning")

from the kbuild tree and commit:

  0fde37e9c004 ("certs: Check that builtin blacklist hashes are valid")

from the tpmdd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc certs/Makefile
index f7041c29a2e0,e38e10c46890..000000000000
--- a/certs/Makefile
+++ b/certs/Makefile
@@@ -6,21 -6,46 +6,36 @@@
  obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) +=3D system_keyring.o system_certifi=
cates.o common.o
  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist.o common.o
  obj-$(CONFIG_SYSTEM_REVOCATION_LIST) +=3D revocation_certificates.o
 -ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),"")
 +ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
+=20
+ quiet_cmd_check_blacklist_hashes =3D CHECK   $(patsubst "%",%,$(2))
+       cmd_check_blacklist_hashes =3D $(AWK) -f $(srctree)/scripts/check-b=
lacklist-hashes.awk $(2); touch $@
+=20
+ $(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
+=20
+ $(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
+=20
+ CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
+=20
 -targets +=3D blacklist_hashes_checked
+ $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$=
(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FO=
RCE
+ 	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SR=
CPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
+=20
  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
+=20
  else
  obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.o
  endif
++targets +=3D blacklist_hashes_checked
 =20
 -ifeq ($(CONFIG_SYSTEM_TRUSTED_KEYRING),y)
 -
 -$(eval $(call config_filename,SYSTEM_TRUSTED_KEYS))
 +quiet_cmd_extract_certs  =3D CERT    $@
 +      cmd_extract_certs  =3D $(obj)/extract-cert $(2) $@
 =20
 -# GCC doesn't include .incbin files in -MD generated dependencies (PR#668=
71)
  $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 =20
 -# Cope with signing_key.x509 existing in $(srctree) not $(objtree)
 -AFLAGS_system_certificates.o :=3D -I$(srctree)
 -
 -quiet_cmd_extract_certs  =3D EXTRACT_CERTS   $(patsubst "%",%,$(2))
 -      cmd_extract_certs  =3D scripts/extract-cert $(2) $@
 +$(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extrac=
t-cert FORCE
 +	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""=
))
 =20
  targets +=3D x509_certificate_list
 -$(obj)/x509_certificate_list: scripts/extract-cert $(SYSTEM_TRUSTED_KEYS_=
SRCPREFIX)$(SYSTEM_TRUSTED_KEYS_FILENAME) FORCE
 -	$(call if_changed,extract_certs,$(SYSTEM_TRUSTED_KEYS_SRCPREFIX)$(CONFIG=
_SYSTEM_TRUSTED_KEYS))
 -endif # CONFIG_SYSTEM_TRUSTED_KEYRING
 -
 -clean-files :=3D x509_certificate_list .x509.list x509_revocation_list bl=
acklist_hashes_checked
 =20
  ifeq ($(CONFIG_MODULE_SIG),y)
  	SIGN_KEY =3D y

--Sig_/.WxI_cplo/pHnJakss.Mclc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXxN0ACgkQAVBC80lX
0GzaaAf/cxADqh2us9UXNDU264P1ZdwDGy4iOWO/Gphz2V1Qxov3VvQftG67eMJg
NQ0E0WGBh7JL8X8WV3VootdAkjVJ9vZcAJ/nWM649gNqHtDq/Aunc2mzd1FOMooE
tK/Np5K9dqK+t9Xnq1mcTqs9AxDvhtYFusKjDB6SO35BNpyGJo7vFyiINR3shHW6
8EQE4rRSG8NYnum/ejzpr9ZsvKtJ96KawktzLHoAaNbMmVHqZKXcsZMW0gL3blUG
B9dBG08n/v0GjyIQ47W+dj5iS1XpvTL0iMZMbDQ0yEIq+5H3/IgXHCaaTn83xDGu
+kx0qdIkgPfDxyftSDHNR4huuiGvOQ==
=pzpK
-----END PGP SIGNATURE-----

--Sig_/.WxI_cplo/pHnJakss.Mclc--
