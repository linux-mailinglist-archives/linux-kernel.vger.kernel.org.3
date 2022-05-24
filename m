Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC3533208
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiEXTyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241642AbiEXTyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:54:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1697CB20;
        Tue, 24 May 2022 12:54:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gi33so28978082ejc.3;
        Tue, 24 May 2022 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BM1TcEJ1rSjvHQ3DiiP4bMrjTXo3on1VRj5jI+ImT0c=;
        b=nCBYghWbLbxT1ChNXklDtLZuce4dbmnHu4mmcoCKiXKulovNPkWF6cvFuz0npHmOHu
         P6JoUKY3m46hiYVPUUpFXvyC1HWTxuErhziuokLysk//JdpZXUIUb/7k/9iZmc/LcsuC
         c7SqApT0As3pqSCB7nsqDZz6GkKfZkhjLhDl3BkPVzNi4bQIm6W5CxuvjwubJNfzTEQo
         /bfv0V4go7FpoYIn8m8aPPgrleSvI6HKX6bzvUZW0n3mbzUg7DpBnhLWqDwOiL/UkSJL
         j7QC6rUolyr1AtXktjGgJOWNpci+LVv15/7ukGgCbSQdQHYC7v6S8Why7cbLYEydPykh
         LHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BM1TcEJ1rSjvHQ3DiiP4bMrjTXo3on1VRj5jI+ImT0c=;
        b=jLdXFMDk0nVKV7Uf5SLVo8MQrWZXF5UfosU1L+oulPclhb5zpiPj6GARUGCgQYqvNg
         Hega44erT2qhlWdm5+oKsn2q7oDAawF6tOpG1c9Ygu/1ETKetNqSrXrh0cjR1EtLM/ow
         jVFrCciyAa7p5sL6ehei8VOnL2iC1qX4GNB4PCUETAicARJCkYAjrNQgB9yEFORFWlG0
         bnvRWE2mJr573FHGfFz5lWhIWf25K95NXW7Nkmi6pJUe7CjtE6hhrMhhN6/x9K42YK6j
         qalGwPdvBH5tUDKCGbFAx8TUX9tjd4Ywkn200EAxIEPuUNYyqvOZVgfFWgq9xueLdq0X
         3ugQ==
X-Gm-Message-State: AOAM533sI8VZjkqouKHdywNyp+AdXxGSVx76dRDBv08kWvp1pzMumDtE
        FDLFAaPhYjr93i8w8x76NSB1J9Yv/1o5qPEiYK8=
X-Google-Smtp-Source: ABdhPJzaOr1HrCCGCXVK5emjnaADAxldeFs8V//J5maGXkNHQVLCXsf5Lv3+INcjE2Vx4JJ8UDsszGRT5egoZfefRS8=
X-Received: by 2002:a17:906:c115:b0:6ff:6e5:b4b1 with SMTP id
 do21-20020a170906c11500b006ff06e5b4b1mr3780602ejc.497.1653422048613; Tue, 24
 May 2022 12:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru> <20220524181150.9240-2-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-2-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 May 2022 21:53:32 +0200
Message-ID: <CAHp75Vdyk0228iPX+-D12DcogS0mDBNzUmjAaO=VGT6brH0eyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio:accel:bma180: rearrange iio trigger get and register
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "teodora.baluta@intel.com" <teodora.baluta@intel.com>,
        "narcisaanamaria12@gmail.com" <narcisaanamaria12@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, May 24, 2022 at 8:14 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> IIO trigger interface function iio_trigger_get() should be called after
> iio_trigger_register() (or its devm analogue) strictly, because of
> iio_trigger_get() acquires module refcnt based on the trigger->owner
> pointer, which is initialized inside iio_trigger_register() to
> THIS_MODULE.
> If this call order is wrong, the next iio_trigger_put() (from sysfs
> callback or "delete module" path) will dereference "default" module
> refcnt, which is incorrect behaviour.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 0668a4e4d297 ("iio: accel: bma180: Fix indio_dev->trig assignment")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/accel/bma180.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index d8a454c266d5..5d0bd0fc3018 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1006,11 +1006,12 @@ static int bma180_probe(struct i2c_client *client,
>
>                 data->trig->ops = &bma180_trigger_ops;
>                 iio_trigger_set_drvdata(data->trig, indio_dev);
> -               indio_dev->trig = iio_trigger_get(data->trig);
>
>                 ret = iio_trigger_register(data->trig);
>                 if (ret)
>                         goto err_trigger_free;
> +
> +               indio_dev->trig = iio_trigger_get(data->trig);
>         }
>
>         ret = iio_triggered_buffer_setup(indio_dev, NULL,
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
