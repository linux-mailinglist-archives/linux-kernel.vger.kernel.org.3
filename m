Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55B5167CA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 22:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354594AbiEAUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 16:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiEAUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 16:31:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B71543EE7;
        Sun,  1 May 2022 13:27:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso14636202pjb.1;
        Sun, 01 May 2022 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0bEJs7qgg/eX6nUTN2NKhZYoTjWbfIDdjjcVr0MKn0=;
        b=j+TvewDN/kI4TIXi0Uj6To92nH4CpMfaizm/t37LfhTx55UMcby1jK6vfE0cJ6gMKP
         FasRMems0yURB5dgj96Jyt2oaqWtAhW5YHGnhn3lJRBjSDbC7QoWIOcM0jKWcEtXwuNM
         wtl0XOD6AAj3u9B9jmDMSLGzzUkGueKu8uq3ch4YeeS8ecLtnz7xanl6ZLpRVObbGNOt
         ytuy6BqXgQ8FjVsfGGwkIZ7GE93TWk0ienpbJkAbbkK24JFIsvhnWjpUsiupqAYNpVRp
         ZQ8qgcLX1YxzjTx5/hegJJIv+mkOY0vpX/mXGEIX93s/P+SVcfGQR83hFY7Pa0wNOsf/
         GMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0bEJs7qgg/eX6nUTN2NKhZYoTjWbfIDdjjcVr0MKn0=;
        b=SjHzu4f0doOT5BkvhHz3R/VmEzynoDaz/CvgWW5TraV89igSKqitfYfGEH6WoGNtQV
         sX5CvWrke/BLYzolBkuGOAjE2CMGdHmCK8uKTltgomCFT5IZgZvamYboL5f2reHb9V30
         5b/tfp7cHwjeEPRJ7rtN5xkz3Ru4hhZ7clqJjMu4WVFGZIRd3EBJDPycgVoUsKPYTtIh
         Cr1DnkRy79qQEEEa+nHMRW8vEzpT5EzKofPYaOWRAVpH7u5Xha5x0z/cZ0tWD9HYE+ug
         /94HGRIloT8EWAEg+zsWPRF42biiz7yi2Wf5q/0URU2Py1ceeq27f7t2JDuu0nbDfOr2
         rhKA==
X-Gm-Message-State: AOAM532nlPqitKfipymgtWsf0ntFOsZt746JtWKOIdGAYntdwUc++LtG
        l5PFvYKdi6hK2PCgc6bpEJaqsXlQqINNHrBQEe8=
X-Google-Smtp-Source: ABdhPJwm7QsGb1flanj0/iVrkkfHHUEGVd7uWE4OvR8bWCBKO+qnfZgqzifffqvCmJEzL9FcLcasYZWXj1RV3BFTb4s=
X-Received: by 2002:a17:902:f547:b0:15d:10ce:e2ff with SMTP id
 h7-20020a170902f54700b0015d10cee2ffmr8441158plf.80.1651436861735; Sun, 01 May
 2022 13:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
 <20220420211105.14654-7-jagathjog1996@gmail.com> <20220501173110.67a18bf9@jic23-huawei>
In-Reply-To: <20220501173110.67a18bf9@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Mon, 2 May 2022 01:57:30 +0530
Message-ID: <CAM+2EuL7Qcj2znsmXPd6Q7wT-EQrUa=y6idcH=rryQdSiGSdOg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] iio: accel: bma400: Add step change event
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, May 1, 2022 at 9:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 21 Apr 2022 02:41:02 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Added support for event when there is a detection of step change.
> > INT1 pin is used to interrupt and event is pushed to userspace.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> Hi Jagath,
>
> A query about handling of multiple interrupts...
>
> > ---
> >  drivers/iio/accel/bma400.h      |  2 +
> >  drivers/iio/accel/bma400_core.c | 75 +++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >
> >   * Read-write configuration registers
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index aafb5a40944d..fe101df7b773 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
>
> >
> >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > @@ -971,6 +1035,7 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> >  {
> >       struct iio_dev *indio_dev = private;
> >       struct bma400_data *data = iio_priv(indio_dev);
> > +     s64 timestamp = iio_get_time_ns(indio_dev);
> >       int ret;
> >
> >       /* Lock to protect the data->status */
> > @@ -981,6 +1046,16 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> >       if (ret)
> >               goto unlock_err;
> >
> > +     if (FIELD_GET(BMA400_STEP_STAT_MASK, le16_to_cpu(data->status))) {
> > +             iio_push_event(indio_dev,
> > +                            IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
> > +                                           IIO_EV_DIR_NONE,
> > +                                           IIO_EV_TYPE_CHANGE, 0, 0, 0),
> > +                            timestamp);
> > +             mutex_unlock(&data->mutex);
>
> Is it possible for two interrupt sources to be active at the same time?

Yeah, it is possible when multiple interrupts are enabled like data ready,
step and generic interrupts.

> Given the device is clearing interrupts on read (which is unusual enough to
> make me check that on the datasheet) you will loose any other events.
>
> Normal trick is to act on all set bits and if any of them were acted on
> return HANDLED.

Then I will push all the events that occurred and then in the end I will return
HANDLED so that none of the events are missed.
I will change this in the next version.

Thank you,
Jagath


>
> > +             return IRQ_HANDLED;
> > +     }
> > +
> >       if (FIELD_GET(BMA400_INT_DRDY_MSK, le16_to_cpu(data->status))) {
> >               mutex_unlock(&data->mutex);
> >               iio_trigger_poll_chained(data->trig);
>
