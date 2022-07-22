Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EC57DE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiGVJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiGVJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52DAF73F;
        Fri, 22 Jul 2022 02:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C1C61F64;
        Fri, 22 Jul 2022 09:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77DEC341C6;
        Fri, 22 Jul 2022 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658481052;
        bh=OK8LmIuAEgVsEBkiSNzzMiMp+U1+ADxlXeHm7mqZaTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6jq7Tg0q/Eyh5XpZi+1zP+fDCj3KuU5UDAW1Ag0JjkZO6LADytvyqolI3M5Ry9LJ
         hCGcCabPhjJ4MjZCSRLlp3PrOWzYf8PHjea3ra8LLSwS7QVHk3r61PAB9XgxBnAdHB
         EJqVnJ4tLsYyZdUtLioD8mw3Hl952UiFipEYHkWB5aM+kgMra18AG00yGBcpovRvW6
         iMntJBfP4kNuYx2/n/l/iDfPq2xgbmG9umL/fQBgjdXJtLVYYyHHHSuxIdsFkEuZ/F
         i7px0y0ZYE8xBCXcidwYouibNMVc0kt77QKBeU3J5z5qqAFFiDHyb5yn/0O91DMB7w
         nxaLpIimgYyhg==
Date:   Fri, 22 Jul 2022 10:10:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] perf/hw_breakpoint: Add KUnit test for
 constraints accounting
Message-ID: <20220722091044.GC18125@willie-the-truck>
References: <20220704150514.48816-1-elver@google.com>
 <20220704150514.48816-2-elver@google.com>
 <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 05:22:07PM +0100, Mark Rutland wrote:
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

I would actually like to remove HW_BREAKPOINT completely for arm64 as it
doesn't really work and causes problems for other interfaces such as ptrace
and kgdb.

Will
