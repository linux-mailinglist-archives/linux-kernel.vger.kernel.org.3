Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E094755C263
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiF0HWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiF0HWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:22:44 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9445592;
        Mon, 27 Jun 2022 00:22:43 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id t16so13635867qvh.1;
        Mon, 27 Jun 2022 00:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lf4yj+6FH3gNxqcU8txlBalUgOkWR6VEzFtr+kOB45w=;
        b=r8SMDV+BhZ1EPLp/livoqkezb+I7n4kZcaMHomwrlNEJRheCmsv32HfK3N8FSCRQC0
         va50nPKyB0j/ZzQq1VVQarLZML2cBvscG7Mg7FtrHFk0+7wKLEwX6vAz+L1UdJpNHNgd
         pEWy2pbdP+drtYs9tYy0DSThilPXVLplDwR3SIrpDZAQaWngOX0lh41s/SuPL0bSf8FR
         MwVg3gldGIrJlE03lgCDgQG6uJFxX3RaB2NZINuFQVYbUGqNcm4pKNRMUVURxRY7dFyM
         JvMAdFKgysxkGWAUartu1CRFSB5HFtIqIOINGOqXTgUx855j/R4z/0A4QvxddPY8Z5ro
         H+1g==
X-Gm-Message-State: AJIora84feO3h55W2w1ffYNZQ0XSbkOdZ0ZLS/4cwBEihujXoGBEdnWb
        tXLbKgfbxjcqOCR89kyVhNBGRLtTAjovjA==
X-Google-Smtp-Source: AGRyM1szcE7hZ5EFRDS9XNeh//BOnMqjJs8qVxTnnkmuoEQBMmHl/yf8E+bGnS1KMPq3yqj/01yxqw==
X-Received: by 2002:a05:6214:238d:b0:46e:6864:ac18 with SMTP id fw13-20020a056214238d00b0046e6864ac18mr7573467qvb.78.1656314562655;
        Mon, 27 Jun 2022 00:22:42 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006aef1e5eb87sm8349155qkp.24.2022.06.27.00.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:22:42 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3177f4ce3e2so76567857b3.5;
        Mon, 27 Jun 2022 00:22:42 -0700 (PDT)
X-Received: by 2002:a81:9bcc:0:b0:317:9ff1:5a39 with SMTP id
 s195-20020a819bcc000000b003179ff15a39mr13857699ywg.384.1656314561880; Mon, 27
 Jun 2022 00:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220213025739.2561834-1-liambeguin@gmail.com> <20220213025739.2561834-7-liambeguin@gmail.com>
In-Reply-To: <20220213025739.2561834-7-liambeguin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 09:22:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVMhLRS+XuX_8O5UPHzoOp6a6XpTvysQS+nT+GLkL7gjQ@mail.gmail.com>
Message-ID: <CAMuHMdVMhLRS+XuX_8O5UPHzoOp6a6XpTvysQS+nT+GLkL7gjQ@mail.gmail.com>
Subject: Re: [PATCH v15 06/10] iio: test: add basic tests for the iio-rescale driver
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Mon, Feb 14, 2022 at 12:00 AM Liam Beguin <liambeguin@gmail.com> wrote:
> The iio-rescale driver supports various combinations of scale types and
> offsets. These can often result in large integer multiplications. Make
> sure these calculations are done right by adding a set of kunit test
> cases that build on top of iio-test-format.
>
> To run these tests, add the following to .kunitconfig
>         $ cat .kunitconfig
>         CONFIG_IIO=y
>         CONFIG_IIO_RESCALE_KUNIT_TEST=y
>         CONFIG_KUNIT=y
>
> Then run:
>         $ ./tools/testing/kunit/kunit.py run --kunitconfig .kunitconfig
>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> Reviewed-by: Peter Rosin <peda@axentia.se>

Thanks for your patch, which is now commit 8e74a48d17d509bf
("iio: test: add basic tests for the iio-rescale driver") in v5.18.

> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -4,6 +4,16 @@
>  #
>
>  # Keep in alphabetical order
> +config IIO_RESCALE_KUNIT_TEST
> +       bool "Test IIO rescale conversion functions"

Is there any reason this cannot be tristate, so I can always enable
this as a module, and run the test by loading the module whenever
I want?

> +       depends on KUNIT && !IIO_RESCALE
> +       default KUNIT_ALL_TESTS
> +       help
> +         If you want to run tests on the iio-rescale code say Y here.
> +
> +         This takes advantage of ARCH=um to run tests and should be used by
> +         developers to tests their changes to the rescaling logic.
> +
>  config IIO_TEST_FORMAT
>          bool "Test IIO formatting functions"
>          depends on KUNIT=y

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
