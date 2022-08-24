Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D42659FEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbiHXPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiHXPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:54:27 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511972EF0;
        Wed, 24 Aug 2022 08:54:26 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m2so5598954qvq.11;
        Wed, 24 Aug 2022 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JayAHS+OuNb+tyTryqcDsCuLA5dC38MXJtz38feqpuE=;
        b=mvsh0Cn0VLETNnxcOhwecAeKWzrUuHEJAjYg2OvijsY66ETjWMmCMPZ2KuXInqdkz1
         RB47XLKzF7x7ht1pCdHpZQjCcFv+2hPpcRBJy4bcat6lg0KZ9KrZ/0lthw9G+fPOCWFw
         EOL5Fgm9PdeZrUks6F/BLJLKxb4re6P9+oGJiak+gHiDc9ccWfvRFGVHXWzh5VNxO9+P
         zFSFJ6i3kj+YIP2kQLnaHI/T0rmQ5Cw69jqteao/Y2n6WQPrhsKi8/jKB4hzHkafF5Rq
         jn7UAyu3Usfog7HcngwlAHPVX6tne8iTvUtT1jux4E4LOEEe8isy98BVoK1++t3LxbH9
         RMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JayAHS+OuNb+tyTryqcDsCuLA5dC38MXJtz38feqpuE=;
        b=HHMduJoP39M9/1UNIx8JFC5BAX/B4cmHz3yKJsirFyQHsTLhj1PFXVqiY3aUrrV8oE
         NtT7JgBe0VXy7odcGx/KZYDKtqkeU42RYr+g49qh5SHL5nUmZFYAROPHmG7nu9QiKJHR
         9252mZr7pGeUocTMte4QwR4UgWlgoL66zm/JVIIfbCaLvsxUfGChm8MCkRjNXz0Tguns
         XItwdRh7hMREAMXsf/je4ZFt5roGsuy2LKmxuIJK3Z+dsK7Plca/RUiySO1Ag3UDoeO1
         SAUjFdlOyTkBhFmSnfWbJVJzznX2//KlHKWdM3H+EdIQo4OyGmO2Sl0A1j2yycOA7HRN
         3JZw==
X-Gm-Message-State: ACgBeo2I4T0Sc/cKGYIs6GFZhvNsQkqxv/uhNQPt4NOMbjiau0X4rZfC
        MmOdLiK5YBHxjwQrmZcMJsSVwRyxANR8oeBCNuMyNBbGwww=
X-Google-Smtp-Source: AA6agR4X852vOzlnPqLIyPLX+Wa320bennKiKmAkP/rIphXqC3Krc1SbPNgaPRmAkrChHfjiLzHb0QW6FsSP1ZucH9c=
X-Received: by 2002:a05:6214:29c2:b0:497:8b2:442 with SMTP id
 gh2-20020a05621429c200b0049708b20442mr6434328qvb.97.1661356465737; Wed, 24
 Aug 2022 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220824131428.31904-1-henning.schild@siemens.com>
In-Reply-To: <20220824131428.31904-1-henning.schild@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 18:53:49 +0300
Message-ID: <CAHp75Veu5CpRcmtvKwqhwqpjSgrvw03V6k7WrO8v=+cLhABcsA@mail.gmail.com>
Subject: Re: [PATCH v2] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
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

On Wed, Aug 24, 2022 at 4:27 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is not driver to provide that pin we will poll forever and also

not --> no

> create a lot of log messages.
>
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not we exit our probe function early and do not even

not, we

> bother registering the "leds-gpio". This method was chosen over "Kconfig
> depends" since this way we can add support for more devices and GPIO
> backends more easily without "depends"ing on all GPIO backends.

"depends":ing

The code is fine from my perspective,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
thanks!

> Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> index 4c9e663a90ba..0c96ba98e338 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
> @@ -57,6 +57,8 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
>         struct gpio_desc *gpiod;
>         int err;
>
> +       if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> +               return -ENODEV;
>         gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
>         simatic_leds_pdev = platform_device_register_resndata(NULL,
>                 "leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
