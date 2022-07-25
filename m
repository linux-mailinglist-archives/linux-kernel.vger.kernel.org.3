Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159257FDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiGYLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiGYLB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:01:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298E6155
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:01:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f73so19361923yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnm/5jPi/oqeCaQaqiY7o9Mgs5EnAdp5rIAWl4CX1kc=;
        b=E3q3Uy+KE30s3i9aCOl8AotGVDDShiXI7tWYkdizXOWArvf4tCCKrrqgQQ+YkeOGMm
         JDZXyDdGc/Uy1nkQfdfP8PF5dqX8nk6czkkh8l5sGQ583o9cap9IXxSoNArL0baijSwt
         zxeqokI9/BAh+Kpu6s6ZhCETT0Cktr5+QqYK8cEs+7TfRw5jw7YZ7zwqspzZo5C9BLvR
         5uISoADuepWhs+rjDzP1giy3xy79mqbzcC3qlpiBZ/VLbqFYtOecxkQkVGrV6aGMsObC
         ELKTuHvvUvXvFC6VwmucZ+kr2LAnyx0MLuRN/eCgrT7ajUJwPwKB1iGwhNyH/jqqBifR
         kIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnm/5jPi/oqeCaQaqiY7o9Mgs5EnAdp5rIAWl4CX1kc=;
        b=M6+uJWggJQsflarbHeAFc2WEPAX1OPgQCN+ncUkk70rSFNV1ln7vU/yayhl2S/t6e2
         g7yqFNalrynITrJxH33hyjXWWSnt7NoyxLOo5nlWy/RV3JD9qQJez3WlQchguToGaX59
         6Ug2ko8ENgXNqs4xjVl/9seAgHXD7B4P33j4Cje5a61OlMjgBKx/w9rgfwzTJl4v63tE
         LlqkJGjkXjgM0aUcQ4jX6TN+A7w+eTvkMlpQ1au84bmw4DDquApLw8uG6tK43eFlyXXO
         Uv6igmIkpFMajWaZXBvmnDsIBb8VuCOUF0AkmMR8Zn3VaTaG526BgPze6yvrzXO5qDhe
         mmDQ==
X-Gm-Message-State: AJIora+hO1og9GDcYTvJClr5jrBjjvgDf8bhtIyuRUOw8c598aafB8vl
        vwz7YEVywsBF0+CmaZd/GPWLNtOXi585AYKDB7vhmA==
X-Google-Smtp-Source: AGRyM1s4PTcghivRcD1z3aK99V0VtYiFFUccAGTBIJw4jlLGmDG/y/3ylLenSc8tzgZ6jqSK70Df541MERbbmnr4XaI=
X-Received: by 2002:a25:c602:0:b0:670:90ba:98fb with SMTP id
 k2-20020a25c602000000b0067090ba98fbmr8445943ybf.143.1658746885541; Mon, 25
 Jul 2022 04:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Jul 2022 13:00:48 +0200
Message-ID: <CANpmjNMk+p1bAEKe6Em6n0_6_1O2Aco7g9v1hcVj54hKdGJ4ug@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 18:22, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Marco,
>
> [adding Will]
>
> On Mon, Jul 04, 2022 at 05:05:01PM +0200, Marco Elver wrote:
> > Add KUnit test for hw_breakpoint constraints accounting, with various
> > interesting mixes of breakpoint targets (some care was taken to catch
> > interesting corner cases via bug-injection).
> >
> > The test cannot be built as a module because it requires access to
> > hw_breakpoint_slots(), which is not inlinable or exported on all
> > architectures.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> As mentioned on IRC, I'm seeing these tests fail on arm64 when applied atop
> v5.19-rc7:
>
> | TAP version 14
> | 1..1
> |     # Subtest: hw_breakpoint
> |     1..9
> |     ok 1 - test_one_cpu
> |     ok 2 - test_many_cpus
> |     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 3 - test_one_task_on_all_cpus
> |     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 4 - test_two_tasks_on_all_cpus
> |     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 5 - test_one_task_on_one_cpu
> |     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 6 - test_one_task_mixed
> |     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 7 - test_two_tasks_on_one_cpu
> |     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 8 - test_two_tasks_on_one_all_cpus
> |     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> |     Expected IS_ERR(bp) to be false, but is true
> |     not ok 9 - test_task_on_all_and_one_cpu
> | # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> | # Totals: pass:2 fail:7 skip:0 total:9
>
> ... which seems to be becasue arm64 currently forbids per-task
> breakpoints/watchpoints in hw_breakpoint_arch_parse(), where we have:
>
>         /*
>          * Disallow per-task kernel breakpoints since these would
>          * complicate the stepping code.
>          */
>         if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
>                 return -EINVAL;
>
> ... which has been the case since day one in commit:
>
>   478fcb2cdb2351dc ("arm64: Debugging support")
>
> I'm not immediately sure what would be necessary to support per-task kernel
> breakpoints, but given a lot of that state is currently per-cpu, I imagine it's
> invasive.

Thanks for investigating - so the test is working as intended. ;-)

However it's a shame that arm64's support is limited. And what Will
said about possible removal/rework of arm64 hw_breakpoint support
doesn't sound too reassuring.

We will definitely want to revisit arm64's hw_breakpoint support in future.

Thanks,
-- Marco
