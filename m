Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6954451F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiFIHuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiFIHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:50:33 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265CC687C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:50:32 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso17207128ilo.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UTrdcwVGYZBfRqJEg/qIbaLEhJKmxhweso7R79qIqH0=;
        b=dJyC2tj/KBZ8CrMJnr5GSKQnu2PvQNY2RVVfYWnvW6hRVo6LAdTSQiQl71mifjBSUJ
         cI+QdZ9k2rvPnxgShFiNtJVqoO7f1R1TGflRceKW+sEiJkDRvNcXXt5h1vEr+IzkJaqV
         4BqXh0U62NWi2xb3V3HbRCmiQ1+UWLmmT+MR4AKDaCj1436gKkFX2sdiDeC773ybUeDE
         RdLex4JOZUl6UcAMNKTlQm2P3HkcnaNup2SrIaA9W+g7Iu22WeJiHssvkBVlb0Uj0oc2
         eajbBvSLAVIR7Df0zv+bt6D8r37Yur+Iiu742r8TjmAAfo9DTkYD2ANCaR/XjRNx5bWS
         WWAA==
X-Gm-Message-State: AOAM532+PO4pW6aIjgezaBkXlzCG85LEReUDdU7takL+aMgi/UB6ofLT
        AP9bqmSCMvCZOf4EOfsvfb5+WlyRDZ9egR/oywL7/YAfm2CI
X-Google-Smtp-Source: ABdhPJwjiHptorZizX/hT6ZuZbLjnZ5UbdLOEVd5N1fZtBLUID+zQATZmRLdgvdqCE9QezYdtOIdy8y1vpMlzUh01N9J0yE7hCOu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b0:b0:32e:dfe3:10bf with SMTP id
 b16-20020a05663801b000b0032edfe310bfmr21024823jaq.188.1654761031748; Thu, 09
 Jun 2022 00:50:31 -0700 (PDT)
Date:   Thu, 09 Jun 2022 00:50:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c525005e0ff1382@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in kvm_xen_vcpu_set_attr
From:   syzbot <syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122ece4ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
dashboard link: https://syzkaller.appspot.com/bug?extid=e54f930ed78eb0f85281
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: init active (active state 0) object type: hrtimer hint: xen_timer_callback+0x0/0xb0 arch/x86/kvm/xen.c:1086
WARNING: CPU: 1 PID: 26545 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 1 PID: 26545 Comm: syz-executor.4 Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd c0 5e 28 8a 4c 89 ee 48 c7 c7 a0 52 28 8a e8 74 08 32 05 <0f> 0b 83 05 35 b5 bb 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900160df778 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880565a3b00 RSI: ffffffff8160ef28 RDI: fffff52002c1bee1
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffffffff89cedc20
R13: ffffffff8a285820 R14: ffffffff816a8e30 R15: ffffffff911293e0
FS:  00007f720c5f2700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020402000 CR3: 000000004040a000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_object_init+0x524/0xd10 lib/debugobjects.c:590
 debug_hrtimer_init kernel/time/hrtimer.c:414 [inline]
 debug_init kernel/time/hrtimer.c:468 [inline]
 hrtimer_init+0x23/0x2b0 kernel/time/hrtimer.c:1592
 kvm_xen_init_timer arch/x86/kvm/xen.c:168 [inline]
 kvm_xen_vcpu_set_attr+0x1ca/0x16c0 arch/x86/kvm/xen.c:716
 kvm_arch_vcpu_ioctl+0x1bcd/0x39f0 arch/x86/kvm/x86.c:5695
 kvm_vcpu_ioctl+0x973/0xf30 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4100
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f720b489109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f720c5f2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f720b59c030 RCX: 00007f720b489109
RDX: 0000000020003680 RSI: 000000004048aecb RDI: 000000000000000b
RBP: 00007f720b4e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f720bacfb1f R14: 00007f720c5f2300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
