Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF705A0CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiHYJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiHYJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:31:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0483874DEF;
        Thu, 25 Aug 2022 02:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6070B827DC;
        Thu, 25 Aug 2022 09:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56736C433D6;
        Thu, 25 Aug 2022 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419865;
        bh=plUt9uMkO0KE9Ug185awFHVbd+XLpzhEW8EZU+WPwdI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gqHYU93y5S1V9afV+Fb301SVrj38bUxYiBnCmzv80PNF/rfxbw6VEKcGtNIm6lgzA
         FzV4RrxBUQ5WH5wzreUErNhfU2Toi01OiX0D7VMwZYSSN7PS6ObxqJs2JjSq1+LuuW
         zlIz+TanoZKGu+0tjaf6FsyJtYMiW9Fe5Z+viJOvYJ0PzKLqkxdC1rTp0muh/B5riu
         1f7OpaFdgWDCWbUp9HbTJnQdAqRUD0YmZn2d+SLJA/YvZn/FaV5JtgU2Y8JCwJ24gh
         /RtJrd1XSnbssBUgFJ44+qocx71uf7a3F9UV6BJ9zN/vT5hJ8Ju1Qwo6LXclOwCaae
         pZGyaRtMKGF6Q==
Date:   Thu, 25 Aug 2022 11:31:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Karthik Alapati <mail@karthek.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix memory leak in hidraw_release()
In-Reply-To: <YuKuldGx55BB+hrd@karthik-strix-linux.karthek.com>
Message-ID: <nycvar.YFH.7.76.2208251130510.19850@cbobk.fhfr.pm>
References: <YuKuldGx55BB+hrd@karthik-strix-linux.karthek.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022, Karthik Alapati wrote:

> Free the buffered reports before deleting the list entry.
> 
> BUG: memory leak
> unreferenced object 0xffff88810e72f180 (size 32):
>   comm "softirq", pid 0, jiffies 4294945143 (age 16.080s)
>   hex dump (first 32 bytes):
>     64 f3 c6 6a d1 88 07 04 00 00 00 00 00 00 00 00  d..j............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ac6c3>] kmemdup+0x23/0x50 mm/util.c:128
>     [<ffffffff8357c1d2>] kmemdup include/linux/fortify-string.h:440 [inline]
>     [<ffffffff8357c1d2>] hidraw_report_event+0xa2/0x150 drivers/hid/hidraw.c:521
>     [<ffffffff8356ddad>] hid_report_raw_event+0x27d/0x740 drivers/hid/hid-core.c:1992
>     [<ffffffff8356e41e>] hid_input_report+0x1ae/0x270 drivers/hid/hid-core.c:2065
>     [<ffffffff835f0d3f>] hid_irq_in+0x1ff/0x250 drivers/hid/usbhid/hid-core.c:284
>     [<ffffffff82d3c7f9>] __usb_hcd_giveback_urb+0xf9/0x230 drivers/usb/core/hcd.c:1670
>     [<ffffffff82d3cc26>] usb_hcd_giveback_urb+0x1b6/0x1d0 drivers/usb/core/hcd.c:1747
>     [<ffffffff82ef1e14>] dummy_timer+0x8e4/0x14c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
>     [<ffffffff812f50a8>] call_timer_fn+0x38/0x200 kernel/time/timer.c:1474
>     [<ffffffff812f5586>] expire_timers kernel/time/timer.c:1519 [inline]
>     [<ffffffff812f5586>] __run_timers.part.0+0x316/0x430 kernel/time/timer.c:1790
>     [<ffffffff812f56e4>] __run_timers kernel/time/timer.c:1768 [inline]
>     [<ffffffff812f56e4>] run_timer_softirq+0x44/0x90 kernel/time/timer.c:1803
>     [<ffffffff848000e6>] __do_softirq+0xe6/0x2ea kernel/softirq.c:571
>     [<ffffffff81246db0>] invoke_softirq kernel/softirq.c:445 [inline]
>     [<ffffffff81246db0>] __irq_exit_rcu kernel/softirq.c:650 [inline]
>     [<ffffffff81246db0>] irq_exit_rcu+0xc0/0x110 kernel/softirq.c:662
>     [<ffffffff84574f02>] sysvec_apic_timer_interrupt+0xa2/0xd0 arch/x86/kernel/apic/apic.c:1106
>     [<ffffffff84600c8b>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:649
>     [<ffffffff8458a070>] native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
>     [<ffffffff8458a070>] arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
>     [<ffffffff8458a070>] acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
>     [<ffffffff8458a070>] acpi_idle_do_entry+0xc0/0xd0 drivers/acpi/processor_idle.c:554
> 
> Link: https://syzkaller.appspot.com/bug?id=19a04b43c75ed1092021010419b5e560a8172c4f
> Reported-by: syzbot+f59100a0428e6ded9443@syzkaller.appspotmail.com
> Signed-off-by: Karthik Alapati <mail@karthek.com>
> ---
>  drivers/hid/hidraw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 681614a8302a..197b1e7bf029 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -350,6 +350,8 @@ static int hidraw_release(struct inode * inode, struct file * file)
>  	down_write(&minors_rwsem);
>  
>  	spin_lock_irqsave(&hidraw_table[minor]->list_lock, flags);
> +	for (int i = list->tail; i < list->head; i++)
> +		kfree(list->buffer[i].value);
>  	list_del(&list->node);
>  	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
>  	kfree(list);

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

