Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B3533F48
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiEYOd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244836AbiEYOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:33:22 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63FAAE263
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:33:19 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u18-20020a5d8712000000b0064c7a7c497aso11674603iom.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lfuRuCSbDbWw/LnmiLDn4PqMyIUMss4hmHEyVpcB5Bk=;
        b=f6mDWMRnSUugHYZgSC6TVPcd7JJ3/UgkrhCMkgMoweAMYN2u+93N8RPSnImk0INFEL
         XsemPEUXJo8skzUMQir+rG/waIprgWtOGJUwWrWOo+c83lVNrA1rNnP8eif6K5mvN6uw
         V9lsVsVVBwx8h0Kj7xGSPniMUvy080qxVdQWZIp2hNqR8dw3CKqMro1L0pnrwbNm/Z1W
         IK/8RQalOBcUose5x6e8lwVFujr5+2d0E8VGYJ3DD2B2ZTyBQG+P4LzloltTYqff14IW
         ActktOCdDUIj8IU3D7f4cL+FKbaRGOa75h6wqfQQLGBJezaZ24fzr4A7Z6OzsqhoWZEW
         KKwA==
X-Gm-Message-State: AOAM532ioFf0HZ7cGPpfiGijOZKOX5B0M5ZI9U7PWYhdmJWGUtFbQZNd
        BNbgUpByj75YLvrSm2Xlu+qklLKTGZ4Rvp0pSw43bfSAHMdc
X-Google-Smtp-Source: ABdhPJzTwtWHWhxEhDsaVWEr2S8+/3aht9UKWNH55PIwPGUjiB6Db+Hkc6N+N5+hfzxiE3l699mTHOiwxjVZ0ks5kOqz2DReax4x
MIME-Version: 1.0
X-Received: by 2002:a92:6811:0:b0:2cd:994d:7406 with SMTP id
 d17-20020a926811000000b002cd994d7406mr15883176ilc.245.1653489199318; Wed, 25
 May 2022 07:33:19 -0700 (PDT)
Date:   Wed, 25 May 2022 07:33:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d8c8805dfd6f470@google.com>
Subject: [syzbot] memory leak in hidraw_report_event
From:   syzbot <syzbot+f59100a0428e6ded9443@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    aa051d36ce4a Merge tag 'for-linus-2022052401' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cd063df00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb563a60820e68b9
dashboard link: https://syzkaller.appspot.com/bug?extid=f59100a0428e6ded9443
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d91de5f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10522639f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f59100a0428e6ded9443@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810e72f180 (size 32):
  comm "softirq", pid 0, jiffies 4294945143 (age 16.080s)
  hex dump (first 32 bytes):
    64 f3 c6 6a d1 88 07 04 00 00 00 00 00 00 00 00  d..j............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ac6c3>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8357c1d2>] kmemdup include/linux/fortify-string.h:440 [inline]
    [<ffffffff8357c1d2>] hidraw_report_event+0xa2/0x150 drivers/hid/hidraw.c:521
    [<ffffffff8356ddad>] hid_report_raw_event+0x27d/0x740 drivers/hid/hid-core.c:1992
    [<ffffffff8356e41e>] hid_input_report+0x1ae/0x270 drivers/hid/hid-core.c:2065
    [<ffffffff835f0d3f>] hid_irq_in+0x1ff/0x250 drivers/hid/usbhid/hid-core.c:284
    [<ffffffff82d3c7f9>] __usb_hcd_giveback_urb+0xf9/0x230 drivers/usb/core/hcd.c:1670
    [<ffffffff82d3cc26>] usb_hcd_giveback_urb+0x1b6/0x1d0 drivers/usb/core/hcd.c:1747
    [<ffffffff82ef1e14>] dummy_timer+0x8e4/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
    [<ffffffff812f50a8>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1474
    [<ffffffff812f5586>] expire_timers kernel/time/timer.c:1519 [inline]
    [<ffffffff812f5586>] __run_timers.part.0+0x316/0x430 kernel/time/timer.c:1790
    [<ffffffff812f56e4>] __run_timers kernel/time/timer.c:1768 [inline]
    [<ffffffff812f56e4>] run_timer_softirq+0x44/0x90 kernel/time/timer.c:1803
    [<ffffffff848000e6>] __do_softirq+0xe6/0x2ea kernel/softirq.c:571
    [<ffffffff81246db0>] invoke_softirq kernel/softirq.c:445 [inline]
    [<ffffffff81246db0>] __irq_exit_rcu kernel/softirq.c:650 [inline]
    [<ffffffff81246db0>] irq_exit_rcu+0xc0/0x110 kernel/softirq.c:662
    [<ffffffff84574f02>] sysvec_apic_timer_interrupt+0xa2/0xd0 arch/x86/kernel/apic/apic.c:1106
    [<ffffffff84600c8b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
    [<ffffffff8458a070>] native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
    [<ffffffff8458a070>] arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
    [<ffffffff8458a070>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<ffffffff8458a070>] acpi_idle_do_entry+0xc0/0xd0 drivers/acpi/processor_idle.c:554

BUG: memory leak
unreferenced object 0xffff88810e72f160 (size 32):
  comm "softirq", pid 0, jiffies 4294945145 (age 16.060s)
  hex dump (first 32 bytes):
    27 1a e8 41 4f c2 fd 8c 00 00 00 00 00 00 00 00  '..AO...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ac6c3>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8357c1d2>] kmemdup include/linux/fortify-string.h:440 [inline]
    [<ffffffff8357c1d2>] hidraw_report_event+0xa2/0x150 drivers/hid/hidraw.c:521
    [<ffffffff8356ddad>] hid_report_raw_event+0x27d/0x740 drivers/hid/hid-core.c:1992
    [<ffffffff8356e41e>] hid_input_report+0x1ae/0x270 drivers/hid/hid-core.c:2065
    [<ffffffff835f0d3f>] hid_irq_in+0x1ff/0x250 drivers/hid/usbhid/hid-core.c:284
    [<ffffffff82d3c7f9>] __usb_hcd_giveback_urb+0xf9/0x230 drivers/usb/core/hcd.c:1670
    [<ffffffff82d3cc26>] usb_hcd_giveback_urb+0x1b6/0x1d0 drivers/usb/core/hcd.c:1747
    [<ffffffff82ef1e14>] dummy_timer+0x8e4/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
    [<ffffffff812f50a8>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1474
    [<ffffffff812f5586>] expire_timers kernel/time/timer.c:1519 [inline]
    [<ffffffff812f5586>] __run_timers.part.0+0x316/0x430 kernel/time/timer.c:1790
    [<ffffffff812f56e4>] __run_timers kernel/time/timer.c:1768 [inline]
    [<ffffffff812f56e4>] run_timer_softirq+0x44/0x90 kernel/time/timer.c:1803
    [<ffffffff848000e6>] __do_softirq+0xe6/0x2ea kernel/softirq.c:571
    [<ffffffff81246db0>] invoke_softirq kernel/softirq.c:445 [inline]
    [<ffffffff81246db0>] __irq_exit_rcu kernel/softirq.c:650 [inline]
    [<ffffffff81246db0>] irq_exit_rcu+0xc0/0x110 kernel/softirq.c:662
    [<ffffffff84574f02>] sysvec_apic_timer_interrupt+0xa2/0xd0 arch/x86/kernel/apic/apic.c:1106
    [<ffffffff84600c8b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
    [<ffffffff8458a070>] native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
    [<ffffffff8458a070>] arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
    [<ffffffff8458a070>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<ffffffff8458a070>] acpi_idle_do_entry+0xc0/0xd0 drivers/acpi/processor_idle.c:554

BUG: memory leak
unreferenced object 0xffff88810e72f140 (size 32):
  comm "softirq", pid 0, jiffies 4294945147 (age 16.040s)
  hex dump (first 32 bytes):
    5e 2d ce 49 18 07 8e f1 00 00 00 00 00 00 00 00  ^-.I............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814ac6c3>] kmemdup+0x23/0x50 mm/util.c:128
    [<ffffffff8357c1d2>] kmemdup include/linux/fortify-string.h:440 [inline]
    [<ffffffff8357c1d2>] hidraw_report_event+0xa2/0x150 drivers/hid/hidraw.c:521
    [<ffffffff8356ddad>] hid_report_raw_event+0x27d/0x740 drivers/hid/hid-core.c:1992
    [<ffffffff8356e41e>] hid_input_report+0x1ae/0x270 drivers/hid/hid-core.c:2065
    [<ffffffff835f0d3f>] hid_irq_in+0x1ff/0x250 drivers/hid/usbhid/hid-core.c:284
    [<ffffffff82d3c7f9>] __usb_hcd_giveback_urb+0xf9/0x230 drivers/usb/core/hcd.c:1670
    [<ffffffff82d3cc26>] usb_hcd_giveback_urb+0x1b6/0x1d0 drivers/usb/core/hcd.c:1747
    [<ffffffff82ef1e14>] dummy_timer+0x8e4/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
    [<ffffffff812f50a8>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1474
    [<ffffffff812f5586>] expire_timers kernel/time/timer.c:1519 [inline]
    [<ffffffff812f5586>] __run_timers.part.0+0x316/0x430 kernel/time/timer.c:1790
    [<ffffffff812f56e4>] __run_timers kernel/time/timer.c:1768 [inline]
    [<ffffffff812f56e4>] run_timer_softirq+0x44/0x90 kernel/time/timer.c:1803
    [<ffffffff848000e6>] __do_softirq+0xe6/0x2ea kernel/softirq.c:571
    [<ffffffff81246db0>] invoke_softirq kernel/softirq.c:445 [inline]
    [<ffffffff81246db0>] __irq_exit_rcu kernel/softirq.c:650 [inline]
    [<ffffffff81246db0>] irq_exit_rcu+0xc0/0x110 kernel/softirq.c:662
    [<ffffffff84574f02>] sysvec_apic_timer_interrupt+0xa2/0xd0 arch/x86/kernel/apic/apic.c:1106
    [<ffffffff84600c8b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
    [<ffffffff8458a070>] native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
    [<ffffffff8458a070>] arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
    [<ffffffff8458a070>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
    [<ffffffff8458a070>] acpi_idle_do_entry+0xc0/0xd0 drivers/acpi/processor_idle.c:554



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
