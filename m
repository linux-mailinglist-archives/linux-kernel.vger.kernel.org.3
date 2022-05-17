Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867BB52AB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352317AbiEQSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352333AbiEQSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:44:12 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D728E04
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:44:11 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e3-20020a056e020b2300b002d10200d90fso5148098ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eFDTuSie96x9bOH1fl5bJ6quL4k/UvgjH4eylB8bN6w=;
        b=iasINs6jdhKnxedFydbFJOsZqEpT7KhgHJJyYu4zZZof460kw8hc9DS3rLasiCk+Ls
         XnsWxEeRVgIjq3PfwSH7uf6TFb7fM++NW6xXfYpkYM7k0l0l4SxbyZ/Bz61kwFz0hwGb
         BgghbK9NyBokbK2G2RBEE0lERiJXDYee047M3ViINS5ZJNXX0Af/1FKixsz6J/9fJdOq
         1KBnrrvMPy0JFEHhYtUU1op/+t2kdDA7gKhjKeZtBpwcOpCugO56Ntt1fNhmRC5sJAgW
         MLmxQT3yUMhkH2zeYOp6llqvNPLY2mM+iTgelQMddPR1Q7uLAQslpoh0AMmbIfzUs5Zj
         Yx9g==
X-Gm-Message-State: AOAM533wTuk5Mf0IgW3q/wf73FTLDOkkSicxzhGB4EWmNMLQqDlZCNRU
        +z+egUkMPX/4BiK61JXmvJuADrurTdsfT9HM/hhyE1T2KJwz
X-Google-Smtp-Source: ABdhPJzbfsX6vQgsLZ8uyfJsXF0374MKJ9O4Pk84iVIO102w4kEQwSxlbb9+nvReNx+NOoSY1FYnqSasvWn5qwBMTilLvZinZezF
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2393:b0:32e:319d:c7cc with SMTP id
 q19-20020a056638239300b0032e319dc7ccmr6263550jat.103.1652813050526; Tue, 17
 May 2022 11:44:10 -0700 (PDT)
Date:   Tue, 17 May 2022 11:44:10 -0700
In-Reply-To: <8cf1ef4e-03b6-4da2-530f-65058c57a9d1@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1bd6505df39865e@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in io_do_iopoll
From:   syzbot <syzbot+1a0a53300ce782f8b3ad@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in io_do_iopoll

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 4077 Comm: syz-executor.0 Not tainted 5.18.0-rc2-syzkaller-00022-ga67f2fc1f9b5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900056478d8 EFLAGS: 00010246
RAX: ffffffff89dad020 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffc90005647950 RDI: ffff88807f0668c0
RBP: ffff88807f066901 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81ec0c20 R11: 0000000000000000 R12: 0000000000000003
R13: ffffc90005647950 R14: ffff88807f0668c0 R15: ffff88807f066938
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_do_iopoll+0x262/0x1080 fs/io_uring.c:2776
 io_iopoll_try_reap_events+0xba/0x158 fs/io_uring.c:2829
 io_ring_ctx_wait_and_kill+0x1d9/0x327 fs/io_uring.c:10170
 io_uring_release+0x42/0x46 fs/io_uring.c:10187
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2a00 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x22df/0x24c0 kernel/signal.c:2864
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:867
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe34b8890e9
Code: Unable to access opcode bytes at RIP 0x7fe34b8890bf.
RSP: 002b:00007fe34c997218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fe34b99bf68 RCX: 00007fe34b8890e9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fe34b99bf6c
RBP: 00007fe34b99bf60 R08: 00007fff26bf1080 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fe34b99bf6c
R13: 00007fff26becbef R14: 00007fe34c997300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc900056478d8 EFLAGS: 00010246
RAX: ffffffff89dad020 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffc90005647950 RDI: ffff88807f0668c0
RBP: ffff88807f066901 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81ec0c20 R11: 0000000000000000 R12: 0000000000000003
R13: ffffc90005647950 R14: ffff88807f0668c0 R15: ffff88807f066938
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         a67f2fc1 io_uring: don't attempt to IOPOLL for MSG_RIN..
git tree:       git://git.kernel.dk/linux-block io_uring-5.18
console output: https://syzkaller.appspot.com/x/log.txt?x=13167865f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e408a5da421f07d4
dashboard link: https://syzkaller.appspot.com/bug?extid=1a0a53300ce782f8b3ad
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
