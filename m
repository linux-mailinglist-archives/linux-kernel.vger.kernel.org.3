Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6159BB37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiHVISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiHVISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:18:41 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DD1276C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:18:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id x9-20020a056602210900b006897b3869e4so3166910iox.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=1iYF7Owrbe1QC0mi1CzjUmfXmKZlI8V18K28aWI+DSE=;
        b=lCMrSSBx6v0n7WOXAkLDzhgAwW0w0oeCCWH+h9oJyN2pTL/avi9qZf+NvL9hXr4m1Z
         MN9uO0eS5EQFL6BPj3JpyRGYYZrjSOzUKZ7xDFtKyxCnPWypyw3e1Nm9G89gHtFQDNfZ
         9ANH5Zkn2JoWU/jHMrqTFJQoklkx9yMgcxc+3YxyFdD0KDzM+39IiudzDMBqu7NfCPk8
         fCfkzrYk4yf3KUaTI5txU9ObF9f1b3vLL4kLjjyR6ESDaoH5J7ToCXJWt0p8dfbM62XT
         1u/s6T+m0MKJXfAkOP2UiMk9xQqPJMIIoc2+QqZ1nBhvtnSAFUtjzfPOeT/rC27FpJe5
         0MzQ==
X-Gm-Message-State: ACgBeo3FVlaJWfBXU+j9OgfL366Eh1/ZLRG2izSlgrEuwU25Yzlp90ok
        lSgj2lk2qX4Vhc4lHwc0hPeQEZ7AeuAq2Xdictbg6rMW3gZi
X-Google-Smtp-Source: AA6agR6pHFPnFANG+CDkfNJqTwAGVmg2VG9mJUpoM24MSGzBSXaH9E25yMZQQcw/p+PgBCDtiSw1ebOZu0Nqu95mELFdyG4bzpka
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c1:b0:688:6a81:8d91 with SMTP id
 l1-20020a05660227c100b006886a818d91mr8538746ios.189.1661156312516; Mon, 22
 Aug 2022 01:18:32 -0700 (PDT)
Date:   Mon, 22 Aug 2022 01:18:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec8f5c05e6d0175f@google.com>
Subject: [syzbot] usb-testing boot error: BUG: corrupted list in pick_next_task_fair
From:   syzbot <syzbot+b637b6748f2b5dc92271@syzkaller.appspotmail.com>
To:     Henry.Wang@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        longpeng2@huawei.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vschneid@redhat.com
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

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc503d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=b637b6748f2b5dc92271
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b637b6748f2b5dc92271@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff88810b71d628, but was ffff000000000000. (next=ffff88810e7380a8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:62!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__list_del_entry_valid.cold+0x70/0x72 lib/list_debug.c:62
Code: fc ff 0f 0b 4c 89 ea 48 89 ee 48 c7 c7 40 b4 62 86 e8 c7 1e fc ff 0f 0b 4c 89 e9 48 89 ee 48 c7 c7 80 b5 62 86 e8 b3 1e fc ff <0f> 0b 83 c3 01 b8 ff ff 37 00 89 1d 22 2a ce 05 48 c1 e0 2a 65 48
RSP: 0000:ffffc9000014fd58 EFLAGS: 00010082
RAX: 000000000000006d RBX: ffff8881f6937b00 RCX: 0000000000000000
RDX: ffff888100365580 RSI: ffffffff812c97e8 RDI: fffff52000029f9d
RBP: ffff88810b71d628 R08: 000000000000006d R09: 0000000000000000
R10: 0000000080000002 R11: 000000000000004e R12: ffff8881f69385e8
R13: ffff88810e7380a8 R14: ffff8881f69385e8 R15: ffffc9000014fe30
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:134 [inline]
 list_move include/linux/list.h:217 [inline]
 pick_next_task_fair+0x170/0xf80 kernel/sched/fair.c:7468
 __pick_next_task kernel/sched/core.c:5804 [inline]
 pick_next_task kernel/sched/core.c:6313 [inline]
 __schedule+0x3a3/0x26f0 kernel/sched/core.c:6458
 schedule+0xda/0x1b0 kernel/sched/core.c:6570
 smpboot_thread_fn+0x2eb/0x9c0 kernel/smpboot.c:160
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid.cold+0x70/0x72 lib/list_debug.c:62
Code: fc ff 0f 0b 4c 89 ea 48 89 ee 48 c7 c7 40 b4 62 86 e8 c7 1e fc ff 0f 0b 4c 89 e9 48 89 ee 48 c7 c7 80 b5 62 86 e8 b3 1e fc ff <0f> 0b 83 c3 01 b8 ff ff 37 00 89 1d 22 2a ce 05 48 c1 e0 2a 65 48
RSP: 0000:ffffc9000014fd58 EFLAGS: 00010082
RAX: 000000000000006d RBX: ffff8881f6937b00 RCX: 0000000000000000
RDX: ffff888100365580 RSI: ffffffff812c97e8 RDI: fffff52000029f9d
RBP: ffff88810b71d628 R08: 000000000000006d R09: 0000000000000000
R10: 0000000080000002 R11: 000000000000004e R12: ffff8881f69385e8
R13: ffff88810e7380a8 R14: ffff8881f69385e8 R15: ffffc9000014fe30
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
