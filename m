Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F564D98B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbiCOK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiCOK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:27:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498764506D;
        Tue, 15 Mar 2022 03:26:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHqLp758Jz4xLQ;
        Tue, 15 Mar 2022 21:26:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647339971;
        bh=DnIf4+KzBYCXCr77sCmro4W9111SzEmHH+XVf6G2kXg=;
        h=Date:From:To:Cc:Subject:From;
        b=KFeYif+UtYtvMMn6VWssI8QIuN+TAbCrTuXNBQqgfG2VwT0MCDQ45Co0d5bVCgd17
         nGhWXItLXi5J1gOka+nhL99TNlCHR8iOgbi8Nrur7drLvulN6TjxnK7qa2soWXVQs9
         TeZSY0UAG8rMyCb2tYwFuzROdgDByIzl5dvwSwVddu2DNkvRU0Byt3NcD2Mz6iu/OL
         SNhemqna8GEIOB48c4XViyiL48a54ZIjP/6VsAvrw2jkcBz4hjTLHfE1jS5zmI+Nzm
         Bi3FZg5WWDfCxmTr362khDAmSwCthJujqEIe8RzaoIlwxEW4v6Ti2dWt9rWEwzTh2X
         tSuwrssY8MQtw==
Date:   Tue, 15 Mar 2022 21:26:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220315212610.0f996842@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h6xFeX791JGavsaFW91kBqU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h6xFeX791JGavsaFW91kBqU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

mm/readahead.c: In function 'read_cache_pages_invalidate_page':
mm/readahead.c:54:17: error: implicit declaration of function 'do_invalidat=
epage'; did you mean 'd_invalidate'? [-Werror=3Dimplicit-function-declarati=
on]
   54 |                 do_invalidatepage(page, 0, PAGE_SIZE);
      |                 ^~~~~~~~~~~~~~~~~
      |                 d_invalidate

Caused by commit

  f1fdabbaae8e ("fs: Turn do_invalidatepage() into folio_invalidate()")

I have used the folio tree from next-20220310 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/h6xFeX791JGavsaFW91kBqU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwacIACgkQAVBC80lX
0GzIKgf/S0YBkWV0/HqG8kYmfG4CemI4Ta2XCWBX0aH/ClwpWKKBiDXnVRia7T+f
Rmh96NYuxApbsEtShZ4wrX7pkFkzLbkRYbc9diI5+2u/lhIrmT6MJ+QjPlEmLeLe
XRNRPlKap7hpDKMUMvCSaAIMzp8Hvy4rIR9eQCwhWve/ViyBqquKcncC27vexgMS
9oC1MD//dxicI0DnarhuQ/Dn3gUpas/t5eGMunZYRptSsWe+/KvvVDVXycQIjwFb
HaLTfuCakG3vqp1BEk/uiBseSHKPhCjsD9gZ5Ae8rN7eDLn1koMOTZKoEksQzOCy
qV69Y/L9uYx85dSwYBqQnq3zfRwcFA==
=hzBH
-----END PGP SIGNATURE-----

--Sig_/h6xFeX791JGavsaFW91kBqU--
