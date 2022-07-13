Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75729573566
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiGML3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiGML3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:29:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C6102706;
        Wed, 13 Jul 2022 04:29:50 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 75so17466524ybf.4;
        Wed, 13 Jul 2022 04:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l38PHrFinRKcyHffSFx6DE5JXWszo10fwq1zDEvyc08=;
        b=a1VUfBEkKKmi+Q3oKT5w4UIhSPSJyCsber2kpECN9NC6L/7+IgA0wQnFLA6BthS3oL
         Cq1yt632JlM8QwMgvAc8Pz4Pxn+taQPUiaFLnCMVAWxPweSW9xr2Mk71Lv0UOXapKJYJ
         IAWLiGOl1im5Xf7eyWFRTta8nXmPBRJAzokON/gFzJejqyqv+U4IEPHQ5v0ueeZM0eka
         EJ8i4URnPQVk87uLVfbamUVcLg77IwQmpMYtUlw5jnFdC2jLDsQx9PHwjJM/2ckNN/fU
         HiFxSDatFVHQADWyzRsRCa9lu+OyEGCzCwy9uUq+21x1sJ1hOldAQxRA5y4SYTyL2m3N
         /OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l38PHrFinRKcyHffSFx6DE5JXWszo10fwq1zDEvyc08=;
        b=hiC7BQYjn64UiF2VuaYKVtLI1QVKbTD7lRHUfAG1/9eP8ZKdg0iZWjgGGWAAbDFW+j
         a++NRpjBOqgzZYk2rYwiWGYHFlQHNZ25/wxITHZBRGJCeUs0p5HUAuzroJlrx0tJoDMV
         P/GI48bO+cbPJ7fTeC34ithLoFkX80dK4cABBNCkVnLWmYGB1OcgOYx5ZXIONY984XCs
         Rz7N+sdCp+YJ8JGPUSQ6J0eUUve1IxVOpyD5U1P0G5DNtwa/ixrGzCybEoEnn/WRrj8x
         ZclE8GiU9NR2GnAvWaRbusI2cGxHHllbK7Mf61e1+Oe+xniyXz97DWWPRA67XYiWDTKe
         EyLg==
X-Gm-Message-State: AJIora/ouqZGmpq1Ww2UYbrbJiBCZXHLAO8/Kj/nrMklI3A1lq/b/F92
        +gwzH4joDrBQz5YqQF73qa3dAcXhYwjrFadr2wQKpregc4sAcw==
X-Google-Smtp-Source: AGRyM1u6ApjGcXcC65izgGN6moyUjwp57VXvRuhZvcLZ0kzJd54GByXp5IBARqp2yvSwg1BtXJh5n5Q9RNax8JPdZg8=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr3193764ybg.460.1657711790036; Wed, 13
 Jul 2022 04:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com> <20220713013721.68879-6-warthog618@gmail.com>
 <CAHp75VeTyS_77LCp6Uab18M3hJ0dtf5jiSSrPN4tHaBHFEUTkg@mail.gmail.com> <20220713102459.GA113115@sol>
In-Reply-To: <20220713102459.GA113115@sol>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 13:29:13 +0200
Message-ID: <CAHp75VeTcEiQQA24+wk7Sq0seKcZfJ07J9m-8d9-aKcnNxkFnQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpiolib: cdev: consolidate edge detector
 configuration flags
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 12:25 PM Kent Gibson <warthog618@gmail.com> wrote:
> On Wed, Jul 13, 2022 at 12:07:29PM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:

...

> > >         struct linereq *lr;
> > >         struct gpio_v2_line_event le;
> > >         int level;
> > > -       u64 eflags;
> > > +       u64 edflags;
> >
> > I would at the same time move it up before `int level;`.
>
> Ok.  What is the general rule you want applied, cos I'm not seeing it.

Common sense.
But here are two informal recommendations:
1) longer line first;
2) you may still group by struct, POD or other flavours (see below).

...

> > > +       int level = -1, diff_seqno;
> > > +       u64 eflags, edflags = READ_ONCE(line->edflags);
> >
> > Ditto.

Here is obviously the longer line case.

...

> > >         u32 debounce_period_us;
> > >         unsigned long irqflags = 0;
> > >         int irq, ret;
> > > +       u64 eflags;
> >
> > Ditto for similarity.

Here and in other cases above, swapping them won't interleave the
types grouping (like int-u64-int). But in some cases it's allowed when
you put the last definition in the block the definition of the
variable that keeps the returned value.

-- 
With Best Regards,
Andy Shevchenko
