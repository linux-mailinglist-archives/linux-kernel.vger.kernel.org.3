Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA224A57C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiBAHdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiBAHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:33:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:33:36 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q8so17165446oiw.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8UdammtyVx5EZAt87tg0T0RNHOojMP8yJWvr7M56iQ=;
        b=haoGVsVQAzGG2SPFci3XpfbSPiur+S28MMUzpS69ADK382iF+H+IUehv+dLvTBxrrq
         H/D2k9krPqqnf2rJC+99Kf8glCUGOMSUMbAH/I2E2RzHiDs8Y4fEASgximwWzi11P5pg
         vB7TF/tVgQN6wPnbDMVk+EtxU5I7F3OXE6VVvPzGukA/hUaAaToUM3bHabj3+lweVQyh
         SOEKKWKCrxAsELqwIIcmtGNO8kA8BoBuaXg8VVCTA4JlPhVnbcJBtJ16nuJUWU6yQFCh
         LBJYPpClY6swn7+iIZoyH2WEY1VdI7kjpkf+vGdlvT9nhKs3feD0i1Pr2YNoj+mMA5bN
         dscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8UdammtyVx5EZAt87tg0T0RNHOojMP8yJWvr7M56iQ=;
        b=1aN0TF6utmPr7ryoy4PUCKovw+ODnPwTQ8iWtZCVOExmhTTrVMXK4zYGiHm7fJ1Dcd
         9vcu6nbsBHlN8AHbj5Oj9V/mwXzYF6R+7NdRelMm/GjZ2/zwOPf7USgQ0DBHrPl9Z78W
         a+UDr9asqyGnEnpIUFuY1Vex7h+X34j7bAbrYkrTynQgyj9oI/AAqtf2B520/o6V31rX
         xew1x49oNFslCEY+n73C9blMFagSOoCsqnL7rs+lykYMcyqyT4kXcls07lweXXIaGJ8Q
         T0Xylh7q3Yq+BYD3zexyIlwN6r/vof7lw7I/imDRjBLf9SSZyb6xQgl+ja5oyGg59CEz
         oR+Q==
X-Gm-Message-State: AOAM530LC6ee+6oAESZfZ0HEobGIWnVeRqcbocc9bPenQfyPBB7jr4HK
        GC4oSxRQNcBSnqxIS+LQHYQ9JajsTWJD2CoHIR6sSg==
X-Google-Smtp-Source: ABdhPJy26D1ewz7OBehQImCy7Emi3FxJ0U1d3ccorWuiWoINBgO9zfb3ky9sHHioPq168bjuzVh+9mr6pljjfAkoCls=
X-Received: by 2002:a05:6808:1188:: with SMTP id j8mr395888oil.195.1643700815629;
 Mon, 31 Jan 2022 23:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com> <20220131103407.1971678-2-elver@google.com>
In-Reply-To: <20220131103407.1971678-2-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 1 Feb 2022 08:33:24 +0100
Message-ID: <CACT4Y+b3cpG_L+UO=vvRtPdBh7Np5U4AA5_WuK7s7FUazuBvwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/perf_events: Test modification of perf_event_attr::sig_data
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 11:34, Marco Elver <elver@google.com> wrote:
>
> Test that PERF_EVENT_IOC_MODIFY_ATTRIBUTES correctly modifies
> perf_event_attr::sig_data as well.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  .../selftests/perf_events/sigtrap_threads.c     | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
> index 8e83cf91513a..6d849dc2bee0 100644
> --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> @@ -44,9 +44,10 @@ static struct {
>  } ctx;
>
>  /* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
> -#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
> +#define TEST_SIG_DATA(addr, id) (~(unsigned long)(addr) + id)
>
> -static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
> +static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
> +                                             unsigned long id)
>  {
>         struct perf_event_attr attr = {
>                 .type           = PERF_TYPE_BREAKPOINT,
> @@ -60,7 +61,7 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
>                 .inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
>                 .remove_on_exec = 1, /* Required by sigtrap. */
>                 .sigtrap        = 1, /* Request synchronous SIGTRAP on event. */
> -               .sig_data       = TEST_SIG_DATA(addr),
> +               .sig_data       = TEST_SIG_DATA(addr, id),
>         };
>         return attr;
>  }
> @@ -110,7 +111,7 @@ FIXTURE(sigtrap_threads)
>
>  FIXTURE_SETUP(sigtrap_threads)
>  {
> -       struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on);
> +       struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on, 0);
>         struct sigaction action = {};
>         int i;
>
> @@ -165,7 +166,7 @@ TEST_F(sigtrap_threads, enable_event)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -175,7 +176,7 @@ TEST_F(sigtrap_threads, enable_event)
>  /* Test that modification propagates to all inherited events. */
>  TEST_F(sigtrap_threads, modify_and_enable_event)
>  {
> -       struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on);
> +       struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on, 42);
>
>         EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr), 0);
>         run_test_threads(_metadata, self);
> @@ -184,7 +185,7 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 42));
>
>         /* Check enabled for parent. */
>         ctx.iterate_on = 0;
> @@ -204,7 +205,7 @@ TEST_F(sigtrap_threads, signal_stress)
>         EXPECT_EQ(ctx.tids_want_signal, 0);
>         EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
>         EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
> -       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
> +       EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
