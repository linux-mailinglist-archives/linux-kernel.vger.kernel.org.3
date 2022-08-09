Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBA58D69D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiHIJke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiHIJkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:40:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC3108D;
        Tue,  9 Aug 2022 02:40:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so2831442qtu.2;
        Tue, 09 Aug 2022 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=13gZ9Mf5RvWypABlt58TTnGhakk4LYMYk1XGCyVkqlk=;
        b=iA2CDbJ7gAw1Gae5y9ub7vzKUQqYazw0kpXgsJh24IQWG9+4To7IyPkLqxP3FnTVHo
         mFCrhzgf0li/LpWqo5s1JKmSJnWVxyBzvzKH3GZG/IitzdDUV36LrQN6p7a1ZQANovsz
         TNodTTLbJHZsKV3zT8jyHzgq3Bg55061g4iOXrj0xEs1wWDeoRKPM4MBBWHb623Saa+f
         ZsYQ8vgM1+r+SX6lxBEMWdhooFwtrvASRm5QCNp1f2+J+Ag43zf4RMQR8/d9TWBgZGAC
         Yzrr/TyA/+21UR2gfmcLZW34jx8xaWG671+zUgxrWx2aRwHQqY/drmJ8bowDD4j7Uaa1
         siQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=13gZ9Mf5RvWypABlt58TTnGhakk4LYMYk1XGCyVkqlk=;
        b=xuSRhxhp5cM1hJ8s9djWf5b0PYJ2XVnuN61Sw0ly48c1HboNqsy+ZOQtX4uVgRjNmg
         VGJf2aMBdz0/BU333BdDcxUc41ddEtbLcwInRuJR5GPI4hYsgwawICgdZeG2qLrOqNPd
         ivUv0czHBRlJ7qriVbF23WQx4yOiWmvbzNLnXHts73kJ0LE20hxUkBw6f6JiApuNj2rg
         ChQezFKIT1Dj9f4l/LHmn0p0cOFGxShl/i7jDMvH5OPWq2EkoDuTIfbeP/p/ygFpqnMF
         Lab8l0kFtpr29RPgqOkvEwnRS872ZzVV+lcxqR1AcwE08xvKEc3XtIE3qWk3PnhZSVBA
         vWtg==
X-Gm-Message-State: ACgBeo37pd4DSrkVP/L6xZP0450PjyEevAWNX1CSPjyPHnxfbj9llE0F
        PxuvL0W+LSqd0DQOwkmY64jamC2D+G2SUGUcr10=
X-Google-Smtp-Source: AA6agR7fxKuQxdyQ/VhFQtXYM3r/jBAY2fxH0L4/R2MIx+u7pw9VvZxYi5GkgaDvFzh/VwSAoEj2VE/3QvO1k5PWa84=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr13553601qtj.384.1660038029553; Tue, 09
 Aug 2022 02:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220809073648.167821-1-marcus.folkesson@gmail.com> <20220809073648.167821-5-marcus.folkesson@gmail.com>
In-Reply-To: <20220809073648.167821-5-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:39:53 +0200
Message-ID: <CAHp75Vc-cd_-+qyd62tcJGdXh917AgZY5VB0ztXR3zwrGoMCRQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] iio: adc: mcp3911: use resource-managed version of iio_device_register
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
>
> Keep using managed resources as much as possible.

...

> +static void mcp3911_cleanup_clock(void *_adc)
> +{
> +       struct mcp3911 *adc = _adc;
> +       clk_disable_unprepare(adc->clki);
> +}

You may rather switch to devm_clk_get_enabled() and drop this.

...

>                         dev_err(&adc->spi->dev,
>                                 "failed to get adc clk (%ld)\n",
>                                 PTR_ERR(adc->clki));
> -                       ret = PTR_ERR(adc->clki);
> -                       goto reg_disable;
> +                       return PTR_ERR(adc->clki);
>                 }
>         } else {
>                 ret = clk_prepare_enable(adc->clki);
>                 if (ret < 0) {
>                         dev_err(&adc->spi->dev,
>                                 "Failed to enable clki: %d\n", ret);
> -                       goto reg_disable;
> +                       return ret;
>                 }
> +
> +               ret = devm_add_action_or_reset(&spi->dev,
> +                               mcp3911_cleanup_clock, adc);
> +               if (ret)
> +                       return ret;
>         }

As per above.

-- 
With Best Regards,
Andy Shevchenko
