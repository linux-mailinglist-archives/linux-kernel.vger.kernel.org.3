Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB358D348
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiHIFkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiHIFk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:40:29 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE32195
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:40:28 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id f5-20020a056e020b4500b002df180f0997so8045575ilu.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=ABAMHtybv8t+r8522rVxoNASvHh59EpYpnl9sqx+2lQ=;
        b=FFy5DlWEBgJDEdW8r7sdejvX8AqV4TbHDpEhDN0Pd7N1mLastP53yYsAoAfg8ysmNr
         2SVE2neKfHi4kZyBSHEzF8hP/bC+uBGBATT6nKbTFjwF4VTlf6GtFR23OKt/nI5glRz1
         OKR5/lvRSPHGuHroUiqWVbaM5Tk2CxMnVSwOQONmtgwJXurhvd/CEOuhMcK4Zh547oV8
         J9AaaGeF6lsa6/k0FiTKKf5oWdGpvhIosp+2gELSfJDl59S82/tzhwVdoCjEmVkH/lVF
         d+7L+u7SMESSRYTs5fefk++Y8CIu0F+TMFaStoPDtfb0fNfXh2OSWfBiH2/IeYTm/Wy2
         GGtA==
X-Gm-Message-State: ACgBeo3Cp54g9kEK2Kf4nErElB1ZuUMwdKCsRxsyQD/dYT0ZIjErljXc
        bvtHZxuDtuxSBz08+JSshcBBqEXhTl9d9YHtF9b/hexXRU/p
X-Google-Smtp-Source: AA6agR5kbqmeoL+lIxIE43HizhcXuvyP5zF6CoEaWLqWbufIZ6GEjecndswPAdubX0Y13UuhrJ1l2Pfxl3cE9ZZZq01bEYF22cL/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dcb:b0:342:b6d6:16b6 with SMTP id
 m11-20020a0566380dcb00b00342b6d616b6mr8561261jaj.125.1660023628066; Mon, 08
 Aug 2022 22:40:28 -0700 (PDT)
Date:   Mon, 08 Aug 2022 22:40:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab752605e5c85e9a@google.com>
Subject: [syzbot] WARNING in blk_mq_release
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

Hello,

syzbot found the following issue on:

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1634c29e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=31c9594f6e43b9289b25
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131893fe080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31c9594f6e43b9289b25@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3818 at block/blk-mq.c:3881 blk_mq_release+0x115/0x2d0
Modules linked in:
CPU: 1 PID: 3818 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:blk_mq_release+0x115/0x2d0 block/blk-mq.c:3881
Code: 89 ef 4c 89 e6 48 c7 c2 ff ff ff ff b9 08 00 00 00 e8 ef bd 50 00 48 85 c0 74 13 48 89 c3 e8 12 05 71 fd eb b0 e8 0b 05 71 fd <0f> 0b eb d1 e8 02 05 71 fd eb 05 e8 fb 04 71 fd 48 8b 44 24 10 4c
RSP: 0018:ffffc90003affbc0 EFLAGS: 00010293
RAX: ffffffff84171ba5 RBX: ffff888078c482a8 RCX: ffff8880743b8000
RDX: 0000000000000000 RSI: ffffffff8a8d4160 RDI: ffffffff8ae9a7c0
RBP: ffffc90003affc90 R08: dffffc0000000000 R09: fffffbfff1c07946
R10: fffffbfff1c07946 R11: 1ffffffff1c07945 R12: ffffc90003affc20
R13: ffff888020751718 R14: dffffc0000000000 R15: ffff888020751868
FS:  00007f0eea256700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f101f96d058 CR3: 000000001df33000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_release_queue+0x13d/0x210 block/blk-sysfs.c:780
 kobject_cleanup+0x235/0x470 lib/kobject.c:673
 __alloc_disk_node+0x359/0x540 block/genhd.c:1388
 __blk_mq_alloc_disk+0x11b/0x1e0 block/blk-mq.c:3961
 loop_add+0x325/0x9b0 drivers/block/loop.c:1978
 loop_control_get_free drivers/block/loop.c:2139 [inline]
 loop_control_ioctl+0x39a/0x770 drivers/block/loop.c:2154
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0ee9089279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0eea256168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0ee919c050 RCX: 00007f0ee9089279
RDX: 0000000000000000 RSI: 0000000000004c82 RDI: 0000000000000004
RBP: 00007f0eea2561d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffe6368d72f R14: 00007f0eea256300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
