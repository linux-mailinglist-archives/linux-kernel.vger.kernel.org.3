Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130FE49A892
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319510AbiAYDJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3423536AbiAYCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:35:23 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBDBC04967E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 18:10:04 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i14so15576966ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 18:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw1DWEcQIEt8m+nktD6YAgCCZ66sXTqiTlvo4jZ+Ooc=;
        b=IV4UUBTWv7dCWuKKUmqYaTqZ6BSPJXwQPCMLyUQtbxvSktF6MqhJiebjkrbQB+v6wx
         nkYGW9GnuzlTEzoSlGB4FD9TFIYYweO/VzNgLF55/tMWgCjeBtaLcwVxJF5HEznh1qp7
         cv0ZTIIOLS+vB1zI0iZlaSM9B5+X14oIQEGvBKOzzqCFEByCoMEeMCRQVcQ1DmsJ6u/A
         2URcjpXTgtDbDsyyKsOWtpg+YmwnZSvqttK7NyQVhsSiTC21J6aCjIX/S50Ic3jP2pGQ
         dZ9ghDbQK+7lsYCHdF5CFZ17L6AcSDdUxbah1dPgfp9t81Emk9274rkOLbWWY701Y3as
         +AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw1DWEcQIEt8m+nktD6YAgCCZ66sXTqiTlvo4jZ+Ooc=;
        b=BwMHgjRi4xyPOBgc4RgWPOA9TUUSwl8mJX/BdisQ6QFbfR7+ixGUNJEmyCKUbT3rYE
         AujC6Rf8/kSOXLpuccwfmNjzucQaBQeSzML4HysTNiwqif2pGQPTwTCx9E3S2P8psaJq
         S4HU3RGWghEAYFVc05P13fRvfxwhM+2gPEiGy0H9Ih4452viyLqjDXEsNkOoCGhisx22
         dWuYrEDG7zeNzz6YBEqjHOFgBIM1tbh2PDoiowqzMz8PF68z15n5zhzfn5QnorqMW90O
         oUG2RCp2LDe7gn61aY2/i/e7hfNw14CgUZPR1OiY9F0oW7Qih9B4+V3opmRc0idyyDYb
         E55g==
X-Gm-Message-State: AOAM530MynAo+xLbgMQC9egv4ZP+3X8MUJJKHCBY/qy52XPSThuhjNpA
        mj94fxetJUsO4JX7Ni2kJqyqVH73efEOhdj0rwwX0Q==
X-Google-Smtp-Source: ABdhPJzUKOwOTPGCN93MmdPXJ3xAz6M1rwWubCf/hb2F9I8m+/OrWMDeX8iB0GQ+2nwGsGoNuGLVwfigts5QuSSshsQ=
X-Received: by 2002:a92:c9c8:: with SMTP id k8mr9677860ilq.2.1643076603057;
 Mon, 24 Jan 2022 18:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20211118193714.2293728-1-irogers@google.com> <YaOi6pYqoc3boYX/@krava>
 <YaY8eBB+PnklIxZA@kernel.org> <CAP-5=fXR952+Rfa8yPAwO7FmHTctuTxfY0yEREtvJkHtx=PfYA@mail.gmail.com>
In-Reply-To: <CAP-5=fXR952+Rfa8yPAwO7FmHTctuTxfY0yEREtvJkHtx=PfYA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Jan 2022 18:09:50 -0800
Message-ID: <CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com>
Subject: Re: [PATCH] perf map: Fix namespace memory leak
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As with:
https://lore.kernel.org/linux-perf-users/20220122045811.3402706-4-irogers@google.com/
I implemented REFCNT_CHECKING for nsinfo (I'll mail it soon). This
more accurately identifies the problem. In one run I got:
```
=================================================================
==3900722==ERROR: AddressSanitizer: attempting double-free on
0x602000026710 in thread T6:
    #0 0x7f9a1dd6f4d7 in __interceptor_free
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x5650d04cb29c in nsinfo__put util/namespaces.c:259
    #2 0x5650d04aba93 in map__new util/map.c:198
    #3 0x5650d04a11f6 in machine__process_mmap2_event util/machine.c:1798
    #4 0x5650d04a24bf in machine__process_event util/machine.c:2019
    #5 0x5650d03e78b3 in perf_event__process util/event.c:567
    #6 0x5650d056e3bb in perf_tool__process_synth_event
util/synthetic-events.c:65
    #7 0x5650d05711a6 in perf_event__synthesize_mmap_events
util/synthetic-events.c:501
    #8 0x5650d0572fc0 in __event__synthesize_thread util/synthetic-events.c:792
    #9 0x5650d05739fd in __perf_event__synthesize_threads
util/synthetic-events.c:929
    #10 0x5650d0573cbd in synthesize_threads_worker util/synthetic-events.c:961
    #11 0x7f9a1dc48d7f in start_thread nptl/pthread_create.c:481
    #12 0x7f9a1cfdcb6e in clone (/lib/x86_64-linux-gnu/libc.so.6+0xfcb6e)

0x602000026710 is located 0 bytes inside of 8-byte region
[0x602000026710,0x602000026718)
freed by thread T13 here:
    #0 0x7f9a1dd6f4d7 in __interceptor_free
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x5650d04cb29c in nsinfo__put util/namespaces.c:259
    #2 0x5650d04aba93 in map__new util/map.c:198
    #3 0x5650d04a11f6 in machine__process_mmap2_event util/machine.c:1798
    #4 0x5650d04a24bf in machine__process_event util/machine.c:2019
    #5 0x5650d03e78b3 in perf_event__process util/event.c:567
    #6 0x5650d056e3bb in perf_tool__process_synth_event
util/synthetic-events.c:65
    #7 0x5650d05711a6 in perf_event__synthesize_mmap_events
util/synthetic-events.c:501
    #8 0x5650d0572fc0 in __event__synthesize_thread util/synthetic-events.c:792
    #9 0x5650d05739fd in __perf_event__synthesize_threads
util/synthetic-events.c:929
    #10 0x5650d0573cbd in synthesize_threads_worker util/synthetic-events.c:961
    #11 0x7f9a1dc48d7f in start_thread nptl/pthread_create.c:481

previously allocated by thread T3 here:
    #0 0x7f9a1dd6f7cf in __interceptor_malloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x5650d04cb17f in nsinfo__get util/namespaces.c:244
    #2 0x5650d04ab7df in map__new util/map.c:150
    #3 0x5650d04a11f6 in machine__process_mmap2_event util/machine.c:1798
    #4 0x5650d04a24bf in machine__process_event util/machine.c:2019
    #5 0x5650d03e78b3 in perf_event__process util/event.c:567
    #6 0x5650d056e3bb in perf_tool__process_synth_event
util/synthetic-events.c:65
    #7 0x5650d05711a6 in perf_event__synthesize_mmap_events
util/synthetic-events.c:501
    #8 0x5650d0572fc0 in __event__synthesize_thread util/synthetic-events.c:792
    #9 0x5650d05739fd in __perf_event__synthesize_threads
util/synthetic-events.c:929
    #10 0x5650d0573cbd in synthesize_threads_worker util/synthetic-events.c:961
    #11 0x7f9a1dc48d7f in start_thread nptl/pthread_create.c:481

Thread T6 created by T0 here:
    #0 0x7f9a1dd17716 in __interceptor_pthread_create
../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
    #1 0x5650d05745eb in perf_event__synthesize_threads
util/synthetic-events.c:1039
    #2 0x5650d05789fc in __machine__synthesize_threads
util/synthetic-events.c:1791
    #3 0x5650d0578a81 in machine__synthesize_threads
util/synthetic-events.c:1802
    #4 0x5650d024edd8 in __cmd_top
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/builtin-top.c:1273
    #5 0x5650d025629b in cmd_top
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/builtin-top.c:1774
    #6 0x5650d03b132b in run_builtin
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/perf.c:313
    #7 0x5650d03b188d in handle_internal_command
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/perf.c:365
    #8 0x5650d03b1c52 in run_argv
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/perf.c:409
    #9 0x5650d03b246b in main
/usr/local/google/home/irogers/kernel-trees/kernel.org/tip/tools/perf/perf.c:539
    #10 0x7f9a1cf077ec in __libc_start_main ../csu/libc-start.c:332

Thread T13 created by T0 here:
    #0 0x7f9a1dd17716 in __interceptor_pthread_create
../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
    #1 0x5650d05745eb in perf_event__synthesize_threads
util/synthetic-events.c:1039
    #2 0x5650d05789fc in __machine__synthesize_threads
util/synthetic-events.c:1791
```
That is thread 3 had created the wrapper object around the nsinfo,
thread 13 had put and freed it which cause a double free when thread 6
tried to do the same thing. How did thread 6 and 13 have the same
value for dso->nsinfo? In this patch we read then put the value, as
the put is slow another thread reads and puts the value too. We need
to atomically swap the value of dso->nsinfo with nsi and then do a put
on nsi which holds the old value of dso->nsinfo. The question is how
to do the swap?

C11 has atomic_exchange, but Makefile.config sets the std as gnu99.
C11 is used in some selftests. atomic_t and atomic_long_t aren't
guaranteed to be 64-bit, a long can be 32-bit with 64-bit pointers.
Using a non-atomic swap fixes the issue, memory leak, etc. but clearly
this needs to be atomic. My preference would be to bump to C11, but I
can do a linux atomic or poor man's swap if others prefer. Wdyt?

Thanks,
Ian

On Tue, Nov 30, 2021 at 9:20 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 7:00 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Sun, Nov 28, 2021 at 04:40:26PM +0100, Jiri Olsa escreveu:
> > > On Thu, Nov 18, 2021 at 11:37:14AM -0800, Ian Rogers wrote:
> > > > This leak was happening reliably with test "Lookup mmap thread" with
> > > > stack traces like:
> > > >
> > > > Direct leak of 5504 byte(s) in 172 object(s) allocated from:
> > > >     #0 0x7f4685e47987 in __interceptor_calloc
> > > >     #1 0x56063b974c2a in nsinfo__new util/namespaces.c:142
> > > >     #2 0x56063b9781ff in thread__new util/thread.c:70
> > > >     #3 0x56063b944953 in ____machine__findnew_thread util/machine.c:543
> > > >     #4 0x56063b944ac6 in __machine__findnew_thread util/machine.c:574
> > > >     #5 0x56063b944b36 in machine__findnew_thread util/machine.c:584
> > > >     #6 0x56063b94c892 in machine__process_fork_event util/machine.c:1954
> > > >     #7 0x56063b94cc1f in machine__process_event util/machine.c:2019
> > > >     #8 0x56063b894f18 in perf_event__process util/event.c:567
> > > >     #9 0x56063ba17951 in perf_tool__process_synth_event util/synthetic-events.c:65
> > > >     #10 0x56063ba19086 in perf_event__synthesize_fork util/synthetic-events.c:287
> > > >     #11 0x56063ba1c39d in __event__synthesize_thread util/synthetic-events.c:775
> > > >     #12 0x56063ba1cf6f in __perf_event__synthesize_threads util/synthetic-events.c:929
> > > >     #13 0x56063ba1d4ab in perf_event__synthesize_threads util/synthetic-events.c:1000
> > > >     #14 0x56063b821a3d in synth_all tests/mmap-thread-lookup.c:136
> > > >     #15 0x56063b821c86 in mmap_events tests/mmap-thread-lookup.c:174
> > > >     #16 0x56063b8221b7 in test__mmap_thread_lookup tests/mmap-thread-lookup.c:230
> > > >
> > > > The dso->nsinfo is overwritten, but without a nsinfo__put this can leak
> > > > the overwritten nsinfo.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > nice catch!
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > This one is tricky, I have to retrieve the details from last time this
> > surfaced, but try:
> >
> > # perf top -F 10000
> >
> > leave it for a while and press 'q':
> >
> > perf: /home/acme/git/perf/tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
> >                                                                                                                      Aborted (core dumped)
> >
> > I reproduced the above assertion a few times, now I'm not being able,
> > probably some namespace related activity took place when it hit.
>
> I was able to reproduce in about 1 run in 3. With address sanitizer
> the core dump turns into a heap-use-after-free with a report of:
>
> ==235440==ERROR: AddressSanitizer: heap-use-after-free on address
> 0x6030000485c8 at pc 0x55d8b882bfb7 bp 0x7fffd3426e90 sp
> 0x7fffd3426e88
> READ of size 4 at 0x6030000485c8 thread T0
>     #0 0x55d8b882bfb6 in __read_once_size ./tools/include/linux/compiler.h:132
>     #1 0x55d8b882bfb6 in atomic_read
> ./tools/include/asm/../../arch/x86/include/asm/atomic.h:28
>     #2 0x55d8b882c35c in refcount_sub_and_test
> ./tools/include/linux/refcount.h:123
>     #3 0x55d8b882c45e in refcount_dec_and_test
> ./tools/include/linux/refcount.h:148
>     #4 0x55d8b882d4af in nsinfo__put util/namespaces.c:204
>     #5 0x55d8b87adecd in __nsinfo__zput util/namespaces.h:65
>     #6 0x55d8b87b4bcc in dso__delete util/dso.c:1327
>     #7 0x55d8b87b4c8d in dso__put util/dso.c:1342
>     #8 0x55d8b87fb23b in dsos__purge util/machine.c:182
>     #9 0x55d8b87fb2e3 in dsos__exit util/machine.c:190
>     #10 0x55d8b87fb46e in machine__exit util/machine.c:222
>     #11 0x55d8b87fb715 in machines__exit util/machine.c:262
>     #12 0x55d8b88149d2 in perf_session__delete util/session.c:305
>     #13 0x55d8b85c0924 in cmd_top ./tools/perf/builtin-top.c:1781
>     #14 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
>     #15 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
>     #16 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
>     #17 0x55d8b87187bc in main ./tools/perf/perf.c:539
>
> 0x6030000485c8 is located 24 bytes inside of 32-byte region
> [0x6030000485b0,0x6030000485d0)
> freed by thread T0 here:
>     #0 0x7fb6e7c454d7 in __interceptor_free
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:127
>     #1 0x55d8b882d41a in nsinfo__delete util/namespaces.c:192
>     #2 0x55d8b882d4bf in nsinfo__put util/namespaces.c:205
>     #3 0x55d8b87adecd in __nsinfo__zput util/namespaces.h:65
>     #4 0x55d8b87b4bcc in dso__delete util/dso.c:1327
>     #5 0x55d8b87b4c8d in dso__put util/dso.c:1342
>     #6 0x55d8b87fb23b in dsos__purge util/machine.c:182
>     #7 0x55d8b87fb2e3 in dsos__exit util/machine.c:190
>     #8 0x55d8b87fb46e in machine__exit util/machine.c:222
>     #9 0x55d8b87fb715 in machines__exit util/machine.c:262
>     #10 0x55d8b88149d2 in perf_session__delete util/session.c:305
>     #11 0x55d8b85c0924 in cmd_top ./tools/perf/builtin-top.c:1781
>     #12 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
>     #13 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
>     #14 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
>     #15 0x55d8b87187bc in main ./tools/perf/perf.c:539
>
> previously allocated by thread T11 here:
>     #0 0x7fb6e7c45987 in __interceptor_calloc
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x55d8b882ceaa in nsinfo__new util/namespaces.c:142
>     #2 0x55d8b883047f in thread__new util/thread.c:70
>     #3 0x55d8b87fcb93 in ____machine__findnew_thread util/machine.c:543
>     #4 0x55d8b87fcd06 in __machine__findnew_thread util/machine.c:574
>     #5 0x55d8b87fcd76 in machine__findnew_thread util/machine.c:584
>     #6 0x55d8b8804ad2 in machine__process_fork_event util/machine.c:1954
>     #7 0x55d8b8804e5f in machine__process_event util/machine.c:2019
>     #8 0x55d8b874cf18 in perf_event__process util/event.c:567
>     #9 0x55d8b88cfbd1 in perf_tool__process_synth_event
> util/synthetic-events.c:65
>     #10 0x55d8b88d1306 in perf_event__synthesize_fork
> util/synthetic-events.c:287
>     #11 0x55d8b88d461d in __event__synthesize_thread util/synthetic-events.c:775
>     #12 0x55d8b88d51ef in __perf_event__synthesize_threads
> util/synthetic-events.c:929
>     #13 0x55d8b88d54af in synthesize_threads_worker util/synthetic-events.c:961
>     #14 0x7fb6e7b1eead in start_thread nptl/pthread_create.c:463
>
> Thread T11 created by T0 here:
>     #0 0x7fb6e7bed716 in __interceptor_pthread_create
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
>     #1 0x55d8b88d5ddd in perf_event__synthesize_threads
> util/synthetic-events.c:1039
>     #2 0x55d8b88da3b8 in __machine__synthesize_threads
> util/synthetic-events.c:1791
>     #3 0x55d8b88da43d in machine__synthesize_threads
> util/synthetic-events.c:1802
>     #4 0x55d8b85b9378 in __cmd_top ./tools/perf/builtin-top.c:1273
>     #5 0x55d8b85c0811 in cmd_top ./tools/perf/builtin-top.c:1774
>     #6 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
>     #7 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
>     #8 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
>     #9 0x55d8b87187bc in main ./tools/perf/perf.c:539
>
> SUMMARY: AddressSanitizer: heap-use-after-free
> ./tools/include/linux/compiler.h:132 in __read_once_size
> Shadow bytes around the buggy address:
>   0x0c0680001060: fa fa fa fa fa fa fa fa fd fd fd fd fa fa fa fa
>   0x0c0680001070: fa fa fa fa fa fa fa fa fa fa fd fd fd fd fa fa
>   0x0c0680001080: fa fa fa fa fa fa fa fa fa fa fa fa fd fd fd fd
>   0x0c0680001090: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c06800010a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> =>0x0c06800010b0: fa fa fa fa fa fa fd fd fd[fd]fa fa fa fa fa fa
>   0x0c06800010c0: fa fa fa fa fa fa fa fa fd fd fd fa fa fa fd fd
>   0x0c06800010d0: fd fa fa fa fd fd fd fd fa fa fd fd fd fa fa fa
>   0x0c06800010e0: fd fd fd fd fa fa fd fd fd fd fa fa fd fd fd fa
>   0x0c06800010f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fd fd
>   0x0c0680001100: fd fd fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> ==235440==ABORTING
>
> My hope was to land this so that 'perf test' wouldn't have new
> failures caused by leak sanitizer. So one option could be to guard the
> change with an address sanitizer #ifdef. The larger fix is to rework
> the reference counting logic, but I'd really hope we could switch that
> work to being in a language like Rust to get us out of the current
> memory leak vs crash wac-a-mole.
>
> +Riccardo as he did some great and related fixes over the summer.
>
> Thanks,
> Ian
>
>
>
> > - Arnaldo
> >
> > > thanks,
> > > jirka
> > >
> > > > ---
> > > >  tools/perf/util/map.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > > index 8af693d9678c..ceed8f407bc0 100644
> > > > --- a/tools/perf/util/map.c
> > > > +++ b/tools/perf/util/map.c
> > > > @@ -192,6 +192,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > > >                     if (!(prot & PROT_EXEC))
> > > >                             dso__set_loaded(dso);
> > > >             }
> > > > +           nsinfo__put(dso->nsinfo);
> > > >             dso->nsinfo = nsi;
> > > >
> > > >             if (build_id__is_defined(bid))
> > > > --
> > > > 2.34.0.rc2.393.gf8c9666880-goog
> > > >
> >
> > --
> >
> > - Arnaldo
