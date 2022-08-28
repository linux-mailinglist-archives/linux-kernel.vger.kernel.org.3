Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108135A3EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiH1Rxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiH1Rxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:53:34 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288919035
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:53:33 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so3477315ioz.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=zfttuNiZWmjuUsnOponIJcuusQ1LT+/eY2qkTwE8vcc=;
        b=PltfMTAnfYpu7KYkdfzrJCs/ArRn4ROyHhjOWJwvxX8qWaEOLD2ke1zObmzWY3J8E1
         cJKL2ydFFeqRZlpUOn/tuUAKhdY6YYxUp8mB85cNfdO5/IlSk7JJLWtZqbzqbwoAs7K1
         jRuSbEo+ROMt44CVHPuZz7ITtu6YSW+yey9L+pU5b9WidZ4ZtA/kZFJDJ63Z+EOsjoF2
         +3EK8Y7fZw8V6f4MEivc1UZq+/3gOYl+uU4ELU9YT0seom9jx1S74QZfgPabwyr4hrkv
         XskG9MnXFgVWtH+4/1w9JYws4ZGqfdIznjs4jz1zQMcnWCGlR3mmoir6Uzx2uu13YZwe
         3Aqw==
X-Gm-Message-State: ACgBeo0UYmA5br8v53XkcOUXKHRTOIgY6J0UaPVw44qcWIAJ+0nSl42S
        Bl9aau5n4qcv6NxB9JTBBfSZD+Xsqki2QZUNy15V/UbB3xwK
X-Google-Smtp-Source: AA6agR4QwOT4saPMZxj2ssex3/TieH0CNW0ktQDmSKt/fYzS57P5Mv1AdQCbDAHLK8Looz4u+mqVvIb5k9cg3pBDzRUG4R5Jhezb
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150e:b0:689:b4e6:7a46 with SMTP id
 g14-20020a056602150e00b00689b4e67a46mr7893445iow.117.1661709212840; Sun, 28
 Aug 2022 10:53:32 -0700 (PDT)
Date:   Sun, 28 Aug 2022 10:53:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059f81c05e750d3d5@google.com>
Subject: [syzbot] usb-testing boot error: BUG: unable to handle kernel paging
 request in path_init
From:   syzbot <syzbot+90efd69929ca6d662ea9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
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

HEAD commit:    4dce3b375179 usb/hcd: Fix dma_map_sg error check
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1349ab8d080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb39b084894e9a5
dashboard link: https://syzkaller.appspot.com/bug?extid=90efd69929ca6d662ea9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90efd69929ca6d662ea9@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 100026067 P4D 100026067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 259 Comm: kworker/u4:3 Not tainted 6.0.0-rc1-syzkaller-00028-g4dce3b375179 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:path_init+0xac/0x1910 fs/namei.c:2350
Code: da 48 c1 ea 03 80 3c 02 00 0f 85 6a 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 0b 48 89 ca 48 89 4d c8 83 e1 07 48 c1 ea 03 <0f> b6 04 02 38 c8 7f 08 84 c0 0f 85 eb 13 00 00 48 8b 45 c8 31 ff
RSP: 0000:ffffc900016bf998 EFLAGS: 00010a06

RAX: dffffc0000000000 RBX: ffff88810e6b3300 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8183329b RDI: ffffc900016bfc50
RBP: ffffc900016bfa30 R08: 0000000000000005 R09: 0000000000200000
R10: 0000000000000040 R11: 0000000000052040 R12: ffffc900016bfb88
R13: ffffc900016bfd48 R14: 0000000000000001 R15: ffffc900016bfb88
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 path_openat+0x183/0x28f0 fs/namei.c:3686
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_open_execat+0x116/0x730 fs/exec.c:919
 bprm_execve fs/exec.c:1819 [inline]
 bprm_execve+0x48c/0x1960 fs/exec.c:1806
 kernel_execve+0x3ea/0x500 fs/exec.c:2009
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffdc0000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:path_init+0xac/0x1910 fs/namei.c:2350
Code: da 48 c1 ea 03 80 3c 02 00 0f 85 6a 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 0b 48 89 ca 48 89 4d c8 83 e1 07 48 c1 ea 03 <0f> b6 04 02 38 c8 7f 08 84 c0 0f 85 eb 13 00 00 48 8b 45 c8 31 ff
RSP: 0000:ffffc900016bf998 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff88810e6b3300 RCX: 0000000000000000
RDX: 1fffe00000000000 RSI: ffffffff8183329b RDI: ffffc900016bfc50
RBP: ffffc900016bfa30 R08: 0000000000000005 R09: 0000000000200000
R10: 0000000000000040 R11: 0000000000052040 R12: ffffc900016bfb88
R13: ffffc900016bfd48 R14: 0000000000000001 R15: ffffc900016bfb88
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000000 CR3: 0000000007825000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 6a 15 00 00    	jne    0x1578
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 0b             	mov    (%rbx),%rcx
  1b:	48 89 ca             	mov    %rcx,%rdx
  1e:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
  22:	83 e1 07             	and    $0x7,%ecx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2d:	38 c8                	cmp    %cl,%al
  2f:	7f 08                	jg     0x39
  31:	84 c0                	test   %al,%al
  33:	0f 85 eb 13 00 00    	jne    0x1424
  39:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  3d:	31 ff                	xor    %edi,%edi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
