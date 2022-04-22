Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F6850AEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443842AbiDVEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443835AbiDVEC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:02:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61B4E3B0;
        Thu, 21 Apr 2022 20:59:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kl0z44z9fz4x7V;
        Fri, 22 Apr 2022 13:59:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650599969;
        bh=rgfSwER6bjjFEk0VhZ1xkozEkvdXCtQbyj9SLWydRJM=;
        h=Date:From:To:Cc:Subject:From;
        b=d2XWQipTXyCDaSy1KrjLfPO2c6ew7K0ZMo8wXW7FGuAGtdVvfR10zoAt3fw71WKCj
         JX4TW2A5c+kxlvF4BRnYbkP+rls32/rf7GY6YbWw7PzZ6xZ1ceiHDUy/OoS6zjqB5s
         dLBPwoeJ/d2dbh3PN7FGWPsdohTZWczy13W5J5Tz6TOl+KbKFtzsgD0icFB2ceuuR/
         uGrtedtExlOosr+Z4/Yj7N1zf25jX8bHMYq/Gf+NM+Lr3FsuVkVH4mmXqRMmKOKKEn
         e5rTD7xHDrTm0jspF+EBvXcKAGrlbrOoO+mf/W4wHbPHQOMrxxP4wzFa4rVBtq4EJv
         P+lZZEkER9oKw==
Date:   Fri, 22 Apr 2022 13:59:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the random tree with the jc_docs tree
Message-ID: <20220422135927.7fa82fa4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kafs3okMNST.qMw/HSwm.8S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kafs3okMNST.qMw/HSwm.8S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  Documentation/security/siphash.rst

between commits:

  dc701cfc5b26 ("Documentation: siphash: convert danger note to warning for=
 HalfSipHash")
  561fb3cd5ec2 ("Documentation: siphash: enclose HalfSipHash usage example =
in the literal block")

from the jc_docs tree and commit:

  91afe794c070 ("siphash: update the hsiphash documentation")

from the random tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/security/siphash.rst
index 06d793e68086,79ac8101406c..000000000000
--- a/Documentation/security/siphash.rst
+++ b/Documentation/security/siphash.rst
@@@ -121,15 -121,23 +121,25 @@@ even scarier, uses an easily brute-forc
  instead of SipHash's 128-bit key. However, this may appeal to some
  high-performance `jhash` users.
 =20
+ HalfSipHash support is provided through the "hsiphash" family of function=
s.
+=20
 -**Danger!** Do not ever use the hsiphash functions except for as a hashta=
ble key
 -function, and only then when you can be absolutely certain that the outpu=
ts will
 -never be transmitted out of the kernel. This is only remotely useful over
 -`jhash` as a means of mitigating hashtable flooding denial of service att=
acks.
 +.. warning::
 +   Do not ever use HalfSipHash except for as a hashtable key function, and
 +   only then when you can be absolutely certain that the outputs will nev=
er
 +   be transmitted out of the kernel. This is only remotely useful over
 +   `jhash` as a means of mitigating hashtable flooding denial of service
 +   attacks.
 =20
- Generating a HalfSipHash key
- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+ On 64-bit kernels, the hsiphash functions actually implement SipHash-1-3,=
 a
+ reduced-round variant of SipHash, instead of HalfSipHash-1-3. This is bec=
ause in
+ 64-bit code, SipHash-1-3 is no slower than HalfSipHash-1-3, and can be fa=
ster.
+ Note, this does *not* mean that in 64-bit kernels the hsiphash functions =
are the
+ same as the siphash ones, or that they are secure; the hsiphash functions=
 still
+ use a less secure reduced-round algorithm and truncate their outputs to 32
+ bits.
+=20
+ Generating a hsiphash key
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
 =20
  Keys should always be generated from a cryptographically secure source of
  random numbers, either using get_random_bytes or get_random_once::

--Sig_/kafs3okMNST.qMw/HSwm.8S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJiKB8ACgkQAVBC80lX
0GwXnQf/Z0krKKoLxskBQJodAXyEJqSf8EDFNUGMB6MYWg9he8A5lCYSBvw5Nkcz
zdw9anD5zIBqoFvdukbJLBjet6WJMto1AjBPqWlGV9zyAMwy4pqne4VdtIC38hQK
7FZVv4vvSMf2CQRpRlUjCrUDcuIWCkGmuKMXDW3+JkRTfcraafZnSNYrwp71YQZi
W01x3TIGmO0Lr1X9oo1CcHN3f43fBsIFUqOzky1IHymAxSZW7MZx8iMFPS6Fb8aB
BKWeqVw6gT/5aN/cHhslk4dDgt2S2RlVv6/mqB4+vduRQyA6pIwFTBRbd+vyeyAE
KVvT8VuLu3w1FBvEfoIpDD0qG55qxw==
=Iq2B
-----END PGP SIGNATURE-----

--Sig_/kafs3okMNST.qMw/HSwm.8S--
