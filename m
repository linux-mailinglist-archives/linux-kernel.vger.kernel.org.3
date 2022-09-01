Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD675A90D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiIAHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiIAHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7358125BB4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:43:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so1716899pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xAasCrPyDcJjNZEv/g1ZViJ/obKRI3obPhi8OuWR/Jg=;
        b=fTQzVN2+a+Qmud5WL/Hkyqm4dpv+bd0N/1hRwrASuIUQ/9dV5WH0AyeQ+shXU/3C70
         C5L98tomT5S4qR8eUdya9eEH2+7GhhLAC6Z2r9l7EAk5kmdavbx5VXxKhYw0DtMYb9lh
         y+Ccr0qtQJDj1sJebYGpQV7l1qj4bMFLSUEMrMcuB45js1fxldKtTxv00Udx9P+2krPk
         yB4crUqo2OhwKOqjckLMjf2bRxsd8zf9freqzuhk0Lfi3ERHz6gmfEdxl5oqqt1cnAzq
         4aE+4nTrco/e1sKWleF24HR1JiEsKxipXAmN/+aIfV5FIoEkw3yf+8laRNiEm+y/3TaP
         MaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xAasCrPyDcJjNZEv/g1ZViJ/obKRI3obPhi8OuWR/Jg=;
        b=6gmlak7ITIqvTAJyBO4e4kl8G/Ztl8FXeLqEoylJeVe+ub60+0Fe8utsQjIhfKwe4O
         ORhto2c8i2PvWVOzQcMVD6mfz9QOFuNfj+8XZw4d0HVbokSAVQb7t2MGZEQ+EfJrTri8
         a7CsYzIrJANej+bzBgvc8Vj9Hn/6iwdYjnAFZWs5BKutLOxL141/1q+cgCZqadtJ2tmr
         R4CQxHB/j9O+kSMaT9FJsA2d0tmqqDtlVpJ4HTwovIyRpCRQqEkNC/faWDpe7Kla/HB2
         GdE6FUOp91r0eQy4p13JT6lmcbkebXt985nhepDWEx5MD37f+mSkHwBDd+DEkAh/G5LQ
         KPuQ==
X-Gm-Message-State: ACgBeo1d3BhBAP9DR+0E8qKuXh8ffJmYQnOPqKqAY33tWD2MBc1k/b0x
        e3yJ0VTAEKEoyb68iyH9hfi4IkFBc8Y4ZXeqxBpUzLgunrSnbw==
X-Google-Smtp-Source: AA6agR51xRKfsuWzY7TjERjWz9bBX6piO4b74yFoMwPCvR8u0J7qUSxcNyUHR07wO2nUzAieCaeTmJ9wR4tmzNizLgQ=
X-Received: by 2002:a17:902:d505:b0:175:5313:2a3f with SMTP id
 b5-20020a170902d50500b0017553132a3fmr3939626plg.70.1662018186293; Thu, 01 Sep
 2022 00:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-2-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-2-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 09:42:55 +0200
Message-ID: <CAHUa44E8q27hy2i+sckuWd5GahGg=QxgLUWLAMQwCrxhUGNrNQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] firmware: arm_ffa: Add pointer to the ffa_dev_ops in
 struct ffa_dev
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently ffa_dev_ops_get() is the way to fetch the ffa_dev_ops pointer.
> It checks if the ffa_dev structure pointer is valid before returning the
> ffa_dev_ops pointer.
>
> Instead, the pointer can be made part of the ffa_dev structure and since
> the core driver is incharge of creating ffa_device for each identified
> partition, there is no need to check for the validity explicitly if the
> pointer is embedded in the structure.
>
> Add the pointer to the ffa_dev_ops in the ffa_dev structure itself and
> initialise the same as part of creation of the device.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/bus.c    | 4 +++-
>  drivers/firmware/arm_ffa/driver.c | 2 +-
>  include/linux/arm_ffa.h           | 7 +++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
> index 641a91819088..69328041fbc3 100644
> --- a/drivers/firmware/arm_ffa/bus.c
> +++ b/drivers/firmware/arm_ffa/bus.c
> @@ -167,7 +167,8 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev)
>         return valid;
>  }
>
> -struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
> +struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
> +                                      const struct ffa_dev_ops *ops)
>  {
>         int ret;
>         struct device *dev;
> @@ -183,6 +184,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
>         dev_set_name(&ffa_dev->dev, "arm-ffa-%04x", vm_id);
>
>         ffa_dev->vm_id = vm_id;
> +       ffa_dev->ops = ops;
>         uuid_copy(&ffa_dev->uuid, uuid);
>
>         ret = device_register(&ffa_dev->dev);
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index ec731e9e942b..213665e5ad0e 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -688,7 +688,7 @@ static void ffa_setup_partitions(void)
>                  * as part of the discovery API, we need to pass the
>                  * discovered UUID here instead.
>                  */
> -               ffa_dev = ffa_device_register(&uuid_null, tpbuf->id);
> +               ffa_dev = ffa_device_register(&uuid_null, tpbuf->id, &ffa_ops);
>                 if (!ffa_dev) {
>                         pr_err("%s: failed to register partition ID 0x%x\n",
>                                __func__, tpbuf->id);
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index e5c76c1ef9ed..91b47e42b73d 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -17,6 +17,7 @@ struct ffa_device {
>         bool mode_32bit;
>         uuid_t uuid;
>         struct device dev;
> +       const struct ffa_dev_ops *ops;
>  };
>
>  #define to_ffa_dev(d) container_of(d, struct ffa_device, dev)
> @@ -47,7 +48,8 @@ static inline void *ffa_dev_get_drvdata(struct ffa_device *fdev)
>  }
>
>  #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
> -struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id);
> +struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
> +                                      const struct ffa_dev_ops *ops);
>  void ffa_device_unregister(struct ffa_device *ffa_dev);
>  int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
>                         const char *mod_name);
> @@ -57,7 +59,8 @@ const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev);
>
>  #else
>  static inline
> -struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
> +struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
> +                                      const struct ffa_dev_ops *ops)
>  {
>         return NULL;
>  }
> --
> 2.37.2
>
