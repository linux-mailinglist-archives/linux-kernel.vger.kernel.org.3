Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52B536DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbiE1RCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiE1RCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:02:14 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD42718
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:02:13 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id a12-20020a92c54c000000b002d2f39932e8so3983338ilj.19
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 10:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YqLzJ9cfv6TjkWrL8fe4QzMNaUzL13j6Pk/KrOYdA2Q=;
        b=O34fQ5Y2ZEyY2DzZZmQYYJIDFtPS265DrLsa4VE+rJza4LE0zvrhnx8IM3WcT9kOGZ
         E6y+HPwfWtEIOtdNFKzO1cbDgG995egfKBAoyIFCw2j6B8x5jU8RyNBR39AAw4414C6k
         T/xLYoan5RsXUAcob3PmS7n/D69Q4sjDAYZyzwq4ZDIYzUX9kLu7mtUy7+ACFq2lcyvC
         KxXtvEEkVgjvglGdZhvLdFUmT9Et9L/jd316K9wZ/Sditm6m8opn6UA79AKqhbtoydh2
         YLXAzfeGpOHjG8KXy2RGjpZrc05p3QCtQWfd+seyNQ3WtzJ7QbuVO81k8yvqmk/ozlkB
         1FSQ==
X-Gm-Message-State: AOAM530n7Hhls8rogaPcEEAYxGNC2e9YxzyGLcxVONzlopdwSfcgC8aX
        STsbGOpshmB9mcOY5MPrgUJqPou8/4jkuOsuJjuIC55sI61Q
X-Google-Smtp-Source: ABdhPJxujxKADyUZGJq2Vo5tm/+llNn8BeB8yVRk6VqktuH0OdrQqmlphMWK0s7rpkiI5OJxG1/meI6MXc7BOjPlwVpwBR/O5WEa
MIME-Version: 1.0
X-Received: by 2002:a5d:9bda:0:b0:668:5cb0:d91e with SMTP id
 d26-20020a5d9bda000000b006685cb0d91emr2710722ion.92.1653757332647; Sat, 28
 May 2022 10:02:12 -0700 (PDT)
Date:   Sat, 28 May 2022 10:02:12 -0700
In-Reply-To: <YpJNQN6++raKTXS5@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b7a1b05e0156265@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in driver_unregister

------------[ cut here ]------------
Unexpected driver unregister!
WARNING: CPU: 0 PID: 2335 at drivers/base/driver.c:194 driver_unregister drivers/base/driver.c:194 [inline]
WARNING: CPU: 0 PID: 2335 at drivers/base/driver.c:194 driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
Modules linked in:
CPU: 0 PID: 2335 Comm: syz-executor.0 Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:driver_unregister drivers/base/driver.c:194 [inline]
RIP: 0010:driver_unregister+0x8c/0xb0 drivers/base/driver.c:191
Code: 68 4c 89 e7 e8 65 b9 db fe 48 89 ef e8 fd a0 ff ff 5d 41 5c e9 75 fa 78 fe e8 70 fa 78 fe 48 c7 c7 80 7a 81 86 e8 12 96 ee 02 <0f> 0b 5d 41 5c e9 5a fa 78 fe e8 75 93 ad fe eb 96 e8 6e 93 ad fe
RSP: 0018:ffffc9000267fa78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888118006050 RCX: 0000000000000000
RDX: ffff888114fe8000 RSI: ffffffff812bdce8 RDI: fffff520004cff41
RBP: ffff888118006098 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff812b86be R11: 0000000000000000 R12: 0000000000000000
R13: ffff888118006008 R14: ffff88811785e7a8 R15: ffff888100219ca0
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6f40b3718 CR3: 0000000007825000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_gadget_unregister_driver+0x48/0x70 drivers/usb/gadget/udc/core.c:1590
 raw_release+0x18b/0x290 drivers/usb/gadget/legacy/raw_gadget.c:412
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2980 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x22df/0x24c0 kernel/signal.c:2864
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:867
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x156/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc6f417f0e9
Code: Unable to access opcode bytes at RIP 0x7fc6f417f0bf.
RSP: 002b:00007fc6f40b3218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc6f4292108 RCX: 00007fc6f417f0e9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc6f4292108
RBP: 00007fc6f4292100 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc6f429210c
R13: 00007ffd64cd846f R14: 00007fc6f40b3300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16effa13f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13e750ddf00000

