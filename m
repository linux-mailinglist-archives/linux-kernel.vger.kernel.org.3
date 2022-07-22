Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6D57E260
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiGVNdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:33:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B799DC8D;
        Fri, 22 Jul 2022 06:33:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so5207935wmi.1;
        Fri, 22 Jul 2022 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x+Rn/D/yF9ZUx24lUEiA0+gX6X67o4TLvlhy9jszTuU=;
        b=CsVBl9aE1pFRS1o2BEHEdLb3f/FDSMEYzzxDz0GdB7YMo5O9QRx/r1kbjth4zWzGwf
         u0ev64VLZUWAvMLzoJ7+8WqeMILtN3GcMP6EqGStIJMcfCXjONG6S6ssn/buF4Z6ZRUW
         HGB1C+c+2mlGGGvHd70XHM2U1cX4ACmPMshJHgvbrZ4dBm8SMSQTgX6c13Eg/ANrA839
         efW8nXHrBKEun17h0JF/9OS/F0aDIX3p6ttkGl+HlxoD+fxM6WTew2ulyGb3xjpubQOS
         2S+Mn6ifM4TgGFU3+y9yHFiwUCNrF7hV04ekKTpa2F14WeOct9QCPFCI+6H+LsHOOAd+
         ysCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+Rn/D/yF9ZUx24lUEiA0+gX6X67o4TLvlhy9jszTuU=;
        b=HOTj20Ww4xm8oxp/EBlfdaiZDyhinKgJZooP+8xmoTi72GRIpvTq0I8fRf/dtLztrF
         aXJwvallo+LvoMwTFyseS5BFF1KiamAGGQpbflGwH6aFqm1rMZCG5EO4nYwuj2Bte/6A
         Q+l+evXFEb5j1YMQ9qD2YmbSNGlJRphavHP7CGm0wChAXJQsR/NDdLjffU56JJrOvE+y
         81Uf8MOUgClAMIgGGpOuAVkpUPberThx8q6rYRIGpE16fsm2J2R1V2JMkRtalVXeSnZy
         Ua/QHyRTgOIg9nd9H3rk8TKs27T0TvFM2VmJIno/HSZ+0y4jlLIhDtZBpQ0tQKE3G8OJ
         1v+w==
X-Gm-Message-State: AJIora/vXiv/hDekH2NCEQotjqtOSoM7Gonu6M+iA2RsBj5B0m0SbP0E
        iqLVNIykS2HBASJVmtONorg=
X-Google-Smtp-Source: AGRyM1um8Ujr8HwmgfrYMYvS28yvzg4fW2bxal/LDen0ynI8jWWBGMhvIk1krvP0Feczy+rq0wXBPw==
X-Received: by 2002:a05:600c:3510:b0:3a3:34e7:cfc8 with SMTP id h16-20020a05600c351000b003a334e7cfc8mr5994881wmq.164.1658496828992;
        Fri, 22 Jul 2022 06:33:48 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c4603000000b003a2d87aea57sm8919041wma.10.2022.07.22.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:33:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [syzbot] INFO: task hung in __input_unregister_device (4)
Date:   Fri, 22 Jul 2022 15:33:37 +0200
Message-ID: <5843755.lOV4Wx5bFT@opensuse>
In-Reply-To: <00000000000088a03905e2d435c2@google.com>
References: <00000000000088a03905e2d435c2@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4756117.31r3eYUQgx"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4756117.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On sabato 2 luglio 2022 17:32:22 CEST syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    90557fa89d3e dt-bindings: usb: atmel: Add Microchip 
LAN966..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/
usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=16892484080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=33f1eaa5b20a699
> dashboard link: https://syzkaller.appspot.com/bug?
extid=deb6abc36aad4008f407
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU 
Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?
x=155cc25c080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f64834080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the 
commit:
> Reported-by: syzbot+deb6abc36aad4008f407@syzkaller.appspotmail.com
> 
> INFO: task kworker/0:2:71 blocked for more than 143 seconds.
>       Not tainted 5.19.0-rc4-syzkaller-00099-g90557fa89d3e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:2     state:D stack:23752 pid:   71 ppid:     2 flags:
0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5146 [inline]
>  __schedule+0x93f/0x2630 kernel/sched/core.c:6458
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6530
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
>  input_disconnect_device drivers/input/input.c:784 [inline]
>  __input_unregister_device+0x24/0x470 drivers/input/input.c:2234
>  input_unregister_device+0xb4/0xf0 drivers/input/input.c:2429
>  iforce_usb_disconnect+0x5e/0xf0 drivers/input/joystick/iforce/iforce-
usb.c:261
>  usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
>  device_remove drivers/base/dd.c:545 [inline]
>  device_remove+0x11f/0x170 drivers/base/dd.c:537
>  __device_release_driver drivers/base/dd.c:1222 [inline]
>  device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1248
>  bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
>  device_del+0x4f3/0xc80 drivers/base/core.c:3604
>  usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
>  usb_disconnect.cold+0x278/0x6ec drivers/usb/core/hub.c:2228
>  hub_port_connect drivers/usb/core/hub.c:5190 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5490 [inline]
>  port_event drivers/usb/core/hub.c:5646 [inline]
>  hub_event+0x1e83/0x4690 drivers/usb/core/hub.c:5728
>  process_one_work+0x996/0x1610 kernel/workqueue.c:2289
>  process_scheduled_works kernel/workqueue.c:2352 [inline]
>  worker_thread+0x854/0x1080 kernel/workqueue.c:2438
>  kthread+0x2ef/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/26:
>  #0: ffffffff87a94700 (rcu_read_lock){....}-{1:2}, at: 
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
> 6 locks held by kworker/0:2/71:
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
set_work_data kernel/workqueue.c:636 [inline]
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
>  #0: ffff888109b13538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: 
process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
>  #1: ffffc90001057da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: 
process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
>  #2: ffff88810f267190 (&dev->mutex){....}-{3:3}, at: device_lock include/
linux/device.h:835 [inline]
>  #2: ffff88810f267190 (&dev->mutex){....}-{3:3}, at: 
hub_event+0x1c1/0x4690 drivers/usb/core/hub.c:5674
>  #3: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: device_lock include/
linux/device.h:835 [inline]
>  #3: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: 
usb_disconnect.cold+0x43/0x6ec drivers/usb/core/hub.c:2219
>  #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: device_lock include/
linux/device.h:835 [inline]
>  #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: __device_driver_lock 
drivers/base/dd.c:1054 [inline]
>  #4: ffff88811d2cb118 (&dev->mutex){....}-{3:3}, at: 
device_release_driver_internal+0xa0/0x700 drivers/base/dd.c:1245
>  #5: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: 
input_disconnect_device drivers/input/input.c:784 [inline]
>  #5: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: 
__input_unregister_device+0x24/0x470 drivers/input/input.c:2234
> 2 locks held by acpid/1166:
>  #0: ffff88811d2cf110 (&evdev->mutex){+.+.}-{3:3}, at: evdev_close_device 
drivers/input/evdev.c:411 [inline]
>  #0: ffff88811d2cf110 (&evdev->mutex){+.+.}-{3:3}, at: 
evdev_release+0x299/0x410 drivers/input/evdev.c:456
>  #1: ffff88811d2cc2c0 (&dev->mutex#2){+.+.}-{3:3}, at: 
input_close_device+0x42/0x1f0 drivers/input/input.c:726
> 2 locks held by getty/1240:
>  #0: ffff8881109fc098 (&tty->ldisc_sem){++++}-{0:0}, at: 
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
>  #1: ffffc900000432e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: 
n_tty_read+0xe50/0x13c0 drivers/tty/n_tty.c:2124
> 3 locks held by udevd/1293:
>  #0: ffff8881106e6488 (&of->mutex){+.+.}-{3:3}, at: kernfs_file_read_iter 
fs/kernfs/file.c:197 [inline]
>  #0: ffff8881106e6488 (&of->mutex){+.+.}-{3:3}, at: 
kernfs_fop_read_iter+0x189/0x6e0 fs/kernfs/file.c:236
>  #1: ffff888108bf0a00 (kn->active#40){++++}-{0:0}, at: 
kernfs_file_read_iter fs/kernfs/file.c:198 [inline]
>  #1: ffff888108bf0a00 (kn->active#40){++++}-{0:0}, at: 
kernfs_fop_read_iter+0x1ac/0x6e0 fs/kernfs/file.c:236
>  #2: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: 
device_lock_interruptible include/linux/device.h:840 [inline]
>  #2: ffff88811d2ca190 (&dev->mutex){....}-{3:3}, at: 
read_descriptors+0x3c/0x2c0 drivers/usb/core/sysfs.c:873
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 26 Comm: khungtaskd Not tainted 5.19.0-rc4-syzkaller-00099-
g90557fa89d3e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 06/29/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
>  nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
>  watchdog+0xc1d/0xf50 kernel/hung_task.c:369
>  kthread+0x2ef/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/
include/asm/irqflags.h:51 [inline]
> NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/
include/asm/irqflags.h:89 [inline]
> NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/
processor_idle.c:111 [inline]
> NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c9/0x240 
drivers/acpi/processor_idle.c:554
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
"syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/
msgid/syzkaller-bugs/00000000000088a03905e2d435c2%40google.com.
> 
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 
usb-testing

--nextPart4756117.31r3eYUQgx
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="diff"

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index ea58805c480f..2717e35c79a3 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -258,6 +258,9 @@ static void iforce_usb_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	clear_bit(IFORCE_XMIT_RUNNING, iforce_usb->iforce.xmit_flags);
+	wake_up(&iforce_usb->iforce.wait);
+
 	input_unregister_device(iforce_usb->iforce.dev);
 
 	usb_free_urb(iforce_usb->irq);

--nextPart4756117.31r3eYUQgx--



