Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568E512432
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiD0VFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiD0VFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:05:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A2BF43;
        Wed, 27 Apr 2022 14:01:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so4491202pje.1;
        Wed, 27 Apr 2022 14:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqYFNy0Ye1hG0JvZqo/UaJOYPE63YVH9ZWtIRJQCusE=;
        b=XQLshbFroY/oV5ijkx6Jh5DxQyHuOqj2ianmBSoFT+s6hC/g6qq91dNna3cR24DCdj
         4jI2UzB0lDjDClKeu3wVpDkKT9CgW5SGiOeYulemQwJAL94tLwkZ9BqD7N/ayIY01W66
         RHG7Z53plRevZQRErpmKz7AxHUUDNybKQYZzxEIC+G35RUrxDqjnWLKWQDowOmNrFqI4
         nzbvYc0swtbUGueZbtgttFuKKin+3PoqpVsbDAofEcS+t9H8+YUUCi92N6EU0gjjhMms
         x1xY6UABX9aBNVrq5dmv1pOrj38SuNUicZ6xgQo35x9hv42UjhdT+daYI+ANNFk1WukP
         edWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqYFNy0Ye1hG0JvZqo/UaJOYPE63YVH9ZWtIRJQCusE=;
        b=N5OUJ0uruDRmCYAxttEEFcWWbuE0zJ1VHkIiY3J6COgP6I79T3Bbs8oW/bDB9N2Y8a
         1LJks5GOdyO0v2XHXR4CYYkdORE/AMm6bh20QhFYhVvIJ6xIHPQ7/4ADSvS2cXRl0MnS
         ZWtf3bdHxH0qjU2goDLBlCN/+ETgF4rfq7b2bB7/Kl/iCHewThHbd0Y065ev1T71/5D3
         7oMvV8wPAen6rwdskSKGWyYgjmxFTpYuc0fB1kj4zlqZx7VPQPcdfFZp3HjwlwkdLOqS
         hj7KfPFu9BQzeCsrrT2Rb2o9hw5y+l8ICFVaEO5/Bf/Sm47r0tEp9OJRXg60vV4IfBPL
         wC8g==
X-Gm-Message-State: AOAM533CoDlArrE5cAQESANZl/2FhtLVn2tode0h2jVZZag3FkkqsWLz
        9hP2u9l+Q2Qs6kqKzT/D12oGIQABiEUHW95PSB4=
X-Google-Smtp-Source: ABdhPJxpuB5tajITNAXKzFz4oroSs+BVtuP2/qtQEvVhRgsZMYpDDRUxPfKPCeC0hQ+aGsaNXz8nOdpgl9J6OPUDxg4=
X-Received: by 2002:a17:90b:1d0e:b0:1d2:79e9:21aa with SMTP id
 on14-20020a17090b1d0e00b001d279e921aamr45334321pjb.153.1651093318360; Wed, 27
 Apr 2022 14:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
 <20220420211105.14654-6-jagathjog1996@gmail.com> <CAHp75Ve8mruPEyorSmydAHM27rnL9Wv+qNdWyQ9tVxz-+JJYiQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve8mruPEyorSmydAHM27rnL9Wv+qNdWyQ9tVxz-+JJYiQ@mail.gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 28 Apr 2022 02:31:47 +0530
Message-ID: <CAM+2EuJ3n4RVHVh9ZH-HkkjUm+zLLt=g34H5aOxPiDW673NOrw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] iio: accel: bma400: Add separate channel for step counter
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Apr 27, 2022 at 6:04 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added channel for step counter which can be enable or disable
> > through the sysfs interface.
>
> ...
>
> > +static int bma400_enable_steps(struct bma400_data *data, int val)
> > +{
> > +       int ret;
> > +
> > +       if (data->steps_enabled == val)
> > +               return 0;
> > +
> > +       ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG,
> > +                                BMA400_STEP_INT_MSK,
> > +                                FIELD_PREP(BMA400_STEP_INT_MSK, !!val));
>
> > +       data->steps_enabled = val;
>
> This will update the value even if we got an error and actual device
> state is unknown here. Does this make sense?

I will correct this in the next series.

>
> > +       return ret;
> > +}
>
> ...
>
> I perhaps missed why kmalloc() is needed now. Any pointers to the discussion?

Here step is a 24-bit value and since this is a sysfs channel read (slow path),
kmalloc() is used to make the buffer DMA safe to read the multibyte value
using regmap_bulk_read().

>
> --
> With Best Regards,
> Andy Shevchenko

Thank you,
Jagath
