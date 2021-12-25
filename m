Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF147F3EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhLYQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:56:17 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45583 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:56:16 -0500
Received: by mail-il1-f197.google.com with SMTP id k14-20020a056e021a8e00b002b4b2388c48so6170169ilv.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LZ85zs7UbC00u/OM5zrLGntNtou/HLcWoZgXMiysNFw=;
        b=YKnM3F/fuHSjdgMKSp869LP/r/M3s5bAxHSR0sxYB9X8l5n9VEsP+qcygzl7eKKAXT
         6RhxZbeoJLjplghUhFWnO8UGylWHtyuhrMWoGDCQIAglMdp4K46aOPdQEvMrRQ0vcacs
         ciE43EOyCDxRWgnLm9ELx6jd6yO1nL+BJmUq0XGdlJhdB8j6VJsniRu1Ruv4SMgcFAvy
         6cyRRc9pigHysWvg7Zun8MNEQ620PtQ7myivzhtZpgv66ewQAKWL4micRM4RxW6wlMyJ
         WlS2qNxHNCSY3nD7cGh0eGdBiHFwLMUtnrS765SRHzZivqPBcqCoI4A3L1H0AMtoj3Yw
         w5TQ==
X-Gm-Message-State: AOAM531o/n/sxiFks3Vc+vksQI3rY14Zs6iGkmvW2kf9oTFG3X2MtoX2
        /MOn3ihAs/oYQewdYr0Ocu5r0wdKjA43XMXFhdsRMzVi4ObK
X-Google-Smtp-Source: ABdhPJwyhrqW5eugjWkaVTs5R1j1sJSma1SgbZxdpddKB5lcH9YqW/iijN5GYp0iJnaO6aDZfrR1CI6USF2l1c29bK37EKUgHRCc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8:: with SMTP id z8mr5075267jao.199.1640451376043;
 Sat, 25 Dec 2021 08:56:16 -0800 (PST)
Date:   Sat, 25 Dec 2021 08:56:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a5baf05d3fb593e@google.com>
Subject: [syzbot] WARNING in vmx_queue_exception
From:   syzbot <syzbot+82112403ace4cbd780d8@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6e0567b73052 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128c1adbb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6104739ac5f067ea
dashboard link: https://syzkaller.appspot.com/bug?extid=82112403ace4cbd780d8
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82112403ace4cbd780d8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 28019 at arch/x86/kvm/vmx/vmx.c:1616 vmx_queue_exception+0x2f2/0x440 arch/x86/kvm/vmx/vmx.c:1616
Modules linked in:
CPU: 1 PID: 28019 Comm: syz-executor.5 Not tainted 5.16.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:vmx_queue_exception+0x2f2/0x440 arch/x86/kvm/vmx/vmx.c:1616
Code: 41 5e 41 5f 5d e9 de b3 fd ff e8 79 22 60 00 eb 05 e8 72 22 60 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 5e 22 60 00 <0f> 0b e9 78 fe ff ff 89 f9 80 e1 07 38 c1 0f 8c 35 fd ff ff e8 15
RSP: 0018:ffffc90010587450 EFLAGS: 00010287
RAX: ffffffff812469b2 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc900051ea000 RSI: 0000000000001923 RDI: 0000000000001924
RBP: 0000000000000000 R08: ffffffff81246824 R09: ffffed100645904d
R10: ffffed100645904d R11: 0000000000000000 R12: ffff8880322c8000
R13: dffffc0000000000 R14: 0000000000000006 R15: 0000000080000006
FS:  00007fe6788f8700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f4bcd8058 CR3: 0000000087d66000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvm_inject_exception arch/x86/kvm/x86.c:9071 [inline]
 inject_pending_event arch/x86/kvm/x86.c:9145 [inline]
 vcpu_enter_guest+0x19aa/0x9df0 arch/x86/kvm/x86.c:9801
 vcpu_run+0x4d3/0xe50 arch/x86/kvm/x86.c:10055
 kvm_arch_vcpu_ioctl_run+0x494/0xb20 arch/x86/kvm/x86.c:10250
 kvm_vcpu_ioctl+0x894/0xe20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3727
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe679fa3e99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6788f8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe67a0b7030 RCX: 00007fe679fa3e99
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000000f
RBP: 00007fe679ffdff1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe39ef7acf R14: 00007fe6788f8300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
