Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0DD501B43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbiDNStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiDNSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:49:48 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE563DB4A3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:47:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id d1-20020a6bcd01000000b0064d23a49b27so3531587iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fxnR1qb7euZq/t/wHxPLii/QYjapXLkNdeZFm0KG9Sk=;
        b=pjl+bXhfmgerBKvYGEZZEa/XeoMbY8VbfUW+pKy8UWGHAmy00RWGMHSI+aGXlpfKJP
         WMC0vBrCzHKNb50Hvy6DRf/cRWGoghLZJt+ZgM1LDEtMNaO1ni5JGOMBlOAEAoedflxk
         AWt0Y7XThlkSukrdIDPIxZ5ISU8ervOw3XiVV2TbJhaJHLwoyQDfrcT+jbvzHtBo6JYq
         wNStMXsKozU4dJM2e6aSeEKyg55WHf0rn+N8AM49qCcaXfCuJT2u3ftkLsaKzikuFhXu
         iR42d8zbDpwQ7oTJtz96NVhjKJVJEGYO+AhipEW7f+ycJwrW2UoDjVnN3heKOWFlEcWs
         x//A==
X-Gm-Message-State: AOAM532xo0PXWu+7BU9ApeBzYn62K5G/RoEOCgc2KqXB02Ix95FBKlk3
        u8nAxAx+UWhct0mo5gfe2Q35UlioNnCwDv6wUfeUz87myBCf
X-Google-Smtp-Source: ABdhPJy/nmGnaiAiK9o4YgO+H2pZIXWhUwjjPU7rjujZzobQwcxQmOF4UIkrwmdrwN+u3kTIXxiG9yH/mFHqjWNIKibyVaLbQFup
MIME-Version: 1.0
X-Received: by 2002:a6b:8bc4:0:b0:649:af51:9c5f with SMTP id
 n187-20020a6b8bc4000000b00649af519c5fmr1742928iod.184.1649962041128; Thu, 14
 Apr 2022 11:47:21 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:47:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005abf2305dca1b91b@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
From:   syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
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

HEAD commit:    4ea3c6425269 Merge tag 'powerpc-5.18-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148cb824f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=307baecfd5e87ced
dashboard link: https://syzkaller.appspot.com/bug?extid=1a247e36149ffd709a9b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17279a70f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121dc124f00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142753df700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162753df700000
console output: https://syzkaller.appspot.com/x/log.txt?x=122753df700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com

pvrusb2: You need to resolve the failing condition before this driver can function.  There should be some earlier messages giving more information about the problem.
pvrusb2: Invalid write control endpoint
================================================================================
UBSAN: array-index-out-of-bounds in drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:602:13
index -1 is out of range for type 'int [20]'
CPU: 0 PID: 1959 Comm: pvrusb2-context Not tainted 5.18.0-rc1-syzkaller-00401-g4ea3c6425269 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 pvr2_i2c_core_init+0xc7d/0xd30 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:602
 pvr2_hdw_setup_low drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2134 [inline]
 pvr2_hdw_setup drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2261 [inline]
 pvr2_hdw_initialize+0x787/0x37d0 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2338
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:109 [inline]
 pvr2_context_thread_func+0x250/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1959 Comm: pvrusb2-context Not tainted 5.18.0-rc1-syzkaller-00401-g4ea3c6425269 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 panic+0x2d7/0x636 kernel/panic.c:250
 ubsan_epilogue+0x4a/0x50 lib/ubsan.c:158
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 pvr2_i2c_core_init+0xc7d/0xd30 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:602
 pvr2_hdw_setup_low drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2134 [inline]
 pvr2_hdw_setup drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2261 [inline]
 pvr2_hdw_initialize+0x787/0x37d0 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2338
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:109 [inline]
 pvr2_context_thread_func+0x250/0x850 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
