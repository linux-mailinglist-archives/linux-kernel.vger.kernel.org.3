Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEDF510D68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356483AbiD0Avl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiD0Avi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:51:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31F0443D8;
        Tue, 26 Apr 2022 17:48:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kp0VL3rtRz4xXW;
        Wed, 27 Apr 2022 10:48:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651020507;
        bh=dMk+4pPlzo6bmz2jtOMFc70rckCnX1jBMamqrO++5io=;
        h=Date:From:To:Cc:Subject:From;
        b=oyzqHe6i18VzYpgzctl5vja8PdpIEE0YXTqRtTxhsRsNDYKPlWg9s/I+ONrkLq1S8
         SJL0Qndm+9eXJuaB3G2F00uiV4VQPewLpImnaP7WjZAyJ/D+nx6/FMyCwddQjSrjdT
         3YIaYrscTaciC7K44ChLh9yv9O3mO6WXc/CQdF+/XhNS3M5qaWNRLJ/fpczO1o08Zd
         0qZNTeI1tHn521Wm06RxJfmW3AZYkRpTIVsxW3MdQoRWZRuOPH53/MIfMs7ZVX1pD+
         UEt3Jo/5F+J9L4I/EJrb7+KdlbPZ6nZIqqW53aHnZMQw7QYA7ElBzZalgk+MXFPJGx
         ErkjJ4BTu4yhA==
Date:   Wed, 27 Apr 2022 10:48:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the input tree
Message-ID: <20220427104825.15a04680@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/djBJ2_E+oJ90mkL9SpRNhZu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/djBJ2_E+oJ90mkL9SpRNhZu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the input tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATUS' und=
eclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
   93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
      |                                    ^~~~~~~~~~~~~~~~
drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of macro =
'MTK_PMIC_KEYS_REGS'
   48 |         .deb_reg                =3D _deb_reg,             \
      |                                   ^~~~~~~~
drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_MISC' =
undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MISC'?
   98 |         .pmic_rst_reg =3D MT6359_TOP_RST_MISC,
      |                         ^~~~~~~~~~~~~~~~~~~
      |                         MT6358_TOP_RST_MISC

Caused by commit

  0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")

I have used the input tree from next-20220426 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/djBJ2_E+oJ90mkL9SpRNhZu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJoktkACgkQAVBC80lX
0GxXDggAoRkJM8iK0vyIiHoZDSClWaAuuhUb4v48SE/X9c4PiikBf4xG7M7t0UKs
bgAAcFAEJRigXrTLKvIrTut+yZgtzyj0RXZC5eBtWnzuGuKl9ayU6h7YVZTX7/bQ
TWZgUbhLddAlUmp3OskQ9vKcWf2sAc0ubZv2gMPd8ccsJorcL2EhwehOhDXNzBM3
1sMeT3Dj385tH7nGrKKlzypxlX5F6JcOXvInDJ1ynENj8NszDehrpqAYPHNV5+c4
qzfafs/AyDBkUOHx+cRb7GXkSSFLwxkc4+0sGU5VYqtDcfxanjRvyDXqEs3PFj4v
xg+d2vPGr/qNOSYaJW4u+BMVwnRQbA==
=V2qk
-----END PGP SIGNATURE-----

--Sig_/djBJ2_E+oJ90mkL9SpRNhZu--
