Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CBD51A169
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350886AbiEDN6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350807AbiEDN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:58:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A6B3EAAF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:54:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so2116992wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+GOwhDIbDtSZrtYRKjeg/TUTolp/DrA7B48gMykmvY=;
        b=M+vNY3afGqV5zT+k495RE4WQ+SoBAjIjehQQGndvWwReZtjlevFqTntxWmM3cUX5RL
         L5SWVVt1g59Cy4po7i1aIBzuoDPb0uQJ9cqsi025Q6kqCYDVO7fjwmMXvxF7jey7KpYY
         9hynqJ9WYDb1kdJ/Gxc0FEaW/32hAL1tzsOhJVU2OoVrkITu5OaHyZHi+rWCaOBomDgX
         IC3ITU+Ifh76Pw7Z2DXlJuzSDS3GbZjE5yLZpuxsXuix+ugYtWHO7saSMv/kgHqhZwr6
         qGCCKhl6jFiR5OSi8I2AyC5gJcQWTexJsPlQCUoj7JZ52Cj2gd4RD/tvmvqFfPlc00ou
         LDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+GOwhDIbDtSZrtYRKjeg/TUTolp/DrA7B48gMykmvY=;
        b=LKpPeg+RLhfZQVurLH5/RnRoLWgf/umwCHOUskQuMWNL+KFNFQUxoWqLArJ73PAZG3
         BKaerLEN23BBe1IcsD6CylUDZLToHwjhL9mNV3tYmZAyUSHS/q+2O6BDEpQA7SAaElfH
         HG3Rk2urFJjtJrb5vahn1HcOFNrO/vIr8tH2m4MHNWmrsaqa7m0Nt6NcitYczTGJAkF1
         jtJSc2Euxu14Feii6KZcWIo4IhoB+uo04TSTETJMD7CzxeR/CSlceR4mjYXUS5pgdpPJ
         0OmF7PeCdOuWQkErEDLFGcYKmSsZE/ss63/oA//CYC+mt2cxS/DhNyVW+SEBRFTrUuIx
         HipQ==
X-Gm-Message-State: AOAM530+2D2BEBri9Ft4t5ZGMbUky6+D7su3DgzIG+blKc/KKcWzBuc5
        jtmUtqAOqMA7d/pMnWMUSNrJeAZnTCRBeX/IowTGBQ==
X-Google-Smtp-Source: ABdhPJxKmZggzbdxPEFqaQ9Zef1tQDgYJTUyK8+USqm/aPcmCtbHupk0U9zQRhCAlnao5ogjcWTt6G4764pdlz47yn4=
X-Received: by 2002:a5d:4806:0:b0:20a:da03:711b with SMTP id
 l6-20020a5d4806000000b0020ada03711bmr16109055wrq.395.1651672471735; Wed, 04
 May 2022 06:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com> <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
 <CANpmjNPKyGUV4fXui5hEwc9+4y70kP_XgSnHbPObWBGyDeccYA@mail.gmail.com>
In-Reply-To: <CANpmjNPKyGUV4fXui5hEwc9+4y70kP_XgSnHbPObWBGyDeccYA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 4 May 2022 21:54:20 +0800
Message-ID: <CABVgOSkLGryZeWVXdfBDkQKWvSkYTk2LWx+yC9J+4FYQpn2bpQ@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 9:48 PM Marco Elver <elver@google.com> wrote:
>
> On Wed, 4 May 2022 at 15:43, David Gow <davidgow@google.com> wrote:
> >
> > On Wed, May 4, 2022 at 3:09 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Use the newly added suite_{init,exit} support for suite-wide init and
> > > cleanup. This avoids the unsupported method by which the test used to do
> > > suite-wide init and cleanup (avoiding issues such as missing TAP
> > > headers, and possible future conflicts).
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > This patch should go on the -kselftest/kunit branch, where this new
> > > support currently lives, including a similar change to the KFENCE test.
> > > ---
> >
> > Thanks! This is working for me. I ran it as a builtin using kunit_tool
> > under (I had to add an x86_64-smp architecture), then use:
> > ./tools/testing/kunit/kunit.py run --arch=x86_64-smp
> > --kconfig_add=CONFIG_KCSAN=y --kconfig_add=CONFIG_DEBUG_KERNEL=y
> > --timeout 900 'kcsan'
> >
> > To add the x86_64 smp architecture, I added a file
> > ./tools/testing/kunit/qemu_configs/x86_64-smp.py, which was a copy of
> > x86_64.py but with 'CONFIG_SMP=y' added to XXXX and '-smp 16' added to
> > YYYY.

(Whoops, forgot to copy this in properly: XXXX was 'kconfig' and YYYY
was 'extra_qemu_params'.)

The x86_64-smp.py file ends up looking like this:
---8<---
from ..qemu_config import QemuArchParams

QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
                          kconfig='''
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SMP=y
                          ''',
                          qemu_arch='x86_64',
                          kernel_path='arch/x86/boot/bzImage',
                          kernel_command_line='console=ttyS0',
                          extra_qemu_params=['-smp 16'])
---8<---
> > It took about 10 minutes on my system, so the default 5 minute timeout
> > definitely wasn't enough.
>
> The trick to reduce the KCSAN test time is to set
> CONFIG_KCSAN_REPORT_ONCE_IN_MS=100 or lower. So should you consider a
> special KUnit config, I'd add that.
>

Ah: it might be worth adding a dedicated kcsan .kunitconfig, in which
case this would be helpful. It'd also need the SMP qemu config above
before it's particularly useful, and 16 was a randomly-picked number
of CPUs -- not sure if there's a better default.

If you're likely to use it, though, we can definitely add it in. I'm
sure there'll eventually be other uses for an SMP config under
kunit_tool, too.

> > (It's maybe worth noting that kunit_tool's output is pretty ugly when
> > this isn't running on an SMP system, as the skipped subtests -- plus
> > the "no tests run" errors -- take up a lot of space on the screen.
> > That's possibly something we should consider when we look further into
> > how the kunit_tool NO_TEST result works. Not really related to this
> > change (or even this test) though.)
> >
> > No complaints about the patch: I'm just really glad to see things
> > migrate off custom init/exit code!
> >
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Thank you!
>
> > -- David
> >
> > >  kernel/kcsan/kcsan_test.c | 31 +++++++++++++------------------
> > >  1 file changed, 13 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > > index a36fca063a73..59560b5e1d9c 100644
> > > --- a/kernel/kcsan/kcsan_test.c
> > > +++ b/kernel/kcsan/kcsan_test.c
> > > @@ -1565,14 +1565,6 @@ static void test_exit(struct kunit *test)
> > >         torture_cleanup_end();
> > >  }
> > >
> > > -static struct kunit_suite kcsan_test_suite = {
> > > -       .name = "kcsan",
> > > -       .test_cases = kcsan_test_cases,
> > > -       .init = test_init,
> > > -       .exit = test_exit,
> > > -};
> > > -static struct kunit_suite *kcsan_test_suites[] = { &kcsan_test_suite, NULL };
> > > -
> > >  __no_kcsan
> > >  static void register_tracepoints(struct tracepoint *tp, void *ignore)
> > >  {
> > > @@ -1588,11 +1580,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
> > >                 tracepoint_probe_unregister(tp, probe_console, NULL);
> > >  }
> > >
> > > -/*
> > > - * We only want to do tracepoints setup and teardown once, therefore we have to
> > > - * customize the init and exit functions and cannot rely on kunit_test_suite().
> > > - */
> > > -static int __init kcsan_test_init(void)
> > > +static int kcsan_suite_init(struct kunit_suite *suite)
> > >  {
> > >         /*
> > >          * Because we want to be able to build the test as a module, we need to
> > > @@ -1600,18 +1588,25 @@ static int __init kcsan_test_init(void)
> > >          * won't work here.
> > >          */
> > >         for_each_kernel_tracepoint(register_tracepoints, NULL);
> > > -       return __kunit_test_suites_init(kcsan_test_suites);
> > > +       return 0;
> > >  }
> > >
> > > -static void kcsan_test_exit(void)
> > > +static void kcsan_suite_exit(struct kunit_suite *suite)
> > >  {
> > > -       __kunit_test_suites_exit(kcsan_test_suites);
> > >         for_each_kernel_tracepoint(unregister_tracepoints, NULL);
> > >         tracepoint_synchronize_unregister();
> > >  }
> > >
> > > -late_initcall_sync(kcsan_test_init);
> > > -module_exit(kcsan_test_exit);
> > > +static struct kunit_suite kcsan_test_suite = {
> > > +       .name = "kcsan",
> > > +       .test_cases = kcsan_test_cases,
> > > +       .init = test_init,
> > > +       .exit = test_exit,
> > > +       .suite_init = kcsan_suite_init,
> > > +       .suite_exit = kcsan_suite_exit,
> > > +};
> > > +
> > > +kunit_test_suites(&kcsan_test_suite);
> > >
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_AUTHOR("Marco Elver <elver@google.com>");
> > > --
> > > 2.36.0.464.gb9c8b46e94-goog
> > >
