Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936151CB63
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385980AbiEEVmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiEEVmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:42:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5965313E3A;
        Thu,  5 May 2022 14:38:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvRs16tKyz4x7Y;
        Fri,  6 May 2022 07:38:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651786710;
        bh=rYA36BBy09Tp+SheSMYy1pFpmjsD+svcqIqXzlNxOi0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OWWs9mxSB8AagTYzp4Nj4pDpBmWCiw/WnJ9R8dX26Yz56r5f3+Isv2sFEt/yNGuT4
         o8rpAD/pjGzaCMI09VhdoMwyEt9wn8zmaAaomy4zp99Yue1wLFBSZGMZHUX2febguS
         jhzKwRuAQiwuy4jOySsr62WTUaUHADcAV9kXS+Zy1tBRLnTbFCnF+K0t1mfaT2RW06
         nLYG5de2Nt2mqrCi+c3WKzq6gY55G5s7rryPjcqLhRGH7gDnMS3mJi+5gn7q0Xy2rS
         1okv8r5tel+APsdZmahnD29mLP5mgH3YaSKy0nLWQQUnXYwxDf6MOsvt++JUetL7HW
         iiwHKKCZprY3w==
Date:   Fri, 6 May 2022 07:38:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20220506073829.5545ff1a@canb.auug.org.au>
In-Reply-To: <20220506073537.6da48a27@canb.auug.org.au>
References: <20220506073537.6da48a27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0K6qHDeOqVItmIqYCtinyo+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0K6qHDeOqVItmIqYCtinyo+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 6 May 2022 07:35:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the mm tree, today's linux-next build (i386 allmodconfig
> clang14) produced this warning:
>=20
> mm/shmem.c:1704:7: error: variable 'folio' is used uninitialized whenever=
 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>=20
> Introduced by commit
>=20
>   2b58b3f33ba2 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_fo=
lio()")
>=20
> 'folio' is used in the error path.

This is actually a build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/0K6qHDeOqVItmIqYCtinyo+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0Q9UACgkQAVBC80lX
0Gzf/wgAgbJJZEJN4b2sfki7lWfcEDOweS8bPDZGlFFIZXSRJ6uG5BySaf/IYzfD
SE5GW276B0aIi5L9tB/qHDUj2pO8S+Ye4EGEdIDhVN59VD5KQjfNmcLhn+ZXFXRS
G4mjaw3u1v7SpQSv3MS7MxRXg88KG55cvUzZrTcj1qaUrb0ooa/5B4MF6Z8rDy7Y
sfl1IlKRgfK8QvWVxtdUK/JFvDmkFpOwoQegrQg+8QXwZtELFyUAlnVfxScuGTbc
V9Al5BGshPU+UQg2zJeNGLIE7o6HSkTQSOGfhPiYcp0q9xmrbqZ5HrPqMg093zwJ
rErCMPigYBk5xw9PO84ktDfL1S48OQ==
=ZIeN
-----END PGP SIGNATURE-----

--Sig_/0K6qHDeOqVItmIqYCtinyo+--
