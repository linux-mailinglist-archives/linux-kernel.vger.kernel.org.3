Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E54E8A71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiC0WS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0WS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:18:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27314EF41;
        Sun, 27 Mar 2022 15:16:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u26so14935969eda.12;
        Sun, 27 Mar 2022 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YqXAKsRg5NB+t2/EKrR18CcSxKRanJcc5WsAI2eJ+c=;
        b=KHQSM9EtyCnVj/5hAoKqe+N0taL8HPZRXGxFKZSxmDxyh8ZnvNQHPM8F2R9jbP1H1Y
         n9tdxfkj+UldMkZ/oqC9qNSPjJX9WA8mFsNRA2c8hvuMHZl/eqhQUQwkmUZlo7KkhJy+
         2Yjwawx6/uX67adhHg8z7VcIfv6Nb15+HH02vUYEfCA36W/f2MviL/7GInQt0Llp6DDb
         ifoktV8tjJsHH4Gs+KG2u8M2pJGDp5lORY0JzUBRTLrhF5pDgFvZiYwZD5bipKBroZiw
         LWMfNMIP99eENLDQHRXKGVvX7NWQLrBf9/A6zmtZ48Jy1c4yN0JrW/fjQrBVXaSAsQPG
         nLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YqXAKsRg5NB+t2/EKrR18CcSxKRanJcc5WsAI2eJ+c=;
        b=dgkNR4Tl7xciL77r/ihk+k1vMQJHrWIU2+088uQJsdURYpUdjkvYDT5gdb3us1RlWX
         RJOm6dymw8+b/cLmEByxGSLdE8TKLe3rHJaZhYyAYQye4sDq5Ff/ybVjbUYWTUJcv3xo
         /C9NYUEAd6Vn2FF08KcAVPqEnvvpseMJNe11UvrLoVyiyco2oOFzzNhVzJXMLYAz6ry9
         b/zIpp+9zkywjvqanEP5Za9YUSjkfgyeUWvVp/v9AQIDgDAbtpckiY31RoceY5KZW90t
         r5gr4HB/Y9f4kkgOpWI493vyMUlO9cnYfSz27fNGoVVXQuFdhefLc+/RHcb+lgCeM3hw
         5G2g==
X-Gm-Message-State: AOAM531SuU9+eJRlUBXZLsFYRLpfCePfW6ykHjulEMo34watBd9dtPW1
        f5yKktOZnh3dW+87M4N+sU6BTBk1Sv8smmxAk3hWEOUyhJs=
X-Google-Smtp-Source: ABdhPJxiw+SGdXidWk7bAM3x5T6Bu4MVtCnAYoiQmq/+gTmPbRn7lYtP2eNXnFcu7EYEsc+FzoDTBfDTArIYTctFjQM=
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id
 c17-20020a05640227d100b004191b024a04mr12436901ede.218.1648419406297; Sun, 27
 Mar 2022 15:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220318204808.3404542-1-swboyd@chromium.org>
In-Reply-To: <20220318204808.3404542-1-swboyd@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Mar 2022 01:16:10 +0300
Message-ID: <CAHp75Ve+SiiAM6VkiwPt95w68KEDk46vXR6ZzjOR7ZgaeZ80HA@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Fix hardware gain read/write
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
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

On Sat, Mar 19, 2022 at 5:58 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There are four possible gain values according to sx9324_gain_vals[]: 1,
> 2, 4, and 8. When writing and reading the register the values are off by
> one. The bits should be set according to this equation:
>
>         ilog2(<gain>) + 1
>
> so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> in the register field, etc. Fix up the functions.

...

> +       *val = 1 << regval;

I see it's similar in the original code, but this is still problematic
from C standard point of view, i.e. if regval = 31, the C standard
calls it UB (Undefined Behaviour).

-- 
With Best Regards,
Andy Shevchenko
