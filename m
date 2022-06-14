Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3A954BDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354348AbiFNWoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiFNWon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:44:43 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CEA527FF;
        Tue, 14 Jun 2022 15:44:43 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f2a4c51c45so14373551fac.9;
        Tue, 14 Jun 2022 15:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BlywHEHWwAikA1BIx+1HObwxJemRBodVSJxjZAvyH0=;
        b=oek8ORgLW920YK+aBF4RjJQ+66CJReyk51tWXZ0Ss6MAV8UmvfIr1Z1bfH9yMZZUIb
         xXqir0BHTbtml6r1JXLJoKEEPncPnua6TOz9xPj9fIz2dBkbqeaNz9K6HiSFc3xVys9v
         hPDsWraLEzExfKyuS/wxWDhXM3qx+/Rku+Fwk6yLfpoGjqMhTHYzeWiP+GhLxwEt1Rj6
         nBZeO5P4FBhZ82cGae8pqT/UDqbItDTvXqWnL+kLePURN07liQQ/EBDru7Kzr2HyKid4
         EdIR3My73lezA7lBQE9sJoF/cmuzaKVBvvG64btEpDRSrg0a3an63HRCtGSoXERTBxJP
         dkiQ==
X-Gm-Message-State: AJIora801HdU2doKnRFQJKBykyf/SbOCFHCBjIRcMW7iUWV6le5Lz6BT
        7ScTeaCMhjZu8TJz9YYnWVymWkp0Sq/eJC69TRc=
X-Google-Smtp-Source: AGRyM1tcQBnXP8BMOB9ZaS0TqFq8eO1YxGVAJA2mKzlS2ot5h4iNba25hnvfsR2rhL53UesyRj/glx3opr1n84ZngL4=
X-Received: by 2002:a05:6870:4585:b0:fb:5105:76b8 with SMTP id
 y5-20020a056870458500b000fb510576b8mr3627210oao.92.1655246682311; Tue, 14 Jun
 2022 15:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com>
In-Reply-To: <20220614143353.1559597-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 15:44:31 -0700
Message-ID: <CAM9d7chXE5rvSMfRBzy1TBZ_VNMW2Tn=bD4pkOZ9=e1gdxCKTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event encoding
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Tue, Jun 14, 2022 at 7:34 AM Ian Rogers <irogers@google.com> wrote:
>
> A mask encoding of a cpu map is laid out as:
>   u16 nr
>   u16 long_size
>   unsigned long mask[];
> However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> after long_size. This means 32-bit and 64-bit builds see the mask as
> being at different offsets. On top of this the structure is in the byte
> data[] encoded as:
>   u16 type
>   char data[]
> This means the mask's struct isn't the required 4 or 8 byte aligned, but
> is offset by 2. Consequently the long reads and writes are causing
> undefined behavior as the alignment is broken.
>
> Fix the mask struct by creating explicit 32 and 64-bit variants, use a
> union to avoid data[] and casts; the struct must be packed so the
> layout matches the existing perf.data layout. Taking an address of a
> member of a packed struct breaks alignment so pass the packed
> perf_record_cpu_map_data to functions, so they can access variables with
> the right alignment.
>
> As the 64-bit version has 4 bytes of padding, optimizing writing to only
> write the 32-bit version.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/perf/event.h | 36 +++++++++++--
>  tools/perf/tests/cpumap.c           | 19 ++++---
>  tools/perf/util/cpumap.c            | 80 +++++++++++++++++++++++------
>  tools/perf/util/cpumap.h            |  4 +-
>  tools/perf/util/session.c           | 30 +++++------
>  tools/perf/util/synthetic-events.c  | 34 +++++++-----
>  6 files changed, 143 insertions(+), 60 deletions(-)
>
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index e7758707cadd..d2d32589758a 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include <linux/limits.h>
>  #include <linux/bpf.h>
> +#include <linux/compiler.h>
>  #include <sys/types.h> /* pid_t */
>
>  #define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(obj), mem))
> @@ -153,20 +154,47 @@ enum {
>         PERF_CPU_MAP__MASK = 1,
>  };
>
> +/*
> + * Array encoding of a perf_cpu_map where nr is the number of entries in cpu[]
> + * and each entry is a value for a CPU in the map.
> + */
>  struct cpu_map_entries {
>         __u16                    nr;
>         __u16                    cpu[];
>  };
>
> -struct perf_record_record_cpu_map {
> +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 32-bit. */
> +struct perf_record_mask_cpu_map32 {
> +       /* Number of mask values. */
>         __u16                    nr;
> +       /* Constant 4. */
>         __u16                    long_size;
> -       unsigned long            mask[];
> +       /* Bitmap data. */
> +       __u32                    mask[];
>  };
>
> -struct perf_record_cpu_map_data {
> +/* Bitmap encoding of a perf_cpu_map where bitmap entries are 64-bit. */
> +struct perf_record_mask_cpu_map64 {
> +       /* Number of mask values. */
> +       __u16                    nr;
> +       /* Constant 8. */
> +       __u16                    long_size;
> +       /* Legacy padding. */
> +       char                     __pad[4];
> +       /* Bitmap data. */
> +       __u64                    mask[];
> +};
> +
> +struct __packed perf_record_cpu_map_data {
>         __u16                    type;
> -       char                     data[];
> +       union {
> +               /* Used when type == PERF_CPU_MAP__CPUS. */
> +               struct cpu_map_entries cpus_data;
> +               /* Used when type == PERF_CPU_MAP__MASK and long_size == 4. */
> +               struct perf_record_mask_cpu_map32 mask32_data;
> +               /* Used when type == PERF_CPU_MAP__MASK and long_size == 8. */
> +               struct perf_record_mask_cpu_map64 mask64_data;
> +       };
>  };

How about moving the 'type' to the union as well?
This way we don't need to pack the entire struct
and can have a common struct for 32 and 64 bit..

struct cpu_map_entries {
    __u16 type;
    __u16 nr;
    __u16 cpu[];
};

struct perf_record_mask_cpu_map {
    __u16 type;
    __u16 nr;
    __u16 long_size;  // still needed?
    __u16 pad;
    unsigned long mask[];
};

// changed it to union
union perf_record_cpu_map_data {
    __u16  type;
    struct cpu_map_entries cpus_data;
    struct perf_record_mask_cpu_map mask_data;
};

Thanks,
Namhyung
