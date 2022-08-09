Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9A58D6D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiHIJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiHIJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:53:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7B237C0;
        Tue,  9 Aug 2022 02:53:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i24so8262982qkg.13;
        Tue, 09 Aug 2022 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wD1M5z8B531e5NdBeNnG/0DZVP1KTM21sISlJ8/KhBY=;
        b=QiZdu/ZrO+9+z4cp+yAyLG+b5AqKRTiWGKm6R46glWkBH2l0E+6dVbY5dIObMJ/utz
         8J1Px9QcUA/plhwZyjvHEytRTMjPxwcLtNwWHbIkSphJ4hOtJ+u5LHfC3kDIwcCslMew
         WBU3zkMZXuIRBIuOx82IxJKcPzGMgOuLlnk8W7obRh07TkAIFXcWfwwLihii3ICCPeGW
         BOZsVyxOXsRA6ezRIiZTpmnc7ad6wq16njjUhb6C+nN+8DjoXLcFfHbfiQb3009RqiNL
         GoptSSl3AEVX5JDu1e1oczpJf5j+UV/ts9/Rzlr9j5hSsgux+mKRcbJgDTtiBc91F3RC
         d4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wD1M5z8B531e5NdBeNnG/0DZVP1KTM21sISlJ8/KhBY=;
        b=zBuH6haLgzeQznSNhf8YccHuS8r9y9+BkZHTF5PVE4iHBSlePXIvKLPKsg7dWQZpPy
         W7rOo4ExN0FP4ANIL4DyUEj6s4Xj4Jv3NoZEcLVa25hMawfjDMZ1ZfAkhDCkaUpHqytE
         r3Y3quNX+NIQpP4m+4SX1MATEXMuipTmnaljFFRS+6JfPj9Du8notcsI1kPkxQYnEl1b
         2oYdounixbcYJ3EtJBsaTXTI18ZIiVe5raAtbOW65vCmyQ1mIKVThZQXRNu/VLFsy2Mi
         iqZtO4Niz/d8y+aMQhmx1WRLe9ZzZqp+azz4ZBgV3uNH46qR2e4gyy7TNjyPLZqRrYay
         17MQ==
X-Gm-Message-State: ACgBeo2VLPU8sRhlcMbksCJDhSjN/0uPDtIijalsXCU1y5zfNcChbUde
        QIjzpMN9duKVpi8XKmDzb3Bm6TUJKU84feFgpgv+6AWs66Y=
X-Google-Smtp-Source: AA6agR5Rtkm8klmstIT4E1JG+CQK1v7oHC+oUsv4Gm3Y2Z+rnq1Kt+AmzFXa7JJlAKX96lOGzwM+fuz9ROHsaCwM4cQ=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr17333570qkp.734.1660038813607; Tue, 09
 Aug 2022 02:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220809073648.167821-1-marcus.folkesson@gmail.com> <20220809073648.167821-6-marcus.folkesson@gmail.com>
In-Reply-To: <20220809073648.167821-6-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:52:57 +0200
Message-ID: <CAHp75Vfhd=4Jzra-Vz9qfMw0Pe1YRT-sGNe_=4pZ=WEd5EqBig@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iio: adc: mcp3911: add support for buffers
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Tue, Aug 9, 2022 at 9:32 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

Below comments are minor and may be addressed in case you have to
issue another version of the series (depending on what Jonathan asks).

...

> Add support for buffers to make the driver fit for more usecases.

use cases

...

>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/trigger.h>

I would split this group...

>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>

...and put it here to explicitly show that the driver belongs to the
IIO subsystem.

> +#include <asm/unaligned.h>

...

> +       struct spi_transfer xfer[] = {
> +               {
> +                       .tx_buf = &adc->tx_buf,
> +                       .len = 1,
> +               }, {
> +                       .rx_buf = adc->rx_buf,
> +                       .len = sizeof(adc->rx_buf),
> +               },
> +       };

> +

Redundant blank line.

> +       int scan_index;

...

> +       for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +                       indio_dev->masklength) {

One line?

> +               const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
> +
> +               adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);
> +               i++;
> +       }

-- 
With Best Regards,
Andy Shevchenko
