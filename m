Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EDF545F56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbiFJIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347810AbiFJIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:36:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE9F140D7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:33:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c4so9678395lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XeN9qJ3gHue/ygYZG2b6Md0zUPiK+iGP6VK/ep2YAk=;
        b=igt5Pg8VUzddVKy92alpOC3+TUscdhJ22ogFfnlYFYDH1QE+OUw5ouljQd59n/uSki
         jpsC4ETDA+OXwY0l8zXHRgQqzE6MhKMYKSn1VazCv4EqDW5/QHsfqPhNzVDLx3Ye29c1
         8WQOLt4kof+UU6J9tvMAnIuSag8fj09ldrpUnPoqwo7z3lDMZMox7MRmskDlp4kQkJfH
         yHEeYEOyVU3ChGxfQqdEA6sb7WMq5ZvrFe5B1q1uIeHWHAd7/X7DYgRZrguZ/zGMobzS
         vGEaN01Y/sxNCmVVV5zdSo+IjttwZrV6fCeOMqXZgHe4HDh+/EQtp5/a77wYZWs25IQq
         wSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XeN9qJ3gHue/ygYZG2b6Md0zUPiK+iGP6VK/ep2YAk=;
        b=YN/CHoYQ+wIuhH9HuEO/hST7Qk0DiZf9UIs37degY9q4D95kwLHYAnqLAlrVQSXGB9
         RXcnlXKNMuMrBMpSKfFLin56pFeKGRsQren36eSVRz6vFTxZZ/0FopLQqN5PStMEOpP7
         zJLB4CAQwv7e7S6NkEGCfs47WjuLy2x2CdFBuGzLW6ymy++3XiPE3oMM5QuUFu/0jOl0
         Th9UoJyTx6hS7mQRUJLUmJiRPRvg8DbI5f/a9IwnIPs1uZVG7HQXVTl6rXYvVJ0MO8Sf
         rA/8IRkNYfYyAU81rKLQlWI0b+/BZSIBlq6eJxJAPAExjA44S8+P0rPxUDdypO2kdufX
         554g==
X-Gm-Message-State: AOAM531879DmJsXztizdDEw4+wfdJhScbHPLKxgymWiVFmiCQCPjvFra
        pk2D+b5q/JpkZWapNzio5Wye2Ealw/p4XfQZ9sqxXw==
X-Google-Smtp-Source: ABdhPJwG6SRfLIKvz0d20slA7OFlpy9G1vi0fRLRZHPMtSyaC4HHeg6tzRw7Sic/HNxDJwtXRsd1slXsc8/0myAJ31U=
X-Received: by 2002:a05:6512:3c94:b0:477:ba25:de54 with SMTP id
 h20-20020a0565123c9400b00477ba25de54mr26785569lfv.137.1654850029182; Fri, 10
 Jun 2022 01:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008488e005e0721af2@google.com>
In-Reply-To: <0000000000008488e005e0721af2@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 10:33:37 +0200
Message-ID: <CACT4Y+a_RYa0qTi1jNJv4_cu51zmzqgNT=WgQco3nxhTVzDRWw@mail.gmail.com>
Subject: Re: [syzbot] linux-next boot error: INFO: task hung in
 add_early_randomness (2)
To:     syzbot <syzbot+4bff2788f64e121fefcf@syzkaller.appspotmail.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 at 09:39, syzbot
<syzbot+4bff2788f64e121fefcf@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2e776ccffa84 Add linux-next specific files for 20220602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14226a35f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5266d49aa5c20076
> dashboard link: https://syzkaller.appspot.com/bug?extid=4bff2788f64e121fefcf
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4bff2788f64e121fefcf@syzkaller.appspotmail.com

Assume this is also fixed by:

#syz fix: virtio-rng: make device ready before making request

> INFO: task swapper/0:1 blocked for more than 143 seconds.
>       Not tainted 5.18.0-next-20220602-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:swapper/0       state:D stack:23832 pid:    1 ppid:     0 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5116 [inline]
>  __schedule+0xa06/0x4b40 kernel/sched/core.c:6428
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6500
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
>  add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
>  hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
>  virtrng_scan+0x37/0x90 drivers/char/hw_random/virtio-rng.c:205
>  virtio_dev_probe+0x639/0x910 drivers/virtio/virtio.c:313
>  call_driver_probe drivers/base/dd.c:562 [inline]
>  really_probe+0x23e/0xb90 drivers/base/dd.c:641
>  __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:774
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:804
>  __driver_attach+0x22d/0x550 drivers/base/dd.c:1173
>  bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
>  bus_add_driver+0x422/0x640 drivers/base/bus.c:618
>  bus_add_driver+0x422/0x640 drivers/base/bus.c:618
>  driver_register+0x220/0x3a0 drivers/base/driver.c:240
>  do_one_initcall+0x103/0x660 init/main.c:1300
>  do_initcall_level init/main.c:1375 [inline]
>  do_initcalls init/main.c:1391 [inline]
>  do_basic_setup init/main.c:1410 [inline]
>  kernel_init_freeable+0x6b1/0x73a init/main.c:1617
>  kernel_init+0x1a/0x1d0 init/main.c:1506
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by swapper/0/1:
>  #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1064 [inline]
>  #0: ffff88801b377170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x222/0x550 drivers/base/dd.c:1172
>  #1: ffffffff8c841068 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
> 2 locks held by kworker/u4:0/8:
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
>  #0: ffff888010c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
>  #1: ffffc900000d7da8 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
> 2 locks held by pr/ttyS0/16:
> 1 lock held by khungtaskd/28:
>  #0: ffffffff8bd86aa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
> 1 lock held by hwrng/755:
>  #0: ffffffff8c841068 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
>
> =============================================
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008488e005e0721af2%40google.com.
