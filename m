Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7E59345F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiHOSAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiHOR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:59:28 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1728E36
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:59:26 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id c9-20020a05660221c900b00688a5a621afso137626ioc.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=pc5WxU8NMnC+CnIzNPL1GwX0yvtsCVqhE7KfX+0SS/w=;
        b=PqPkKsUd7vde7DCaM/Dwr2Qp7wkIF0QU3nmUFVZaOCZa8OUdATizWWcK2OSog0o7Am
         H87hoDEjFQq/KWrW9ZS4HoI8RUHLeQEUa2kjINzUboZtu33tVGESlgXVDikq5gWPp7YV
         tdgnPYrd3Lms1ZwIPAn/2QM6SHWEe1hRNMF3SNVlaNxQhjK95PUpqQAVFymCii7LB/gg
         VkiwwBwDZnBTh9G0+lbbB809jiTL6GDhCJP+LAMpAEQvwHa7NLgg7NGfES09+BUxz3Qw
         HDf84r1HhvpC1HdEn2/AeWbOGixVqfYkmTHeAbmvNjKBSdp7RB+Wt0SedJtunMl3G+lZ
         YUAw==
X-Gm-Message-State: ACgBeo0+plmghH3JrhXIzuniksK6dDQz5pYtBQ/E8WcCCNnZ/PoDQCUG
        v6T5rWyMIpc3+XI8NEgtKJUsLnSelc+0Mybt5WCSiCiAeqzE
X-Google-Smtp-Source: AA6agR7XNLSv+trWB7eGaaMeGYV48OHQ8WVQY5lpTMEJlKJLu6afFuOheCfxYnlH5qjQCSo5Jq7R1PaFAtbBO8eZhVwEZ4L6Ew1v
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dd1:b0:341:55c2:38b6 with SMTP id
 m17-20020a0566380dd100b0034155c238b6mr7809604jaj.245.1660586364483; Mon, 15
 Aug 2022 10:59:24 -0700 (PDT)
Date:   Mon, 15 Aug 2022 10:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fbed305e64b6440@google.com>
Subject: [syzbot] upstream boot error: general protection fault in scsi_alloc_sdev
From:   syzbot <syzbot+9ada839c852179f13999@syzkaller.appspotmail.com>
To:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17b23aa5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b9175e0879a7749
dashboard link: https://syzkaller.appspot.com/bug?extid=9ada839c852179f13999
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ada839c852179f13999@syzkaller.appspotmail.com

scsi 0:0:1:0: Direct-Access     Google   PersistentDisk   1    PQ: 0 ANSI: 6
general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xfff8200000004000-0xfff8200000004007]
CPU: 1 PID: 56 Comm: kworker/u4:4 Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:freelist_dereference mm/slub.c:347 [inline]
RIP: 0010:get_freepointer mm/slub.c:354 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:368 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3211 [inline]
RIP: 0010:slab_alloc mm/slub.c:3251 [inline]
RIP: 0010:__kmalloc+0x113/0x340 mm/slub.c:4420
Code: 8b 51 08 48 8b 01 48 83 79 10 00 48 89 44 24 08 0f 84 18 02 00 00 48 85 c0 0f 84 0f 02 00 00 48 8b 7d 00 8b 4d 28 40 f6 c7 0f <48> 8b 1c 08 0f 85 1b 02 00 00 48 8d 4a 08 65 48 0f c7 0f 0f 94 c0
RSP: 0018:ffffc900015777f8 EFLAGS: 00010246

RAX: ffff000000000000 RBX: ffff88801bd64000 RCX: 0000000000000800
RDX: 0000000000005d09 RSI: 0000000000000dc0 RDI: 000000000003dce0
RBP: ffff888011842140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000dc0
R13: 0000000000000000 R14: 0000000000000cb8 R15: 0000000000000dc0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 scsi_alloc_sdev+0x109/0xcc0 drivers/scsi/scsi_scan.c:287
 scsi_probe_and_add_lun+0x22be/0x3660 drivers/scsi/scsi_scan.c:1191
 __scsi_scan_target+0x21f/0xdb0 drivers/scsi/scsi_scan.c:1673
 scsi_scan_channel drivers/scsi/scsi_scan.c:1761 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1737
 scsi_scan_host_selected+0x2df/0x3b0 drivers/scsi/scsi_scan.c:1790
 do_scsi_scan_host+0x1e8/0x260 drivers/scsi/scsi_scan.c:1929
 do_scan_async+0x3e/0x500 drivers/scsi/scsi_scan.c:1939
 async_run_entry_fn+0x98/0x530 kernel/async.c:127
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	8b 51 08             	mov    0x8(%rcx),%edx
   3:	48 8b 01             	mov    (%rcx),%rax
   6:	48 83 79 10 00       	cmpq   $0x0,0x10(%rcx)
   b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  10:	0f 84 18 02 00 00    	je     0x22e
  16:	48 85 c0             	test   %rax,%rax
  19:	0f 84 0f 02 00 00    	je     0x22e
  1f:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  23:	8b 4d 28             	mov    0x28(%rbp),%ecx
  26:	40 f6 c7 0f          	test   $0xf,%dil
* 2a:	48 8b 1c 08          	mov    (%rax,%rcx,1),%rbx <-- trapping instruction
  2e:	0f 85 1b 02 00 00    	jne    0x24f
  34:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  38:	65 48 0f c7 0f       	cmpxchg16b %gs:(%rdi)
  3d:	0f 94 c0             	sete   %al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
