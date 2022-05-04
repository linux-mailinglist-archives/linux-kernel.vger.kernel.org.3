Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD37F51A146
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350818AbiEDNvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350707AbiEDNvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:51:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9D71DA66
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:48:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g28so2428386ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGeVcjcx7ubf0H6xiQHVeNK7WJ7KHB5Hzo+aIBcdMbw=;
        b=r7wfh/o/QkAiLYnjT0XQ7rglMN/ysdTnZawwtLudKJmq+KL1bkfCVgI6njx595p4Ae
         X0MheeNzMY31n2WxT/glP5VXfmkjB+m15nM94l/6IPIMkzMioQ4NG6ObNzLyT9Rk4CEa
         OWUEbI1PLkakpGHIXj5zhg5SURsbhCJX7zwTDWq1vDVuxKq+U+a5R0Ab1DqOVwk7oMG0
         LaQ1wj9IJfiYPB9JIanXG2RNkxuqDN2ia0sZzG+OkxRwk/A16DoxkC8ApFFah/7u+ufI
         UWywU1kE1XnyKOh9J0I8MfkBVESW0qJNMw7RlBchA3GWQsijaDEZvi+C9INBCFQDDV5l
         +qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGeVcjcx7ubf0H6xiQHVeNK7WJ7KHB5Hzo+aIBcdMbw=;
        b=w6JAmOMYeszUUepp9yicOlBPQmHsjEChVCRolaQciBQWdLBpqHA4tJo18aZ5/6DaZG
         mi45qTcUfik8fm0rnjclYYLBpTLbOkXcTEtL8sAeGruhkZ06mUgXhAyFeWT4dLlp77VR
         XcT5nZY+ZHnGndrSU/qL6xxcQ+zF1tbxghqtO2RftQVAsRadhuXh5mO3H7XSYPTSL3L2
         2TXZGvTLJPC7SQGsOFpxw8pLu8AOARi4b6m0TruDUR5aDRHL1xlcEGTEyhqoNurxm1ZL
         3LdvTS6M5rsi2oZAzRuXcusGZxRVxWDGw8hAKdFd3J/zPMNuzyJCe7Rf0c5zMisx6FO3
         DjIA==
X-Gm-Message-State: AOAM532nB45nRZ04nPf1tpSy9vPEsKecUumcOX4DSItBPwAFTq1E1m5n
        xjk6y56dMjmSuQ5Hw5Q6JY+g0+txzXa7oZ+qDqB+oIgUbeIGGw==
X-Google-Smtp-Source: ABdhPJw2zAfS41ZGf/imf+QuVsLyAdZugiJTLMc+FNrly+bXeoBf1lzM8TWsB8p1f0TGIkNpJLPFwkSTTUVrIt1ckJ4=
X-Received: by 2002:a25:9347:0:b0:649:7f07:4536 with SMTP id
 g7-20020a259347000000b006497f074536mr11795074ybo.1.1651672082491; Wed, 04 May
 2022 06:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com> <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
In-Reply-To: <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 May 2022 15:47:26 +0200
Message-ID: <CANpmjNPKyGUV4fXui5hEwc9+4y70kP_XgSnHbPObWBGyDeccYA@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     David Gow <davidgow@google.com>
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

On Wed, 4 May 2022 at 15:43, David Gow <davidgow@google.com> wrote:
>
> On Wed, May 4, 2022 at 3:09 PM Marco Elver <elver@google.com> wrote:
> >
> > Use the newly added suite_{init,exit} support for suite-wide init and
> > cleanup. This avoids the unsupported method by which the test used to do
> > suite-wide init and cleanup (avoiding issues such as missing TAP
> > headers, and possible future conflicts).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > This patch should go on the -kselftest/kunit branch, where this new
> > support currently lives, including a similar change to the KFENCE test.
> > ---
>
> Thanks! This is working for me. I ran it as a builtin using kunit_tool
> under (I had to add an x86_64-smp architecture), then use:
> ./tools/testing/kunit/kunit.py run --arch=x86_64-smp
> --kconfig_add=CONFIG_KCSAN=y --kconfig_add=CONFIG_DEBUG_KERNEL=y
> --timeout 900 'kcsan'
>
> To add the x86_64 smp architecture, I added a file
> ./tools/testing/kunit/qemu_configs/x86_64-smp.py, which was a copy of
> x86_64.py but with 'CONFIG_SMP=y' added to XXXX and '-smp 16' added to
> YYYY.
> It took about 10 minutes on my system, so the default 5 minute timeout
> definitely wasn't enough.

The trick to reduce the KCSAN test time is to set
CONFIG_KCSAN_REPORT_ONCE_IN_MS=100 or lower. So should you consider a
special KUnit config, I'd add that.

> (It's maybe worth noting that kunit_tool's output is pretty ugly when
> this isn't running on an SMP system, as the skipped subtests -- plus
> the "no tests run" errors -- take up a lot of space on the screen.
> That's possibly something we should consider when we look further into
> how the kunit_tool NO_TEST result works. Not really related to this
> change (or even this test) though.)
>
> No complaints about the patch: I'm just really glad to see things
> migrate off custom init/exit code!
>
> Reviewed-by: David Gow <davidgow@google.com>

Thank you!

> -- David
>
> >  kernel/kcsan/kcsan_test.c | 31 +++++++++++++------------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index a36fca063a73..59560b5e1d9c 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -1565,14 +1565,6 @@ static void test_exit(struct kunit *test)
> >         torture_cleanup_end();
> >  }
> >
> > -static struct kunit_suite kcsan_test_suite = {
> > -       .name = "kcsan",
> > -       .test_cases = kcsan_test_cases,
> > -       .init = test_init,
> > -       .exit = test_exit,
> > -};
> > -static struct kunit_suite *kcsan_test_suites[] = { &kcsan_test_suite, NULL };
> > -
> >  __no_kcsan
> >  static void register_tracepoints(struct tracepoint *tp, void *ignore)
> >  {
> > @@ -1588,11 +1580,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
> >                 tracepoint_probe_unregister(tp, probe_console, NULL);
> >  }
> >
> > -/*
> > - * We only want to do tracepoints setup and teardown once, therefore we have to
> > - * customize the init and exit functions and cannot rely on kunit_test_suite().
> > - */
> > -static int __init kcsan_test_init(void)
> > +static int kcsan_suite_init(struct kunit_suite *suite)
> >  {
> >         /*
> >          * Because we want to be able to build the test as a module, we need to
> > @@ -1600,18 +1588,25 @@ static int __init kcsan_test_init(void)
> >          * won't work here.
> >          */
> >         for_each_kernel_tracepoint(register_tracepoints, NULL);
> > -       return __kunit_test_suites_init(kcsan_test_suites);
> > +       return 0;
> >  }
> >
> > -static void kcsan_test_exit(void)
> > +static void kcsan_suite_exit(struct kunit_suite *suite)
> >  {
> > -       __kunit_test_suites_exit(kcsan_test_suites);
> >         for_each_kernel_tracepoint(unregister_tracepoints, NULL);
> >         tracepoint_synchronize_unregister();
> >  }
> >
> > -late_initcall_sync(kcsan_test_init);
> > -module_exit(kcsan_test_exit);
> > +static struct kunit_suite kcsan_test_suite = {
> > +       .name = "kcsan",
> > +       .test_cases = kcsan_test_cases,
> > +       .init = test_init,
> > +       .exit = test_exit,
> > +       .suite_init = kcsan_suite_init,
> > +       .suite_exit = kcsan_suite_exit,
> > +};
> > +
> > +kunit_test_suites(&kcsan_test_suite);
> >
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Marco Elver <elver@google.com>");
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >
