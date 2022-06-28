Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CB55EA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiF1RGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiF1RGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:06:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1814E2B1BE;
        Tue, 28 Jun 2022 10:06:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c1so20915600qvi.11;
        Tue, 28 Jun 2022 10:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8bQ8ei1JkcwOHR5YxHEw7aHiNSi0KYBwHi+TZqv03IU=;
        b=i5dDrqOMKlZHRI0VmPlke/MZaZP5psV64tvfJ/TY/NYY10OAtco34+1btuy0I9jCiT
         CYq/P/u4f8kZpFNXLFZ4dIHvQ8j7I4rdh69AcN7/jjE6sE6ZJI3m+q3FCX9bKxAQIu+Z
         t2JRrw31ixhFlXaG13J7nLd8WwqLY4i1FhWobytrjeoMRtrVpSA1bXLbb9hPfQA629fF
         dH2EfTdZTd52GWkXMwjhFJoPIWSKUIMZ8sh1bRqGHNYd4MmiW0LsxxqPBbyPheTaxj24
         gSFi9jNL76HmCR2+K+UhSYYtPq5oKB3OFzy/rSNEiIv6VOnA5pUYBaEhjkRCMaG9ZZYC
         yDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bQ8ei1JkcwOHR5YxHEw7aHiNSi0KYBwHi+TZqv03IU=;
        b=y4CkdD1KV5OD7EFIxiyWw02wXswS82pbKP0UZN4rMsJBiCiAoQGGUH8zbeUH8/Bv5p
         dCpXi/mH9sQ+IUEG3EA4LZcl0OyDaxKVhvirU54f67kwTwH4rFsWHIv9MQvJjkIpgpZh
         6H6D2caW4b0o6XRLfbPRaE4F48EtvtEfcMMEl/w97eG26R5ZTKLcw0kzTxGIaOzcwrwe
         2AL0reYSjUy03hRdAo2+Tsaa6APZQnloagNuxZU4oYoRrt5DeMbs2Pfi9x8yEFujkFrr
         8MbyDh3l25g9BFOR0sUNxOq7yHYcH3OXP12msiHUDa4qxKt5TKUHdQXdcJ24Ki/nQzZH
         XTiA==
X-Gm-Message-State: AJIora8HgnQxgLs+O1mJgXAyNdgkABN7XR3LX5s6DfWc3t0Q3BE/Homy
        TZWH+ep0rosutQNZLHFGKTsHEfiNvHI=
X-Google-Smtp-Source: AGRyM1vBV0bhd9khvvCwxnpInVjHXx6m51xNDclsodRJzCWiltlCTvyGCEbQ62Nnhj+u8W8fc/Qcjw==
X-Received: by 2002:ac8:5f4e:0:b0:31b:f5e3:6e97 with SMTP id y14-20020ac85f4e000000b0031bf5e36e97mr2093706qta.623.1656435992102;
        Tue, 28 Jun 2022 10:06:32 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id br14-20020a05620a460e00b006a6ce613c7csm6250443qkb.89.2022.06.28.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:06:30 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:06:26 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v15 06/10] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <Yrs1EgYZMArqmdb0@shaak>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
 <20220213025739.2561834-7-liambeguin@gmail.com>
 <CAMuHMdVMhLRS+XuX_8O5UPHzoOp6a6XpTvysQS+nT+GLkL7gjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVMhLRS+XuX_8O5UPHzoOp6a6XpTvysQS+nT+GLkL7gjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jun 27, 2022 at 09:22:29AM +0200, Geert Uytterhoeven wrote:
> Hi Liam,
> 
> On Mon, Feb 14, 2022 at 12:00 AM Liam Beguin <liambeguin@gmail.com> wrote:
> > The iio-rescale driver supports various combinations of scale types and
> > offsets. These can often result in large integer multiplications. Make
> > sure these calculations are done right by adding a set of kunit test
> > cases that build on top of iio-test-format.
> >
> > To run these tests, add the following to .kunitconfig
> >         $ cat .kunitconfig
> >         CONFIG_IIO=y
> >         CONFIG_IIO_RESCALE_KUNIT_TEST=y
> >         CONFIG_KUNIT=y
> >
> > Then run:
> >         $ ./tools/testing/kunit/kunit.py run --kunitconfig .kunitconfig
> >
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > Reviewed-by: Peter Rosin <peda@axentia.se>
> 
> Thanks for your patch, which is now commit 8e74a48d17d509bf
> ("iio: test: add basic tests for the iio-rescale driver") in v5.18.

Thanks!  I also recently sent a fix for this which recently made it
upstream:
7a2f6f61e8ee ("iio: test: fix missing MODULE_LICENSE for IIO_RESCALE=m")

> > --- a/drivers/iio/test/Kconfig
> > +++ b/drivers/iio/test/Kconfig
> > @@ -4,6 +4,16 @@
> >  #
> >
> >  # Keep in alphabetical order
> > +config IIO_RESCALE_KUNIT_TEST
> > +       bool "Test IIO rescale conversion functions"
> 
> Is there any reason this cannot be tristate, so I can always enable
> this as a module, and run the test by loading the module whenever
> I want?

I based this patch off of IIO_TEST_FORMAT, and also thought that Kunit
tests had to be built-in to work with tools/testing/kunit/kunit.py

Looking at the Documentation again, it seems I was (partially?) wrong,
kunit tests can be run as module, but manually.

I could give this a try and send a patch in the next few days.

Cheers,
Liam

> > +       depends on KUNIT && !IIO_RESCALE
> > +       default KUNIT_ALL_TESTS
> > +       help
> > +         If you want to run tests on the iio-rescale code say Y here.
> > +
> > +         This takes advantage of ARCH=um to run tests and should be used by
> > +         developers to tests their changes to the rescaling logic.
> > +
> >  config IIO_TEST_FORMAT
> >          bool "Test IIO formatting functions"
> >          depends on KUNIT=y
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
