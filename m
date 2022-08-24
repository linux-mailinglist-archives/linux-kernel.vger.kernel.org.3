Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44A5A02CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiHXUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXUcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:32:41 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7336CF44
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:32:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso13467710ils.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=vMbxh3tuKM+IAEhxFu+6JNSqpo0hHeregWugzxmhrb0=;
        b=VJSpyHltpYr22QKRb/weUg6MncXzIVUxT3oDTfgxBjAdZjdyjTa5yXijq2ZPcYEYjJ
         5eHy5dLHcXFvhn8chaTrkEgsoKHHjW71CALULftesmrk58uavouXKpRdSbkZl91jceEe
         7zEZ4fS5EUztCU6rfaAa0GaPXRFA/2vRVvwGdN4mR+w6HlF/FmL1Ejd8aBKxxrgIdjtq
         aZzeN8170Qkn+S/gc3AFFQxySix6B4FB6AfqhhzRh8UK2Ax36bsHhf1IJELGdsEDDQ//
         ORmkYsfAUJxjl+3MnG01x2l5dfMcP/NNN4nB1Vxr1uUgRHoJfzi7Wva/blb9pwzQxMjs
         pZVw==
X-Gm-Message-State: ACgBeo1gwufbUHIiyN5rup+Drr00mxT3Q0MKablxfIaHNHqLModEDekA
        UzEVMw7th+hWIzkQrBKPPUNB+keh2jsybZGkqNe4xFUnCYDy
X-Google-Smtp-Source: AA6agR7Q0IaVMkmSOWSp/7Ct82U5k8k/LECJDxp7CfWitYlqFaMwDqcOZ2C8KkSr1TSU3ANdSS8pPht+FZUr8jvX01lB170hHt0U
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1c4:b0:689:2db5:ea0f with SMTP id
 w4-20020a05660201c400b006892db5ea0fmr290488iot.197.1661373160075; Wed, 24 Aug
 2022 13:32:40 -0700 (PDT)
Date:   Wed, 24 Aug 2022 13:32:40 -0700
In-Reply-To: <0000000000009ebf5605e6ff48d5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bc13705e702955b@google.com>
Subject: Re: [syzbot] WARNING in cpuset_attach
From:   syzbot <syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, steven.price@arm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c40e8341e3b3 Merge tag 'cgroup-for-6.0-rc2-fixes' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169937b5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
dashboard link: https://syzkaller.appspot.com/bug?extid=29d3a3b4d86c8136ad9e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10823695080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dab02b080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29d3a3b4d86c8136ad9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3614 at kernel/cpu.c:347 lockdep_assert_cpus_held kernel/cpu.c:347 [inline]
WARNING: CPU: 0 PID: 3614 at kernel/cpu.c:347 lockdep_assert_cpus_held+0xbd/0xe0 kernel/cpu.c:336
Modules linked in:
CPU: 1 PID: 3614 Comm: vhost-3613 Not tainted 6.0.0-rc2-syzkaller-00054-gc40e8341e3b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:lockdep_assert_cpus_held kernel/cpu.c:347 [inline]
RIP: 0010:lockdep_assert_cpus_held+0xbd/0xe0 kernel/cpu.c:336
Code: e8 38 0c 34 00 be ff ff ff ff 48 c7 c7 70 64 e3 8b e8 37 71 37 08 31 ff 89 c3 89 c6 e8 dc 08 34 00 85 db 75 d5 e8 13 0c 34 00 <0f> 0b eb cc 48 c7 c7 44 66 de 8d e8 d3 73 80 00 e9 62 ff ff ff 48
RSP: 0018:ffffc9000377fbe8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888025c19d80 RSI: ffffffff8147ff0d RDI: 0000000000000005
RBP: ffff888075905000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000377fda0
R13: ffffffff8bfdc2a0 R14: 1ffff920006eff84 R15: ffffc9000377fdc4
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000150 CR3: 0000000025a0b000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 cpuset_attach+0x92/0x520 kernel/cgroup/cpuset.c:2292
 cgroup_migrate_execute+0xbc7/0x1220 kernel/cgroup/cgroup.c:2584
 cgroup_attach_task+0x416/0x7c0 kernel/cgroup/cgroup.c:2875
 cgroup_attach_task_all+0xde/0x140 kernel/cgroup/cgroup-v1.c:70
 vhost_attach_cgroups_work+0x3a/0x90 drivers/vhost/vhost.c:523
 vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:364
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

