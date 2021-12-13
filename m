Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A462C4720AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhLMFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLMFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:45:53 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADB8C06173F;
        Sun, 12 Dec 2021 21:45:53 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 8so13978126pfo.4;
        Sun, 12 Dec 2021 21:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YxTqaHrb1WONr4bzbFg9s07xU3CclGU8fXdbhcxL4wY=;
        b=HrwQaPS9mX/xUntq2L4rPSLlfvXt8WxPbyDS1O81vEPuznXszRyVBMEpIQ4jUGYr+d
         n3hpK21TmtA97jBvAb9Ml9Samja179i6QsL8zq0chSGWstVYH2g2NlcXim+ROrJd31TB
         upHt1ukE/j5f24oq8kOyeTyw2ti7EkoCRfrpCwFq7qh04ZPK0nzWy3HaEu4wYtBTaxjU
         8B1dVPArY3cDt4LIWdIcPQG5SEXaMMw2f0bmsvIwh9R9chh2xCcM/5PKlnv4PfMY37gR
         BFcL3i7lfZG7UDnsT947ul+rwowo1kOwvqE+L1rPJdMFbUxeTC8pNtVpMPkoV4PwAg84
         SOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YxTqaHrb1WONr4bzbFg9s07xU3CclGU8fXdbhcxL4wY=;
        b=OPRHMk4w7yNq3yQv/snDtvhlFVlvLreWKw3oV1Y8XuKKoUrN2KLyDxFFKakudHXNoH
         zOgsOymWH/2fCKmZKvGQWmzzQpIDkLg6Mvv5R0nUTKA9zszSKfNY+yIFQg6hzzurIAdP
         A+FFdLkCRtfPFKB441Kr8BJ3N7uAsBRWQjqqdvuF7G0VFNHlP4oKW60tk4F8ujCqC/xe
         4sgXHhiqjAnbIpCqcwbrIgy/R+KHSOtVfBGQB4RiCU9hGYcPFtnp/r/um1XGI7Vc5Fq6
         tozdbA2G7VABIDMSO709T5cGoMd9vnFI8WUDXCksGxZhxjASURZ1ULCkskDG7doAPMm4
         CkYw==
X-Gm-Message-State: AOAM5309j8poMD/j88fCTkL/WVHjl/dGONg7btfxF7m/07obBEQyUr9o
        lc4wUuvml1DJL6VdnzKSjwc=
X-Google-Smtp-Source: ABdhPJxSAkGXd7eqoG11hnQsbGyVxpD1ryL7wjbnVUDsr9Yqg6avZ0fCzJ7Z0d4Br6GhMorxKY+8Vg==
X-Received: by 2002:aa7:93c4:0:b0:49f:a7f5:7f5a with SMTP id y4-20020aa793c4000000b0049fa7f57f5amr31796521pff.8.1639374353027;
        Sun, 12 Dec 2021 21:45:53 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e537:8856:7d40:7c6])
        by smtp.gmail.com with ESMTPSA id mq14sm5553657pjb.54.2021.12.12.21.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 21:45:51 -0800 (PST)
Date:   Sun, 12 Dec 2021 21:45:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mylene Josserand <mylene.josserand@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <YbbeDFJERtP0mAIQ@google.com>
References: <20211103114830.62711-1-alistair@alistair23.me>
 <20211103114830.62711-2-alistair@alistair23.me>
 <YYYk/uisKqPNgRu0@google.com>
 <CAKmqyKOFZOLpjMY+kj2CLibFhYJ3-tL+9+cKEVzgSn9Mzq30gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOFZOLpjMY+kj2CLibFhYJ3-tL+9+cKEVzgSn9Mzq30gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:27:46PM +1000, Alistair Francis wrote:
>  On Sat, Nov 6, 2021 at 4:47 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Wed, Nov 03, 2021 at 09:48:27PM +1000, Alistair Francis wrote:
> > > From: Mylčne Josserand <mylene.josserand@bootlin.com>
> > >
...
> > > +                            si->tch_hdr.max,
> > > +                            si->xy_mode + 3 + si->tch_hdr.ofs,
> > > +                            si->tch_hdr.bofs);
> > > +
> > > +     num_cur_tch = tch.hdr;
> > > +     if (num_cur_tch > max_tch) {
> > > +             dev_err(dev, "Num touch err detected (n=%d)\n", num_cur_tch);
> > > +             num_cur_tch = max_tch;
> > > +     }
> > > +
> > > +     if (num_cur_tch == 0 && ts->num_prv_rec == 0)
> > > +             return 0;
> > > +
> > > +     /* extract xy_data for all currently reported touches */
> > > +     if (num_cur_tch)
> > > +             cyttsp5_get_mt_touches(ts, &tch, num_cur_tch);
> > > +     else
> > > +             cyttsp5_mt_lift_all(ts);
> >
> > Not needed with INPUT_MT_DROP_UNUSED.
> 
> I tried INPUT_MT_DROP_UNUSED and I still need this function

I am curious why that is. Probably call to input_mt_sync_frame() was in
a wrong place?

...

> > > +
> > > +static int cyttsp5_deassert_int(struct cyttsp5 *ts)
> > > +{
> > > +     u16 size;
> > > +     u8 buf[2];
> > > +     int rc;
> > > +
> > > +     rc = regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, 2);
> > > +     if (rc < 0)
> > > +             return rc;
> > > +
> > > +     size = get_unaligned_le16(&buf[0]);
> > > +     if (size == 2 || size == 0)
> > > +             return 0;
> >
> > If you were to use level interrupts this probably would not be needed.
> 
> I have tried with/without this and I still can't get level interrupts working.

Does the platform support level interrupts?

...
> > > +static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> > > +                      const char *name)
> > > +{
> > > +     struct cyttsp5 *ts;
> > > +     struct cyttsp5_sysinfo *si;
> > > +     int rc = 0, i;
> > > +
> > > +     ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> > > +     if (!ts)
> > > +             return -ENOMEM;
> > > +
> > > +     /* Initialize device info */
> > > +     ts->regmap = regmap;
> > > +     ts->dev = dev;
> > > +     si = &ts->sysinfo;
> > > +     dev_set_drvdata(dev, ts);
> > > +
> > > +     /* Initialize mutexes and spinlocks */
> > > +     mutex_init(&ts->system_lock);
> > > +
> > > +     /* Initialize wait queue */
> > > +     init_waitqueue_head(&ts->wait_q);
> > > +
> > > +     /* Power up the device */
> > > +     ts->vdd = regulator_get(dev, "vdd");
> >
> > Do not mix managed an unmanaged resources. You are leaking this
> > regulator.
> 
> I'm not clear what I should do differently here.

devm_regulator_get().

> 
> >
> > > +     if (IS_ERR(ts->vdd)) {
> > > +             rc = PTR_ERR(ts->vdd);
> > > +             dev_set_drvdata(dev, NULL);
> > > +             kfree(ts);

You can't call kfree() for memory allocated with devm_kzalloc().

> > > +             return rc;
> > > +     }
> > > +
> > > +     rc = regulator_enable(ts->vdd);
> > > +     if (rc) {
> > > +             regulator_put(ts->vdd);
> > > +             dev_set_drvdata(dev, NULL);
> > > +             kfree(ts);
> > > +             return rc;
> > > +     }
> > > +
> > > +     /* Reset the gpio to be in a reset state */
> > > +     ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > > +     if (IS_ERR(ts->reset_gpio)) {
> > > +             rc = PTR_ERR(ts->reset_gpio);
> > > +             dev_err(dev, "Failed to request reset gpio, error %d\n", rc);
> > > +             return rc;
> > > +     }
> > > +     gpiod_set_value(ts->reset_gpio, 1);
> > > +
> > > +     /* Need a delay to have device up */
> > > +     msleep(20);
> > > +
> > > +     rc = devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
> > > +                                    IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >
> > Please do not override platform setup with hardcoded triggers. Also, it
> > is strongly recommended to use level interrupts for these peripherals.
> >
> > This is also likely unsafe if controller is not completely shut off and
> > is capable of generating interrupts given input device is not yet
> > allocated.
> 
> I have dropped the `IRQF_TRIGGER_FALLING |`
> 
> I have tried to use level interrupts, but I can't get the device
> working with them.

That is weird, does the interrupt controller support level interrupts?

Thanks.

-- 
Dmitry
