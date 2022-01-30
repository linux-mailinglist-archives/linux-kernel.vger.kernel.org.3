Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA44A3AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356607AbiA3WeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:34:11 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50301 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiA3WeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:34:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jn5b429Dnz4xcq;
        Mon, 31 Jan 2022 09:34:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643582048;
        bh=R2a/s5cswYdl1kcfDiZ5RF7E0kCcUTG0iR5Pfd857Pw=;
        h=Date:From:To:Cc:Subject:From;
        b=FYfuPHfWnlSfigjLoqb0D0vYsen/+JlooNe1+TmLb0TLqYQclAAIjB0U2hYpbdzBf
         FUqtAgfVe0yl06y39JQl/qtTkPGn0uwyunyfZKSsVAG4xCggAq0WxV8xzuUrQgNMFd
         b7KcuKV55DlhqIxH4cQCg+yHoElB3PlsHnPhsUGG/TwSnSeo7GOXCJgwygyNJfaRzR
         VyHsOPvnlnVhtK6mNMkOBkKm2k8bKz3wEmssRF0JVfpwux80PoT6Q8l7e/yekAEPM8
         afRy0mCCUaLb6s4CIjy8GH8Gr5hvAo1+s/N/Ch8E0tg1OeP/DEs6FErP7szKqYYcdQ
         Y0jNDZ9KWqqdA==
Date:   Mon, 31 Jan 2022 09:34:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shijith Thotton <sthotton@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131093406.4200546c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IfyaL2G5XAz9GN4+6TdxnpR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IfyaL2G5XAz9GN4+6TdxnpR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/printk.h:555,
                 from include/asm-generic/bug.h:22,
                 from arch/x86/include/asm/bug.h:84,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/firmware.h:7,
                 from drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:5:
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c: In function 'otx2_cpt_=
print_uc_dbg_info':
include/linux/dynamic_debug.h:162:33: error: array subscript 4 is above arr=
ay bounds of 'u32[4]' {aka 'unsigned int[4]'} [-Werror=3Darray-bounds]
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |                                 ^
include/linux/dynamic_debug.h:134:17: note: in definition of macro '__dynam=
ic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                 ^~~~
include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_=
func_call'
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/printk.h:570:9: note: in expansion of macro 'dynamic_pr_debug'
  570 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1798:41: note: in expan=
sion of macro 'pr_debug'
 1798 |                                         pr_debug("Mask: %8.8x %8.8x=
 %8.8x %8.8x %8.8x",
      |                                         ^~~~~~~~
drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c:1756:13: note: while re=
ferencing 'mask'
 1756 |         u32 mask[4];
      |             ^~~~

Caused by commit

  d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups")

from Linus' tree interacting with commit

  a8712a32665f ("Makefile: Enable -Warray-bounds")

from the kspp tree.

I have applied the following patch for now.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 31 Jan 2022 09:28:12 +1100
Subject: [PATCH] fix up for otx2_cptpf_ucode.c out of bound reference

Fixes: d9d7749773e8 ("crypto: octeontx2 - add apis for custom engine groups=
")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/=
crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 4c8ebdf671ca..e990405c7f33 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1753,7 +1753,7 @@ void otx2_cpt_print_uc_dbg_info(struct otx2_cptpf_dev=
 *cptpf)
 	char engs_info[2 * OTX2_CPT_NAME_LENGTH];
 	struct otx2_cpt_eng_grp_info *grp;
 	struct otx2_cpt_engs_rsvd *engs;
-	u32 mask[4];
+	u32 mask[5];
 	int i, j;
=20
 	pr_debug("Engine groups global info");
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/IfyaL2G5XAz9GN4+6TdxnpR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH3El4ACgkQAVBC80lX
0Gy3ywgAmTfWly7vylkZG5qCWQN3WRbtZeGDp5vpaEhwZ4kGpYmb4atgGNGgwaOB
g55ROPbk/d9k70kVYbmqkD5zID/S8htOXnBd2peHbD8Pbzh6kCoUm3JBWcOEXupf
MUphJW6ReT1nCIMjTWjSrymhKj8UaIGN3ssfTtFu+ulaotaLpweTIaBh/t/WzhHl
p2QMkIWejUrV8Av2FajLrwXRXD2v1Rd/j9xNEaC3pGcLAJkzOq31GTFJnTobQZ4B
rLEATlf5Z2d2YwfjNLWEJ0iFdGIp9yqyVpXzRQIeUXxpBHIrkSZOCT0DNvGhRGJh
TkkoF+T/KONyrB9I3UuyvupHZkLPtQ==
=nb63
-----END PGP SIGNATURE-----

--Sig_/IfyaL2G5XAz9GN4+6TdxnpR--
