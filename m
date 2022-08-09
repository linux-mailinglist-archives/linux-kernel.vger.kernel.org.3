Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5815B58D665
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbiHIJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiHIJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:23:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CBAB48E;
        Tue,  9 Aug 2022 02:23:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id i24so8228202qkg.13;
        Tue, 09 Aug 2022 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=f+fdEIR1AEiTFiMAXgcgg4D5Xs19jgAX17houym3UV4=;
        b=JK9r/P8zKiHlaVfCRdaWXmexAL4vdmpL7PrlLEtZiwxGGppGxVVO6Hukb5qigsqc6A
         gddP03pAB5VCIqBGkzqQBut7W6Ng5qWqcsEaGzL5CKC3LSF7BEaa3xTwY3wCSmVnpSVd
         6smtV5Wd8xmb2trZBRe/82gKTbS3/lYsYhiwWjSzFL2WKilDTsDN6IhQq/n8uD4p2szx
         urPtqK+argJj5tWti1qs20ZbWmBbaGZ3EmsbDD7fk0/0KTwaNmQ5YPIDkOhPw4byTcJ1
         EsmJNUH8/yDl2StB+qzJbjbQ6HUfKJvD983CdziZ5xnWqjz3AnMaDZb65ZQe+mXFQEPj
         TpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=f+fdEIR1AEiTFiMAXgcgg4D5Xs19jgAX17houym3UV4=;
        b=tUH9m3HGgco3jRvJWDu3bLIVGuTTsDHTlF3xJEz1CmmUWkSsUNezfWLb8ctMiZQ3Dp
         CdtZnfsEcnnBUdtgH4ig1xIp2t4QVBBj9abACUu6RttSUoExoguisk7JVu4EskbtaP3q
         iS22/G0WPomJrodS5t62dSVCiREvsOLzNIIUv3Swq+dSLp5QHHnjnn66v91Pum0X2pwC
         iLNR9Ekj9zUYGhHrmRr+ExOPgRrdM/TAux972rsyG3tvZLoRluvkSh9Gz2DaJeQbFZbp
         2QF4lS6NF5Z8WZhD7zISfUqPrUAeVp/+35t8MSEi+/n+gyQSGvyXLwU4muRRr/Gbmrsn
         9vRw==
X-Gm-Message-State: ACgBeo14exC7fBVHEJsoUpyGnMDnKZG7BnAWzDp3Brs2nCi6kR8etYAT
        fqGNH9tB66iXluiH2guMGMR46CfR0dkqwe75wwY=
X-Google-Smtp-Source: AA6agR7u2vIoLyFHu+Fwj6xhzyZ9kJaHV+/fIU8nRNkSYf3YSOl3Q/USv6mQgiMQnEk2V8iPpPm9hGfpqIqMGtzmtDU=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr17276480qkp.734.1660037012162; Tue, 09
 Aug 2022 02:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev> <20220809025054.1626339-3-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-3-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 11:22:55 +0200
Message-ID: <CAHp75VdrWMD7A2PJ-nPa0aLYZPqmgC7+pZ2SMDMtGWjHrx=xxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for changing the laptop keyboard LED modes. These
> are visible effects such as static, rainbow, pulsing, colour cycles.
>
> These sysfs attributes are added to asus-nb-wmi:
> - keyboard_rgb_save
> - keyboard_rgb_mode
> - keyboard_rgb_speed

...

> +What:          /sys/devices/platform/<platform>/keyboard_rgb_speed
> +Date:          Aug 2022
> +KernelVersion: 6.1
> +Contact:       "Luke Jones" <luke@ljones.dev>
> +Description:
> +               Set the speed of the selected RGB effect, the speed will not apply
> +               until the keyboard_rgb_save attribute is set (write-only):
> +                       * 0 - slow
> +                       * 1 - medium
> +                       * 2 - fast

> \ No newline at end of file

^^^

...

> +       u8 save;
> +       int err;

> +
> +       struct asus_wmi *asus = dev_get_drvdata(device);
> +       struct led_classdev *cdev = &asus->keyboard_rgb_led.dev.led_cdev;

No blank line in the definition block and try to keep "the longest
line first", a.k.a. reversed xmas tree ordering.

...

> +       u8 mode;
> +
> +       struct asus_wmi *asus = dev_get_drvdata(device);

Ditto.

I would really recommend you spending some time to read the existing
code (better recent one) and look for the common patterns.

...

> +       /* These are the known usable modes across all TUF/ROG */
> +       if (mode >= 12 || mode == 10)

The second condition was different in previous versions. Or am I
confused by another patch series?

> +         asus->keyboard_rgb_led.mode = 10;
> +       else
> +         asus->keyboard_rgb_led.mode = mode;

...

> +
> +

Single blank line is enough.

...

> -               struct mc_subled *mc_led_info = asus->keyboard_rgb_mode.subled_info;
> -               struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_mode.dev;
> +               struct mc_subled *mc_led_info = asus->keyboard_rgb_led.subled_info;
> +               struct led_classdev_mc *mc_cdev = &asus->keyboard_rgb_led.dev;

Not sure why this change happened...

> -               asus->keyboard_rgb_mode.save = 1;
> -               asus->keyboard_rgb_mode.mode = 0;
> -               asus->keyboard_rgb_mode.speed = 0xeb;
> +               asus->keyboard_rgb_led.save = 1;
> +               asus->keyboard_rgb_led.mode = 0;
> +               asus->keyboard_rgb_led.speed = 0xeb;

...and this.
Is it some kind of renaming? Can you split it to another patch if it
was initially like that?

-- 
With Best Regards,
Andy Shevchenko
