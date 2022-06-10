Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB29A545F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbiFJIjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348150AbiFJIif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:38:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE83D480
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:36:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a15so41716426lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eicu7148pm/4x777cEThw3z5cRYIwfGOQ4/TvMVAHCg=;
        b=VEsJD1EpHTtwZpiGwJunS27R9TD1UKBge1fJ8t2WtSv+quG309wZsJ/jAFZt90U9zJ
         6jtvaPJI4Qt8txBzyMnqoXZP6aZkuo6pLQ9KtQW36Kqv8XQ5YgDc0aFr0R3EW7hcM38w
         AXhCXfa5Bpp5Zw67Hud1ZT3XmWM0vc7cxghtMWUMM1RTQKfHX05sEMEVjvYzT9ooUAgz
         GqU6L+dbRvjJ9LftnDpakXo7yAMHtMbQQFfWvlrFU9H0RTY2gLzerztouBO5ihHfS2XO
         U+3R48tAdCFBp7ax1cB8r5f/Bl3dLlcv5SBKlAdl3x/tN32w6ncwdW99tZzZklZf3pkl
         9yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eicu7148pm/4x777cEThw3z5cRYIwfGOQ4/TvMVAHCg=;
        b=8CNJglJFCUAv49MZMST3mkT2LaMb3tNwuJECSPF8Xkz4J61aR3rAhPfJU2fczJB/IO
         hgTKGovJXVIlSOS8Xu1UmuMZ1qlz8vOUsE5STZpAmG2lm0g8AeVa91zeOntiZnTrUsKx
         Tu0ry3r2Xxw+6FGhGM962SdGchWdhcJT0963psXGfFgPca+CAZNYJED7ZbgZ9ccsyBNx
         3BSuPYmSLF/OsHxSvRp3FoXB5o82zkArp+wt5Pzmkaurw6nWGfvVsYshtidxj106HYCK
         dE+5cqnIJt7hkK/mk+yCtt9PVRJ0r1IWjFCYs2AcKrOQh3kNCuV8AjXI3Tq/yS9crT1W
         o4Lg==
X-Gm-Message-State: AOAM531GyZc8q8UDkXva4oVh8cS1lQxz3e6tUcJJ+zo6sdhXPnJCVzsO
        PzmfGVaHopPyAbQHrFFHpNBLTAzdNFgoFUD2KXP/Dw==
X-Google-Smtp-Source: ABdhPJyWO6tS8NeUxy/ypAEjfKWBR37YKuyIXcaEa64lgPxJzpyUGzNL2NS8qZc2GGHL2XozDYTxPfu30GvaJz5JpFs=
X-Received: by 2002:a05:6512:48f:b0:479:1f1a:544d with SMTP id
 v15-20020a056512048f00b004791f1a544dmr21465928lfq.206.1654850209333; Fri, 10
 Jun 2022 01:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008ea7ac05e09b46a6@google.com>
In-Reply-To: <0000000000008ea7ac05e09b46a6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 10:36:37 +0200
Message-ID: <CACT4Y+Z8fdbQ9Kq1gHSha2q7a6RrOajbPKrSVCFyLNS95XkVgQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: INFO: task hung in hwrng_register
To:     syzbot <syzbot+6da75abeed821109137b@syzkaller.appspotmail.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        llvm@lists.linux.dev, mpm@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
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

On Sat, 4 Jun 2022 at 10:46, syzbot
<syzbot+6da75abeed821109137b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14409a93f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=99f457384a4fea79
> dashboard link: https://syzkaller.appspot.com/bug?extid=6da75abeed821109137b
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6da75abeed821109137b@syzkaller.appspotmail.com

+Jason, Laurent

This started appearing at the same time as 'task hung in
add_early_randomness" bug reports:
https://syzkaller.appspot.com/bug?id=256d08cc261a3c38832064a33df4c928b3cd0ef0
https://syzkaller.appspot.com/bug?id=be1d99e09e499aed3939dc678718371984104e5c
https://syzkaller.appspot.com/bug?id=1cd11df5d984c694e3e7fc9fe271389b2340bed0
https://syzkaller.appspot.com/bug?id=35496bafab4c3f81f0b0d6d72c69787300629740

Is this also fixed by "virtio-rng: make device ready before making
request" patch?




> INFO: task swapper/0:1 blocked for more than 143 seconds.
>       Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:swapper/0       state:D stack:21080 pid:    1 ppid:     0 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5116 [inline]
>  __schedule+0x957/0xec0 kernel/sched/core.c:6428
>  schedule+0xeb/0x1b0 kernel/sched/core.c:6500
>  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
>  __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
>  __mutex_lock kernel/locking/mutex.c:747 [inline]
>  mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
>  add_early_randomness drivers/char/hw_random/core.c:69 [inline]
>  hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
>  virtrng_scan+0x3e/0x90 drivers/char/hw_random/virtio-rng.c:205
>  virtio_dev_probe+0xa03/0xba0 drivers/virtio/virtio.c:313
>  call_driver_probe+0x96/0x250
>  really_probe+0x220/0x940 drivers/base/dd.c:634
>  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:764
>  driver_probe_device+0x50/0x240 drivers/base/dd.c:794
>  __driver_attach+0x35f/0x5a0 drivers/base/dd.c:1163
>  bus_for_each_dev+0x188/0x1f0 drivers/base/bus.c:301
>  bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
>  bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
>  driver_register+0x2e9/0x3e0 drivers/base/driver.c:240
>  do_one_initcall+0xbd/0x2b0 init/main.c:1295
>  do_initcall_level+0x168/0x218 init/main.c:1368
>  do_initcalls+0x4b/0x8c init/main.c:1384
>  kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
>  kernel_init+0x19/0x2b0 init/main.c:1499
>  ret_from_fork+0x1f/0x30
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by swapper/0/1:
>  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
>  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x353/0x5a0 drivers/base/dd.c:1162
>  #1: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness drivers/char/hw_random/core.c:69 [inline]
>  #1: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
> 2 locks held by pr/ttyS0/16:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8cb1eee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
> 2 locks held by kworker/u4:4/56:
>  #0: ffff888011c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
>  #1: ffffc900013e7d00 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
> 1 lock held by hwrng/755:
>  #0: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0xec/0x470 drivers/char/hw_random/core.c:503
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008ea7ac05e09b46a6%40google.com.
