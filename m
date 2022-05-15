Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444F5276C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiEOJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiEOJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:59:09 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBC393FD
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:59:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ay38-20020a5d9da6000000b0065adc1f932bso8315476iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dXrZqzLacjALnp/9Lb0r4NL7NJ68sYlMo/1uj1P8idw=;
        b=8Oe9fFQpaKG+E5dvUVGnMFE7XdTKgcKMciVP9n5gJtCo5Z8g61yIGIqkdFfrzDNDLu
         kHpG4O25fUQ9sfhVB0KPrl/IUR26Ewi1XhK7uaeyvB7U0cTgSYHhsBM1ASIO4Fubv1Zf
         XmQYgvLpMUC91kaT1o4sat+pG4n7zw9fPSAwqwdngcarZ8yN3+9BzPzEuslf/DlPno6L
         vNicUf1oZbNDlNR3N1mg62jsqlIkhwExOhuMeG2clahCiTmM40FoWJJOamZj36YPjSBy
         ReZgE6ZPE4TqDnv0BYXcDaOUt63AMXcpwFv+seUF+QwSKTZ9umKfzeeivPQmN9Il5Y9/
         19eA==
X-Gm-Message-State: AOAM530zjL1jf00kbj8iAjMs6AszJTJ+CiFfe6fMO0XtT9myIwtdcF5F
        Jegu0+kknZ/qQ6fXX3igtp2zFCwNmxpy9JNewQtlFhFqWJKU
X-Google-Smtp-Source: ABdhPJxyGT9ScgW7X6MJm6zJVvwHkrZi0TFhzI3M40wqMIjz8KRFm49Hkkm1AdmTM0C+8f9WTUI58z1IQehvhp+1VVDKjIrSCXWC
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1406:b0:649:d35b:4bbb with SMTP id
 t6-20020a056602140600b00649d35b4bbbmr5735181iov.23.1652608747851; Sun, 15 May
 2022 02:59:07 -0700 (PDT)
Date:   Sun, 15 May 2022 02:59:07 -0700
In-Reply-To: <20220515094719.1786-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e542d05df09f5cb@google.com>
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
From:   syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
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
general protection fault in dst_dev_put

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dst_dev_put+0x22/0x320 net/core/dst.c:154
Code: 00 00 00 00 00 0f 1f 00 41 57 41 56 49 89 fe 41 55 41 54 55 e8 5f 7b 2b fa 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
RSP: 0018:ffffc90000147c88 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff874dc581 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffe8ffffd801e7
R10: fffff91ffffb003c R11: 0000000000000000 R12: 0000000000000003
R13: ffff888069c1a8a8 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f729a014ff8 CR3: 0000000023035000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fib6_nh_release_dsts.part.0+0xf8/0x160 net/ipv6/route.c:3672
 fib6_nh_release_dsts net/ipv6/route.c:3663 [inline]
 fib6_nh_release+0x11a/0x240 net/ipv6/route.c:3653
 fib6_info_destroy_rcu+0x187/0x210 net/ipv6/ip6_fib.c:176
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x7b1/0x1880 kernel/rcu/tree.c:2786
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dst_dev_put+0x22/0x320 net/core/dst.c:154
Code: 00 00 00 00 00 0f 1f 00 41 57 41 56 49 89 fe 41 55 41 54 55 e8 5f 7b 2b fa 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 dc 02 00 00 49 8d 7e 3a 4d 8b 26 48 b8 00 00 00
RSP: 0018:ffffc90000147c88 EFLAGS: 00010246

RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff874dc581 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffe8ffffd801e7
R10: fffff91ffffb003c R11: 0000000000000000 R12: 0000000000000003
R13: ffff888069c1a8a8 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f729a014ff8 CR3: 0000000023035000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	0f 1f 00             	nopl   (%rax)
   7:	41 57                	push   %r15
   9:	41 56                	push   %r14
   b:	49 89 fe             	mov    %rdi,%r14
   e:	41 55                	push   %r13
  10:	41 54                	push   %r12
  12:	55                   	push   %rbp
  13:	e8 5f 7b 2b fa       	callq  0xfa2b7b77
  18:	4c 89 f2             	mov    %r14,%rdx
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 dc 02 00 00    	jne    0x30f
  33:	49 8d 7e 3a          	lea    0x3a(%r14),%rdi
  37:	4d 8b 26             	mov    (%r14),%r12
  3a:	48                   	rex.W
  3b:	b8                   	.byte 0xb8
  3c:	00 00                	add    %al,(%rax)


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=16848769f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cc4e85f00000

