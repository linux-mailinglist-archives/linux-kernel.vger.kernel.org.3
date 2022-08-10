Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB758E95C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiHJJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiHJJNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:13:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A486C3D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:13:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w7-20020a5d9607000000b0067c6030dfb8so7753501iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=FKHfwpgy/oFXIvLPEAflHzsj253CYh/YxdrAewsnulk=;
        b=KHR2IABOAS6fJ82gvLLU7kQDai8+FedQa/k7gTP449ffqNycHrgCoI6xFE4pDMRMm7
         5ddCGFxAw7nBtWHJ4BnFPhktwMCLFORFfC4Z6RWpx/BY3SiZ1pEmqDg66hpbQ6f3q4n1
         rcqyTxptdtvrj3Jz0OFEqHCBlEEHWKFEQRewgmxmzfVoikyPDbjM6c532S1YPNainmHT
         GIbN5BfYm+uubfeg24EzNvIcXEC0sLEhScfpTffElJuavqZPRH/P3wem897MQHyEmEoD
         0aP4LzdFlXogp36ifLVbGWo9wEA4Uf6YMuJedED4kfVFUsaIbv+BTS2hzFFbQBk7gf3N
         b9AQ==
X-Gm-Message-State: ACgBeo0DJhwHi42SqsCUoNdFXsgKJmHADvL79a3GhQzwxXivZEh5k5KU
        oqkyOfrsvrmiqYD5rmUio4SnW0S3S1ZbaAGFhu4RWXA2ak7T
X-Google-Smtp-Source: AA6agR7y0Sx1zr94W68yQIMRI/9oi0yx8cNrw5sYZHUa/JS5pxAmszVcuN2pzmfx8+5crcfGvXgl1yaVEGMyoTp/8TLOwMSOuWkj
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:2df:1aae:47c4 with SMTP id
 q14-20020a92ca4e000000b002df1aae47c4mr12371069ilo.57.1660122803606; Wed, 10
 Aug 2022 02:13:23 -0700 (PDT)
Date:   Wed, 10 Aug 2022 02:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe1d6705e5df7580@google.com>
Subject: [syzbot] linux-next boot error: general protection fault in __switch_to
From:   syzbot <syzbot+95ea0d29692df9761488@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        masahiroy@kernel.org, mingo@redhat.com, nathan@kernel.org,
        peterz@infradead.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5fcd1080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
dashboard link: https://syzkaller.appspot.com/bug?extid=95ea0d29692df9761488
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95ea0d29692df9761488@syzkaller.appspotmail.com

general protection fault, maybe for address 0xffff888020655880: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1089 Comm: kworker/u4:4 Not tainted 5.19.0-next-20220810-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__switch_to+0x680/0x1050 arch/x86/kernel/process_64.c:661
Code: 67 05 00 00 eb 13 0f 1f 00 66 8c d0 66 83 f8 18 74 07 b8 18 00 00 00 8e d0 48 83 c4 10 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f <c3> 48 8d bd 28 18 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
RSP: 0000:ffffc900057cf530 EFLAGS: 00010086
RAX: ffff888020655880 RBX: ffff000000000000 RCX: ffffffff812a921c
RDX: 1ffff110040cab10 RSI: 0000000000000008 RDI: ffff888020523b00
RBP: ffff000000000000 R08: 0000000000000001 R09: ffff888020523b07
R10: ffffed10040a4760 R11: 0000000000000000 R12: ffff000000000000
R13: ffff000000000000 R14: ffff000000000000 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__switch_to+0x680/0x1050 arch/x86/kernel/process_64.c:661
Code: 67 05 00 00 eb 13 0f 1f 00 66 8c d0 66 83 f8 18 74 07 b8 18 00 00 00 8e d0 48 83 c4 10 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f <c3> 48 8d bd 28 18 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
RSP: 0000:ffffc900057cf530 EFLAGS: 00010086
RAX: ffff888020655880 RBX: ffff000000000000 RCX: ffffffff812a921c
RDX: 1ffff110040cab10 RSI: 0000000000000008 RDI: ffff888020523b00
RBP: ffff000000000000 R08: 0000000000000001 R09: ffff888020523b07
R10: ffffed10040a4760 R11: 0000000000000000 R12: ffff000000000000
R13: ffff000000000000 R14: ffff000000000000 R15: ffff000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000bc8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	67 05 00 00 eb 13    	addr32 add $0x13eb0000,%eax
   6:	0f 1f 00             	nopl   (%rax)
   9:	66 8c d0             	mov    %ss,%ax
   c:	66 83 f8 18          	cmp    $0x18,%ax
  10:	74 07                	je     0x19
  12:	b8 18 00 00 00       	mov    $0x18,%eax
  17:	8e d0                	mov    %eax,%ss
  19:	48 83 c4 10          	add    $0x10,%rsp
  1d:	4c 89 e0             	mov    %r12,%rax
  20:	5b                   	pop    %rbx
  21:	5d                   	pop    %rbp
  22:	41 5c                	pop    %r12
  24:	41 5d                	pop    %r13
  26:	41 5e                	pop    %r14
  28:	41 5f                	pop    %r15
* 2a:	c3                   	retq <-- trapping instruction
  2b:	48 8d bd 28 18 00 00 	lea    0x1828(%rbp),%rdi
  32:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  39:	fc ff df
  3c:	48 89 fa             	mov    %rdi,%rdx
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
