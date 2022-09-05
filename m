Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D585ACEC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiIEJUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiIEJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:20:32 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561E73C171
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:20:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id z30-20020a05660217de00b00688bd42dc1dso4699623iox.15
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=42LVKbRe88WqSmr3sQ8PuHY+JpZ2kWQqwhfpaaDJUuE=;
        b=qJrKcMsYhmgLsIdQjvfgZwxTdmLRFOHkWBC0YXlR+h4IQnLwycI947B83Ji/akl7Yo
         SxP4FUzV+bGtMFPFgU5JUZvuWM7IkWFymg5tZR1TskiAyWUYShP2uiuDouq8m+dI8dQs
         28OJkGJpepEqU3XlR9pHJyBz3TNeHnWe1eCsk9vvgo4R2s0jb5vz+oj4j9jNLQ+4fMyw
         sPnEIOQSDKisHJF1ke0cMt1/cB9wvccBWwzZTWFW0ZUclTZk8/XlvlzW/dSf5Fnur70C
         f11QkhfYFAqyxLF6QzC/VSITH4Fjii+X2wcWb/ohL5STsH+FU/k2hxhI6qto0jfRIqi9
         U60A==
X-Gm-Message-State: ACgBeo0wasWAScIyVh84IJ8Fa7sK9dtVTp9JaqDB9GRFDXABt7ywJFBq
        CtvZ0iuzwruVOV6R+yxIoye1M2OXJnLPlHbTLGsvtMq+4ryn
X-Google-Smtp-Source: AA6agR4G+2RJEc8PzKhAui1YtBAmQQ/djA7Qx7o3vXDK+m4zM5uAPVxymfJ7yXyhihTQ4UY5XbCjyujzl5MDHdc3LumQx9IWqp2S
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:2ec:8f2f:be1c with SMTP id
 w2-20020a056e021a6200b002ec8f2fbe1cmr10159728ilv.176.1662369627098; Mon, 05
 Sep 2022 02:20:27 -0700 (PDT)
Date:   Mon, 05 Sep 2022 02:20:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bd49d05e7ea9773@google.com>
Subject: [syzbot] BUG: corrupted list in hci_register_dev
From:   syzbot <syzbot+e32111a3390bdf27b0c9@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b27a3ca08ba7 Add linux-next specific files for 20220829
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a9cf13080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2eb01587c47db4c
dashboard link: https://syzkaller.appspot.com/bug?extid=e32111a3390bdf27b0c9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e32111a3390bdf27b0c9@syzkaller.appspotmail.com

list_add corruption. prev->next should be next (ffff888145f20188), but was ffff88807c3000c8. (prev=ffff88807cf2d8c8).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:30!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18538 Comm: kworker/1:19 Not tainted 6.0.0-rc3-next-20220829-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events vhci_open_timeout
RIP: 0010:__list_add_valid.cold+0x56/0x58 lib/list_debug.c:30
Code: 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 00 31 49 8a e8 76 d5 f0 ff 0f 0b 48 89 f1 48 c7 c7 80 30 49 8a 4c 89 e6 e8 62 d5 f0 ff <0f> 0b 4c 89 e1 48 89 ee 48 c7 c7 e0 32 49 8a e8 4e d5 f0 ff 0f 0b
RSP: 0018:ffffc90005ed7af0 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffff88806558fcc0 RCX: 0000000000000000
RDX: ffff88807e7a8000 RSI: ffffffff816204f8 RDI: fffff52000bdaf50
RBP: ffff88806558fcc8 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000000000001 R11: 6464615f7473696c R12: ffff888145f20188
R13: ffff88807cf2d8c8 R14: ffff888145f20190 R15: ffff888145f20188
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcdeb19cd0 CR3: 000000000bc8e000 CR4: 00000000003526e0
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 add_tail lib/klist.c:104 [inline]
 klist_add_tail+0x158/0x2a0 lib/klist.c:137
 device_add+0xda7/0x1e90 drivers/base/core.c:3534
 hci_register_dev+0x2f6/0xbb0 net/bluetooth/hci_core.c:2593
 __vhci_create_device+0x393/0x7d0 drivers/bluetooth/hci_vhci.c:336
 vhci_create_device drivers/bluetooth/hci_vhci.c:374 [inline]
 vhci_open_timeout+0x38/0x50 drivers/bluetooth/hci_vhci.c:531
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid.cold+0x56/0x58 lib/list_debug.c:30
Code: 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 00 31 49 8a e8 76 d5 f0 ff 0f 0b 48 89 f1 48 c7 c7 80 30 49 8a 4c 89 e6 e8 62 d5 f0 ff <0f> 0b 4c 89 e1 48 89 ee 48 c7 c7 e0 32 49 8a e8 4e d5 f0 ff 0f 0b
RSP: 0018:ffffc90005ed7af0 EFLAGS: 00010282
RAX: 0000000000000075 RBX: ffff88806558fcc0 RCX: 0000000000000000
RDX: ffff88807e7a8000 RSI: ffffffff816204f8 RDI: fffff52000bdaf50
RBP: ffff88806558fcc8 R08: 0000000000000075 R09: 0000000000000000
R10: 0000000000000001 R11: 6464615f7473696c R12: ffff888145f20188
R13: ffff88807cf2d8c8 R14: ffff888145f20190 R15: ffff888145f20188
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcdeb19cd0 CR3: 000000000bc8e000 CR4: 00000000003526e0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
