Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECF511796
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiD0Mqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiD0Mqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:46:34 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944D8CD86
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:43:23 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id t1-20020a056602140100b0065393cc1dc3so2201944iov.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ej//LfNdHlptNd5pdrw15BpdsBtUnXJhQm0s51Nc30k=;
        b=A3G4rxggCs4f+yhVpqNO4SSiwnFqxJ+24Ni75q2yC2Nm/QR/DzM75gtRPYlMGcd2iK
         hmHyMVhKyez8mH4rfnvgXpQ3+wHfdY6pqOu0Icm255eIpmwAAm5ejPqnU9LA1a/eflVH
         HlZPj8X31gnR3mpm0VSngbrbObd0DZNI4gOqxpa1lGxaCiUuwXBBNXxJ9IU/StDJ3pWm
         /xC17Pf9oQCjoad/SzCH1wse4yMSQSjOhbbHmGt0y2CMa2pVhdjGlKwwBWD8yMtuw9BX
         lYd3lLeXFFM8Co3jgTVMXyLN++w6+U5kvLc8V1m5kR5URsAgpAEZ2gAJ+Ezs/zAT9G8U
         A3tQ==
X-Gm-Message-State: AOAM532GCU/Wek0oWYQNstVBIHNaomjRngIgUPULI538P2+eFaP95FKs
        3QjKJWpvHfdvqkhhDZe09UMIC8Tpnzw+XnyFNt7RvLgXb21o
X-Google-Smtp-Source: ABdhPJwUzPLJ+zql1X4uwWGVxbNLdROBbpqOCbs5gXQa0eCWPpSfi9Xum0jxaxCNbx/CWHq9Yxu9Bo5KFxowQmbbQK2BELGTkQCs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3472:b0:319:e0d3:9027 with SMTP id
 q50-20020a056638347200b00319e0d39027mr11720885jav.263.1651063402936; Wed, 27
 Apr 2022 05:43:22 -0700 (PDT)
Date:   Wed, 27 Apr 2022 05:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a23c8505dda227eb@google.com>
Subject: [syzbot] WARNING in vma_merge
From:   syzbot <syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f02ac5c95dfd Add linux-next specific files for 20220427
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134114c8f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9256c70f586da8a
dashboard link: https://syzkaller.appspot.com/bug?extid=7728e4ab5371cebc9c00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7728e4ab5371cebc9c00@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 16395 at mm/mmap.c:1072 vma_merge+0x428/0x950 mm/mmap.c:1072
Modules linked in:
CPU: 0 PID: 16395 Comm: syz-executor.0 Not tainted 5.18.0-rc4-next-20220427-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vma_merge+0x428/0x950 mm/mmap.c:1072
Code: 00 e8 5c 1f c4 ff e8 57 1f c4 ff 45 31 f6 e8 4f 1f c4 ff 4c 89 f0 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 38 1f c4 ff <0f> 0b e9 6c fd ff ff e8 2c 1f c4 ff 48 8d bd 88 00 00 00 48 b8 00
RSP: 0018:ffffc90002dffc90 EFLAGS: 00010293
RSP: 0018:ffffc90002dffc90 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000008100077 RCX: 0000000000000000
RDX: ffff888076f91d40 RSI: ffffffff81b62968 RDI: 0000000000000003
RBP: ffff88801bea8000 R08: 0000000020600000 R09: 0000000000000000
R10: ffffffff81b626ce R11: 0000000000000000 R12: 0000000020ce2000
R13: 0000000020600000 R14: ffff8880791ba360 R15: ffff8880791ba360
FS:  0000555556995400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002a80 CR3: 000000003bbf8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 userfaultfd_release+0x4c5/0x670 fs/userfaultfd.c:888
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:169
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f394ce3bd2b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffc0fe56030 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f394ce3bd2b
RDX: 00007f394cfa04b0 RSI: ffffffffffffffff RDI: 0000000000000004
RBP: 00007f394cf9d960 R08: 0000000000000000 R09: 00007f394cfa04b8
R10: 00007ffc0fe56130 R11: 0000000000000293 R12: 0000000000085752
R13: 00007ffc0fe56130 R14: 00007f394cf9bf60 R15: 0000000000000032
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
