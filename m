Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC134FA1DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiDIC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiDIC6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:58:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4556830A;
        Fri,  8 Apr 2022 19:56:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id be5so3500345plb.13;
        Fri, 08 Apr 2022 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQyPSrgr9MS7EpRh2VWlvGNNESfQ8NWuUEdNThLjldw=;
        b=j/+h/dLqzkWj5Fqfos0fPiStfP0opcXSwBlFQkktY5MZUxfJ5nwud8+5hbcHt4e2SF
         FtGayZQopAgXHgIn1LrXgdyZUaTwI34YQd5YavavKifblyB0mKcxl3b5rPCb7yjPOpdT
         zGxHkBNKDa0fuiqD0hOHVNwArO+3Kjm0ZN8mFGWxEzxHRwc3mQzM2g9I2/NtOSFufhxD
         ZP6V7wRQnS1G4ZZCbG9MAcB+vDfYTs9yozwGFYeEfoAHG0l88BpEOLBB72l/CTxWQEfW
         +QeuC7O2hDB40zrKD/2heMtRrcU1wdnilyxTVzzCcCHu65yIILpKnowDZjM02qM5A/cx
         JNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQyPSrgr9MS7EpRh2VWlvGNNESfQ8NWuUEdNThLjldw=;
        b=TpQoz6++D+H12KEm050blNFvxr4+h3HYy151nEHTOfyAON0FVALiM60uZV1diBtkYI
         YM6/fPHGfsWO75N8QHxEcbcPzklVOGc1X9oVT/dB3Vcdc8IHuQsjI77evYjhntUJR9gc
         Ha3u1zAR+kw1+o8fTHL48sn3gnv+xhdH7Nmv9uc8jNvyM29yon0Srd5KxFk7jomWSFlN
         dp2MJYus/nkvnGUx/FobCU9FJT2GIVSDODO8yzoU+HMExQPF1jIDPCep+eVI4JXL5nq1
         ReIuzPg8OV1fYPnkAUGPIaAa218WDuFYkQ/yaaUvOTu84jYDGREiosWnr77zYUffcfi5
         qB2g==
X-Gm-Message-State: AOAM533pWRJmX/6mc/FeESbQK0L+JK7LdGfzOVe372g3+u42l1HnCGhH
        m9Aj4piiE4IMCWv2DQgxyWAO8SwKd8xAxnpQoA==
X-Google-Smtp-Source: ABdhPJysfJ3hL7zN/14NcjhG+NL5gN9Clmu0frccbRswIVmlJPnlxX6eWfAoWuAW0vahw3vc6onqFPX7Wiq9q3zMTS4=
X-Received: by 2002:a17:902:e80c:b0:156:bc53:704e with SMTP id
 u12-20020a170902e80c00b00156bc53704emr21820688plg.31.1649472992064; Fri, 08
 Apr 2022 19:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220409022629.3493557-1-zheyuma97@gmail.com> <YlDwoazfX4rcf4ho@google.com>
In-Reply-To: <YlDwoazfX4rcf4ho@google.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 9 Apr 2022 10:56:21 +0800
Message-ID: <CAMhUBj=Z+zsU9-cjRZv5b3=_N5GMNeW7C3z9BATrMZcNpQ9JKw@mail.gmail.com>
Subject: Re: [PATCH] input: cypress-sf: Register a callback to disable the regulators
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     y.oudjana@protonmail.com, linux-input@vger.kernel.org,
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

On Sat, Apr 9, 2022 at 10:34 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Zheyu,
>
> On Sat, Apr 09, 2022 at 10:26:29AM +0800, Zheyu Ma wrote:
> > When the driver fails to probe, we will get the following splat:
> >
> > [   19.311970] ------------[ cut here ]------------
> > [   19.312566] WARNING: CPU: 3 PID: 375 at drivers/regulator/core.c:2257 _regulator_put+0x3ec/0x4e0
> > [   19.317591] RIP: 0010:_regulator_put+0x3ec/0x4e0
> > [   19.328831] Call Trace:
> > [   19.329112]  <TASK>
> > [   19.329369]  regulator_bulk_free+0x82/0xe0
> > [   19.329860]  devres_release_group+0x319/0x3d0
> > [   19.330357]  i2c_device_probe+0x766/0x940
> >
> > Fix this by adding a callback that will deal with the disabling when the
> > driver fails to probe.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  drivers/input/keyboard/cypress-sf.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/input/keyboard/cypress-sf.c b/drivers/input/keyboard/cypress-sf.c
> > index c28996028e80..798611b76de6 100644
> > --- a/drivers/input/keyboard/cypress-sf.c
> > +++ b/drivers/input/keyboard/cypress-sf.c
> > @@ -61,6 +61,13 @@ static irqreturn_t cypress_sf_irq_handler(int irq, void *devid)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static void cypress_sf_disable_regulator(void *arg)
> > +{
> > +     struct cypress_sf_data *data = arg;
> > +
> > +     regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> > +}
> > +
> >  static int cypress_sf_probe(struct i2c_client *client)
> >  {
> >       struct cypress_sf_data *touchkey;
> > @@ -84,6 +91,10 @@ static int cypress_sf_probe(struct i2c_client *client)
> >               return error;
> >       }
> >
> > +     error = devm_add_action_or_reset(&client->dev, cypress_sf_disable_regulator, touchkey);
> > +     if (error)
> > +             return error;
>
> This needs to be moved to the spot after we enabled regulators. I
> adjusted and applied.

Thanks for your reminder!

Zheyu Ma
