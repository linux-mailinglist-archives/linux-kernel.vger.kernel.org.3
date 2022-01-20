Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734F4494C56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiATK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiATK5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:57:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57278C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:57:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y15so11823488lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUNTh7u2E9DfdgesQvQ1qd5bfrg5OU7bq+NJm3Ty0Mc=;
        b=i1S7X5WA9ePXDWmj6riFvdA8RfszJnhS72pd1abXzqIr2pvyv5EiNzLJxUE6w8/0xG
         UKCXeW4AzbME6NrR8uKAVNyjRO73zPGtNk5cZSrr+Hm+alI1uRcPkwKPfe5GPwzQgBL5
         BtvocI8qOznALR7YFNlFZRvMFwp/6I5vgQPwPRKSVT82XnSFtREjDd3SjOLMJgXOw6vt
         zHDGYZAqZhRQWvX5Qkf6K8D4HtJ5HDU3UagpUNQ6BSZ6Rc8CvVEKIBiUOsXiH9dTaOcQ
         MK3wDp23obHZgy5+qp4J4hk84ZDpH5wtT4sDQL4ufni36811T5Sy68m7129kylTcl7hA
         KPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUNTh7u2E9DfdgesQvQ1qd5bfrg5OU7bq+NJm3Ty0Mc=;
        b=r3YdwV0mhCjZZ9x36WD9KsAh9FgXbM3gLIDR6zn0KOcVJH1iD4K/GK6NihbaD0q0Jo
         aK9g4rtRopNnQnp33ZQWKTG1pP3v8Fe22fVFU/MqMzzS8GzScXhCYAlboZCGTM71lAkY
         q8h3EpD8YVFPrtLTAOg+hejtpfVPTIN8Kr65mcL0WWb1EKY/ARnkDW+dccGjwlCcgDhi
         3PYd372ukFY6/v4zss2Wob6JUsbllu3IaBFpUMd36uSox67va2kfj86Xmoqxo74pID4x
         8HDy87p9+PAVe7VA5Q0CKtJLTTF0UsdDfJShT2iZpNAynNjL+fiKKd8sKypWWwBHLIUv
         4itA==
X-Gm-Message-State: AOAM532i10sP7LQx0575WZo3Ew6Ga/pS5deBlO+UxQDbzbVwHcFt0rAT
        lzR7r3n6OoUqOsO2BT9w89lwyVWvF8eBl2vydiJIeBUmi4+rP1Hz
X-Google-Smtp-Source: ABdhPJzixS+6gQ+YfDfPkn6qPkq9XM8dZsL+3QjLOovFRhmEwbVM4FS9R4wVi3gTtHLOiI2vua/wUXN/pp1RKqLQqYc=
X-Received: by 2002:a2e:7f10:: with SMTP id a16mr28296759ljd.48.1642676268618;
 Thu, 20 Jan 2022 02:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-9-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-9-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Jan 2022 16:27:37 +0530
Message-ID: <CAFA6WYN5JgY67sdk0K8Az6+T5tsQo2wbZaiNX4oigRiKRPaA+A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] optee: add optee_pool_op_free_helper()
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

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds a common helper function to free a tee_shm allocated using the
> helper function optee_pool_op_alloc_helper().
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 10 ++++++++++
>  drivers/tee/optee/ffa_abi.c       |  4 +---
>  drivers/tee/optee/optee_private.h |  3 +++
>  drivers/tee/optee/smc_abi.c       |  7 +++----
>  4 files changed, 17 insertions(+), 7 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index f4bccb5f0e93..daf947e98d14 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -69,6 +69,16 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>         return rc;
>  }
>
> +void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> +                              int (*shm_unregister)(struct tee_context *ctx,
> +                                                    struct tee_shm *shm))
> +{
> +       if (shm_unregister)
> +               shm_unregister(shm->ctx, shm);
> +       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +       shm->kaddr = NULL;
> +}
> +
>  static void optee_bus_scan(struct work_struct *work)
>  {
>         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 5ec484b42432..4cbc45035f92 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -379,9 +379,7 @@ static int pool_ffa_op_alloc(struct tee_shm_pool *pool,
>  static void pool_ffa_op_free(struct tee_shm_pool *pool,
>                              struct tee_shm *shm)
>  {
> -       optee_ffa_shm_unregister(shm->ctx, shm);
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> -       shm->kaddr = NULL;
> +       optee_pool_op_free_helper(pool, shm, optee_ffa_shm_unregister);
>  }
>
>  static void pool_ffa_op_destroy_pool(struct tee_shm_pool *pool)
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index df3a483bbf46..e77765c78878 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -236,6 +236,9 @@ int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>                                                    struct page **pages,
>                                                    size_t num_pages,
>                                                    unsigned long start));
> +void optee_pool_op_free_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> +                              int (*shm_unregister)(struct tee_context *ctx,
> +                                                    struct tee_shm *shm));
>
>
>  void optee_remove_common(struct optee *optee);
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index f2ef76451443..0b27688d1e97 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -548,10 +548,9 @@ static void pool_op_free(struct tee_shm_pool *pool,
>                          struct tee_shm *shm)
>  {
>         if (!(shm->flags & TEE_SHM_PRIV))
> -               optee_shm_unregister(shm->ctx, shm);
> -
> -       free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> -       shm->kaddr = NULL;
> +               optee_pool_op_free_helper(pool, shm, optee_shm_unregister);
> +       else
> +               optee_pool_op_free_helper(pool, shm, NULL);
>  }
>
>  static void pool_op_destroy_pool(struct tee_shm_pool *pool)
> --
> 2.31.1
>
