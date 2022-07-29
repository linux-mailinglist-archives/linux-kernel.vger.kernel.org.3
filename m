Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABEE5854E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiG2SEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2SEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:04:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1F489E9C;
        Fri, 29 Jul 2022 11:04:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a89so6740033edf.5;
        Fri, 29 Jul 2022 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3MAjoMT9VR/wVsWj4lPdUn6oGHvZ2QXR6VcneAl0a/Q=;
        b=MlGuR0BktiYu1BpW7yWcehNVLCtLpci7Jcdcdz5Beutn26gAMho09FObomibZY09NQ
         GJLt7XAIAWk+1rJ0BLO+u3y5fvW5BlKAiRzMmbxD0v5iWNkfreHgXVclCFQjEbVG+TOH
         GJOQZpoIwVCoF+QjaDF9UBB6dtpj9H9s9wzJ4KmVpKwCpWFnjgqOTPVy/Af083vpx+N9
         tBHovkvATIHC5XXrX5LTRGezpmhEmNTPKicxGe9GT6zz8EMZNL/KyKW0sMrpMzz0Ks1V
         vi45ZYg00m9X6ntYv9wyroEEWU3kdjZXV1GmI/ooQ32ZFesLG6r2SyndQzwV/758nEcQ
         5VhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3MAjoMT9VR/wVsWj4lPdUn6oGHvZ2QXR6VcneAl0a/Q=;
        b=sPj4fT3zF3dF9571RYe+6U7xcsjCgEwsyEH0EwHUIjBGW1p4/vGgmrmEW16gVv9ZEN
         I4KrB/lTSvQHiL+3q+VGpcMv2tFdZgHbt9pqpWzNVnhxrgMsNokflrXmElWQMn3Rc+0D
         hKCddF0S+8izdwZhMDE6lMzexy1qTkuoUkm4pSyokWO2p3oygXXxAcpqIVuC3pgfO9Or
         cZ1wd4n/pcO3EawTirCOjQkYdSBb9YVqbetVwQCwZ4LLL0hBauRYTnH7knt7tIVhvBhS
         636wLl6l53nFWNMFmbRJRPmxejiafXOULWScIhEcceD9zjpxByXv6qm+lf+f0Foj/WTM
         Pvkg==
X-Gm-Message-State: AJIora+fEr+e+hX8cMC4m9QtvMO6lPCUAuV+BJzYMXlKOkUjKzT1GrdF
        vHCIkOMgtucu4U+i1elQanxp4lyK1C9mDwhxCMY=
X-Google-Smtp-Source: AGRyM1vC6lO293TtGD+jsks8a3hiBL0azv2QELnBLvSrEAl+kigI7L9fPXtiq6xJmoFJ2lgoshQ6GuUrjfBnTHNEoT4=
X-Received: by 2002:a05:6402:4414:b0:434:f58c:ee2e with SMTP id
 y20-20020a056402441400b00434f58cee2emr4659034eda.362.1659117869031; Fri, 29
 Jul 2022 11:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru> <20220729172332.19118-3-ddrokosov@sberdevices.ru>
In-Reply-To: <20220729172332.19118-3-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 20:03:51 +0200
Message-ID: <CAHp75VdZbnT2AbCWaBo9Fo7jWba=12ydkpqPbNHgqDWUiWWrsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: accel: adxl345: use HZ macro from units.h
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 7:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> Remove duplicated definition of NHZ_PER_HZ, because it's available in
> the units.h.

Fine to me in principle (whatever name it gets after all)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/iio/accel/adxl345_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 370bfec1275a..94189133fe8f 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/units.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -32,7 +33,6 @@
>
>  #define ADXL345_BW_RATE                        GENMASK(3, 0)
>  #define ADXL345_BASE_RATE_NANO_HZ      97656250LL
> -#define NHZ_PER_HZ                     1000000000LL
>
>  #define ADXL345_POWER_CTL_MEASURE      BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY      0x00
> --
> 2.36.0



-- 
With Best Regards,
Andy Shevchenko
