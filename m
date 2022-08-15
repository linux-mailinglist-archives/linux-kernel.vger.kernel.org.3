Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34A59345D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiHOR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiHOR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:59:26 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45B28E0A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:59:24 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso5577638ill.20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=o4gt2uH2nRBrWB+v2fHMFI9b9NFOngOVSEfxYVNbalc=;
        b=wrnC7IfEAqElDLFv2dRivGA2HNgRS73WYd8j+dxdU8/QbRHKWuV45Us5VeaDQG7TJc
         VP97i84ZBWge0NyMf/vPd78Z34p10I1JBZI8m3FUUC77jWOTSlKHV9uZKymQg0Lm3jpO
         iTTlVQ5slA8zFqWPWytSmUiOjRDNwV0hlNcfHEdW0LKF3OI2Ho+ZGDgeb5fUdkpMC775
         llh5Jr+IhfnWGTycid6urnZX0+MpMe2Aj8cqaiSBbh7KklIwKjzfIEjzTU8myWphGEWf
         hfs69ABLg8mvOxduOriiiJmmDvuHXcJJOc1IBwz8jKEaT2pASu5ygAKF3A+NgpWiulXg
         qc5Q==
X-Gm-Message-State: ACgBeo0sp2oQ166Bq27EzztuDwq0M9BPKr8JE2pSzubRVbuKZZ1etCe6
        eHLhocb+RtA4IS188TnVpz8ogk/F7FKbwM68ebVGJ3DMogy6
X-Google-Smtp-Source: AA6agR4k6eysZypx7i2tNh7V2DyW4EBeU4bZGsGuhKTxiKZM8mY8yQb8sscnz2VXOMKOJ1q/pJlzIWts2c18QPKSh2wZ7SErnwOq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:2df:86f0:ebd2 with SMTP id
 u6-20020a056e021a4600b002df86f0ebd2mr7878465ilv.209.1660586363853; Mon, 15
 Aug 2022 10:59:23 -0700 (PDT)
Date:   Mon, 15 Aug 2022 10:59:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056248b05e64b6478@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in free_block
From:   syzbot <syzbot+382af021ce115a936b1f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz, willy@infradead.org
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

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d65d0d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e656d8727a25e83b
dashboard link: https://syzkaller.appspot.com/bug?extid=382af021ce115a936b1f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+382af021ce115a936b1f@syzkaller.appspotmail.com

platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
cfg80211: failed to load regulatory.db
BUG: unable to handle page fault for address: ffffebde00000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 6.0.0-rc1-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events cache_reap
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:858 [inline]
RIP: 0010:virt_to_slab mm/slab.h:175 [inline]
RIP: 0010:free_block+0xc4/0x2d0 mm/slab.c:3317
Code: b8 00 00 00 80 7f 77 00 00 48 81 fd 00 00 00 80 72 07 48 8b 05 9d d0 70 04 48 01 e8 48 2d 00 00 00 80 48 c1 e8 06 48 83 e0 c0 <48> 8b 4c 06 08 f6 c1 01 0f 85 47 01 00 00 48 01 f0 0f 1f 44 00 00
RSP: 0018:ffffc900002f3c80 EFLAGS: 00010006
RAX: 000001de00000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffea0000000000 RDI: ffff888100cf06c0
RBP: 0000000000000000 R08: ffffc900002f3cf8 R09: 0000000000000000
R10: ffff888100f70a40 R11: 0001ffffffffffff R12: ffff888100cf06c0
R13: ffffc900002f3cf8 R14: ffffc900002f3cf8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888237d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebde00000008 CR3: 0000000104e75000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drain_array_locked mm/slab.c:2130 [inline]
 drain_array+0xb8/0x1a0 mm/slab.c:3958
 cache_reap+0x238/0x330 mm/slab.c:4010
 process_one_work+0x3d3/0x720 kernel/workqueue.c:2289
 worker_thread+0x618/0xa70 kernel/workqueue.c:2436
 kthread+0x1a9/0x1e0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
CR2: ffffebde00000008
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:253 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:858 [inline]
RIP: 0010:virt_to_slab mm/slab.h:175 [inline]
RIP: 0010:free_block+0xc4/0x2d0 mm/slab.c:3317
Code: b8 00 00 00 80 7f 77 00 00 48 81 fd 00 00 00 80 72 07 48 8b 05 9d d0 70 04 48 01 e8 48 2d 00 00 00 80 48 c1 e8 06 48 83 e0 c0 <48> 8b 4c 06 08 f6 c1 01 0f 85 47 01 00 00 48 01 f0 0f 1f 44 00 00
RSP: 0018:ffffc900002f3c80 EFLAGS: 00010006
RAX: 000001de00000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffea0000000000 RDI: ffff888100cf06c0
RBP: 0000000000000000 R08: ffffc900002f3cf8 R09: 0000000000000000
R10: ffff888100f70a40 R11: 0001ffffffffffff R12: ffff888100cf06c0
R13: ffffc900002f3cf8 R14: ffffc900002f3cf8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888237d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebde00000008 CR3: 0000000104e75000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 80       	mov    $0x80000000,%eax
   5:	7f 77                	jg     0x7e
   7:	00 00                	add    %al,(%rax)
   9:	48 81 fd 00 00 00 80 	cmp    $0xffffffff80000000,%rbp
  10:	72 07                	jb     0x19
  12:	48 8b 05 9d d0 70 04 	mov    0x470d09d(%rip),%rax        # 0x470d0b6
  19:	48 01 e8             	add    %rbp,%rax
  1c:	48 2d 00 00 00 80    	sub    $0xffffffff80000000,%rax
  22:	48 c1 e8 06          	shr    $0x6,%rax
  26:	48 83 e0 c0          	and    $0xffffffffffffffc0,%rax
* 2a:	48 8b 4c 06 08       	mov    0x8(%rsi,%rax,1),%rcx <-- trapping instruction
  2f:	f6 c1 01             	test   $0x1,%cl
  32:	0f 85 47 01 00 00    	jne    0x17f
  38:	48 01 f0             	add    %rsi,%rax
  3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
