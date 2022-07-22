Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CE57DF72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiGVKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296C0233;
        Fri, 22 Jul 2022 03:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC03621EE;
        Fri, 22 Jul 2022 10:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D1C341C6;
        Fri, 22 Jul 2022 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658484661;
        bh=XJriq7tTdC1cyZXBj5IiJNgiitzwRUBjtyO0pj7JFl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GYwdPrRYvSBKEv7G5/kKFJUa2DEKFzex1xLkbvZdsBit2yMR6NrcAJrb68xyJ09vO
         ZfB0Jfm3C5/A59OkflqeQ4KeW+FSZ9Ur0O59Sa+Xq519nvirxnMOamJoBY5iHlH77C
         +281F5H+7DwYIfisnecFu4qx5i4sySkfKdn/WfX4hRS0NTiMaq/In1ihyDkEmbBXzW
         JhnZLAfQsxtxIOB1t2Kqh7e489D4xGjL5pMYJLO92wPHSWpwcSuXDumLBCkTsqQkqq
         8GLc2RWRnTDeGQ4lNHZ6OM/8qvWtAjyP97T/VAupUrbCfzmRd1KTtZ2sHb8a6jPKtQ
         upgOmuW3V8cPQ==
Date:   Fri, 22 Jul 2022 11:10:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
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
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
Message-ID: <20220722101053.GA18284@willie-the-truck>
References: <20220704150514.48816-1-elver@google.com>
 <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com>
 <20220722091044.GC18125@willie-the-truck>
 <CACT4Y+ZOXXqxhe4U3ZtQPCj2yrf6Qtjg1q0Kfq8+poAOxGgUew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZOXXqxhe4U3ZtQPCj2yrf6Qtjg1q0Kfq8+poAOxGgUew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:20:25AM +0200, Dmitry Vyukov wrote:
> On Fri, 22 Jul 2022 at 11:10, Will Deacon <will@kernel.org> wrote:
> > > [adding Will]
> > >
> > > On Mon, Jul 04, 2022 at 05:05:01PM +0200, Marco Elver wrote:
> > > > Add KUnit test for hw_breakpoint constraints accounting, with various
> > > > interesting mixes of breakpoint targets (some care was taken to catch
> > > > interesting corner cases via bug-injection).
> > > >
> > > > The test cannot be built as a module because it requires access to
> > > > hw_breakpoint_slots(), which is not inlinable or exported on all
> > > > architectures.
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > As mentioned on IRC, I'm seeing these tests fail on arm64 when applied atop
> > > v5.19-rc7:
> > >
> > > | TAP version 14
> > > | 1..1
> > > |     # Subtest: hw_breakpoint
> > > |     1..9
> > > |     ok 1 - test_one_cpu
> > > |     ok 2 - test_many_cpus
> > > |     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 3 - test_one_task_on_all_cpus
> > > |     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 4 - test_two_tasks_on_all_cpus
> > > |     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 5 - test_one_task_on_one_cpu
> > > |     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 6 - test_one_task_mixed
> > > |     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 7 - test_two_tasks_on_one_cpu
> > > |     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 8 - test_two_tasks_on_one_all_cpus
> > > |     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> > > |     Expected IS_ERR(bp) to be false, but is true
> > > |     not ok 9 - test_task_on_all_and_one_cpu
> > > | # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> > > | # Totals: pass:2 fail:7 skip:0 total:9
> > >
> > > ... which seems to be becasue arm64 currently forbids per-task
> > > breakpoints/watchpoints in hw_breakpoint_arch_parse(), where we have:
> > >
> > >         /*
> > >          * Disallow per-task kernel breakpoints since these would
> > >          * complicate the stepping code.
> > >          */
> > >         if (hw->ctrl.privilege == AARCH64_BREAKPOINT_EL1 && bp->hw.target)
> > >                 return -EINVAL;
> > >
> > > ... which has been the case since day one in commit:
> > >
> > >   478fcb2cdb2351dc ("arm64: Debugging support")
> > >
> > > I'm not immediately sure what would be necessary to support per-task kernel
> > > breakpoints, but given a lot of that state is currently per-cpu, I imagine it's
> > > invasive.
> >
> > I would actually like to remove HW_BREAKPOINT completely for arm64 as it
> > doesn't really work and causes problems for other interfaces such as ptrace
> > and kgdb.
> 
> Will it be a localized removal of code that will be easy to revert in
> future? Or will it touch lots of code here and there?
> Let's say we come up with a very important use case for HW_BREAKPOINT
> and will need to make it work on arm64 as well in future.

My (rough) plan is to implement a lower-level abstraction for handling the
underlying hardware resources, so we can layer consumers on top of that
instead of funneling through hw_breakpoint. So if we figure out how to make
bits of hw_breakpoint work on arm64, then it should just go on top.

The main pain point for hw_breakpoint is kernel-side {break,watch}points
and I think there are open design questions about how they should work
on arm64, particularly when considering the interaction with user
watchpoints triggering on uaccess routines and the possibility of hitting
a kernel watchpoint in irq context.

Will
