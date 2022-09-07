Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA05AFA57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIGDA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiIGDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:00:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5511EEC4;
        Tue,  6 Sep 2022 20:00:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMn710t0Pz4xDK;
        Wed,  7 Sep 2022 13:00:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662519613;
        bh=AWrG22HsG40nFWEUvbc9CiDwEjFs/Llqm0vlEFXRFA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gaoYIDfRJ9UCJHb31CKusDYxzY+a5mYX995fC1QLu1Ehf55PXp9X4RMvzW9Tcjenc
         f7CF3uTfXjGMOKAP6vRK+bNs4wj3ddVxKVqEE6CMMZ4sfDiXgSyRxd6OkDPL1Dg4Hg
         LIAEdb7xeH9pijEikyFeh+Emd//dQ1pOmbujE1ApYxYnnAlyIWrYHPoEmLHd8w2fQL
         blAykyGF4JYyrnMFAWiImBr9u+8XSTNSPft6kb+kk1Q7r4yuiKNoF9m6p5TIa2FO0W
         /W1jEVI1DS6EWCLYiuNUfERRMU+V7JZ7yJbhzY8tH+AB0KpLLXjLYol6v3B4relRre
         xaNeuXm1WFbpw==
Date:   Wed, 7 Sep 2022 13:00:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20220907130011.32818436@canb.auug.org.au>
In-Reply-To: <29e096e8-4ede-df66-4606-4bd0e5bda755@arm.com>
References: <20220831083452.2fc938cf@canb.auug.org.au>
        <20220907050535.243e5030@canb.auug.org.au>
        <29e096e8-4ede-df66-4606-4bd0e5bda755@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JVAmzB6om6HkpojjuskFSzT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JVAmzB6om6HkpojjuskFSzT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 7 Sep 2022 08:01:34 +0530 Anshuman Khandual <anshuman.khandual@arm.=
com> wrote:
>
> On 9/7/22 00:35, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > On Wed, 31 Aug 2022 08:34:52 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> >>
> >> After merging the perf tree, today's linux-next build (native perf)
> >> failed like this:
> >>
> >> In file included from /usr/include/stdio.h:866,
> >>                  from /home/sfr/next/next/tools/perf/util/branch.h:9,
> >>                  from util/branch.c:2:
> >> In function 'fprintf',
> >>     inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> >> /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' =
directive argument is null [-Werror=3Dformat-overflow=3D]
> >>   105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __f=
mt,
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >>   106 |                         __va_arg_pack ());
> >>       |                         ~~~~~~~~~~~~~~~~~
> >> cc1: all warnings being treated as errors
> >>
> >> Presumably caused by commit
> >>
> >>   9781e500dcb8 ("perf branch: Extend branch type classification")
> >>
> >> "native" here is PowerPC64 LE.
> >> $ gcc --version
> >> gcc (Debian 11.2.0-10) 11.2.0
> >>
> >> I have used the perf tree from next-20220830 for today. =20
> >=20
> > I am still seeing this build failure. =20
>=20
> But did you apply the fix patch from Arnaldo that removes -Wno-format-ove=
rflow
> compiler option for the file util/branch.c ?
>=20
> https://lore.kernel.org/all/YxJBh3wvAGol+Ekq@kernel.org/

No, I expected a fix to be in the perf tree ...

Also note that the following fixes the problem for me:

diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index d40776c44b06..b7b898f2872e 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -88,7 +88,8 @@ const char *branch_type_name(int type)
 		"ERET",
 		"IRQ",
 		"SERROR",
-		"NO_TX"
+		"NO_TX",
+		""
 	};
=20
 	if (type >=3D 0 && type < PERF_BR_MAX)


PERF_BR_MAX has been increased by one (when PERF_BR_EXTEND_ABI was
added), but a new string has not been added to the array ...
--=20
Cheers,
Stephen Rothwell

--Sig_/JVAmzB6om6HkpojjuskFSzT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMYCTsACgkQAVBC80lX
0GyyqAf/T1LM5r9YpZaFxgEvJ/8Q4rMacCoXmNDz9ptU7STW8JzpiE1l6sK5Qtpc
1E7CKauRkOst9sNygxXO7SU3BI/LedD5h+pYDob0inSF87CR4Pz39KDMcqtUp7+7
rR9lw8Gbxz90tGZe67gQ2JwY1YTtg3idCgG0qwNEuu+Jm0yxjTHg50+1rHbXpGa8
VwV4u90yqIiqfhruAT3IJEK3T0qd+g1GS4TzspXSx7/wekEPou0uKZQbRA3AuvXR
SaOr8bnfCW/A+FXfrb9T2IP8TEZi4a86wBXxJbQECQuuWsBJ3QDrW368gq1BXxy/
Q1n/EZlOamk3St56m91gUIWWxkGjWg==
=oWZ1
-----END PGP SIGNATURE-----

--Sig_/JVAmzB6om6HkpojjuskFSzT--
