Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C182159B2FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiHUJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiHUJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 05:53:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBCE6D
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 02:53:12 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o9-20020a056e0214c900b002dc29c288bfso6410007ilk.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 02:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Y3ohtxzyfjecMyfPrWqbrtHnd2LOCq2GyjbDwe7DVQU=;
        b=0Uj/QV2EOVUF+Q1FudlJ4tZWZ90kLwfez+1sFX1Xbib7fHCvkUTDnfO4DhxOs6krYk
         tSM7pZXbN3kguATjIUR8lrN4wnYHF1eDGFb5uVsin+zxLWLFVoiTU+viBVN67aiZfsNI
         7uKyKcRUXJIIFx/EiIlDgm9Siz9RfX/ez0Dg/6E8pNu+L4cutWIEAWBANNEBsI3PlzCb
         WnbgTegvxmbIRYhTTRRtG5B17KrH9oXCo0sv14piZW7H1CUfAxy4OaD4fnz9H4PTAeJc
         GDtK4ZhxwZbbOPDBlkX2H9rIDEzsPGAw24aTWR+HV/iY7yXqh9SCRamvjzU5m0J555Mo
         wweA==
X-Gm-Message-State: ACgBeo0offagdh5v2Jwax+Ak9RT1CB79HMGXxqn5tQ3p+X4cHwnSa9r4
        Y7FCCXJ6OOiZjKPUjL+/k+ud4rnXLGEY6yYp93Q0LcNW5iau
X-Google-Smtp-Source: AA6agR4NlrP13WbxNL2GH1apEb/auTIoEfODfMiLhO3B1tVO893cK8z3knlZpDC41EkhaSxJtY45f3kNiDYsN9Jr7Qm8rX7jPyrQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1094:b0:2e9:1ea9:4ad4 with SMTP id
 r20-20020a056e02109400b002e91ea94ad4mr5951473ilj.222.1661075591932; Sun, 21
 Aug 2022 02:53:11 -0700 (PDT)
Date:   Sun, 21 Aug 2022 02:53:11 -0700
In-Reply-To: <20220821013333.1710-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a315f05e6bd4c80@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in kvm_put_kvm
From:   syzbot <syzbot+ee478a0237db20ef61f1@syzkaller.appspotmail.com>
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
KASAN: vmalloc-out-of-bounds Read in notifier_chain_register

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in notifier_chain_register+0x1bd/0x210 kernel/notifier.c:32
Read of size 4 at addr ffffc90004f73bf0 by task syz-executor.0/4102

CPU: 1 PID: 4102 Comm: syz-executor.0 Not tainted 5.19.0-syzkaller-13930-g7ebfc85e2cd7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x59/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 notifier_chain_register+0x1bd/0x210 kernel/notifier.c:32
 __blocking_notifier_chain_register kernel/notifier.c:266 [inline]
 blocking_notifier_chain_register+0x6f/0xc0 kernel/notifier.c:284
 kvm_init_pm_notifier arch/x86/kvm/../../../virt/kvm/kvm_main.c:938 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1223 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4913 [inline]
 kvm_dev_ioctl+0x1060/0x1e80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4960
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe58a889279
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe58bac9168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe58a99bf80 RCX: 00007fe58a889279
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00007fe58a8e3189 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffa66a9c1f R14: 00007fe58bac9300 R15: 0000000000022000
 </TASK>

Memory state around the buggy address:
 ffffc90004f73a80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004f73b00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90004f73b80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                                             ^
 ffffc90004f73c00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90004f73c80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


Tested on:

commit:         7ebfc85e Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1517a8b5080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=924833c12349a8c0
dashboard link: https://syzkaller.appspot.com/bug?extid=ee478a0237db20ef61f1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12118e5b080000

