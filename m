Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DEC581E87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiG0EJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiG0EJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:09:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD12E9CA;
        Tue, 26 Jul 2022 21:09:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lt0f01pRwz4x1b;
        Wed, 27 Jul 2022 14:09:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658894952;
        bh=HdMybXKiD136ksZcJduRwx5J+ELUOOdg7AtPYNgYzMg=;
        h=Date:From:To:Cc:Subject:From;
        b=uDVutVSlXJ/OIo2VLBBSDWX/Ar3Vtu5A+EvRdCSChQyp4kHlsohqpAvSkVzzimAlg
         EyZ8ZsMrXZAenQd0iZygTlK8MWnax/4v/iVc1S4Z0WpBo+07wyFLflDwHSMmaoykFN
         prjpYBdh/j4XNKp7Dgx8arkWXoQLzrAWpr4YG6jtmwxBFUD186gl4NznCyv/gN59cv
         W9ihorRHgwVOhmhad8hDkoGzCmNKCKYEttQUsuKvZqLXrCM8sTkqwmX/ySj91HyoBe
         TaZZzy0f8U36BhShUW/hql5Q0DZIPKKu7kOjvzasxpbcwNUhPorL5+J51yPJJDE6ro
         HQMI37ys+qtYg==
Date:   Wed, 27 Jul 2022 14:09:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220727140910.172a91c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p_29Og4caOb4/bwF=FeFjcE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p_29Og4caOb4/bwF=FeFjcE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/kernel.h:20,
                 from io_uring/notif.c:1:
io_uring/notif.c: In function 'io_alloc_notif':
io_uring/notif.c:52:23: error: implicit declaration of function 'io_alloc_r=
eq_refill'; did you mean 'io_rsrc_refs_refill'? [-Werror=3Dimplicit-functio=
n-declaration]
   52 |         if (unlikely(!io_alloc_req_refill(ctx)))
      |                       ^~~~~~~~~~~~~~~~~~~
include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
io_uring/notif.c:54:17: error: implicit declaration of function 'io_alloc_r=
eq'; did you mean 'xa_alloc_irq'? [-Werror=3Dimplicit-function-declaration]
   54 |         notif =3D io_alloc_req(ctx);
      |                 ^~~~~~~~~~~~
      |                 xa_alloc_irq
io_uring/notif.c:54:15: warning: assignment to 'struct io_kiocb *' from 'in=
t' makes pointer from integer without a cast [-Wint-conversion]
   54 |         notif =3D io_alloc_req(ctx);
      |               ^

Caused by commit

  fbe6f6bc3210 ("io_uring/zc: notification completion optimisation")

I have used the block tree from next-20220726 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/p_29Og4caOb4/bwF=FeFjcE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLgumYACgkQAVBC80lX
0GyNWgf+OI+2JKDjxr2l5G0pCbqFpaW6pdCad4Hjnt4NkTRa5XyjUPkJEHCqMWHF
UGI5Mn5dwHFr6JMra95dXduwxRfbrU1ARAl92OFbVxjc/AbcviXtILSVeO7AQWx+
jHMrHWvGoytG2bNh/C1d9G6jcC8urQBb1YdxXcAPd8ciIizsp/gUn+693FTOW/PJ
Kvj0AKqbvMATlbNsA7RJxBm5ZMUeKN34rZzVjBeagfVzKsBReEjF/9lvSm6Ig/qc
H5HjKE0PgKWHKQia2DyUs9G38h5aDtx5a+mYVU4PfaPt020pXTONqFVnmuE+cMTS
gDWeE82//Oq1MwQnzNmhckO6YVpeMQ==
=l2Wu
-----END PGP SIGNATURE-----

--Sig_/p_29Og4caOb4/bwF=FeFjcE--
