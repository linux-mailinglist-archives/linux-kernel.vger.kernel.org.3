Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF254CD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiFOPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiFOPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:53:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A721D306;
        Wed, 15 Jun 2022 08:53:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fu3so24090072ejc.7;
        Wed, 15 Jun 2022 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDvK3aBrt95N9QEgQgB/5GPv5tA2EGWou9Hqc2Iu33o=;
        b=qiGjVR0XEyraV6oGuMUGSEIQLVYoV/LyV8Bfjnx+H1BSCzN4RJIdPI67r33glFbZO3
         jLet8kq9DZ8ic9339Wsx8huE6yMWk7a8nZqwAVEUZ8p4WeXFI5GdqdthPdhDzEtiqf7h
         2AexV5b9ntWXG3KnrLPw++rDTtTet0JhGK2X4C+hR5Ex54PgDevowDp5bmJKXMzT3UT5
         T8tC26xldPIRSih1J7OEs8kBD3MMe0FfiwT/D6OU4xVtQIW8tB015RsqnKmISfJjrYDP
         3M685qpT+1GYpIJRdWOJ1sn+IWniql3UaQOEMUBl3U30HgocaLNsI8XfCcumkr0A6dS1
         sCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDvK3aBrt95N9QEgQgB/5GPv5tA2EGWou9Hqc2Iu33o=;
        b=cfS6KAUhR7G06+vIrF8lygzCsoz6Wh0peklX9wpSFpqQv2LhAL56Gbula/TX2PlN72
         nkyp5o2UWcEoouWNo8zolNpI+lrn7UmFVg1PC9EIj8ezp1PEgAhIpsEFlsSk+0m4RoXD
         /PGW0VI0j8V0/I6lHXuroQrdI2nlA2ZP1VoqL8OtHgLLzf8A/Rij9kCHi6pFOnA+jyZG
         Gk10Rpo1zLz4RcdLBhbAUP2KaPvM5s/8SSdWz7xOb8gzj1HZPigGlTtZqizvez9kNFtU
         tnlvvMJgpIWKi0Zksk0Iy/CzK6pZnw7DHmzxdNXYRhgz2D5xplxi5D10C1Clrxxv2/Lv
         akPg==
X-Gm-Message-State: AJIora+EPqhYdvDxi43Q5LTzHmWrOw7eN96+P8cKT73bh6WqvRRgkbRy
        nV9R+qQ0aIW+xlwhG9HcuUyqYO/kHcwK0CxywZU=
X-Google-Smtp-Source: AGRyM1u11HA4kMYRmtww2DDb3KC8BU9ZciwZJOd0e+NaqGGtUl2P3dlnAif/o4EVMYlYy4x2+WmSLC6Euag/NRehkz4=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr437434ejm.636.1655308418875; Wed, 15
 Jun 2022 08:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220615154918.521687-1-jjhiblot@traphandler.com> <20220615154918.521687-2-jjhiblot@traphandler.com>
In-Reply-To: <20220615154918.521687-2-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 17:52:54 +0200
Message-ID: <CAHp75VfR+mpMp6Q+30dvB=-RMdpdk1V-xsMqCb7=6XW0aT6grQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] leds: class: simplify the implementation of devm_of_led_get()
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        johan+linaro@kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
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

On Wed, Jun 15, 2022 at 5:49 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Use the devm_add_action_or_reset() helper.

...

> @@ -20,8 +20,10 @@
>  #include <linux/timer.h>
>  #include <uapi/linux/uleds.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
>  #include "leds.h"
>
> +
>  static struct class *leds_class;
>
>  static ssize_t brightness_show(struct device *dev,

Stray changes.

...

> +       led_put((struct led_classdev *) cdev);

Casting from/to void * is redundant.

-- 
With Best Regards,
Andy Shevchenko
