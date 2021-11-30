Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A850463CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhK3RYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhK3RYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:24:02 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BBC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:20:42 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j21so22058733ila.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyG9OXV4P5tX+vmnVX1tnOviKmV0Xh2bT7c5syeukro=;
        b=M2TfxHCbx+Mgd28DC6d3EcqY4dznfFsmEXPFVxqbAphT4gm+lNRn9uQX1/3THwEciW
         e3S9Urf7GDttTG24PWDWVAKYi2n4c3c3QVUXBoB6K15UL9nBO6xfP98ZPXVTMtie2FLz
         4Xit5MwZObRMkY1xyfWTTfKCMjYtN2V0NWl+ffKZYXTY0SW/gEOTIjA0PgVdXSkGFkzp
         HyoiT1JBJn6wxVZWiilxdQtVRfO/gdI/pAuErI1MyIa/5tK+jz8i3C7SzbT5gPJTemZ5
         7M/ot2YFayGjH7Ml6ViFYcJ3XpjGM18P33MDiabkr47xivLohcwI+Acqg4crvEv/hZNQ
         zgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyG9OXV4P5tX+vmnVX1tnOviKmV0Xh2bT7c5syeukro=;
        b=p4c1jDtycWATifBfWRQPSg2b12jmT4YDP/4wCKJ7zvE8n6uaJS9suoZd+vQ0ew1zrn
         uZUu4sNZ6Oxl7YTzk4i+p/IjONnq/WIzZj9d/iyvCw0VH1o8jNT8gSkcj5Q1QMY0bx7X
         oyLdGUPiocYgch8kvUxJgab986pPFl3yZi5uqNdx3NQBGqdvS+TMjrL1ZDelFHUxkZnB
         i8nDe/7AH36F1MXBju3tWvfTf5vnYsc8HbN/S8DJ6WX83e/R9EhYbvBzoZWx/tSXCQU1
         6kQHE2W4va8WW3G/RMo858tB+Lumc//Iwq6deqHR5ICqWdmL22Z5Pk2dhv3Ruyg2c2vp
         6VBg==
X-Gm-Message-State: AOAM5325aZ3xJCkUPT3Sv35WFcQc5XgfqqFxrAJ/IwKABhL2dBsYuBhZ
        fLAenPWvVned/+5IZL6cZB2SPCmyG3JsP2/8n88CgQ==
X-Google-Smtp-Source: ABdhPJzW1qM8ezAH7rMCm/B3X07huZgeytdoKj4zxrZFCqeCAhgGCra7cEgv/V/grjDwHsBF0htzfjkhGIVsEAEnov0=
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr365913ilk.89.1638292841854;
 Tue, 30 Nov 2021 09:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20211118193714.2293728-1-irogers@google.com> <YaOi6pYqoc3boYX/@krava>
 <YaY8eBB+PnklIxZA@kernel.org>
In-Reply-To: <YaY8eBB+PnklIxZA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 Nov 2021 09:20:25 -0800
Message-ID: <CAP-5=fXR952+Rfa8yPAwO7FmHTctuTxfY0yEREtvJkHtx=PfYA@mail.gmail.com>
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
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 7:00 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Nov 28, 2021 at 04:40:26PM +0100, Jiri Olsa escreveu:
> > On Thu, Nov 18, 2021 at 11:37:14AM -0800, Ian Rogers wrote:
> > > This leak was happening reliably with test "Lookup mmap thread" with
> > > stack traces like:
> > >
> > > Direct leak of 5504 byte(s) in 172 object(s) allocated from:
> > >     #0 0x7f4685e47987 in __interceptor_calloc
> > >     #1 0x56063b974c2a in nsinfo__new util/namespaces.c:142
> > >     #2 0x56063b9781ff in thread__new util/thread.c:70
> > >     #3 0x56063b944953 in ____machine__findnew_thread util/machine.c:543
> > >     #4 0x56063b944ac6 in __machine__findnew_thread util/machine.c:574
> > >     #5 0x56063b944b36 in machine__findnew_thread util/machine.c:584
> > >     #6 0x56063b94c892 in machine__process_fork_event util/machine.c:1954
> > >     #7 0x56063b94cc1f in machine__process_event util/machine.c:2019
> > >     #8 0x56063b894f18 in perf_event__process util/event.c:567
> > >     #9 0x56063ba17951 in perf_tool__process_synth_event util/synthetic-events.c:65
> > >     #10 0x56063ba19086 in perf_event__synthesize_fork util/synthetic-events.c:287
> > >     #11 0x56063ba1c39d in __event__synthesize_thread util/synthetic-events.c:775
> > >     #12 0x56063ba1cf6f in __perf_event__synthesize_threads util/synthetic-events.c:929
> > >     #13 0x56063ba1d4ab in perf_event__synthesize_threads util/synthetic-events.c:1000
> > >     #14 0x56063b821a3d in synth_all tests/mmap-thread-lookup.c:136
> > >     #15 0x56063b821c86 in mmap_events tests/mmap-thread-lookup.c:174
> > >     #16 0x56063b8221b7 in test__mmap_thread_lookup tests/mmap-thread-lookup.c:230
> > >
> > > The dso->nsinfo is overwritten, but without a nsinfo__put this can leak
> > > the overwritten nsinfo.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > nice catch!
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
>
> This one is tricky, I have to retrieve the details from last time this
> surfaced, but try:
>
> # perf top -F 10000
>
> leave it for a while and press 'q':
>
> perf: /home/acme/git/perf/tools/include/linux/refcount.h:131: refcount_sub_and_test: Assertion `!(new > val)' failed.
>                                                                                                                      Aborted (core dumped)
>
> I reproduced the above assertion a few times, now I'm not being able,
> probably some namespace related activity took place when it hit.

I was able to reproduce in about 1 run in 3. With address sanitizer
the core dump turns into a heap-use-after-free with a report of:

==235440==ERROR: AddressSanitizer: heap-use-after-free on address
0x6030000485c8 at pc 0x55d8b882bfb7 bp 0x7fffd3426e90 sp
0x7fffd3426e88
READ of size 4 at 0x6030000485c8 thread T0
    #0 0x55d8b882bfb6 in __read_once_size ./tools/include/linux/compiler.h:132
    #1 0x55d8b882bfb6 in atomic_read
./tools/include/asm/../../arch/x86/include/asm/atomic.h:28
    #2 0x55d8b882c35c in refcount_sub_and_test
./tools/include/linux/refcount.h:123
    #3 0x55d8b882c45e in refcount_dec_and_test
./tools/include/linux/refcount.h:148
    #4 0x55d8b882d4af in nsinfo__put util/namespaces.c:204
    #5 0x55d8b87adecd in __nsinfo__zput util/namespaces.h:65
    #6 0x55d8b87b4bcc in dso__delete util/dso.c:1327
    #7 0x55d8b87b4c8d in dso__put util/dso.c:1342
    #8 0x55d8b87fb23b in dsos__purge util/machine.c:182
    #9 0x55d8b87fb2e3 in dsos__exit util/machine.c:190
    #10 0x55d8b87fb46e in machine__exit util/machine.c:222
    #11 0x55d8b87fb715 in machines__exit util/machine.c:262
    #12 0x55d8b88149d2 in perf_session__delete util/session.c:305
    #13 0x55d8b85c0924 in cmd_top ./tools/perf/builtin-top.c:1781
    #14 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
    #15 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
    #16 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
    #17 0x55d8b87187bc in main ./tools/perf/perf.c:539

0x6030000485c8 is located 24 bytes inside of 32-byte region
[0x6030000485b0,0x6030000485d0)
freed by thread T0 here:
    #0 0x7fb6e7c454d7 in __interceptor_free
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x55d8b882d41a in nsinfo__delete util/namespaces.c:192
    #2 0x55d8b882d4bf in nsinfo__put util/namespaces.c:205
    #3 0x55d8b87adecd in __nsinfo__zput util/namespaces.h:65
    #4 0x55d8b87b4bcc in dso__delete util/dso.c:1327
    #5 0x55d8b87b4c8d in dso__put util/dso.c:1342
    #6 0x55d8b87fb23b in dsos__purge util/machine.c:182
    #7 0x55d8b87fb2e3 in dsos__exit util/machine.c:190
    #8 0x55d8b87fb46e in machine__exit util/machine.c:222
    #9 0x55d8b87fb715 in machines__exit util/machine.c:262
    #10 0x55d8b88149d2 in perf_session__delete util/session.c:305
    #11 0x55d8b85c0924 in cmd_top ./tools/perf/builtin-top.c:1781
    #12 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
    #13 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
    #14 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
    #15 0x55d8b87187bc in main ./tools/perf/perf.c:539

previously allocated by thread T11 here:
    #0 0x7fb6e7c45987 in __interceptor_calloc
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x55d8b882ceaa in nsinfo__new util/namespaces.c:142
    #2 0x55d8b883047f in thread__new util/thread.c:70
    #3 0x55d8b87fcb93 in ____machine__findnew_thread util/machine.c:543
    #4 0x55d8b87fcd06 in __machine__findnew_thread util/machine.c:574
    #5 0x55d8b87fcd76 in machine__findnew_thread util/machine.c:584
    #6 0x55d8b8804ad2 in machine__process_fork_event util/machine.c:1954
    #7 0x55d8b8804e5f in machine__process_event util/machine.c:2019
    #8 0x55d8b874cf18 in perf_event__process util/event.c:567
    #9 0x55d8b88cfbd1 in perf_tool__process_synth_event
util/synthetic-events.c:65
    #10 0x55d8b88d1306 in perf_event__synthesize_fork
util/synthetic-events.c:287
    #11 0x55d8b88d461d in __event__synthesize_thread util/synthetic-events.c:775
    #12 0x55d8b88d51ef in __perf_event__synthesize_threads
util/synthetic-events.c:929
    #13 0x55d8b88d54af in synthesize_threads_worker util/synthetic-events.c:961
    #14 0x7fb6e7b1eead in start_thread nptl/pthread_create.c:463

Thread T11 created by T0 here:
    #0 0x7fb6e7bed716 in __interceptor_pthread_create
../../../../src/libsanitizer/asan/asan_interceptors.cpp:216
    #1 0x55d8b88d5ddd in perf_event__synthesize_threads
util/synthetic-events.c:1039
    #2 0x55d8b88da3b8 in __machine__synthesize_threads
util/synthetic-events.c:1791
    #3 0x55d8b88da43d in machine__synthesize_threads
util/synthetic-events.c:1802
    #4 0x55d8b85b9378 in __cmd_top ./tools/perf/builtin-top.c:1273
    #5 0x55d8b85c0811 in cmd_top ./tools/perf/builtin-top.c:1774
    #6 0x55d8b87176b7 in run_builtin ./tools/perf/perf.c:313
    #7 0x55d8b8717c10 in handle_internal_command ./tools/perf/perf.c:365
    #8 0x55d8b8717fcd in run_argv ./tools/perf/perf.c:409
    #9 0x55d8b87187bc in main ./tools/perf/perf.c:539

SUMMARY: AddressSanitizer: heap-use-after-free
./tools/include/linux/compiler.h:132 in __read_once_size
Shadow bytes around the buggy address:
  0x0c0680001060: fa fa fa fa fa fa fa fa fd fd fd fd fa fa fa fa
  0x0c0680001070: fa fa fa fa fa fa fa fa fa fa fd fd fd fd fa fa
  0x0c0680001080: fa fa fa fa fa fa fa fa fa fa fa fa fd fd fd fd
  0x0c0680001090: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c06800010a0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
=>0x0c06800010b0: fa fa fa fa fa fa fd fd fd[fd]fa fa fa fa fa fa
  0x0c06800010c0: fa fa fa fa fa fa fa fa fd fd fd fa fa fa fd fd
  0x0c06800010d0: fd fa fa fa fd fd fd fd fa fa fd fd fd fa fa fa
  0x0c06800010e0: fd fd fd fd fa fa fd fd fd fd fa fa fd fd fd fa
  0x0c06800010f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fd fd
  0x0c0680001100: fd fd fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==235440==ABORTING

My hope was to land this so that 'perf test' wouldn't have new
failures caused by leak sanitizer. So one option could be to guard the
change with an address sanitizer #ifdef. The larger fix is to rework
the reference counting logic, but I'd really hope we could switch that
work to being in a language like Rust to get us out of the current
memory leak vs crash wac-a-mole.

+Riccardo as he did some great and related fixes over the summer.

Thanks,
Ian



> - Arnaldo
>
> > thanks,
> > jirka
> >
> > > ---
> > >  tools/perf/util/map.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > > index 8af693d9678c..ceed8f407bc0 100644
> > > --- a/tools/perf/util/map.c
> > > +++ b/tools/perf/util/map.c
> > > @@ -192,6 +192,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> > >                     if (!(prot & PROT_EXEC))
> > >                             dso__set_loaded(dso);
> > >             }
> > > +           nsinfo__put(dso->nsinfo);
> > >             dso->nsinfo = nsi;
> > >
> > >             if (build_id__is_defined(bid))
> > > --
> > > 2.34.0.rc2.393.gf8c9666880-goog
> > >
>
> --
>
> - Arnaldo
