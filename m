Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F5463BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhK3QZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhK3QZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:25:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D37C061574;
        Tue, 30 Nov 2021 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=yT5Ve3laIDiiQ14A0WrYsr3gkg1tox13wDMRqv3TQdA=; b=N5k07lqWyHdIxvr5mi8SH7zcuw
        bvu3gbDUoW8LyA+qSIx8TjQFn0l/0kGiwqZkXWBNPeRFMjrJyJgPILYnW5GR5mRdTDCiN+q1oIeEq
        2/9uPRgP9pD4S5K4ceQjbIJ0VEtetrHkgJ2OiiIXVDDwEEnAIbKXn8uiyditp7Plz3ho4Hr2CxSlj
        tgDlIEGGbTf/7v3JIVWNVKSi8OGb01sQygskLmw8XeoDNXb96qFd1xojEcMqv6L7skN5qMWIJpr1H
        7FaGrsofkHGqmpPh90W8LiWdFFl9UL0tUUUU0shFn3f1g8zq592+r6Sgi6RwdqUsqCaNAzB/uov8w
        okSg5zuA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms5tA-00699L-Uq; Tue, 30 Nov 2021 16:21:52 +0000
Date:   Tue, 30 Nov 2021 08:21:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the akpm tree
Message-ID: <YaZPoEHL2svLLBwS@bombadil.infradead.org>
References: <20211130184622.71be17e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211130184622.71be17e0@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 06:46:22PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the akpm tree, today's linux-next boot test (powerpc
> pseries_le_defconfig) failed like this:
>=20
> [    0.025828][    T0] pid_max: default: 32768 minimum: 301
> [    0.028445][    T0] Mount-cache hash table entries: 8192 (order: 0, 65=
536 bytes, linear)
> [    0.028636][    T0] Mountpoint-cache hash table entries: 8192 (order: =
0, 65536 bytes, linear)
> [    0.055344][    T0] BUG: Unable to handle kernel data access on write =
at 0x2000000b7
> [    0.056649][    T0] Faulting instruction address: 0xc00000000057435c
> [    0.057458][    T0] Oops: Kernel access of bad area, sig: 11 [#1]
> [    0.057734][    T0] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 N=
UMA pSeries
> [    0.058250][    T0] Modules linked in:
> [    0.058816][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-r=
c3 #2
> [    0.059410][    T0] NIP:  c00000000057435c LR: c000000000577f54 CTR: 0=
000000000000003
> [    0.059608][    T0] REGS: c000000002787a80 TRAP: 0380   Not tainted  (=
5.16.0-rc3)
> [    0.059999][    T0] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE> =
 CR: 44000288  XER: 20000000
> [    0.060654][    T0] CFAR: c000000000574464 IRQMASK: 0=20
> [    0.060654][    T0] GPR00: c000000000577f54 c000000002787d20 c00000000=
2788500 c00000000252d5e8=20
> [    0.060654][    T0] GPR04: c000000000e42500 c00000000252d5e8 000000000=
0000000 c0000000073a02c9=20
> [    0.060654][    T0] GPR08: c000000000e42380 c000000000f89d48 c00000000=
274f700 ffffffffffffffff=20
> [    0.060654][    T0] GPR12: 0000000000000000 c000000002970000 000000000=
0000000 0000000000000000=20
> [    0.060654][    T0] GPR16: 0000000002bf00d0 000000000135bfd8 000000000=
0000000 0000000000000000=20
> [    0.060654][    T0] GPR20: c00000000252d6e8 c00000000252d740 000000000=
0000006 0000000000000000=20
> [    0.060654][    T0] GPR24: 0000000000000000 0000000000000002 c00000000=
2662eb8 c00000000252d5e8=20
> [    0.060654][    T0] GPR28: 00000002000000b7 c000000001004108 000000000=
0000000 c00000000252d5c0=20
> [    0.062938][    T0] NIP [c00000000057435c] count_subheaders.part.0+0x9=
c/0x2b0
> [    0.064395][    T0] LR [c000000000577f54] __register_sysctl_paths+0x64=
/0x320
> [    0.065201][    T0] Call Trace:
> [    0.065521][    T0] [c000000002787dc0] [c000000000577f54] __register_s=
ysctl_paths+0x64/0x320
> [    0.065960][    T0] [c000000002787e40] [c0000000005782a4] __register_s=
ysctl_base+0x34/0x50
> [    0.066570][    T0] [c000000002787e60] [c0000000020259bc] sysctl_init_=
bases+0x34/0x74
> [    0.066960][    T0] [c000000002787e90] [c000000002041744] proc_sys_ini=
t+0x54/0x68
> [    0.067306][    T0] [c000000002787eb0] [c0000000020410dc] proc_root_in=
it+0xb8/0xdc
> [    0.067763][    T0] [c000000002787ed0] [c0000000020044fc] start_kernel=
+0x838/0x8cc
> [    0.068171][    T0] [c000000002787f90] [c00000000000d39c] start_here_c=
ommon+0x1c/0x600
> [    0.068782][    T0] Instruction dump:
> [    0.069295][    T0] f821ff61 eab40018 2c350000 418201c8 e9350000 2c290=
000 4182020c 3b000000=20
> [    0.069694][    T0] 3a600000 eb950018 2c3c0000 41820198 <e93c0000> 2c2=
90000 418201dc 3b200000=20
> [    0.071747][    T0] ---[ end trace df5d37c8b563422a ]---
> [    0.071967][    T0]=20
> [    1.073058][    T0] Kernel panic - not syncing: Attempted to kill the =
idle task!
>=20
> Bisected to commit
>=20
>   f00ff38c1dfa ("sysctl: add and use base directory declarer and registra=
tion helper")
>=20
> I have reverted that complete 6 patch series for today.

I'll be trying to reproduce and fix, thanks for the report!

  Luis
