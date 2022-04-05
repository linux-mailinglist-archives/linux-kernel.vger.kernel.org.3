Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB614F51A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846713AbiDFCIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457637AbiDEQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:23:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5C37DE31
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649175684; x=1680711684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOfrO/l6F0LrcdJO4XTmDU8NuIKRrF+SxqFE/ogbwpU=;
  b=UqlefvKEhYJnX7An8mRh+tVt+hlleiWqWRiTppvgGunv35lxwiCdRi7g
   qo6Wk/Aqmf9kCxc+LYRnUmTyaIGtcpN8qMA1oS2e8WQ7YYmmqX0edobF2
   X1ERCMAs50pt2ahZXgZaRCbursgvuaHw7O2ZJ9JOMwx2bkSTalT1H4XtB
   wL2fQ4/zvzXPGCIAWCT9Q2lv8xfy7rABx+Ac+dDAM3tvMo84SjIAuHveD
   AYnB+BeQhQT/4+zFaAFsQsSDWOkz8UdXoYG+A5tuO6zu5SRHRcRzDYgEm
   G1qUKIS72rjkPtHidXnmfxbylyOkW0oR6lXlit8MB4eZcLL4CHi9jEgEr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259624479"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="259624479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:21:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569963695"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.229.244]) ([10.249.229.244])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:21:20 -0700
Message-ID: <b1b875cb-cae5-e707-7897-047f991c3db0@linux.intel.com>
Date:   Tue, 5 Apr 2022 19:21:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 01/16] perf record: Introduce thread affinity and mmap
 masks
Content-Language: en-GB
To:     Ian Rogers <irogers@google.com>
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
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <CAP-5=fXK6BfeUdA=h=Rx3K96Hn5nHHPrz7hQDwCMRpSbzcBXvw@mail.gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
In-Reply-To: <CAP-5=fXK6BfeUdA=h=Rx3K96Hn5nHHPrz7hQDwCMRpSbzcBXvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.04.2022 1:25, Ian Rogers wrote:
> On Mon, Jan 17, 2022 at 10:38 AM Alexey Bayduraev
> <alexey.v.bayduraev@linux.intel.com> wrote:
>>
>> Introduce affinity and mmap thread masks. Thread affinity mask

<SNIP>

> 
> In per-thread mode it is possible that cpus is the dummy CPU map here.
> This means that the cpu below has the value -1 and setting bit -1
> actually has the effect of setting bit 63. Here is a reproduction
> based on the acme/perf/core branch:
> 
> ```
> $ make STATIC=1 DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer
> -fsanitize=undefined -fno-sanitize-recover'
> $ perf record -o /tmp/perf.data  --per-thread true
> tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
> exponent -1 is negative
> $ UBSAN_OPTIONS=abort_on_error=1 gdb --args perf record -o
> /tmp/perf.data --per-thread true
> (gdb) r
> tools/include/asm-generic/bitops/atomic.h:10:36: runtime error: shift
> exponent -1 is negative
> (gdb) bt
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
> #1  0x00007ffff71d2546 in __GI_abort () at abort.c:79
> #2  0x00007ffff640db9f in __sanitizer::Abort () at
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:151
> #3  0x00007ffff6418efc in __sanitizer::Die () at
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:58
> #4  0x00007ffff63fd99e in
> __ubsan::__ubsan_handle_shift_out_of_bounds_abort (Data=<optimized
> out>, LHS=<optimized out>,
>     RHS=<optimized out>) at
> ../../../../src/libsanitizer/ubsan/ubsan_handlers.cpp:378
> #5  0x0000555555c54405 in set_bit (nr=-1, addr=0x555556ecd0a0)
>     at tools/include/asm-generic/bitops/atomic.h:10
> #6  0x0000555555c6ddaf in record__mmap_cpu_mask_init
> (mask=0x555556ecd070, cpus=0x555556ecd050) at builtin-record.c:3333
> #7  0x0000555555c7044c in record__init_thread_default_masks
> (rec=0x55555681b100 <record>, cpus=0x555556ecd050) at
> builtin-record.c:3668
> #8  0x0000555555c705b3 in record__init_thread_masks
> (rec=0x55555681b100 <record>) at builtin-record.c:3681
> #9  0x0000555555c7297a in cmd_record (argc=1, argv=0x7fffffffdcc0) at
> builtin-record.c:3976
> #10 0x0000555555e06d41 in run_builtin (p=0x555556827538
> <commands+216>, argc=5, argv=0x7fffffffdcc0) at perf.c:313
> #11 0x0000555555e07253 in handle_internal_command (argc=5,
> argv=0x7fffffffdcc0) at perf.c:365
> #12 0x0000555555e07508 in run_argv (argcp=0x7fffffffdb0c,
> argv=0x7fffffffdb00) at perf.c:409
> #13 0x0000555555e07b32 in main (argc=5, argv=0x7fffffffdcc0) at perf.c:539
> ```
> 
> Not setting the mask->bits if the cpu map is dummy causes no data to
> be written. Setting mask->bits 0 causes a segv. Setting bit 63 works
> but feels like there are more invariants broken in the code.
> 
> Here is a not good workaround patch:
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ba74fab02e62..62727b676f98 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3329,6 +3329,11 @@ static void record__mmap_cpu_mask_init(struct
> mmap_cpu_mask *mask, struct perf_c
>  {
>         int c;
> 
> +       if (cpu_map__is_dummy(cpus)) {
> +               set_bit(63, mask->bits);
> +               return;
> +       }
> +
>         for (c = 0; c < cpus->nr; c++)
>                 set_bit(cpus->map[c].cpu, mask->bits);
>  }
> 
> Alexey, what should the expected behavior be with per-thread mmaps?
> 
> Thanks,
> Ian

Thanks a lot,

In case of per-thread mmaps we should initialize thread_data[0]->maps[i] by
evlist->mmap[i]. Looks like this was missed by this patchset.

Your patch works, because it triggers test_bit() in record__thread_data_init_maps()
and thread_data maps get correctly initialized.

However, it's better to ignore thread_data->masks in record__mmap_cpu_mask_init()
and setup thread_data maps explicitly for per-thread case.

Also, to prevent more runtime crashes, --per-thread and --threads 
options should be mutually exclusive.

I will prepare a fix for this issue soon.

Regards,
Alexey

> 
>> +static void record__free_thread_masks(struct record *rec, int nr_threads)
>> +{
>> +       int t;
>> +
>> +       if (rec->thread_masks)
>> +               for (t = 0; t < nr_threads; t++)
>> +                       record__thread_mask_free(&rec->thread_masks[t]);
>> +
>> +       zfree(&rec->thread_masks);
>> +}
>> +
>> +static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
>> +{
>> +       int t, ret;
>> +
>> +       rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
>> +       if (!rec->thread_masks) {
>> +               pr_err("Failed to allocate thread masks\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for (t = 0; t < nr_threads; t++) {
>> +               ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
>> +               if (ret) {
>> +                       pr_err("Failed to allocate thread masks[%d]\n", t);
>> +                       goto out_free;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +out_free:
>> +       record__free_thread_masks(rec, nr_threads);
>> +
>> +       return ret;
>> +}
>> +
>> +static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
>> +{
>> +       int ret;
>> +
>> +       ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
>> +       if (ret)
>> +               return ret;
>> +
>> +       record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
>> +
>> +       rec->nr_threads = 1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int record__init_thread_masks(struct record *rec)
>> +{
>> +       struct perf_cpu_map *cpus = rec->evlist->core.cpus;
>> +
>> +       return record__init_thread_default_masks(rec, cpus);
>> +}
>> +
>>  int cmd_record(int argc, const char **argv)
>>  {
>>         int err;
>> @@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
>>                 goto out;
>>         }
>>
>> +       err = record__init_thread_masks(rec);
>> +       if (err) {
>> +               pr_err("Failed to initialize parallel data streaming masks\n");
>> +               goto out;
>> +       }
>> +
>>         if (rec->opts.nr_cblocks > nr_cblocks_max)
>>                 rec->opts.nr_cblocks = nr_cblocks_max;
>>         pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
>> @@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
>>         symbol__exit();
>>         auxtrace_record__free(rec->itr);
>>  out_opts:
>> +       record__free_thread_masks(rec, rec->nr_threads);
>> +       rec->nr_threads = 0;
>>         evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
>>         return err;
>>  }
>> --
>> 2.19.0
>>
