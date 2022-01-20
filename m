Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4263494DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiATMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:18:22 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48720 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiATMSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:18:21 -0500
Received: by mail-il1-f199.google.com with SMTP id t18-20020a92ca92000000b002b952c60bfbso2293263ilo.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 04:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pQ7xOOQh9MziPMJQrqKb5S9rgs/wOTuUDyObBUnxmus=;
        b=Zd+8DsYAn23M+RH/1EELy4/0PlfY6ncy4VAmBWub7SxmcwyUcPQgTJzl03+/iynWfB
         q7XNN5xS9BKjCs/EKGIZkneoJ5G7ML5VLjAPMolmC7Unn0ssqiczstK5DTxsjNT0e9PK
         Lm9yAepyNEdA487956G43EJ3yBIgkvdq/YBJJ423zJLFZZLqJTaysk+Dql8XOG+Migqj
         OSu3/G6+k7tSSo/Y/T2y6wTIBk9q190qhreG2fPbAReXpvClSIQ4UlDxhpMd0l/yEMjp
         OOOeGJ9MvNsYs+lnxKhwKRsNHqIDODGTirATEwYXv9o7t68MmbElI7EU/AvJ6XV4JLKs
         wjtg==
X-Gm-Message-State: AOAM532vk87O8JualQJfJQ9R/3/expaD37d9WRtV+CpoRzeVodYOQDq4
        1C8I09DhZT7K3XsZVM16hZeH3l/S2Py32OPMxzfYcalOgjO6
X-Google-Smtp-Source: ABdhPJyFSM+FQhDMgiEsmaKTyyPQkdeI8y3gWaSaHdlrQgiAR/BLbYR+YC6wicyEQrtYgOmIPmX72dUHO262qpUvDWnByCqzIo7k
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3450:: with SMTP id q16mr14470241jav.311.1642681101166;
 Thu, 20 Jan 2022 04:18:21 -0800 (PST)
Date:   Thu, 20 Jan 2022 04:18:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083ab5e05d6027f02@google.com>
Subject: [syzbot] WARNING in dma_map_sgtable
From:   syzbot <syzbot+d03b64357793677f0080@syzkaller.appspotmail.com>
To:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, sumit.semwal@linaro.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e3a8b6a1e70c Merge tag 'slab-for-5.17-part2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1507e01fb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73c17fd2d4a060fe
dashboard link: https://syzkaller.appspot.com/bug?extid=d03b64357793677f0080
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d03b64357793677f0080@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 21150 at kernel/dma/mapping.c:188 __dma_map_sg_attrs kernel/dma/mapping.c:188 [inline]
WARNING: CPU: 1 PID: 21150 at kernel/dma/mapping.c:188 dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
Modules linked in:
CPU: 1 PID: 21150 Comm: syz-executor.5 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__dma_map_sg_attrs kernel/dma/mapping.c:188 [inline]
RIP: 0010:dma_map_sgtable+0x203/0x260 kernel/dma/mapping.c:264
Code: 75 15 e8 50 b2 13 00 eb cb e8 49 b2 13 00 eb c4 e8 42 b2 13 00 eb bd e8 3b b2 13 00 0f 0b bd fb ff ff ff eb af e8 2d b2 13 00 <0f> 0b 31 ed 48 bb 00 00 00 00 00 fc ff df e9 7b ff ff ff 89 e9 80
RSP: 0018:ffffc9000969fd20 EFLAGS: 00010287
RAX: ffffffff8171ee13 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc900056f9000 RSI: 000000000000079b RDI: 000000000000079c
RBP: ffff888147437408 R08: ffffffff8171ece3 R09: ffffed100d4e6956
R10: ffffed100d4e6956 R11: 0000000000000000 R12: ffff888147437000
R13: ffff88806a734aa0 R14: 0000000000000000 R15: 0000000000000002
FS:  00007f009bbc7700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555641b108 CR3: 000000001901b000 CR4: 00000000003506e0
DR0: 0000000020000100 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 get_sg_table+0xfc/0x150 drivers/dma-buf/udmabuf.c:72
 begin_cpu_udmabuf+0xf5/0x160 drivers/dma-buf/udmabuf.c:126
 dma_buf_begin_cpu_access+0xd8/0x170 drivers/dma-buf/dma-buf.c:1164
 dma_buf_ioctl+0x2a0/0x2f0 drivers/dma-buf/dma-buf.c:363
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f009d251fe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f009bbc7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f009d364f60 RCX: 00007f009d251fe9
RDX: 0000000020000040 RSI: 0000000040086200 RDI: 000000000000000b
RBP: 00007f009d2ac08d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc7751fd4f R14: 00007f009bbc7300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
