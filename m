Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA3536D68
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiE1PCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiE1PCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:02:16 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683CF12AC8
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:02:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u7-20020a05660229a700b006657df613cbso4252710ios.14
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nR6Y/jrwWnlGdn4UloS/R/H0u6Pl7U01+gd1axF8MeA=;
        b=R4qbIwf+1IZrppNS2+U9EY58wBS6qEbsRl3ifK1swkK5IEx40aeRdLmVTMCAegP4KA
         B47ZN4et4LScd1jBYf5ZvogQf5E+60ZVfZRRX5c5mVY8j/2tZvxUhYpsvOOnpWfuxPBQ
         D7mbgVUQcvx0X5chy0xSLdl/P2qWsjSf2b/+g7PToDE7IkN9GSzjqSqsR7ZnwzxacMcY
         PinC5M4Es+8rVzJu9v++GIUQHONHQ2whhfgRrPj0J1nsbRDowaVhLm0L9XiYbm2t0Qy3
         O9uLFpyIcnBqplbH62vLoTbK7fkgEMfa9m9EVv0vsl3AX29lu0K/upBTCA45LEQaWM6q
         SGUw==
X-Gm-Message-State: AOAM5339RHiMuEyXXbtSllESkyf7Bz6Smwerz7mjTaFIoPB0HlmWzFZQ
        6O8niiIcGVoGD5sA9HcMjQk3Y0cQBTirZ1VnvrAKJYjBpzSX
X-Google-Smtp-Source: ABdhPJwKEkMt64vcoB2wz1pW0VF5iJH3m/cRe7NQg/SQeNKvxZrm1Mqrjz/QdAyAHnvT92N0r7togNjEoF6hv3zWfhUXUdAEZXzy
MIME-Version: 1.0
X-Received: by 2002:a6b:e814:0:b0:660:d496:d2d2 with SMTP id
 f20-20020a6be814000000b00660d496d2d2mr15136406ioh.147.1653750133685; Sat, 28
 May 2022 08:02:13 -0700 (PDT)
Date:   Sat, 28 May 2022 08:02:13 -0700
In-Reply-To: <YpI1g7/sZVYKz5Hn@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004403a805e013b52c@google.com>
Subject: Re: [syzbot] WARNING in driver_unregister
From:   syzbot <syzbot+02b16343704b3af1667e@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
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

syzbot tried to test the proposed patch but the build/boot failed:

KASAN: null-ptr-deref Read in ida_free

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
BUG: KASAN: null-ptr-deref in ida_free+0x1b6/0x2e0 lib/idr.c:510
Read of size 8 at addr 0000000000000000 by task syz-fuzzer/1284

CPU: 1 PID: 1284 Comm: syz-fuzzer Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_report mm/kasan/report.c:432 [inline]
 kasan_report.cold+0x61/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
 ida_free+0x1b6/0x2e0 lib/idr.c:510
 dev_free+0xdb/0x6e0 drivers/usb/gadget/legacy/raw_gadget.c:209
 kref_put include/linux/kref.h:65 [inline]
 raw_release+0x219/0x290 drivers/usb/gadget/legacy/raw_gadget.c:421
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x1f7/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x49dfbb
Code: e8 aa 4b fc ff eb 88 cc cc cc cc cc cc cc cc e8 bb 8f fc ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
RSP: 002b:000000c0002fb5f0 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000c00001e000 RCX: 000000000049dfbb
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 000000c0002fb630 R08: 0000000000000001 R09: 000000c0002fb650
R10: 000000c0002fb5dc R11: 0000000000000206 R12: 000000c0002fb5e8
R13: 0000000000203000 R14: 000000c0000001a0 R15: 00007f1aab9f437e
 </TASK>
==================================================================


Warning: Permanently added '10.128.1.74' (ECDSA) to the list of known hosts.
2022/05/28 15:01:17 fuzzer started
2022/05/28 15:01:17 connecting to host at 10.128.0.163:44569
2022/05/28 15:01:17 checking machine...
2022/05/28 15:01:17 checking revisions...
syzkaller login: [   28.730807][ T1284] ==================================================================
[   28.732309][ T1284] BUG: KASAN: null-ptr-deref in ida_free+0x1b6/0x2e0
[   28.733500][ T1284] Read of size 8 at addr 0000000000000000 by task syz-fuzzer/1284
[   28.734813][ T1284] 
[   28.735363][ T1284] CPU: 1 PID: 1284 Comm: syz-fuzzer Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
[   28.737366][ T1284] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   28.738920][ T1284] Call Trace:
[   28.739425][ T1284]  <TASK>
[   28.739871][ T1284]  dump_stack_lvl+0xcd/0x134
[   28.740555][ T1284]  kasan_report.cold+0x61/0x1c6
[   28.741239][ T1284]  ? ida_free+0x1b6/0x2e0
[   28.741875][ T1284]  kasan_check_range+0x13d/0x180
[   28.742577][ T1284]  ida_free+0x1b6/0x2e0
[   28.743209][ T1284]  ? ida_destroy+0x3b0/0x3b0
[   28.743995][ T1284]  ? rcu_read_lock_sched_held+0x3a/0x70
[   28.744853][ T1284]  ? kfree+0x36b/0x4f0
[   28.745531][ T1284]  dev_free+0xdb/0x6e0
[   28.746110][ T1284]  ? _raw_spin_unlock_irqrestore+0x38/0x70
[   28.747069][ T1284]  raw_release+0x219/0x290
[   28.747719][ T1284]  __fput+0x277/0x9d0
[   28.748344][ T1284]  ? gadget_unbind+0xd0/0xd0
[   28.749014][ T1284]  task_work_run+0xdd/0x1a0
[   28.749693][ T1284]  exit_to_user_mode_prepare+0x1f7/0x200
[   28.750523][ T1284]  syscall_exit_to_user_mode+0x19/0x60
[   28.751641][ T1284]  do_syscall_64+0x42/0xb0
[   28.756063][ T1284]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   28.761951][ T1284] RIP: 0033:0x49dfbb
[   28.765827][ T1284] Code: e8 aa 4b fc ff eb 88 cc cc cc cc cc cc cc cc e8 bb 8f fc ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[   28.785433][ T1284] RSP: 002b:000000c0002fb5f0 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
[   28.793837][ T1284] RAX: 0000000000000000 RBX: 000000c00001e000 RCX: 000000000049dfbb
[   28.801799][ T1284] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
[   28.809765][ T1284] RBP: 000000c0002fb630 R08: 0000000000000001 R09: 000000c0002fb650
[   28.817720][ T1284] R10: 000000c0002fb5dc R11: 0000000000000206 R12: 000000c0002fb5e8
[   28.825672][ T1284] R13: 0000000000203000 R14: 000000c0000001a0 R15: 00007f1aab9f437e
[   28.833636][ T1284]  </TASK>
[   28.836678][ T1284] ==================================================================
[   28.844826][ T1284] Kernel panic - not syncing: panic_on_warn set ...
[   28.851483][ T1284] CPU: 1 PID: 1284 Comm: syz-fuzzer Not tainted 5.18.0-rc5-syzkaller-00157-g97fa5887cf28-dirty #0
[   28.862730][ T1284] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   28.872864][ T1284] Call Trace:
[   28.876128][ T1284]  <TASK>
[   28.879041][ T1284]  dump_stack_lvl+0xcd/0x134
[   28.883617][ T1284]  panic+0x2d7/0x636
[   28.887498][ T1284]  ? panic_print_sys_info.part.0+0x10b/0x10b
[   28.893461][ T1284]  ? ida_free+0x1b6/0x2e0
[   28.897951][ T1284]  end_report.part.0+0x3f/0x7c
[   28.902699][ T1284]  kasan_report.cold+0x93/0x1c6
[   28.907540][ T1284]  ? ida_free+0x1b6/0x2e0
[   28.911848][ T1284]  kasan_check_range+0x13d/0x180
[   28.916765][ T1284]  ida_free+0x1b6/0x2e0
[   28.921001][ T1284]  ? ida_destroy+0x3b0/0x3b0
[   28.925850][ T1284]  ? rcu_read_lock_sched_held+0x3a/0x70
[   28.931386][ T1284]  ? kfree+0x36b/0x4f0
[   28.935444][ T1284]  dev_free+0xdb/0x6e0
[   28.939501][ T1284]  ? _raw_spin_unlock_irqrestore+0x38/0x70
[   28.946270][ T1284]  raw_release+0x219/0x290
[   28.951563][ T1284]  __fput+0x277/0x9d0
[   28.955538][ T1284]  ? gadget_unbind+0xd0/0xd0
[   28.960121][ T1284]  task_work_run+0xdd/0x1a0
[   28.964752][ T1284]  exit_to_user_mode_prepare+0x1f7/0x200
[   28.970391][ T1284]  syscall_exit_to_user_mode+0x19/0x60
[   28.975939][ T1284]  do_syscall_64+0x42/0xb0
[   28.980357][ T1284]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   28.986259][ T1284] RIP: 0033:0x49dfbb
[   28.990166][ T1284] Code: e8 aa 4b fc ff eb 88 cc cc cc cc cc cc cc cc e8 bb 8f fc ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[   29.009849][ T1284] RSP: 002b:000000c0002fb5f0 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
[   29.018247][ T1284] RAX: 0000000000000000 RBX: 000000c00001e000 RCX: 000000000049dfbb
[   29.026199][ T1284] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
[   29.034157][ T1284] RBP: 000000c0002fb630 R08: 0000000000000001 R09: 000000c0002fb650
[   29.042160][ T1284] R10: 000000c0002fb5dc R11: 0000000000000206 R12: 000000c0002fb5e8
[   29.050128][ T1284] R13: 0000000000203000 R14: 000000c0000001a0 R15: 00007f1aab9f437e
[   29.058093][ T1284]  </TASK>
[   29.061162][ T1284] Kernel Offset: disabled
[   29.065471][ T1284] Rebooting in 86400 seconds..



Tested on:

commit:         97fa5887 USB: new quirk for Dell Gen 2 devices
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7b232ec3adf5c8d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b16343704b3af1667e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cc0d03f00000

