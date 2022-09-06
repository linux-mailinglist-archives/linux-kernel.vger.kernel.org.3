Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE695AEE4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiIFPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiIFPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:02:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EEACA03
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:17:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m3so829455pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+j4ngLEidLDoWH4lYh7XJRQiFBg9/g7VTw1Vm7SR9A0=;
        b=d5PNZpnzvwHvosRxcq2fbaInTI96TYp6qDLB8koxhOOb3+VzjXTHYiwi2XiFS3UaGr
         84pykmGBFGuO4AgF1bDfiouDNjYsZp9nOs15leDj/cNf57eK0iiDyH5J6sRpMbpQ0Kfg
         Nj8fTn9Ot9Xye+h9sJbBg9SJlyMAp+XmNeLsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+j4ngLEidLDoWH4lYh7XJRQiFBg9/g7VTw1Vm7SR9A0=;
        b=rVd4NpSIFPOQeX4qUqSTM6RSM/3RsA84UIlK863/mKFeRKyQN7zvHDlEaxDcJXQG6a
         hxBOD46oQO7pTgGhP8X+cX7r9gu0j2hNJzvmmVTFnjfOESDj5ugUWyPjD6EgjgV46UMT
         dZH+8eYCHacyQ5Pvvq0LkM0C5CNX1Xrr0R7TF1BWny+sUnEFBd+bFK713vyjhHtZwxt4
         MJu5irHQb/A7BQL8yojAHmv4nejuagvFj8i50uCurB5iskL+5zFWYQOiw3Gvdf/mVqk0
         Bco0CiMZ/8DCcTONkaHdMOq0Ts/iLDe6C0+4XLLMR5vLwHgb0jPd3ued7N16Krz+3GJZ
         Flcg==
X-Gm-Message-State: ACgBeo0rLKt2LgThk66pBtpLfhd3fs0vUPD2Mui8emx1yGs16juErcJX
        ElfQZ2Ji9AhxHsIGBW/lQrv3V6SXWQqMifEmWUwA/JDzvLciIQ==
X-Google-Smtp-Source: AA6agR5gL7141ocVuqNdid444nlmHYa18Y6TXeuKossEc3lPZWLLtU93+J6ZJf9v1A4lWTPbR26XifHmENooJe0h5o0=
X-Received: by 2002:a17:902:f7d2:b0:176:ca6b:eadb with SMTP id
 h18-20020a170902f7d200b00176ca6beadbmr4928847plw.173.1662473746499; Tue, 06
 Sep 2022 07:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172024.1613208-1-svenva@chromium.org> <20220831172024.1613208-2-svenva@chromium.org>
In-Reply-To: <20220831172024.1613208-2-svenva@chromium.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Tue, 6 Sep 2022 10:15:35 -0400
Message-ID: <CAG-rBihyZhanjiuqGGHMo-zB9YJ=FCaD+C-7R63FnVgKDsM+Mg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwrng: core: fix potential suspend/resume race condition
To:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alex Levin <levinale@google.com>, Rajat Jain <rajatja@google.com>,
        Andrey Pronin <apronin@google.com>,
        Stephen Boyd <swboyd@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any feedback on this patch, good/bad, any suggestions?

Herbert, this patch should fix hw_random/core suspend/resume issues, without
having to freeze the kthread - which should avoid the freeze regression problems
that popped up.

See earlier kthread freeze attempt here:
https://lore.kernel.org/all/4a45b3e0-ed3a-61d3-bfc6-957c7ba631bb@maciej.szmigiero.name/T/#m2c37e2c176c4efc362116b57493749664b960f45

I was hoping you could take a look.

On Wed, Aug 31, 2022 at 1:20 PM Sven van Ashbrook <svenva@chromium.org> wrote:
>
> The hwrng fill function runs as a normal kthread. This thread
> doesn't get frozen by the PM, i.e. it will keep running during,
> or in, system suspend. It may call the client driver's
> data_present()/data_read() functions during, or in, suspend;
> which may generate errors or warnings. For example, if the
> client driver uses an i2c bus, the following warning may be
> intermittently generated:
>
>   i2c: Transfer while suspended
>
> Fix by converting the delay polled kthread into an ordered work
> queue running a single, self-rearming delayed_work. Make the
> workqueue WQ_FREEZABLE, so the PM will drain any work items
> before going into suspend. This prevents client drivers from
> being accessed during, or in, suspend.
>
> Tested on a Chromebook containing an cr50 tpm over i2c. The test
> consists of 31000 suspend/resume cycles. Occasional
> "i2c: Transfer while suspended" warnings are seen. After applying
> this patch, these warnings disappear.
>
> This patch also does not appear to cause any regressions on the
> ChromeOS test queues.
>
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
> ---
>
>  drivers/char/hw_random/core.c | 95 +++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 3675122c6cce..ee85ca97d215 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -17,7 +17,7 @@
>  #include <linux/hw_random.h>
>  #include <linux/random.h>
>  #include <linux/kernel.h>
> -#include <linux/kthread.h>
> +#include <linux/workqueue.h>
>  #include <linux/sched/signal.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
> @@ -28,14 +28,17 @@
>
>  #define RNG_MODULE_NAME                "hw_random"
>
> -static struct hwrng *current_rng;
>  /* the current rng has been explicitly chosen by user via sysfs */
>  static int cur_rng_set_by_user;
> -static struct task_struct *hwrng_fill;
> +static struct workqueue_struct *hwrng_wq;
> +static struct delayed_work hwrng_fill_dwork;
> +static size_t entropy_credit;
> +/* Protects rng_list, current_rng, is_hwrng_wq_running */
> +static DEFINE_MUTEX(rng_mutex);
>  /* list of registered rngs */
>  static LIST_HEAD(rng_list);
> -/* Protects rng_list and current_rng */
> -static DEFINE_MUTEX(rng_mutex);
> +static struct hwrng *current_rng;
> +static bool is_hwrng_wq_running;
>  /* Protects rng read functions, data_avail, rng_buffer and rng_fillbuf */
>  static DEFINE_MUTEX(reading_mutex);
>  static int data_avail;
> @@ -488,37 +491,29 @@ static int __init register_miscdev(void)
>         return misc_register(&rng_miscdev);
>  }
>
> -static int hwrng_fillfn(void *unused)
> +static void hwrng_fillfn(struct work_struct *unused)
>  {
> -       size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
> +       unsigned short quality;
>         unsigned long delay;
> +       struct hwrng *rng;
> +       size_t entropy; /* in 1/1024 of a bit */
>         long rc;
>
> -       while (!kthread_should_stop()) {
> -               unsigned short quality;
> -               struct hwrng *rng;
> -
> -               rng = get_current_rng();
> -               if (IS_ERR(rng) || !rng)
> -                       break;
> -               mutex_lock(&reading_mutex);
> -               rc = rng_get_data(rng, rng_fillbuf,
> -                                 rng_buffer_size(), 1);
> -               if (current_quality != rng->quality)
> -                       rng->quality = current_quality; /* obsolete */
> -               quality = rng->quality;
> -               mutex_unlock(&reading_mutex);
> -               put_rng(rng);
> -
> -               if (!quality)
> -                       break;
> +       rng = get_current_rng();
> +       if (IS_ERR(rng) || !rng)
> +               return;
> +       mutex_lock(&reading_mutex);
> +       rc = rng_get_data(rng, rng_fillbuf, rng_buffer_size(), 1);
> +       if (current_quality != rng->quality)
> +               rng->quality = current_quality; /* obsolete */
> +       quality = rng->quality;
> +       mutex_unlock(&reading_mutex);
> +       put_rng(rng);
>
> -               if (rc <= 0) {
> -                       pr_warn("hwrng: no data available\n");
> -                       msleep_interruptible(10000);
> -                       continue;
> -               }
> +       if (!quality)
> +               return;
>
> +       if (rc > 0) {
>                 /* If we cannot credit at least one bit of entropy,
>                  * keep track of the remainder for the next iteration
>                  */
> @@ -529,11 +524,11 @@ static int hwrng_fillfn(void *unused)
>                 /* Outside lock, sure, but y'know: randomness. */
>                 delay = add_hwgenerator_randomness((void *)rng_fillbuf, rc,
>                                                    entropy >> 10);
> -               if (delay > 0)
> -                       schedule_timeout_interruptible(delay);
> +       } else {
> +               pr_warn("hwrng: no data available\n");
> +               delay = 10 * HZ;
>         }
> -       hwrng_fill = NULL;
> -       return 0;
> +       mod_delayed_work(hwrng_wq, &hwrng_fill_dwork, delay);
>  }
>
>  static void hwrng_manage_rngd(struct hwrng *rng)
> @@ -541,14 +536,12 @@ static void hwrng_manage_rngd(struct hwrng *rng)
>         if (WARN_ON(!mutex_is_locked(&rng_mutex)))
>                 return;
>
> -       if (rng->quality == 0 && hwrng_fill)
> -               kthread_stop(hwrng_fill);
> -       if (rng->quality > 0 && !hwrng_fill) {
> -               hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
> -               if (IS_ERR(hwrng_fill)) {
> -                       pr_err("hwrng_fill thread creation failed\n");
> -                       hwrng_fill = NULL;
> -               }
> +       if (rng->quality == 0 && is_hwrng_wq_running) {
> +               cancel_delayed_work(&hwrng_fill_dwork);
> +               is_hwrng_wq_running = false;
> +       } else if (rng->quality > 0 && !is_hwrng_wq_running) {
> +               mod_delayed_work(hwrng_wq, &hwrng_fill_dwork, 0);
> +               is_hwrng_wq_running = true;
>         }
>  }
>
> @@ -631,8 +624,7 @@ void hwrng_unregister(struct hwrng *rng)
>         new_rng = get_current_rng_nolock();
>         if (list_empty(&rng_list)) {
>                 mutex_unlock(&rng_mutex);
> -               if (hwrng_fill)
> -                       kthread_stop(hwrng_fill);
> +               cancel_delayed_work_sync(&hwrng_fill_dwork);
>         } else
>                 mutex_unlock(&rng_mutex);
>
> @@ -703,17 +695,32 @@ static int __init hwrng_modinit(void)
>                 return -ENOMEM;
>         }
>
> +       /* ordered wq to mimic delay-polled kthread behaviour */
> +       hwrng_wq = alloc_ordered_workqueue("hwrng",
> +               WQ_FREEZABLE |  /* prevent work from running during suspend/resume */
> +               WQ_MEM_RECLAIM  /* client drivers may need memory reclaim */
> +       );
> +       if (!hwrng_wq) {
> +               kfree(rng_fillbuf);
> +               kfree(rng_buffer);
> +               return -ENOMEM;
> +       }
> +
>         ret = register_miscdev();
>         if (ret) {
> +               destroy_workqueue(hwrng_wq);
>                 kfree(rng_fillbuf);
>                 kfree(rng_buffer);
>         }
>
> +       INIT_DELAYED_WORK(&hwrng_fill_dwork, hwrng_fillfn);
> +
>         return ret;
>  }
>
>  static void __exit hwrng_modexit(void)
>  {
> +       destroy_workqueue(hwrng_wq);
>         mutex_lock(&rng_mutex);
>         BUG_ON(current_rng);
>         kfree(rng_buffer);
> --
> 2.37.2.672.g94769d06f0-goog
>
