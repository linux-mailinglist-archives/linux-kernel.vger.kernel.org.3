Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8E546962
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbiFJP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiFJP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:29:09 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D11CF6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:29:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l184-20020a6b3ec1000000b00669b5cbd6f3so2300749ioa.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=a1YkpK9AMgIcniGtB5BOtyoBh6YXaqPFUaEYyQooalU=;
        b=IjN9WI11niBDn/llkQJifAIGI8uIr258VSJz2aHFT4yCo+msLn32k8K+AmZFwOZCbJ
         RrROi8t6VAWBuYAp8hNZO3H63yOUgi6NcYtQxINNsydpH5kheVCQxLD1B1HTd3utzisf
         TFvSemIYimWYq+p3/j8A8ShPIpGPeLFp+iaqT5FKVbr2nDH33ENY/Q+zcmPBDViUCM4B
         T5PT4dW7JhV6P22jnySWXPN7vWTagz4G0AD+wPo2g3+5KwVReVviXIau2U4pWkG9Hs9/
         OCttl/GMjJLbQr6zEzLFINPnE6f4KRaAja5juEmzRgt7UGD0T197cnjBNsxy8KB/fuSA
         x9RQ==
X-Gm-Message-State: AOAM530we1Xhi3viLVxc5lpR+DfIbeAFCJg9PgN+rvLqEuzbPMBJ+rDk
        rGiSUUOncnKBzSUGlQ/QGWZ8ZyOYMJo1nSg8pRsM9qktZoQg
X-Google-Smtp-Source: ABdhPJytv3gCBELVdufxw54rzWwOwBzWA2e4slu1cDTFQtjsYEzSPgQOfyXbQ4MXLFkitc1LAtlruFBtc4z1I0Bzaapz8swQK1Ru
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2692:b0:331:fcfd:adf5 with SMTP id
 o18-20020a056638269200b00331fcfdadf5mr5351007jat.166.1654874947568; Fri, 10
 Jun 2022 08:29:07 -0700 (PDT)
Date:   Fri, 10 Jun 2022 08:29:07 -0700
In-Reply-To: <20220610151650.1358-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065c75c05e11999d6@google.com>
Subject: Re: [syzbot] possible deadlock in bpf_trace_printk
From:   syzbot <syzbot+c49e17557ddb5725583d@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in bpf_bprintf_prepare

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2971 at kernel/bpf/helpers.c:791 try_get_fmt_tmp_buf kernel/bpf/helpers.c:791 [inline]
WARNING: CPU: 1 PID: 2971 at kernel/bpf/helpers.c:791 bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:839
Modules linked in:
CPU: 1 PID: 2971 Comm: udevd Not tainted 5.18.0-syzkaller-12122-gd678cbd2f867-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:try_get_fmt_tmp_buf kernel/bpf/helpers.c:791 [inline]
RIP: 0010:bpf_bprintf_prepare+0xf31/0x11a0 kernel/bpf/helpers.c:839
Code: ff e8 93 f8 ea ff 48 83 7c 24 08 00 41 bd 04 00 00 00 0f 85 8a fa ff ff e8 7c f8 ea ff 8d 6b 03 e9 f7 f6 ff ff e8 6f f8 ea ff <0f> 0b 65 ff 0d de b4 73 7e bf 01 00 00 00 41 bc f0 ff ff ff e8 16
RSP: 0018:ffffc90002d7e780 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff88807dfabb00 RSI: ffffffff818f8be1 RDI: 0000000000000005
RBP: ffffc90002d7e8b8 R08: 0000000000000005 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000003
R13: 0000000000000004 R14: ffffc90002d7e970 R15: 0000000000000003
FS:  00007f17e75cf840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a120075288 CR3: 000000001d494000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0x10d/0x260 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:869 [inline]
 __bpf_prog_run include/linux/filter.h:628 [inline]
 bpf_prog_run include/linux/filter.h:635 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2050 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2087
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
 bpf_trace_printk+0x134/0x260 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:869 [inline]
 __bpf_prog_run include/linux/filter.h:628 [inline]
 bpf_prog_run include/linux/filter.h:635 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2050 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2087
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x200/0x2a0 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
 bpf_trace_printk+0x134/0x260 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:869 [inline]
 __bpf_prog_run include/linux/filter.h:628 [inline]
 bpf_prog_run include/linux/filter.h:635 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2050 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2087
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin.constprop.0+0xda/0x1b0 include/trace/events/lock.h:95
 __pv_queued_spin_lock_slowpath+0x103/0xb50 kernel/locking/qspinlock.c:405
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:591 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock kernel/locking/lockdep.c:143 [inline]
 graph_lock kernel/locking/lockdep.c:169 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3764 [inline]
 validate_chain kernel/locking/lockdep.c:3797 [inline]
 __lock_acquire+0x333f/0x5660 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
 bpf_trace_printk+0x134/0x260 kernel/trace/bpf_trace.c:374
 bpf_prog_0605f9f479290f07+0x2f/0x33
 bpf_dispatcher_nop_func include/linux/bpf.h:869 [inline]
 __bpf_prog_run include/linux/filter.h:628 [inline]
 bpf_prog_run include/linux/filter.h:635 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2050 [inline]
 bpf_trace_run2+0x110/0x340 kernel/trace/bpf_trace.c:2087
 __bpf_trace_contention_begin+0xb5/0xf0 include/trace/events/lock.h:95
 trace_contention_begin+0xc0/0x150 include/trace/events/lock.h:95
 __mutex_lock_common kernel/locking/mutex.c:605 [inline]
 __mutex_lock+0x13c/0x1350 kernel/locking/mutex.c:747
 kernfs_get_open_node fs/kernfs/file.c:524 [inline]
 kernfs_fop_open+0x7e8/0xe00 fs/kernfs/file.c:693
 do_dentry_open+0x4a1/0x11f0 fs/open.c:848
 do_open fs/namei.c:3527 [inline]
 path_openat+0x1c71/0x2910 fs/namei.c:3660
 do_filp_open+0x1aa/0x400 fs/namei.c:3687
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1278
 do_sys_open fs/open.c:1294 [inline]
 __do_sys_openat fs/open.c:1310 [inline]
 __se_sys_openat fs/open.c:1305 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1305
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f17e7125697
Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
RSP: 002b:00007ffcc7516d30 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000055a11ff7ccc0 RCX: 00007f17e7125697
RDX: 0000000000080000 RSI: 00007ffcc7516e68 RDI: 00000000ffffff9c
RBP: 00007ffcc7516e68 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055a11ff7ccc0 R14: 0000000000000001 R15: 0000000000000000
 </TASK>


Tested on:

commit:         d678cbd2 xsk: Fix handling of invalid descriptors in X..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17515e73f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=c49e17557ddb5725583d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145a11bff00000

