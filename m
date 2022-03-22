Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70254E3C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiCVKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiCVKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:39:26 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D4919294;
        Tue, 22 Mar 2022 03:37:59 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y4so18538614vsd.11;
        Tue, 22 Mar 2022 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=A8Uwl5R9FFhyS86G5PyV/+OCLLYlqbgHEjOZGBcExKg=;
        b=THgrE5uqHYUftr0rIVpMCDI3nJyG9ASl9fqWURbpF4ljru1ObqwKEASBFjIfwRL4jb
         ibo83ukpDUhcM1wXLObYxw/DKH0YggtwvueERPXiluejhpnLgz/zlWFI1e/ZBgLlInlQ
         BSA7Uj6kfM1zfd0mjnQ2v5YVwJJp2kFrMC4Fo437YxZlbJ0fU/ea4onz/Se7kkBLcAFu
         9eLGReIr1uzNJk8Cyu4zVMxhfHAFaZN1Y5JGxBNpa/h3yQb61cpilkvBVrFM9CIoU4J/
         QU8jutKgLFC6jXxR4pixEpyWFfEkDJ4y9f8yyqMIhtZoDxg/ddRIzRIfosIz6Nvhobun
         PTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=A8Uwl5R9FFhyS86G5PyV/+OCLLYlqbgHEjOZGBcExKg=;
        b=zzHl0IBrrMphWQfWNB5IGTlp7drWpKo3/lXWE9/Nvy7xIN68JDrH/aVaqXQVG3XsMU
         2l/45FAqGVPuyprFyaQA3hKOjsCnwKSMiGM8a7L2fjNqiUFh1xl7MyZbR4rH8v4zVB1m
         mK7NdxiSqkSd5k5r/hcMogY9eExMTvJnxLP06xo42qCMcRu04cNwiOv5pkQ7ZCYOC3tc
         kWIz+z+CzQzD38O5d/1qcs/2h/r13dJqIgXAT2dfto9HGPu5er1qLfYsMjYpZ0njHBGb
         q3TMv7TpjimbwBzUG8/2SyWezXqwm89v3XkNcEpfEf2UUpHEnWmjcH0j+lNvfP7gcBBt
         9c2g==
X-Gm-Message-State: AOAM530ddrLTU4VDjffYb9/vTx+w05vJzL29on1+4W/srNk2/SrfU9j/
        hd7tWtd+JosUFCw6NnzeJ2qQc0OkT6VM00tGJSwVbQ/0I/d0Fw==
X-Google-Smtp-Source: ABdhPJzZDF9Lie8DORask+I9MnvoyLtQOR+yWRQ+SP4r5kBdT53viKN/6zUUyRt7PCs0/J8jU9dPUkET5am1U6aOqxU=
X-Received: by 2002:a05:6102:284a:b0:31e:c455:5dee with SMTP id
 az10-20020a056102284a00b0031ec4555deemr8594948vsb.27.1647945478537; Tue, 22
 Mar 2022 03:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-12-andrea.merello@gmail.com> <CAHp75VcbkZV0ek6C-YKb3iuZKyQGp7U48j-hQ+UqXFuGEYgZ4Q@mail.gmail.com>
In-Reply-To: <CAHp75VcbkZV0ek6C-YKb3iuZKyQGp7U48j-hQ+UqXFuGEYgZ4Q@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 22 Mar 2022 11:37:47 +0100
Message-ID: <CAN8YU5Pc6nto5pYgorrM4RHcn-EQXfyV+=V6ig4boG7cqBTznA@mail.gmail.com>
Subject: Re: [v3 11/13] iio: imu: add BNO055 serdev driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

Some inline comments, OK for the rest.

Il giorno lun 21 feb 2022 alle ore 21:28 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Thu, Feb 17, 2022 at 5:27 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> >
> > This path adds a serdev driver for communicating to a BNO055 IMU via
> > serial bus, and it enables the BNO055 core driver to work in this
> > scenario.

[...]

> > +       /**
> > +        * enum cmd_status - represent the status of a command sent to the HW.
> > +        * @STATUS_OK:   The command executed successfully.
> > +        * @STATUS_FAIL: The command failed: HW responded with an error.
> > +        * @STATUS_CRIT: The command failed: the serial communication failed.
> > +        */
> > +       enum {
> > +               STATUS_OK = 0,
> > +               STATUS_FAIL = 1,
> > +               STATUS_CRIT = -1
>
> + Comma and sort them by value?
> For the second part is an additional question, why negative?

For STATUS_CRIT, being a (bad) error, a negative value seemed
appropriate to me. STATUS_OK is zero as usual, but maybe STATUS_FAIL
should be negative also? It is some legal protocol status (unlike the
STATUS_CRIT mess), in this sense I may consider it not an error, but
still our command failed (because the IMU politely didn't accept it),
so it's an error in this sense...

I may just let all of them implicit if you prefer.

[...]

> > +       while (1) {
> > +               ret = bno055_sl_send_chunk(priv, hdr + i * 2, 2);
> > +               if (ret)
> > +                       goto fail;
> > +
> > +               if (i++ == 1)
> > +                       break;
> > +               usleep_range(2000, 3000);
> > +       }
>
> The infinite loops are hard to read and understand.
> Can you convert it to the regular while or for one?
>
> Also, this looks like a repetition of something (however it seems that
> it's two sequencial packets to send).

Maybe it's worth to unroll then?

> ...
>
> > +       const int retry_max = 5;
> > +       int retry = retry_max;
>
> > +       while (retry--) {
>
> Instead simply use
>
> unsigned int retries = 5;
>
> do {
>   ...
> } while (--retries);
>
> which is much better to understand.

OK, but still have the const var for the max (see below)

> ...
>
> > +               if (retry != (retry_max - 1))
> > +                       dev_dbg(&priv->serdev->dev, "cmd retry: %d",
> > +                               retry_max - retry);
>
> This is an invariant to the loop.

why? This triggers at all retries, not at the first attempt i.e. it
prints only if this doesn't succeed at the first time. Indeed what
seems wrong to me is that you need -1 also in the dev_dbg() argument
to produce correct text.

[...]

>
> > +       reg_addr = ((u8 *)reg)[0];
>
> This looks ugly.
> Can't you supply the data struct pointer instead of void pointer?

I confirm that it's ugly :)

Not sure about what you exactly meant, sorry; what I can do is to
introduce a local and split this ugly loc, as done in
bno055_sl_write_reg(). Is this what you are suggesting?

> ...
>
> > +       if (serdev_device_set_baudrate(serdev, 115200) != 115200) {
>
> Is it limitation / requirement by the hardware? Otherwise it should
> come from DT / ACPI.

 It's a requirement. Not sure it's really by the HW; possibly it's
statically set in device firmware.

> ...
>
> > +       ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
>
> Ditto.

Ditto :)

[...]
