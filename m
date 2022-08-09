Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF81958D4D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiHIHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbiHIHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:41:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2553A6317
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:41:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b4so10936463pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MfgEYzR6eEnuVK+7RNKv2ttuzrC3TDpbmb3GSdRA6M8=;
        b=X/6BfiU3QWlgUqT1EKwJATkxHuobK1Tqhu360EX2D1Tef9MpiXYZ284ZCwlnJxQtg0
         vLRxbRTFaeeIxrimt8/0R+YtqHjiKzWXZ8F+5YjTBrO6OhJgZNRTIfA64JqZ8rrGn85w
         t507hHLvw4CuEv9m9DZlN0b7249hRbU20+k9C4Ir4TQfX6ev2WvAQ4YUBmdqzXn3EZPd
         pgcQhOdif7EcodqjIqIaSgJojJK1xXl40FJxm3yrtb3sA+1mifUd46BRouQgAAVuUDKo
         95U5RRnJlnEX1rSISE1YuqgqJSH4ArULHKYHVqST9MsisKjJHS5cP6LYXnD3LD6py7VD
         a3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MfgEYzR6eEnuVK+7RNKv2ttuzrC3TDpbmb3GSdRA6M8=;
        b=GsVnBES70E3B4at3gXA8aU81rr5/c4OqE41Wm3jW7mJcgTiOw9SUSZuhrvFHFdwrk6
         Is/OAxqO02vyfOPFzTfBKOv30weF3w/MASqkFfpvDoX+KlAdosHkc8PhUmdYkbHX/Uf8
         8WWj3b6UdN9yk+DXwqAuZjvyzSP1yh5J+HxhIwWn1E8KfqDihWMsO9vqEiYdXtaHZxlc
         cXqrAZeUEc4X/x2jlccMWydnuQgL/7C0kKWCFxh5FM2OXe5lI5s343nrT+4nmqwr8vuT
         M/GBDTmBn3ZtFadFUJKqmKbooWR51Q/RVkthIYTjb7qcrizOrtbj2wCcjCYLUAVA4CNC
         TrGQ==
X-Gm-Message-State: ACgBeo31d/Rw5/oQQjEYx10m8K/K8bC96IY7l1DwIcOPkKVNepx4u9l7
        mEuGVI2/KsYrMjLZb35NUbGryB14KszQFg2tuOpnHF9KcI0=
X-Google-Smtp-Source: AA6agR6fQfrYNvhiE6wS50tpRL9AtzhHNVwooT5ys+z/RBT9lifHiQH1EBl//4dVZr2hQd7kSq1OaHaUyG6geneHD2Q=
X-Received: by 2002:a17:90b:38c9:b0:1f7:28bb:aa16 with SMTP id
 nn9-20020a17090b38c900b001f728bbaa16mr14819899pjb.201.1660030907248; Tue, 09
 Aug 2022 00:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220725080240.106619-1-jsd@semihalf.com>
In-Reply-To: <20220725080240.106619-1-jsd@semihalf.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Tue, 9 Aug 2022 09:41:36 +0200
Message-ID: <CAOtMz3P94+Mmwx7oD=rEC2V0Cbd+NGAczfSdKNuxu8w+4FU1sA@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: Introduce cooldown timer to AMDPSP driver
To:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     mika.westerberg@linux.intel.com, wsa@kernel.org,
        rrangel@chromium.org, mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarko, Andriy,

Could you please take a look?

Best Regards,
Jan


pon., 25 lip 2022 o 10:03 Jan Dabros <jsd@semihalf.com> napisa=C5=82(a):
>
> In order to optimize performance, limit amount of back and forth
> transactions between x86 and PSP. This is done by introduction of
> cooldown period - that is window in which x86 isn't releasing the bus
> immediately after each I2C transaction.
>
> In order to protect PSP from being starved while waiting for
> arbitration, after a programmed time bus is automatically released by a
> deferred function.
>
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> ---
>  drivers/i2c/busses/i2c-designware-amdpsp.c | 68 +++++++++++++++++-----
>  1 file changed, 53 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-amdpsp.c b/drivers/i2c/bus=
ses/i2c-designware-amdpsp.c
> index b624356c945f..2e1bb5ae72c3 100644
> --- a/drivers/i2c/busses/i2c-designware-amdpsp.c
> +++ b/drivers/i2c/busses/i2c-designware-amdpsp.c
> @@ -6,6 +6,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/psp-sev.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>
>  #include <asm/msr.h>
>
> @@ -15,6 +16,8 @@
>  #define PSP_MBOX_OFFSET                0x10570
>  #define PSP_CMD_TIMEOUT_US     (500 * USEC_PER_MSEC)
>
> +#define PSP_I2C_COOLDOWN_TIME_MS 100
> +
>  #define PSP_I2C_REQ_BUS_CMD            0x64
>  #define PSP_I2C_REQ_RETRY_CNT          400
>  #define PSP_I2C_REQ_RETRY_DELAY_US     (25 * USEC_PER_MSEC)
> @@ -240,6 +243,42 @@ static int psp_send_i2c_req(enum psp_i2c_req_type i2=
c_req_type)
>         return ret;
>  }
>
> +static void release_bus_now(void)
> +{
> +       int status;
> +
> +       if (!psp_i2c_sem_acquired)
> +               return;
> +
> +       status =3D psp_send_i2c_req(PSP_I2C_REQ_RELEASE);
> +       if (status)
> +               return;
> +
> +       dev_dbg(psp_i2c_dev, "PSP semaphore held for %ums\n",
> +               jiffies_to_msecs(jiffies - psp_i2c_sem_acquired));
> +
> +       psp_i2c_sem_acquired =3D 0;
> +}
> +
> +static void psp_release_i2c_bus_deferred(struct work_struct *work)
> +{
> +
> +       mutex_lock(&psp_i2c_access_mutex);
> +
> +       /*
> +        * If there is any pending transaction, cannot release the bus he=
re.
> +        * psp_release_i2c_bus will take care of this later.
> +        */
> +       if (psp_i2c_access_count)
> +               goto cleanup;
> +
> +       release_bus_now();
> +
> +cleanup:
> +       mutex_unlock(&psp_i2c_access_mutex);
> +}
> +static DECLARE_DELAYED_WORK(release_queue, psp_release_i2c_bus_deferred)=
;
> +
>  static int psp_acquire_i2c_bus(void)
>  {
>         int status;
> @@ -250,21 +289,23 @@ static int psp_acquire_i2c_bus(void)
>         if (psp_i2c_mbox_fail)
>                 goto cleanup;
>
> +       psp_i2c_access_count++;
> +
>         /*
> -        * Simply increment usage counter and return if PSP semaphore was
> -        * already taken by kernel.
> +        * No need to request bus arbitration once we are inside cooldown
> +        * period.
>          */
> -       if (psp_i2c_access_count) {
> -               psp_i2c_access_count++;
> +       if (psp_i2c_sem_acquired)
>                 goto cleanup;
> -       }
>
>         status =3D psp_send_i2c_req(PSP_I2C_REQ_ACQUIRE);
>         if (status)
>                 goto cleanup;
>
>         psp_i2c_sem_acquired =3D jiffies;
> -       psp_i2c_access_count++;
> +
> +       schedule_delayed_work(&release_queue,
> +                             msecs_to_jiffies(PSP_I2C_COOLDOWN_TIME_MS))=
;
>
>         /*
>          * In case of errors with PSP arbitrator psp_i2c_mbox_fail variab=
le is
> @@ -279,8 +320,6 @@ static int psp_acquire_i2c_bus(void)
>
>  static void psp_release_i2c_bus(void)
>  {
> -       int status;
> -
>         mutex_lock(&psp_i2c_access_mutex);
>
>         /* Return early if mailbox was malfunctional */
> @@ -295,13 +334,12 @@ static void psp_release_i2c_bus(void)
>         if (psp_i2c_access_count)
>                 goto cleanup;
>
> -       /* Send a release command to PSP */
> -       status =3D psp_send_i2c_req(PSP_I2C_REQ_RELEASE);
> -       if (status)
> -               goto cleanup;
> -
> -       dev_dbg(psp_i2c_dev, "PSP semaphore held for %ums\n",
> -               jiffies_to_msecs(jiffies - psp_i2c_sem_acquired));
> +       /*
> +        * Send a release command to PSP if the cooldown timeout elapsed =
but x86 still
> +        * owns the ctrlr.
> +        */
> +       if (!delayed_work_pending(&release_queue))
> +               release_bus_now();
>
>  cleanup:
>         mutex_unlock(&psp_i2c_access_mutex);
> --
> 2.37.1.359.gd136c6c3e2-goog
>
