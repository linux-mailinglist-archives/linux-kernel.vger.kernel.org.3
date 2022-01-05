Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC20485230
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 13:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiAEMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 07:03:21 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43829 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiAEMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:03:20 -0500
Received: by mail-il1-f197.google.com with SMTP id l3-20020a056e0212e300b002b5afe23123so6859086iln.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 04:03:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B2ue6rdjnDkmtAxgVcmjk6LtSUfDXVXxXmhyUfE9ElI=;
        b=DDjsLfmvamFm2HGCmy5hK75iO1ZFFA+Fh+RHfxqWPovQY9jqTl8nKVLOY2dJvcCjlR
         LsiRwdg4HSxP/4VYvS1doMhak+efwEyZgQsRbpk4OHZfjWzNA2sixUfSR0udHq0hZO/0
         fGB/Xc3iPd6pWpEThG5UHTqm6n8TQNCY7XjbPWAqjvjR4o9eK8OvUxWm6zirvWFMLvke
         bxNFSTVi9Cto5KIs2WfNsQ3vj0oBJcL32L85cYWaaGNJgouEezFL+65RvG2uLhp4isUa
         vgPMMM+zUk96Cc0SWZ2cec4+zulGnGvPFCTVgzHGTayJCGw4gJ/3iYGMUsoUQK3NsP9y
         zxqw==
X-Gm-Message-State: AOAM530KGPh8HZS8qH7e0JfLT1a1JV2eCffAyrRXQu67W8TnBX2l3xYG
        6D2sd4DhGJBPGABpLMNMmdHFMARb8WJx38kRlBv9PGsHQGXI
X-Google-Smtp-Source: ABdhPJxOfzDp5Usc2hvhmpqMhVJOOCW51JfVCPHBLIi7ZfcGaUG05Tssg94wOvZ92zfJifTHXYHG+OFAecAS8q1EBAS0JI+GjFVu
MIME-Version: 1.0
X-Received: by 2002:a92:ddc4:: with SMTP id d4mr561543ilr.281.1641384199974;
 Wed, 05 Jan 2022 04:03:19 -0800 (PST)
Date:   Wed, 05 Jan 2022 04:03:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002df33305d4d48a3c@google.com>
Subject: [syzbot] KMSAN: uninit-value in cma_make_mc_event
From:   syzbot <syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com>
To:     avihaih@nvidia.com, dledford@redhat.com, glider@google.com,
        haakon.bugge@oracle.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13420bb9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=8fcbb77276d43cc8b693
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
BUG: KMSAN: uninit-value in cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
 cma_set_qkey drivers/infiniband/core/cma.c:510 [inline]
 cma_make_mc_event+0xb73/0xe00 drivers/infiniband/core/cma.c:4570
 cma_iboe_join_multicast drivers/infiniband/core/cma.c:4782 [inline]
 rdma_join_multicast+0x2b83/0x30a0 drivers/infiniband/core/cma.c:4814
 ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479
 ucma_join_multicast+0x1e3/0x250 drivers/infiniband/core/ucma.c:1546
 ucma_write+0x639/0x6d0 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x8ce/0x2030 fs/read_write.c:588
 ksys_write+0x28c/0x520 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable ib.i created at:
 cma_iboe_join_multicast drivers/infiniband/core/cma.c:4737 [inline]
 rdma_join_multicast+0x586/0x30a0 drivers/infiniband/core/cma.c:4814
 ucma_process_join+0xa76/0xf60 drivers/infiniband/core/ucma.c:1479

CPU: 0 PID: 29874 Comm: syz-executor.3 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
