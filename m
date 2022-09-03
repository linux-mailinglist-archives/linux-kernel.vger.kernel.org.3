Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8735ABF30
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiICN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiICN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:59:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB655C95D;
        Sat,  3 Sep 2022 06:59:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p2so81975qvq.12;
        Sat, 03 Sep 2022 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iiL6z23t62qbAi4c25YcyuZvR6RVB1jjAlc6NDXVf3k=;
        b=ZYine8pU56VTmIXvbF5M45dL3VPSMZiDchpVrbwKqy2WHRq4DB8UYylvaFKv6GcGSZ
         HZm4+3hhIQU2tlDBfbVyq8QX4Eh1gwcV5K02rFuPKJ8fy9bP1C/Cm4Of8EG+d1pbcNSr
         aDWTkRgXSkdagG/KDtRuCTQHP4d/wDpiMgYTxjcVnugWkfGcEjwtLwIjnPQca9Tz1O3k
         gHW5RWVBtKa28D4PFJiKJ9NMex+8ivNqrz8+QaH+eO6QhlL61C1g95StQ9eEN8wPrRjV
         o4v7UU6oDw0BY+xTxX6NAizD/fOA6TpGxSWOQ+iwJUiqynZXjRbh1/ZUsCZiOBbbvcjG
         F2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iiL6z23t62qbAi4c25YcyuZvR6RVB1jjAlc6NDXVf3k=;
        b=ijIha94q/brndzbE9LvbEdavnPkodeJ3uyDYcZHWMJLfjjLlMOMmfH4M4yvpf30g3H
         j1UygFfmm+I2FW/1KImeBlCQMfRTraj6r6kHD/g0DdkGSQAkzrZFks4jRybtku1lhuRP
         6QDLDU/q+Mum/yEJzZCCY19e4EAMXkI9AvX7zY6AomEDbrwTX6H5ANmMgGoFucMmFv1U
         kVhhHRKyx/4znBR5NxfsJpWaXRVC7/li1q6WflLB4I1uuRk3u8vSXeRbDurg9jNW3A16
         vYPWbeNbkQicImc/ZyDGYurwHE+m+AC+WBKmQWmtlfedhLiuLfm0nEk+XLpeZZq/YcFj
         fFxg==
X-Gm-Message-State: ACgBeo05AsAl/tRwUww3Z5C7tJ4nBI5kQveZmeMq60yf5UdvhpiHEqz9
        vm0Y0dloXnIxl8y0KPHZOqZI1EjsVI4m27538LE=
X-Google-Smtp-Source: AA6agR4RbdHvNJ3iwQ7oeScf7KMGnkXTK1Z8x1HnTsRLtFjgKU/8oZ5xCFTkQUf4MVtgCv3Tsr911GJP08rsXSRaCbE=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr24017908qvb.82.1662213542328; Sat, 03
 Sep 2022 06:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com> <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
 <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
 <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com> <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com>
In-Reply-To: <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Sep 2022 16:58:25 +0300
Message-ID: <CAHp75Vcec-umx927+octdFDLHwNTmk7wm8iG6_6bR-fAW_wM2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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

On Sat, Sep 3, 2022 at 3:06 PM Crt Mori <cmo@melexis.com> wrote:
> On Fri, 2 Sept 2022 at 20:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Sep 2, 2022 at 8:59 PM Crt Mori <cmo@melexis.com> wrote:
> > > On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:

...


> > > > > +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> > > > > +               return mlx90632_pwr_set_sleep_step(data->regmap);
> > > >
> > > > > +       else
> > > >
> > > > Redundant.
> > > >
> > > No, the powermode changes among the type.
> >
> > Yes. 'else' keyword is always redundant in the
> >
> >   if (...)
> >     return / break / continue / goto
> >   else

> > cases.
> >
> In this case current power mode of the sensor is halt, so the else is
> needed to set it to continuous mode, which means I can't just remove
> the else here because this statement restores the power mode before
> this function was entered (and changed powermode for the setup).

What do you mean by all this? Read your code again and see what I'm
talking about...

> > > > > +               return mlx90632_pwr_continuous(data->regmap);

-- 
With Best Regards,
Andy Shevchenko
