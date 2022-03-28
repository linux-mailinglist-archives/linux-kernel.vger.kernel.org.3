Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A064E961B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbiC1MBi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 08:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiC1MBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:01:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E33DEED
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:59:51 -0700 (PDT)
Received: from canpemm500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KRrmL3V5CzCrSg;
        Mon, 28 Mar 2022 19:57:38 +0800 (CST)
Received: from canpemm500001.china.huawei.com (7.192.104.163) by
 canpemm500003.china.huawei.com (7.192.105.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:59:49 +0800
Received: from canpemm500001.china.huawei.com ([7.192.104.163]) by
 canpemm500001.china.huawei.com ([7.192.104.163]) with mapi id 15.01.2308.021;
 Mon, 28 Mar 2022 19:59:49 +0800
From:   "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Wangjing(Hogan)" <hogan.wang@huawei.com>,
        "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Subject: [Question] kernfs: NULL pointer dereference in
 kernfs_dop_revalidate()
Thread-Topic: [Question] kernfs: NULL pointer dereference in
 kernfs_dop_revalidate()
Thread-Index: AdhCmcTZEgAvxUCLQpCJ5NBzzvVfgw==
Date:   Mon, 28 Mar 2022 11:59:49 +0000
Message-ID: <685d8898ca614138a9c15f8042e3d291@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.254]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We met a kernel panic during boot the new kernel using kexec, the kernel version
is 4.18.0(with some our changes), here is the stack:

[    0.534423] BUG: unable to handle kernel NULL pointer dereference at 0000000000000004
[    0.542224] PGD 0 P4D 0 
[    0.542228] Oops: 0000 [#1] SMP NOPTI
[    0.559748] CPU: 80 PID: 603 Comm: systemd-journal Tainted: G           OE    --------- -  - 4.18.0-147.5.2.5.h781_272.x86_64 #1
[    0.571262] Hardware name: Huawei 2288H V5/BC11SPSCB0, BIOS 7.58 05/25/2020
[    0.578200] RIP: 0010:kernfs_dop_revalidate+0x33/0xc0
[    0.583234] Code: 85 a4 00 00 00 48 8b 57 30 31 c0 48 85 d2 74 51 41 54 55 53 48 8b aa 60 02 00 00 48 89 fb 48 c7 c7 40 50 f0 a9 e8 9d 53 2e 00 <8b> 45 04 85 c0 78 1d 48 8b 43 18 45 31 e4 48 8b 40 30 48 85 c0 74
[    0.601919] RSP: 0018:ffffba340384fc70 EFLAGS: 00010246
[    0.607126] RAX: 0000000000000000 RBX: ffff8e6042df3140 RCX: 0000000000000030
[    0.614234] RDX: ffff8e604382bd00 RSI: 0000000000000000 RDI: ffffffffa9f05040
[    0.621340] RBP: 0000000000000000 R08: 0000746e65766575 R09: 0000000000000006
[    0.628446] R10: ffff8e604390d021 R11: 61c8864680b583eb R12: ffffba340384fcf8
[    0.635553] R13: ffffba340384fcf0 R14: ffff8e6043677320 R15: ffff8e6042df2fc0
[    0.642660] FS:  00007f2bf2cecd80(0000) GS:ffff8e617a500000(0000) knlGS:0000000000000000
[    0.650719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.656444] CR2: 0000000000000004 CR3: 000000604398e003 CR4: 00000000003606e0
[    0.663553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.670659] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.677766] Call Trace:
[    0.680211]  lookup_fast+0x258/0x2d0
[    0.683778]  walk_component+0x48/0x480
[    0.687516]  ? link_path_walk+0x27c/0x510
[    0.691513]  path_lookupat+0x84/0x1f0
[    0.695165]  filename_lookup+0xb6/0x190
[    0.698990]  ? __check_object_size+0xd4/0x1a0
[    0.703338]  ? strncpy_from_user+0x45/0x190
[    0.707509]  ? do_faccessat+0xa2/0x230
[    0.711246]  do_faccessat+0xa2/0x230
[    0.714812]  do_syscall_64+0x5b/0x1b0
[    0.718470]  entry_SYSCALL_64_after_hwframe+0x65/0xca

It seems that the user space uses the access() function to verify whether a directory or file exists.
The kdump service has not started yet at this point, so there's no vmcore.  I use the sysrq-trigger to
get a vmcore manully, here is the part of disassembly code of function kernfs_dop_revalidate:

---
0 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 551
1 0xffffffff884c7e00 <kernfs_dop_revalidate>:     nopl   0x0(%rax,%rax,1) [FTRACE NOP]
2 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 554
3 0xffffffff884c7e05 <kernfs_dop_revalidate+0x5>: and    $0x40,%esi
4 0xffffffff884c7e08 <kernfs_dop_revalidate+0x8>: jne    0xffffffff884c7eb2 <kernfs_dop_revalidate+0xb2>
5 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/./include/linux/dcache.h: 481
6 0xffffffff884c7e0e <kernfs_dop_revalidate+0xe>: mov    0x30(%rdi),%rdx
7 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 586
8 0xffffffff884c7e12 <kernfs_dop_revalidate+0x12>:        xor    %eax,%eax
9 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 558
10 0xffffffff884c7e14 <kernfs_dop_revalidate+0x14>:        test   %rdx,%rdx
11 0xffffffff884c7e17 <kernfs_dop_revalidate+0x17>:        je     0xffffffff884c7e6a <kernfs_dop_revalidate+0x6a>
12 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 551
13 0xffffffff884c7e19 <kernfs_dop_revalidate+0x19>:        push   %r12
14 0xffffffff884c7e1b <kernfs_dop_revalidate+0x1b>:        push   %rbp
15 0xffffffff884c7e1c <kernfs_dop_revalidate+0x1c>:        push   %rbx
16 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/kernfs-internal.h: 79
17 0xffffffff884c7e1d <kernfs_dop_revalidate+0x1d>:        mov    0x260(%rdx),%rbp
18 0xffffffff884c7e24 <kernfs_dop_revalidate+0x24>:        mov    %rdi,%rbx
19 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/fs/kernfs/dir.c: 562
20 0xffffffff884c7e27 <kernfs_dop_revalidate+0x27>:        mov    $0xffffffff89105040,%rdi
21 0xffffffff884c7e2e <kernfs_dop_revalidate+0x2e>:        callq  0xffffffff887ad1d0 <mutex_lock>
22 /usr/src/debug/kernel-4.18.0-147.5.2.5.h781_272.x86_64/linux-4.18.0-147.5.2.5.h781_272.x86_64/./include/linux/compiler.h: 188
23 0xffffffff884c7e33 <kernfs_dop_revalidate+0x33>:        mov    0x4(%rbp),%eax
......
---

According to the message: " BUG: unable to handle kernel NULL pointer dereference at
0000000000000004" and RIP "kernfs_dop_revalidate+0x33", the %rbp is NULL, it is assigned
at line 17 above, and the offset of i_private in struct inode is 0x260, so it turns out that the
i_private is NULL, which is returned from kernfs_dentry_node.

---
75 static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
76 {
77 	if (d_really_is_negative(dentry))
78		return NULL;
79	return d_inode(dentry)->i_private;
80 }
---
550 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
551 {
552 	struct kernfs_node *kn;
553
554		if (flags & LOOKUP_RCU)
555			return -ECHILD;
556
557		/* Always perform fresh lookup for negatives */
558		if (d_really_is_negative(dentry))
559			goto out_bad_unlocked;
560
561		kn = kernfs_dentry_node(dentry);
562		mutex_lock(&kernfs_mutex);
563
564		/* The kernfs node has been deactivated */
565		if (!kernfs_active(kn))
566			goto out_bad;
567     ......
---

We've tried to delete and access some files in sysfs concurrently at the user space, but can't
reproduce the problem for now, :-(

Any advice about the problem or how to debug the kernfs? Thanks!

Jay Zhou
