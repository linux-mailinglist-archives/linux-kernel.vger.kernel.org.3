Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4284F2173
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiDEDJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiDEDI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:08:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6A1A8C3F;
        Mon,  4 Apr 2022 19:55:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXXMK4bW5z4xXt;
        Tue,  5 Apr 2022 12:55:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649127342;
        bh=0X5IKdKdiQgyqwGlPD2EXLDaBlQIGtaZABDXmKF3Bjc=;
        h=Date:From:To:Cc:Subject:From;
        b=i4cIVA3K0IZv5wjzC7kp94G+lS+Fu0hPNqWClOz8W0od9796yXypQicijCrLBNxdL
         AftgyR1qv/lznaoWJ/nS0qPxSMXHOd9KGDXi5q028KbrtwR7rs7fq3t9nDK2y6XOG8
         kl1YQZYdDhVRDVca/xMn595oQNutPvFQPhygAN+JkuoLtDvoVC918p7BDscWkySwgW
         6R81LvQFGaN4UwxVAw6CZe/hlYtPYZHcyyjL9qHyGnCtKbhY6W2OnzDItWdr5uhhkI
         YbOqJ6H2YW19q/rLXQkpDSvQ+duZmijA8Gra/wXY4tRwjwpzoxnOJ6HVwRpJMOxkU7
         uupH3p3G7/G5A==
Date:   Tue, 5 Apr 2022 12:55:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Message-ID: <20220405125540.2135d81d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AgTO6kKYKuIZnbyIQZOZ85u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AgTO6kKYKuIZnbyIQZOZ85u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  security/apparmor/policy_unpack_test.c

between commit:

  d86d1652ab13 ("apparmor: test: Remove some casts which are no-longer requ=
ired")

from the apparmor tree and commit:

  5f91bd9f1e7a ("apparmor: test: Use NULL macros")

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

diff --cc security/apparmor/policy_unpack_test.c
index 399dce3781aa,5c18d2f19862..000000000000
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@@ -408,8 -408,8 +408,8 @@@ static void policy_unpack_test_unpack_u
 =20
  	size =3D unpack_u16_chunk(puf->e, &chunk);
 =20
 -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
 +	KUNIT_EXPECT_EQ(test, size, 0);
- 	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
+ 	KUNIT_EXPECT_NULL(test, chunk);
  	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
  }
 =20
@@@ -430,8 -430,8 +430,8 @@@ static void policy_unpack_test_unpack_u
 =20
  	size =3D unpack_u16_chunk(puf->e, &chunk);
 =20
 -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
 +	KUNIT_EXPECT_EQ(test, size, 0);
- 	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
+ 	KUNIT_EXPECT_NULL(test, chunk);
  	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
  }
 =20

--Sig_/AgTO6kKYKuIZnbyIQZOZ85u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLr6wACgkQAVBC80lX
0GyJnQf/QkeaZtW6owO89lZU4MNDWmuXCnwMNQFUq8zn++DBkraGLIhsvjSx6Qda
sjXtf+yJbZ8ymitnZ15KQl9EbfBZ2e/TR3ZDZdOGVbxbaTGJIJhhIpY0hK4QRhec
4OczTgg0E069PznOGPbM7UXtGSOVipnbJpWfMY1sT4Udr7qsiNrrRAyh9LaIKDIS
Kipvr1eTZkawdB3IibTtOzRWdgVHGVl5zKex9J3sfJeXn0nGsFAGJVQzxp1ILBFQ
lnLVenv8s3z5f5d+T9NxF7jtuM584Nz6Vm4bX7AseXOubigwmaEYGyfgu5fscp6z
FkwdjacK9CtlSfsMGrT1FSG3wI0hpQ==
=9CTE
-----END PGP SIGNATURE-----

--Sig_/AgTO6kKYKuIZnbyIQZOZ85u--
