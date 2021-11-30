Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3D462DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhK3Htq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbhK3Htp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:49:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B05C061574;
        Mon, 29 Nov 2021 23:46:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3Dmw6pcSz4xR7;
        Tue, 30 Nov 2021 18:46:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638258385;
        bh=IRJ88mg4Dj0bG6EbQHSHF+i5Z5NAYf6YkaS9fWv0Txg=;
        h=Date:From:To:Cc:Subject:From;
        b=m2EbPr33VrCs6TfSz6ftDcLzMhrsdxJRhMUMrK5B8AZyHLC26LFuU+doOI/j5kXWV
         7MpyuhpqHlS0LUTTjvWg5Yx9oQ8In8SVkc1p8iyb7pBy94sijteLzFaHgy1RoinEHf
         FAKIzRzJC0y6mzJzSZa/I/pf7ONbjC5K061Er1xHTGQggjtAn3AcwshjpD5OgWsRWN
         5NU7/Q2mFnANArra2UhV0lrPlOZnkjlYfK1EcQNmWqlCZMjAciLVkpahpmKtH7p0AV
         oaVly3oOMlnW+piB3n6Rr78keS1fkBzoArsFrlGWbFNS9Zeff+4hy/Z8WgbDfqUDV3
         mUfIg5LbukFRA==
Date:   Tue, 30 Nov 2021 18:46:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the akpm tree
Message-ID: <20211130184622.71be17e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sz3UtG29bHJ50Xq9dByJzGA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sz3UtG29bHJ50Xq9dByJzGA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next boot test (powerpc
pseries_le_defconfig) failed like this:

[    0.025828][    T0] pid_max: default: 32768 minimum: 301
[    0.028445][    T0] Mount-cache hash table entries: 8192 (order: 0, 6553=
6 bytes, linear)
[    0.028636][    T0] Mountpoint-cache hash table entries: 8192 (order: 0,=
 65536 bytes, linear)
[    0.055344][    T0] BUG: Unable to handle kernel data access on write at=
 0x2000000b7
[    0.056649][    T0] Faulting instruction address: 0xc00000000057435c
[    0.057458][    T0] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.057734][    T0] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUM=
A pSeries
[    0.058250][    T0] Modules linked in:
[    0.058816][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc3=
 #2
[    0.059410][    T0] NIP:  c00000000057435c LR: c000000000577f54 CTR: 000=
0000000000003
[    0.059608][    T0] REGS: c000000002787a80 TRAP: 0380   Not tainted  (5.=
16.0-rc3)
[    0.059999][    T0] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  C=
R: 44000288  XER: 20000000
[    0.060654][    T0] CFAR: c000000000574464 IRQMASK: 0=20
[    0.060654][    T0] GPR00: c000000000577f54 c000000002787d20 c0000000027=
88500 c00000000252d5e8=20
[    0.060654][    T0] GPR04: c000000000e42500 c00000000252d5e8 00000000000=
00000 c0000000073a02c9=20
[    0.060654][    T0] GPR08: c000000000e42380 c000000000f89d48 c0000000027=
4f700 ffffffffffffffff=20
[    0.060654][    T0] GPR12: 0000000000000000 c000000002970000 00000000000=
00000 0000000000000000=20
[    0.060654][    T0] GPR16: 0000000002bf00d0 000000000135bfd8 00000000000=
00000 0000000000000000=20
[    0.060654][    T0] GPR20: c00000000252d6e8 c00000000252d740 00000000000=
00006 0000000000000000=20
[    0.060654][    T0] GPR24: 0000000000000000 0000000000000002 c0000000026=
62eb8 c00000000252d5e8=20
[    0.060654][    T0] GPR28: 00000002000000b7 c000000001004108 00000000000=
00000 c00000000252d5c0=20
[    0.062938][    T0] NIP [c00000000057435c] count_subheaders.part.0+0x9c/=
0x2b0
[    0.064395][    T0] LR [c000000000577f54] __register_sysctl_paths+0x64/0=
x320
[    0.065201][    T0] Call Trace:
[    0.065521][    T0] [c000000002787dc0] [c000000000577f54] __register_sys=
ctl_paths+0x64/0x320
[    0.065960][    T0] [c000000002787e40] [c0000000005782a4] __register_sys=
ctl_base+0x34/0x50
[    0.066570][    T0] [c000000002787e60] [c0000000020259bc] sysctl_init_ba=
ses+0x34/0x74
[    0.066960][    T0] [c000000002787e90] [c000000002041744] proc_sys_init+=
0x54/0x68
[    0.067306][    T0] [c000000002787eb0] [c0000000020410dc] proc_root_init=
+0xb8/0xdc
[    0.067763][    T0] [c000000002787ed0] [c0000000020044fc] start_kernel+0=
x838/0x8cc
[    0.068171][    T0] [c000000002787f90] [c00000000000d39c] start_here_com=
mon+0x1c/0x600
[    0.068782][    T0] Instruction dump:
[    0.069295][    T0] f821ff61 eab40018 2c350000 418201c8 e9350000 2c29000=
0 4182020c 3b000000=20
[    0.069694][    T0] 3a600000 eb950018 2c3c0000 41820198 <e93c0000> 2c290=
000 418201dc 3b200000=20
[    0.071747][    T0] ---[ end trace df5d37c8b563422a ]---
[    0.071967][    T0]=20
[    1.073058][    T0] Kernel panic - not syncing: Attempted to kill the id=
le task!

Bisected to commit

  f00ff38c1dfa ("sysctl: add and use base directory declarer and registrati=
on helper")

I have reverted that complete 6 patch series for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/sz3UtG29bHJ50Xq9dByJzGA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGl1s4ACgkQAVBC80lX
0GyV3gf/ZFtWmMGC9oDU/MB5bKEkOtAPvAwzthwNHmq4PXTrofnI8Xk80H7jr1yC
uDA7E/rSBTx9ssWwOqgaG1y9EpjYnKGp9RUsCJhpwdX9HP4elgKN9bkPprf1OvW+
QPZou749BCDMh3AIhYDivCenIZGd2BcGWDTxwhqY/4yf+uTP1T0Ji/TPCydsR/1M
TDfG9jBM5oBmXguRSLB7iijs0ASl3gpfK7lA/nY2jhwC5zNEYUproKJRGQZBnnDR
PZhJYLUVR9FnFRUAmVuKPCxhcDfH9Ek/pdmzlHc1dOR4bd1pSK9AdxJDMzQ3Ng3C
ONBNHLV3eNL7Y6qboCf0IdfWeJ6DUg==
=VRm7
-----END PGP SIGNATURE-----

--Sig_/sz3UtG29bHJ50Xq9dByJzGA--
