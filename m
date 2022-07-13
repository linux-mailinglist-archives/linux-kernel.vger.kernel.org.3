Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B8573417
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiGMKZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGMKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:25:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A82E0B8;
        Wed, 13 Jul 2022 03:25:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y141so9847356pfb.7;
        Wed, 13 Jul 2022 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mORAnmVYynEoBlYDjmoHZD1onSOI2rZkmi5yptxXWS4=;
        b=Mz+eQNQJBUFqrwEnuIqLwdLe8ef7x7szzU+qZlYKEKxlf1Oh7I0p4aZpdKdWr0FGKN
         9YJX3LSN1QtLfc0gBN32WarrFahkdO/oQETomQijQ5uA6aEAEERBPylO9hlkjCGgxK0F
         gRy355kttp8aeKWKARk4xP5yprmIHNkVBmwg6/Swn1BuPWe7umJRj+iNj7qRd5f1tG9E
         QcNea1Vg+muMsPK8lwdVDQGXURRYvNHseAqFq6W7UWP1WXTjNOLsvvl3mD0aSj/MEbXs
         8Aea1k0HJHt191VZDZQW6FdiQ1GTGO9pLGrgzlCvMvLeSlUqfqs+b/jQ7Jm5hyloM5NV
         7iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mORAnmVYynEoBlYDjmoHZD1onSOI2rZkmi5yptxXWS4=;
        b=M2EAWzQJxMOcbRfbjQz0KImG+vcaG2wf04zf8Ad4akeBM0zOwpVHrXAG2Dm/MvCKJR
         ErJgM7e9OaV2YXVZlyrYHt8SE0P/cCJK5Z90QjFVEa+UYhWwBCA/gJpppMN/2GGdE/2r
         Lagb2D3ZnEQfQz3c7o7lHN3JG3XBzjPSKYdLT20nBGcRQWYeWyulttIih5EyElNQujrU
         zg2AeMX2JcWIx+Dhro36V7OKXoEbXxzRFCnIzA8kGv6mpEUqMaRN12RXS4wsl8mBPxiv
         UJ3ah1rHGrX4w5H/p3cyjbCBqXxdkDhPvzBTDugTfLnUwSfX9a2E6qL1yf0hIGZcmimk
         ElSw==
X-Gm-Message-State: AJIora8xn8xtTkEVtED1jKw3fB09e5uiF2/t620SA8OdvbaYeyn2IgP3
        DTZuCNTLXU2evlNPONDRKdY4C9r7AxA=
X-Google-Smtp-Source: AGRyM1tZ/J1fjHJRhTPOq2UfYqT80L7FIYZCKGt9z+seG9/LJXqdXKXrOBFS+nILE+MwdETXCizhGQ==
X-Received: by 2002:a63:244:0:b0:412:a3c3:3ebe with SMTP id 65-20020a630244000000b00412a3c33ebemr2243109pgc.185.1657707905492;
        Wed, 13 Jul 2022 03:25:05 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id gf17-20020a17090ac7d100b001ef87123615sm1220062pjb.37.2022.07.13.03.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:25:04 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:24:59 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [PATCH 5/6] gpiolib: cdev: consolidate edge detector
 configuration flags
Message-ID: <20220713102459.GA113115@sol>
References: <20220713013721.68879-1-warthog618@gmail.com>
 <20220713013721.68879-6-warthog618@gmail.com>
 <CAHp75VeTyS_77LCp6Uab18M3hJ0dtf5jiSSrPN4tHaBHFEUTkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeTyS_77LCp6Uab18M3hJ0dtf5jiSSrPN4tHaBHFEUTkg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:07:29PM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 3:39 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > Combine the polarity_change flag, struct line eflags, and hte enable
> > flag into a single flag variable.
> >
> > The combination of these flags describes the configuration state
> > of the edge detector, so formalize and clarify that by combining
> > them into a single variable, edflags, in struct line.
> >
> > The edflags is a subset of the GPIO_V2_LINE_FLAGsb relevant to
> > the edge detector, and is also a superset of the eflags it replaces.
> > The eflags name is still used to describe the subset of edflags
> > corresponding to the rising/falling edge flags where edflags is
> > masked down to that subset.
> >
> > This consolidation reduces the number of variables being passed,
> > simplifies state comparisons, and provides a more extensible
> > foundation should additional edge sources be integrated in the
> > future.
> 
> I believe that you have checked this from a locking perspective, so we
> won't have worse lock contamination, if any.
> 

Yeah, they are used in the same way as the old eflags, so there is no
change in that regard.

> ...
> 
> >         struct linereq *lr;
> >         struct gpio_v2_line_event le;
> >         int level;
> > -       u64 eflags;
> > +       u64 edflags;
> 
> I would at the same time move it up before `int level;`.
> 

Ok.  What is the general rule you want applied, cos I'm not seeing it.

Cheers,
Kent.

> ...
> 
> > +       int level = -1, diff_seqno;
> > +       u64 eflags, edflags = READ_ONCE(line->edflags);
> 
> Ditto.
> 
> ...
> 
> >         u32 debounce_period_us;
> >         unsigned long irqflags = 0;
> >         int irq, ret;
> > +       u64 eflags;
> 
> Ditto for similarity.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
