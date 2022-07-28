Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9CA584370
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiG1Pna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiG1PnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:43:25 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F06A4A9;
        Thu, 28 Jul 2022 08:43:22 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id x10so1424406plb.3;
        Thu, 28 Jul 2022 08:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9J9OIkJMZnysMReJqY0eBDSfGAATl0A6Xx7Ap4m7F8k=;
        b=eit6dye5UVfLjH2AhkiBYZ1QuhsRRvNhx//RGJqzsTqPn023VZmDf+O9etHxNrJelk
         3Efye8jN4sYlNLZHNSrlOsT2Mo+vLjgqaX3uZfA64+ft7RV5hZe8OB/1/5Ypq6OTJgTk
         QeZ4P9/hP2iZ+Dm3qAaPfvRcoc+E+uvojc9NaC/irr+bwNbVLKUcRzbcb+50UieOXnT+
         DRU6bpyVnK7Q0GY9wWWh+gRqHWqPUVWagtvjdsfTON2/4BsoFJqXoDHY4QaETHJO9ifa
         vz4GWmWLqy9iOafc6d4T8IPYmQ7Kmco1ClG3IdYAzH85JOs+5JOD8laeCYwJ39OkKlQ0
         EPrQ==
X-Gm-Message-State: AJIora85cqIA7AoT0Lw+BVBRst2VX8wtcVnSVg8ftcPDIL1sIxk7xTjT
        SISxlSrS+OKLAWCjDzlWFF4=
X-Google-Smtp-Source: AGRyM1u24LGPgyQLBUhgENLyOoBvMALle4uJlRPhTLWgWhlPPfmDqRB16Mor7m8gcDzDmrm1tfpMCA==
X-Received: by 2002:a17:902:da88:b0:16d:b75e:16d8 with SMTP id j8-20020a170902da8800b0016db75e16d8mr7113840plx.157.1659023002111;
        Thu, 28 Jul 2022 08:43:22 -0700 (PDT)
Received: from karthik-strix-linux.karthek.com ([61.1.131.162])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b0015e9f45c1f4sm1483344plx.186.2022.07.28.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:43:21 -0700 (PDT)
Date:   Thu, 28 Jul 2022 21:13:17 +0530
From:   Karthik Alapati <mail@karthek.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hidraw: fix memory leak in hidraw_release()
Message-ID: <YuKuldGx55BB+hrd@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the buffered reports before deleting the list entry.

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

Link: https://syzkaller.appspot.com/bug?id=19a04b43c75ed1092021010419b5e560a8172c4f
Reported-by: syzbot+f59100a0428e6ded9443@syzkaller.appspotmail.com
Signed-off-by: Karthik Alapati <mail@karthek.com>
---
 drivers/hid/hidraw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 681614a8302a..197b1e7bf029 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -350,6 +350,8 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	down_write(&minors_rwsem);
 
 	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
+	for (int i = list->tail; i < list->head; i++)
+		kfree(list->buffer[i].value);
 	list_del(&list->node);
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	kfree(list);
-- 
2.36.1

