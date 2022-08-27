Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9D5A38BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiH0QTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0QTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:19:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4AB31372;
        Sat, 27 Aug 2022 09:19:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3321c2a8d4cso103891367b3.5;
        Sat, 27 Aug 2022 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ZzCEDZFGy7crEWv5aADYRIqm1rYHEXZLuiymaAeTJxQ=;
        b=N4SAZdNQYeRw7VOrbqSr3moyahCLBIey9UEE+ExNf5sq4cwLCWiUL/YOuOBJnamWfr
         /BSZWt491psVDWOl9apza+FdnRg3Pu43PqZMB4MkDTB+3E3jH9IwQt0gig56gSAFZzD8
         flZN4Z444ffI4+TasX86VTkCHhmsC2udFwnHxkx8QD3dn8MwNM+ObEhuJUwTvBZpY4LE
         Of9N3U+DKypyH7yogLOWJaPjqxywciEwZS4sTQsBd0Fa06FXeAaUVMF8FjXKymnedbWm
         bu1GzmkGjQx9CfwDvhjh73bMF1pt1hVt8WE32DNeZgjWafpuZt1bMFL0JQfCPc5wN6vl
         XXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZzCEDZFGy7crEWv5aADYRIqm1rYHEXZLuiymaAeTJxQ=;
        b=0+skOGiSG/XfA/XdF3UXCbgzpqTS7+vPVj9m+kZut6BaYiwSsXG1wGqqBNq3JLma0/
         3GNlya7xq+jURdBi9pdM9U3VYm+1dqRnqsqg/dtyMdVEPmB5J0X1nh/7IUIhf4D1hn8W
         NORnbyOWjhjeuUUMnLqD8GwDmKApyD7/tH4XfXiGmMDX9wKKr7sezHxlFso8qs5ck9xz
         Yrdi/+a03iIzJpPfSZ7fbK6epu2RLPGXZ8t/U9/2A8c7nrydifzbx9JkvEKD2N5cS1i2
         RJ8absgF6LbQEt0aWqlC1q7E4YOtgkh6DxYSiQu1ognB7gPYbVWbjI0ycGMBdPwDP7Ei
         1tVQ==
X-Gm-Message-State: ACgBeo21GzTO4ydYV02871jKStwkoBXSCtG+SbLEsOrMKQKOyUPe0GlL
        mdM/RwD51U1WuS3M2AV2Tb9DzkagutHhtdewK7OX8Txx3jODXw==
X-Google-Smtp-Source: AA6agR5eUmt1vQxqIfXM06JV5cWcKQQLp1xI0nYcwyjK016xTVEO9FyyRV+2SpAgo2bFydKJ91nlqMPURe5r2WmCaGQ=
X-Received: by 2002:a05:6902:100b:b0:695:c64a:ab62 with SMTP id
 w11-20020a056902100b00b00695c64aab62mr3991400ybt.552.1661617169435; Sat, 27
 Aug 2022 09:19:29 -0700 (PDT)
MIME-Version: 1.0
From:   Jiacheng Xu <578001344xu@gmail.com>
Date:   Sun, 28 Aug 2022 00:19:16 +0800
Message-ID: <CAO4S-me4hoy0W6GASU3tOFF16+eaotxPbw+kqyc6vuxtxJyDZg@mail.gmail.com>
Subject: possible deadlock in rfcomm_sk_state_change
To:     linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using modified Syzkaller to fuzz the Linux kernel-5.19, the
following crash was triggered.
We would appreciate a CVE ID if this is a security issue.

HEAD commit: 3d7cb6b04c3f Linux-5.19
git tree: upstream

console output:
https://drive.google.com/file/d/1NmOGWcfPnY2kSrS0nOwvG1AZ923jFQ3p/view?usp=sharing
kernel config: https://drive.google.com/file/d/1wgIUDwP5ho29AM-K7HhysSTfWFpfXYkG/view?usp=sharing
syz repro: https://drive.google.com/file/d/16hUTEGw4IcPQA9CZvoF7I5la42TlU-Cx/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1YvgzTvV4qaSZPiD4D1IWGL4GuapzHD2w/view?usp=sharing

Environment:
Ubuntu 20.04 on Linux 5.4.0
QEMU 4.2.1:
qemu-system-x86_64 \
  -m 2G \
  -smp 2 \
  -kernel /home/workdir/bzImage \
  -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
  -drive file=/home/workdir/stretch.img,format=raw \
  -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
  -net nic,model=e1000 \
  -enable-kvm \
  -nographic \
  -pidfile vm.pid \
  2>&1 | tee vm.log

If you fix this issue, please add the following tag to the commit:
Reported-by Jiacheng Xu<578001344xu@gmail.com>

============================================
WARNING: possible recursive locking detected
5.19.0 #1 Not tainted
--------------------------------------------
syz-executor/9064 is trying to acquire lock:
ffff888026b13130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0},
at: lock_sock include/net/sock.h:1677 [inline]
ffff888026b13130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0},
at: rfcomm_sk_state_change+0x6e/0x3a0 net/bluetooth/rfcomm/sock.c:73

but task is already holding lock:
ffff888026b13130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0},
at: lock_sock include/net/sock.h:1677 [inline]
ffff888026b13130 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0},
at: rfcomm_sock_shutdown+0x57/0x220 net/bluetooth/rfcomm/sock.c:902

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor/9064:
 #0: ffff888110dac410 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:741 [inline]
 #0: ffff888110dac410 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at:
__sock_release+0x86/0x280 net/socket.c:649
 #1: ffff888026b13130
(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock
include/net/sock.h:1677 [inline]
 #1: ffff888026b13130
(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at:
rfcomm_sock_shutdown+0x57/0x220 net/bluetooth/rfcomm/sock.c:902
 #2: ffffffff8d7d8428 (rfcomm_mutex){+.+.}-{3:3}, at:
rfcomm_dlc_close+0x34/0x240 net/bluetooth/rfcomm/core.c:507
 #3: ffff8880155d2d28 (&d->lock){+.+.}-{3:3}, at:
__rfcomm_dlc_close+0x157/0x710 net/bluetooth/rfcomm/core.c:487

stack backtrace:
CPU: 0 PID: 9064 Comm: syz-executor Not tainted 5.19.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2988 [inline]
 check_deadlock kernel/locking/lockdep.c:3031 [inline]
 validate_chain kernel/locking/lockdep.c:3816 [inline]
 __lock_acquire.cold+0x152/0x3ca kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5630
 lock_sock_nested+0x36/0xf0 net/core/sock.c:3389
 lock_sock include/net/sock.h:1677 [inline]
 rfcomm_sk_state_change+0x6e/0x3a0 net/bluetooth/rfcomm/sock.c:73
 __rfcomm_dlc_close+0x1ab/0x710 net/bluetooth/rfcomm/core.c:489
 rfcomm_dlc_close+0x1ea/0x240 net/bluetooth/rfcomm/core.c:520
 __rfcomm_sock_close+0xda/0x260 net/bluetooth/rfcomm/sock.c:220
 rfcomm_sock_shutdown+0xf4/0x220 net/bluetooth/rfcomm/sock.c:905
 rfcomm_sock_release+0x5f/0x140 net/bluetooth/rfcomm/sock.c:925
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xe0/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaf5/0x2da0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x2842/0x2870 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2270 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x174/0x260 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f26c3295dfd
Code: Unable to access opcode bytes at RIP 0x7f26c3295dd3.
RSP: 002b:00007f26c43fcc58 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f26c33bc0a0 RCX: 00007f26c3295dfd
RDX: 0000000000000080 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f26c32ff4c1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f26c33bc0a0
R13: 00007ffc2c88f2df R14: 00007ffc2c88f480 R15: 00007f26c43fcdc0
 </TASK>
