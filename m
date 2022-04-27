Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD25116F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiD0MiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiD0MiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:38:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0599F50E33;
        Wed, 27 Apr 2022 05:34:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so3141219ejn.2;
        Wed, 27 Apr 2022 05:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhfpcQvRyLbcrTp/kXyOp93AQzKLRCL6FGXAmgALmAs=;
        b=Bk1FQAG7UVM2UrT6fvL2VChLSxmZ6j26DKtnO7pxhz+GXrsgtmkZ0TRWtaisUD5/GU
         oG4STG9oIQl0HCwtPEWpbCYTuzflRZ916j4Izx+MRLRyFxDaokBrmZP5Nod/J2U+VbI8
         05cuNrLrV3G1nqFvKWakcvUvWOypCUL+G07bG+elFB5ZJ80xguEVpdGvRv4OHfHNoVQ+
         UeBKjeGKdqU5jBp2SZvm+9bs8+9CNyoG41fLoLRK/P2kOJ72QbZNNmaDGtwylyHxZcNb
         S3RX/z3/eEQ6sVQ0Z/Tcdj4J569dH28eLlyf7oFvyFDdhnc2zDXFX6nrFeBjjth6ptlI
         EX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhfpcQvRyLbcrTp/kXyOp93AQzKLRCL6FGXAmgALmAs=;
        b=2/pUyjfIJKaEezFfCpvJxNgAd6GqTyQsxp8ZcOY20xtcYyYbLICEGnIgWzyXGJM5YD
         L53xyXQqZhLddrdixRuGhjOUgIGZMOOY6oFpHMolYNSuHX4rIojO84Oz+Ccm9Vm74isd
         IUL1RJjU2VSuJjv655kj2Ns0gV7jNvkpKt4fzbuTXCKGSYo4fvR9IWYV+fp02BlwGpSS
         yT3Oxw5/0nBWBeybixs1VUGF4qBUVM1MqvkB/CqwOb5mjn4IjWL0hYgbb9W30b88yTrs
         tavwTFjv3Gzl3V85LEdgfgNDY7zY1zMiv2XdrBiSp/Pbo3+GOlZI9kasU2in5hyMhCiF
         5mcw==
X-Gm-Message-State: AOAM533ekpO8GNUC/GSLM3tWfIFzj+iHF1ZKEqFKmGeI2gFXkIJPTDOk
        +s0sdUHBvh+FMlzZ6NfgoAkUoUJMHAtF/100kpc=
X-Google-Smtp-Source: ABdhPJzAFnCDeY6Dx2o/+6Wh4mQrUfyXJOg971RnasoqwpXlCSCtLwvEs/wIYtcgBEPJKeu6SdHbi0a0GK2fmv4Cf9c=
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr26824486ejh.77.1651062897611; Wed, 27
 Apr 2022 05:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com> <20220420211105.14654-6-jagathjog1996@gmail.com>
In-Reply-To: <20220420211105.14654-6-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 14:34:21 +0200
Message-ID: <CAHp75Ve8mruPEyorSmydAHM27rnL9Wv+qNdWyQ9tVxz-+JJYiQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] iio: accel: bma400: Add separate channel for step counter
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added channel for step counter which can be enable or disable
> through the sysfs interface.

...

> +static int bma400_enable_steps(struct bma400_data *data, int val)
> +{
> +       int ret;
> +
> +       if (data->steps_enabled == val)
> +               return 0;
> +
> +       ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> +                                BMA400_STEP_INT_MSK,
> +                                FIELD_PREP(BMA400_STEP_INT_MSK, !!val));

> +       data->steps_enabled = val;

This will update the value even if we got an error and actual device
state is unknown here. Does this make sense?

> +       return ret;
> +}

...

I perhaps missed why kmalloc() is needed now. Any pointers to the discussion?

-- 
With Best Regards,
Andy Shevchenko
