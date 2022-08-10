Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D8858E727
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiHJGNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHJGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:13:22 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EFB60695
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:13:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id w6-20020a6bf006000000b006845b59a08bso5968708ioc.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 23:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=E+Mvi8z+W8TnkH/xD+yD2aHEkFWueZO6v0An11czXsI=;
        b=prwXjOKqwFu11HroVEkgDVRAxJctgJ4JQao6SzAusxE0BF4GmMtcoV3ECkGf/PTgMg
         RB9HwzhbeC6wMCZ+BxcGKZHuDwgeE1xbahqkyCxy0NI+a0ZpIL4+gcPM9VrN69jpYihd
         p+El/9/+IOLnrYVxAZhiRKo5/4vUF+OWtb9u/cWqWwjavD+Twy3gr9JGAYPYS9MD64t1
         bD/KF4XWKHROyUcW/Z9Oq5gVgkt8XT3m8Q82GPl9wkNgR+87eQDrMVp+ElsxO0wFo9va
         EuWYOioxuTiFZXsqWFmWhr2QRIatnKSMWQ7H6as0WP2LfevggF2iNekGLCpngBRFSZbm
         RBUg==
X-Gm-Message-State: ACgBeo0eKv9AdZzSIeDtHwgir3X6wfi3Dewv87rDddWhC9c3BavmWj4s
        hmW+8t8WyYeYYifv7CxyRzRhAtLhdjn+6XJAV6Ae5qmXHZ+6
X-Google-Smtp-Source: AA6agR7Qa+ODpr/kS0RkfSrK24swAnoVqccHrbP4x+0+SNQ+P5YRFwiz7EA5wSJ4FFi4sVsVYlu+uEtW39hM2GQQAqHPvtwTV1k7
MIME-Version: 1.0
X-Received: by 2002:a92:c543:0:b0:2df:bf0d:1512 with SMTP id
 a3-20020a92c543000000b002dfbf0d1512mr8660026ilj.240.1660112001243; Tue, 09
 Aug 2022 23:13:21 -0700 (PDT)
Date:   Tue, 09 Aug 2022 23:13:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f242e05e5dcf211@google.com>
Subject: [syzbot] KMSAN: uninit-value in stack_trace_consume_entry
From:   syzbot <syzbot+227ae323c9d4c04c300a@syzkaller.appspotmail.com>
To:     glider@google.com, jpoimboe@redhat.com, jslaby@suse.cz,
        kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        mbenes@suse.cz, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    a58741ac26cc kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13325fe3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abbc202e1724cf37
dashboard link: https://syzkaller.appspot.com/bug?extid=227ae323c9d4c04c300a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e2bc23e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14915203e00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+227ae323c9d4c04c300a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in stack_trace_consume_entry+0x171/0x310 kernel/stacktrace.c:89
CPU: 1 PID: 10926 Comm: syz-executor854 Not tainted 5.6.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 stack_trace_consume_entry+0x171/0x310 kernel/stacktrace.c:89
 arch_stack_walk+0x317/0x3e0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x117/0x1a0 kernel/stacktrace.c:123
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 sock_write_iter+0x4f6/0x6d0 net/socket.c:1005
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443dd9
Code: e8 2c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffb6d37698 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443dd9
RDX: 0000000000000018 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007fffb6d376b0 R08: 0000000101bbbbbb R09: 0000000101bbbbbb
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000404c80 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 stack_trace_consume_entry+0x27a/0x310 kernel/stacktrace.c:90
 arch_stack_walk+0x317/0x3e0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x117/0x1a0 kernel/stacktrace.c:123
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 sock_write_iter+0x4f6/0x6d0 net/socket.c:1005
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 stack_trace_save+0x193/0x1a0 kernel/stacktrace.c:117
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 kmsan_memcpy_memmove_metadata+0x272/0x2e0 mm/kmsan/kmsan.c:247
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:267
 __msan_memcpy+0x43/0x50 mm/kmsan/kmsan_instr.c:116
 sock_write_iter+0x4f6/0x6d0 net/socket.c:1005
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2793 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4401
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1081 [inline]
 alloc_skb_with_frags+0x18c/0xa70 net/core/skbuff.c:5764
 sock_alloc_send_pskb+0xada/0xc60 net/core/sock.c:2245
 packet_alloc_skb net/packet/af_packet.c:2816 [inline]
 packet_snd net/packet/af_packet.c:2911 [inline]
 packet_sendmsg+0x66a0/0x93b0 net/packet/af_packet.c:2993
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 sock_write_iter+0x6bc/0x6d0 net/socket.c:1004
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0xa5a/0xca0 fs/read_write.c:496
 vfs_write+0x44a/0x8f0 fs/read_write.c:558
 ksys_write+0x267/0x450 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write+0x92/0xb0 fs/read_write.c:620
 __x64_sys_write+0x4a/0x70 fs/read_write.c:620
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
