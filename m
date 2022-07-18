Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B251B577CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiGRHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiGRHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:45:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955C175BA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:45:39 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l3-20020a056e0212e300b002dcf19c711cso840520iln.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3ofDS4wEe0tvH6/5zL47NIIIrdFyj2g/u2lqn6YpkIg=;
        b=35iVI77Z/b0umMWCMsxHC12cBqUYc4uaQgU9DjnWPjsFJqo65Zo09dyeUQUOwWuAxx
         eUx8zx0YPWaC7DGLFF0aLYBVj+mSKTN5BWJzzdavETdwAlgUqs/BkJkLXOXWli6EbUXn
         w5jdnASwISKPXz6LGy3mTA2sK33kozD61HVl1P3DWnVASnkQWysfGhnnwe9y6f2uRa5G
         SRujtS/6juwrlOih12WZicYPPX+pXkIWWT9d1Oc75cXWu/kJR6h2Bcev7X4TaCDJrWji
         grWxOH/XaDqJru8jyezl0okNCpVLxfpJ9gZfc6l76ezTHBeRhuplJHpSkB+nSpioVSE1
         iZHA==
X-Gm-Message-State: AJIora+ztw50AhUmRv4GRT8vDxWme4vrYMglMnqK4zXNRWs8HkFRfHZk
        NZA0TRoR661TVGWhkDgLQtPAlL23hRgNEoN3E3W6efyD53jy
X-Google-Smtp-Source: AGRyM1tQoVdgTcENII7Sq/M3U7JbBE83ncASGi8D4b5igcmT5EOY+1SDDtePKEPz8dBbz6KiXwlCMLId8sgbfgjVGLMJSfxMGeu4
MIME-Version: 1.0
X-Received: by 2002:a5e:d702:0:b0:67b:ce60:53da with SMTP id
 v2-20020a5ed702000000b0067bce6053damr10111281iom.24.1658130338543; Mon, 18
 Jul 2022 00:45:38 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:45:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1fe8205e40f8daf@google.com>
Subject: [syzbot] WARNING in page_counter_cancel (4)
From:   syzbot <syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15583826080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=28eb226ee1d37f08087a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12222b9a080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1560ab8c080000

The issue was bisected to:

commit 2ee236fe53a8e2ab54679c74e8a1fb77e55b29bb
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Tue Jun 21 20:46:53 2022 +0000

    mm: start tracking VMAs with maple tree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b5b252080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b5b252080000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b5b252080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28eb226ee1d37f08087a@syzkaller.appspotmail.com
Fixes: 2ee236fe53a8 ("mm: start tracking VMAs with maple tree")

------------[ cut here ]------------
page_counter underflow: -512 nr_pages=1536
WARNING: CPU: 0 PID: 3608 at mm/page_counter.c:56 page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
Modules linked in:
CPU: 0 PID: 3608 Comm: syz-executor428 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
Code: c7 04 24 00 00 00 00 45 31 f6 eb 97 e8 2a 36 ae ff 4c 89 ea 48 89 ee 48 c7 c7 a0 55 da 89 c6 05 26 90 db 0b 01 e8 bb bb 67 07 <0f> 0b eb a8 4c 89 e7 e8 65 3b fa ff eb c7 0f 1f 00 41 56 41 55 49
RSP: 0018:ffffc9000302fb28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888140159268 RCX: 0000000000000000
RDX: ffff88801ea81d40 RSI: ffffffff81610608 RDI: fffff52000605f57
RBP: fffffffffffffe00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff888140159268
R13: 0000000000000600 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb2ef03c290 CR3: 000000002234d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_counter_uncharge+0x2e/0x60 mm/page_counter.c:159
 hugetlb_cgroup_uncharge_counter+0xcc/0x3d0 mm/hugetlb_cgroup.c:432
 hugetlb_vm_op_close+0x424/0x6b0 mm/hugetlb.c:4598
 remove_vma+0x81/0x130 mm/mmap.c:187
 exit_mmap+0x288/0x720 mm/mmap.c:3222
 __mmput+0x128/0x4c0 kernel/fork.c:1180
 mmput+0x5c/0x70 kernel/fork.c:1201
 exit_mm kernel/exit.c:510 [inline]
 do_exit+0xa09/0x29f0 kernel/exit.c:782
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7fb2eefc6d39
Code: Unable to access opcode bytes at RIP 0x7fb2eefc6d0f.
RSP: 002b:00007ffc35614978 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb2ef03b3f0 RCX: 00007fb2eefc6d39
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000003
R10: 0000000020000000 R11: 0000000000000246 R12: 00007fb2ef03b3f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
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
