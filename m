Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED179575A15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiGODwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:52:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF0774AB;
        Thu, 14 Jul 2022 20:52:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkcrK2Gvtz4xZD;
        Fri, 15 Jul 2022 13:52:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657857153;
        bh=NUSlK5LL8VwLPsQr8OytS3Qo6VM9VPQzWDZrNHjoa14=;
        h=Date:From:To:Cc:Subject:From;
        b=eM02OFd0T5ZnxrvMysWv+z5Xo/84pEJqU+cIWTT1GqKsZ3hvuoYWQmHkjftBiOX8P
         4E8XX62CvTMqz1Fc6ZW02KwwXI+8rXpSYBzzHrZk3kbJOUG0stc1c8IaBjFkGVizWV
         FOC492xvvqQ1BY1e0Z0h0Lwou6SJfBpk0AhIVD0VOs3vqMk2ynsUX9NRjo7KJKN0q9
         1EqZF066oaJT8NtARDb7kvY5ZSZu8ILJO07d6Zb/tc+FkQ9DrtZCijQg8wP9EYotK5
         V2rrTURHWqGByZA3SzlU6SINXJwq9r09hHDdUvcq/buw/7ToOw+z6SuT+eeWv8cjHV
         Kh22VJOLhgHuA==
Date:   Fri, 15 Jul 2022 13:52:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20220715135232.74b81bec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tiJe.Mn_Y=i_88joI3T4J=o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tiJe.Mn_Y=i_88joI3T4J=o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/linux/slab.h:16,
                 from io_uring/net.c:5:
io_uring/net.c: In function 'io_recvmsg_multishot_overflow':
include/linux/overflow.h:67:22: warning: comparison of distinct pointer typ=
es lacks a cast
   67 |         (void) (&__a =3D=3D &__b);                  \
      |                      ^~
io_uring/net.c:332:13: note: in expansion of macro 'check_add_overflow'
  332 |         if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
      |             ^~~~~~~~~~~~~~~~~~
include/linux/overflow.h:68:22: warning: comparison of distinct pointer typ=
es lacks a cast
   68 |         (void) (&__a =3D=3D __d);                   \
      |                      ^~
io_uring/net.c:332:13: note: in expansion of macro 'check_add_overflow'
  332 |         if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
      |             ^~~~~~~~~~~~~~~~~~
include/linux/overflow.h:67:22: warning: comparison of distinct pointer typ=
es lacks a cast
   67 |         (void) (&__a =3D=3D &__b);                  \
      |                      ^~
io_uring/net.c:335:13: note: in expansion of macro 'check_add_overflow'
  335 |         if (check_add_overflow(hdr, iomsg->controllen, &hdr))
      |             ^~~~~~~~~~~~~~~~~~

Introduced by commit

  a8b38c4ce724 ("io_uring: support multishot in recvmsg")

--=20
Cheers,
Stephen Rothwell

--Sig_/tiJe.Mn_Y=i_88joI3T4J=o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLQ5IAACgkQAVBC80lX
0GzHqgf8CaUfIbDDwCmPxUA7bVVMfaVuJI2aMf7zvq7xQWDDfgu16rX2CR4J5sIQ
/kCJsg1uk8n//A88lG6nPYLj+f7HL+SijhGFnUxQXSyxOyd3mKy7sj0gqcfabC0B
eRy7vtqj3jy0NPxpUJLMiiWeneWESBUj0KB+Jy8/wBsKfh4VTZWpM/1tqgLkzlC2
k4rS2LNl6n0UiK62caiqQBxwo19+yN87MCeKWJrKNs+2h6yGeTOPR97jjKLnnq9/
UsQZ75BgXTB/aShU8nOk6NnicQPaCZnUqHTdILj1TOicCyqEKYvjTsSPUhdGylix
KA1DwYRF5ZUnz5kxecBtN7aCDudFGQ==
=fxVZ
-----END PGP SIGNATURE-----

--Sig_/tiJe.Mn_Y=i_88joI3T4J=o--
