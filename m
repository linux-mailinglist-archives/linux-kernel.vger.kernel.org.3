Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E34B8306
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiBPIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:32:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiBPIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:32:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14842BC0;
        Wed, 16 Feb 2022 00:32:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzB5Z5jMNz4xcl;
        Wed, 16 Feb 2022 19:32:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645000323;
        bh=ufGu8A2k/MSBln0FGlqpfyxF+26NIwv8r7qMB2Q71QU=;
        h=Date:From:To:Cc:Subject:From;
        b=RiE688Asfp+eyy25fijQPwjKU7zeXAk0f/Zsz1XCozeDjdl7s5VznqrOHjkxr3zbw
         zDCupc1fPLO/vQKtzY9W9pteV77iSapZ5A6a5FN3m/KFG1lcPzHtvfxknNUAMGBfpa
         2SnMWRfchQVeEDLkV/up/e4Vs+J+s0v0PywJdUyE96C5eJYhTt8Xf1qhiSBuLBPnAu
         VeCMbLBjRk77xSpdTOYqMZ/Uhtgo4DThLpGcTzbfBOMwiRwVL9P78B+G+eWOdAad3D
         4DstD+Fb90HcSPUcd5eQX2fiAGiGT/UGSo4KeVUhR5uG429eQuiM2KQ7fQxTgizNu4
         1zELQXDczHp5A==
Date:   Wed, 16 Feb 2022 19:32:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sujiaxun <sujiaxun@uniontech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot warning after merge of the akpm-current tree
Message-ID: <20220216193202.28838626@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MyW5A9bQuF.s/kacwfWEYnM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MyW5A9bQuF.s/kacwfWEYnM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next boot tests
(qemu powerpc pseries_le_defconfig) produced these warnings:

  sysctl table check failed: vm/=C3=B8Ie^B Not a file
  sysctl table check failed: vm/(efault) No proc_handler
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4 #3
  Call Trace:
  [c0000000073e39d0] [c0000000007b8370] dump_stack_lvl+0x74/0xa8 (unreliabl=
e)
  [c0000000073e3a10] [c000000000577ecc] __register_sysctl_table+0x60c/0x9f0
  [c0000000073e3b20] [c000000002043ea4] __register_sysctl_init+0x40/0x78
  [c0000000073e3b90] [c00000000203583c] oom_init+0x6c/0x84
  [c0000000073e3bf0] [c000000000012130] do_one_initcall+0x60/0x2d0
  [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
  [c0000000073e3db0] [c000000000012730] kernel_init+0x30/0x1a0
  [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
  failed when register_sysctl vm_oom_kill_table to vm

Caused by commit

  5c4a1da27403 ("mm: move oom_kill sysctls to their own file")

I have applied the following fix patch for today.

=46rom b6c6a58898ebf468ae042b3481dccd73db32c2a9 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 Feb 2022 19:20:20 +1100
Subject: [PATCH] fix up for "mm: move oom_kill sysctls to their own file"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 07ff90c920bc..9787e2cc51b5 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -80,7 +80,8 @@ static struct ctl_table vm_oom_kill_table[] =3D {
 		.maxlen		=3D sizeof(sysctl_oom_dump_tasks),
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
-	}
+	},
+	{}
 };
 #endif
=20
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/MyW5A9bQuF.s/kacwfWEYnM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMtoIACgkQAVBC80lX
0Gy7jQf9HNCUXnBzl1Q4/dJdcTTP6jkgOX2h5cK/hAqZ37MXQTujrZ1bxFRdy6nk
CX9Q9lqoNAjDLr7p92fzN392VkPvEw2LJQCVdXBivDfl4VsZW9lqxtyD1RnNkXiE
M0NrZsqHAlAsT85LGPd4tN+SVzN3/5PARBfO3awDroi8vi0Pl/rkGjQoSZz5OEMa
uSMK+jYBvP+hN4jOHjK1rlSv+bJXiLPwWpZibxd6AL0JzIiab0fIYhvs4nSvwn6d
G646Lw4+2sCRT5hkUJWVYIMlL96YHJWaEA14DRcmx+7zUC8LP4ew9bOUyHWvYR31
IMRY/4Q+FZ/zJ7npU/KEqu0vQK06sA==
=lcTu
-----END PGP SIGNATURE-----

--Sig_/MyW5A9bQuF.s/kacwfWEYnM--
