Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C59C5AEEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiIFPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiIFPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:35:15 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336555466C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:37 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id d18-20020a056e020c1200b002eaea8e6081so9574906ile.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Fe89WGWJZwiIb158sxstTr/GnL2kLOTXmABZOYRz0hw=;
        b=jrnYniHbI85MqQnGmyXbPXXQZMnWuwvuvAG8rOrnDMxYxsS1ChieqNYGS3t5FLG+Lx
         k1Kg71nPycyqS0VnfO1H6Vd6pLqQrS54P7GxlTagdyDc/sKdz6NuFey7gF6/MxR0YfAT
         j50DlLCgR2d2CLDoaZQyoyBmlJNSs9ymVy+NeQhoVAXFEPD1yd4aat+UZaUHTBcQuK+F
         grYArxas04LmZKn2Tvn9edeh/C22N4cHu0o8j/fNHTbGVInPtneB5rJbA2osFafZ+A9c
         Ev6Lu7vpYDZX/RvCmsJ2qF6zCPd6P+C6Q0Z4NMypZY7BkHSlG8NRmYmnBlnQjwn2/ZjV
         Oraw==
X-Gm-Message-State: ACgBeo0qomX8Us1v0T49s/1oxKIpJfHnUhAcdc3LC5d/ejqc+tlJcHR9
        eAsLfpBa4FAXuE641ZfBnvOTHKl4mCmse3LsQGOBc19mp0sI
X-Google-Smtp-Source: AA6agR6UbPF1yi0UcJv+otI7unVJjhlAKyO1RsEcB8JlQSEq+cfX8KQb0M4+0FH+ofYXeEYxmb4LC2NcF/HOw6U4uZe+2iofILjf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcb:b0:2ed:3517:3292 with SMTP id
 x11-20020a056e021bcb00b002ed35173292mr12792554ilv.103.1662475465936; Tue, 06
 Sep 2022 07:44:25 -0700 (PDT)
Date:   Tue, 06 Sep 2022 07:44:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098580e05e8033b9a@google.com>
Subject: [syzbot] usb-testing boot error: BUG: unable to handle kernel paging
 request in follow_page_mask
From:   syzbot <syzbot+6b3a1fd733d73b7a14d7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
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

HEAD commit:    4e55e22d3d9a USB: hcd-pci: Drop the unused id parameter fr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16b2d4d7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=6b3a1fd733d73b7a14d7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f931abacee/disk-4e55e22d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b749a498398/vmlinux-4e55e22d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b3a1fd733d73b7a14d7@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffeefda00001ff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 687 Comm: kworker/u4:0 Not tainted 6.0.0-rc1-syzkaller-00049-g4e55e22d3d9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:native_pud_val arch/x86/include/asm/pgtable_types.h:347 [inline]
RIP: 0010:pud_none arch/x86/include/asm/pgtable.h:829 [inline]
RIP: 0010:follow_pud_mask mm/gup.c:730 [inline]
RIP: 0010:follow_p4d_mask mm/gup.c:782 [inline]
RIP: 0010:follow_page_mask+0x1a9/0x1c90 mm/gup.c:846
Code: 00 80 88 ff ff 4c 01 e8 4d 89 e5 49 c1 ed 1b 41 81 e5 f8 0f 00 00 49 01 c5 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 18 00 00 4d 8b 75 00 31 ff 49 83 e6 9f 4c 89
RSP: 0000:ffffc90001e7fb10 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff88810e732500 RCX: 0000000000000000
RDX: 1ffff2fda00001ff RSI: ffffffff8167fdbd RDI: 0000000000000007
RBP: ffffc90001e7fc48 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007fffffffefc0
R13: ffff97ed00000ff8 R14: 0000000000000000 R15: 0000000000002017
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffeefda00001ff CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __get_user_pages+0x3f2/0x1020 mm/gup.c:1193
 __get_user_pages_locked mm/gup.c:1399 [inline]
 __get_user_pages_remote+0x18f/0x830 mm/gup.c:2109
 get_user_pages_remote+0x84/0xc0 mm/gup.c:2182
 get_arg_page+0xe4/0x2a0 fs/exec.c:222
 copy_string_kernel+0x169/0x460 fs/exec.c:639
 copy_strings_kernel+0xb3/0x190 fs/exec.c:655
 kernel_execve+0x377/0x500 fs/exec.c:2001
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffeefda00001ff
---[ end trace 0000000000000000 ]---
RIP: 0010:native_pud_val arch/x86/include/asm/pgtable_types.h:347 [inline]
RIP: 0010:pud_none arch/x86/include/asm/pgtable.h:829 [inline]
RIP: 0010:follow_pud_mask mm/gup.c:730 [inline]
RIP: 0010:follow_p4d_mask mm/gup.c:782 [inline]
RIP: 0010:follow_page_mask+0x1a9/0x1c90 mm/gup.c:846
Code: 00 80 88 ff ff 4c 01 e8 4d 89 e5 49 c1 ed 1b 41 81 e5 f8 0f 00 00 49 01 c5 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 18 00 00 4d 8b 75 00 31 ff 49 83 e6 9f 4c 89
RSP: 0000:ffffc90001e7fb10 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff88810e732500 RCX: 0000000000000000
RDX: 1ffff2fda00001ff RSI: ffffffff8167fdbd RDI: 0000000000000007
RBP: ffffc90001e7fc48 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00007fffffffefc0
R13: ffff97ed00000ff8 R14: 0000000000000000 R15: 0000000000002017
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffeefda00001ff CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 80 88 ff ff 4c    	add    %al,0x4cffff88(%rax)
   6:	01 e8                	add    %ebp,%eax
   8:	4d 89 e5             	mov    %r12,%r13
   b:	49 c1 ed 1b          	shr    $0x1b,%r13
   f:	41 81 e5 f8 0f 00 00 	and    $0xff8,%r13d
  16:	49 01 c5             	add    %rax,%r13
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d4 18 00 00    	jne    0x1908
  34:	4d 8b 75 00          	mov    0x0(%r13),%r14
  38:	31 ff                	xor    %edi,%edi
  3a:	49 83 e6 9f          	and    $0xffffffffffffff9f,%r14
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
