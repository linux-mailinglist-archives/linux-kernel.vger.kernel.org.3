Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826BF545F49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiFJIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348030AbiFJIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:34:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C665633882
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:32:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 20so2210393lfz.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2qHVMNC89KEaLQP1Bq1nS5jM3wTACD+XBwIshrDDSQ=;
        b=BvVP3lc9hnk1I8CIpUJ2qJ4hb1MUw41/qIR60K7rrVF+HN4ODSc+Bm4Ngaj6vFbJ56
         dNcHm4mSJ5VGEkbeA6KTO+w58K9eeerzJRqYz2GkVjic6kjXSgjL3lueS8dXqHhO2Wqi
         oCVGhEe9LvC3+WOnGeW/Dw8Xt2U9Y9q302WkWJVowbUPCgQjplnRpO+qc3dJsIi5oDp6
         YLUb+VSTu1QAMeJN207DEkP+pBsnYY3lD53mgrud6JoR9KZgBVT/PeRCpbJvWs8nGuoS
         UFymtsRtooXaPojZOGRivZu/jYW/CdNowaA1aujgnqRx7YNXFL6DNLmPvTkZobgZPDqR
         Qxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2qHVMNC89KEaLQP1Bq1nS5jM3wTACD+XBwIshrDDSQ=;
        b=l+g1LeHzmFgv7iFfdLqcP0YwazGkn9i4ansD0V+aFAR35M9xFocq2ZTRJTK055hFiI
         F1vqzY63Vd9/PgQ05xhxSTPXCBAcKs0WDrWBTyIFU+E0SqDpb1p5nwNCEg/nDPa4i78y
         XR4bPQLMoXCm674vynQdmweq59Z/L/mce7Uc2YkaGHYw2Q3FJfVsg6NYjRb/aaLUpdWr
         kPQaAK2HdV/vNFRzL0bRlHQmMznlvPJZ/1Q/5WvSWZMLu24bxX5WM46IHeCzlhKU/b2e
         NmS0bsZZ/T41Kma3rIALdsy9hLg0HcgPyh1YhAdB44CXsKiwjDuqWUlRpGeFh+S6+0oE
         OVzw==
X-Gm-Message-State: AOAM5306+Nij8RkmptXVb+dnERr5QQRoXyveW321Rz0VSe2RUTJH37yJ
        luJ0HSzyLGA1rxsp02B2njM+1JOwtlQB3rH7+J5dDg==
X-Google-Smtp-Source: ABdhPJzGk//f2+F0+hXVmgNhhWSCUO6L6VGLAKcnWBch93b+wg00S/YcSE90O/LXFcg5ZUUN68Yr7vRuPEqYnnvusN4=
X-Received: by 2002:ac2:4f11:0:b0:479:3554:79d with SMTP id
 k17-20020ac24f11000000b004793554079dmr17843777lfr.417.1654849947716; Fri, 10
 Jun 2022 01:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039214105e0d5c4f4@google.com>
In-Reply-To: <00000000000039214105e0d5c4f4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Jun 2022 10:32:15 +0200
Message-ID: <CACT4Y+ZiGzx7EkdOwEmpNCcOFq-N537QbW=-wAA=NAGGxTo-VQ@mail.gmail.com>
Subject: Re: [syzbot] usb-testing boot error: INFO: task hung in add_early_randomness
To:     syzbot <syzbot+695f4009c37860232f35@syzkaller.appspotmail.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com,
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

On Tue, 7 Jun 2022 at 08:33, syzbot
<syzbot+695f4009c37860232f35@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f2906aa86338 Linux 5.19-rc1
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1042a03bf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bafeb86189666d4
> dashboard link: https://syzkaller.appspot.com/bug?extid=695f4009c37860232f35
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+695f4009c37860232f35@syzkaller.appspotmail.com

Assume this is also fixed by:

#syz fix: virtio-rng: make device ready before making request

> INFO: task swapper/0:1 blocked for more than 143 seconds.
>       Not tainted 5.19.0-rc1-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:swapper/0       state:D stack:23984 pid:    1 ppid:     0 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5116 [inline]
>  __schedule+0x93c/0x25e0 kernel/sched/core.c:6428
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
>  kernel_init_freeable+0x6ac/0x735 init/main.c:1610
>  kernel_init+0x1a/0x1d0 init/main.c:1499
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by swapper/0/1:
>  #0: ffff88810cb9e170 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>  #0: ffff88810cb9e170 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1054 [inline]
>  #0: ffff88810cb9e170 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x222/0x550 drivers/base/dd.c:1162
>  #1: ffffffff87edbbe8 (reading_mutex){+.+.}-{3:3}, at: add_early_randomness+0x1a/0x170 drivers/char/hw_random/core.c:69
> 2 locks held by pr/ttyS0/14:
> 1 lock held by khungtaskd/27:
>  #0: ffffffff87a94840 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6491
> 1 lock held by hwrng/150:
>  #0: ffffffff87edbbe8 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x141/0x370 drivers/char/hw_random/core.c:503
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000039214105e0d5c4f4%40google.com.
