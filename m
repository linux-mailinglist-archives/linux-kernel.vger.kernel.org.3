Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3118049F1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345847AbiA1DsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:48:06 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58673 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiA1DsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:48:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JlNhg0Swtz4xcQ;
        Fri, 28 Jan 2022 14:48:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643341683;
        bh=+AcSLPwMhoTZy74+5ME6OlwPS7bureaRpYE8d1VwP3Y=;
        h=Date:From:To:Cc:Subject:From;
        b=CdZWtVHv3bL/m8F2llBoUbfdisjYUMsIwH6cK0jUHES8sNxp6LQtVVcIyaCS6zvC4
         9UVogp+o4g6BJDJ4QHm4JtNu0mV1Zywl6ueWqOsZZcYoWs++dGHXc5eefF3tQnWPkQ
         b5DZRLivrrrK7oV1wzqTiLH9AdBZGMqYidoSTGX4ZcVeIZBYm/1w50pfI9z+a2FZsc
         ebqiJ7ROYjF/blIomJD6G5ZZinz4PA7lkmR8/uF05+8bEzhXDazqx0hJRbEV0s7KNf
         c0Z9UDW9RGWbJSp3Nv++1wJk7oit4smK0s7v4qCc50A8Pk2kaCCWqWe02KLBkVAa+g
         KQ+SEKIXu5Hxw==
Date:   Fri, 28 Jan 2022 14:48:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20220128144801.73f5ced0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9N2ajg9p+xO9PjwewIRTh1P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9N2ajg9p+xO9PjwewIRTh1P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (x86_64
allmodconfig) failed like this:

lib/test_kasan.c: In function 'vmalloc_oob':
lib/test_kasan.c:1113:71: error: array subscript 2035 is outside array boun=
ds of 'char[2035]' [-Werror=3Darray-bounds]
 1113 |                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_p=
tr)[size]);
      |                                               ~~~~~~~~~~~~~~~~~~~~~=
~~~^~~~~~
lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAI=
L'
   96 |         expression;                                                =
     \
      |         ^~~~~~~~~~
lib/test_kasan.c:1096:17: note: referencing an object of size 2035 allocate=
d by 'vmalloc'
 1096 |         v_ptr =3D vmalloc(size);
      |                 ^~~~~~~~~~~~~
lib/test_kasan.c:1116:63: error: array subscript 2040 is outside array boun=
ds of 'char[2035]' [-Werror=3Darray-bounds]
 1116 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size=
 + 5]);
      |                                       ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~=
~~~~~
lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAI=
L'
   96 |         expression;                                                =
     \
      |         ^~~~~~~~~~
lib/test_kasan.c:1096:17: note: referencing an object of size 2035 allocate=
d by 'vmalloc'
 1096 |         v_ptr =3D vmalloc(size);
      |                 ^~~~~~~~~~~~~

Caused by commit

  96304a5b9bff ("kasan: improve vmalloc tests")

interacting with commit

  d4e0dad4a0cd ("Makefile: Enable -Warray-bounds")

from the kspp tree.

Since the KASAN tests are doing this deliberately, I added the below
hack for today.  Is there something better?

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 Jan 2022 14:40:24 +1100
Subject: [PATCH] similar to "kasan: test: fix compatibility with
 FORTIFY_SOURCE"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/test_kasan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 9dd767d05235..c07132c857e7 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -1096,6 +1096,8 @@ static void vmalloc_oob(struct kunit *test)
 	v_ptr =3D vmalloc(size);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, v_ptr);
=20
+	OPTIMIZER_HIDE_VAR(v_ptr);
+
 	/*
 	 * We have to be careful not to hit the guard page in vmalloc tests.
 	 * The MMU will catch that and crash us.
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/9N2ajg9p+xO9PjwewIRTh1P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHzZ3EACgkQAVBC80lX
0GwiFAf8Cw3msbJoB/WvX4sibiLqoUZJij/zXTPkG1uD09OVwluM1vHo3sbSLBsw
nDfjiOOi/oOeDaOSknjlFtdo+QkYw1pU4sNj8rlICeiawjg3zoLMT2WnDxRfDV6w
H+1w9FXKe9stgezcoC/ckgEG9ntjC6z09m1qISUwWV+IV+49B+KE92hGwIGq1NfN
jeaIe2JIP0J/glgs7Io+gab8dygmGvSR4QRZKjqaUw83nHJKs3OFfOtLjGTgrWAW
+bAysnh5EhvKi68Og/igHrc5TDiJ9WX7w47u1nUTzr8JjKqQoDhaEF5p3rKzRgd6
+MKbsNj77AuvfqCW/1U5lGI++9bD5w==
=F6zI
-----END PGP SIGNATURE-----

--Sig_/9N2ajg9p+xO9PjwewIRTh1P--
