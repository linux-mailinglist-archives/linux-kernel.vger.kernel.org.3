Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39D53C379
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiFCDz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiFCDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:55:14 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A231DE6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:55:12 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so4050869ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=67s011urMPrqijMUzLCh1Hzn7U+7BzSOK/7A2nOu2uM=;
        b=fDVnt02nt0FdyXW6ADRqGzR8FiFjOlXaew3MPOZEmMMjNloj+CrrqdPpIthngWFkBp
         NwLYat5hJC+iMkT3DkXC36v3BWSSxGiO5JsfXH2N6sfVHevVNPax+3crXn4lPoCbW8pN
         3Ii7ZHKdSOEThSrqIUzDUklrWSoV75jznTLIMFWYsG3A9OkHzNE86uE2eHkFVrjRDdYH
         xJ/hF+9t5S4hOpocr8VtiikBPnEiZYOrxMMXDRXdtRHL5jZ2n8qxZOt0d9UxuERjeIEG
         I/g9/d/9C6sEs03RVMCSyesPd24RAIdasodOBUD0rOA1y/lSrLSKn7bFHaj8i8wOVy7e
         dkUA==
X-Gm-Message-State: AOAM532FnbKOpW35SfWcAMYDBUn9BpA92AZ9G46JgY/42ZABPfhCeVSE
        DXxRNZydGTVF+H7GRVxxBqfeaFR034rkMuqMQ0RtG2bZ+LZF
X-Google-Smtp-Source: ABdhPJzZ5j51Lan1+tvuZNfsLZWSY1sZloDxOhFva3hHh+saipNbENHDArsucUXEihOzis2DfSazxyGkONd4is69KnxfcvOUjqaT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d91:b0:2d3:bef3:a073 with SMTP id
 h17-20020a056e021d9100b002d3bef3a073mr5105450ila.60.1654228512039; Thu, 02
 Jun 2022 20:55:12 -0700 (PDT)
Date:   Thu, 02 Jun 2022 20:55:12 -0700
In-Reply-To: <20220603033532.5154-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6700505e083161f@google.com>
Subject: Re: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __device_attach

usb usb9: device_add((null)) --> -22
general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 1 PID: 4084 Comm: syz-executor.0 Not tainted 5.18.0-syzkaller-11972-gd1dc87763f40-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:948
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90003347b98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff92000668f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000002 RDI: 0000000000000108
RBP: ffff888021878030 R08: 0000000000000000 R09: ffffffff8dbb1097
R10: fffffbfff1b76212 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff8880218780b0
FS:  00007f8da1571700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8da059d090 CR3: 000000006b626000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_ioctl.part.0+0x48e/0x560 drivers/usb/core/devio.c:2356
 proc_ioctl drivers/usb/core/devio.c:182 [inline]
 proc_ioctl_default drivers/usb/core/devio.c:2391 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x2c08/0x36f0 drivers/usb/core/devio.c:2807
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f8da0489109
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8da1571168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8da059bf60 RCX: 00007f8da0489109
RDX: 0000000020000040 RSI: 00000000c0105512 RDI: 0000000000000005
RBP: 00007f8da04e308d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff3b94a64f R14: 00007f8da1571300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__device_attach+0xad/0x4a0 drivers/base/dd.c:948
Code: e8 03 42 80 3c 20 00 0f 85 a3 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 65 48 49 8d bc 24 08 01 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 06 0f 8e 6e 03 00 00 45 0f b6 b4 24 08 01 00
RSP: 0018:ffffc90003347b98 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff92000668f74 RCX: 0000000000000000
RDX: 0000000000000021 RSI: 0000000000000002 RDI: 0000000000000108
RBP: ffff888021878030 R08: 0000000000000000 R09: ffffffff8dbb1097
R10: fffffbfff1b76212 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 00000000fffffff0 R15: ffff8880218780b0
FS:  00007f8da1571700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8da059d090 CR3: 000000006b626000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 03 42 80 3c       	callq  0x3c804208
   5:	20 00                	and    %al,(%rax)
   7:	0f 85 a3 03 00 00    	jne    0x3b0
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 8b 65 48          	mov    0x48(%rbp),%r12
  1b:	49 8d bc 24 08 01 00 	lea    0x108(%r12),%rdi
  22:	00
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 06                	je     0x38
  32:	0f 8e 6e 03 00 00    	jle    0x3a6
  38:	45                   	rex.RB
  39:	0f                   	.byte 0xf
  3a:	b6 b4                	mov    $0xb4,%dh
  3c:	24 08                	and    $0x8,%al
  3e:	01 00                	add    %eax,(%rax)


Tested on:

commit:         d1dc8776 assoc_array: Fix BUG_ON during garbage collect
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113f50ddf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12390667f00000

