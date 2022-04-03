Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D364F0CB7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376521AbiDCWLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiDCWLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:11:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9BF205E7;
        Sun,  3 Apr 2022 15:09:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWp3x3G0Nz4xNp;
        Mon,  4 Apr 2022 08:09:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649023789;
        bh=bbvggyT8cLz9htyGPggIouyeA9Xia4xl6DPGtbQPyCE=;
        h=Date:From:To:Cc:Subject:From;
        b=XFPjAMovu+ssAKRt+5fDqZz/38AENoCNorXuVQ09K7pb+VWjJifeulPhnyk4+4WVl
         XJUmxX3VCUwUDpw6/sXAb1KbUXl9nvYJYLETXxLinzXOgT4LsgUqMFe/ezpBXrNSke
         f46QGVSkiYt9hlWLa8bDfYV4PkiCQ3/f5WGWN3azhvoyD4TZUqHbkeVqoPGioDidYE
         9LhjfvgAvlRYy4XbANuhQf0jyoWaK5lx0kpGfJImLl2T5XwT1+oAn6FbAwqH5QWyuZ
         O5ZQcoVmxzZ/KrnWqBEt8pO8z2G+ayVor4uT7Z6AwnPwvE8EkB/x1RSbxAhDtmNiIs
         lmQ9ntFAtqj4g==
Date:   Mon, 4 Apr 2022 08:09:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kbuild tree with Linus' tree
Message-ID: <20220404080948.0590992a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hJ.h65H//uz7K/bHpxvjl8y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hJ.h65H//uz7K/bHpxvjl8y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kbuild tree got a conflict in:

  scripts/kconfig/confdata.c

between commit:

  b6ad541697ea ("kconfig: remove stale comment about removed kconfig_print_=
symbol()")

from Linus' tree and commit:

  55de8686df7e ("kconfig: change .config format to use =3Dn instead of "is =
not set"")

from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I think that maybe the kbuild tree needs to be fixed up to match what
has actually been merged by Linus.
--=20
Cheers,
Stephen Rothwell

diff --cc scripts/kconfig/confdata.c
index c4340c90e172,0c711a1bdc96..000000000000
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@@ -658,9 -658,14 +658,7 @@@ static char *escape_string_value(const=20
  	return out;
  }
 =20
- enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };
-=20
- static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n ou=
tput_n,
 -/*
 - * Kconfig configuration printer
 - *
 - * This printer is used when generating the resulting configuration after
 - * kconfig invocation and `defconfig' files. Unset symbol might be omitte=
d by
 - * passing a non-NULL argument to the printer.
 - */
+ static void __print_symbol(FILE *fp, struct symbol *sym, bool output_n,
  			   bool escape_string)
  {
  	const char *val;

--Sig_/hJ.h65H//uz7K/bHpxvjl8y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKGywACgkQAVBC80lX
0Gx1Nwf+N/RXHRugoZXCXelMmEE0GfZKGCh9gAdVqp4rO8fS5if8AxpGgCncpm3V
aq+i9G925kCIOtY8ZScGDvFU+bYsBLwFGlFpAT2wIdpZiJr/PZRHdwhLKMWwNlYu
MDIWK4MveOcpnuUlJVQaTBu2m2Ja6RLB9c0n7na+lJce6btDpTqARi9wd7F4z7Qj
aN/qce3tSt0IuJs2k4wVee4LK31fJHsXmBTwvYWWUsSGMdcS4Itfz+mfO+vJd1xm
6t77zX39X70/fhzkyJQYrgmtwtkdZQtlehXMatKQ3+CUyNNDVQ1cuuo3D3M6dJID
XvQWlFvrcJC1yV+rx8dpa4nuTKCJ7Q==
=2J6q
-----END PGP SIGNATURE-----

--Sig_/hJ.h65H//uz7K/bHpxvjl8y--
