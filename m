Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC22458A086
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiHDS3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbiHDS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:29:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932866C12F;
        Thu,  4 Aug 2022 11:29:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kb8so819389ejc.4;
        Thu, 04 Aug 2022 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uP2+bF8bVNuuTL60DeDiDH8lBSMjk4leEZOz7iiYLeI=;
        b=AJI7YDZxNufqXrGeC54agIHsf1wdybUqYe0tqEJGaVjT5IoAG846W56a6UyZ98wL9J
         TW6pNMg0/VC8DoKjEsK28prU04LjjpSB6m0w43V1LE3cq2RsFFMxsLLyzf04ZGcZuRIX
         5eWfl2Jx/tm962jQJjQkjqd/ceveCxvsoZd5K5hxMDNj3Wlm1w58VfLSTnnNWNjiBWui
         dHaklqqTZ9YNuPTt2BDCXDIiU/QEVjm/99uDzyAs1ELuiEkH4mJpNyMJx0zz9ojgN312
         cP2VhY3vlkH+0yc3aSxsyH//Auh6/T0RQNI84EG+MxK6WRjYRwNyFbJ9vwLqw52UsfV5
         aurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uP2+bF8bVNuuTL60DeDiDH8lBSMjk4leEZOz7iiYLeI=;
        b=x1F8HN4xq1skpfF5wHBm1Pa3nwmFU8/I62IPUMm4pExy3gFqmD9YYSaMSsRgFBmcc8
         JyCwRlE/rBg05dwaw2+D7RhnTJXRy9lEc46m8/C1v5aNNPQnJ57lMWNERqFLUnfs32Ie
         pWYz5zCFwdJzrkZtJTVLpEmNWFbdmVgv/bH3PhpH3+rbHUYI4mPWVT2lV4HDtsa03c69
         ++FyDvU3uInmJAfxE7XxeX837QYy9REP8aoqK+XJjB5Lo8hghQkInfBa29pWXvW204Oo
         SBbtutoFWmqzBQABjrMgi09ySMoA6Dqsrk8rNm3m8vjWV7UY1+sTb125gD4t5vB9Cqh6
         s8OA==
X-Gm-Message-State: ACgBeo26kyycX6I3mxqBgLsU7A3M2GQJLRkwOyxenPtUGh/zTnS5txyi
        yrNgEGqS1/mwvu5IrGSxvWW6hx2hwwiSORh2Q6g=
X-Google-Smtp-Source: AA6agR6UFQ9tU5XN9nesgUkWWSYNb6xocYfw6Y9XF/xvLhTNJQhBvc3dhbRo9njA1uGAW79NJnx0TSzbM1jeQ5NNvjg=
X-Received: by 2002:a17:906:7950:b0:72f:d4a4:564d with SMTP id
 l16-20020a170906795000b0072fd4a4564dmr2304999ejo.479.1659637747783; Thu, 04
 Aug 2022 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru> <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
 <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Aug 2022 20:28:28 +0200
Message-ID: <CAHp75VdCWKCVws_xp7igCAGYFC7bxkQgCyXFohQR5PHzTkoSpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 9:16 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Wed, Aug 03, 2022 at 07:49:33PM +0200, Andy Shevchenko wrote:
> > On Wed, Aug 3, 2022 at 3:11 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

...

> > > +static const struct {
> > > +       int val;
> > > +       int val2;
> > > +} msa311_fs_table[] = {
> > > +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> > > +};
> >
> > Besides that this struct is defined not only once in the file, this is
> > very well NIH struct s32_fract. Why not use the latter?

> Good point, but looks like this struct is not so popular in the other
> kernel drivers:

It's simply new, it is not about popularity. I would put it as it's
not _yet_ so popular.

...

> grep "s32_fract" -r -l . | wc -l
> 3

Hint: `git grep` much much faster on Git repositories (it goes via
index and not working copy) and see
`git grep -lw s32_fract`

...

> > > +       .cache_type = REGCACHE_RBTREE,
> >
> > Tree hash is good for sparse data, do you really have it sparse (a lot
> > of  big gaps in between)?
>
> I suppose so. MSA311 regmap has ~6 gaps.

Yes and how long is each gap in comparison to the overall space?

...

> > > +       for (fs = 0; fs < ARRAY_SIZE(msa311_fs_table); ++fs)
> >
> > fs++ will work as well.
>
> I would prefer ++fs if you don't mind :)

Why? It's a non-standard pattern, and needs an explanation.

> > > +               /* Do not check msa311_fs_table[fs].val, it's always 0 */
> > > +               if (val2 == msa311_fs_table[fs].val2) {
> > > +                       mutex_lock(&msa311->lock);
> > > +                       err = regmap_field_write(msa311->fields[F_FS], fs);
> > > +                       mutex_unlock(&msa311->lock);
> >
> > > +                       if (err)
> > > +                               dev_err(dev, "cannot update scale (%d)\n", err);
> >
> > This can be done after putting the device back into (auto)sleep, right?
> >
>
> Are you talking about dev_err logging? Sure, it can be moved after
> pm_runtime* calls.

Yes.

> > > +                       break;
> > > +               }
> > > +
> > > +       pm_runtime_mark_last_busy(dev);
> > > +       pm_runtime_put_autosuspend(dev);

...

> > > +       for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> >
> > odr++ works well also.
>
> I would prefer ++odr if you don't mind :)

See above.

...

> > > +                               dev_err(dev, "cannot update freq (%d)\n", err);
> >
> > frequency
>
> It will be more ugly due 80 symbols restriction.

Nope, it will be understandable by the user. You do code for the user
and then for the developer, right?

...

> > > +               dev_dbg(dev, "found MSA311 compatible chip[%#x]\n", partid);
> >
> > Useless message.
>
> Why? It's under dynamic debug, so I will see it if I really want to.

So what the point of the _successful_ detection? You already know from
the code, that partid, you know by other means that probe was
successful, why this message is needed? Especially for debugging when
we have initcall_debug option.

...

> > > +               return dev_err_probe(dev, err, "cannot disable set0 intrs\n");
> >
> > interrupts
>
> It will be more ugly due 80 symbols restriction.

As above to here and other cryptic messages. Please think about the users first.

...

> > > +       indio_dev->modes = 0; /* setup buffered mode later */
> >
> > Why explicit assignment to 0? Doesn't kzalloc() do it for you?
>
> kzalloc() will do it for me, of course. Previously, I initialized modes to
> INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> suggested to replace it with 0. I can remove this line at all, no problem.
> I just thought, it's more readable.

You may leave comment without assignment explaining that IIO core will
set the buffered mode.

-- 
With Best Regards,
Andy Shevchenko
