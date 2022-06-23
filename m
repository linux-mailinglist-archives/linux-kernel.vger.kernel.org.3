Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA7558919
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiFWTfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiFWTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:34:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFDA67E7A;
        Thu, 23 Jun 2022 12:16:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t24so645518lfr.4;
        Thu, 23 Jun 2022 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRoo8gwukGSsHOsbRrXr9T/EZLikeGS+5uPgeGWMFmY=;
        b=ST8X3DX1V4jN7py9xmmJbgHpdlBUOunm1IpWgc8EDD+21t2KOvL1AbFEvpx3KTG/HU
         fvCU47npbo864gJ2mAHOCTgn3Sq/MSzoPTqZh7ffYwZGVqSPq2hQKl2VDd4l+2lbhbiN
         afKv8O17+ALKX/JnZHgUsRD2GSb5Qa0rEc8bGZ663yewBzXbo8I/fdKhmkBipgQJJ+Kt
         k7YkLI6mVlz43u8wpg3G1yqT4ZMjKPrt+4oxM5IRaxQfHh6PNQWik/PSywtNkfAWQ/qY
         l/LAo2VqSPLJMO7qjswmXMiWkaGUdkZGhhsbReU5IOtCKOGD4c9VdlRWFJ8nTrKzpS7i
         RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRoo8gwukGSsHOsbRrXr9T/EZLikeGS+5uPgeGWMFmY=;
        b=hDY4NyxDY3Vz2SuB9ae1seVvVKzuuXScJYFhcsHw48N45tZL5OyiqV1bPuzYV7aPZm
         tQmZopJV1q9coadSVXLxK0CSQdY60MGZMo0JXuVeuHF/hw0/h4DYu4tuorbI8P44LK+J
         BqGiEDQxhYKGV5ja+GDiVX0DyFhaIN9+4sFISSPF5DMOMo6Oj2wVd+B+gB+DfC+0UU1F
         6QaoMnv8rPr8NWpikVFHNDU7121cSgrEi6lClPkktntZmvmIHb9Nd6MC5yejfSYlzcVd
         /xD0QpC9x84Y8wI0kzIteRiiPyx8ODsKH8s5EACkr/F/4Rt6yFz7By6u338uO5pfUEbt
         pAGA==
X-Gm-Message-State: AJIora9uFyjTUsSNxkmSGjo280NPTJOULmCdm/hZ8klycPeRmCL46wHx
        y7GixWmWiZPoke1/T60FYGe9GPmqJ9LyPey6e/U=
X-Google-Smtp-Source: AGRyM1sMrZfy8H6ui6CHsvGYbX7zEbqSrILUBfkOGZnMQ6pGuJoonGzKSDkBggS72kyQnnVsOb4hcs8ihF4IsdRO9Wc=
X-Received: by 2002:a05:6512:ea5:b0:47f:785c:7031 with SMTP id
 bi37-20020a0565120ea500b0047f785c7031mr6549249lfb.35.1656011787996; Thu, 23
 Jun 2022 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-10-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-10-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 21:15:51 +0200
Message-ID: <CAHp75Vf7=Pk7T8ysrFS9u1sKQXUpqczGJkaeX-MLbwpx-iM2rg@mail.gmail.com>
Subject: Re: [PATCH 10/10] iio: adc: mcp3911: add support to set PGA
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

On Thu, Jun 23, 2022 at 7:41 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Add support for setting the Programmable Gain Amplifiers by adjust the
> scale value.

...

> +       int ret = mcp3911_read(adc, MCP3911_REG_GAIN, val, 1);
> +
> +       if (ret)
> +               return ret;

Please split the assignment.

  int ret;

  ret = ...
  if (ret)


...

> +       *val >>= channel * 3;
> +       *val &= 0x07;

GENMASK() ?

> +       *val = (1 << *val);

Unneeded parentheses, perhaps BIT()?

...

> +                               ret = mcp3911_update(adc, MCP3911_REG_GAIN,
> +                                               MCP3911_GAIN_MASK(channel->channel),
> +                                               MCP3911_GAIN_VAL(channel->channel,
> +                                                       i), 1);

This is not good indentation, at least i), should be on the previous line.

...

> +static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> +{
> +       u32 ref = MCP3911_INT_VREF_MV;
> +       u32 div;

> +       int ret = 0;

Useless assignment.

> +       int tmp0, tmp1;
> +       s64 tmp2;
> +
> +       if (adc->vref) {
> +               ret = regulator_get_voltage(adc->vref);
> +               if (ret < 0) {
> +                       dev_err(&adc->spi->dev,
> +                               "failed to get vref voltage: %d\n",
> +                              ret);

> +                       goto out;

Return directly.

> +               }
> +
> +               ref = ret / 1000;
> +       }
> +
> +       /*
> +        * For 24bit Conversion
> +        * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> +        * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> +        */
> +
> +       /* ref = Reference voltage
> +        * div = (2^23 * 1.5 * gain) = 12582912 * gain
> +        */
> +       for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> +               div = 12582912 * BIT(i);
> +               tmp2 = div_s64((s64)ref * 1000000000LL, div);
> +               tmp1 = div;
> +               tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
> +
> +               mcp3911_scale_table[i][0] = 0;
> +               mcp3911_scale_table[i][1] = tmp1;
> +       }

> +out:

The useless label.

> +       return ret;

return 0;

> +}

-- 
With Best Regards,
Andy Shevchenko
