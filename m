Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6749A828
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316687AbiAYC60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:58:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50179 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415164AbiAYA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:58:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjT3q0XSKz4xNp;
        Tue, 25 Jan 2022 11:57:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643072279;
        bh=f3nUSDyey+3emcvOFkTIpsD48NeCC0JpEvrTdXnbHP8=;
        h=Date:From:To:Cc:Subject:From;
        b=RnaYgb9Nr+gkbn/N2LHSY3O5bGhTKez+ktdy6lt/XryTllaTxSsOaj3Hl1YfqJN6Y
         0LBHL7CcjaU/F/33nP8ZpfBWzYuSXiedrTPl+Gg4ayhHn9doCs/InvlRKTFu5VvOYI
         py6MNsANyDR0rCbB7Zory7W4hBzLTN7AhxMOptCrc4l7C1a0eP4hWpCbD1FK41ORY3
         MgSq21hkI63cbgDfZrCLJWZ3P8pT7/WBWXazSJEd/gqHMwFWO+1TBcIR5YDTD26q48
         6hhay9bLYH12Iw67zk8sQNFCNPifFioNj5hpUN0Xm2w9ja/XEo7d67L4kCldRffPZ2
         t6VABksOW+Deg==
Date:   Tue, 25 Jan 2022 11:57:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>, David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Omar Sandoval <osandov@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125115757.20bc45e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mWXtgt44xfe97I9Ky8aKrVT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mWXtgt44xfe97I9Ky8aKrVT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from arch/x86/include/asm/cpumask.h:5,
                 from arch/x86/include/asm/msr.h:11,
                 from arch/x86/include/asm/processor.h:22,
                 from arch/x86/include/asm/cpufeature.h:5,
                 from arch/x86/include/asm/thread_info.h:53,
                 from include/linux/thread_info.h:60,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/wait.h:9,
                 from include/linux/mempool.h:8,
                 from include/linux/bio.h:8,
                 from fs/btrfs/ioctl.c:7:
In function 'fortify_memcpy_chk',
    inlined from 'btrfs_ioctl_encoded_write' at fs/btrfs/ioctl.c:5082:3:
include/linux/fortify-string.h:316:25: error: call to '__write_overflow_fie=
ld' declared with attribute warning: detected write beyond size of field (1=
st parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
  316 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/fortify-string.h:324:25: error: call to '__read_overflow2_fie=
ld' declared with attribute warning: detected read beyond size of field (2n=
d parameter); maybe use struct_group()? [-Werror=3Dattribute-warning]
  324 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  602670289b69 ("fortify: Detect struct member overflows in memcpy() at com=
pile-time")

interacting with commit

  504e1ebb6316 ("btrfs: add BTRFS_IOC_ENCODED_WRITE")

from the btrfs tree.

I applied the following hack:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jan 2022 11:47:17 +1100
Subject: [PATCH] fix up for "btrfs: add BTRFS_IOC_ENCODED_WRITE"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/ioctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 73ad918a05a9..d34620034f8e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5079,9 +5079,14 @@ static int btrfs_ioctl_encoded_write(struct file *fi=
le, void __user *argp,
 		}
 		args.iov =3D compat_ptr(args32.iov);
 		args.iovcnt =3D args32.iovcnt;
-		memcpy(&args.offset, &args32.offset,
-		       sizeof(args) -
-		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
+		args.offset =3D args32.offset;
+		args.flags =3D args32.flags;
+		args.len =3D args32.len;
+		args.unencoded_len =3D args32.unencoded_len;
+		args.unencoded_offset =3D args32.unencoded_offset;
+		args.compression =3D args32.compression;
+		args.encryption =3D args32.encryption;
+		memcpy(args.reserved, args32.reserved, sizeof(args.reserved));
 #else
 		return -ENOTTY;
 #endif
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/mWXtgt44xfe97I9Ky8aKrVT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvSxYACgkQAVBC80lX
0GwcMAf/Uzc/nOW403lZ3BYhmmg5KZfP7Or66ER6ha2sNYSk49gJywjWh+mOnNNn
tcsHBMMY6Sc6fpSdx/fWrblFXkd1uEkURwJXDkpMAwGFEcqoNhu4mgKQ3QhDZGgg
UUrj5L4xAwwKrQgP6S0v4qYssePA3R9+dJnmanfcQVGKuZWno2X7xI9GT8avUYnn
gldlJGatHzSJRYpTj0dZ5E+5DFmsp8x0ZYZWWJtbQufnq2O2WEUFTWtL6l4+ZHq3
yBW4z960YKrJq0m8S0t/d1rmBYeECsNMoVVx5RV/7eXOIpHyLcG+BvtpVRoNElmi
6kNEEmHQQEf9owTgvXAcvj9/jcHLiA==
=0n8w
-----END PGP SIGNATURE-----

--Sig_/mWXtgt44xfe97I9Ky8aKrVT--
