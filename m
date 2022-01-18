Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC084913C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiARBwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiARBwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:52:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C2C061574;
        Mon, 17 Jan 2022 17:52:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JdBbt5Wkhz4xsm;
        Tue, 18 Jan 2022 12:52:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642470748;
        bh=kR/zK4xF3tyAN2VgcwkwIkvMU1E9aH33MEHQopQjlEk=;
        h=Date:From:To:Cc:Subject:From;
        b=pNdM6XYUaCXceej05bDsYWF6iwS8CJVM/B/xg60wpoi9LEXlfxJQdO7E8KAEzD4um
         wapSA7r7Joq+ZVYFMmKHGYCbKWk0j6kmktDAl6ihPZJz7UHAISu8sjbeRrFXKMnxw4
         xXNetK+qoPNJEuNKyjHPAG+JQ3b4a7lyXMLuEP0VybZgXTlfjxxryOy/2pD/8rI5r4
         b1LySLw/jQszxn0A4rnYP0/Ayohc8VliJXJezyekCriGWI6lIPD4FbHQSN/KrzDG6w
         73yeGusvlsHjY9uBF3fvNvMip/1XhveCS+OF1EVf2FdI9vn3fi/+qLvmeL8gYvubEg
         v19V+RUUNAJFQ==
Date:   Tue, 18 Jan 2022 12:52:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: linux-next: manual merge of the akpm tree with the random tree
Message-ID: <20220118125225.31313015@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HnRFYszX4qkU+HoY/VBET3S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HnRFYszX4qkU+HoY/VBET3S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  drivers/char/random.c

between commit:

  b48e412a0b73 ("random: selectively clang-format where it makes sense")

from the random tree and patch:

  "random: move the random sysctl declarations to its own file"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/char/random.c
index b04664fa61a2,2ce43609dbc8..000000000000
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@@ -2055,7 -2076,18 +2054,18 @@@ static struct ctl_table random_table[]=20
  #endif
  	{ }
  };
+=20
+ /*
+  * rand_initialize() is called before sysctl_init(),
+  * so we cannot call register_sysctl_init() in rand_initialize()
+  */
+ static int __init random_sysctls_init(void)
+ {
+ 	register_sysctl_init("kernel/random", random_table);
+ 	return 0;
+ }
+ device_initcall(random_sysctls_init);
 -#endif 	/* CONFIG_SYSCTL */
 +#endif	/* CONFIG_SYSCTL */
 =20
  struct batched_entropy {
  	union {

--Sig_/HnRFYszX4qkU+HoY/VBET3S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHmHVkACgkQAVBC80lX
0GwnYQf/fSVq8cqI92+/P6EHMHjoKIVR7fJG9FtXMcMwodg7wTjiRfwSHc90emOZ
JVIQ97rLn+oW/vteFiwcJovEy9LzW/rtYyrHDHFJAvcslPWVEBkkAX3iYZGbQTAf
4QTtJl5XXTJR6afLixC3avjkdhq/2wRE+m22ztlBqWL12iafCszgZuVqpEbIXGyc
uRmyqPEn4r+9i0/nDRw46S3T71U+jSPDj3Hqrm0Wi1gvvbtzcNb937xtTw2zRNLD
OvJ+dN3GLj25OEwd/NyaqAZzwAdUDuFftNi67E+8/fVOeDcX8wFxjMTFwlQrYGMh
efprWeoaOMZr85KHOosWhuzMYhTx4g==
=bq0K
-----END PGP SIGNATURE-----

--Sig_/HnRFYszX4qkU+HoY/VBET3S--
