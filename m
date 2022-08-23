Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E22659EEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHWWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHWWI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:08:28 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F91DFB1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:08:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z3-20020a921a43000000b002e9214e10d8so10472134ill.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=N6/gijpR6LFurEhtke6ErVbUL06q5VjvPEyQiomujHk=;
        b=rZ+7U6co1J8z+979RmNVjUL+/m8lU+ef/BIX9gjw1A9mblWk5UAzw8TgJ+v5KtDybu
         x9EBTSggAzaQBCtYfC0bRumvfziZ70MuJal1EKBq0hpGpzfTbiRl0Gtpa7nSMP0jGE/y
         BlM6vZLEiN6ozc2QrZDeo0KtqOoYNAYhyniaDYzSi39B+D6wZjDxhtFj+kVbx46dn4fz
         1UQ09Qu7+OQm46P5fxXT4oiyhGQDrel7nTZ4vwN9/ZRXAA/WwJa5xm5vIPA96ys7QHGK
         3mXe7EfC2EZmaqsSPoGzJ6f2w10RabewBHMhC3bb6hufqOIR7ML36I1DXgECya2rvcEc
         triQ==
X-Gm-Message-State: ACgBeo32ubpztlE3EZO+5wUeEwDWaRHH2gwXLc2vs8DWWd9geZVtdCwz
        Ei5PVPlqrdH670yAN8cxuNIueUKMwETR3OgSmeRp4Pn2S8/d
X-Google-Smtp-Source: AA6agR5CHY8sscNkH2PWveaVn6eBzapa/upOeLtrBHVpwhJxicK4G1V5+8kNwkSLcGwNe99ntqbi+MtblsZGkstrS6xey6OMXKQi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cac:b0:2e5:fa4f:c0c9 with SMTP id
 x12-20020a056e021cac00b002e5fa4fc0c9mr764967ill.204.1661292505393; Tue, 23
 Aug 2022 15:08:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6f34a05e6efcd01@google.com>
Subject: [syzbot] WARNING in split_huge_page_to_list (2)
From:   syzbot <syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10ef7dc3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
dashboard link: https://syzkaller.appspot.com/bug?extid=07a218429c8d19b1fb25
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17993aa5080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16521a3d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com

raw: 05ffc00000010801 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
page dumped because: VM_WARN_ON_ONCE_PAGE(is_hzp)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3025 at mm/huge_memory.c:2555 split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
Modules linked in:
CPU: 1 PID: 3025 Comm: syz-executor201 Not tainted 5.19.0-rc8-syzkaller-01618-g680fb5b009e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/20/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
lr : split_huge_page_to_list+0x308/0xe2c mm/huge_memory.c:2555
sp : ffff80001321bba0
x29: ffff80001321bbf0 x28: 0000000000400000 x27: 0000000000000001
x26: ffff80000ceda000 x25: 05ffc00000000000 x24: ffff80000d8c1000
x23: fffffc0003300000 x22: ffff0001ff012d40 x21: fffffc0003304400
x20: 0000000000000000 x19: fffffc0003300000 x18: 00000000000000c0
x17: ffff80000dcfd698 x16: ffff80000db3b658 x15: ffff0000c6708000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c6708000
x11: ff808000081bf324 x10: 0000000000000000 x9 : 461f0eca467c0e00
x8 : 0000000000000001 x7 : ffff8000081937c0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000031
Call trace:
 split_huge_page_to_list+0x310/0xe2c mm/huge_memory.c:2555
 split_huge_page include/linux/huge_mm.h:206 [inline]
 try_to_split_thp_page mm/memory-failure.c:1488 [inline]
 memory_failure+0x510/0x14cc mm/memory-failure.c:1870
 madvise_inject_error+0x260/0x334 mm/madvise.c:1115
 do_madvise+0x258/0x5ac mm/madvise.c:1398
 __do_sys_madvise mm/madvise.c:1423 [inline]
 __se_sys_madvise mm/madvise.c:1421 [inline]
 __arm64_sys_madvise+0x2c/0x40 mm/madvise.c:1421
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 11566
hardirqs last  enabled at (11565): [<ffff8000081bd590>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:264
hardirqs last disabled at (11566): [<ffff80000bfa4314>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (11536): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (11527): [<ffff800008101e20>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (11527): [<ffff800008101e20>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---
Memory Failure: 0x10c110: thp split failed
Memory failure: 0x10c110: recovery action for unsplit thp: Ignored


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
