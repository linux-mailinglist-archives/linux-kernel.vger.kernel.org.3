Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77B14D78F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiCNAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiCNAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:50:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B41EAF8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:49:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id k10-20020a5d91ca000000b006414a00b160so11127590ior.18
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OHRLMLoHkEbfYamoPLRuqVSCdAcnIFKnHOlbAz7Kclk=;
        b=N/fOLr/IKzOQKDUREmCKSdAQDAoeu/QeEc/fYQdiwPXZzed57G24I7e7YqZlWrj/NH
         0x9/iIYAaf6FI5Oswd9i5k8txKLsQGY91/gQs8OPENs5xTvKMEw7iD3ZGGVBktFRGTiA
         72+SbvVpzdZOYxuRaVbDspNZs/94LhyEKVf5yGXYC+1m1GFvYRpL3FHnPuUBcH2Yqimz
         JloN2lUlDNSVpB65WagdC6pP8DlWbJ3dZ6/027ljpSgACxh9zMwt62W0cV1XSE6MKi1a
         hgxiHUrZE51lNZDKINBiGbhcqSpYE7N6ZiPqDLspGzzWzNfWH+xeDeq7gA9H9+5MHdwD
         QU0Q==
X-Gm-Message-State: AOAM530FCvLejLLjtKOhI6nOQd3FbDbBdC+J879L01nCoeWJJtrkRZwV
        pthOg9xxeoZk/QfPnlB1XDndRq6JneGcDHwjswySlF2LIgkn
X-Google-Smtp-Source: ABdhPJzu0OBRWuXc30QXUnUn0/csjXuuxH1iONtXJ/c+/bb6rJJS4XnK2aGrn8buVl//ZtI4K+O+vhFj7IX3nnChWYL+7316kF3d
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29ce:b0:609:4f60:59cb with SMTP id
 z14-20020a05660229ce00b006094f6059cbmr17350284ioq.183.1647218948201; Sun, 13
 Mar 2022 17:49:08 -0700 (PDT)
Date:   Sun, 13 Mar 2022 17:49:08 -0700
In-Reply-To: <20220314003725.1713-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046602c05da230c76@google.com>
Subject: Re: [syzbot] general protection fault in __pm_runtime_resume (2)
From:   syzbot <syzbot+b9bd12fbed3485a3e51f@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __pm_runtime_resume

general protection fault, probably for non-canonical address 0xdffffc0000000072: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000390-0x0000000000000397]
CPU: 0 PID: 45 Comm: kworker/u5:0 Not tainted 5.17.0-rc7-syzkaller-00060-g92f90cc9fe0e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_cmd_work
RIP: 0010:__pm_runtime_resume+0x45/0x170 drivers/base/power/runtime.c:1126
Code: 44 89 ee e8 2d af 02 fd 45 85 ed 75 4e e8 a3 ab 02 fd 48 8d bd 91 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 03 01 00 00
RSP: 0018:ffffc9000115fc28 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888021a7e000 RCX: 0000000000000000
RDX: 0000000000000072 RSI: ffffffff8476148d RDI: 0000000000000391
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffc4a7f
R10: ffffffff84761483 R11: 000000000000000c R12: 0000000000000004
R13: 0000000000000000 R14: ffff888021a7e190 R15: ffff888021a7e128
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555c48214048 CR3: 000000007e914000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 pm_runtime_get_sync include/linux/pm_runtime.h:420 [inline]
 h5_enqueue+0x175/0x390 drivers/bluetooth/hci_h5.c:632
 hci_uart_send_frame+0x1ee/0x6b0 drivers/bluetooth/hci_ldisc.c:286
 hci_send_frame+0x1c0/0x370 net/bluetooth/hci_core.c:2942
 hci_cmd_work+0x204/0x3c0 net/bluetooth/hci_core.c:3861
 process_one_work+0x9ac/0x1650 kernel/workqueue.c:2307
 worker_thread+0x657/0x1110 kernel/workqueue.c:2454
 kthread+0x2e9/0x3a0 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__pm_runtime_resume+0x45/0x170 drivers/base/power/runtime.c:1126
Code: 44 89 ee e8 2d af 02 fd 45 85 ed 75 4e e8 a3 ab 02 fd 48 8d bd 91 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 03 01 00 00
RSP: 0018:ffffc9000115fc28 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888021a7e000 RCX: 0000000000000000
RDX: 0000000000000072 RSI: ffffffff8476148d RDI: 0000000000000391
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8ffc4a7f
R10: ffffffff84761483 R11: 000000000000000c R12: 0000000000000004
R13: 0000000000000000 R14: ffff888021a7e190 R15: ffff888021a7e128
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcda3cf0718 CR3: 0000000021ecd000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	44 89 ee             	mov    %r13d,%esi
   3:	e8 2d af 02 fd       	callq  0xfd02af35
   8:	45 85 ed             	test   %r13d,%r13d
   b:	75 4e                	jne    0x5b
   d:	e8 a3 ab 02 fd       	callq  0xfd02abb5
  12:	48 8d bd 91 03 00 00 	lea    0x391(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 03 01 00 00    	jne    0x143


Tested on:

commit:         92f90cc9 Merge tag 'fuse-fixes-5.17-rc8' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=15ec83ad700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=442f8ac61e60a75e
dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd12fbed3485a3e51f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d10379700000

