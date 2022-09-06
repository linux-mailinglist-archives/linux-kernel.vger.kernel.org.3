Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438785AE69A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiIFL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiIFL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:29:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2D767D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:29:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q21so7062492edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zJsAbZ/AKQeQ4weLGmp9NwiMeQJfb78eam6V/+FnVYY=;
        b=hBJzKow00M7omsY5l8rx/oyG5lSnqXPpiS+FRD2mIETLT7IIulTADi08ZhxkkFuwG6
         viLhlgZpTXlsGRt4fnHKJ7FkdVsOnY/JCjWZNl0+u7JyY+GWilo2U/6GwBupmXhuKL01
         NjXSfN35V2BIKf+mYIn+s44nlll6xXIZKj9khobr46DuW1Ln6C67ejc4zUOp0b4aY8Rr
         3Rw0dV85sbJA9cevPC0snEgGkI/+WpKcIlaETzpch+tUj2CDVx2SgodgulS2ZHVNFCB/
         MOqaYZ2+gCkEs7CqRaLJgnqCDBnrlTtk89fd0H+byG5PEZSw6f3tJsLxuURZ2Kz14JQU
         x4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zJsAbZ/AKQeQ4weLGmp9NwiMeQJfb78eam6V/+FnVYY=;
        b=1rIFmgIZBUriGcWOJHIaEVIg31N+hJgDegg5q/RuADaKrChZl/H13IK6uulYx7/Yh1
         KazSO2EhSbMl1s566LqR55Vt/655J6cqAPVZSS0jJ5sFQ0Hl/HJC2Y/JXtFC7WwY4AE0
         oyLqZR9I+tRtH1gJtEXlFfIU92D+ebQn1vaG6hlygFvo+zsDkTbcr/bYHSMalYte76pd
         2m7VP9chuMQuSgUweMaUbjZkFyuXgtqq5PSzNV8tbLiEDKSqDcEEFqJ6sSVq6wN8n52q
         j0hn1h177yoEOPH/5rX7yX2aw2Uz+E/CJ3Mp5oaQlLBFopfNYV4mCqUTMveNOFWVR2Wk
         PwDQ==
X-Gm-Message-State: ACgBeo2P8Qbem1UpSPdhwQt09d6OgyLVLHnUt6igrQ4QQL8p+jV0MyI8
        xmw/IyZvVxeoMducmmqlHgMpipK1u8yP6CTh04joXw==
X-Google-Smtp-Source: AA6agR7Ok6ZUdyxV/KYBIT2cMmvQ/X8wHDApVUtfTjcaRRjUfQx3FJxPHPBP52nqOraNKAVYxsoFQptGhpxKejPYmLg=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr11345627edr.32.1662463772132; Tue, 06
 Sep 2022 04:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <YxbUO7WM0TbUBatv@google.com> <20220906101126.GA8061@francesco-nb.int.toradex.com>
In-Reply-To: <20220906101126.GA8061@francesco-nb.int.toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 13:29:21 +0200
Message-ID: <CACRpkdZU5vN6M31MN_EEQHpi+WfMOr4CTpkc7PD=AVvy_kb99A@mail.gmail.com>
Subject: Re: [PATCH] mfd: stmpe: switch to using gpiod API
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 12:11 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
> On Mon, Sep 05, 2022 at 10:01:47PM -0700, Dmitry Torokhov wrote:
> > This patch switches the driver away from legacy gpio/of_gpio API to
> > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > make private to gpiolib.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/mfd/stmpe.c | 36 +++++++++++++-----------------------
> >  1 file changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> > index 987e251d90ae..0c4f74197d3e 100644
> > --- a/drivers/mfd/stmpe.c
> > +++ b/drivers/mfd/stmpe.c
> > @@ -8,14 +8,13 @@
> >   */
> >
>
> <snip>
>
> > -     pdata->irq_gpio = of_get_named_gpio_flags(np, "irq-gpio", 0,
> <snip>
> > +     irq_gpio = devm_gpiod_get_optional(ci->dev, "irq", GPIOD_ASIS);
> isn't this changing from irq-gpio to irq-gpios property name?

The gpiolib core will automatically append and test the strings
*-gpios and *-gpio (in that order)

> in the DTS files we do have something like that:
>
>  irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;

This seems to be an orthogonal bug.

That flag in the last cell is invalid for a GPIO, the DT schema should
scream at you if you have one. GPIO flags are
GPIO_ACTIVE_LOW, GPIO_OPEN_DRAIN etc. That looks more
like an IRQ, and then the property should be irqs = <...>.

Yours,
Linus Walleij
