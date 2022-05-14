Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF452703C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiENJUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiENJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:20:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038802BB1E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:20:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t1-20020a056602140100b0065393cc1dc3so6433768iov.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cSNHYl5zll4AYOJuUlvp5qhbSyn60AyhXFgJHcsX4G0=;
        b=z+LiDlD/SsUAJPQ+N/xlW8UdnPpnlFpWs7zcaQJKdI0EDoR/f1EL/ah6ecylaj0A6k
         KKY/o0NwRVLgxhNPoU/XUdq0HyFcUC2bKKL+LccDxnllMUUTSvUKONQiVrq6ftAPMySS
         i6GdAgtLXCHdRGcwHGeEPFWdDJL7QlN4sugUyIlRQdmRsxN4CHMbxKGi4BraEqFzWIRA
         yx682kzus5V9Z3ZOgPXfvNjKcAz6TUHsUIMoRqVHlc6O9+kSs+kA/cu7bp0QDrngCiIl
         Cj8Xj6FMxoqstZiEIQRnjGCeMNkr/OMicubOt9ifudHMYG+QhZ6n3GqxMbdKKkPdZlLi
         /zUw==
X-Gm-Message-State: AOAM531aLuqKrQ1wxuqnYndNvFzwr2MlfNqTxBJ7SuYLnPw8WOcdGdyH
        mrZn2tBwOYRUncm4hFmMmsAArpf7uMtvDT3Q2l5L5tbMR/hv
X-Google-Smtp-Source: ABdhPJwqMq4HX31jXiNnxDsW+KaUa1VjK235DqByKJId38yclXdvfs9ga/3h5Ww8+wwCTl8yXvNwcSIv/YRU3YEn6h7Lsz+CZmND
MIME-Version: 1.0
X-Received: by 2002:a92:194c:0:b0:2c8:2a07:74e7 with SMTP id
 e12-20020a92194c000000b002c82a0774e7mr4494081ilm.272.1652520008419; Sat, 14
 May 2022 02:20:08 -0700 (PDT)
Date:   Sat, 14 May 2022 02:20:08 -0700
In-Reply-To: <20220514084129.1104-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016121805def54c0a@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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
WARNING in mntput_no_expire

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffeaa23bc1f R14: 00007fbb0b9ee300 R15: 0000000000022000
 </TASK>
cgroup: cgroup_addrm_files: failed to add max, err=-12
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4705 at fs/namespace.c:1225 mntput_no_expire+0x979/0xfe0 fs/namespace.c:1225
Modules linked in:
CPU: 1 PID: 4705 Comm: syz-executor.1 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0x979/0xfe0 fs/namespace.c:1225
Code: 04 00 00 48 8b 35 af a3 dd 0b b9 01 00 00 00 bf 08 00 00 00 48 c7 c2 60 fe f0 8b e8 e1 0c 72 ff e9 01 f9 ff ff e8 d7 be 9d ff <0f> 0b e9 b6 f8 ff ff e8 cb be 9d ff 0f 0b e9 aa f8 ff ff e8 bf be
RSP: 0018:ffffc90005887b08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880687e1d80 RSI: ffffffff81db8209 RDI: 0000000000000003
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81db7aa8 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888073407200 R14: dffffc0000000000 R15: ffffed100e680e4a
FS:  00007fbb0b9ee700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe756d5ff8 CR3: 0000000075509000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mntput+0x67/0x90 fs/namespace.c:1288
 __fput+0x3ba/0x9d0 fs/file_table.c:333
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 get_signal+0x1c5/0x24c0 kernel/signal.c:2641
 arch_do_signal_or_restart+0x82/0x20f0 arch/x86/kernel/signal.c:867
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbb0a8890e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb0b9ee168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: fffffffffffffff4 RBX: 00007fbb0a99c030 RCX: 00007fbb0a8890e9
RDX: 0000000000000006 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007fbb0b9ee1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007ffeaa23bc1f R14: 00007fbb0b9ee300 R15: 0000000000022000
 </TASK>


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13f70966f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1668ee31f00000

