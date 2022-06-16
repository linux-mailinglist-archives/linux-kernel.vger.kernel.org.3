Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33F54E992
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378009AbiFPSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378008AbiFPSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:39:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47754194;
        Thu, 16 Jun 2022 11:39:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hj18so3757055ejb.0;
        Thu, 16 Jun 2022 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTMAYNOtiXLbIpfBfX/ZjoF2j1Xgqm6lvqAWKAijSCw=;
        b=nyIQTTIZFGabt6h84OUe/BFnlLSq7adaVeP4z1n5ObblUDxDNNljfgsiz3VCvV9ZkC
         U7xuxJiYskOlhs1ud2X1DPGZvY0xjIFn0sVTd0BZq35jlitXDUvG6OIh7QdQxEUbgMl/
         yF/djqpmpb4Y2V61qa4hNsSem8fawETTnv347nn+Xsl6BJEDc1HROOx7Zy0VgWMHlvPT
         6MpuGT7JqBe8jYSmhMsdkF8QOAqzUVq4WuLg6Zd5thSLGxOZfw0eOlXaAt6tw/RCB0NT
         aVuJY2k1FZN5T0U5k1LuvX8Vn3vXZLMKWU8pKp5GZ3Mie1f1VSRCyeRSRvnZMTM/NbRC
         koMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTMAYNOtiXLbIpfBfX/ZjoF2j1Xgqm6lvqAWKAijSCw=;
        b=UIDO3QUz9J1zukEaiBMJD+2wOskT4cOaxEhnbaIRN+g3aY3almRligZ+kQ4tj+Hgsf
         CUqZV64nTy/qaSvlp4jGFCgNuIaW+l1K7+Jvd76ErC/16RHfugSe7PPKBTIRFiaW1UrI
         +VSvm/Y4qRmHwCYeD6FE1pFCxT9SNCNxiMhSR0LHkRsI+GwhkM18y2hoGfA0T6eYUdh9
         FkXaSVgxmtnvwAdXJoKmlLKTNYd+q9CT6UBOlu3wbbzg54smDglCRUzjOiej3i/yqnmj
         FhOlcXzUWbTCeGa31AFg2MtQXaQDQcKC3LzrsojZXZSgDyxb8p65zPOYQX3+cIRX5iAh
         neoA==
X-Gm-Message-State: AJIora/T2j8qxKU9XywDDx7lw4E6WT0RF4TV5R18QpMigysBmjbYSkEQ
        kTlnr5IGt3pftLVY5kBq2DGmEZOC1ASx1U0pwk8=
X-Google-Smtp-Source: AGRyM1tVRlc/Efjknp2j0mwetaeHSRuuZt3+3lupYLxOIvdx4bOnZ8iDWPyj+gzzwfQlpMTvdeDuFyByDBNdSk7oxOI=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr5744542ejm.636.1655404763382; Thu, 16
 Jun 2022 11:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
 <20220616104211.9257-3-ddrokosov@sberdevices.ru> <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
 <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220616170218.dihjli46spimozeg@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Jun 2022 20:38:46 +0200
Message-ID: <CAHp75VdEY9z_0=sAkKOico9JKYPOX6yqnoetiW49oFHm+SeUoQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jun 16, 2022 at 7:02 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Thu, Jun 16, 2022 at 02:18:52PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 16, 2022 at 12:42 PM Dmitry Rokosov
> > <DDRokosov@sberdevices.ru> wrote:

...

> > Not sure why you put those blank lines herey, it makes code not compact.
>
> Here I use blank lines to split fields from different registers.
> In other words, in the msa311_fields enum one line contains fields from one
> register. But for some heavy registers (like TAP_ACTIVE_STS) we have so many
> fields and their declaration doesn't fit to 80 symbols.
> So I've made a decision to split registers using blank lines.

Better is to add a comment explaining what register is described
below, and not just a blank line.

...

> > Not sure you need this. Dropping i2c dependency from this structure
> > allows much easier to add, e.g. SPI support of the same hardware.
>
> Mainly I use i2c pointer in the probe() path, and you are right, we can
> change i2c pointer to dev and generalize msa311_priv struct from bus
> perspective.

Yep, note that you may easily retrieve i2c_client from struct device
pointer if you need to do that in some (I believe rare to none) cases.

...

> > > +       struct regmap *regs;
> >
> > I believe this is used most, so making this a first member in the
> > structure saves  some instructions (check with bloat-o-meter).
> >
>
> Are you talking about archs where offset calculation adds more bytes to
> instruction? And when offset equals to 0, we can save some space.

It doesn't have anything to do with arches, simply compiler
optimization, otherwise yes, that's what I meant.

...

> > > +       wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
> >
> > This looks very odd from a physics perspective: sec * sec * sec == sec ?!
> >
> > Perhaps you meant some HZ* macros from units.h?
> >
>
> I suppose because of UHZ calculation I have to use NANO instead of
> USEC_PER_SEC in the following line:
>
>         freq_uhz = msa311_odr_table[odr].val * USEC_PER_SEC +
>                    msa311_odr_table[odr].val2;
>
> But below line is right from physics perspective. 1sec = 1/Hz, so
> msec = (USEC_PER_SEC / freq_uhz) * MSEC_PER_SEC:
>
>         wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;
>
> Or do you mean that I should change MSEC_PER_SEC to just MILLI?

1 / Hz = 1 sec. That's how physics defines it. Try to figure out what
you meant by above multiplications / divisions and come up with the
best that fits your purposes.

...

> > > +                       if (err) {
> > > +                               dev_err(dev, "cannot update freq (%d)\n", err);
> > > +                               goto failed;
> > > +                       }
> >
> > Why is this inside the loop and more important under lock? Also you
> > may cover the initial error code by this message when moving it out of
> > the loop and lock.
> >
> > Ditto for other code snippets in other function(s) where applicable.
>
> Yes, I can move dev_err() outside of loop. But all ODR search loop
> should be under lock fully, because other msa311 operations should not
> be executed when we search proper ODR place.

I didn't suggest getting rid of the lock.

...

> > > +       mutex_lock(&msa311->lock);
> > > +       err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
> > > +       mutex_unlock(&msa311->lock);
> >
> > > +
> >
> > No need.
>
> Sorry, I don't understand. We do not need to call it under lock, right?
> I think we have to wrap it by msa311 lock, because other msa311
> operations should not be executed when we enable or disable new data
> interrupt (for example ODR value changing or something else).

The blank line is not needed, I specifically commented on the
emphasized paragraph (by delimiting it with blank lines and leaving
the rest for the better context for you to understand, it seems it did
the opposite...).

...

> > > +       mutex_lock(&msa311->lock);
> > > +       err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> > > +       mutex_unlock(&msa311->lock);
> >
> > > +
> >
> > No need.
>
> Again I don't understand why, sorry. We do not want to get sporadic
> MSA311 attributes changing during power mode transition from another
> userspace process.

As per above.

-- 
With Best Regards,
Andy Shevchenko
