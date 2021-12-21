Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539AE47BF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbhLUMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhLUMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:16:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85DC061574;
        Tue, 21 Dec 2021 04:16:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJFmX5MKzz4xmt;
        Tue, 21 Dec 2021 23:16:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640088973;
        bh=1z2SwME5Aku2UNRpHEs9HfjiN4612fvj2KO0CU/gLZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=KiKkw5AkjqUz5Uwm+B85zBd92j8ZIglBHPR+inJwY5YFf0iIVjZpak7rl946TTxOd
         s839cWVU+gd9qBcKLd+kBIUHqvPLfoBmWSuy8N4L9to+m9lUkOHgSx9MfDlceh2mHH
         7I7vzcUHLvQm7pzXKAC7jIV5oz0WiI/Dh9rMpJf9p+P+Yk769/zMmUOrf4pqSZQDoY
         gPdw4Q5q95eOV6EQcrcc6IK0kKS0Di3CvDFGqCgjFf271uExv+ka1ZCZkzGizw/dDh
         BFFe/7djYbkPufS/4CqwrqUlrrp5bJCAMO5NDMt1sChRuANnSZzd6owU9E39emrUqH
         VcXcshlM9ufBA==
Date:   Tue, 21 Dec 2021 23:16:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: run time warning after merge of the userns tree
Message-ID: <20211221231611.785b74cf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4uD7FicQV8yBT7I4oCRdziU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4uD7FicQV8yBT7I4oCRdziU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[I am just guessing at the userns tree.]

My qemu boot test of a powerpc pseries_le_defconfig kernel produced
this warning:

  SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
  ftrace: allocating 33453 entries in 13 pages
  ftrace: allocated 13 pages with 3 groups
  trace event string verifier disabled
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:9469 sched_init+0x45c/0x4f4
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.16.0-rc6 #2
  NIP:  c000000002027c98 LR: c000000002027c94 CTR: 0000000000000000
  REGS: c00000000278bb80 TRAP: 0700   Not tainted  (5.16.0-rc6)
  MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 84000220  XER: 000000=
00
  CFAR: c00000000016c1fc IRQMASK: 1=20
  GPR00: c000000002027c94 c00000000278be20 c00000000278d300 000000000000000=
1=20
  GPR04: c000000000f88788 c000000002865d98 c000000007070680 000000000000000=
1=20
  GPR08: 000000007dae0000 c000000007070630 0000000000000000 000000000000000=
1=20
  GPR12: 0000000000000000 c000000002970000 0000000000000000 000000000000000=
0=20
  GPR16: 0000000002bf00d0 c0000000027c1f38 c00000000017e510 c000000002867f0=
0=20
  GPR20: c0000000025306b8 c00000000017b520 c00000000017b200 c0000000028682b=
8=20
  GPR24: 0000000000000400 0000000000000000 c0000000027c2470 c0000000027b3a0=
0=20
  GPR28: c0000000021af900 0000000000000800 0000000000000000 c00000007fc8f90=
0=20
  NIP [c000000002027c98] sched_init+0x45c/0x4f4
  LR [c000000002027c94] sched_init+0x458/0x4f4
  Call Trace:
  [c00000000278be20] [c000000002027c94] sched_init+0x458/0x4f4 (unreliable)
  [c00000000278bed0] [c000000002004200] start_kernel+0x53c/0x8cc
  [c00000000278bf90] [c00000000000d39c] start_here_common+0x1c/0x600
  Instruction dump:
  90ea0188 f92a0180 3d22fffb 39291890 39490050 7d005028 31080001 7d00512d=20
  40c2fff4 e86d0908 4a144499 60000000 <0b030000> a08d0008 e86d0908 4bfff849=
=20
  ---[ end trace 0000000000000000 ]---

Exposed by commit

  40966e316f86 ("kthread: Ensure struct kthread is present for all kthreads=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/4uD7FicQV8yBT7I4oCRdziU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHBxYsACgkQAVBC80lX
0GzZjgf+I10ffk6B+zKRHQ3My2mJIzY8paFnofu1ZtjHulspRya3djQ3fJaWc6/m
8hhmBXx3EC1LjZ/UGE/aVJZrVJV4OUl5KA4Igvca5Qe7CjpG/l0jqTIvL2IUiSCG
gejkDZCpBA0vk31SndzAD3WVtjinZiBvcd+4F6CK/aBVNykwWla7xZba1Wkndp0p
r+XboFq/Mi8THNpwkNdV4EokaHefhuBuHHNQk+t76pGQILJ/46YgPrn80egaRqOQ
2TcTIpvkSG92xVhGC6ouX9VACFvYKPrtNkXvp6kF68LIiNtJAntIsTG7artukofJ
z8wikqxR6dKcfq6bmrBpZmUMzPJyyQ==
=Siq0
-----END PGP SIGNATURE-----

--Sig_/4uD7FicQV8yBT7I4oCRdziU--
