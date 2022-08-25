Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4D5A1A19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbiHYUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiHYUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:12:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67142B99E1;
        Thu, 25 Aug 2022 13:12:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id cb8so16176430qtb.0;
        Thu, 25 Aug 2022 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pGYo7MgM4ntqJX0vqGEGbqHVguM5P8C7f8EezOlQTHg=;
        b=HfPj2BmNqHO+f4BQZjcu7YafJWAMqQcvYdDb0aeIrS/YafRs+39ImkXbw45p0Dj1OV
         JAG3JCDBUrWxWyYnAhkzU+Gv4KhdIgy6o0rXgpw557QT85sSkaTZF2xl9sUs6yB2hckO
         nTfSPe8MMNUMOCbEEu8FiorTgSKsuOi1Lb+se/UqtY2pkqxUJTyb7PKGyMbPDLSfROEF
         XGfzj2NU4zYNk7IMVMwsOePJ/YUL0XVODBDcHHn1bUf9QvzIXAW74mDCkwQHdYkaIe59
         8trvc+VWfIiq1xNHYvKNkWFlOvno2TuWIDyahveGPzo3KFxk7a+W/+tUNRq1/D9L3Zbv
         erZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pGYo7MgM4ntqJX0vqGEGbqHVguM5P8C7f8EezOlQTHg=;
        b=PeG8Lx8EDTWCHkZk7z1G1Eyd76CmQrTaXILHmhnLLM1ngsnD+2SGWw5tre5NUvz/V6
         cvbi/7RekRKIt1u8aW+fjLleCOZ/uyfhN+wV0YdrxxOL0Nr9xmXnyHuH7cUPHV0f6Arq
         CqnQq8Y0eaMmTh/haDDEZ28ZWCO2VDF8oXgnv+azeNK6OpBfWG8LR5NWZ5RkdLp9p3X4
         q7VoKKa0fUMSAQTBQRwMpXqvG7sjYejgFyM1B+8uNalvG7/k0KqZw3IGwPEEpB/NAf8c
         gRLVegSfcvywECLwqiPX2QXnINj08aSVrgoF9IlEoJDQKscds05uHtxZwx+YBQfqEVVL
         cjrg==
X-Gm-Message-State: ACgBeo02aYgPsmlv2zjUzH5cCVvxNpatUTJ4TL/VLykYFiWp64xnbYal
        3BI1iz/brl3fERZLy8ZaVGFYZ2EG6LSYkgG5M6EI7g3aQko=
X-Google-Smtp-Source: AA6agR7FS23bQp6uuqGhFRmQ6qNFnWot94d8f/D3GbqmtaHSFbUX523BypBhI/yRwc3hRlLN/ZPGcY+U+IfsvOWmX4g=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr5185305qtx.481.1661458351521; Thu, 25
 Aug 2022 13:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220824125203.685287-1-ramona.bolboaca@analog.com> <20220824125203.685287-3-ramona.bolboaca@analog.com>
In-Reply-To: <20220824125203.685287-3-ramona.bolboaca@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 23:11:55 +0300
Message-ID: <CAHp75VeP_ZLYSty2x_m27M_1HzsXx_DX=UsZopPEonAfr7_RyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: add max11205 adc driver
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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

On Wed, Aug 24, 2022 at 3:56 PM Ramona Bolboaca
<ramona.bolboaca@analog.com> wrote:
>
> Adding support for max11205 16-bit single-channel ultra-low power
> delta-sigma adc.
> The MAX11205 is compatible with the 2-wire interface and uses
> SCLK and RDY/DOUT for serial communica- tions. In this mode, all
> controls are implemented by tim- ing the high or low phase of the SCLK.
> The 2-wire serial interface only allows for data to be read out through the
> RDY/DOUT output.

Is there any existing driver that can be extended to support this chip?

...

> +       st->chip_info = device_get_match_data(&spi->dev);

And if chip_info is NULL?

...

> +static void max11205_remove(struct spi_device *spi)
> +{
> +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +       struct max11205_state *st = iio_priv(indio_dev);

> +       iio_device_unregister(indio_dev);
> +       regulator_disable(st->vref);
> +}

Have you tested module removal?

> +

...

> +static const struct chip_info max11205_chip_info[] = {
> +       [TYPE_MAX11205A] = {
> +               .out_data_rate = MAX11205A_OUT_DATA_RATE,

> +               .name = "max11205a"

+ Comma

> +       },
> +       [TYPE_MAX11205B] = {
> +               .out_data_rate = MAX11205B_OUT_DATA_RATE,

> +               .name = "max11205b"

Ditto.

> +       }

Ditto.

> +};

...

> +

Redundant blank line.

> +module_spi_driver(max11205_spi_driver);

-- 
With Best Regards,
Andy Shevchenko
