Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5C5307CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353137AbiEWCta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiEWCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:49:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962C36E1D;
        Sun, 22 May 2022 19:49:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L61xt02W1z4xD8;
        Mon, 23 May 2022 12:49:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653274162;
        bh=8vRrqTTTdaOdgjSyiFkBry6La19dq3qrUOHOFmITwwM=;
        h=Date:From:To:Cc:Subject:From;
        b=kQjXVig3BrrDkctZY3mC0Pl/OEc/TcXgNDjlPgSAGT+ikHn40yxT5TjYmNiTRJHYp
         6MiWA+DMhyw44xRHAw/a5kOrmeKWak0P8M/6d7gwRLVPgwBTybMtaexhl5Co8O0rZa
         Rw1AbNXBvF5f9GFBkMcrmtagi6boTUZH0Pxpx1Gl4iHp97eOVW7Y55RfuHJLw2sVMg
         328/J/i4mb3r6H0hlakmo0u4NnhnliZrvDSyIsdl50WsqAaaYg5g0tvV90WS/G/dzC
         WmtLwcarJ+hn+o7+rLa988v6crud0gzhyf26tRg7fLmyZ7fDGl6YHQqH9xqDOxQ/yB
         Llnz8tqGW+OOw==
Date:   Mon, 23 May 2022 12:49:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20220523124921.7d6bbf34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZtyPrewlH62vDJ+OMJGI0ml";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZtyPrewlH62vDJ+OMJGI0ml
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/md/bcache/btree.c: In function 'bch_btree_check':
drivers/md/bcache/btree.c:2073:1: error: the frame size of 2184 bytes is la=
rger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
 2073 | }
      | ^

Caused by commit

  c766acd3d78e ("bcache: improve multithreaded bch_btree_check()")

struct btree_check_state is very large to put on the stack :-(

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZtyPrewlH62vDJ+OMJGI0ml
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKK9jEACgkQAVBC80lX
0GwF2wf9HjrIEdKFVp9p1ny33ibl0ftizJ4Z9NUW2D4hkeGZr7i8LWMnwPA6dW+u
DvHyu1oHT5AQZdPdOYzI/ScSy9MMs74ApxYJja7x+JQAfZ4pdhKXLQjk1GAav32e
ndFUyn9aeczJGtUj4ktQZzgKVqFKzwzToTP/AwQW16gQHnoWucn+wK7V4gBQo+kp
2Q7jz1FonSknbSdjQ7j+A2zCyjt19nJdN/GjdIBZuMv3wbLB6+dWpHLp1rRE7wHH
HOk7uPqlLgnrk5EbRYR5LD3dRWN9IKCQ/u50e8RSyfO/RH+yvus1twnYgba4JQvD
9QdOvNftaO9qPuQqw1fG7jp+QwzA2A==
=2S6x
-----END PGP SIGNATURE-----

--Sig_/ZtyPrewlH62vDJ+OMJGI0ml--
