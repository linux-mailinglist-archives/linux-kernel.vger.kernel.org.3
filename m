Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312085647C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiGCOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiGCOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:15:14 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03765D4;
        Sun,  3 Jul 2022 07:14:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-317a66d62dfso61118307b3.7;
        Sun, 03 Jul 2022 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0FH56a+Shs/91/PsN1Ki0zVCm9WciZlIf0/Nr3AfS0=;
        b=XMl/KiO1rtvigAKy+uGtMZz328eE5t9CxIohDrLEz+CizJcfX4PXtfjO9/16ZPfvPH
         9CzZwHmT9FvVY2dJpoFqv+tWQumT9hn3s3xHXxjFaYMF1mSOYEcGgkClLcUU1s1CVv6+
         q634F9c9vSZf1jJLxwR0SVVLmAu6ykIkijZfx67sFw5EJC0KyK/ys0LqvqG3kudgqa5Q
         GibTEEUGgj30W5EAIwcd0uHp4A8nxqzGLyYUbKvKlntWfo/8g6G3SQn7Q1yFN5KblxPA
         X7w6mJNVobAa2aShzoOpn9ueRBEqQo3NdxArVnqTNPfvdtJIsryQloBy4xxkr9nYw43D
         9MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0FH56a+Shs/91/PsN1Ki0zVCm9WciZlIf0/Nr3AfS0=;
        b=lkeDB4hc9EerIcZ8nmzSKzAk074ed7krkjnYw8xuYGQQHIQC/p2ahOIx9OsnYZ6Eq8
         Z5/up/efkmfDRvAAL/47XW9aXy/Zn8yV7aYaNDWmPEohTPrSXTIbdO+YH0sKYn+o+bOg
         MwMSqrxU0NdnhoqRLWiT3g5W/UST/YAjmbnRbRnFqDwGJ9HtL5wXmB2KJkypr3mHRjLQ
         dVE20f1JTKsvv5gu8n6iZ16XAFOrL0hRR6WNmjLBI/Z6sNVDFWZeCXtlcvVg/NRpVEJg
         a/oe8XYitSTfsQzpbqLyMu8jYrXrSDL36Og2ZbGI6EzQjtXVYKlzZmZWAzF0Dj9hnoln
         dh2g==
X-Gm-Message-State: AJIora+uFEd7bYg/JVOdJSUU0+o/U8MCJMsvRw24qT5eDbUKmuRC3lgv
        IxOx0RImScm/7CrqHNdaZvrLo+CNJ7NF62Jy6k5ScZd0qLYb5w==
X-Google-Smtp-Source: AGRyM1uf3eSmQXwBLhqdFaSKUHbaLEKa/Irc8krnHWk6gpxnyVII4Xysoy81SMPHJdlwUBlOzIQaZQtVEKJW6KDTmO8=
X-Received: by 2002:a81:6f02:0:b0:31b:dd95:1ccf with SMTP id
 k2-20020a816f02000000b0031bdd951ccfmr26982262ywc.520.1656857684481; Sun, 03
 Jul 2022 07:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com> <20220703111057.23246-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703111057.23246-3-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 16:14:07 +0200
Message-ID: <CAHp75VcshqBNtd7HFMR39Fh3mR=Uv0m4rznpFPDhix3hB0or7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: regmap: Support combined GPIO and pin control drivers
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Allow gpio-regmap to be used for the GPIO portion of a combined
> pin control and GPIO driver by setting the has_pinctrl flag. This
> flag will cause GPIO direction set ops to be implemented as calls
> to pinctrl_gpio_direction_input/output() instead of updating the
> direction set registers directly.
>
> Note that reg_dir_out/in_base is still required for implementing
> the GPIO chip's ->get_direction() callback.

...

> +       /*
> +        * we need a direction register for implementing ->get_direction
> +        * even if ->direction_input/output is handled by pin control
> +        */

/*
 * Multi-line comments go with this format
 * or style. Pay attention to the capitalization
 * and English grammar, e.g. period at the end of sentence(s).
 */

...

> +       if (config->has_pinctrl && !(config->reg_dir_in_base ||
> +                                    config->reg_dir_out_base))

Can you re-indent this either to be one line or put the second part of
the conditional onto the second line?

And why not use && everywhere?

> +               return ERR_PTR(-EINVAL);

-- 
With Best Regards,
Andy Shevchenko
