Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE06A48B9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245445AbiAKVp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiAKVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:45:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8498C06173F;
        Tue, 11 Jan 2022 13:45:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYPQB5Myhz4xmx;
        Wed, 12 Jan 2022 08:45:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641937554;
        bh=horR/F246q5h2cOFjuXY0hWw0uKMJ1zqHhBirXI8mmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mH1GrJ95HOH6ofYFHL/CtB5ETiQ1BPz3h+PlElw0RIkyDZBj8vQtCEyyqdYivFiHk
         YFWNvkKLin5VPEeNg16+QOG8z+nUxngKfpK5b25c5j1h/gQRl2PtUmZ+B9QNnalvk4
         i40lT3xZeivC4LS3A04IHklh9WKBe28WK08w/h1zMXXIuLOkfB+PYaa2b9nl+G31IU
         mXpuddIOW0i1la/ecrC4cWkzIh8POXla2AawhEnFvQCvIX5Qoi6BVsBI/YBMEQas1T
         66zGM/ZFc93S69DuiGdtIVBfDfePh3Mk4jOJHJ8u8qqo127HBeSzbmA5PvxGd2xBU7
         lDJXGSXUSUEnA==
Date:   Wed, 12 Jan 2022 08:45:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20220112084553.2aa71f08@canb.auug.org.au>
In-Reply-To: <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
References: <20220106091921.3fa617bc@canb.auug.org.au>
        <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W3185Q7B4iYGXgk4HPJ23u5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W3185Q7B4iYGXgk4HPJ23u5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 7 Jan 2022 14:28:37 +0530 kajoljain <kjain@linux.ibm.com> wrote:
>
> On 1/6/22 3:49 AM, Stephen Rothwell wrote:
> >=20
> > After merging the perf tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > In file included from include/linux/perf_event.h:17,
> >                  from arch/powerpc/perf/isa207-common.h:12,
> >                  from arch/powerpc/perf/isa207-common.c:9:
> > arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
> > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_2' undec=
lared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
> >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> >       |           ^~~~~~~~~
> > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro '=
PERF_MEM_S'
> >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> >       |                    ^~~~~~~~~~
> > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro '=
P'
> >   240 |     ret |=3D PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
> >       |                                                   ^
> > include/uapi/linux/perf_event.h:1339:11: note: each undeclared identifi=
er is reported only once for each function it appears in
> >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> >       |           ^~~~~~~~~
> > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro '=
PERF_MEM_S'
> >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> >       |                    ^~~~~~~~~~
> > arch/powerpc/perf/isa207-common.c:240:51: note: in expansion of macro '=
P'
> >   240 |     ret |=3D PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
> >       |                                                   ^
> > include/uapi/linux/perf_event.h:1339:11: error: 'PERF_MEM_HOPS_3' undec=
lared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
> >  1339 |  (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
> >       |           ^~~~~~~~~
> > arch/powerpc/perf/isa207-common.h:273:20: note: in expansion of macro '=
PERF_MEM_S'
> >   273 | #define P(a, b)    PERF_MEM_S(a, b)
> >       |                    ^~~~~~~~~~
> > arch/powerpc/perf/isa207-common.c:244:51: note: in expansion of macro '=
P'
> >   244 |     ret |=3D PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
> >       |                                                   ^
> >=20
> > Caused by commit
> >=20
> >   af2b24f228a0 ("perf powerpc: Add data source encodings for power10 pl=
atform")
> >=20
> > It looks like patch 1/4 of this series is missing ... =20
>=20
> Hi Stephen,
>      Yes you are right, original patch series contain 4 patches, where
> 1/4 patch contain kernel side changes for the same. Hence we are getting
> this error, as that patch is missing in the Arnaldo tree.
>=20
> Link to the patchset: https://lkml.org/lkml/2021/12/6/143
>=20
> That kernel side patch is taken by Michael Ellermen via powerpc git.
>=20
> Link to the patchset on powerpc/next:
>=20
> [1/4] perf: Add new macros for mem_hops field
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/=
?id=3Dcb1c4aba055f928ffae0c868e8dfe08eeab302e7
>=20
>=20
> [3/4] powerpc/perf: Add encodings to represent data based on newer
> composite PERF_MEM_LVLNUM* fields
>  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit=
/?id=3D4a20ee106154ac1765dea97932faad29f0ba57fc
>=20
> [4/4] powerpc/perf: Add data source encodings for power10 platform
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/=
?id=3D6ed05a8efda56e5be11081954929421de19cce88
>=20
> Thanks,
> Kajol Jain
>=20
> >=20
> > I have used the perf tree from next-20220105 for today.
> >  =20

I am still getting this build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/W3185Q7B4iYGXgk4HPJ23u5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHd+pIACgkQAVBC80lX
0GzFTAf/ayoLU8ZsXcnnyewCbjtaSeStlDP2MT8E0rfsHm+ADLRzry7s0lHJ0Mlw
BGyNwNePl2yPAD2XmzU8eV+E12RjaGFp/GWRoGN+oOBULTO6Flmf2TRVunNkzWTP
NDuI8MDlvJxGuGgNu3QuYIHiI7T1F6MVdUQ4jVTss9mjBNH+McEyVlKmuMzgjlgJ
NrsoD+CMi17bcfF3yzg1+jP7EDDS7Po3F6z1TRn88r06Mg0OvKI6P/ALfpv1L1gr
7vVbyeeUBz6QQCy7B6Pew9zlp1BMEJ68npm6YjI58SJkoUhuaT6UW+jYjmozmIEx
Shn1IANYe57myMuFvWiGC7LfupJw0Q==
=dlLO
-----END PGP SIGNATURE-----

--Sig_/W3185Q7B4iYGXgk4HPJ23u5--
