Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B456958CABE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiHHOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbiHHOta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:49:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7225DDE82
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:49:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso4689574ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 07:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=am3sHbEwW+ZWO2QgZi3pU3wZ+Quj0eC3MzjWRkHQ6Zw=;
        b=Wjnu6INgzIOwQwCF/AHZW9kav6gtDPA9Ir1/PHu/Li08+++ChC7V4K8jBM5o3FI4V8
         ihEdKyNt0LDdjYXRXWgz4ixqn303CJMOWSXnhkB6fKTrIqjGIFlRY2chky7POR1Z4Gg8
         oDEol/jac4kh2zepijpAbNns/jHAC7Rh2vFjMbqiFEtWd1tKPTTCG1GpYuTQwwvq2kgH
         /SDnDyT6Ci2pWr0BIeJv03rQUse9ygfEqAo8IXbigj8BWfMM4+PC1XjseFUg3DfXa4Cp
         Izu6OWN5EYON4aDtKpxIrv577QYXrgdXoYVGwAOp5OOKf3rSZ9G/cB2vUsX/6AvAPmWM
         fSUQ==
X-Gm-Message-State: ACgBeo3At/pYjFPezpvBxPDqTv7FKKI/B20l4vDMJ3mwWNEQHrjwi6QV
        irXyzhM2L4/bWuEZnOcA5Yd0z2PqDwpsgwA1aMnn0WMDO3+F
X-Google-Smtp-Source: AA6agR57SUCwZPjlt/ykE1w5W61DzIBVRbHPqe1OzVPcw0pu2eqwWWJpnO2AtXkS2XMtlAAz1Q13hl38I3vDvcPqk/1SFiBtljja
MIME-Version: 1.0
X-Received: by 2002:a02:6d24:0:b0:33f:7beb:6b1 with SMTP id
 m36-20020a026d24000000b0033f7beb06b1mr8062952jac.86.1659970164413; Mon, 08
 Aug 2022 07:49:24 -0700 (PDT)
Date:   Mon, 08 Aug 2022 07:49:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcdce705e5bbebfa@google.com>
Subject: [syzbot] WARNING in hrtimer_init
From:   syzbot <syzbot+fd406bb2745861bd67e8@syzkaller.appspotmail.com>
To:     dwmw@amazon.co.uk, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=102f0876080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b664fba5e66c4bf
dashboard link: https://syzkaller.appspot.com/bug?extid=fd406bb2745861bd67e8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d9918e080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118d9951080000

The issue was bisected to:

commit 536395260582be7443b0b35b0bbb89ffe3947f62
Author: Joao Martins <joao.m.martins@oracle.com>
Date:   Thu Mar 3 15:41:22 2022 +0000

    KVM: x86/xen: handle PV timers oneshot mode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14713d46080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16713d46080000
console output: https://syzkaller.appspot.com/x/log.txt?x=12713d46080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd406bb2745861bd67e8@syzkaller.appspotmail.com
Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: hrtimer hint: xen_timer_callback+0x0/0xb0 include/linux/rcupdate.h:281
WARNING: CPU: 1 PID: 3601 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 3601 at lib/debugobjects.c:505 __debug_object_init+0xae3/0x1860 lib/debugobjects.c:590
Modules linked in:
CPU: 1 PID: 3601 Comm: syz-executor171 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:debug_print_object lib/debugobjects.c:502 [inline]
RIP: 0010:__debug_object_init+0xae3/0x1860 lib/debugobjects.c:590
Code: 89 ff e8 40 6e a5 fd 4d 8b 07 48 c7 c7 60 b0 e9 8a 48 c7 c6 c0 ae e9 8a 48 89 da 44 89 f1 4c 8b 4c 24 18 31 c0 e8 2d d6 1a fd <0f> 0b 4c 8b 64 24 48 ff 05 4c 7f ce 09 48 8b 9c 24 b0 00 00 00 48
RSP: 0018:ffffc900030df3a0 EFLAGS: 00010246
RAX: 1a852b5f5a7fcb00 RBX: ffffffff8ae9b1c0 RCX: ffff888027671d80
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900030df588 R08: ffffffff816c1ccd R09: fffff5200061bdf1
R10: fffff5200061bdf1 R11: 1ffff9200061bdf0 R12: ffff88802733af2c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffffff8a8f8840
FS:  0000555556fce300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e1f0266048 CR3: 000000001fc5d000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_hrtimer_init kernel/time/hrtimer.c:414 [inline]
 debug_init kernel/time/hrtimer.c:468 [inline]
 hrtimer_init+0x20/0x40 kernel/time/hrtimer.c:1592
 kvm_xen_init_timer arch/x86/kvm/xen.c:168 [inline]
 kvm_xen_vcpu_set_attr+0x82c/0x11a0 arch/x86/kvm/xen.c:716
 kvm_arch_vcpu_ioctl+0x1651/0x2680 arch/x86/kvm/x86.c:5715
 kvm_vcpu_ioctl+0x6d5/0xcf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4104
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc97e717e99
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe56856698 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc97e717e99
RDX: 0000000020000000 RSI: 000000004048aecb RDI: 0000000000000007
RBP: 00007fc97e6dbdb0 R08: 0000000000000012 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc97e6dbe40
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
