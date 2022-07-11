Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4C56D886
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGKIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiGKIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:42:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BA2182A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:42:19 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31caffa4a45so41848777b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbEeMhaMhMOIFE7vJDdeDc8ULQN4ZptBVrKw7X+VxQs=;
        b=ObFrz41RIzdXr5qaNWjyskEd6dnfwk81/aVaeIgneQ6+j1lxaCxsXaPxDZ1Y8pyeeI
         1dCH3tqKuqRAMzKr+HkTWWk4qLZ6/u+XfjaZrWvcRuMiOXGWBiBwjpXWBYYJcu1pCt/b
         5HYoYKInUcmpxUzwhQW3+tJrdVZzYox1JchV7Nz820Ve0vsgtabIFxfKIysBu9mo2b2s
         yGVAxhQlK+l44yEZENaSvle4e6JkQRjqqamD5RjANh+/3lhw0i+VhTufxOViRW0ScrrS
         LE94O+xTjaz09s4qCkz4f/g4hlWP8q28NVvZ0bsbvD2EJGIemUgNbfkzXFyuGlz/no+M
         WEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbEeMhaMhMOIFE7vJDdeDc8ULQN4ZptBVrKw7X+VxQs=;
        b=ALq0wQwFkDD9YcfoqMyklP24DR8k6W1+0yyZTHj3z9oFw3RBYRT0r3DqZXuhuyNKVa
         qDRsC4eKIV5RDPy0bodor44bvamm+RiQpdBI5uUuEksF5h9Wb3nmoaZsBxKrUfWnGxRb
         JwP6wmrzneyvJIhnVUhD5GGBvoSQJtLGR9YwmE9HIyfRQHtdnAemxJrEf+jmY8xH6moq
         yYdYavZZzSXhrw7FyQPV4sKY+9gbo+IhDy4WqWJ0ysJDrhwyyuE8aTVPs1bF00M3S4n1
         AYAqBWdQY7dxQFLVS5aTUXB7ZyLq3qUpZXIRlRNAZxXrel86oNncsoBKGIs/SGx9hUfw
         KZkw==
X-Gm-Message-State: AJIora/N85wAVUgYuEf+s2feeU2sh+0hDQu5ExqywcKGIj1ROD1Qb2OR
        D3uBEM3u7tFjoguQi876qPiAMCrbTtSXrQH4cFbEhA==
X-Google-Smtp-Source: AGRyM1tu+11jEpO9I0Zp/q1P64jol0ViZ8rD11nXo7P0I6A8tRWYlerraqnGejlpiHTPIxLEgh9vgYaErsEarPH8PiA=
X-Received: by 2002:a81:a8d:0:b0:31c:cb2f:c805 with SMTP id
 135-20020a810a8d000000b0031ccb2fc805mr19345536ywk.118.1657528938287; Mon, 11
 Jul 2022 01:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220704130602.12307-1-henning.schild@siemens.com> <20220704130602.12307-2-henning.schild@siemens.com>
In-Reply-To: <20220704130602.12307-2-henning.schild@siemens.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:42:07 +0200
Message-ID: <CACRpkdaZK+0r5VfyAzp-4wYkdANQ68pMnwZAobusnkZS1qaN8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nct6116d: add new driver for several Nuvoton
 super io chips
To:     Henning Schild <henning.schild@siemens.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Mon, Jul 4, 2022 at 3:06 PM Henning Schild
<henning.schild@siemens.com> wrote:

> This patch adds gpio support for several Nuvoton NCTXXX chips. These
> Super-I/O chips offer multiple functions of which several already have
> drivers in the kernel, i.e. hwmon and watchdog.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

(...)
>  drivers/gpio/Kconfig         |   9 +
(...)
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -457,6 +457,15 @@ config GPIO_MXS
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> +config GPIO_NCT6116D
> +       tristate "Nuvoton Super-I/O GPIO support"
> +       help
> +         This option enables support for GPIOs found on Nuvoton Super-I/O
> +         chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called gpio-nct6116d.
> +
>  config GPIO_OCTEON

This driver is put among the memory-mapped GPIO drivers
in Kconfig despite it is using port-mapped IO.

Move it to the right section with the other port-mapped IO
GPIO drivers that begins like this:

menu "Port-mapped I/O GPIO drivers"
        depends on X86 # Unconditional I/O space access


Yours,
Linus Walleij
