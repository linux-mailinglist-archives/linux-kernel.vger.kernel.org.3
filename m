Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01385A2175
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiHZHKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbiHZHK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:10:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892569FE9;
        Fri, 26 Aug 2022 00:10:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDWFB6HCGz4xDB;
        Fri, 26 Aug 2022 17:10:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661497823;
        bh=D+/iLaa6H3WpuuFlEI1h7i9kslU9mWhl3oJwRjhaFbA=;
        h=Date:From:To:Cc:Subject:From;
        b=Pl1wHrL1X+J/6AUUTr4RvDnqDP23RXFE08dHv0HJYVLtMM6SZvHdjMHM0vKD1VDvd
         FaEHdM3QTxGdoP7jGcxMasziyuzDxGwd1vQUXVN8WDlTts4/bikDxdpYUR6Ovqi231
         SvzrIpQkBDljyTpndonrYWN5lBb69OZwtDXs9JSQphKZC0yyp0qN5dCIKYPmHMg8gd
         BTyJ45cUXjOdxCYshMczxI9DHUbsBJK9ag+srphepmpHjZTwK2oXgJn/xBm7arwj2d
         IP00hbagfQt++2pd8MSjF7nP2A7wep6evPrxvofONws5PoNHSzXqpsJuUqRAT+1CSf
         ndLi9n3gqRzDA==
Date:   Fri, 26 Aug 2022 17:10:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220826171020.5772e600@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/opxvO9zRt8XjfN2.HWoyqVY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/opxvO9zRt8XjfN2.HWoyqVY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/xmon/xmon.c: In function 'cmds':
arch/powerpc/xmon/xmon.c:1089:33: error: too few arguments to function 'sho=
w_mem'
 1089 |                                 show_mem(0, NULL);
      |                                 ^~~~~~~~
In file included from arch/powerpc/xmon/xmon.c:14:
include/linux/mm.h:2585:13: note: declared here
 2585 | extern void show_mem(unsigned int flags, nodemask_t *nodemask, gfp_=
t gfp_mask);
      |             ^~~~~~~~

Caused by commit

  9ea9abc5cd7e ("mm: reduce noise in show_mem for lowmem allocations")

I have reverted that commit for today (and the following fix).

--=20
Cheers,
Stephen Rothwell

--Sig_/opxvO9zRt8XjfN2.HWoyqVY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMIcdwACgkQAVBC80lX
0GzCMwf+PnWcLkXisg6lJpJbV21L74GRxm2EH9N/g9QNeNbx0fr0z3X87m7yOw5Q
YNil6x/XGP7u/bHAM3b8UM0jep/0LZtWiTiIC2FwrGcsbZE+AtU/w0dytzYHPgvE
BvEKZwWcjEvv2TlgxgWjmZV1RP/KyNf+h0Omm6oy1r7qyK8uRb7ovv7G4eovKIra
9d9+3c20MH/KqU/BG4VINUdpfbnC2EDWq7hzsmc0gdNHfzbYWSIM8O3OvwvEIrH3
E4AMmf0+QY3BwHunRsdDYUwzHCuM0IOtzDwKn0CUwVYL7+JknkrjmWHOcU2rf0AD
JZYgYHhDQ5XTB/dBmAcGGakroDvhXA==
=OSep
-----END PGP SIGNATURE-----

--Sig_/opxvO9zRt8XjfN2.HWoyqVY--
