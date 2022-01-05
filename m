Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B99485B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiAEWUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbiAEWTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:19:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574FDC061245;
        Wed,  5 Jan 2022 14:19:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JTkRb0srmz4xnF;
        Thu,  6 Jan 2022 09:19:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641421163;
        bh=QfDjSUj+Bm1/JoRgYzugmB60OsqL++bY3C4BCxzpAVw=;
        h=Date:From:To:Cc:Subject:From;
        b=CPNFhlnPI2e/VloHquRN7DqRN9MBDvvHY057ULTc4XqvnT+C9jCWoDXPVG2+SVFQo
         5acWM/cgVqs8x8hLKp5nRmrhmLaZIstH3Ljv9D3j5yCUXss1mB1qUrq4UjwOJhE51m
         lyGHoBFUlQ7XS9vbRs+cNBOJMMIq8fyh9dQ6sxVeqYgMzF0Et66J8FF7LMenK9enpV
         7bD5hPnzelilHl2+gNb1W1HnlmTigbUEFVsp7/UWlfZn6Pp+zNgveBYGIfiATBJ8ip
         ecsClE9z/oZoXj+ZHf3PL3TVNPLZ5eSQj+cTKT0+N8kEe8JAi+NjprvRy2ScVOSgql
         IjrD0v8MigTGg==
Date:   Thu, 6 Jan 2022 09:19:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20220106091921.3fa617bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ad2mF1w6wTRuKxYawgn1ioK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ad2mF1w6wTRuKxYawgn1ioK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/perf_event.h:17,
                 from arch/powerpc/perf/isa207-common.h:12,
                 from arch/powerpc/perf/isa207-common.c:9:
arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undeclare=
d (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
 1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
      |           ^~~~~~~~~
arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF=
_MEM_S'
  273 | #define P(a, b)    PERF_MEM_S(a, b)
      |                    ^~~~~~~~~~
arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
  240 |     ret |=3D PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
      |                                                   ^
include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifier i=
s reported only once for each function it appears in
 1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
      |           ^~~~~~~~~
arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF=
_MEM_S'
  273 | #define P(a, b)    PERF_MEM_S(a, b)
      |                    ^~~~~~~~~~
arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro 'P'
  240 |     ret |=3D PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
      |                                                   ^
include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undeclare=
d (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
 1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
      |           ^~~~~~~~~
arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro 'PERF=
_MEM_S'
  273 | #define P(a, b)    PERF_MEM_S(a, b)
      |                    ^~~~~~~~~~
arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro 'P'
  244 |     ret |=3D PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
      |                                                   ^

Caused by commit

  af2b24f228a0 ("perf powerpc: Add data source encodings for power10 platfo=
rm")

It looks like patch 1/4 of this series is missing ...

I have used the perf tree from next-20220105 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ad2mF1w6wTRuKxYawgn1ioK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHWGWkACgkQAVBC80lX
0GwPFAf/TiloP1qFatishWP3Y03cnXzCVOaarDGWUcg5mrz+NNa82eqGF/kZaMb5
bToevb+403g72ChHNdbfR94s+4kSF2rVFimLX2BC++hy0L7i8oHH9AEFek5dammC
E6I9lnM6OwFaSjs0ugheeD0hszishpQd8zEGs/1kYasz4RsGd2YYtY0vBxIgrIi3
nCQRSFx5RcFMoZm4CRiIk9f50ePKHhKrvDr11s29J9/NpxPOCorouUIdMpAm2YO6
OZhArysYQcLadW1di02fKJOStTt+WSbvg09wO1YE3N+Y5hr4BbForZS8UlkNjCMi
DoWdwOIzaiBapQJMq/BDizUFUXZZkQ==
=WwQb
-----END PGP SIGNATURE-----

--Sig_/ad2mF1w6wTRuKxYawgn1ioK--
