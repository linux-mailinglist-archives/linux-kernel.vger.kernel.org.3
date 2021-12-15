Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A850D47549E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhLOIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:24 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47910 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLOIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:23 -0500
Received: by mail-il1-f199.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so20052161ila.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 00:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=po/7CS4T7iEDKSSB3j3cm5/eaT2fIYjaoVYevZ1QUQM=;
        b=8D2KhzzEc/I7aBEXLFMO8rQLPOa+2Uhbg3JRjluxFBfyvmWJwPXxMvpE5r/T21METU
         l88T5BW5OlUOBUbgci4jgoftgpN5X3tmnuDbbObDB8gecaaev+jOE+mMab40W7exT1lG
         moQHJbRt8SRMVf7eSOcXnaskjJLfikFQnHN9qZJN1/MYkdChxVecFgTc38BjyED9S78K
         NIEy3+nVFKTfOfg4yM+U8pv3/H0s2244HMrYR4XJs3gnYtlFrqnqrNVlOTU8fXXszrBE
         s5Jwp/xBvh7F0+A5S+c5wf8EfUX6TLw+kJUFGnH56mvKQPwOsE8CE+hBfQd1vpJJxqrg
         z7AQ==
X-Gm-Message-State: AOAM531gp1g+iamktblDfB8qQdyj1yVxWxG4Homh7NjKWJ9G4Y8E+rf0
        w9mqojIPtnzn2jGY6Vqfa9SbhJIqam07lhucTE0glTVjsbH+
X-Google-Smtp-Source: ABdhPJwO16Ec6TH3I/U8zkZseQTKpEFVtg25+wnTmN7li8rXEJbEaERLY3NUgNHnFX0P3jl9vZJfaIeKXg1KujU2U36NklBbHO2u
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1584:: with SMTP id m4mr5978909ilu.185.1639558462916;
 Wed, 15 Dec 2021 00:54:22 -0800 (PST)
Date:   Wed, 15 Dec 2021 00:54:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5543705d32b73bf@google.com>
Subject: [syzbot] KMSAN: uninit-value in n_tty_receive_buf_common (2)
From:   syzbot <syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8b936c96768e kmsan: core: remove the accidentally committe..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16469fc5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e00a8959fdd3f3e8
dashboard link: https://syzkaller.appspot.com/bug?extid=b68d24ad0de64bdba684
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150a1e4db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c305bdb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
BUG: KMSAN: uninit-value in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
BUG: KMSAN: uninit-value in __receive_buf drivers/tty/n_tty.c:1577 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
 variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
 n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
 __receive_buf drivers/tty/n_tty.c:1577 [inline]
 n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
 n_tty_receive_buf2+0xbe/0xd0 drivers/tty/n_tty.c:1709
 tty_ldisc_receive_buf+0x15e/0x390 drivers/tty/tty_buffer.c:471
 tty_port_default_receive_buf+0x14b/0x1e0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x5bf/0xa10 drivers/tty/tty_buffer.c:543
 process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 __kmalloc+0xc3c/0x12d0 mm/slub.c:4437
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
 __tty_buffer_request_room+0x4d2/0x900 drivers/tty/tty_buffer.c:275
 __tty_insert_flip_char+0xe5/0x3d0 drivers/tty/tty_buffer.c:392
 tty_insert_flip_char include/linux/tty_flip.h:36 [inline]
 uart_insert_char+0x495/0xb70 drivers/tty/serial/serial_core.c:3139
 serial8250_read_char+0x280/0x820 drivers/tty/serial/8250/8250_port.c:1769
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1784 [inline]
 serial8250_handle_irq+0x540/0x980 drivers/tty/serial/8250/8250_port.c:1927
 serial8250_default_handle_irq+0x18f/0x370 drivers/tty/serial/8250/8250_port.c:1949
 serial8250_interrupt+0x111/0x3f0 drivers/tty/serial/8250/8250_core.c:126
 __handle_irq_event_percpu+0x188/0xc90 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
 handle_irq_event+0x188/0x420 kernel/irq/handle.c:215
 handle_edge_irq+0x472/0x13e0 kernel/irq/chip.c:822
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0xf8/0x360 arch/x86/kernel/irq.c:250
 common_interrupt+0xb1/0xd0 arch/x86/kernel/irq.c:240
 asm_common_interrupt+0x1e/0x40

CPU: 0 PID: 1056 Comm: kworker/u4:5 Not tainted 5.16.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
