Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB54354AC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355952AbiFNIxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356020AbiFNIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2113414D32
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655196786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vkrp4CO/9UvJmo5cc1dfyzRQg7YqDey+RKfYJG/5u98=;
        b=hCA1H4J1s2PRIO6VVPDP+i3H1U1YrD+b7GOkc4pjgNsMFf8VAxyuCe7NjpDI6y/IrFjKFj
        kIxVnEQg/lTg5OQJtCXN7dFhxzZS93F3BNoJ+ol1DIOcKi1ybm5Ksf4e1GCuotO87XjwIf
        e3uYXKYlYKpw0st3NrNmyw8Au050p2I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-ZrUP8yxSOKiS7v3SLAcZGA-1; Tue, 14 Jun 2022 04:53:04 -0400
X-MC-Unique: ZrUP8yxSOKiS7v3SLAcZGA-1
Received: by mail-lj1-f199.google.com with SMTP id z10-20020a05651c022a00b00255a0bf5ccfso1101246ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkrp4CO/9UvJmo5cc1dfyzRQg7YqDey+RKfYJG/5u98=;
        b=n5e2gg35q3yYBWATNhjtAbkj+ZHMFxAgaG6hsVc6+sOjI26XxDeFwlGTzDV9hC+PE8
         k4IVq5G/LBFwxa5+J/+Du1zmLusaowJUP5e2ofj3K6pksKQj1SXzk20yV8L6+pRyHSmX
         cNrl9cR92T/kIs7bTq01AvU88S0JaMpry2l4oD8fvFj/v8jvHrDxGx+9DN1OFe3erunP
         ORIBgi+3WnsJWGnQ8EsYUZUk8vXFP/Flsx7M1jxtV4bYVWIWqddZKaQgz8zBpB9s3gWL
         TmXUDdRNbv31T8N15JQFPxnO7K9wxKkqC8LaNUlHpipFb73QmUJRV2QJpfN10djt/v0H
         7xpQ==
X-Gm-Message-State: AJIora/Vbwu7PPD3qqNL1mAdqi+wiIG6DEeOsn9osOkpk17TBkWOtWR1
        0ptgOUM6G4ZlQ4Ft9Zx2LT7rknLkGecbFzZEwvrixk834IVT5/ciIHEGcQMKZ6bkZjRU68KOG2e
        DUF33spLI73Qf3a7g1hhLDyiH42FFgOaErkEsGstZ
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id p16-20020a056512313000b00479385fe2acmr2413173lfd.575.1655196782574;
        Tue, 14 Jun 2022 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v4GFXDXwQ+WJme+RK3CludKMXoAn8uXS7Pj1PsZfLPvN+oKO5SkXXzy51Kwnu4qCl2+DwKCFXMBbWyhCpH97A=
X-Received: by 2002:a05:6512:3130:b0:479:385f:e2ac with SMTP id
 p16-20020a056512313000b00479385fe2acmr2413138lfd.575.1655196781990; Tue, 14
 Jun 2022 01:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008ea7ac05e09b46a6@google.com> <CACT4Y+Z8fdbQ9Kq1gHSha2q7a6RrOajbPKrSVCFyLNS95XkVgQ@mail.gmail.com>
 <CACGkMEuK=bYcpNfjcsh64K0_-nYX2btw9Mi9uWsCYcfENBcHuA@mail.gmail.com> <CACT4Y+YF+Jo5kgjqBouw3NnKUq0pxF3geJhbACpN3QgtHSj8kQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YF+Jo5kgjqBouw3NnKUq0pxF3geJhbACpN3QgtHSj8kQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Jun 2022 16:52:50 +0800
Message-ID: <CACGkMEtaxSBzY+it6N8UmNssDxiCGJ48YrVQEPQSpEisedkwFg@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: INFO: task hung in hwrng_register
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6da75abeed821109137b@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, llvm@lists.linux.dev, mpm@selenic.com,
        syzkaller-bugs@googlegroups.com,
        Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 4:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 14 Jun 2022 at 10:07, Jason Wang <jasowang@redhat.com> wrote:
> > > On Sat, 4 Jun 2022 at 10:46, syzbot
> > > <syzbot+6da75abeed821109137b@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of git:/..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14409a93f00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=99f457384a4fea79
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6da75abeed821109137b
> > > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+6da75abeed821109137b@syzkaller.appspotmail.com
> > >
> > > +Jason, Laurent
> > >
> > > This started appearing at the same time as 'task hung in
> > > add_early_randomness" bug reports:
> > > https://syzkaller.appspot.com/bug?id=256d08cc261a3c38832064a33df4c928b3cd0ef0
> > > https://syzkaller.appspot.com/bug?id=be1d99e09e499aed3939dc678718371984104e5c
> > > https://syzkaller.appspot.com/bug?id=1cd11df5d984c694e3e7fc9fe271389b2340bed0
> > > https://syzkaller.appspot.com/bug?id=35496bafab4c3f81f0b0d6d72c69787300629740
> > >
> > > Is this also fixed by "virtio-rng: make device ready before making
> > > request" patch?
> >
> > Yes, I think so.
> >
> > Thanks
>
> Let's tell the bot so that it reports such bugs in future:
>
> #syz fix: virtio-rng: make device ready before making request

Ok.

Thanks

>
>
> > > > INFO: task swapper/0:1 blocked for more than 143 seconds.
> > > >       Not tainted 5.18.0-syzkaller-13760-g032dcf09e2bf #0
> > > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > task:swapper/0       state:D stack:21080 pid:    1 ppid:     0 flags:0x00004000
> > > > Call Trace:
> > > >  <TASK>
> > > >  context_switch kernel/sched/core.c:5116 [inline]
> > > >  __schedule+0x957/0xec0 kernel/sched/core.c:6428
> > > >  schedule+0xeb/0x1b0 kernel/sched/core.c:6500
> > > >  schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6559
> > > >  __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
> > > >  __mutex_lock kernel/locking/mutex.c:747 [inline]
> > > >  mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
> > > >  add_early_randomness drivers/char/hw_random/core.c:69 [inline]
> > > >  hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
> > > >  virtrng_scan+0x3e/0x90 drivers/char/hw_random/virtio-rng.c:205
> > > >  virtio_dev_probe+0xa03/0xba0 drivers/virtio/virtio.c:313
> > > >  call_driver_probe+0x96/0x250
> > > >  really_probe+0x220/0x940 drivers/base/dd.c:634
> > > >  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:764
> > > >  driver_probe_device+0x50/0x240 drivers/base/dd.c:794
> > > >  __driver_attach+0x35f/0x5a0 drivers/base/dd.c:1163
> > > >  bus_for_each_dev+0x188/0x1f0 drivers/base/bus.c:301
> > > >  bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
> > > >  bus_add_driver+0x32f/0x600 drivers/base/bus.c:618
> > > >  driver_register+0x2e9/0x3e0 drivers/base/driver.c:240
> > > >  do_one_initcall+0xbd/0x2b0 init/main.c:1295
> > > >  do_initcall_level+0x168/0x218 init/main.c:1368
> > > >  do_initcalls+0x4b/0x8c init/main.c:1384
> > > >  kernel_init_freeable+0x43a/0x5c3 init/main.c:1610
> > > >  kernel_init+0x19/0x2b0 init/main.c:1499
> > > >  ret_from_fork+0x1f/0x30
> > > >  </TASK>
> > > >
> > > > Showing all locks held in the system:
> > > > 2 locks held by swapper/0/1:
> > > >  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
> > > >  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
> > > >  #0: ffff8881468d4170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x353/0x5a0 drivers/base/dd.c:1162
> > > >  #1: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness drivers/char/hw_random/core.c:69 [inline]
> > > >  #1: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_register+0x3bf/0x680 drivers/char/hw_random/core.c:599
> > > > 2 locks held by pr/ttyS0/16:
> > > > 1 lock held by khungtaskd/29:
> > > >  #0: ffffffff8cb1eee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
> > > > 2 locks held by kworker/u4:4/56:
> > > >  #0: ffff888011c69138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
> > > >  #1: ffffc900013e7d00 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
> > > > 1 lock held by hwrng/755:
> > > >  #0: ffffffff8d24ccc8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0xec/0x470 drivers/char/hw_random/core.c:503
> > > >
> > > > =============================================
> > > >
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008ea7ac05e09b46a6%40google.com.
> > >
> >
>

