Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6290E4B944F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbiBPXET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:04:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiBPXES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:04:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920CA2A2281;
        Wed, 16 Feb 2022 15:04:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzYRc1j6Rz4xmx;
        Thu, 17 Feb 2022 10:03:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645052636;
        bh=8RGPcLW/e4NTCH+ITSAm3ZElmrOC11P4FBUZ5izeeIM=;
        h=Date:From:To:Cc:Subject:From;
        b=jSycGiFZmDRuQZdJO9o9GXgfWVXW+XMCeAVcjY0m4Sl1kIxXe8vwkyUxvRGbx0M1N
         EMqcbshOnEXgj4UYF6jNIZW74xSWveFY4L11bVjKR5ELMI3kkl0IxhYXKSRLKmtq5V
         PdFaFP69y83E0aiRuvY0JKIfbuVl1OZYOCJYzd6eRskVnhr9oKvKzh82JUYQEJ1+I4
         Fg4XMLL15x0q7OER5XIPZ/nbg2kJ3Huwlgbb7GGhhfLeEHJRIvHJU501T0hL+XVpCr
         y5IgUNg9uTdN62yH7PAqN6jbejEPtimAC0lli/G7zlQHNG4P6tDQmnY9AIQw/cdXh/
         WernZY16RRc2g==
Date:   Thu, 17 Feb 2022 10:03:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the arm64 tree
Message-ID: <20220217100354.73b552d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yfzRquWjE+9QdguLEDZ0ubu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yfzRquWjE+9QdguLEDZ0ubu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  arch/x86/um/Kconfig

between commit:

  b62a8486de3a ("elfcore: Replace CONFIG_{IA64, UML} checks with a new opti=
on")

from the arm64 tree and commit:

  6692531df62d ("uml/x86: use x86 load_unaligned_zeropad()")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/um/Kconfig
index ead7e5b3a975,4eb47d3ba625..000000000000
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@@ -8,7 -8,7 +8,8 @@@ endmen
 =20
  config UML_X86
  	def_bool y
 +	select ARCH_BINFMT_ELF_EXTRA_PHDRS if X86_32
+ 	select DCACHE_WORD_ACCESS
 =20
  config 64BIT
  	bool "64-bit kernel" if "$(SUBARCH)" =3D "x86"

--Sig_/yfzRquWjE+9QdguLEDZ0ubu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmINgtoACgkQAVBC80lX
0GzDfwf/XxOzhvPhlAuNUhKs/pYxNsWoDGzHEVMTRCI7Q4TTZBBz0HXSyS2SmrhZ
c9qXJez76QaOECYpjAl0cQ3glx8WS1s0ZH9zypTSC656f5luqj6RIDDIzyK1vG21
Ipztc4jKRocR6KEwVpEHSAF2TIqo5ZaHm0qjqcKD3bKsy0t8o45xOqXlCqbwenH5
E2m5hb+LCXU/BiEPCLgNuZH45HM3A8QCdRR9QJMfOPbLYlZ/4vxvYaka+HMgbyQH
z11uRt0TIYvxPhsupW3aHNIawQ7vaQonyheqovk3gyT1p4Qr5vxt5VayYg1tEHqC
LsWRjouFmjsV4eA/kt8UnLdSfqXniw==
=eyKq
-----END PGP SIGNATURE-----

--Sig_/yfzRquWjE+9QdguLEDZ0ubu--
