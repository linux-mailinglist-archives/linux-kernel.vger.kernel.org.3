Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1A4F1FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiDDXFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiDDXEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:04:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37CA50E05
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:26:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d29so10558565wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 15:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tk4we7nUoTbyLWYY1AO8gmsaLDfVO5hbnaoNTmuLqaY=;
        b=MmiMkUkKCrCXllCkJdgoHz0VFLmBlQ/m7hwInTcUhMYAiYA8pSFQe6WU5JCKR54g4o
         MFlKrKv+gSMRZr4J9L0R3oG/ChbwlRyk0PCH766BCGKHTGTIG249s5J+cNvsQs7i+pAg
         aN2iqH6VTvmwmu4f7w/I7gVPJIFGt7hBd6YtPSQnxyAQD3SRUhdsTJMb9A/dpKkOMSOB
         FHnCmN9E1uCKkjZwMyEAcIVVejqdgco6SP1HuaRcHRQTgP5HvZbVLlz1tOlMdLOlhr/u
         L9M1k0xy1YnJM8Pbz2GwE2AIN2qvtdpIV781u07M3uPNtCijNOtdcQ6tbQkreZjRu5VY
         uD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tk4we7nUoTbyLWYY1AO8gmsaLDfVO5hbnaoNTmuLqaY=;
        b=7gq6rmdjANbjxHYJpPgM8NrcRM4J2hbJaUv/7HoZNqP6wVPvX6lx2vSxS0ZlBuFM9a
         l4bkrdzqBXi3O5pRpx9Sh4mTsZL8KQNXMFdgOIehzPQnvmnnr+TBDNBcul6tG349czbw
         fNwoLfQyw/C383HGygW6GEjUchcUM31FTG6UnrYCsK57aoAzR7R/xaQzDNzZXgUu0SBk
         aPabFMkeeefuHCKcLlIpx/ojlKyBtgBscQq+sSgVUcardBONQMVhQK9Ng/Xp/KQeBLNr
         lPs+J6SOSHhKoV36bZP9cQ9rY7RfUc05K3TO19VtrzuZI4Mk3jdZf5hMNyI4D4zgKvrz
         P4/g==
X-Gm-Message-State: AOAM533jRQ3sxfwlSWgg3nHLY8wXj6f6XuObl3H5PFJP3ume02UGDHFP
        K+XMY2xtCBRmYn/RHEkvekS8kW2b0fYNbOEEQEa5kw==
X-Google-Smtp-Source: ABdhPJy3GPr/sqd3mmhkoX0+NnSvR4nQrB9hn4knP/dKjYAVV49pBLovPKAlXms1bC3mk9rhyq6TQTFZ50mXQAN2obo=
X-Received: by 2002:a5d:50c3:0:b0:206:179f:1143 with SMTP id
 f3-20020a5d50c3000000b00206179f1143mr282595wrt.343.1649111164141; Mon, 04 Apr
 2022 15:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com> <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
In-Reply-To: <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Apr 2022 15:25:52 -0700
Message-ID: <CAP-5=fXK6BfeUdA=h=Rx3K96Hn5nHHPrz7hQDwCMRpSbzcBXvw@mail.gmail.com>
Subject: Re: [PATCH v13 01/16] perf record: Introduce thread affinity and mmap masks
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
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

On Mon, Jan 17, 2022 at 10:38 AM Alexey Bayduraev
<alexey.v.bayduraev@linux.intel.com> wrote:
>
> Introduce affinity and mmap thread masks. Thread affinity mask
> defines CPUs that a thread is allowed to run on. Thread maps
> mask defines mmap data buffers the thread serves to stream
> profiling data from.
>
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 123 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index bb716c953d02..41998f2140cd 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -87,6 +87,11 @@ struct switch_output {
>         int              cur_file;
>  };
>
> +struct thread_mask {
> +       struct mmap_cpu_mask    maps;
> +       struct mmap_cpu_mask    affinity;
> +};
> +
>  struct record {
>         struct perf_tool        tool;
>         struct record_opts      opts;
> @@ -112,6 +117,8 @@ struct record {
>         struct mmap_cpu_mask    affinity_mask;
>         unsigned long           output_max_size;        /* = 0: unlimited */
>         struct perf_debuginfod  debuginfod;
> +       int                     nr_threads;
> +       struct thread_mask      *thread_masks;
>  };
>
>  static volatile int done;
> @@ -2204,6 +2211,47 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>         return 0;
>  }
>
> +static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
> +{
> +       mask->nbits = nr_bits;
> +       mask->bits = bitmap_zalloc(mask->nbits);
> +       if (!mask->bits)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
> +{
> +       bitmap_free(mask->bits);
> +       mask->nbits = 0;
> +}
> +
> +static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
> +{
> +       int ret;
> +
> +       ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
> +       if (ret) {
> +               mask->affinity.bits = NULL;
> +               return ret;
> +       }
> +
> +       ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
> +       if (ret) {
> +               record__mmap_cpu_mask_free(&mask->maps);
> +               mask->maps.bits = NULL;
> +       }
> +
> +       return ret;
> +}
> +
> +static void record__thread_mask_free(struct thread_mask *mask)
> +{
> +       record__mmap_cpu_mask_free(&mask->maps);
> +       record__mmap_cpu_mask_free(&mask->affinity);
> +}
> +
>  static int parse_output_max_size(const struct option *opt,
>                                  const char *str, int unset)
>  {
> @@ -2683,6 +2731,73 @@ static struct option __record_options[] = {
>
>  struct option *record_options = __record_options;
>
> +static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
> +{
> +       int c;
> +       for (c = 0; c < cpus->nr; c++)
> +               set_bit(cpus->map[c].cpu, mask->bits);
> +}
> +

In per-thread mode it is possible that cpus is the dummy CPU map here.
This means that the cpu below has the value -1 and setting bit -1
actually has the effect of setting bit 63. Here is a reproduction
based on the acme/perf/core branch:

```
$ make STATIC=1 DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer
-fsanitize=undefined -fno-sanitize-recover'
$ perf record -o /tmp/perf.data  --per-thread true
tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
exponent -1 is negative
$ UBSAN_OPTIONS=abort_on_error=1 gdb --args perf record -o
/tmp/perf.data --per-thread true
(gdb) r
tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
exponent -1 is negative
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
#1  0x00007ffff71d2546 in __GI_abort () at abort.c:79
#2  0x00007ffff640db9f in __sanitizer::Abort () at
../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:151
#3  0x00007ffff6418efc in __sanitizer::Die () at
../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:58
#4  0x00007ffff63fd99e in
__ubsan::__ubsan_handle_shift_out_of_bounds_abort (Data=<optimized
out>, LHS=<optimized out>,
    RHS=<optimized out>) at
../../../../src/libsanitizer/ubsan/ubsan_handlers.cpp:378
#5  0x0000555555c54405 in set_bit (nr=-1, addr=0x555556ecd0a0)
    at tools/include/asm-generic/bitops/atomic.h:10
#6  0x0000555555c6ddaf in record__mmap_cpu_mask_init
(mask=0x555556ecd070, cpus=0x555556ecd050) at builtin-record.c:3333
#7  0x0000555555c7044c in record__init_thread_default_masks
(rec=0x55555681b100 <record>, cpus=0x555556ecd050) at
builtin-record.c:3668
#8  0x0000555555c705b3 in record__init_thread_masks
(rec=0x55555681b100 <record>) at builtin-record.c:3681
#9  0x0000555555c7297a in cmd_record (argc=1, argv=0x7fffffffdcc0) at
builtin-record.c:3976
#10 0x0000555555e06d41 in run_builtin (p=0x555556827538
<commands+216>, argc=5, argv=0x7fffffffdcc0) at perf.c:313
#11 0x0000555555e07253 in handle_internal_command (argc=5,
argv=0x7fffffffdcc0) at perf.c:365
#12 0x0000555555e07508 in run_argv (argcp=0x7fffffffdb0c,
argv=0x7fffffffdb00) at perf.c:409
#13 0x0000555555e07b32 in main (argc=5, argv=0x7fffffffdcc0) at perf.c:539
```

Not setting the mask->bits if the cpu map is dummy causes no data to
be written. Setting mask->bits 0 causes a segv. Setting bit 63 works
but feels like there are more invariants broken in the code.

Here is a not good workaround patch:

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba74fab02e62..62727b676f98 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3329,6 +3329,11 @@ static void record__mmap_cpu_mask_init(struct
mmap_cpu_mask *mask, struct perf_c
 {
        int c;

+       if (cpu_map__is_dummy(cpus)) {
+               set_bit(63, mask->bits);
+               return;
+       }
+
        for (c = 0; c < cpus->nr; c++)
                set_bit(cpus->map[c].cpu, mask->bits);
 }

Alexey, what should the expected behavior be with per-thread mmaps?

Thanks,
Ian

> +static void record__free_thread_masks(struct record *rec, int nr_threads)
> +{
> +       int t;
> +
> +       if (rec->thread_masks)
> +               for (t = 0; t < nr_threads; t++)
> +                       record__thread_mask_free(&rec->thread_masks[t]);
> +
> +       zfree(&rec->thread_masks);
> +}
> +
> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
> +{
> +       int t, ret;
> +
> +       rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
> +       if (!rec->thread_masks) {
> +               pr_err("Failed to allocate thread masks\n");
> +               return -ENOMEM;
> +       }
> +
> +       for (t = 0; t < nr_threads; t++) {
> +               ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
> +               if (ret) {
> +                       pr_err("Failed to allocate thread masks[%d]\n", t);
> +                       goto out_free;
> +               }
> +       }
> +
> +       return 0;
> +
> +out_free:
> +       record__free_thread_masks(rec, nr_threads);
> +
> +       return ret;
> +}
> +
> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
> +{
> +       int ret;
> +
> +       ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
> +       if (ret)
> +               return ret;
> +
> +       record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
> +
> +       rec->nr_threads = 1;
> +
> +       return 0;
> +}
> +
> +static int record__init_thread_masks(struct record *rec)
> +{
> +       struct perf_cpu_map *cpus = rec->evlist->core.cpus;
> +
> +       return record__init_thread_default_masks(rec, cpus);
> +}
> +
>  int cmd_record(int argc, const char **argv)
>  {
>         int err;
> @@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       err = record__init_thread_masks(rec);
> +       if (err) {
> +               pr_err("Failed to initialize parallel data streaming masks\n");
> +               goto out;
> +       }
> +
>         if (rec->opts.nr_cblocks > nr_cblocks_max)
>                 rec->opts.nr_cblocks = nr_cblocks_max;
>         pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
> @@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
>         symbol__exit();
>         auxtrace_record__free(rec->itr);
>  out_opts:
> +       record__free_thread_masks(rec, rec->nr_threads);
> +       rec->nr_threads = 0;
>         evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>         return err;
>  }
> --
> 2.19.0
>
