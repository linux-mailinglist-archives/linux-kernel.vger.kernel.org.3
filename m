Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E272A51A131
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350770AbiEDNrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350766AbiEDNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:47:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14282FFEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:43:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so2074781wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBqq6UprR1Yrhinom9y32Umswbttty4rMVtulmJXvwU=;
        b=RwgLbatbKNiJCxHnjM7Qtw2bcrhGQtkJ2mJ1LvQIS+CuVtI7Syx4no8gmzsYwZbKJD
         a3aBjdlIhGaCLJoAdPLkhW4Ytsj4crbWLZd2Q948Ce0UPPT7r9/82kla7sNZGl3HrgKB
         SIZA6dgC45cWOVNxsu1iODyE/b20eOYAjmmZvHjpGASSQ3oecwk5ZGMjoP88JoqQhCPi
         wAkLJvhDQ+fZDX6NClXKv0wdEMBadBPoFhFHBd13DfYQoyk0PJq6ZcrKHIwrziRSjjI3
         TBHupHd48/6OCjqE2godf9+MK83C1yK/r51WkrBbzNMOpWtHkD0o9F78PG2rciHgNKau
         CeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBqq6UprR1Yrhinom9y32Umswbttty4rMVtulmJXvwU=;
        b=uRF6Xkmp+Er6v8FjJO8qzwNBwDL2qCJCSHqsOBdOVJ315jwMJX982aXS45JzJu//gn
         Ykh62MvugQx4GQbhlEiJMLFxgCFKtaMQwnIUZfGUnaeiPF3oSz8EW417Vz5Z+IHaXEtl
         NF2YXHKsIiUOFTSf+M6+YRATUsZX+BNThO5FqnAuYpOCu7jSboqpzhWr2XktTSTMRauO
         E9MoI7A70vij/aFa9X4HL/UhAsri4PjtoGPeTzrNqr6zkbvAXoIkooiTeJEm5+WFWtag
         BCuTFhgEu5oh25t3EUDY7dQ6w4GKb6KFgOo9cVvQ+GY7Jc7RMWABfE2y1r4IdqXXkNUl
         pulQ==
X-Gm-Message-State: AOAM530B0h09nRy50NTeJqarX+Ec29I1o/5tOg6cCw2l7YwsBpzdHWbC
        YUJMoN30n/n4or9ventGgb3/Qc8C0RAM5AjpiThb3Q==
X-Google-Smtp-Source: ABdhPJxIShXJi12iXrPikJsVYfHCvSYbYkVu2YYgyhehd6U2NWz6myNE5wIeepiDUEPHahK3gZbNP/cw4cb8jbikI0M=
X-Received: by 2002:a5d:6b0e:0:b0:20a:dd17:e452 with SMTP id
 v14-20020a5d6b0e000000b0020add17e452mr16461520wrw.501.1651671809318; Wed, 04
 May 2022 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com>
In-Reply-To: <20220504070941.2798233-1-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 4 May 2022 21:43:18 +0800
Message-ID: <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
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

On Wed, May 4, 2022 at 3:09 PM Marco Elver <elver@google.com> wrote:
>
> Use the newly added suite_{init,exit} support for suite-wide init and
> cleanup. This avoids the unsupported method by which the test used to do
> suite-wide init and cleanup (avoiding issues such as missing TAP
> headers, and possible future conflicts).
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> This patch should go on the -kselftest/kunit branch, where this new
> support currently lives, including a similar change to the KFENCE test.
> ---

Thanks! This is working for me. I ran it as a builtin using kunit_tool
under (I had to add an x86_64-smp architecture), then use:
./tools/testing/kunit/kunit.py run --arch=x86_64-smp
--kconfig_add=CONFIG_KCSAN=y --kconfig_add=CONFIG_DEBUG_KERNEL=y
--timeout 900 'kcsan'

To add the x86_64 smp architecture, I added a file
./tools/testing/kunit/qemu_configs/x86_64-smp.py, which was a copy of
x86_64.py but with 'CONFIG_SMP=y' added to XXXX and '-smp 16' added to
YYYY.
It took about 10 minutes on my system, so the default 5 minute timeout
definitely wasn't enough.

(It's maybe worth noting that kunit_tool's output is pretty ugly when
this isn't running on an SMP system, as the skipped subtests -- plus
the "no tests run" errors -- take up a lot of space on the screen.
That's possibly something we should consider when we look further into
how the kunit_tool NO_TEST result works. Not really related to this
change (or even this test) though.)

No complaints about the patch: I'm just really glad to see things
migrate off custom init/exit code!

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  kernel/kcsan/kcsan_test.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index a36fca063a73..59560b5e1d9c 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -1565,14 +1565,6 @@ static void test_exit(struct kunit *test)
>         torture_cleanup_end();
>  }
>
> -static struct kunit_suite kcsan_test_suite = {
> -       .name = "kcsan",
> -       .test_cases = kcsan_test_cases,
> -       .init = test_init,
> -       .exit = test_exit,
> -};
> -static struct kunit_suite *kcsan_test_suites[] = { &kcsan_test_suite, NULL };
> -
>  __no_kcsan
>  static void register_tracepoints(struct tracepoint *tp, void *ignore)
>  {
> @@ -1588,11 +1580,7 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
>                 tracepoint_probe_unregister(tp, probe_console, NULL);
>  }
>
> -/*
> - * We only want to do tracepoints setup and teardown once, therefore we have to
> - * customize the init and exit functions and cannot rely on kunit_test_suite().
> - */
> -static int __init kcsan_test_init(void)
> +static int kcsan_suite_init(struct kunit_suite *suite)
>  {
>         /*
>          * Because we want to be able to build the test as a module, we need to
> @@ -1600,18 +1588,25 @@ static int __init kcsan_test_init(void)
>          * won't work here.
>          */
>         for_each_kernel_tracepoint(register_tracepoints, NULL);
> -       return __kunit_test_suites_init(kcsan_test_suites);
> +       return 0;
>  }
>
> -static void kcsan_test_exit(void)
> +static void kcsan_suite_exit(struct kunit_suite *suite)
>  {
> -       __kunit_test_suites_exit(kcsan_test_suites);
>         for_each_kernel_tracepoint(unregister_tracepoints, NULL);
>         tracepoint_synchronize_unregister();
>  }
>
> -late_initcall_sync(kcsan_test_init);
> -module_exit(kcsan_test_exit);
> +static struct kunit_suite kcsan_test_suite = {
> +       .name = "kcsan",
> +       .test_cases = kcsan_test_cases,
> +       .init = test_init,
> +       .exit = test_exit,
> +       .suite_init = kcsan_suite_init,
> +       .suite_exit = kcsan_suite_exit,
> +};
> +
> +kunit_test_suites(&kcsan_test_suite);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Marco Elver <elver@google.com>");
> --
> 2.36.0.464.gb9c8b46e94-goog
>
