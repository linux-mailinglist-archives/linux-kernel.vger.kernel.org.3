Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C14A42C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377144AbiAaLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377542AbiAaLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:10:11 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A99C061751;
        Mon, 31 Jan 2022 03:08:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w25so25166551edt.7;
        Mon, 31 Jan 2022 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2GSB+cw9fBHWC2jC3pTDr/GEplFrT5rHLrrinIShdM=;
        b=duGpE0ZyhrSh8C7+2BcmiI9rLr5N8bpscoM7526UGikK+irkYznXFUUatn8/dIfHs0
         ZtEPS6jfIMmBvQzq3jn9fAzyjqBtcCAWCJZJIsXHTLgHA/e4sKTcQOwHQpqoNAZ2hBKL
         BR0YkoNg+OCLQx1Dnm/wHz3Tc8pYDd5p8ZzROW4kwUWFLJiuAu3l0UQvSv8Hjm4iYKr6
         fOzhC8lgTBKn4wiVQLT81yNg3+gJ4h0s3Ot3B1YZRdN2s1Rx/B2KV8G2+RYpKqyouDEJ
         InKPNbopUk+W1yceAkcAxGgzPDnemnZF7k9lmwliMTJJ6tu6hL8Gm2k1irV2rQzZoEmm
         3CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2GSB+cw9fBHWC2jC3pTDr/GEplFrT5rHLrrinIShdM=;
        b=6rag4oGYwYad/mTMWjTF7rj8bNDoDaBss1n9yXLnxydS3p2Q1l/HbLfln9QM2x0YPE
         TASJYwenp4NFSwGSmkl+YlCPxQtU6PQP+UuTbuVs42kruq4NwYWsv6hygYLPgR6GUlQQ
         m42fkgfRdzf2HomA4rH6ZAzofhj22sJJeoHfKiwoz1XXVuU9Jngis1b6ZWAS0MQAc/Ns
         LOY11iBEKlItrEdw0SRorLPnkC/EmL0vlN86Fl4s4HF+3vi74ufQvwaDmxnyhwLojX6Y
         77HGETYSX1EX5WC3q9ze+pSdGdMIFyXo7PLcY4l7ba7dRBNdjk1JxG0aKWGNdsBWJLUx
         sPFQ==
X-Gm-Message-State: AOAM530Ot/udggfiU604v3ZfZGtZo/c0VwRpeVi5b3wkRo+XGr7RM1Mi
        w/usoJczGLUoHUYNik5YLaUZxQ0AL8IZ/XMxxtKPsa7QEpY=
X-Google-Smtp-Source: ABdhPJyMcyvbVO4D3864tYIiVkQgZLjfAJr9n0nGKbgdI4LQoyNRLGy1giaO2KVdFuGjcxamXLWT5Xu51k94fg5m8ew=
X-Received: by 2002:a05:6402:350d:: with SMTP id b13mr20146137edd.125.1643627294519;
 Mon, 31 Jan 2022 03:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20220130161101.1067691-1-liambeguin@gmail.com>
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Jan 2022 13:06:38 +0200
Message-ID: <CAHp75VdpA-fFBvkwUB4mvu=ye9xBf7aVPvmA3bC7btf1zGe2Ag@mail.gmail.com>
Subject: Re: [PATCH v13 00/11] iio: afe: add temperature rescaling support
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 6:11 PM Liam Beguin <liambeguin@gmail.com> wrote:
>
> Jonathan, Peter, Andy,
>
> This series focuses on adding temperature rescaling support to the IIO
> Analog Front End (AFE) driver.
>
> The first few patches from previous iterations addressing minor bugs in
> IIO inkernel functions have been taken in, and are no longer in v13.
>
> The main changes to the AFE driver include an initial Kunit test suite,
> support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> and temperature transducer sensors.
>
> I'm not quite sure what happened with the left-shift change last time,
> I had it in my v12 local branch, it seems I got mixed up before sending.

LGTM (with the potential room to clean up in the future, but let's
digest this first)
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks for your time,
> Liam
>
> Changes since v12:
> - rebase on latest testing branch
> - fix copyright holder in newly created header file
> - add myself as a copyright holder of the iio-rescale.c driver at
>   Peter's suggestion
> - fix undefined behavior on left-shift operation
>
> Changes since v11:
> - update commits with my personal email since all this work was done on
>   my own time
> - apply Peter's Reviewed-by to my local tree
> - fix use of units.h
> - make use of units.h more consistently in iio-rescale.c and in the
>   tests
> - fix #include ordering
> - treat 04/16 as a fix. Move it, and add a Fixes: tag
> - fix undefined behavior on left-shift operation
> - add comment about fract_mult with iio_str_to_fixpoint()
> - reword commit message for 14/16, based on Andy's comments
>
> Changes since v10:
> - apply Andy's suggestion for offset calculations
> - make use of units.h more consistently
>
> Changes since v9:
> - make use of linux/units.h
> - reorder commits, fix fract_log2 before merging fract
> - keep fractional representation when not overflowing
>
> Changes since v8:
> - reword comment
> - fix erroneous 64-bit division
> - optimize and use 32-bit divisions when values are know to not overflow
> - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
>   point
> - add test cases
> - use nano precision in test cases
> - simplify offset calculation in rtd_props()
>
> Changes since v7:
> - drop gcd() logic in rescale_process_scale()
> - use div_s64() instead of do_div() for signed 64-bit divisions
> - combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
> - switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
> - rework test logic to allow for small relative error
> - rename test variables to align error output messages
>
> Changes since v6:
> - rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
> - combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
> - add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
> - force use of positive integers with gcd()
> - reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
> - fix duplicate symbol build error
> - apply Reviewed-by
>
> Changes since v5:
> - add include/linux/iio/afe/rescale.h
> - expose functions use to process scale and offset
> - add basic iio-rescale kunit test cases
> - fix integer overflow case
> - improve precision for IIO_VAL_FRACTIONAL_LOG2
>
> Changes since v4:
> - only use gcd() when necessary in overflow mitigation
> - fix INT_PLUS_{MICRO,NANO} support
> - apply Reviewed-by
> - fix temperature-transducer bindings
>
> Changes since v3:
> - drop unnecessary fallthrough statements
> - drop redundant local variables in some calculations
> - fix s64 divisions on 32bit platforms by using do_div
> - add comment describing iio-rescaler offset calculation
> - drop unnecessary MAINTAINERS entry
>
> Changes since v2:
> - don't break implicit offset truncations
> - make a best effort to get a valid value for fractional types
> - drop return value change in iio_convert_raw_to_processed_unlocked()
> - don't rely on processed value for offset calculation
> - add INT_PLUS_{MICRO,NANO} support in iio-rescale
> - revert generic implementation in favor of temperature-sense-rtd and
>   temperature-transducer
> - add separate section to MAINTAINERS file
>
> Changes since v1:
> - rebase on latest iio `testing` branch
> - also apply consumer scale on integer channel scale types
> - don't break implicit truncation in processed channel offset
>   calculation
> - drop temperature AFE flavors in favor of a simpler generic
>   implementation
>
>
> Liam Beguin (11):
>   iio: afe: rescale: expose scale processing function
>   iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>   iio: afe: rescale: add offset support
>   iio: afe: rescale: fix accuracy for small fractional scales
>   iio: afe: rescale: reduce risk of integer overflow
>   iio: afe: rescale: make use of units.h
>   iio: test: add basic tests for the iio-rescale driver
>   iio: afe: rescale: add RTD temperature sensor support
>   iio: afe: rescale: add temperature transducers
>   dt-bindings: iio: afe: add bindings for temperature-sense-rtd
>   dt-bindings: iio: afe: add bindings for temperature transducers
>
>  .../iio/afe/temperature-sense-rtd.yaml        | 101 +++
>  .../iio/afe/temperature-transducer.yaml       | 114 +++
>  drivers/iio/afe/iio-rescale.c                 | 292 ++++++-
>  drivers/iio/test/Kconfig                      |  10 +
>  drivers/iio/test/Makefile                     |   1 +
>  drivers/iio/test/iio-test-rescale.c           | 711 ++++++++++++++++++
>  include/linux/iio/afe/rescale.h               |  36 +
>  7 files changed, 1226 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-sense-rtd.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/temperature-transducer.yaml
>  create mode 100644 drivers/iio/test/iio-test-rescale.c
>  create mode 100644 include/linux/iio/afe/rescale.h
>
> Range-diff against v12:
>  1:  a8ca9300ef2a <  -:  ------------ iio: inkern: apply consumer scale on IIO_VAL_INT cases
>  2:  efaeceac8d87 <  -:  ------------ iio: inkern: apply consumer scale when no channel scale is available
>  3:  8131208a4454 <  -:  ------------ iio: inkern: make a best effort on offset calculation
>  4:  06202d8f6481 <  -:  ------------ iio: afe: rescale: use s64 for temporary scale calculations
>  5:  87b9d77f0d30 <  -:  ------------ iio: afe: rescale: reorder includes
>  6:  e9bf09ca9703 !  1:  ee26b0eeac65 iio: afe: rescale: expose scale processing function
>     @@ include/linux/iio/afe/rescale.h (new)
>      @@
>      +/* SPDX-License-Identifier: GPL-2.0-only */
>      +/*
>     -+ * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
>     ++ * Copyright (C) 2018 Axentia Technologies AB
>      + */
>      +
>      +#ifndef __IIO_RESCALE_H__
>  7:  865296d2bc4f =  2:  a510097c83f1 iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>  8:  aea3159ed169 !  3:  8f2f2699a9b4 iio: afe: rescale: add offset support
>     @@ Commit message
>          Reviewed-by: Peter Rosin <peda@axentia.se>
>
>       ## drivers/iio/afe/iio-rescale.c ##
>     +@@
>     +  * IIO rescale driver
>     +  *
>     +  * Copyright (C) 2018 Axentia Technologies AB
>     ++ * Copyright (C) 2022 Liam Beguin <liambeguin@gmail.com>
>     +  *
>     +  * Author: Peter Rosin <peda@axentia.se>
>     +  */
>      @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale, int scale_type,
>         }
>       }
>  9:  7b518cba1cb5 =  4:  2efa970bad26 iio: afe: rescale: fix accuracy for small fractional scales
> 10:  79844ae7461c !  5:  201037c0ead8 iio: afe: rescale: reduce risk of integer overflow
>     @@ drivers/iio/afe/iio-rescale.c: int rescale_process_scale(struct rescale *rescale
>      +          if (scale_type == IIO_VAL_FRACTIONAL)
>      +                  tmp = *val2;
>      +          else
>     -+                  tmp = 1 << *val2;
>     ++                  tmp = ULL(1) << *val2;
>
>                 rem2 = *val % (int)tmp;
>                 *val = *val / (int)tmp;
> 11:  19f28d029522 =  6:  0e3bf50d9eb2 iio: afe: rescale: make use of units.h
> 12:  18b743ae2f8b =  7:  72813d9788e4 iio: test: add basic tests for the iio-rescale driver
> 13:  240a3f1424fc =  8:  8ee4c16355af iio: afe: rescale: add RTD temperature sensor support
> 14:  d7dc1e1f8f9c =  9:  36a9bb066369 iio: afe: rescale: add temperature transducers
> 15:  c0a94061491a = 10:  581962b44cf3 dt-bindings: iio: afe: add bindings for temperature-sense-rtd
> 16:  b29eed6b4e17 = 11:  d09d377b05ac dt-bindings: iio: afe: add bindings for temperature transducers
>
> base-commit: cd717ac6f69db4953ca701c6220c7cb58e17f35a
> --
> 2.35.1.4.g5d01301f2b86
>


-- 
With Best Regards,
Andy Shevchenko
