Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C45297DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiEQDWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiEQDWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:22:02 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20422BEA;
        Mon, 16 May 2022 20:22:01 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id m6-20020a05683023a600b0060612720715so11385498ots.10;
        Mon, 16 May 2022 20:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A08l/5aP6P9j7WRUh17MSeLG9NFDcdB6Muobd8lBirk=;
        b=jVnNGa/Hvxc+R1DD4u0YQdeqeoqNhO6SdBI0G0gsClx5yVuHiOMA1y4cah8UN8ardJ
         xuPcgQ7Uw5a3cruAtRhECrdza+TjRhL5eDr7C9oTjGU04PKx0lgZp+qCvxw8GLajg5cp
         oR+9LgTQBHjjrCqUBnGd+cZx8PDv7rMIXLSuYMfdYnHtKTABQ6dIRcbkqbD4M39R/f5J
         11JXE7Kz355AVoePh2S5ix+caYQgzg8XlrDr1XzgdfME6h3q8LG3caOtNiDcG7GcpKKh
         JFKnvBl6BhJOxvZU3hDK3cZ8K1po+bT/2bagSN2v2B19UWPrpIg/hGjl0Jko+gxP0RRB
         oRhA==
X-Gm-Message-State: AOAM533tKnhRV2LzrYoiF5Mq6ScbcG6v4/owYEPQuLIleTxEosEJBSMf
        ZW2ko5he42lP2ShlUnF+i8Ybqs+lKpgiBVkO8jPP550o
X-Google-Smtp-Source: ABdhPJyc/7AwXkKRqa7UJCSwE3+Y5NN/M8iCai20U8PsugpDA61eA9gT989mptYBaLC7AQn3SsRepzXBL4GAyIriXZs=
X-Received: by 2002:a9d:6645:0:b0:605:fb52:3739 with SMTP id
 q5-20020a9d6645000000b00605fb523739mr7309946otm.124.1652757720856; Mon, 16
 May 2022 20:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com> <20220513040519.1499333-3-irogers@google.com>
In-Reply-To: <20220513040519.1499333-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 16 May 2022 20:21:49 -0700
Message-ID: <CAM9d7ch6Xg+gGLsuJ_=X7=wSMRpo324YfRtfHG1=+YD8oG+7vQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] perf test: Use skip in vmlinux kallsyms
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, May 12, 2022 at 9:05 PM Ian Rogers <irogers@google.com> wrote:
>
> Currently failures in reading vmlinux or kallsyms result in a test
> failure. However, the failure is typically permission related. Prefer to
> flag these failures as skip.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/vmlinux-kallsyms.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
> index 93dee542a177..983f32964749 100644
> --- a/tools/perf/tests/vmlinux-kallsyms.c
> +++ b/tools/perf/tests/vmlinux-kallsyms.c
> @@ -114,7 +114,7 @@ static bool is_ignored_symbol(const char *name, char type)
>  static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused,
>                                         int subtest __maybe_unused)
>  {
> -       int err = -1;
> +       int err = TEST_FAIL;
>         struct rb_node *nd;
>         struct symbol *sym;
>         struct map *kallsyms_map, *vmlinux_map, *map;
> @@ -142,7 +142,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>          * and find the .ko files that match them in /lib/modules/`uname -r`/.
>          */
>         if (machine__create_kernel_maps(&kallsyms) < 0) {
> -               pr_debug("machine__create_kernel_maps ");
> +               pr_info("machine__create_kernel_maps failed");
> +               err = TEST_SKIP;
>                 goto out;
>         }
>
> @@ -158,7 +159,8 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>          * code and with the one got from /proc/modules from the "kallsyms" code.
>          */
>         if (machine__load_kallsyms(&kallsyms, "/proc/kallsyms") <= 0) {
> -               pr_debug("dso__load_kallsyms ");
> +               pr_debug("machine__load_kallsyms failed");

For consistency, you might want to use pr_info() here.

Thanks,
Namhyung


> +               err = TEST_SKIP;
>                 goto out;
>         }
>
> @@ -178,7 +180,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>          * Now repeat step 2, this time for the vmlinux file we'll auto-locate.
>          */
>         if (machine__create_kernel_maps(&vmlinux) < 0) {
> -               pr_debug("machine__create_kernel_maps ");
> +               pr_info("machine__create_kernel_maps failed");
>                 goto out;
>         }
>
> @@ -196,7 +198,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
>          * to fixup the symbols.
>          */
>         if (machine__load_vmlinux_path(&vmlinux) <= 0) {
> -               pr_debug("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
> +               pr_info("Couldn't find a vmlinux that matches the kernel running on this machine, skipping test\n");
>                 err = TEST_SKIP;
>                 goto out;
>         }
> --
> 2.36.0.550.gb090851708-goog
>
