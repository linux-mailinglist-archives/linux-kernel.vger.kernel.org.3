Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27F754BA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbiFNTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbiFNTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:18:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8129C80;
        Tue, 14 Jun 2022 12:18:24 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q140so9357540pgq.6;
        Tue, 14 Jun 2022 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+NwpM7oTO+xnUjVlqc3L1OHg1oUbX+X1MudKapZCG0=;
        b=N7w6wGMnSDEBRS4oEaUHnN0mL93zIrrEl64nkWLb8uxxQQHK1zUBWdniPqPyRupaLP
         kK+dQZ3LDBD6a8rTYRA2mM36EAsuW7inw6DKhY502A2DEG8xtjuCO8BrhWrX/zL5DeRO
         78MJ+L+YQRk3Dj/6pJcIpYBbLBM+9XpNW3iDVCL32L0lfd0C7KgBTyPDV124EkAT923o
         3kwJPPj/qxU1IcExAqfMz0j3VxPt71tt6J1G6bgMiLxU8jW+qsevR5VYjt0/jpY/e/Lx
         exnXHQvOMcb6t1N/OOQDX4AZ4A0aKIh73/FghL/l/SOiumkEIO4dJSPV3SaBSyoNaZnY
         2Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+NwpM7oTO+xnUjVlqc3L1OHg1oUbX+X1MudKapZCG0=;
        b=07vQiGNQi/bcqZxwTjf1+/2EZ75278JtUUB+omC1okUe8GXQpLlHZAg2nNMyCNZRa8
         KSAAXw3a9Hm1K6Ckm2zpCLmbMgW45czheZal+wpvwMFlQTtCMkH0lsRAL1Os+1z14Mz9
         ovNoN+keGs95JmPvPGm3FbgTdD2KtEI7Zi6klm92OsPHDNe2x45na5v0GOyL+GqEBpJN
         D84qGY+JxFWfjgy+FI1X65L2zCEVTkC6ufX8Xg1yw/hCIkUYX958ETPSlXTGsxf760JM
         3E5u/88DjXY2SWVN5vNXZVbEf91+1CHqYx9owOHQtbIyPnU28Ncx1RiLhXqw3tj0ofoZ
         hiGw==
X-Gm-Message-State: AOAM530qdGDsCxovNVyFjlP5qIenWvns73mF9tsknc4ilhrqT4buRtGE
        oEXQoGrtxJkGwJXRYnMjkF/v3T6CfAuzFtta6pc=
X-Google-Smtp-Source: ABdhPJxJVP7kLwEvDb6GM3mzsHla130vZdGI8qm5xFlowjEwjFJxMFOGnV9sLinMO36fAmvUPbzOXuK63hp0s6pNnFI=
X-Received: by 2002:a05:6a02:19b:b0:3fa:3e63:15fb with SMTP id
 bj27-20020a056a02019b00b003fa3e6315fbmr5790839pgb.129.1655234303519; Tue, 14
 Jun 2022 12:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
 <20220613191706.31239-3-jagathjog1996@gmail.com> <CAHp75VdJ7z+GnEGEe2obd8Df5mJtNGQASf1c7WWXJVQ1Db8U4A@mail.gmail.com>
In-Reply-To: <CAHp75VdJ7z+GnEGEe2obd8Df5mJtNGQASf1c7WWXJVQ1Db8U4A@mail.gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Wed, 15 Jun 2022 00:48:11 +0530
Message-ID: <CAM+2EuJAyTL=JcESt8fteSy7q09nSShQKF0AMkiwdJOtHe5uPA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: accel: bma400: Add support for single and
 double tap events
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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

Hi Andy,

On Tue, Jun 14, 2022 at 2:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 9:17 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Add support for single and double tap events based on the tap threshold
> > value and minimum quiet time value between the taps. The INT1 pin is used
> > to interrupt and event is pushed to userspace.
>
> the event
>
> ...
>
> >  #include <linux/iio/trigger.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/sysfs.h>
>
> s is before t

Sure I will arrange this in alphabetical order.

>
> ...
>
> >         bool step_event_en;
> >         bool activity_event_en;
> >         unsigned int generic_event_en;
> > +       unsigned int tap_event_en;
>
> Should it be boolean? Or i.o.w. why does it need to be an unsigned int?

tap_event_en is used as a bitmask. Bit 2 and 3 of tap_event_en
are used to tell the state of the single and double tap events.
For example bit 2 is used to indicate single tap is enabled or not.

set_mask_bits() and FIELD_GET()  is used to set and retrieve the
required bit value so I used unsigned int.



>
> ...
>
> > +       data->step_event_en = 0;
> > +       data->activity_event_en = 0;
>
> These are booleans.
>
> --
> With Best Regards,
> Andy Shevchenko
