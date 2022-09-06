Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0F5AF858
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIFXUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIFXUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:20:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A18C472;
        Tue,  6 Sep 2022 16:20:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMhF92pv6z4xD3;
        Wed,  7 Sep 2022 09:20:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662506413;
        bh=wCaSgYxGu7Jh4EHOpMu0Yy2bS4uffTuB38SZd3J/r1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O24ypygOKxT9lty4aSrIJBbDD6jSzebU/GslEclFLv5lsIcjSOB0g79EqYd9AjuRc
         RK0wumVBjR3vTfkfGgN+/TYWJYPjJ51w45zFqkBOYD6LEXVEFP8Laauy4tfwgCPFBl
         HVSpnGB4D2ogTgtxDVJH8nxKVMpWSbc7roiFuTZGrL/Va9x+i/KN1pxBo9uJ14MMwC
         okU31HhNuBVMMR05u25cE8Ds/cXo71Puw2oadtUk1zHBd5dBWsTNktZewPfuSw0l59
         RwF7JsKnh1YdQoitZ7Cl5ML7zjfkKurLq0NtsjIcJsoDmFHTPFh4M9a6ge6P24RiCO
         4kMfDn9bS6FiA==
Date:   Wed, 7 Sep 2022 05:05:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20220907050535.243e5030@canb.auug.org.au>
In-Reply-To: <20220831083452.2fc938cf@canb.auug.org.au>
References: <20220831083452.2fc938cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0sM7YroQQSQQxiC4RiiMh1Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0sM7YroQQSQQxiC4RiiMh1Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Aug 2022 08:34:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
>=20
> In file included from /usr/include/stdio.h:866,
>                  from /home/sfr/next/next/tools/perf/util/branch.h:9,
>                  from util/branch.c:2:
> In function 'fprintf',
>     inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' dir=
ective argument is null [-Werror=3Dformat-overflow=3D]
>   105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   106 |                         __va_arg_pack ());
>       |                         ~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Presumably caused by commit
>=20
>   9781e500dcb8 ("perf branch: Extend branch type classification")
>=20
> "native" here is PowerPC64 LE.
> $ gcc --version
> gcc (Debian 11.2.0-10) 11.2.0
>=20
> I have used the perf tree from next-20220830 for today.

I am still seeing this build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/0sM7YroQQSQQxiC4RiiMh1Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXmf8ACgkQAVBC80lX
0GygFAf8DabGVNOMh8RNCweNgq1bux6EhyJt1rsXcxFBolKhcyCcEYHjTKAMLUvH
yauWoVZzL7HlYfNUI122Fo9KbkDPcl8YAf9eZopUB8iXkbnEBaVHxX4UHPFSHk8a
0Oj0DMzaydrmDt4gkscVwjKULuWpWgPqCLyvvG/u++k2+v5X3mQjQzy1qGdI5E3j
EzbUz9x5I6og8ZqAfwUK8Jf9hmXwZr3bnWuwwNLB+qZtk+VfNUnihiba4t+nFCzr
E6SieCaS/MaivQwe7/Dkw1TNAC3i+q9QvK2Z18oo9kyPxuoDNljPXc8FJosX9iSk
C1PvlzXOeP7a8/rZyk5+wlxkjX4WWw==
=U9Xm
-----END PGP SIGNATURE-----

--Sig_/0sM7YroQQSQQxiC4RiiMh1Y--
