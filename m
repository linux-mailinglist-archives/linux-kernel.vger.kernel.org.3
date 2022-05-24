Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FE5331EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiEXTv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiEXTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:51:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D42BB1D;
        Tue, 24 May 2022 12:51:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so37467625ejk.5;
        Tue, 24 May 2022 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DOFxqMaGUuRJeEsN0C0OkqduzwbXmrH3gQj+T82Log=;
        b=CHJboM1wl7TpJH/i5KVC+sbAGyKD0yHuVZxVhLbJlOmipuSRcAex8DroB7MVKOdkSt
         AYWR8RfhH14j7WourBRjYnVKrTTqMhC+6tB7woqv+CWwk3TwSV8qUEg5AbC9Nwx+3+Tl
         byfJQF4gFRecuqOLwvTfIStphMGbhSy6f1okmLwTk9ch74Ba0mOArWi6U9kAaYC838fC
         cHCp3suAitWiLALMB9fnBdnIYl8wqRRShSZyPyZgU2OfwpfNcpvOlbC2O+OYxiE5VD4G
         wFoYpzAOzc/XVuJ8vj7C9xUZ3EUGYM2MoTZYuTbfIfNBHp5e4AawcrcQhyU2DB5A4Sh0
         sS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DOFxqMaGUuRJeEsN0C0OkqduzwbXmrH3gQj+T82Log=;
        b=T9VTEgFnAIhSII+G90yhVTluTupUzOLn/KjHZKgWm97jBwXez4a91TXwapOWZm0feX
         1s1sk40Z5I4TMg6CQ9NqEztaQpyBi8CkWImmg0jgQuiePz/sY67Lo5KdeD13FqOoZQAB
         idvF3uih+4mNLbsXgWOLnH64EGoKE5qj2uxqvf+sgd9tvuKEers4m+bkQevYk3jqqz58
         SqsaZRBcp/1Bq24i2ATzyZueoy/dLXThLXSgO1S7qC/HmgAqA2Plpenv8sR3vxNEVjXf
         B2BT4YHuC00ygXMcagKpNG32Bkaamkl+jPDWGyLEyA/WBnVyVSE9zaiqwoTBTuq/UmFe
         GMOg==
X-Gm-Message-State: AOAM532ZUN+fkQR6NrAQ3x7YAi9BOR5V88UIc57+wcBvdXWzoCE8yeLk
        er4NmPYNXFBYX+fQRaWBslK/sjbdkEkgGvTlJDo=
X-Google-Smtp-Source: ABdhPJwtZYGdgX4z2ltjTKfzDUHn4PJ8nZTHlVIBOInrURZ90FbOTXpI8uqkaX4D2cktvAP3mpCdrqCs181v9OE+HtI=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr25485859ejc.636.1653421911628; Tue, 24
 May 2022 12:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru> <20220524181150.9240-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-5-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 May 2022 21:51:15 +0200
Message-ID: <CAHp75VdDJow59VQoDQa-Q0R7YCu63h5M5g82uc+fCrXJd_k15w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio:chemical:ccs811: rearrange iio trigger get and register
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

> Fixes: f1f065d7ac30 ("iio: chemical: ccs811: Add support for data ready trigger")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/chemical/ccs811.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 847194fa1e46..80ef1aa9aae3 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -499,11 +499,11 @@ static int ccs811_probe(struct i2c_client *client,
>
>                 data->drdy_trig->ops = &ccs811_trigger_ops;
>                 iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
> -               indio_dev->trig = data->drdy_trig;
> -               iio_trigger_get(indio_dev->trig);
>                 ret = iio_trigger_register(data->drdy_trig);
>                 if (ret)
>                         goto err_poweroff;
> +
> +               indio_dev->trig = iio_trigger_get(data->drdy_trig);
>         }
>
>         ret = iio_triggered_buffer_setup(indio_dev, NULL,
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
