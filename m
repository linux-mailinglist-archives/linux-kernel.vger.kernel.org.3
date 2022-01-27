Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5528B49DA94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiA0GYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiA0GYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:24:40 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C438AC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:24:39 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id q22so2771355ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FPyFOJQ/Z7y7Hdeunmwke8LDQSzSAtnoPvjaEs3s3g=;
        b=SAlY15kbQof2xArreSQ/Q00J9hDhnxjChlasOUBtepZsIEFz+by4ajd7BbmiLwDvhF
         MttP20bOLlNbumoKq4QYBQ9Ar81nhj8cOYJAF0KsSzn4Nrke4wsDIJKfqff84YYU2vGJ
         +o5ZYdGco//SmDQ4N00gmEf+dcVVB5220pfBr5LwZWb2SHyTNLT//USuBfRWStx1kKQg
         hgqPSgm4I/hjVHEbJezdBMjz/2p+mc2PWcuutgVFkLljf9yZ4Fnb0rsagPxziGKAySLf
         /pWHzK0bm/06dEG7pfRTYKMbT7AKyiwC7n+09fHMQ/md2Hr2bRKqXjVP2WjoGm+x77mQ
         PLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FPyFOJQ/Z7y7Hdeunmwke8LDQSzSAtnoPvjaEs3s3g=;
        b=FT3bzZKlA1iMm0hv2oLvj38fi9GaLZIL6GV1+mOzUY50h1QN9BS1/gSOxoj5yn3J1w
         Nkotc3xrV3gXR3fV8ySaV8z4Hjj9rhP0m1cp0tFRGaWQn2lzbpEsJjQJ0i/AGooO63SZ
         Z2qpxFYuZ4xR6oNvTFHGpq/k70l6PQec8zrYJnDvhOaud6cWeg5PUWB7edOFkOk/S/dY
         oy27iSgi9NzajtOq1+xlR1lEAhKiB0AdGrH+MPG/oQQkpvM6+Q6LX9aQoFxUTQ4r821t
         tw7BV2cvizurhaQiCDsGXJX2DMFGSPyr2YfvnqHS4bWMIsGwfuCCjkdiFTsTErXWEtB7
         izHQ==
X-Gm-Message-State: AOAM532ClsTCQDreOOouTRZeHbvVXefc43SsAr8zjMRuW51zrOcaPM7a
        w8t62QkY278m0hxtJpLldImK3qF+7n3TTZ9ZTPfm8g==
X-Google-Smtp-Source: ABdhPJxtuAhp5GhBGc8YqWgPcat670O3fk+75ZPofm9X/QqXYwmLnF0oKdsyozPEIxpaegVC/kCuBK4+Rlhywd2w0d0=
X-Received: by 2002:a05:651c:230e:: with SMTP id bi14mr1885358ljb.242.1643264678050;
 Wed, 26 Jan 2022 22:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-7-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-7-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 11:54:26 +0530
Message-ID: <CAFA6WYNWHtBKU67yWddFVSKt+a3SxNdzu82NUtwcG0y5v-sTLw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] optee: add driver private tee_context
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 21:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds a driver private tee_context by moving the tee_context in struct
> optee_notif to struct optee. This tee_context is used when doing
> internal calls to secure world to deliver notification and later also
> when sharing driver private memory with secure world.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          |  1 +
>  drivers/tee/optee/ffa_abi.c       | 61 ++++++++++++++++++-------------
>  drivers/tee/optee/optee_private.h |  5 ++-
>  drivers/tee/optee/smc_abi.c       | 40 ++++++--------------
>  4 files changed, 51 insertions(+), 56 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 2a369e346b85..f4bccb5f0e93 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -161,6 +161,7 @@ void optee_remove_common(struct optee *optee)
>         optee_unregister_devices();
>
>         optee_notif_uninit(optee);
> +       teedev_close_context(optee->ctx);
>         /*
>          * The two devices have to be unregistered before we can free the
>          * other resources.
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index d71880ede6d6..954e88866968 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -765,7 +765,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  {
>         const struct ffa_dev_ops *ffa_ops;
>         unsigned int rpc_arg_count;
> +       struct tee_shm_pool *pool;
>         struct tee_device *teedev;
> +       struct tee_context *ctx;
>         struct optee *optee;
>         int rc;
>
> @@ -785,12 +787,12 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (!optee)
>                 return -ENOMEM;
>
> -       optee->pool = optee_ffa_shm_pool_alloc_pages();
> -       if (IS_ERR(optee->pool)) {
> -               rc = PTR_ERR(optee->pool);
> -               optee->pool = NULL;
> -               goto err;
> +       pool = optee_ffa_shm_pool_alloc_pages();
> +       if (IS_ERR(pool)) {
> +               rc = PTR_ERR(pool);
> +               goto err_free_optee;
>         }
> +       optee->pool = pool;
>
>         optee->ops = &optee_ffa_ops;
>         optee->ffa.ffa_dev = ffa_dev;
> @@ -801,7 +803,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>                                   optee);
>         if (IS_ERR(teedev)) {
>                 rc = PTR_ERR(teedev);
> -               goto err;
> +               goto err_free_pool;
>         }
>         optee->teedev = teedev;
>
> @@ -809,50 +811,57 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>                                   optee);
>         if (IS_ERR(teedev)) {
>                 rc = PTR_ERR(teedev);
> -               goto err;
> +               goto err_unreg_teedev;
>         }
>         optee->supp_teedev = teedev;
>
>         rc = tee_device_register(optee->teedev);
>         if (rc)
> -               goto err;
> +               goto err_unreg_supp_teedev;
>
>         rc = tee_device_register(optee->supp_teedev);
>         if (rc)
> -               goto err;
> +               goto err_unreg_supp_teedev;
>
>         rc = rhashtable_init(&optee->ffa.global_ids, &shm_rhash_params);
>         if (rc)
> -               goto err;
> +               goto err_unreg_supp_teedev;
>         mutex_init(&optee->ffa.mutex);
>         mutex_init(&optee->call_queue.mutex);
>         INIT_LIST_HEAD(&optee->call_queue.waiters);
>         optee_supp_init(&optee->supp);
>         ffa_dev_set_drvdata(ffa_dev, optee);
> +       ctx = teedev_open(optee->teedev);
> +       if (IS_ERR(ctx))
> +               goto err_rhashtable_free;
> +       optee->ctx = ctx;
>         rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
> -       if (rc) {
> -               optee_ffa_remove(ffa_dev);
> -               return rc;
> -       }
> +       if (rc)
> +               goto err_close_ctx;
>
>         rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
> -       if (rc) {
> -               optee_ffa_remove(ffa_dev);
> -               return rc;
> -       }
> +       if (rc)
> +               goto err_unregister_devices;
>
>         pr_info("initialized driver\n");
>         return 0;
> -err:
> -       /*
> -        * tee_device_unregister() is safe to call even if the
> -        * devices hasn't been registered with
> -        * tee_device_register() yet.
> -        */
> +
> +err_unregister_devices:
> +       optee_unregister_devices();
> +       optee_notif_uninit(optee);
> +err_close_ctx:
> +       teedev_close_context(ctx);
> +err_rhashtable_free:
> +       rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
> +       optee_supp_uninit(&optee->supp);
> +       mutex_destroy(&optee->call_queue.mutex);
> +err_unreg_supp_teedev:
>         tee_device_unregister(optee->supp_teedev);
> +err_unreg_teedev:
>         tee_device_unregister(optee->teedev);
> -       if (optee->pool)
> -               tee_shm_pool_free(optee->pool);
> +err_free_pool:
> +       tee_shm_pool_free(pool);
> +err_free_optee:
>         kfree(optee);
>         return rc;
>  }
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index df2450921464..df3a483bbf46 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -53,7 +53,6 @@ struct optee_call_queue {
>
>  struct optee_notif {
>         u_int max_key;
> -       struct tee_context *ctx;
>         /* Serializes access to the elements below in this struct */
>         spinlock_t lock;
>         struct list_head db;
> @@ -134,9 +133,10 @@ struct optee_ops {
>  /**
>   * struct optee - main service struct
>   * @supp_teedev:       supplicant device
> + * @teedev:            client device
>   * @ops:               internal callbacks for different ways to reach secure
>   *                     world
> - * @teedev:            client device
> + * @ctx:               driver internal TEE context
>   * @smc:               specific to SMC ABI
>   * @ffa:               specific to FF-A ABI
>   * @call_queue:                queue of threads waiting to call @invoke_fn
> @@ -152,6 +152,7 @@ struct optee {
>         struct tee_device *supp_teedev;
>         struct tee_device *teedev;
>         const struct optee_ops *ops;
> +       struct tee_context *ctx;
>         union {
>                 struct optee_smc smc;
>                 struct optee_ffa ffa;
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 66d5d1b56b95..b1082a34cda2 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -952,57 +952,34 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
>  {
>         struct optee *optee = dev_id;
>
> -       optee_smc_do_bottom_half(optee->notif.ctx);
> +       optee_smc_do_bottom_half(optee->ctx);
>
>         return IRQ_HANDLED;
>  }
>
>  static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
>  {
> -       struct tee_context *ctx;
>         int rc;
>
> -       ctx = teedev_open(optee->teedev);
> -       if (IS_ERR(ctx))
> -               return PTR_ERR(ctx);
> -
> -       optee->notif.ctx = ctx;
>         rc = request_threaded_irq(irq, notif_irq_handler,
>                                   notif_irq_thread_fn,
>                                   0, "optee_notification", optee);
>         if (rc)
> -               goto err_close_ctx;
> +               return rc;
>
>         optee->smc.notif_irq = irq;
>
>         return 0;
> -
> -err_close_ctx:
> -       teedev_close_context(optee->notif.ctx);
> -       optee->notif.ctx = NULL;
> -
> -       return rc;
>  }
>
>  static void optee_smc_notif_uninit_irq(struct optee *optee)
>  {
> -       if (optee->notif.ctx) {
> -               optee_smc_stop_async_notif(optee->notif.ctx);
> +       if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
> +               optee_smc_stop_async_notif(optee->ctx);
>                 if (optee->smc.notif_irq) {
>                         free_irq(optee->smc.notif_irq, optee);
>                         irq_dispose_mapping(optee->smc.notif_irq);
>                 }
> -
> -               /*
> -                * The thread normally working with optee->notif.ctx was
> -                * stopped with free_irq() above.
> -                *
> -                * Note we're not using teedev_close_context() or
> -                * tee_client_close_context() since we have already called
> -                * tee_device_put() while initializing to avoid a circular
> -                * reference counting.
> -                */
> -               teedev_close_context(optee->notif.ctx);
>         }
>  }
>
> @@ -1307,6 +1284,7 @@ static int optee_probe(struct platform_device *pdev)
>         struct optee *optee = NULL;
>         void *memremaped_shm = NULL;
>         struct tee_device *teedev;
> +       struct tee_context *ctx;
>         u32 max_notif_value;
>         u32 sec_caps;
>         int rc;
> @@ -1387,9 +1365,13 @@ static int optee_probe(struct platform_device *pdev)
>         optee->pool = pool;
>
>         platform_set_drvdata(pdev, optee);
> +       ctx = teedev_open(optee->teedev);
> +       if (IS_ERR(ctx))
> +               goto err_supp_uninit;
> +       optee->ctx = ctx;
>         rc = optee_notif_init(optee, max_notif_value);
>         if (rc)
> -               goto err_supp_uninit;
> +               goto err_close_ctx;
>
>         if (sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
>                 unsigned int irq;
> @@ -1437,6 +1419,8 @@ static int optee_probe(struct platform_device *pdev)
>         optee_unregister_devices();
>  err_notif_uninit:
>         optee_notif_uninit(optee);
> +err_close_ctx:
> +       teedev_close_context(ctx);
>  err_supp_uninit:
>         optee_supp_uninit(&optee->supp);
>         mutex_destroy(&optee->call_queue.mutex);
> --
> 2.31.1
>
