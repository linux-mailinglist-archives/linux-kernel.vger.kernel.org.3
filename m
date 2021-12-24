Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A947EBC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351393AbhLXFhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351385AbhLXFhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:37:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286CBC061401;
        Thu, 23 Dec 2021 21:37:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKwmh3f93z4xRC;
        Fri, 24 Dec 2021 16:37:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640324228;
        bh=Ml+H7gSgEnX6bae3B1iydAFvNRCqxcogiHKEVbyHUJg=;
        h=Date:From:To:Cc:Subject:From;
        b=rmZrGGDQC5SQHkEejgyD7Iny4WbGGKGNhxu+o9PoZkOeLCu2HG+9F0HiOGl4xF5ei
         JRm1Ue2hui7aUialUKKdRgpKFFKjN+92F6zgggFk8SgIWYVPIRpzWxFjxqnekjXaZ3
         TXHHH5ZlSv1r0ccB/slUx/tj2iTtq9MyotZ/EFQbjXyc9czRVJ58+u0NSk/CHpVKn+
         o6GPM1Bqf7FNM0vzos2MsxHd/JiMw2W80Aa6eYUBYzVRygX9TkwvUfSjG/B5YBEM74
         z2myK6NaFLvUxaYjRSNfWGkk3PeWPLX4OQi3CB60QjDkDiilFtqUMc3Y5biQGIKx/7
         3evLhwvMt+KXg==
Date:   Fri, 24 Dec 2021 16:37:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Harinder Singh <sharinder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kunit-next tree with the jc_docs
 tree
Message-ID: <20211224163707.70e04c0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BBTCWNwXxSZyBJk_3_wdbe_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BBTCWNwXxSZyBJk_3_wdbe_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  Documentation/dev-tools/kunit/start.rst

between commit:

  c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")

from the jc_docs tree and commit:

  4c2911f1e140 ("kunit: tool: reconfigure when the used kunitconfig changes=
")

from the kunit-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/dev-tools/kunit/start.rst
index a858ab009944,0a5e65540974..000000000000
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@@ -59,19 -44,23 +59,20 @@@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST
 =20
  	CONFIG_LIST_KUNIT_TEST=3Dy
 =20
 -:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
 -``.kunitconfig`` are set in the kernel ``.config`` before running the tes=
ts.
 -It'll warn you if you haven't included the dependencies of the options yo=
u're
 -using.
 +Before running the tests, kunit_tool ensures that all config options
 +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
 +you if you have not included dependencies for the options used.
 =20
- .. note ::
-    The configuration is only updated if the ``.kunitconfig`` is not a
-    subset of ``.config``. You can use tools (for example:
-    make menuconfig) to adjust other config options.
+ .. note::
+    If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of=
 the
+    ``.config`` file. But you can edit the ``.config`` file directly or wi=
th
+    tools like ``make menuconfig O=3D.kunit``. As long as its a superset of
+    ``.kunitconfig``, kunit.py won't overwrite your changes.
 =20
 -
 -Running the tests (KUnit Wrapper)
 ----------------------------------
 -
 -To make sure that everything is set up correctly, simply invoke the Python
 -wrapper from your kernel repo:
 +Running Tests (KUnit Wrapper)
 +-----------------------------
 +1. To make sure that everything is set up correctly, invoke the Python
 +   wrapper from your kernel repository:
 =20
  .. code-block:: bash
 =20

--Sig_/BBTCWNwXxSZyBJk_3_wdbe_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFXIMACgkQAVBC80lX
0GwQyQf9HDkjuhISmD2MO9n5Cw4JeSLMMW3wDjNU3U2rj1KWjmAvjkgfkqSE8gbS
IEEj/wfc4sAoUkFqDI8oj9EA5w86HrIiJN8+wne350arMTbrVZlajIfEI5JcFXYf
BdGcoGoaXrYs/7MDLw5AFxuRdkqMckleJ/YRw5ExpUSX+QDZCUG09be5yUlsjfJZ
9moggGlFVHyNnVNrWg0Irg9+uOWzc6b6MAdR0uQDtHb/UUx1sFYs0HL5cLlQ7mOd
JWH7X5bioNytLHRxwCu7e+fnC4QRNNMkbQPG9ag+dujdqPVOWnAMcXVtmBU21uDK
9FSfDJ6rkVo3H/bXlkb7xtRyMFYQyA==
=Cc42
-----END PGP SIGNATURE-----

--Sig_/BBTCWNwXxSZyBJk_3_wdbe_--
