Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B747CC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbhLVEwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbhLVEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:52:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5352C061574;
        Tue, 21 Dec 2021 20:51:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJgsT6PL6z4xbd;
        Wed, 22 Dec 2021 15:51:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640148718;
        bh=5OS+e7d2thNAeS/b3kb+CJImYY495FBhjQj92KeO0uM=;
        h=Date:From:To:Cc:Subject:From;
        b=kffseq6rEjxpqe7Kkjm9NxOj0Coa7QYiGkJ54Fv58g6DHdLR2kPtRdROEsaLEQmC/
         Sng/3f/LRFvJ/Bg2RjiSiD7mQTJkGDMjvrs4BKBQiQkRWS3h0e8Gi3qwOw12W+g4y/
         OGL6iqaXeeWagCr6Txr2Z47C3HASR7y9519Fkf0wga7KpxBmQaTMFzgCPN7QMe3WKD
         zHr8Sb70zalf2q75j56ih4KXJFJNpcSKPE5UhosMiuKXkdw1Tdfd6eh8MMfVNUgN6r
         YdAAHqYpDo3xLrgyljroHji9DkDvm1V3ru0E0zm8h2IlKNfEdd2A9E/tOkQZd4q7ID
         m12SbtPwQjyEw==
Date:   Wed, 22 Dec 2021 15:51:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the
 devicetree-fixes tree
Message-ID: <20211222155156.22a172c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1S1LyIj3ECemRvGN5_=7b53";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1S1LyIj3ECemRvGN5_=7b53
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  include/linux/of_fdt.h

between commit:

  7ca964c3978d ("efi: apply memblock cap after memblock_add()")

from the devicetree-fixes tree and commits:

  60f20d84dc81 ("of/fdt: Rework early_init_dt_scan_chosen() to call directl=
y")
  1f012283e936 ("of/fdt: Rework early_init_dt_scan_memory() to call directl=
y")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/of_fdt.h
index ad09beb6d13c,914739f3c192..000000000000
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@@ -58,11 -58,8 +58,9 @@@ extern int of_flat_dt_is_compatible(uns
  extern unsigned long of_get_flat_dt_root(void);
  extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 =20
- extern int early_init_dt_scan_chosen(unsigned long node, const char *unam=
e,
- 				     int depth, void *data);
- extern int early_init_dt_scan_memory(unsigned long node, const char *unam=
e,
- 				     int depth, void *data);
+ extern int early_init_dt_scan_chosen(char *cmdline);
+ extern int early_init_dt_scan_memory(void);
 +extern void early_init_dt_check_for_usable_mem_range(void);
  extern int early_init_dt_scan_chosen_stdout(void);
  extern void early_init_fdt_scan_reserved_mem(void);
  extern void early_init_fdt_reserve_self(void);

--Sig_/1S1LyIj3ECemRvGN5_=7b53
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHCruwACgkQAVBC80lX
0Gynggf/cvvk+oJRN/IsOKYoD9HpxOYI404PzNW6FAFT9okzIc2QuwADwZ7gu0fU
BOBGm/c4rCEvuC+LxM993dsOHeeUdbavjgoOz+D00LU7evVniVhhh2ET7KVwDO+t
Ht0ntdIgfNka3fTFl9xTRr5+H5kRfok669nQCo7bBoDf+u29E32L6eZq5+bXiNTz
bhoP01IYR/yfGXz3Hy9UQ7ZZvtGOiq4Jpjz0NrCwxo4ZM3JPCMJxfGNFZGVu4Xlq
/Uhd2E9UNx6rhWA7aRL8oaSBO4fZmi/Lz4A4TNMO2JAyRX7OSwsRLPvKfxglqGw4
TQx8BGu43DPYj5HYKxSkFQe/UJJIRw==
=w5QR
-----END PGP SIGNATURE-----

--Sig_/1S1LyIj3ECemRvGN5_=7b53--
