Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226775331E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbiEXTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiEXTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:51:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E96586;
        Tue, 24 May 2022 12:51:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s3so24374104edr.9;
        Tue, 24 May 2022 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdD0A3kORFytdCCRrXtE2cJ7QFpxw6dHdpuZCvNkIJ8=;
        b=YCFHbapgZuqrkMAYNMyL91yyz1Id7fkewk9HKhlwiE0Szz4shNaUwuhQT01QSaSS83
         M2V+Xpc9L8Pu3zbvrbHKLktnGakP57wEKM+y/rJdjxghH4R+0OrwxUEwsd6hNlKsOKgt
         l4xutCO0YN9RSyHArXYMR4cOGCAzQnsauJP5wS93toC24lliRYfwBDtThCZyqBpSGDYa
         4ve5TSgRs4JuCQSydxcoJKnft+KVdW2j5EoiLPELYLUXKTVJXUxLy/6wAjn3rmZ04zlX
         UFUcV77m9EsrETz7IKJUVloU6aM2uqcGDIXKFKb/N2NfgopJhXFSXUH6KYDnSLSGoI1i
         mqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdD0A3kORFytdCCRrXtE2cJ7QFpxw6dHdpuZCvNkIJ8=;
        b=klKbmCdMBpDzCp3CwGKrQQlU30CWS0nybAcLZLel6rGvi5bCgyQ8OO7YgaztUcY6Pc
         BNNkwNChp3/ZpXe7JeQZz0pjAsxF1cWVnB91SACd3cMxLxfyW2D2XRaEwrQW5vIEapL6
         rbo/Wv+nUNp3qYwuCUT7l7V5eutVFlA8C/b8SO/ShyMNx3m5LXoIZahT+NNDK5U+Nl0r
         hy5nfyFurCJAYHBRdokAtKjBsMTnMNeFYAQhfYTzvosieN7gCVVS+cbl+gJDVxP42860
         5In9sB5YoqxoYUW9Dw6kWLZCLlN730RJEZZWiilBDoU71bXSs8ftj7Pkl0MaOBBzW1I8
         mbeQ==
X-Gm-Message-State: AOAM531hSTJl0b6ty8r7LOqDEJpQL2xoTL625XjNYW1AYdgK3UK9TgoW
        KU/mgmKcz6XSUauNXyuX6FFAthwm1dgtwkpt77Q=
X-Google-Smtp-Source: ABdhPJxcr5wi7NoyUzqNXB4eWjFpJzYZCWIURW2i4YY4VifxNp0dUtpsVGCp0fU1ZNKf2XdKAuJNOnjDZQawNYnpdDg=
X-Received: by 2002:a05:6402:2806:b0:42b:67fc:8565 with SMTP id
 h6-20020a056402280600b0042b67fc8565mr12563925ede.230.1653421885286; Tue, 24
 May 2022 12:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru> <20220524181150.9240-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-4-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 May 2022 21:50:49 +0200
Message-ID: <CAHp75Vft+i4KcY2REP2PaF-srf=E+j2H0WBowvTcfpCEQMHppw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio:accel:mxc4005: rearrange iio trigger get and register
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

> Fixes: 47196620c82f ("iio: mxc4005: add data ready trigger for mxc4005")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/accel/mxc4005.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index b3afbf064915..df600d2917c0 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -456,8 +456,6 @@ static int mxc4005_probe(struct i2c_client *client,
>
>                 data->dready_trig->ops = &mxc4005_trigger_ops;
>                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> -               indio_dev->trig = data->dready_trig;
> -               iio_trigger_get(indio_dev->trig);
>                 ret = devm_iio_trigger_register(&client->dev,
>                                                 data->dready_trig);
>                 if (ret) {
> @@ -465,6 +463,8 @@ static int mxc4005_probe(struct i2c_client *client,
>                                 "failed to register trigger\n");
>                         return ret;
>                 }
> +
> +               indio_dev->trig = iio_trigger_get(data->dready_trig);
>         }
>
>         return devm_iio_device_register(&client->dev, indio_dev);
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
