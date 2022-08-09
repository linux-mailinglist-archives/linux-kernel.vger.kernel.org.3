Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354358D473
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiHIHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiHIHVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:21:12 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612E820F76;
        Tue,  9 Aug 2022 00:21:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b24so1720577qka.5;
        Tue, 09 Aug 2022 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ewp+5qWhXCvBt991DQD6+zymRA8iDfvlDFfMmvB+0a4=;
        b=cHxXURJ4qdC0PRqfs/Rqyhlqxif/QqExsU0VzM1rJRamsvm7Df7euPEo7UoRPTP6lI
         Ipi7F0SpeMjoQkBvkaFKygMuF0M95GfMz5wBaA8zLop8Z8ImS+wtsJIv/f7Jx0Z9QFOH
         vSCB1M+gHv5JEa4XAvQKWRn6zYXJtZFHHOlEVFA/2eADIZIOAZA+ATZv7EzRCeu8BxO8
         rokyLIJScYwRYY5Xj4lRYksJW7jUppHWtK8Dy4qceb9Q7sUMo6QklzDp2EGxDobEjeam
         66mpiRDm+ww6mvjZ9svyAdrlYnoi9xwfHitWQcLW+3OC5c9uKZONV6Ix9oIxOoZtPyKS
         V/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ewp+5qWhXCvBt991DQD6+zymRA8iDfvlDFfMmvB+0a4=;
        b=t5Nk85pTTfut428eSfENLNB8PmW/GStI/KDYozFydHfobV5OsMfiymFAZvoso0Q/3f
         jI4xrLkO8UwJKUvan7KhQ3yngakbPr24pEwClw352QZpjhXo3X0FlE2UD1g8zOr1CauC
         5D9F9rOhCO397WLcSRkYIJ7NLUbVXnMmgnykzP81g/kZkzOMzfqKrCaIrH/W0mP6OGBq
         bZIM30udo++e3Esm6T/uewdMc+sqjcGzjgpu1/9OdALYnzbkaWU1DgD/DRSD3eI2YvMo
         bP6XqHWuA0baQRRkDfHckoHZlt4y1k5uWrwYNxH0t152rdyhsgL5ZHZqjDymih313biA
         2ZYw==
X-Gm-Message-State: ACgBeo2SvJL8UgE3t5bIM/MWcWEY9MeZGCtcNAGckDMTJBuMWxepPrxZ
        M5oRjC0LfiqIzr4avL036bBLXYk16vt2RI/61i0OEBJAG10=
X-Google-Smtp-Source: AA6agR7/I3eg+IvnTyVzC+jl42kegbnx9pI+d5CGTyeVmc3CmVrtuxz57g7sz+HImjVkBfjZUHDpp2hNAiLIWqD8f/s=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr16521415qko.383.1660029669459; Tue, 09
 Aug 2022 00:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-3-luke@ljones.dev>
 <CAHp75VcR-strGDhaGE78NjToamK98e8UO-rQhU-Ow81AavU5YA@mail.gmail.com> <KCGBGR.P2V4UO7HLOX11@ljones.dev>
In-Reply-To: <KCGBGR.P2V4UO7HLOX11@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 09:20:32 +0200
Message-ID: <CAHp75VfYhKMuUDpSJ-yDWp7GU8bQh1q9VME8SnUvrwYm8x9=mQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] asus-wmi: Implement TUF laptop keyboard LED modes
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 11:43 PM Luke Jones <luke@ljones.dev> wrote:

...

> >>  +       if (sscanf(buf, "%hhd %hhd %hhd", &save, &mode, &speed) !=
> >> 3)
> >>  +               return -EINVAL;
> >
> > Same comment as per v1.
>
> You wrote:
>
>  > Usually we have three separate nodes for that, but they are kinda
>  > hidden in one driver, so I don't care much.
>
> I think that is the wrong direction to take. Doing so would mean that
> every write to one of these values has to write-out to device. I don't
> know how long writes on an i2c device take, but on the USB connected
> versions they are 1ms, which means that to individually set colour,
> save, mode, speed (also direction and sometimes a 2nd colour on USB)
> adds up to 4-6ms - and I don't know what sort of impact that has in the
> kernel itself, but I do know that users expect there to be fancy
> effects available on par with Windows (like audio equalizer visuals on
> the RGB, something that is in progress in asusctl).

This is a good justification, but easy to workaround by using another
node like "submit" or unifying it with one of the existing nodes
implicitly (like setting savee will submit all changes at once).

> Using multicolor LED class already breaks away from having a single
> packet write, but the gain in API scope was worth the compromise.
> Hopefully we can keep the single set of parameters here?
>
> Pavel suggested using triggers, I've yet to look at that, but will do
> so after finalising this.

The thing is you can't "finalize" this and go to another type of ABI,
because we come with two ABIs - we may not drop the old one once it's
established (yes, there are exceptions, but it's rare). So, knowing
that we would drop an ABI we mustn't introduce it in the first place.

> I suppose one alternative would be to store speed and mode as
> attributes, but not write out until the "save" node is written to?

Yes!

> So
> this raises the question of: we can't read from device, and speed+mode
> must be saved in module for use with "save" now, should I then allow
> showing these values in a _show? On fresh boot they will be incorrect..

Yep, they should be reset either by hardware, or provided somehow
(device tree?) from the platform knowing what firmware sets and what
kernel may use if you don't want to change the settings.

> I'm going to go ahead and split those parameters in to individual nodes
> now anyway - it may help with later work using triggers.

Okay!

-- 
With Best Regards,
Andy Shevchenko
