Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5613C58FCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiHKMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiHKMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC77089928
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660221839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=519IfCfIaIEiaBspR8OgsiWe3H9s5RpR3pee6j3OXrw=;
        b=g+ZTs6ZPy/a5C7OyZlN6TWOcVBxwV2RmpQk/ok2X6onlSjHx10DX87sgRz27xhA10y5yCN
        gvkggNiIcUSAvS4pzbDicyGXJ+JT62xx7GneP4WkrN07ndNunEG47PL8UjnCLQoKuONjih
        jOda440BBUaBJc+0Zu+eB0B+cUYXCRk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-DjJGebecPIeMCbAo_-wbMQ-1; Thu, 11 Aug 2022 08:43:58 -0400
X-MC-Unique: DjJGebecPIeMCbAo_-wbMQ-1
Received: by mail-ed1-f72.google.com with SMTP id m22-20020a056402431600b0043d6a88130aso10755999edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=519IfCfIaIEiaBspR8OgsiWe3H9s5RpR3pee6j3OXrw=;
        b=OjiC8Ebg2/gA4Iygk2mstwFI5JfFNOjdSgd+RNQ9tYlP10Yqjwivud1yDlT9J294MQ
         lK0Bse505+aCH84Xiq/7eCmJP83dRPSCeAx2/Yr94DuPA0sliW7PuuCgM/ZD9lXAHOzd
         nrUIkfuW4BaTSW2buFTVCknN/7PbKKmG70Mf20+1lb6foj4qFMpY/vBBNFHtujNOJIzs
         B9E0BoCUdLvZ7HFEKGblfLCHzyvD78Pf/5nJkxbd3izYZReCqSypZNKoICYoIW9lD695
         gikHP166keAWCQGH381ztHjaWNRL1ETsURRCKvh2//djxXZIL29clAR8tTzok5JFAUZX
         DlzA==
X-Gm-Message-State: ACgBeo1KzYDnlJNc964RQuIql0S9mGOnTMxqKFzgG3xR3uQgI+Z7ApUO
        +E4ehmd5zl4eyUI9p1uZTTpdUTxwB5GOOlhGT3XRw5sNtHvGnCEd87JoENqfKdCpRaAiODtunud
        KDbw3WARMnZft9aNta2btJD+9xrmea0RKBGZ61VG9
X-Received: by 2002:a05:6402:1bcf:b0:443:1c7:cd07 with SMTP id ch15-20020a0564021bcf00b0044301c7cd07mr2483197edb.365.1660221837693;
        Thu, 11 Aug 2022 05:43:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6BQ+ukW/OILBIVEwiikKu/2YOrsmB3Jm4hsmMTKAYd3aASj+Rk+GDlOpfAOZmzBVAP2EOFOJLG7HamTc3wDdw=
X-Received: by 2002:a05:6402:1bcf:b0:443:1c7:cd07 with SMTP id
 ch15-20020a0564021bcf00b0044301c7cd07mr2483172edb.365.1660221837436; Thu, 11
 Aug 2022 05:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220810234056.2494993-1-npache@redhat.com> <CABVgOSmUgkeuKKS_UYMOTUE4vARLpw--j77J9=zAkk5Zr30N9g@mail.gmail.com>
In-Reply-To: <CABVgOSmUgkeuKKS_UYMOTUE4vARLpw--j77J9=zAkk5Zr30N9g@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Date:   Thu, 11 Aug 2022 08:43:30 -0400
Message-ID: <CAA1CXcBjf411E7gCbTfowpOmas-ykuVCyn1B4oAua_VKxMkOCg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves
To:     David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>, alcioa@amazon.com,
        lexnv@amazon.com, Andra Paraschiv <andraprs@amazon.com>,
        YehezkelShB@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        michael.jamet@intel.com, andreas.noever@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 8:20 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Aug 11, 2022 at 7:41 AM Nico Pache <npache@redhat.com> wrote:
> >
> > Both the USB4 and Nitro Enclaves KUNIT tests are now able to be compiled
> > if KUNIT is compiled as a module. This leads to issues if KUNIT is being
> > packaged separately from the core kernel and when KUNIT is run baremetal
> > without the required driver compiled into the kernel.
> >
> > Fixes: 635dcd16844b ("thunderbolt: test: Use kunit_test_suite() macro")
> > Fixes: fe5be808fa6c ("nitro_enclaves: test: Use kunit_test_suite() macro")
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
>
> Hmm... I'm not quite sure I understand the case that's broken here. Is it:
> - KUnit is built as a module (CONFIG_KUNIT=m)
> - USB4/nitro_enclaves are also built as modules, with the test enabled.
> - The kunit module is not available at runtime, so neither driver
> module can load (due to missing kunit dependencies)
Exactly, except the issue is also when the USB/NE=y not just when they
are modules. This is currently creating an issue with our build system
during the depmod stage and has been preventing us from generating
Fedora builds.
>
> If so, that's not a case (i.e., the kunit.ko module being unavailable
> if it was built) we've tried to support thus far. I guess a de-facto
> rule for supporting it would be to depend on KUNIT=y for any KUnit
> tests which are built into the same module as the driver they're
> testing.
Yeah, although it's not been a case you've been trying to support, it
has been working so far :) This has been the case (built-in tests
utilizing 'depends on KUNIT=y') since we began supporting KUNIT in our
testing infrastructure and it would be nice to keep that as a de-facto
rule :)
>
> Alternatively, maybe we could do some horrible hacks to compile stub
> versions of various KUnit assertion symbols in unconditionally, which
> forward to the real ones if KUnit is available.
>
> (Personally, I'd love it if we could get rid of CONFIG_KUNIT=m
> altogether, and it's actually broken right at the moment[1]. There are
> still some cases (unloading / reloading KUnit with different filter
> options) which require it, though.)
Personally I'd hate to see KUNIT=m go as that is how we have been able
to support running Kunit tests so far.

A little background on how we utilize Kunit. We build with KUNIT=m and
KUNIT_ALL_TESTS=m and run the tests baremetal.
Our build system creates 3 packages (kernel, kernel-modules, and
kernel-modules-internal), this allows us to ship the kernel and its
modules, while also isolating packages that we dont want to ship
outside of QE and developers. We then have our own infrastructure in
place to run and collect the output of these tests in our pipelined
environments. We dont utilize UML because we dont support that feature
in RHEL.

Fedora uses this same methodology for running KUNIT, so we are
frequently running kunit on an 'upstream' variant.

I'm not sure how many organizations are supporting continuous KUNIT
testing, or how they are achieving it, but dropping module support
would prevent us from doing the CI testing we have in place.

Cheers!
-- Nico
>
> Cheers,
> -- David
>
> [1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20220713005221.1926290-1-davidgow@google.com/
>
> >  drivers/thunderbolt/Kconfig         | 3 +--
> >  drivers/virt/nitro_enclaves/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> > index e76a6c173637..f12d0a3ee3e2 100644
> > --- a/drivers/thunderbolt/Kconfig
> > +++ b/drivers/thunderbolt/Kconfig
> > @@ -29,8 +29,7 @@ config USB4_DEBUGFS_WRITE
> >
> >  config USB4_KUNIT_TEST
> >         bool "KUnit tests" if !KUNIT_ALL_TESTS
> > -       depends on (USB4=m || KUNIT=y)
> > -       depends on KUNIT
> > +       depends on USB4 && KUNIT=y
>
> This can probably just:
> depends on KUNIT=y
>
>
> >         default KUNIT_ALL_TESTS
> >
> >  config USB4_DMA_TEST
> > diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
> > index ce91add81401..dc4d25c26256 100644
> > --- a/drivers/virt/nitro_enclaves/Kconfig
> > +++ b/drivers/virt/nitro_enclaves/Kconfig
> > @@ -17,7 +17,7 @@ config NITRO_ENCLAVES
> >
> >  config NITRO_ENCLAVES_MISC_DEV_TEST
> >         bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
> > -       depends on NITRO_ENCLAVES && KUNIT
> > +       depends on NITRO_ENCLAVES && KUNIT=y
> >         default KUNIT_ALL_TESTS
> >         help
> >           Enable KUnit tests for the misc device functionality of the Nitro
> > --
> > 2.36.1
> >
>

