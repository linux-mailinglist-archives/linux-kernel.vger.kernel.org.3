Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153F55D9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiF1Lh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343937AbiF1Lh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:37:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E232EF6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:37:25 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e020d8800b002d931252904so7244192ilj.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nXYR0Ni31x3OMa5NpiTlTGP/nRt/blFERdaKnOstPZI=;
        b=Y+Ub3vp1EQ5cXDMzkHOLkyHkiqWeHgCCoAuLntftnLpoJofzFnOU0MthnuwPKV32qB
         IbKqunXSEXn8MUE4ebFs9GKvzZN6F/EefJAvr6L8SWncGy2hSUXo0SYfX7WiEagE8jPL
         yNZeVC8aF7TVHPFooPQKwEsOLQYehudicQNlVsoQsJUUrLVa0ANVGcKXxUEFXiH5bP5l
         Qxm50+mHT8RAkuXJ72f1jkvNdqGBjqj7Tl7DjRlmAODyLwgzG4AOGQqS9LYi0UugdmwW
         RMUsKKjhBUJMGWOEGimhZreXZq5W14jSbpYm+XJydH4sZp6AUmvEOWTNj22KGEafpKAY
         h7+g==
X-Gm-Message-State: AJIora9KWwL1h4FwsV/1JVRaFPaPsyVfUxJkDQ6jQH1gfqh/ES7qE3Nt
        Nmz1VBeXmZTgnLZdPdCtoVY3ULP8qrPV3aZs/s/yZx64OIN9
X-Google-Smtp-Source: AGRyM1sVZemfDWn3mXh7IBcwFhV34fnWynfNnE9Yv6qJ2uq0lb4iea99NY0NIkd1DWvz6VYk0CbKSWWq6sZxIu+PdzePo+NrP3uw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1926:b0:33c:7d9:221f with SMTP id
 p38-20020a056638192600b0033c07d9221fmr9808990jal.154.1656416244349; Tue, 28
 Jun 2022 04:37:24 -0700 (PDT)
Date:   Tue, 28 Jun 2022 04:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8420a05e28075ea@google.com>
Subject: [syzbot] KMSAN: uninit-value in kvm_irq_delivery_to_apic_fast
From:   syzbot <syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, glider@google.com,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
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

HEAD commit:    4b28366af7d9 x86: kmsan: enable KMSAN builds for x86
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=126a4b60080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d14e10a167d1c585
dashboard link: https://syzkaller.appspot.com/bug?extid=d6caa905917d353f0d07
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d596c4080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bcf08ff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6caa905917d353f0d07@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
=====================================================
BUG: KMSAN: uninit-value in kvm_apic_set_irq arch/x86/kvm/lapic.c:634 [inline]
BUG: KMSAN: uninit-value in kvm_irq_delivery_to_apic_fast+0x7a7/0x990 arch/x86/kvm/lapic.c:1044
 kvm_apic_set_irq arch/x86/kvm/lapic.c:634 [inline]
 kvm_irq_delivery_to_apic_fast+0x7a7/0x990 arch/x86/kvm/lapic.c:1044
 kvm_irq_delivery_to_apic+0xdb/0xe40 arch/x86/kvm/irq_comm.c:54
 kvm_pv_kick_cpu_op+0xd1/0x100 arch/x86/kvm/x86.c:9155
 kvm_emulate_hypercall+0xee7/0x1340 arch/x86/kvm/x86.c:9285
 __vmx_handle_exit+0x101f/0x1710 arch/x86/kvm/vmx/vmx.c:6237
 vmx_handle_exit+0x38/0x1f0 arch/x86/kvm/vmx/vmx.c:6254
 vcpu_enter_guest+0x4733/0x52d0 arch/x86/kvm/x86.c:10366
 vcpu_run+0x794/0x1230 arch/x86/kvm/x86.c:10455
 kvm_arch_vcpu_ioctl_run+0x11fe/0x1b30 arch/x86/kvm/x86.c:10659
 kvm_vcpu_ioctl+0xcd4/0x1980 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3948
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x222/0x400 fs/ioctl.c:856
 __x64_sys_ioctl+0x92/0xd0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Local variable lapic_irq created at:
 kvm_pv_kick_cpu_op+0x46/0x100 arch/x86/kvm/x86.c:9146
 kvm_emulate_hypercall+0xee7/0x1340 arch/x86/kvm/x86.c:9285

CPU: 1 PID: 3490 Comm: syz-executor407 Not tainted 5.19.0-rc3-syzkaller-30868-g4b28366af7d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
