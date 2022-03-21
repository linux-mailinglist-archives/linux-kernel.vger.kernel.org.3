Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6236E4E2238
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbiCUIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCUIdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:33:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557545D1AA;
        Mon, 21 Mar 2022 01:31:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k10so3164650edj.2;
        Mon, 21 Mar 2022 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptBJ8d2HXhA8CdAaHQDtBS8m0+CIB+DKz+bbzuAsNIE=;
        b=YJNrChZUz2zpNGb6N7/5G9E77OX8wf8fkLLmgy4NWBBcO6XnmZ+VC1b3vI6IQ5t5EZ
         eIx2XtXCvqOGkg/eUU0Wi3lSh8005CWSO3WyB+BOK6HMK5JZK0opXM8dGx0XRGn94IAn
         kq2N9RJY/r9yUwuWmgo1HKY86cjlKzUPHGFqi3sGvY382L2yjwoG2I54Tmr1SV3YsKUx
         lGAr2xUcjuIldU1AHyvpNpdBVbiFvaQG7cOsg1nUo+dfkL1biCmK8dWVhV2qonk8o7Jm
         fbqt8c+nBhZB0mFFU+NPWvrG8w4iSj1cfOKjgkIrqurRURIf1JdbeYkgHz3RfJecj0WI
         /EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptBJ8d2HXhA8CdAaHQDtBS8m0+CIB+DKz+bbzuAsNIE=;
        b=lNkBnobpdA6U9STi81ieD1FzATz1HTDLirYtlFiGOEqc+YmKpFbLS07POl2pqkruNi
         yNcqaMK80VKoWdQg1jVZkKvE1ERwZTW4Vls1SL86JplPzGYJ9t+WdfDshVgAzXe7pDDD
         FvY/mWP6TSkm3do3TeR7XUuv5JJFLkdkLGs0rOTpQgrq6ceLQ8D4SHkUU+p/ui/iaB5h
         7MpXq+F1mzESmM9ZplCKRdBL7y3/QAMwUe+OYqfsdkWHfKDj9Rzb3OcQKyarjij74SRf
         7e2bkxtyAtbR+J1xsFH/hwZeSrFVOGIY/oivbv4uyThqvKBHbaURAyNcj1PXXtFTgLlr
         t6nQ==
X-Gm-Message-State: AOAM532+1JUpDo0mJ15n3yQAkRYWqTNM2IATbjeRDQv+yb3QGwSO1ASp
        4YKkpFN83q4eAhBC+hPUrgJJifk+GnPylt+rQ54=
X-Google-Smtp-Source: ABdhPJwkZ7E9x3mlklbSGKy4s+bDAybw0OsCV2Xr/ugF7ASrrAvp+IRjqNV5CIpms5KY8brZDRTh2ZtOwhxEDpx2dRY=
X-Received: by 2002:aa7:dc4e:0:b0:419:407b:6bff with SMTP id
 g14-20020aa7dc4e000000b00419407b6bffmr3380196edu.158.1647851496821; Mon, 21
 Mar 2022 01:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com> <20220319181023.8090-2-jagathjog1996@gmail.com>
In-Reply-To: <20220319181023.8090-2-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:30:26 +0200
Message-ID: <CAHp75Vem7DS1oXRt=d78pKe4WEWVOJ7uR8p9r33H5Ws9Rz4Qmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] iio: accel: bma400: conversion to device-managed function
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> This is a conversion to device-managed by using devm_iio_device_register
> inside probe function, now disabling the regulator and putting bma400 to
> power down via a devm_add_action_or_reset() hook.
>
> The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
> and SPI driver struct is removed as devm_iio_device_register function is
> used to automatically unregister on driver detach.

...

> +static void bma400_disable(void *data_ptr)
> +{
> +       struct bma400_data *data = data_ptr;
> +       int ret;

> +       ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> +       if (ret)
> +               dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
> +                        ERR_PTR(ret));

By what reason did you remove mutex around this call?

> +       regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> +}



-- 
With Best Regards,
Andy Shevchenko
