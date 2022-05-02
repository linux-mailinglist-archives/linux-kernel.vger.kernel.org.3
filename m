Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3E516DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384400AbiEBKQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384558AbiEBKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:16:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5D2DC1;
        Mon,  2 May 2022 03:12:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id be20so16047942edb.12;
        Mon, 02 May 2022 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iymi+5khW50GeB4u9utBY2pY3ATPV9dMvcwkgjmV68k=;
        b=bxa2u/xq1Bm6JNNYuARJHWzKFrM/ZrKd3v8JVZsa4hFKdGL15tYQ5/xuxOq9VacfKG
         au4LAiMQ3Ld8gnFZ5b3eUAfT7CaeDU6lQVn47+gRUWBB18M5U5rcnZafFMNe4nhaaKIL
         VMbk019KcEEkx9s+l+BNn/CPEw2s+TPY6TP+0BhE+Louai0pP41QZfonS4nfcNqfsQ3F
         VRcmC0xXPUDUXKkwNbm4kw8b7UHq/k56vZLrVqzEQ+8WQMEYdzfkjHR1LZi43xgLfkeh
         R61hCUBL3VRfVj/KqYMmVLG6Pcv/+aUcbXFr8zQNxClhPLFCBUqQnS63YvvIWnZaRg4l
         EByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iymi+5khW50GeB4u9utBY2pY3ATPV9dMvcwkgjmV68k=;
        b=OZ3LyzfUFQdrV9sjVv0z8PxPPhhPM8np0o3Kw/bLFe8qtgOqdsVUIFezg1vPkmOGS3
         dYrcpSO+PUAFPpK7hwQo0vX+KhFDZCvtePI42fdGsCxJv8myWzq6z5REAqQDQn/1o1/j
         5ihIKmkz/EfVIFtq4mLdsedoJu4uLY5NvDNxXkHdDYS+X8DjOf5qNcFitYoS/Qwit34k
         ti+iruzsjKAtuNDq5O5XQogMIW0u5hOWHlzwaVeZkNgqhUmndCHBysNnq7PEWlvWqzvr
         WYDQxFskSvFpvGn9ZdOPa6y13p9dGTZbX830VP5dverye688782obA79IrCnxEfd881W
         1Miw==
X-Gm-Message-State: AOAM530ErzWbb5Lpjj+wnyHQC7VluJyVy1KoclGDY+jMX45vVTqYXkda
        XxLWucU+C5xcg4EotKPiQAsgDDP1abllT/U3iuk=
X-Google-Smtp-Source: ABdhPJw7lfUkCDuH/6o7hYgeefVGz28jV/88t3EtQY7a1vjwZoBqsWaJajJrWCSz6rj7jAwjoBEWiHlgWqj5z5pW5Xc=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr12901013edm.122.1651486341862; Mon, 02
 May 2022 03:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <20220426131102.23966-9-andrea.merello@gmail.com> <CAHp75VdLiBkg100UjFN36rW_vaOObOoJ_Mv9n=4LjSWb+dQWMw@mail.gmail.com>
 <CAN8YU5PzwmeQ9XA3qod7HejG6cCLCrPvda5eomCh5hUze_DWcA@mail.gmail.com>
In-Reply-To: <CAN8YU5PzwmeQ9XA3qod7HejG6cCLCrPvda5eomCh5hUze_DWcA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 May 2022 12:11:45 +0200
Message-ID: <CAHp75VfOZpD135q_eERnLk0NorXwPxY8DFbKMu+eKV8XahGC1A@mail.gmail.com>
Subject: Re: [v5 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
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

On Mon, May 2, 2022 at 11:50 AM Andrea Merello <andrea.merello@gmail.com> wrote:
> Il giorno mer 27 apr 2022 alle ore 15:23 Andy Shevchenko
> <andy.shevchenko@gmail.com> ha scritto:

...

> > > +#define BNO055_ATTR_VALS(...)          \
> > > +       .vals = (int[]){ __VA_ARGS__},  \
> > > +       .len = ARRAY_SIZE(((int[]){__VA_ARGS__}))
> >
> > Not sure this adds any readability to the code. Can we simply have an
> > array of int for each case with the explicit ARRAY_SIZE() calls?
>
> Do you mean moving the vals array out of the structs? Something like:
>
> static int bno055_gyr_scale_vals[] = {125, 1877467, 250, 1877467,
>         500, 1877467, 1000, 1877467, 2000, 1877467};

With the better style, but yes

...[] = {
  1, 2, 3, 4, 5
   6, 7, 8, 9, 10,
};

> static struct bno055_sysfs_attr_aux_data bno055_gyr_scale_aux = {
>         .fusion_vals = (int[]){1, 900},
>         .hw_xlate = (int[]){4, 3, 2, 1, 0},
>         .type = IIO_VAL_FRACTIONAL

(with last comma to be kept, but yes)

> ?
> But then I'd make also something like:
>
> #define bno055_sysfs_attr_avail(priv, attr, vals, len) \
>         _bno055_sysfs_attr_avail(priv, attr##_vals,
> ARRAY_SIZE(attr##_vals), attr##_aux, vals, len)
>
> And the same for all other users of those structs.
>
> My point is not about readability,

And my point about readability. The reader, and even the author after
some time, may have no clue in this forest of the macros and castings
what's going on.

> but about avoiding as much as
> possible bugs caused by mismatched attr_vals, attr_aux and
> ARRAY_SIZE() arg. e.g:
> bno055_sysfs_attr_avail(priv, bno_foo_vals, ARRAY_SIZE(bno_bar_vals),
> bno_foobar_aux, vals, len)
>
> I used to make quite a lot of mess until I grouped all the stuff in
> one struct :/

If something you want to prevent at compile time, consider to utilize
static_assert() and / or BUILD_BUG_ON() depending on the place in the
code (the former is preferred).

...

> > > +       msleep(20);
> >
> > Perhaps a comment why so long sleep is needed.
>
> DS says that switching mode can last from 7mS up to 19mS depending on
> the case, but I don't know _why_ it takes so long. I may add a comment
> that just states that it's a sensor requirement.

Yes, please add the comment that this time has been chosen to follow
data sheet recommendations.

...

> > > +       for (i = 0; i < bno055_acc_range.len; i++)
> > > +               len += sysfs_emit_at(buf, len, "%d%c", bno055_acc_range.vals[i],
> > > +                                    (i == bno055_acc_range.len - 1) ? '\n' : ' ');
> >
> > You may move the condition out of the loop.
>
> May you elaborate, please? Do you mean something like: loop one time
> less, and then call sysfs_emit_at() once more outside the loop,
> getting rid of the conditional ternary operator at all?

Regular loop with a space as a delimiter and after it the condition to
check i and replace last space by \n. I.o.w. the ternary is an
invariant to the loop and no need to call it for each iteration.

...

> > > +       if (indio_dev->active_scan_mask &&
> > > +           !bitmap_empty(indio_dev->active_scan_mask, _BNO055_SCAN_MAX))
> > > +               return -EBUSY;
> > > +
> > > +       if (sysfs_streq(buf, "0")) {
> > > +               ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_AMG);
> >
> > return bno055_operation_mode_set(...);
>
> Why? bno055_operation_mode_set() returns an error code, while here we
> need to return the len, or propagate the error code only when it's the
> case

Ah good point.

> > > +       } else {
> >
> > ...and drop this with the following decreasing indentation.
>
> if you want to drop this, then I can just duplicate if(ret) return
> ret; i.e. add it after bno055_operation_mode_set(priv,
> BNO055_OPR_MODE_AMG); and get rid of the else branch (see above)

Yes, but now, reading the original code again, I'm wondering why you
are not using kstrtobool().

...

> > Can be removed to group all related checks together.
>
> I'm not sure what you mean here, but see below
>
> > > +       if (ret)
> > > +               dev_notice(dev, "Calibration file load failed. See instruction in kernel Documentation/iio/bno055.rst");
> > > +
> > > +       if (caldata) {
> > > +               caldata_data = caldata->data;
> > > +               caldata_size = caldata->size;
> > > +       }
> > > +       ret = bno055_init(priv, caldata_data, caldata_size);
> >
> > > +       if (caldata)
> > > +               release_firmware(caldata);
> >
> > > +       if (ret)
> > > +               return ret;
> >
> > Can be rewritten in a form of
> >
> > if (caldata) {
> >  ret = bno055_init();
> >  release_firmware(...);
> > } else {
> >  ret = bno055_init();
> > }
> > if (ret)
> >   return ret;
> >
> > ?
>
> Indeed I'd say it could be rewritten as:
>
>         if (ret)
>                 ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);
>         if (ret) {
>                 dev_notice(dev, "Calibration file load failed. See
> instruction in kernel Documentation/iio/bno055.rst");

Missed \n.

>                 ret = bno055_init(priv, NULL, 0);
>         } else {
>                 ret = bno055_init(priv, caldata->data, caldata->size);
>                 release_firmware(caldata);
>         }
>         if (ret)
>                 return ret;

Yes, something like this. Experiment with it and choose which one is
read better.

-- 
With Best Regards,
Andy Shevchenko
