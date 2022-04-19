Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023A50633B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiDSEcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiDSEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:32:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA12612A;
        Mon, 18 Apr 2022 21:29:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kj9n45PDlz4xXS;
        Tue, 19 Apr 2022 14:29:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650342568;
        bh=ITI+nY4YiSnD87tRCkgMBczmbC3NDUN1L1tJAuE4NhY=;
        h=Date:From:To:Cc:Subject:From;
        b=E6ggjHuRqXV88aEJBZXacPQdcqG95uPyVh4xBwet8V5ES1OrynWyKpitEUnZTXH7V
         EW4mikpFYz2Cv89R9ZDTp248H04AQTNQJVA19OLJsREREaGJghlaxhbYW2AitpjmPR
         cgvHHgoZBQlOzao+o+M3g+vsRJE2WJfUApp9w5lNRQacUBMsa00dH4zP1goD3pSajz
         jcsDbmyjsV3dl3I4Oj5qI87e0Qud9UQ4SqRvztBN9s4RHX2RgRAs47rAkI2QjuozF9
         bOGHAArf8uXvWBczeujAnFwEC18fNOpsz1YOOoSyCFE5En7oT3e9CenOtpu2/HTrR1
         2Avi1u/Sr1xwQ==
Date:   Tue, 19 Apr 2022 14:29:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220419142927.4c99ba50@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QjmMTZHC8xiUbBR3cciggFS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QjmMTZHC8xiUbBR3cciggFS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (native powerpcle
perf) failed like this:

../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_weight_cmp'; h=
ave 'int(const long unsigned int *, unsigned int,  int)'
   21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its, int num)
      |     ^~~~~~~~~~~~~~~~~~~
In file included from ../lib/bitmap.c:6:
tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitmap_=
weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsign=
ed int)'
   15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its,
      |     ^~~~~~~~~~~~~~~~~~~
../lib/bitmap.c: In function '__bitmap_weight_cmp':
../lib/bitmap.c:26:50: error: comparison of integer expressions of differen=
t signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   26 |                 if (w + bits - k * BITS_PER_LONG < num)
      |                                                  ^
../lib/bitmap.c:31:23: error: comparison of integer expressions of differen=
t signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   31 |                 if (w > num)
      |                       ^
cc1: all warnings being treated as errors
tools/perf/../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_wei=
ght_cmp'; have 'int(const long unsigned int *, unsigned int,  int)'
   21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its, int num)
      |     ^~~~~~~~~~~~~~~~~~~
In file included from tools/perf/../lib/bitmap.c:6:
tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitmap_=
weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsign=
ed int)'
   15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int b=
its,
      |     ^~~~~~~~~~~~~~~~~~~
tools/perf/../lib/bitmap.c: In function '__bitmap_weight_cmp':
tools/perf/../lib/bitmap.c:26:50: error: comparison of integer expressions =
of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   26 |                 if (w + bits - k * BITS_PER_LONG < num)
      |                                                  ^
tools/perf/../lib/bitmap.c:31:23: error: comparison of integer expressions =
of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
   31 |                 if (w > num)
      |                       ^
cc1: all warnings being treated as errors

Caused by commit

  bf04367e90b2 ("tools: bitmap: sync bitmap_weight")

I have dropped the bitmap tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/QjmMTZHC8xiUbBR3cciggFS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJeOqcACgkQAVBC80lX
0GwipQgAnkmoONSEQgPi4CTpqgf0d/2929Zhc8Kbp5y9vDqbbqr+gVutUFyTVOcg
C2HJ/aoASmYIJV1Wvygf367p5MKH+APGxBlKpBHyaDBZLvPycnWgjZUoVm/ek1zL
fA0+32p31+xlw0WxYCGo5iEJM53iXjkZlhm0brun6lAZK/g8fURB/z39MNCHJ+55
xdLY7ENQSq6Rl3Kl5OrAqQspEoKFYShMqwcSYLYCJ8DREFz3WWBnasLS8Up/rCu9
ZnPzy37YxQqwCPAsREk6p39k13JC4zNIevH35PMXQ5yG5Jkji9HQhSqoS2Li8HCC
38dxSqsMqTBc7RDF9s8dV7xyuWS0sA==
=ktts
-----END PGP SIGNATURE-----

--Sig_/QjmMTZHC8xiUbBR3cciggFS--
