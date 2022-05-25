Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5890533696
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiEYFyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiEYFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:54:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA77703F1;
        Tue, 24 May 2022 22:54:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7Ky22gWVz4xXg;
        Wed, 25 May 2022 15:54:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653458042;
        bh=ZYZjtncWfP80TnvO3PP6HzClE/DFLLWh39fbHLacpM0=;
        h=Date:From:To:Cc:Subject:From;
        b=X37uahJMcNajEqg9oNBpl8CSRhujRbTzqelJJL6yE5lRcirUYGiCs/e1Fj3YEriGX
         7dCyxiS6CtWu70bHWuNfejz0cq+S5lkk7v/jZTiSRlwEb/GtFgyS94xgPraurxAyMg
         eQaQ5wzbe9ww5enQwG61E1rxbj0uehAImLXMrFogFFTlK6LZjKosrkxh5esf7EMHw3
         sFp9MYKsROrhoMH1fiMjScMrrtfZXq9EEyltoQA3M1fGuZKF/HI6Is7wBwipktivyt
         i1R8yrsXREQZWdnhxrUAhxWuB94FWKFVBbbVf8lVhmXG2Vi08QMNDAu7mqSG1V0gIS
         nbVEW1i5dB/ow==
Date:   Wed, 25 May 2022 15:54:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220525155401.4a72ad6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p47KAp=X2rUrBmKDYgqim=L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p47KAp=X2rUrBmKDYgqim=L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc64 defconfig)
produced this warning:

In file included from include/linux/kernel.h:26,
                 from include/linux/cpumask.h:10,
                 from include/linux/smp.h:13,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:62,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:6,
                 from include/linux/mm.h:7,
                 from mm/page_alloc.c:19:
mm/page_alloc.c: In function 'split_free_page':
include/linux/minmax.h:20:35: warning: comparison of distinct pointer types=
 lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                   ^~
include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
mm/page_alloc.c:1138:35: note: in expansion of macro 'min'
 1138 |                 free_page_order =3D min(pfn ? __ffs(pfn) : order, _=
_fls(split_pfn_offset));
      |                                   ^~~

Introduced by commit

  29a8af92b874 ("mm: fix a potential infinite loop in start_isolate_page_ra=
nge()")

--=20
Cheers,
Stephen Rothwell

--Sig_/p47KAp=X2rUrBmKDYgqim=L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKNxHkACgkQAVBC80lX
0Gx4Bgf/fgDGYlI3+zGK6/1/HwSaVZ8hZL3yS1wsvFbWqEd4qLoqKLa54ROAyOZN
2MgoYiJbhJIEzib+qQ5zPk8P1at26TB+z2NdRWyMp4CPjkc1bBohGKwyiN4ztKXj
Q/miuywV5Am0gWgYO7ddisZ5ivxjvVFXnWVFTB79IvYDnatUgfU94nq7WPNytudQ
VKesXGr9GNcHlqvT5mPZ4aj20tVRcL96KKHN5nE35N3wPA1zPLmuk9D/yb2pTLYf
DKWQEryiKAtePxwCnXT/VIODAVcUh40YTVkQ/m/fK6a50x3YRZwgqu/CoeBoGocK
jhAb7u7XhqHLPSdkXUM10W2h5p0mIw==
=NJNq
-----END PGP SIGNATURE-----

--Sig_/p47KAp=X2rUrBmKDYgqim=L--
