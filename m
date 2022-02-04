Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291204A9244
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356503AbiBDCQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiBDCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:16:28 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631AC061714;
        Thu,  3 Feb 2022 18:16:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JqfKd003Pz4xQp;
        Fri,  4 Feb 2022 13:16:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643940981;
        bh=jkZQmuyQzyKA0GIwHcT7UC8C6dcjOfg5jhaAd6IvPQk=;
        h=Date:From:To:Cc:Subject:From;
        b=Tx9JGu3LQvL794T0FmMQf5VT2sKVHUN6+GAC8Zisqvr8rtrfMEtm69EBS6JfUWSnw
         sX3y+ZPbqsAwAOR9fjcryMPCJ4JdPTYO0BSoi/HwnntTmCBmre0mY7IpmDZgMs03+v
         nyHoxZoPtJHGLHs7QqAnCAJ37EKnCQiW/5K3OgaY4gi4zo9N4aIaH1ZMEEXv0aCIG4
         PTa90K347dCHbP6ZcdK16lai2ZLsqL5O+yQze558h6youLgFtlF6S3MA1e25vdqcbw
         R4ZnMnA7GC2JmgU4xmtCkC4/Zue8mNdmFLZ+UQHbg0CNZzw1M6p2pZWfpvnCfBZGl2
         SY6lTcSyxyyLg==
Date:   Fri, 4 Feb 2022 13:16:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Subject: linux-next: manual merge of the landlock tree with Linus' tree
Message-ID: <20220204131619.566307b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lht/ZhflkAm7rLbqRi7BSGC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lht/ZhflkAm7rLbqRi7BSGC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the landlock tree got a conflict in:

  kernel/printk/sysctl.c

between commit:

  1f2cfdd349b7 ("printk: Fix incorrect __user type in proc_dointvec_minmax_=
sysadmin()")

from Linus' tree and commit:

  c96303ec34ab ("printk: Move back proc_dointvec_minmax_sysadmin() to sysct=
l.c")

from the landlock tree.

I fixed it up (I used the letter version and then added the following
merge fix patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 4 Feb 2022 13:13:51 +1100
Subject: [PATCH] fix up for "printk: Fix incorrect __user type in proc_doin=
tvec_minmax_sysadmin()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2e2027e323fd..39e45a602e97 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -889,7 +889,7 @@ static int proc_taint(struct ctl_table *table, int writ=
e,
 }
=20
 int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
-				void __user *buffer, size_t *lenp, loff_t *ppos)
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lht/ZhflkAm7rLbqRi7BSGC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH8jHMACgkQAVBC80lX
0GyxRggAjEuzdVTGZU27tkNHDs6faOUFxHDxonmLFRP9r7IJ4jumzUQIFGVYJIlD
hAbNvEJbhRTV/f7PCxb/JpqsevgYsWt29ks3CkGEAycgEbarfKrs5BvVufvM43RN
rXS+bLyts+onBfniwzYYHLrNCKtsDGa9Sy+J55Hg+wbdOWwltebGbc9numbeuhi2
iAPLhqKZo72snTlhNozX7iiGH4n0O+9zBPrOonvEI9E+UFrK3X0slUa2TN1nUBix
LTWU2NgtCpgZuYgXLEXN1RHO0HQTPUZ+pncbtIo94+qnxXiwbQrT5xiZi/UuIQYh
7a726L8hxnoJxJDSW9jjyCAwcqm+Zg==
=aJqr
-----END PGP SIGNATURE-----

--Sig_/lht/ZhflkAm7rLbqRi7BSGC--
