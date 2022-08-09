Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69B58D78A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiHIKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbiHIKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:41:32 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FCF24099
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:41:31 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x2-20020a6bfe02000000b00682bffede8fso6006958ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=tUq98I7aR5JXGl5sCzEIGpj+bZOjTZ1Xlr+6Uy5x0Ls=;
        b=tIzkzpzIwMLJ5eWcNhC/rndcAoXDob0DDIiIVNNYAfGfh3moNV0yVtIffiTLqNg1L/
         tCIdwmE0xHTj1Ts41NQewGnmV3Iv8k+ZfUefmY3EE3FU2QAZx6P22gv3WDgN8TtZCz4C
         lQRCHqxICxdMrXyN9XPFyV0RsA1wkGg6y07GPBEK8p6ylRd8KDaboVR8p4vJtSscvM1V
         JUz0s4SBu1md+jQRQ0Ee+bZT0G/0q27dgd2lCpnDb96swfG21AYMJ96tRnbVclsJNhvp
         fpdkZX+7oiuUaHu6+Pgg4+MzjyF6Poj7gV/E+VYmfyaU+KV2CXftq0biUGM6+GhvxRt7
         S0Ow==
X-Gm-Message-State: ACgBeo06Q8kxzqDvHZ8ETeZX2LfUYDF0kyu7Cjf/cD+Aai4M9NSsvD69
        JXDca5E9aOlpWilK51Vd8WG+1tTLYTWSbFql/+JgHKIYHrBX
X-Google-Smtp-Source: AA6agR43YaEMsUVc0nln447abeqEOnooti4uMdExknLZbeue8Dw4a9H4ecC1NOhlEGgjwc23KyBdSLEYB1ui7NliMkUNc7CZRNSg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:341:de68:602c with SMTP id
 r21-20020a056638301500b00341de68602cmr10181049jak.10.1660041690986; Tue, 09
 Aug 2022 03:41:30 -0700 (PDT)
Date:   Tue, 09 Aug 2022 03:41:30 -0700
In-Reply-To: <000000000000ab752605e5c85e9a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004dbc5305e5cc93a6@google.com>
Subject: Re: [syzbot] WARNING in blk_mq_release
From:   syzbot <syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1446b746080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=31c9594f6e43b9289b25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=106b302a080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b1dae1080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 23016 at block/blk-mq.c:3881 blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
Modules linked in:
CPU: 1 PID: 23016 Comm: syz-executor588 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:blk_mq_release+0xf8/0x3e0 block/blk-mq.c:3881
Code: fd 4c 8d a3 a8 02 00 00 4c 89 e0 48 c1 e8 03 80 3c 28 00 0f 85 14 02 00 00 48 8b 83 a8 02 00 00 49 39 c4 75 b1 e8 48 e4 96 fd <0f> 0b eb a8 e8 3f e4 96 fd 48 8b 44 24 10 48 05 18 05 00 00 48 89
RSP: 0018:ffffc900032bfc60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807a8e8800 RCX: 0000000000000000
RDX: ffff88807cd89d80 RSI: ffffffff83e3f578 RDI: 0000000000000000
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88807a8e8aa8
R13: ffff88807ab0db40 R14: ffff88807ab0db88 R15: 0000000000000000
FS:  0000555555af3300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf573219f0 CR3: 000000007deea000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 blk_release_queue+0x153/0x270 block/blk-sysfs.c:780
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:721
 __alloc_disk_node+0x4f7/0x610 block/genhd.c:1388
 __blk_mq_alloc_disk+0x13b/0x1f0 block/blk-mq.c:3961
 loop_add+0x3e2/0xaf0 drivers/block/loop.c:1978
 loop_control_ioctl+0x133/0x620 drivers/block/loop.c:2150
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbf572f20b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca9b31288 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fbf572f20b9
RDX: 000000000000000c RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007ffca9b312a0 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

