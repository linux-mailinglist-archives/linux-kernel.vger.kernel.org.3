Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D175213A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiEJL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiEJL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:29:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BE32ABBF4;
        Tue, 10 May 2022 04:25:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyG1H5NYYz4xLb;
        Tue, 10 May 2022 21:25:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652181924;
        bh=tgR0lFQ0BgKgUqHLZLyO6KOe2YNHiBdhu+ndRrBc6s8=;
        h=Date:From:To:Cc:Subject:From;
        b=QDJqwowGRc2JMd3prm99LSdL/7+8G+oxe+syd+oriTNNeT5QGudHNJjA92JFmzZKO
         +e8X+dVB9N4TOtTJhgESZF79c6lK1QsHHyrElDeI/gDbMdgaf6Tc2GotrVNoIAFxFV
         5TikKU2QQHVFBHt59S2ABf5BP4prCSP9upHikbOHOyAZdxFDiEw6J+b8pUlBlXfqWH
         xHmmPsGPZNa12ziRlt0pYTd8v2Pyqq7PbDb1QN5dZtkXkpH44NYENDpI9fxbnf6Em1
         ELqJ66SxJGs24wpRCWxZEJK0KCxCFnjkhuGF8sxqVFwCyqq8n3WBGlv2iTxEUqJRGk
         yzNJo+4XxhQyA==
Date:   Tue, 10 May 2022 21:25:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220510212521.1b3ad15c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WxQ44rXNvsL8FSuhLUW1=IA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WxQ44rXNvsL8FSuhLUW1=IA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allyesconfig)
failed like this:

In file included from mm/damon/vaddr.c:703:
mm/damon/vaddr-test.h: In function '__link_vmas':
mm/damon/vaddr-test.h:29:17: error: implicit declaration of function 'vma_m=
as_store'; did you mean 'mas_store'? [-Werror=3Dimplicit-function-declarati=
on]
   29 |                 vma_mas_store(&vmas[i], &mas);
      |                 ^~~~~~~~~~~~~
      |                 mas_store

Caused by commit

  59904daa2b0c ("damon: convert __damon_va_three_regions to use the VMA ite=
rator")

I have merged the mm-stable, mm-nonmm-stable and mm trees from
next-20220509 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WxQ44rXNvsL8FSuhLUW1=IA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6S6EACgkQAVBC80lX
0Gwu/Af9HkPo04wgf1lCzFbAR3WkNTI070UydK74M65cgXEcOsBb0zWVc7J/MgC2
C/46d4YpbuJgUtXRIHSufLSMxIgy4nwkVGz+4oo92ahf95wrsjkXYUDmi5Pwnf2D
fjlu9mhTHxN8ZpIJc1yRU7O+az758Ot+kKqfTzCSuT3mt6skJI1ScfD/BJ4cw+T6
qFAysAHOAASjsvcFKR/rD5+YCs53Ve0Sth7QJ4t4+LlEEbmMJAc+YkYzYDsyKfw3
yzBmS7ihvMorznSu7iy/b2HUl6a45gU3YQwyeTXVehGniQcDoymPA948Qr0KSXdi
8SCallWdR4xQ8QJmPugHBipLBYfhgQ==
=Io4O
-----END PGP SIGNATURE-----

--Sig_/WxQ44rXNvsL8FSuhLUW1=IA--
