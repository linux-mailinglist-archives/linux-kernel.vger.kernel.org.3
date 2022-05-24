Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408135331DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiEXTuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241023AbiEXTuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:50:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD397938B;
        Tue, 24 May 2022 12:50:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh17so24429039ejc.6;
        Tue, 24 May 2022 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erB0Nr5QGniVYc8uYtdY4lO+Lcl9pYRcvVJYReAay80=;
        b=lMBJHbbyBsIj8e63LUfiCs6dUnnwhiG63we4MDpCGcc/na4051pveWL3zaRszvrDX8
         /u83PfoxBDPtiZBKtQp/ygsnscfrWseaOmBbscKCdH1NO3jMlVmxVAx9y3j8wQx8aOkS
         XQMiFyEXY1RBbAGBE5biElMmN2PSg/NcPVVTAiE3a7i8GuxCI6wT+QG0cdP78ancRQUR
         UtvW5+njcWdAi0UOXQ22kO8IKvlseBE5jYQ52D1PyLhw8D3nmCimdHQ6Kv0qqmab1A5b
         swHjheN4Gmahr8ZJXPfDGj7DBvLzjMAWIv7ZOln0jt85pOONK0Owl2UXHF/0921ia38W
         6QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erB0Nr5QGniVYc8uYtdY4lO+Lcl9pYRcvVJYReAay80=;
        b=2XiFIZ6rURcn5E2LTr+oOJbT1U4r7EdcW8zzLLhZFogGlp5COa7w79rcgtStcxwJu1
         b+ij3yQGsCkM10S6gIaAuCI4bnsnjBmhsg2zHmVGOUsp53vwTs9hRHoL7YvNSGJzQ7PQ
         gesqNbD+KySbI4i8yggJD/0emWx7NUZJbtESk6xUoD8UJ4qqSwJyOSi3BgHcXgPN/AaM
         nZeAXb5Me/aepaxVUnDtQYJLiGxKNBerhSYONUqwKZUbgaJeRZiiUmMSR0x5RnK7fT7k
         J8X9R3KMn3W+qoVCCxkGraSAEfrzTAtXyGRpQW0e7bnVlrQ5jR9I9u8xYSVKBdihSAJA
         gOwA==
X-Gm-Message-State: AOAM532BfUQi2wXI5vq/IVWLXt1hIppJpC6655PeuLlEzYveoxGDR0ff
        HMuEd3lYNFKgpZFY183hjxJiylgJW7ojjrOPaEE=
X-Google-Smtp-Source: ABdhPJzoOBDC9ZZ6MN5xbxf6IOZczh/u5HsjN5yM8numN6ez95D+fZKkGNCBIF537kp89E94WjhXgL0qNiC3XspLIMQ=
X-Received: by 2002:a17:907:6e1a:b0:6fe:f357:3837 with SMTP id
 sd26-20020a1709076e1a00b006fef3573837mr8928209ejc.44.1653421808782; Tue, 24
 May 2022 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220524181150.9240-1-ddrokosov@sberdevices.ru> <20220524181150.9240-3-ddrokosov@sberdevices.ru>
In-Reply-To: <20220524181150.9240-3-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 May 2022 21:49:32 +0200
Message-ID: <CAHp75VcYtTkLe7iAXH3snKuV29xaDHsj1GOrxztT1g-DOu3RoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio:accel:kxcjk-1013: rearrange iio trigger get
 and register
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

> Fixes: c1288b833881 ("iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index ac74cdcd2bc8..748b35c2f0c3 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1554,12 +1554,12 @@ static int kxcjk1013_probe(struct i2c_client *client,
>
>                 data->dready_trig->ops = &kxcjk1013_trigger_ops;
>                 iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> -               indio_dev->trig = data->dready_trig;
> -               iio_trigger_get(indio_dev->trig);
>                 ret = iio_trigger_register(data->dready_trig);
>                 if (ret)
>                         goto err_poweroff;
>
> +               indio_dev->trig = iio_trigger_get(data->dready_trig);
> +
>                 data->motion_trig->ops = &kxcjk1013_trigger_ops;
>                 iio_trigger_set_drvdata(data->motion_trig, indio_dev);
>                 ret = iio_trigger_register(data->motion_trig);
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
