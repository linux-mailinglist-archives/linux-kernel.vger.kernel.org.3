Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C34516AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383464AbiEBGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiEBGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:37:03 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860EF26AEE;
        Sun,  1 May 2022 23:33:35 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id z15so4978241uad.7;
        Sun, 01 May 2022 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=r7aP0gyFyZt3gF8iAxTBfoVEW9XCdzHT3REnq2wtHCA=;
        b=JLRCbIkCpIi/iFIK19GbsqtUjOoKZBzhtv/6ru/k8+Y9G2rTSEQlDnXVbChANo088B
         N6NpUCxyuMEDKa3Jw2uXJmOkUkMm5ic7D70hvL0DBH4TupsP7rdM35Dw6crO5UhMPmad
         vtHrTNir7v7XE8ASPm8DlyUgCslRO+IlttYfhLLshSiC5udcceedYiZHnkkCgDLD+h6D
         RpXyk1LOlvbh3pFaYN8EuLrttNNru8d7FxpL7AuteLLSIPdnzHUcw2JIZMX5eL90iVkC
         jrIOIUxxf4pE6GT4w/wpnBqCU3wJl0mdwsiXlZeXqO2SQ4nbx1l82ihbNrxehr29kqqt
         OphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=r7aP0gyFyZt3gF8iAxTBfoVEW9XCdzHT3REnq2wtHCA=;
        b=7cw65TaY0WGCyXaRYr88RxnYMowTqtddQMjlDy+khYF/PqW4zWqjEvYOnNGXpvwLpw
         WhJMEzDZHPEJBuiag1f4d8lRpVFf4MJIOzMaXlFh9Vk5yiBh4wleAhqB7Bk3GyQl5BcG
         67JE+8abXRKIMY27VaAv1s/hTEmh0sJ2Tqsn7w8w3xAi/v/zrEWeGUFkf+uCXS1WIRhi
         4wMOjjQES0cEOhyD/US+7A/XrQZcozetzRbHe7wdFNNkRezCI5nOCTCSMQy5UVHiz497
         oe6lpVvrOxKGf7gxgI2QyaEvRDRbLGS7f698CS6Hw3RpewT1myTkNSojmXkiALowB/aM
         4UEA==
X-Gm-Message-State: AOAM531kVA4zwkAZZVMh0SAIq7a/g58CqV+aLCgoaO0xkipdSW4z90Ia
        CvW3oTHZDgnVnsqpto6weFf3DDsFd47hhrvexSm9YnzWBxjah5jK
X-Google-Smtp-Source: ABdhPJz6dodclJhDrbEBYxaGhnLdvZMs83xk9fpaKgn6rBqMqvRJIhJ0tyllUShYcKxKQLtNRvAe+lzQbtaZzz4FXr8=
X-Received: by 2002:ab0:1525:0:b0:365:95fa:4e51 with SMTP id
 o34-20020ab01525000000b0036595fa4e51mr555330uae.121.1651473213516; Sun, 01
 May 2022 23:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <CAHp75VcoXu=0yvxmTwGAzexV_MgACXg-Cufkigt_kCEvbnwq_Q@mail.gmail.com> <20220501180303.75a0d0a5@jic23-huawei>
In-Reply-To: <20220501180303.75a0d0a5@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 2 May 2022 08:33:22 +0200
Message-ID: <CAN8YU5PYkQhqrGP8qUK6BgVWVWWECQvYGrSiREU7P5r4kFxVjA@mail.gmail.com>
Subject: Re: [v5 00/14] Add support for Bosch BNO055 IMU
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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

Il giorno dom 1 mag 2022 alle ore 18:54 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Wed, 27 Apr 2022 15:42:49 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Tue, Apr 26, 2022 at 3:11 PM Andrea Merello <andrea.merello@gmail.com> wrote:
> > >
> > > From: Andrea Merello <andrea.merello@iit.it>
> > >
> > > This series (tries to) add support for Bosch BNO055 IMU to Linux IIO
> > > subsystem. It is made up several patches:
> > >
> > >   1/14 to 6/14: add some IIO modifiers, and their documentation, to the IIO
> > >                 core layer, in order to being able to expose the linear
> > >                 acceleration and Euler angles among standard attributes.
> > >                 Also update the IIO event monitor tool
> > >
> > >   7/14: fix binary attributes didn't work with IIO
> > >
> > >   8/14 to 11/14: add the core IIO BNO055 driver and documentation for sysfs
> > >                  attributes and DT bindings
> > >
> > >   12/14: adds serdev BNO055 driver to actually use the IMU via serial line
> > >
> > >   13/14: adds I2C BNO055 driver to actually use the IMU via I2C wiring
> > >
> > >   14/14: add a documentation file that describe the bno055 driver and
> > >          specifically the calibration
> >
> > FWIW,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > for non-commented patches (12 out of 14 AFAICS).
> >
> FWIW I'm fine with the series once you've tidied up the stuff Andy picked up
> on.
>
> Thanks Andy for the detailed reviewing btw.
>
> Jonathan

I'm very grateful to both of you and to everyone who commented on
those patches. Thanks :). Beside the "Reviewed-by" tags where
appropriate, is it usual/appropriate to put some tag like "Thanks-to
.. [for comments]" ?

BTW I have also gone through some kernel-robot reports; they also
state "If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>". I'd say that it would
be OK to add this tag to a patch that just fixes what is reported, but
I'm unsure whether it is appropriate to add this tag to the patches in
my series, because they add the code and the fix at once. Any advice
here?

Andrea
