Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA09526E96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiENDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiENDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:00:08 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EE3925E7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:30:09 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id r137-20020a6b2b8f000000b0065dbbc04e94so4957453ior.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AjHLO46SXL91TRMXYwep6z2HgCCUZNvq37pyPVP1NdI=;
        b=1zmeecMz5XCBZWzYICY9FZDMFXBq1PgalAVXsabjJgWZ3+n8ggP6KsxzyHgXe1JwS/
         VpaZ2779I2IW5hoTmQHJ2Y6bZITum+mAoDThG5jxC7n96fIrTaWobdrdPY144vdyDdVd
         1R14LmrngzEYArkBMz6kMz+0iFeePqWWHX2QaXsnwQpUZ3Dq6mZZ9elHtohGn8qZkeqS
         8YclyxLTQBqZGNYBDpryQDvr/FrahCt+wOn1FQyV7YgFsjgXYNaSODQeZ6Csy/T1otLx
         XYC4MlIrnmSQiHAVVDJ711wkABrchR8xo0ZN+wF2wU7pSDNsOIxYiPoON9Ms4A5F+HoL
         NVqA==
X-Gm-Message-State: AOAM531DaqbRih080eIidS5CySy5moMoA873NvD39cvthikj2wivzyeK
        zNXt1GajB/gq23evbGUAV+bk1+3uWf/YMRddfcGQ2B17c9KQ
X-Google-Smtp-Source: ABdhPJzJT6sSzjHuMFE+bVQgLePoccH47seAQ70HB8zTkYvqeyoiMo5JhvO99FUb9osJ2y5x5aXqlRgzffiVp44kFbA1JhRE5b76
MIME-Version: 1.0
X-Received: by 2002:a92:a00a:0:b0:2d0:ee4a:b1a0 with SMTP id
 e10-20020a92a00a000000b002d0ee4ab1a0mr3866740ili.159.1652491809180; Fri, 13
 May 2022 18:30:09 -0700 (PDT)
Date:   Fri, 13 May 2022 18:30:09 -0700
In-Reply-To: <20220514005032.346-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047d69305deeebb6c@google.com>
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
BUG: unable to handle kernel paging request in dst_dev_put

BUG: unable to handle page fault for address: ffffffffffffffff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD ba8f067 
P4D ba8f067 
PUD ba91067 
PMD 0 

Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.18.0-rc6-syzkaller-00009-gfeb9c5e19e91-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:dst_dev_put+0x30/0x320 net/core/dst.c:154
Code: fe 41 55 41 54 55 e8 bf 78 2b fa 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 dc 02 00 00 49 8d 7e 3a <4d> 8b 26 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6
RSP: 0018:ffffc900001b7c88 EFLAGS: 00010246

RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 1fffffffffffffff RSI: ffffffff874dc821 RDI: 0000000000000039
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffe8ffffc9571f
R10: fffff91ffff92ae3 R11: 0000000000000000 R12: 0000000000000003
R13: ffff88807ac008a8 R14: ffffffffffffffff R15: ffffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 000000006b914000 CR4: 00000000003506e0
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
CR2: ffffffffffffffff
---[ end trace 0000000000000000 ]---
RIP: 0010:dst_dev_put+0x30/0x320 net/core/dst.c:154
Code: fe 41 55 41 54 55 e8 bf 78 2b fa 4c 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 dc 02 00 00 49 8d 7e 3a <4d> 8b 26 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6
RSP: 0018:ffffc900001b7c88 EFLAGS: 00010246

RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 0000000000000100
RDX: 1fffffffffffffff RSI: ffffffff874dc821 RDI: 0000000000000039
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffe8ffffc9571f
R10: fffff91ffff92ae3 R11: 0000000000000000 R12: 0000000000000003
R13: ffff88807ac008a8 R14: ffffffffffffffff R15: ffffffffffffffff
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 000000006b914000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fe 41 55             	incb   0x55(%rcx)
   3:	41 54                	push   %r12
   5:	55                   	push   %rbp
   6:	e8 bf 78 2b fa       	callq  0xfa2b78ca
   b:	4c 89 f2             	mov    %r14,%rdx
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 c1 ea 03          	shr    $0x3,%rdx
  1c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  20:	0f 85 dc 02 00 00    	jne    0x302
  26:	49 8d 7e 3a          	lea    0x3a(%r14),%rdi
* 2a:	4d 8b 26             	mov    (%r14),%r12 <-- trapping instruction
  2d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  34:	fc ff df
  37:	48 89 fa             	mov    %rdi,%rdx
  3a:	48 c1 ea 03          	shr    $0x3,%rdx
  3e:	0f                   	.byte 0xf
  3f:	b6                   	.byte 0xb6


Tested on:

commit:         feb9c5e1 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=13f8f0f1f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79caa0035f59d385
dashboard link: https://syzkaller.appspot.com/bug?extid=5b1e53987f858500ec00
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1233a91af00000

