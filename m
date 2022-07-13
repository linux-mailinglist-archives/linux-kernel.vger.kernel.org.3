Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57233572F58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiGMHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiGMHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:38:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4168FE306E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:38:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so18384052ejs.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlY3VXM/QHzKvU9o+3MNd2IiJhLzdLo1xoINNsP4UTs=;
        b=LB7Y3psQVVEiOl2wnU1xWwm+mTj7HaqJSzK5Y8tJZ8U4jz7z7+3R+o8GMnsOAAjhtw
         nXD4wzj55zC5Yz8Wrb14/cm4hmZ6hSmT272bBMkMefJVMd3DW6Xb/xDrQD5OgLCG1/t0
         svYqgyHqfWQmExcgFCssubphWfZwVJJftNeE2dxPXazfmf84jWmyWL2/Huaw0/ds2WKD
         HWVwSsprP31zdxbgFjLYAzmPQv5nMSeV/gkWrhYxDVSdrBnA199csc5EI0m4M9YLdBEq
         0EMuPrVaytCtcWv3rKgXwbLqU0woI5P4hNUXsS/f/sUldYtD8vZi2qgVCUBztw+2Wu5w
         Nk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlY3VXM/QHzKvU9o+3MNd2IiJhLzdLo1xoINNsP4UTs=;
        b=E3Sjb+9Qg1gBemS9wHFtwjybTuqVuWA8PNAPaPxlwMRurei7uoAPuNheMnlij3wC3i
         UhFPe5xAoPAsr72uDRh8XQI0u3/IGNzYQbC0vArfoPgWwafVEnyn3WejDqjZr8q+R3jL
         4SE5XHDawPAMLUpQ8/xHK2TDzAipMgO92qhF7WUnGyogmpf3wx9R7VShscMDT26iRwlU
         3Mit7pSgiBh8wjKdU0qOmj+L5jGSgQ6mfcqp0ksGomYQCTApTusJTo3yvtg+zU8+Ake0
         edSVUwoR20ha0ub1viBTXf6uB4sFPRo3B9rJlCotISVYiPdssBzrqUhhA9H67GWJNLEW
         Vwtw==
X-Gm-Message-State: AJIora8eYnWiyYRxN3pjbcl1Clc2PKZXx/ECbRQOqhGncAehdFE3g+j1
        TAAdLrZgwVxinP78y6lCjPir8Jb4dMxiGWo3WpUstQ==
X-Google-Smtp-Source: AGRyM1talQC7qA2uYMm1I+tSsqNtJ8wetRjtoOUdNOeXBd1ccqb56IY9Ru1CB4OPrwcdOJUN+qucVhR6iEQKAm/oL+A=
X-Received: by 2002:a17:907:2c4a:b0:72b:5b9b:9c50 with SMTP id
 hf10-20020a1709072c4a00b0072b5b9b9c50mr2145734ejc.636.1657697881725; Wed, 13
 Jul 2022 00:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657216200.git.william.gray@linaro.org> <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com> <YszlP1+sBhxvz3Fo@fedora>
In-Reply-To: <YszlP1+sBhxvz3Fo@fedora>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Jul 2022 09:37:51 +0200
Message-ID: <CAMRc=Mc0=nL_t9Fwmb1uNbsa_v4L4M5BJm2y-vZ8PV47Ryk+Sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 5:06 AM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> On Mon, Jul 11, 2022 at 03:02:10PM +0200, Linus Walleij wrote:
> > On Fri, Jul 8, 2022 at 1:16 AM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> >
> > > Exposes consumer functions providing support for Intel 8255 Programmable
> > > Peripheral Interface devices. A CONFIG_GPIO_I8255 Kconfig option is
> > > introduced; modules wanting access to these functions should select this
> > > Kconfig option.
> > >
> > > Tested-by: Fred Eckert <Frede@cmslaser.com>
> > > Cc: John Hentges <jhentges@accesio.com>
> > > Cc: Jay Dolan <jay.dolan@accesio.com>
> > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> >
> > This chip is like 50 years old, but so am I and I am not obsolete, it's about
> > time that we implement a proper driver for it!
> >
> > But I suppose you are not really using the actual discrete i8255 component?
> > This is certainly used as integrated into some bridge or so? (Should be
> > mentioned in the commit.)
>
> Interestingly, there are some PC/104 devices out there that use actual
> i8255 components (e.g. Diamond Systems Onyx-MM with its 82C55 chips),
> but honestly the majority of devices I come across are simply emulating
> the i8255 interface in an FPGA or similar.
>
> I'll adjust the commit to make it clearer that this is a library for
> i8255-compatible interfaces rather than support for any physical Intel
> 8255 chip in particular.
>
> > > +config GPIO_I8255
> > > +       tristate
> >
> > That's a bit terse :D Explain that this is a Intel 8255 PPI chip first developed
> > in the first half of the 1970ies.
>
> Ack.
>
> > > +++ b/include/linux/gpio/i8255.h
> >
> > You need to provide a rationale for the separate .h file in the commit
> > message even if it is clear
> > how it is used in the following patches.
> >
> > Yours,
> > Linus Walleij
>
> I think I'll move this to gpio/driver.h as per Andy Shevchenko's

I don't think this is what Andy meant. I think he suggested moving
this header into drivers/gpio/ because it doesn't make sense for it to
be publicly accessible for anyone else than the GPIO drivers.

Andy: correct me if I'm wrong.

Bart

> suggestion. For now only a few drivers under drivers/gpio/ use this
> library, so it probably doesn't need to be separate just yet.
>
