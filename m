Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810CF5996B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbiHSIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbiHSIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:04:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FFAAFAF7;
        Fri, 19 Aug 2022 01:04:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c20so2810368qtw.8;
        Fri, 19 Aug 2022 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DrIuhQC3A2KwNz8Y4pmGRMavw3daxroamLa7iGInSPo=;
        b=qemQOo3qpWDc2/2U7dGJHtXXsHuE4vz7AuPeQfUUvkLNP+cb5eZH8eLYofOCE6GrRb
         TXHUM3SECDu5n23DVF6Hu+jSD7gSiT3MbQux/Q8agrymMerZKzJszU3xYGcnXGKlTuAU
         EavGkBN++GB8EeR6nOcWRf08t97yWHVP/ghV2mF0tC7T5kp4Lr26LWVIbQgk5J5vQJFd
         MRZ1SXY/OZM7cR6nuvGKBr2u7N3N3LK9OVfJgt3bjdJNIZJBSSLyo7MjWV75swGbOjAZ
         RkasGALuN109E6sM6kKPtLEmXDY95iGC4SXjA20rQM+F9ZhDg197d+GaMBE6VHSV3qwj
         ZvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DrIuhQC3A2KwNz8Y4pmGRMavw3daxroamLa7iGInSPo=;
        b=FPClr9hyP1vTTY+6hn32he3qkF1EEih5u4i8/ablfj5YJTM0ppjHJYvXYtxtwW9e29
         Mx1pNOenYkje6VSxb3jLJ9crQqXofqB8L7Q3Pk1ORy1StNsWfyyD2Zzu09hNd2RKMAeo
         qZeodQfw1YdpKKv8/bzjp1TV4UxWs2oCA/a5JSHFCgUL3LrkpsQxn6K6ZIiAACVUMC4N
         GC3VeZoo4G5cuXxSjU94AgHPDXs3svyCQACxne4K0mRA00dUKylCfnsp7yx2w1NhnVgB
         0oo3MxSEpsVzmNeBbTPmvvqnvrx2O0CydKI3aFf8C1CyIApHw+iNmnnUV0KuGFY6ToZs
         LyMA==
X-Gm-Message-State: ACgBeo02uBwdgbAxoUmdd0lpehLcjsFOJFGxwMiHD4BMomlMRLleiwue
        mo87UVLAH8RjhehfAJsv574huK95a5HZZe8uqnYGg1vYJbNlwA==
X-Google-Smtp-Source: AA6agR4oZhYX4KSfciJKft2mP+sOvh8rGLPCbHVIyZxmSLVOjFIDt4hwnrGDyZdK0jFcY+en5PoRT+FtrpXmsUUWF/g=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr5399126qtx.195.1660896271093; Fri, 19
 Aug 2022 01:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:03:55 +0300
Message-ID: <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 1:30 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> If an IIO driver uses callbacks from another IIO driver and calls
> iio_channel_start_all_cb() from one of its buffer setup ops, then
> lockdep complains due to the lock nesting, as in the below example with
> lmp91000.  Since the locks are being taken on different IIO devices,
> there is no actual deadlock, so add lock nesting annotation to silence
> the spurious warning.
>
>  ============================================
>  WARNING: possible recursive locking detected
>  6.0.0-rc1+ #10 Not tainted
>  --------------------------------------------
>  python3/23 is trying to acquire lock:
>  0000000064c944c0 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers+0x62/0x180
>
>  but task is already holding lock:
>  00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&indio_dev->mlock);
>    lock(&indio_dev->mlock);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  5 locks held by python3/23:
>   #0: 00000000636b5420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x67/0x100
>   #1: 0000000064c19280 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x13a/0x270
>   #2: 0000000064c3d9e0 (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x149/0x270
>   #3: 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
>   #4: 0000000064c945c8 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers+0x4f/0x180
>
>  stack backtrace:
>  CPU: 0 PID: 23 Comm: python3 Not tainted 6.0.0-rc1+ #10
>  Call Trace:
>   dump_stack+0x1a/0x1c
>   __lock_acquire.cold+0x407/0x42d
>   lock_acquire+0x1ed/0x310
>   __mutex_lock+0x72/0xde0
>   mutex_lock_nested+0x1d/0x20
>   iio_update_buffers+0x62/0x180
>   iio_channel_start_all_cb+0x1c/0x20 [industrialio_buffer_cb]
>   lmp91000_buffer_postenable+0x1b/0x20 [lmp91000]
>   __iio_update_buffers+0x50b/0xd80
>   enable_store+0x81/0x100
>   dev_attr_store+0xf/0x20
>   sysfs_kf_write+0x4c/0x70
>   kernfs_fop_write_iter+0x179/0x270
>   new_sync_write+0x99/0x120
>   vfs_write+0x2c1/0x470
>   ksys_write+0x67/0x100
>   sys_write+0x10/0x20

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-mesages

On top of that, Fixes tag?

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>


--
With Best Regards,
Andy Shevchenko
