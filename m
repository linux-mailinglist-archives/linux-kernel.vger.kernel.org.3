Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A70595756
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiHPJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiHPJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:57:30 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907DDF1B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:42:26 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020c0600b002deca741bc2so6673900ile.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=+jzcfAu8UwI/Y0LokxI7igRVcQotKXMODMjaE4VIKjY=;
        b=NBVlDAtU6YYzbMRn3Cbjs0P6/B3ubnLVPhUL2mUUKs0UW2yn3EMMAx+HRg+22TNLc0
         P47wXEpMWNwVEMCgvkE6hOnj/wp7O83KPIJzJ6t2sp5I7pkcChFpa1JSfmZwtLFk3YVV
         Lb/5+AhQ5m+UlZgGJBq07sxNkSqprnaZm9npsBgWr6MWD/HeNZVhD0jJ0Oy8f/7hLro3
         3gxo4JkVEbWpeFsw+hNUdiTMJzX2c93LOZuvECFNtv6Nf3pCdzXtEWEQY9H/sy7gb3GX
         bxyFTaWcSFhlSEwBKSotzO+1EaJdasfZjo/W8w0xbWlCbfbmK6hAUz36aVFXLS46HqeZ
         d9tA==
X-Gm-Message-State: ACgBeo1178D2k/aAIFlssq+8fcqSQ3GKRERSc6jHmwlHD49T67ReooSY
        W8AU7OBp+PFTGUGGb0sX6dsYl8hqn90MQ7zZPtjYlV5mDXg2
X-Google-Smtp-Source: AA6agR6c541eGIxRlq02NmbBlytmQ2SQ8bDe8DHmliRsrDFWAoKLU6p0PGgRogDGQedplOt63aweHhdXwP0VdZxS/v0N5mYuolkC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:2e7:bed:30d9 with SMTP id
 u9-20020a056e021a4900b002e70bed30d9mr633282ilv.209.1660639345840; Tue, 16 Aug
 2022 01:42:25 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f17af05e657bacb@google.com>
Subject: [syzbot] upstream boot error: WARNING: bad unlock balance in handle_irq_event
From:   syzbot <syzbot+67a35003dea56aed2517@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    69dac8e431af Merge tag 'riscv-for-linus-5.20-mw2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107ac5dd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6bcb425ba129b87
dashboard link: https://syzkaller.appspot.com/bug?extid=67a35003dea56aed2517
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67a35003dea56aed2517@syzkaller.appspotmail.com


=====================================
WARNING: bad unlock balance detected!
5.19.0-syzkaller-14184-g69dac8e431af #0 Not tainted
-------------------------------------
/0 is trying to release lock (&irq_desc_lock_class) at:
[<ffffffff816271ef>] handle_irq_event+0x9f/0x1e0 kernel/irq/handle.c:208
but there are no more locks to release!

other info that might help us debug this:
no locks held by /0.

stack backtrace:
CPU: 0 PID: 0 Comm:  Not tainted 5.19.0-syzkaller-14184-g69dac8e431af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_unlock_imbalance_bug include/trace/events/lock.h:69 [inline]
 __lock_release kernel/locking/lockdep.c:5333 [inline]
 lock_release.cold+0x49/0x4e kernel/locking/lockdep.c:5686
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x12/0x40 kernel/locking/spinlock.c:186
 handle_irq_event+0x9f/0x1e0 kernel/irq/handle.c:208
 handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
 common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
 </IRQ>
BUG: unable to handle page fault for address: ffffdc0000000033
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
BUG: IRQ stack guard page was hit at ffffc8fffffffff8 (stack is ffffc90000000000..ffffc90000008000)
stack guard page: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 0 Comm:  Not tainted 5.19.0-syzkaller-14184-g69dac8e431af #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:memmove+0x5/0x60 mm/kasan/shadow.c:53
Code: e8 60 f8 ff ff 84 c0 74 13 4c 89 e2 44 89 ee 48 89 ef 5d 41 5c 41 5d e9 89 d3 5c 02 5d 31 c0 41 5c 41 5d c3 90 41 55 49 89 fd <41> 54 49 89 d4 31 d2 55 48 8b 4c 24 18 48 89 f5 4c 89 e6 48 89 ef
RSP: 0000:ffffc90000000000 EFLAGS: 00010046
RAX: 0000000080010006 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffc9000000044f RDI: ffffc90000000453
RBP: 0000000000000004 R08: 0000000000000006 R09: 0000000000000002
R10: 000000007ffffffa R11: 0000000000000001 R12: 1ffff92000000004
R13: ffffc90000000453 R14: 0000000000000002 R15: ffffc90000000451
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc8fffffffff8 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 move_right lib/vsprintf.c:601 [inline]
 widen_string+0x254/0x290 lib/vsprintf.c:624
 string_nocheck lib/vsprintf.c:651 [inline]
 string+0x1fb/0x3d0 lib/vsprintf.c:725
 vsnprintf+0x71b/0x14f0 lib/vsprintf.c:2782
 sprintf+0xc0/0x100 lib/vsprintf.c:2986
 print_caller kernel/printk/printk.c:1288 [inline]
 info_print_prefix+0x12e/0x340 kernel/printk/printk.c:1305
 record_print_text+0x14d/0x3e0 kernel/printk/printk.c:1352
 console_emit_next_record.constprop.0+0x6bf/0x840 kernel/printk/printk.c:2715
 console_flush_all kernel/printk/printk.c:2794 [inline]
 console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
 vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
 _printk+0xba/0xed kernel/printk/printk.c:2292
 dump_pagetable.cold+0x20c/0x3d4 arch/x86/mm/fault.c:395
 show_fault_oops arch/x86/mm/fault.c:580 [inline]
 page_fault_oops.cold+0x176/0x3f0 arch/x86/mm/fault.c:696
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000000bb0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000017b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000000de8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000000e90 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000001d7 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000010c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001170 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000233 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000013a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001450 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000028f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000001688 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001730 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000002eb RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000001968 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001a10 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000347 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000001c48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001cf0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000003a3 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000001f28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000001fd0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000003ff RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000002208 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000022b0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000045b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000024e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000002590 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000004b7 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000027c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000002870 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000513 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000002aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000002b50 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000056f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000002d88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000002e30 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000005cb RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003068 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000003110 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000627 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003348 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000033f0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000683 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003628 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000036d0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000006df RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003908 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000039b0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000073b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003be8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000003c90 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000797 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000003ec8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000003f70 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000007f3 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000041a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000004250 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff9200000084f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000004488 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000004530 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000008ab RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000004768 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000004810 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000907 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000004a48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000004af0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000963 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000004d28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000004dd0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff920000009bf RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000005008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000050b0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000a1b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000052e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000005390 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000a77 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000055c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000005670 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000ad3 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000058a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000005950 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000b2f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000005b88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000005c30 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000b8b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000005e68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000005f10 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000be7 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000006148 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000061f0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000c43 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000006428 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000064d0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000c9f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000006708 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000067b0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000cfb RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc900000069e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000006a90 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000d57 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000006cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000006d70 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000db3 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000006fa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000007050 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000e0f RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000007288 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000007330 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000e6b RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000007568 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc90000007610 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000ec7 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000007848 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000000
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:page_fault_oops+0x2a9/0x670 arch/x86/mm/fault.c:698
Code: 49 8d 7e 20 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b2 00 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 76 20 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 86 00 00 00 4d 8b 36 bf 9d 6e ac 57 4c 89 f6 e8
RSP: 0000:ffffc900000078f0 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: 1ffff92000000f23 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8136523c RDI: ffff88801fe79da0
RBP: ffffc90000007b28 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080010005 R11: 2030204455502037 R12: ffffdc0000000033
R13: 0000000000000000 R14: ffff000000000000 R15: 0000000000000000
 kernelmode_fixup_or_oops+0x23f/0x2b0 arch/x86/mm/fault.c:760
 __bad_area_nosemaphore+0x373/0x400 arch/x86/mm/fault.c:806
 do_kern_addr_fault+0x5b/0x70 arch/x86/mm/fault.c:1207
 handle_page_fault arch/x86/mm/fault.c:1486 [inline]
 exc_page_fault+0x14b/0x170 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:get_running_cputimer include/linux/sched/cputime.h:88 [inline]
RIP: 0010:account_group_exec_runtime include/linux/sched/cputime.h:173 [inline]
RIP: 0010:update_curr+0x458/0x830 kernel/sched/fair.c:919
Code: 98 03 00 00 4c 8b ab 28 08 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bd 98 01 00 00 4d 8d b5 38 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 58 03 00 00 41 8b 85 98 01 00
RSP: 0000:ffffc90000007bd8 EFLAGS: 00010806
RAX: dffffc0000000000 RBX: ffff88801fe79e00 RCX: 1ffffffff1bbd7e1
RDX: 1fffe00000000033 RSI: 00000001d823f4f3 RDI: ffff000000000198
RBP: ffff8880b9a3a040 R08: 0000000000000000 R09: ffffffff8dde8b57
R10: fffffbfff1bbd16a R11: 0000000000000001 R12: 00000001d823f4f3
R13: ffff000000000000 R14: ffff000000000138 R15: ffff88801fe79d80
 enqueue_entity+0x29b/0x1520 kernel/sched/fair.c:4423
 enqueue_task_fair+0x1ba/0xce0 kernel/sched/fair.c:5757
 enqueue_task+0xad/0x3a0 kernel/sched/core.c:2066
 activate_task kernel/sched/core.c:2091 [inline]
 ttwu_do_activate+0x157/0x330 kernel/sched/core.c:3670
 ttwu_queue kernel/sched/core.c:3875 [inline]
 try_to_wake_up+0xcc0/0x1e60 kernel/sched/core.c:4198
 wake_up_worker kernel/workqueue.c:856 [inline]
 insert_work+0x27e/0x350 kernel/workqueue.c:1366
 __queue_work+0x625/0x1210 kernel/workqueue.c:1517
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 add_interrupt_randomness+0x22b/0x3f0 drivers/char/random.c:1035
 handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
 handle_irq_event+0xe0/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
 common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
 </IRQ>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:memmove+0x5/0x60 mm/kasan/shadow.c:53
Code: e8 60 f8 ff ff 84 c0 74 13 4c 89 e2 44 89 ee 48 89 ef 5d 41 5c 41 5d e9 89 d3 5c 02 5d 31 c0 41 5c 41 5d c3 90 41 55 49 89 fd <41> 54 49 89 d4 31 d2 55 48 8b 4c 24 18 48 89 f5 4c 89 e6 48 89 ef
RSP: 0000:ffffc90000000000 EFLAGS: 00010046
RAX: 0000000080010006 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffc9000000044f RDI: ffffc90000000453
RBP: 0000000000000004 R08: 0000000000000006 R09: 0000000000000002
R10: 000000007ffffffa R11: 0000000000000001 R12: 1ffff92000000004
R13: ffffc90000000453 R14: 0000000000000002 R15: ffffc90000000451
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc8fffffffff8 CR3: 000000000bc8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 60 f8 ff ff       	callq  0xfffff865
   5:	84 c0                	test   %al,%al
   7:	74 13                	je     0x1c
   9:	4c 89 e2             	mov    %r12,%rdx
   c:	44 89 ee             	mov    %r13d,%esi
   f:	48 89 ef             	mov    %rbp,%rdi
  12:	5d                   	pop    %rbp
  13:	41 5c                	pop    %r12
  15:	41 5d                	pop    %r13
  17:	e9 89 d3 5c 02       	jmpq   0x25cd3a5
  1c:	5d                   	pop    %rbp
  1d:	31 c0                	xor    %eax,%eax
  1f:	41 5c                	pop    %r12
  21:	41 5d                	pop    %r13
  23:	c3                   	retq
  24:	90                   	nop
  25:	41 55                	push   %r13
  27:	49 89 fd             	mov    %rdi,%r13
* 2a:	41 54                	push   %r12 <-- trapping instruction
  2c:	49 89 d4             	mov    %rdx,%r12
  2f:	31 d2                	xor    %edx,%edx
  31:	55                   	push   %rbp
  32:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  37:	48 89 f5             	mov    %rsi,%rbp
  3a:	4c 89 e6             	mov    %r12,%rsi
  3d:	48 89 ef             	mov    %rbp,%rdi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
