Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282104C6D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiB1Myp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiB1Myo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:54:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796BF56C03;
        Mon, 28 Feb 2022 04:54:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6gLH0sFPz4xcq;
        Mon, 28 Feb 2022 23:53:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646052839;
        bh=8B6XiJ9lmvXFwgHrhU14u3sza3iGcw2HRFqAdksawkY=;
        h=Date:From:To:Cc:Subject:From;
        b=gH871yv3uhpNqUtgYkncFghfyNx/ZzyOm2Or4VPktjPYSF72U9aHkGMxnKm3Ti3Dx
         s2+B5lYc1may5lfNgtjMTCNQBuQ8QeXLr3CKNzDAd3B6Andwnv9vU/q69mgo3oSs82
         Ck9X7MTWykWTj8+GOD6IGm11C9EJ26xlmBbMDP39O7zuS5LwPgn7ZtijyIrGFYVRy4
         QqyAHnwfNCVXRiMx5SBTiyAKbtu6DSkHZHVcTaCyGuw2xUVy9TmMeN7ErmVDNF6cS3
         2Ey2+WdFFTFTc0G43lD36ad05eGgm+uDxWCk+j3CnH1Mzy6wGKGDJo2dOtlyPvSIxx
         ykDsbtx4jMoCQ==
Date:   Mon, 28 Feb 2022 23:53:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220228235356.5aca3e03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OJEnBt2I/y_=dGz3QYBoviK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OJEnBt2I/y_=dGz3QYBoviK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/mmap.c: In function 'do_mas_align_munmap':
mm/mmap.c:2375:25: error: implicit declaration of function 'munlock_vma_pag=
es_all'; did you mean 'munlock_vma_page'? [-Werror=3Dimplicit-function-decl=
aration]
 2375 |                         munlock_vma_pages_all(next);
      |                         ^~~~~~~~~~~~~~~~~~~~~
      |                         munlock_vma_page
mm/mmap.c: In function 'do_brk_munmap':
mm/mmap.c:2908:17: error: implicit declaration of function 'munlock_vma_pag=
es_range'; did you mean 'count_vma_pages_range'? [-Werror=3Dimplicit-functi=
on-declaration]
 2908 |                 munlock_vma_pages_range(&unmap, newbrk, oldbrk);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
      |                 count_vma_pages_range

Caused by commits

  a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
  34b6792380ce ("mm/munlock: mlock_pte_range() when mlocking or munlocking")

interacting with commits

  99f86dff3df6 ("mm/mmap: Change do_brk_flags() to expand existing VMA and =
add do_brk_munmap()")
  04552dc1edc5 ("mm: Remove the vma linked list")

from the maple tree.

Given other feedback about the maple tree, I have dropped it for today.

I am not sure what effect this will have on Andrew's patch series, but
I guess I will find out shortly :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/OJEnBt2I/y_=dGz3QYBoviK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcxeQACgkQAVBC80lX
0GxRxAgAmyNS+HPACkW65UElfO7sYYMvsMKorjpvCvznGT9nlwCdloOuzG7OJ5Nm
erC/OrmAZdzRMnEqKce0PGqvknm/kw/YKNa7K5LECg7kH1XhrR5fQThIdYxRRjCD
+dx0ooSt3cSFMKoc9gXU0afxiz1SI+vAdtmw94Xyrivd4FjD+Su1BdoaXsadey1P
k2/uX4HBrU9PQnzAfJa16fU7ZsH/n/QjXrge3naUExWXsDSdwfvo0rRh53Q/JpUl
1dI4Dm/3UYbwtVtTC/NTJwBLDKybs7OtLCyOgRnzBBh4ewQoaU2IjvmoQsHIk+0V
jWnVZT0jCPRrjl4Mxyj/XxStxfsjFA==
=uIy/
-----END PGP SIGNATURE-----

--Sig_/OJEnBt2I/y_=dGz3QYBoviK--
