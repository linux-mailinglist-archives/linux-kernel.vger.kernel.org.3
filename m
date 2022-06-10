Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6254687D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiFJOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiFJOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:37:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04FF1FCE7;
        Fri, 10 Jun 2022 07:37:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id v1so43176803ejg.13;
        Fri, 10 Jun 2022 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyCd7hBSL9GiEfMM7xgKz0XL3YQAl24XQwd7lRWBYUQ=;
        b=RZiqXB8w47FlzcjDL0OseLBYQPSrZJVy1WC/I0f1PTxVTjduz2Udq4JpxOs0DDYTxk
         DVe3lcRUPcioBmos3p0VOFkXpUvoLUYMZrrpeqbqNecxsRtTmgMUmXilGCGDt7de5OXJ
         U71OHgZUn0R+uNHNpapEDo12/8HN9pZqoKm4oLzE5JbIjatgglCxN92hFq4eQZ7De4X1
         TT3/GBsVIIQbCZzw3dk4o+uOXXRbafFAnqrOnfkNQt5A+xXGBtWiGl7pMpPQYgxzPIuu
         +1wwR3Afp/VVb3NnFbQzxvMGNKRnHwRLaUqM9+P/gmx1MqU3cRAZ6L4yn35bvuXa8pS8
         t+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyCd7hBSL9GiEfMM7xgKz0XL3YQAl24XQwd7lRWBYUQ=;
        b=A78/hX9M5f3WqNKPJdQFLhqM1x+fne8FLY3k+iWSr8wJEzznpcFAC6n1amR+G2cPHZ
         /3f+k67ztjS3stVQmXvSWfToPnSK5mGbgBETwjnsVq6vleM7qxz8Q75pWC7pMh0Opppg
         aOSsghpeRr0c87yrIaeI73JyUvr1i0TYcrvFYIp4fNeulhw21y72WgkJkyK1m/Plfsdk
         GBSAOCbmdNXtH71IQsXFLcBJYBNeBXHIYgM9g/YwCcz1wzZbRZlhUZ5swHHh77OElnll
         jF/y3cH5rejYfePzlUxP7oxAchIKkIxdIJzUpfM9Y2hg0i/Y3cR6EcdgfI5yrMf+tA1R
         JjAw==
X-Gm-Message-State: AOAM531MtNMYhIVIZDYzIhOcIUAR1BQjvBa2ISrMNwkteNkhSDAziYKa
        gyPGs1ICj96OexKAIqn08dytD4yM7dHui7aDqSM=
X-Google-Smtp-Source: ABdhPJzXGPWQA4QyVCdpM5F6irbGbT5WJfAeFIA7jnWGBCqYHm9i5nTZdRnTZGayVQz5zeeckZAnd/uNVPDM0LTGr9M=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr40247496ejc.579.1654871862288; Fri, 10
 Jun 2022 07:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220610053012.27279-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220610053012.27279-1-xiaohuizhang@ruc.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:37:05 +0200
Message-ID: <CAHp75Vd6y7RJcwi_Egyb5guJ3i+FJHD-_pdeOmq4LC7xBmhnPg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio:proximity:sx9360: Fix hardware gain read/write
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Fri, Jun 10, 2022 at 7:53 AM Xiaohui Zhang <xiaohuizhang@ruc.edu.cn> wrote:
>
> Similar to the handling of read/write in commit 108e4d4de2b5
> ("iio:proximity:sx9324: Fix hardware gain read/write"), we thought
> a patch might be needed here as well.
>
> There are four possible gain values according to 'sx9360_gain_vals[]':
>
>         1, 2, 4, and 8
>
> The values are off by one when writing and reading the register. The
> bits should be set according to this equation:
>
>         ilog2(<gain>) + 1
>
> so that a gain of 8 is 0x4 in the register field and a gain of 4 is 0x3
> in the register field, etc. Note that a gain of 0 is reserved per the
> datasheet. The default gain (SX9360_REG_PROX_CTRL0_GAIN_1) is also
> wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
> reserved bit 7.
>
> Fix this all up to properly handle the hardware gain and return errors
> for invalid settings.

...

> +       regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
> +       if (regval)
> +               regval--;
> +       else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
> +                regval > SX9360_REG_PROX_CTRL0_GAIN_8)

else?! Isn't it a dead code? How has it been tested?

> +               return -EINVAL;

> +       *val = 1 << regval;

Even in the original code this is wrong in accordance with C standard.
It might have potentially UB. BIT(), for example, solves this issue.
You may do what it does under the hood.

-- 
With Best Regards,
Andy Shevchenko
