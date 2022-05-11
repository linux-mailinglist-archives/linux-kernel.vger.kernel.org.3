Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B6523C54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiEKSRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346143AbiEKSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:17:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81E2B19B;
        Wed, 11 May 2022 11:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56882B825E6;
        Wed, 11 May 2022 18:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B3DC340EE;
        Wed, 11 May 2022 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652293021;
        bh=cyrb1NtufeYvkRiA5L8MAKpYSVZYi26fNCswSxgOD2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKknNgqNi2X56DSqtaTWJUzAXwWCQbz9c/xDbhc73RoF+pTlTjk6auOzlSp5fkWWi
         aprvwi6qMx087Strm9qyZHCuODkBHvxkwvM57Fp3pWFzxPCAiKoQh0dpYBkwQD96AU
         hNN2I0TCNtzSzVSRysPiDUK5yS9ybzFy8MGgDTVcG4bDYVwFEeaim4PRXqLZ+OAy7z
         ePFm816C3vMaSOw6vheNDNfEtcOCCEmqCHjve9kYn/vWARMTwvh8oMZ98bU6TjxaJ6
         AbPqABadGriUw3VqRV3ugLKwYk9iRx4hkPQbhsuyHt8zhmo3FXDGjn6ClytozfHOL+
         5jsWEPT8FrDDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48029400B1; Wed, 11 May 2022 15:16:58 -0300 (-03)
Date:   Wed, 11 May 2022 15:16:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, elver@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf: add breakpoint benchmarks
Message-ID: <Ynv9mm4w9YfEU5j8@kernel.org>
References: <20220505155745.1690906-1-dvyukov@google.com>
 <CAP-5=fVDs-AQvhXbZM9ksRqMdfS00Mpn8LDRZUppJb76TCkrAg@mail.gmail.com>
 <Ynv7gkbBVd9dlJRh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynv7gkbBVd9dlJRh@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 11, 2022 at 03:08:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 11, 2022 at 08:34:58AM -0700, Ian Rogers escreveu:
> > On Thu, May 5, 2022 at 8:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > Add 2 benchmarks:
> > > 1. Performance of thread creation/exiting in presence of breakpoints.
> > > 2. Performance of breakpoint modification in presence of threads.
> > >
> > > The benchmarks capture use cases that we are interested in:
> > > using inheritable breakpoints in large highly-threaded applications.
> > > The benchmarks show significant slowdown imposed by breakpoints
> > > (even when they don't fire).
> > >
> > > Testing on Intel 8173M with 112 HW threads show:
> > >
> > > perf bench --repeat=56 breakpoint thread --breakpoints=0 --parallelism=56 --threads=20
> > >       78.675000 usecs/op
> > > perf bench --repeat=56 breakpoint thread --breakpoints=4 --parallelism=56 --threads=20
> > >    12967.135714 usecs/op
> > > That's 165x slowdown due to presence of the breakpoints.
> > >
> > > perf bench --repeat=20000 breakpoint enable --passive=0 --active=0
> > >        1.433250 usecs/op
> > > perf bench --repeat=20000 breakpoint enable --passive=224 --active=0
> > >      585.318400 usecs/op
> > > perf bench --repeat=20000 breakpoint enable --passive=0 --active=111
> > >      635.953000 usecs/op
> > > That's 408x and 444x slowdown due to presence of threads.
> > >
> > > Profiles show some overhead in toggle_bp_slot,
> > > but also very high contention:
> > >
> > >     90.83%  breakpoint-thre  [kernel.kallsyms]  [k] osq_lock
> > >      4.69%  breakpoint-thre  [kernel.kallsyms]  [k] mutex_spin_on_owner
> > >      2.06%  breakpoint-thre  [kernel.kallsyms]  [k] __reserve_bp_slot
> > >      2.04%  breakpoint-thre  [kernel.kallsyms]  [k] toggle_bp_slot
> > >
> > >     79.01%  breakpoint-enab  [kernel.kallsyms]  [k] smp_call_function_single
> > >      9.94%  breakpoint-enab  [kernel.kallsyms]  [k] llist_add_batch
> > >      5.70%  breakpoint-enab  [kernel.kallsyms]  [k] _raw_spin_lock_irq
> > >      1.84%  breakpoint-enab  [kernel.kallsyms]  [k] event_function_call
> > >      1.12%  breakpoint-enab  [kernel.kallsyms]  [k] send_call_function_single_ipi
> > >      0.37%  breakpoint-enab  [kernel.kallsyms]  [k] generic_exec_single
> > >      0.24%  breakpoint-enab  [kernel.kallsyms]  [k] __perf_event_disable
> > >      0.20%  breakpoint-enab  [kernel.kallsyms]  [k] _perf_event_enable
> > >      0.18%  breakpoint-enab  [kernel.kallsyms]  [k] toggle_bp_slot
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied.

But I'll add some error checks, etc, running as !root, in a toolbox in
Fedora Silverblue produces:

⬢[acme@toolbox perf]$ perf bench breakpoint all
# Running breakpoint/thread benchmark...
# Created/joined 10 threads with 1 breakpoints and 1 parallelism
     Total time: 0.000 [sec]

      54.600000 usecs/op
      54.600000 usecs/op/cpu

# Running breakpoint/enable benchmark...
# Enabled/disabled breakpoint 10 time with 0 passive and 0 active threads
     Total time: 0.000 [sec]

       1.100000 usecs/op

⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ perf bench --repeat=20000 breakpoint enable --passive=224 --active=0
# Running 'breakpoint/enable' benchmark:
# Enabled/disabled breakpoint 20000 time with 224 passive and 0 active threads
     Total time: 8.933 [sec]

     446.674950 usecs/op
⬢[acme@toolbox perf]$

$ grep -m1 "model name" /proc/cpuinfo
model name	: AMD Ryzen 9 5950X 16-Core Processor
 
Diff:

diff --git a/tools/perf/bench/breakpoint.c b/tools/perf/bench/breakpoint.c
index 56936fea246d73c2..d2c074bba06a3d1f 100644
--- a/tools/perf/bench/breakpoint.c
+++ b/tools/perf/bench/breakpoint.c
@@ -83,6 +83,9 @@ static void *breakpoint_thread(void *arg)
 	pthread_t *threads;
 
 	threads = calloc(thread_params.nthreads, sizeof(threads[0]));
+	if (!threads)
+		exit((perror("calloc"), EXIT_FAILURE));
+
 	while (__atomic_fetch_sub(repeat, 1, __ATOMIC_RELAXED) > 0) {
 		done = 0;
 		for (i = 0; i < thread_params.nthreads; i++) {
@@ -114,6 +117,9 @@ int bench_breakpoint_thread(int argc, const char **argv)
 	}
 	breakpoints = calloc(thread_params.nbreakpoints, sizeof(breakpoints[0]));
 	parallel = calloc(thread_params.nparallel, sizeof(parallel[0]));
+	if (!breakpoints || !parallel)
+		exit((perror("calloc"), EXIT_FAILURE));
+
 	for (i = 0; i < thread_params.nbreakpoints; i++) {
 		breakpoints[i].fd = breakpoint_setup(&breakpoints[i].watched);
 		if (breakpoints[i].fd == -1)
@@ -194,6 +200,9 @@ int bench_breakpoint_enable(int argc, const char **argv)
 		exit((perror("perf_event_open"), EXIT_FAILURE));
 	nthreads = enable_params.npassive + enable_params.nactive;
 	threads = calloc(nthreads, sizeof(threads[0]));
+	if (!threads)
+		exit((perror("calloc"), EXIT_FAILURE));
+
 	for (i = 0; i < nthreads; i++) {
 		if (pthread_create(&threads[i], NULL,
 			i < enable_params.npassive ? passive_thread : active_thread, &done))
