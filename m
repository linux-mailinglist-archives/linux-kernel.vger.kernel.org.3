Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550404AE866
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiBIEJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346792AbiBIDiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:38:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2171C0401C7;
        Tue,  8 Feb 2022 19:38:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jtlvd2SGzz4xNq;
        Wed,  9 Feb 2022 14:38:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644377885;
        bh=IVVltse1KVLGor1dXWGYYBLp8Dq1wax8AojZy1EAyWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gS4Oql1HBQSNhBtKfwIAa5uXL4NzdPVDhJDct9TJYJHVWWyhO50cJez9kv5UvPuO6
         lMFQ33E7Cd+DJ3Iinm+UCEL9tnjtQl7uH7fyqyh5Pj9WdBCW//FFrd1QbPuUoJtn6B
         chSBvftsptI3Hlti0sI4MmVRdnpR1r0gd7yeXNgODfwpEVqDfEMpbohVOr/Lu09yuL
         MZuzkxClU1OnnGhrZBgKZEDKHOS3sphcFyY02J/fF3cQVixB2DJ8/XqaXr/F226h3l
         KBwj5GqaZbWePn5YQzjC9lZdaK0P43xi/4vnKWloSmx64Uan0sIzgutanHwoE629sI
         L5A5MRtmGwAeQ==
Date:   Wed, 9 Feb 2022 14:38:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the folio tree
Message-ID: <20220209143804.33b5f08a@canb.auug.org.au>
In-Reply-To: <20220207150621.0273b095@canb.auug.org.au>
References: <20220207150621.0273b095@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tqjQ92p5FdG2WhDa9hyRI1t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tqjQ92p5FdG2WhDa9hyRI1t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 7 Feb 2022 15:06:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the folio tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
> mm/page_vma_mapped.c:219:48: error: implicit declaration of function 'pmd=
_pfn'; did you mean 'pmd_off'? [-Werror=3Dimplicit-function-declaration]
>   219 |                                 if (!check_pmd(pmd_pfn(pmde), pvm=
w))
>       |                                                ^~~~~~~
>       |                                                pmd_off
>=20
> Caused by commit
>=20
>   02ecfe9b9580 ("mm: Convert page_vma_mapped_walk to work on PFNs")
>=20
> Presumably you need to explicitly include <linux/pgtable.h>?
>=20
> I have used the folio tree from next-20220204 for today.

I am still getting this build failure.
--=20
Cheers,
Stephen Rothwell

--Sig_/tqjQ92p5FdG2WhDa9hyRI1t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIDNxwACgkQAVBC80lX
0GyzOAf+No9QMeZbZCVvapQ8yoZJRtYxh/dZr84xH2Yr7KwTAkQx+ybLLIoi6W2F
YPMunXGb6eqzwkVRPACVGILusUJEbDgEOIDHlR8lr75QHgUYQWQEyMihmHP276uA
lOH5we3wHKrzBEiW/t1bens1Zjp4HQRZGUiUFvsClWnJ9V1Mwktqd2ZFPgHRZ1IP
HKl1KWaR/aDhKPlTrjMDKqNvPyF4RGLpcJI+jaTHX4zZSNa4eO5bpKEsT3EGrYCG
mr/5b7P5TAVpzEK+5+0gidx6Cuv3oW5pj2HextHKV1M21ey+dwrxNuH97X+/qsa9
LIa6IPx1y6jhqrJiHgmnFPPfhnNaWA==
=X/50
-----END PGP SIGNATURE-----

--Sig_/tqjQ92p5FdG2WhDa9hyRI1t--
