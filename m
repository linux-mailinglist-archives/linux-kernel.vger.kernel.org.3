Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E572355A101
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiFXSa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiFXSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E897C529;
        Fri, 24 Jun 2022 11:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149AD62020;
        Fri, 24 Jun 2022 18:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B26C341C8;
        Fri, 24 Jun 2022 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656095417;
        bh=+nB3Mze0wsCLxCwnK40J86gG1rNfZ6+oCMClaNRDnLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY2gdr2MrR7VbJEhaUX9GNPkZj/OGMy0Yq+Lc0yj7A2NRmh93SWoSUp3vbxeJpysT
         yqPA0YvarMhp+ehF+AWB3zSEojrWI9fGXTgjE8T7G1WquvVeQ/ZifMM6D+erqYX6Yp
         +b305jRIKZj60cv5cfw/XUzUjOdAfv7Z6OYP3R2oil00lTcqrxAhQnx8SiZaIN8ac6
         G99QBUrqLqpKs2MKrX5CFV1MvPlJ/DpaPqxmKSb4M8Hljo799V1HpIvS5N8pG8PxkT
         S6JBYzxq5+YfqxDo+wJjXUt60AZ0Eo6NPDgtZbul+O7cGV8HxFd20eAYQZASSB5/dn
         K9t5ClYPeU38w==
Date:   Fri, 24 Jun 2022 11:30:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chandan Babu R <chandanrlinux@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ayushman Dutta <ayushman999@gmail.com>,
        syzkaller@googlegroups.com
Subject: Re: kernel BUG at fs/xfs/xfs_message.c:102!
Message-ID: <YrYCuFkRVg5H4vQt@magnolia>
References: <CA+6OtaV5AJEFnP8tuvsyJ07zYzaTGjVO6rk_hLUHqDH-fQrF+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+6OtaV5AJEFnP8tuvsyJ07zYzaTGjVO6rk_hLUHqDH-fQrF+A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:31:41AM -0500, Ayushman Dutta wrote:
> Linux revision: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> Linux version: v5.19-rc2
> 
> Syzkaller Dashboard report:
> 
> XFS: Assertion failed: !(flags & ~XFS_INOBT_WALK_FLAGS_ALL), file:
> fs/xfs/xfs_iwalk.c, line: 761
> ------------[ cut here ]------------
> kernel BUG at fs/xfs/xfs_message.c:102!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 22646 Comm: syz-executor.5 Not tainted 5.19.0-rc2 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:assfail+0x7f/0x8f fs/xfs/xfs_message.c:102
> Code: 7f 10 84 d2 74 0c 48 c7 c7 d0 be 1e b8 e8 00 80 78 fd 8a 1d 4a
> b7 3e 01 31 ff 89 de e8 a1 68 44 fd 84 db 74 07 e8 18 6c 44 fd <0f> 0b
> e8 11 6c 44 fd 0f 0b 5b 5d 41 5c 41 5d c3 e8 03 6c 44 fd 48
> RSP: 0018:ffffc9000dcb77d8 EFLAGS: 00010282
> RAX: 00000000000005c3 RBX: ffffffffb75a1201 RCX: ffffffff84000798
> RDX: 0000000000040000 RSI: ffffc9000518a000 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88806cf4374f
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffb75a1600
> R13: 00000000000002f9 R14: 0000000000000002 R15: ffffc9000dcb7a10
> FS:  00007f74ab8e3640(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2de24000 CR3: 000000001ba2e000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  xfs_inobt_walk+0x3e3/0x470 fs/xfs/xfs_iwalk.c:761
>  xfs_inumbers+0x28e/0x3a0 fs/xfs/xfs_itable.c:423
>  xfs_ioc_inumbers.constprop.0+0x1a5/0x270 fs/xfs/xfs_ioctl.c:916

INUMBERS, eh?  I bet this reproducer calls INUMBERS with
XFS_BULK_IREQ_NREXT64, which doesn't make any sense for INUMBERS and
thus triggers the ASSERT.

Chandan: Any thoughts?

>  xfs_file_ioctl+0x1350/0x1d00 fs/xfs/xfs_ioctl.c:1925
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x7f74ac16f92d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f74ab8e3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f74ac28ff60 RCX: 00007f74ac16f92d
> RDX: 00000000200000c0 RSI: 0000000080405880 RDI: 0000000000000004
> SELinux: unrecognized netlink message: protocol=4 nlmsg_type=0
> sclass=netlink_tcpdiag_socket pid=22661 comm=syz-executor.4
> RBP: 00007f74ac1e0070 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000006 R14: 00007f74ac28ff60 R15: 00007f74ab8c3000
> SELinux: unrecognized netlink message: protocol=4 nlmsg_type=0
> sclass=netlink_tcpdiag_socket pid=22661 comm=syz-executor.4
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:assfail+0x7f/0x8f fs/xfs/xfs_message.c:102
> Code: 7f 10 84 d2 74 0c 48 c7 c7 d0 be 1e b8 e8 00 80 78 fd 8a 1d 4a
> b7 3e 01 31 ff 89 de e8 a1 68 44 fd 84 db 74 07 e8 18 6c 44 fd <0f> 0b
> e8 11 6c 44 fd 0f 0b 5b 5d 41 5c 41 5d c3 e8 03 6c 44 fd 48
> RSP: 0018:ffffc9000dcb77d8 EFLAGS: 00010282
> RAX: 00000000000005c3 RBX: ffffffffb75a1201 RCX: ffffffff84000798
> RDX: 0000000000040000 RSI: ffffc9000518a000 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88806cf4374f
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffb75a1600
> R13: 00000000000002f9 R14: 0000000000000002 R15: ffffc9000dcb7a10
> FS:  00007f74ab8e3640(0000) GS:ffff88806cf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2de24000 CR3: 000000001ba2e000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> 
> 
> 
> Syzkaller repro.txt
> 
> r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x26e1, 0x0)
> 
> ioctl$XFS_IOC_SCRUB_METADATA(r0, 0x80405880, &(0x7f00000000c0)={0xc,
> 0x0, 0x4, 0x221})
> 
> 
> 
> Syzkaller repro.c
> 
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> 
> #define _GNU_SOURCE
> 
> 
> #include <endian.h>
> 
> #include <stdint.h>
> 
> #include <stdio.h>
> 
> #include <stdlib.h>
> 
> #include <string.h>
> 
> #include <sys/syscall.h>
> 
> #include <sys/types.h>
> 
> #include <unistd.h>
> 
> 
> uint64_t r[1] = {0xffffffffffffffff};
> 
> 
> int main(void)
> 
> {
> 
>   syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
>   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
> 
>   syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
> 
>   intptr_t res = 0;
> 
>   memcpy((void*)0x20000040, "./file0\000", 8);
> 
>   res = syscall(__NR_openat, 0xffffff9c, 0x20000040ul, 0x26e1ul, 0ul);
> 
>   if (res != -1)
> 
>     r[0] = res;
> 
>   *(uint32_t*)0x200000c0 = 0xc;
> 
>   *(uint32_t*)0x200000c4 = 0;
> 
>   *(uint32_t*)0x200000c8 = 4;

"Google sentient AI still too stupid to provide ioctl structure paramter
decoding..."

--D

> 
>   *(uint32_t*)0x200000cc = 0x221;
> 
>   *(uint32_t*)0x200000d0 = 0;
> 
>   *(uint64_t*)0x200000d8 = 0;
> 
>   syscall(__NR_ioctl, r[0], 0x80405880, 0x200000c0ul);
> 
>   return 0;
> 
> }
> 
> Config file attached.


