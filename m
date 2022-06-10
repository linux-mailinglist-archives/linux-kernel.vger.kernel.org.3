Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF6545F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347975AbiFJIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347962AbiFJIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:35:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6B3BA4E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:33:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c2so22290392lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLGmNAZd8sPMU7EAXR3djCjc/O6z0WJk+OpyNiemYtE=;
        b=jnO1lG/jpb7oxXzGBOYEEhyCrzE0eifa/suaYfyT6Sh1Y2b+K7FG3y3XvjWm0RItF9
         Fmn1TEuaLFIeL4GM3fjmHcpQiHlIKJn9zeVDfFJBh+Vo2PglBtrQFDZey+6/EIy9XOqG
         fnm+yPqnPcBg22DnxLV/UWBqIYhlSFAg1voB1gOxGIphjPEN0cC25l1GVeqqtlcNjRmr
         yxdfige+2XSHHdkhOb87Fq1xnGgLePgbYlO2ckF9lk2+jXeWFFKc/ZTrmkDKo0S4uqed
         oPY3SXZGRRSls5IbfgVasBS1rWW9oT+6YEfZXq2RJydaNVUpRblzot6ZuN4DCJ9MlPXG
         vjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLGmNAZd8sPMU7EAXR3djCjc/O6z0WJk+OpyNiemYtE=;
        b=LQXAn6ydyyjh+iYDHhBcsOfgQkoA0esHdPXbOGc/cedxsJvtIcaVFb7tLX/KQ2HBz4
         vWxOYb3NgaYH5yaVAmCywZI3sTu1QMzfQzBFIqdZ9+mvUn6ifJNUPtyADTonmM5gEnFc
         peAX1xVPPiaFrj4LUTemgXrUflApWVU3Msvc87UrjptzML5imIrRMuWAsXRYz8VAqf7Y
         s54JrIgiIIWf1NggxTAYn+bIPODLn9ee+vf9HIU1XGtnpqq3Ffw64ca4GBqp7D9JVf/s
         Q9piaVven06An7SPHntfzTD0GYv1T53c0vhqkEL53+RTHlz1hekJhhWA6yvbutxJDwvk
         iRpw==
X-Gm-Message-State: AOAM531JrRwMRWVVL9CcVp/hxRMISCiLSaASIuUkb/Auae0qjkL+7mIV
        lac44w4CLYd+5PPcSuIMZRJ66Qln5f2cZy8OcZs/bQ==
X-Google-Smtp-Source: ABdhPJwcCW9RlbQvF3vA3O3HSZzWFJ+zkb/h3lAEI2ARwUYgAwN4+cm3UDHiF0u0u6DAD7S6MySfiQZKsmWotl/MkY4=
X-Received: by 2002:ac2:4a71:0:b0:47d:b71a:b1f6 with SMTP id
 q17-20020ac24a71000000b0047db71ab1f6mr436300lfp.598.1654849981164; Fri, 10
 Jun 2022 01:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d268b905e09b4915@google.com>
In-Reply-To: <000000000000d268b905e09b4915@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 10:32:49 +0200
Message-ID: <CACT4Y+Ymyh+YCc3hZY+E09=52RpRoUdReVZCKrv5sKFfog9sLQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: INFO: task hung in add_early_randomness
To:     syzbot <syzbot+760e6f85822d8b6bc5ae@syzkaller.appspotmail.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        mpm@selenic.com, syzkaller-bugs@googlegroups.com,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2022 at 10:47, syzbot
<syzbot+760e6f85822d8b6bc5ae@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1457b6dbf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
> dashboard link: https://syzkaller.appspot.com/bug?extid=760e6f85822d8b6bc5ae
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+760e6f85822d8b6bc5ae@syzkaller.appspotmail.com

Assume this is also fixed by:

#syz fix: virtio-rng: make device ready before making request

> INFO: task swapper/0:1 blocked for more than 143 seconds.
>       Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:swapper/0       state:D stack:22136 pid:    1 ppid:     0 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5116 [inline]
>  __schedule+0xa00/0x4b30 kernel/sched/core.c:6428
>  schedule+0xd2/0x1f0 kernel/sched/core.c:6500
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0xa70/0x1350 kernel/locking/mutex.c:747
>  add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
>  hwrng_register+0x399/0x510 drivers/char/hw_random/core.c:599
>  virtrng_scan+0x37/0x90 drivers/char/hw_random/virtio-rng.c:205
>  virtio_dev_probe+0x639/0x910 drivers/virtio/virtio.c:313
>  call_driver_probe drivers/base/dd.c:555 [inline]
>  really_probe+0x23e/0xb90 drivers/base/dd.c:634
>  __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:764
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:794
>  __driver_attach+0x22d/0x550 drivers/base/dd.c:1163
>  bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
>  bus_add_driver+0x422/0x640 drivers/base/bus.c:618
>  driver_register+0x220/0x3a0 drivers/base/driver.c:240
>  do_one_initcall+0x103/0x650 init/main.c:1295
>  do_initcall_level init/main.c:1368 [inline]
>  do_initcalls init/main.c:1384 [inline]
>  do_basic_setup init/main.c:1403 [inline]
>  kernel_init_freeable+0x6b1/0x73a init/main.c:1610
>  kernel_init+0x1a/0x1d0 init/main.c:1499
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by swapper/0/1:
>  #0: ffff8881460e2170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #0: ffff8881460e2170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
>  #0: ffff8881460e2170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x222/0x550 drivers/base/dd.c:1162
>  #1: ffffffff8c832d88 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
> 2 locks held by kworker/u4:0/8:
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
>  #0: ffff888011869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
>  #1: ffffc900000d7da8 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
> 2 locks held by pr/ttyS0/16:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8bd86be0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
> 1 lock held by hwrng/756:
>  #0: ffffffff8c832d88 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d268b905e09b4915%40google.com.
