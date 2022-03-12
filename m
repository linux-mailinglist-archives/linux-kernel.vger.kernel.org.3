Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6930D4D6D73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiCLIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 03:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCLIFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 03:05:24 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FD423D5BE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:04:19 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id e11-20020a5d8e0b000000b006412cf3f627so8006501iod.17
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 00:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5zOjHs3cDSO0d/sc2bYpHYPQ7grv3p5Pd+1pHqicW7k=;
        b=z8isO8NocNV/ByyS0Ye+BwNDJ/WQSCL9Mj6UUidi0BeQkwBkEghRTJ8Bd9e/WAiQ6J
         K/pYOaLrGkTFs7NHgXQb5Hx6mX/z/Y78rhHXPYgfCXczMBmTiI6AoXJ6XleT2pLY1LTU
         ZnwxP6+Y+qq6m/7KZ9llxYGwKjC5uTbSbSGo/6UJxlP1UnoeDO1Qa37BFIyQNqDdm7cc
         6pr57+M7O46ovo5ES1IuNWOZ1I+HVGrYxiTYQj422A3OFRIATzle5UZuJvLR9WRXBl+V
         YySU09HCyj4A06BGn10wgvnwBhU7+xY935IBdMDEHu1IcIIGCB9g+1f1TwcA/dnMlVW1
         LcEA==
X-Gm-Message-State: AOAM531Rqxv3A5evq1CxAIF3k6Tnqxfn4N2xuhRUw0XRpiNqRJXWIOKN
        npjqGxECD1vYd2uNYvKVvqPQeRrQmZwfmf4NDpp90TCetsb2
X-Google-Smtp-Source: ABdhPJxGVWggqKaOvI8uV4fq9PifdIw3pZTopnX1If/fbvee7OSbGfz804S8ZmkgGbIQXfz3JTErP+2vjS9eGsZ5VnPSAVA2rWQs
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:2c6:5a4f:5bb5 with SMTP id
 h9-20020a056e021d8900b002c65a4f5bb5mr11670304ila.210.1647072259089; Sat, 12
 Mar 2022 00:04:19 -0800 (PST)
Date:   Sat, 12 Mar 2022 00:04:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec2a8205da00e46f@google.com>
Subject: [syzbot] WARNING in drm_prime_destroy_file_private
From:   syzbot <syzbot+2448673875b4e20db46a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ea4424be1688 Merge tag 'mtd/fixes-for-5.17-rc8' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14095f9e700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aba0ab2928a512c2
dashboard link: https://syzkaller.appspot.com/bug?extid=2448673875b4e20db46a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2448673875b4e20db46a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 16791 at drivers/gpu/drm/drm_prime.c:228 drm_prime_destroy_file_private+0x3e/0x50 drivers/gpu/drm/drm_prime.c:228
Modules linked in:
CPU: 1 PID: 16791 Comm: syz-executor.5 Not tainted 5.17.0-rc7-syzkaller-00020-gea4424be1688 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:drm_prime_destroy_file_private+0x3e/0x50 drivers/gpu/drm/drm_prime.c:228
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 1f 48 8b 83 90 00 00 00 48 85 c0 75 06 5b e9 e7 6c 1d fd e8 e2 6c 1d fd <0f> 0b 5b e9 da 6c 1d fd e8 05 5a 64 fd eb da 0f 1f 00 41 55 49 89
RSP: 0018:ffffc90002af79e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888025e72370 RCX: 0000000000000000
RDX: ffff8880727aa1c0 RSI: ffffffff845a788e RDI: ffff888025e72400
RBP: ffff8881471d4068 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817e23e8 R11: 0000000000088078 R12: ffff888025e72000
R13: ffff888025e722b8 R14: ffff8881471d4098 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea39ef0d8 CR3: 00000000791d8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_file_free.part.0+0x6e5/0xb80 drivers/gpu/drm/drm_file.c:291
 drm_file_free drivers/gpu/drm/drm_file.c:248 [inline]
 drm_close_helper.isra.0+0x17d/0x1f0 drivers/gpu/drm/drm_file.c:308
 drm_release+0x1e6/0x530 drivers/gpu/drm/drm_file.c:495
 __fput+0x286/0x9f0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 get_signal+0x45a/0x2490 kernel/signal.c:2863
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:288
RIP: 0033:0x7f836c6a0471
Code: Unable to access opcode bytes at RIP 0x7f836c6a0447.
RSP: 002b:00007f836afd22f0 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007f836afd2700 RCX: 00007f836c6a0471
RDX: 00007f836afd29d0 RSI: 00007f836afd22f0 RDI: 00000000003d0f00
RBP: 00007ffed5e285a0 R08: 00007f836afd2700 R09: 00007f836afd2700
R10: 00007f836afd29d0 R11: 0000000000000206 R12: 00007ffed5e2840e
R13: 00007ffed5e2840f R14: 00007f836afd2300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
