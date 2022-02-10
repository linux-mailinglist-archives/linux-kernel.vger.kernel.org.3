Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23E94B0B03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiBJKjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:39:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:39:18 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406CFD8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:39:19 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id h1-20020a056602008100b0061152382337so3746213iob.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PlW2h6/5s4oCJUA+8z2HFxMVXAg0bk5HdTfwA3/Bxig=;
        b=xNVXGFSpWrhvh36NZvzCmqpcNptYCxDqaeioFf70wquTe45AxNEQtzbFhO2VYHGt4u
         kD1E8V0tvzVpOLZENw2XLzXPgT3j0FCx1dPYD/Qi9zaA33x1q2Z1m3Ho+J6H6UU/FHfy
         PptjMLLU96KOrpm7/bpt9IRWDoUnDwSMWXWwiap8RQ7HSmDDM/kjh0lRnSYzxcmnTuJ4
         8ZfUZgUxPN/Wq+3biEVe7blvRt1hJaTDwLNwT0wV4f2H743rRmrwzb2BgPHemeoUHQBE
         WI3gdqSPcONfsmEr5oRKclZtlFrfbXciGaw9nVXw1nU2kuS1hSYveIwKjniJEl5Nehl9
         zxCw==
X-Gm-Message-State: AOAM532QxcTSrm3KOKt0VhWSEyLvoD3Jip7qff3UKdt656D1/wetcnNI
        i2j/hVIkgevK499oLEAxwbHijLS47+W6vHiVxiVcv3VyBlud
X-Google-Smtp-Source: ABdhPJwxEL/23hYjmK317KjnFqyOg+FpEa4Zg1RMKPM9RssZeBr2k8ArUZHYLItqrnjqj8k/qvGp+ZAFr8N6zjsPiwjAHqw9K6oA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:: with SMTP id j4mr3548120ilu.77.1644489558712;
 Thu, 10 Feb 2022 02:39:18 -0800 (PST)
Date:   Thu, 10 Feb 2022 02:39:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbe5bb05d7a78fe6@google.com>
Subject: [syzbot] KCSAN: data-race in random_recv_done / virtio_read
From:   syzbot <syzbot+9f00f7796f970f61ce79@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvivier@redhat.com, mpm@selenic.com,
        mst@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f4bc5bbb5fef Merge tag 'nfsd-5.17-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149676d8700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dcc3374da7c1f7c
dashboard link: https://syzkaller.appspot.com/bug?extid=9f00f7796f970f61ce79
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f00f7796f970f61ce79@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in random_recv_done / virtio_read

write to 0xffff88810254d8cc of 4 bytes by interrupt on cpu 1:
 random_recv_done+0x58/0x80 drivers/char/hw_random/virtio-rng.c:45
 vring_interrupt+0x15d/0x180 drivers/virtio/virtio_ring.c:2165
 __handle_irq_event_percpu+0x92/0x450 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x7b/0x110 kernel/irq/handle.c:210
 handle_edge_irq+0x18e/0x5f0 kernel/irq/chip.c:820
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x60/0x100 arch/x86/kernel/irq.c:250
 common_interrupt+0x9a/0xc0 arch/x86/kernel/irq.c:240
 asm_common_interrupt+0x1e/0x40
 preempt_count arch/x86/include/asm/preempt.h:27 [inline]
 check_kcov_mode kernel/kcov.c:166 [inline]
 __sanitizer_cov_trace_pc+0x14/0x60 kernel/kcov.c:200
 zap_pte_range+0x87d/0x10e0 mm/memory.c:1423
 zap_pmd_range mm/memory.c:1490 [inline]
 zap_pud_range mm/memory.c:1519 [inline]
 zap_p4d_range mm/memory.c:1540 [inline]
 unmap_page_range+0x2dc/0x3d0 mm/memory.c:1561
 unmap_single_vma+0x157/0x210 mm/memory.c:1606
 unmap_vmas+0xd0/0x180 mm/memory.c:1638
 exit_mmap+0x261/0x4b0 mm/mmap.c:3178
 __mmput+0x27/0x1b0 kernel/fork.c:1114
 mmput+0x3d/0x50 kernel/fork.c:1135
 exit_mm+0xdb/0x170 kernel/exit.c:507
 do_exit+0x569/0x16a0 kernel/exit.c:793
 do_group_exit+0x8b/0x160 kernel/exit.c:935
 __do_sys_exit_group+0xb/0x10 kernel/exit.c:946
 __se_sys_exit_group+0x5/0x10 kernel/exit.c:944
 __x64_sys_exit_group+0x16/0x20 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

write to 0xffff88810254d8cc of 4 bytes by task 30156 on cpu 0:
 request_entropy drivers/char/hw_random/virtio-rng.c:56 [inline]
 copy_data drivers/char/hw_random/virtio-rng.c:74 [inline]
 virtio_read+0x1a0/0x450 drivers/char/hw_random/virtio-rng.c:92
 rng_get_data drivers/char/hw_random/core.c:192 [inline]
 rng_dev_read+0x1b4/0x630 drivers/char/hw_random/core.c:229
 vfs_read+0x1e6/0x750 fs/read_write.c:479
 ksys_read+0xd9/0x190 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x3e/0x50 fs/read_write.c:627
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0x00000040 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 30156 Comm: syz-executor.0 Not tainted 5.17.0-rc3-syzkaller-00043-gf4bc5bbb5fef-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
