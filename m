Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C109C57E00D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiGVKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:32:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C2B5052
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:32:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j26so4962118lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXqhKXWkyJJg9+g/9EohedHzzZKAjuqa2sFmi97JD9Y=;
        b=pnVwjwP2epgqugyqrMAsXv6dkAFuOokeRTDVkC6DsP+qX0N8ti0lIHBdgoQII4uwjh
         t4naAikyweBC0my1Llr1nYwJ/BPKlspVAbhCwPoCgTMoNwdYypjKVxB+5z3pB//FCb5f
         Oz3YNzSdFiOyLnc8vSoS+c49UYoX4ct9rex+XVYZL+LGaQEQvsI0oqXiljUx4g/DUwP/
         XQtr7ntRWMBZtOePBlbIMVp0Nv+RhfrAUWMSyNmcqPRQRLWPqncJJ1296PNqH2EkBNyF
         xW3C/bLFl6hSGtA+CmQiPZPhOfPQB/4FBfUufX51z8LjtLhFudukcFcWT4Vek59IOBwC
         jO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXqhKXWkyJJg9+g/9EohedHzzZKAjuqa2sFmi97JD9Y=;
        b=TNoqtICutqtMZpj4l8gYZqRjtEguMJT5vDAWsBxF1DVwajSnV1pgSwGiEMxSmPlg8Y
         xJSjHHWxM0yplHmKZvYfJutvC/7eYdk7fEZDUhXrRGSwb/3YNLPI/KYn1USJhTjz4gRi
         lt7AfTtmKaMg3hbOb/6zR2WjixPZKp82Qt1l1g5sfGrSttVaQ4lnne63IspZXoRNOZpf
         +FcrQVkzCvky/t11BErTOj0DJjlhkRDm9FysitB2OsY31Z3giaj20EjRVtecPziWIk0y
         B08TYatwzHRfGtvvwDuAhFc0KhDW05TzOQBCkdW4IXPtuCbpdtm90B2NS/FEICXWFhAg
         fgdQ==
X-Gm-Message-State: AJIora9uO3hnsWACgBEWdp0oVYfiI1PCnZL34bUcz3itcGc79ZCF+AgW
        S2JJhS0NgG3C67jBe3amBk3AD7Vc9fIr8ZG2m5xpsQ==
X-Google-Smtp-Source: AGRyM1vQ0cnyWSucVzfKlluxmfyG+Ix//9JlO9f9D6f+QcIc7yr3ZZbF+QXGzK5/C+gU2hxCnErBEvbCnNBO6oH2C1A=
X-Received: by 2002:a05:651c:1310:b0:25d:efe5:109d with SMTP id
 u16-20020a05651c131000b0025defe5109dmr742781lja.465.1658485917645; Fri, 22
 Jul 2022 03:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com> <20220722091044.GC18125@willie-the-truck>
 <CACT4Y+ZOXXqxhe4U3ZtQPCj2yrf6Qtjg1q0Kfq8+poAOxGgUew@mail.gmail.com> <20220722101053.GA18284@willie-the-truck>
In-Reply-To: <20220722101053.GA18284@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Jul 2022 12:31:45 +0200
Message-ID: <CACT4Y+Z0imEHF0jM-f-uYdpfSpfzMpa+bFZfPeQW1ECBDjD9fA@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 at 12:11, Will Deacon <will@kernel.org> wrote:
> > > > [adding Will]
> > > >
> > > > On Mon, Jul 04, 2022 at 05:05:01PM +0200, Marco Elver wrote:
> > > > > Add KUnit test for hw_breakpoint constraints accounting, with various
> > > > > interesting mixes of breakpoint targets (some care was taken to catch
> > > > > interesting corner cases via bug-injection).
> > > > >
> > > > > The test cannot be built as a module because it requires access to
> > > > > hw_breakpoint_slots(), which is not inlinable or exported on all
> > > > > architectures.
> > > > >
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > >
> > > > As mentioned on IRC, I'm seeing these tests fail on arm64 when applied atop
> > > > v5.19-rc7:
> > > >
> > > > | TAP version 14
> > > > | 1..1
> > > > |     # Subtest: hw_breakpoint
> > > > |     1..9
> > > > |     ok 1 - test_one_cpu
> > > > |     ok 2 - test_many_cpus
> > > > |     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 3 - test_one_task_on_all_cpus
> > > > |     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 4 - test_two_tasks_on_all_cpus
> > > > |     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 5 - test_one_task_on_one_cpu
> > > > |     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 6 - test_one_task_mixed
> > > > |     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 7 - test_two_tasks_on_one_cpu
> > > > |     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 8 - test_two_tasks_on_one_all_cpus
> > > > |     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > > |     Expected IS_ERR(bp) to be false, but is true
> > > > |     not ok 9 - test_task_on_all_and_one_cpu
> > > > | # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> > > > | # Totals: pass:2 fail:7 skip:0 total:9
> > > >
> > > > ... which seems to be becasue arm64 currently forbids per-task
> > > > breakpoints/watchpoints in hw_breakpoint_arch_parse(), where we have:
> > > >
> > > >         /*
> > > >          * Disallow per-task kernel breakpoints since these would
> > > >          * complicate the stepping code.
> > > >          */
> > > >         if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
> > > >                 return -EINVAL;
> > > >
> > > > ... which has been the case since day one in commit:
> > > >
> > > >   478fcb2cdb2351dc ("arm64: Debugging support")
> > > >
> > > > I'm not immediately sure what would be necessary to support per-task kernel
> > > > breakpoints, but given a lot of that state is currently per-cpu, I imagine it's
> > > > invasive.
> > >
> > > I would actually like to remove HW_BREAKPOINT completely for arm64 as it
> > > doesn't really work and causes problems for other interfaces such as ptrace
> > > and kgdb.
> >
> > Will it be a localized removal of code that will be easy to revert in
> > future? Or will it touch lots of code here and there?
> > Let's say we come up with a very important use case for HW_BREAKPOINT
> > and will need to make it work on arm64 as well in future.
>
> My (rough) plan is to implement a lower-level abstraction for handling the
> underlying hardware resources, so we can layer consumers on top of that
> instead of funneling through hw_breakpoint. So if we figure out how to make
> bits of hw_breakpoint work on arm64, then it should just go on top.
>
> The main pain point for hw_breakpoint is kernel-side {break,watch}points
> and I think there are open design questions about how they should work
> on arm64, particularly when considering the interaction with user
> watchpoints triggering on uaccess routines and the possibility of hitting
> a kernel watchpoint in irq context.

I see. Our main interest would be break/watchpoints on user addresses
firing from both user-space and kernel (uaccess), so at least on irqs.
