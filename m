Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009534F68B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiDFSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiDFSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:09:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6111AF7FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:46:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i6-20020a1c3b06000000b0038e710da2dcso4023537wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUGFoNnUGScUomYsF7wtqgIA+7i5QVqibaScVacsjnU=;
        b=AbBXosJZdvj+44jV/t3tLeXNGDbrJB0DTPW335jYRx/iAWXKo3M2TJxCtQmHuoLYVi
         eQQr6SDYWWaPfQa2K3p9Ft8NRL+qPD66x/fVU/ZtHc6JxasrB4n12PwUWuhSDdznqDT4
         pt9cg1B+Nxdobqqjq4tOLdkOzSaz65OTgy3x+zfILsG+HGNPltMuvQxThoVrexbhob/j
         jQUm/G693iC+2UB4JCW/M5Us7dd74lZ94oEi6kkcxl3wqriqS5/VzIWjKF8TLJvayZ4d
         WdUtgynNNirwZRCNHZ7JpeE33XQBUi/nBqtK9IjpCj0/1IDAO5otMttxuJ6VLHKD2ssc
         0fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUGFoNnUGScUomYsF7wtqgIA+7i5QVqibaScVacsjnU=;
        b=FGKYirZGO0ZbY+xJsp42uKdLM418hqRsdRrrox1q1noapBYtzZSOwWxSRdJkpFHx6e
         VJjDiRailNVEtu+3ohaDAwIOu2rEt2tZ0jm2b6v8d304U6Ww01zdp3t6YqnUEk0OeJh2
         MkcOBZpfa4VcIgsBxs4DaV4+C1YUuEIC8hbuDq7xadOD2DI8VMakuRaFa+tDlHwFHYXp
         ycvlmydFf8n5T8LXKvYG66LD+uA3ssHNryO8bsUr593xkaHFJ5ovNSAfzPAb9qpavBwB
         zUkHkh7nDsYUyJfqsCPzYsySIvylRGpYf4v7LXbZ4Q+umcNEJhpc+v+c6OUPvSyy34gl
         i45w==
X-Gm-Message-State: AOAM532hOvLOCe5Jlb07jwUZPaRxlKH+TjipRQhb9xILpCwD4K3NhI5F
        h1G2Vv5LOWsz2JHAoDTyHEvdQLeaBAaQj3tnKq/ssw==
X-Google-Smtp-Source: ABdhPJxfXtqr7UlMTtJw+k69tST/ohVcghSmTJA/jXiu2RQLY80sqsFAGMx321BxjbudnIHAhpIetDPT0lujI4C5ZlA=
X-Received: by 2002:a7b:c77a:0:b0:38c:2c33:d8f1 with SMTP id
 x26-20020a7bc77a000000b0038c2c33d8f1mr8292204wmk.115.1649263607436; Wed, 06
 Apr 2022 09:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <CAP-5=fXK6BfeUdA=h=Rx3K96Hn5nHHPrz7hQDwCMRpSbzcBXvw@mail.gmail.com> <b1b875cb-cae5-e707-7897-047f991c3db0@linux.intel.com>
In-Reply-To: <b1b875cb-cae5-e707-7897-047f991c3db0@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Apr 2022 09:46:34 -0700
Message-ID: <CAP-5=fWSZyKuFO2=WXbT1=h9N91zFCBBp0663w9uxXdLHEC8KQ@mail.gmail.com>
Subject: Re: [PATCH v13 01/16] perf record: Introduce thread affinity and mmap masks
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
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

On Tue, Apr 5, 2022 at 9:21 AM Bayduraev, Alexey V
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> On 05.04.2022 1:25, Ian Rogers wrote:
> > On Mon, Jan 17, 2022 at 10:38 AM Alexey Bayduraev
> > <alexey.v.bayduraev@linux.intel.com> wrote:
> >>
> >> Introduce affinity and mmap thread masks. Thread affinity mask
>
> <SNIP>
>
> >
> > In per-thread mode it is possible that cpus is the dummy CPU map here.
> > This means that the cpu below has the value -1 and setting bit -1
> > actually has the effect of setting bit 63. Here is a reproduction
> > based on the acme/perf/core branch:
> >
> > ```
> > $ make STATIC=1 DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer
> > -fsanitize=undefined -fno-sanitize-recover'
> > $ perf record -o /tmp/perf.data  --per-thread true
> > tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
> > exponent -1 is negative
> > $ UBSAN_OPTIONS=abort_on_error=1 gdb --args perf record -o
> > /tmp/perf.data --per-thread true
> > (gdb) r
> > tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
> > exponent -1 is negative
> > (gdb) bt
> > #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
> > #1  0x00007ffff71d2546 in __GI_abort () at abort.c:79
> > #2  0x00007ffff640db9f in __sanitizer::Abort () at
> > ../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:151
> > #3  0x00007ffff6418efc in __sanitizer::Die () at
> > ../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:58
> > #4  0x00007ffff63fd99e in
> > __ubsan::__ubsan_handle_shift_out_of_bounds_abort (Data=<optimized
> > out>, LHS=<optimized out>,
> >     RHS=<optimized out>) at
> > ../../../../src/libsanitizer/ubsan/ubsan_handlers.cpp:378
> > #5  0x0000555555c54405 in set_bit (nr=-1, addr=0x555556ecd0a0)
> >     at tools/include/asm-generic/bitops/atomic.h:10
> > #6  0x0000555555c6ddaf in record__mmap_cpu_mask_init
> > (mask=0x555556ecd070, cpus=0x555556ecd050) at builtin-record.c:3333
> > #7  0x0000555555c7044c in record__init_thread_default_masks
> > (rec=0x55555681b100 <record>, cpus=0x555556ecd050) at
> > builtin-record.c:3668
> > #8  0x0000555555c705b3 in record__init_thread_masks
> > (rec=0x55555681b100 <record>) at builtin-record.c:3681
> > #9  0x0000555555c7297a in cmd_record (argc=1, argv=0x7fffffffdcc0) at
> > builtin-record.c:3976
> > #10 0x0000555555e06d41 in run_builtin (p=0x555556827538
> > <commands+216>, argc=5, argv=0x7fffffffdcc0) at perf.c:313
> > #11 0x0000555555e07253 in handle_internal_command (argc=5,
> > argv=0x7fffffffdcc0) at perf.c:365
> > #12 0x0000555555e07508 in run_argv (argcp=0x7fffffffdb0c,
> > argv=0x7fffffffdb00) at perf.c:409
> > #13 0x0000555555e07b32 in main (argc=5, argv=0x7fffffffdcc0) at perf.c:539
> > ```
> >
> > Not setting the mask->bits if the cpu map is dummy causes no data to
> > be written. Setting mask->bits 0 causes a segv. Setting bit 63 works
> > but feels like there are more invariants broken in the code.
> >
> > Here is a not good workaround patch:
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ba74fab02e62..62727b676f98 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3329,6 +3329,11 @@ static void record__mmap_cpu_mask_init(struct
> > mmap_cpu_mask *mask, struct perf_c
> >  {
> >         int c;
> >
> > +       if (cpu_map__is_dummy(cpus)) {
> > +               set_bit(63, mask->bits);
> > +               return;
> > +       }
> > +
> >         for (c = 0; c < cpus->nr; c++)
> >                 set_bit(cpus->map[c].cpu, mask->bits);
> >  }
> >
> > Alexey, what should the expected behavior be with per-thread mmaps?
> >
> > Thanks,
> > Ian
>
> Thanks a lot,
>
> In case of per-thread mmaps we should initialize thread_data[0]->maps[i] by
> evlist->mmap[i]. Looks like this was missed by this patchset.
>
> Your patch works, because it triggers test_bit() in record__thread_data_init_maps()
> and thread_data maps get correctly initialized.
>
> However, it's better to ignore thread_data->masks in record__mmap_cpu_mask_init()
> and setup thread_data maps explicitly for per-thread case.
>
> Also, to prevent more runtime crashes, --per-thread and --threads
> options should be mutually exclusive.
>
> I will prepare a fix for this issue soon.

Hi Alexey,

sorry to nag, I'm being nagged, is there an ETA on the fix? Is it
pragmatic to roll back for now?

Thanks,
Ian

> Regards,
> Alexey
>
> >
> >> +static void record__free_thread_masks(struct record *rec, int nr_threads)
> >> +{
> >> +       int t;
> >> +
> >> +       if (rec->thread_masks)
> >> +               for (t = 0; t < nr_threads; t++)
> >> +                       record__thread_mask_free(&rec->thread_masks[t]);
> >> +
> >> +       zfree(&rec->thread_masks);
> >> +}
> >> +
> >> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> >> +{
> >> +       int t, ret;
> >> +
> >> +       rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> >> +       if (!rec->thread_masks) {
> >> +               pr_err("Failed to allocate thread masks\n");
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       for (t = 0; t < nr_threads; t++) {
> >> +               ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> >> +               if (ret) {
> >> +                       pr_err("Failed to allocate thread masks[%d]\n", t);
> >> +                       goto out_free;
> >> +               }
> >> +       }
> >> +
> >> +       return 0;
> >> +
> >> +out_free:
> >> +       record__free_thread_masks(rec, nr_threads);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> >> +
> >> +       rec->nr_threads = 1;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int record__init_thread_masks(struct record *rec)
> >> +{
> >> +       struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> >> +
> >> +       return record__init_thread_default_masks(rec, cpus);
> >> +}
> >> +
> >>  int cmd_record(int argc, const char **argv)
> >>  {
> >>         int err;
> >> @@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
> >>                 goto out;
> >>         }
> >>
> >> +       err = record__init_thread_masks(rec);
> >> +       if (err) {
> >> +               pr_err("Failed to initialize parallel data streaming masks\n");
> >> +               goto out;
> >> +       }
> >> +
> >>         if (rec->opts.nr_cblocks > nr_cblocks_max)
> >>                 rec->opts.nr_cblocks = nr_cblocks_max;
> >>         pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> >> @@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
> >>         symbol__exit();
> >>         auxtrace_record__free(rec->itr);
> >>  out_opts:
> >> +       record__free_thread_masks(rec, rec->nr_threads);
> >> +       rec->nr_threads = 0;
> >>         evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
> >>         return err;
> >>  }
> >> --
> >> 2.19.0
> >>
