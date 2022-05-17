Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976A452AE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiEQXPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiEQXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:15:02 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC643EC9;
        Tue, 17 May 2022 16:15:01 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l16so696684oil.6;
        Tue, 17 May 2022 16:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hKdpqtuCqcq53/FL0d95GLSWtHDVcFVRWG97eELPOY=;
        b=cz2zRU5iMCzUnIsk7n8zFUWXycTPrp8ZlvmqYb2IXAtWyv8AEbfVF7Ymnt8nt8sC28
         AI/lEcp0isxBQO+It2zp8QtoROk5O+8maq8Qtv7ea3117Zq5qqv4bJp8NwjFp9COZQyO
         DJATsdMrMi9oOlShmdoT1j1Mmz43jqdcBrT3rVME580tvRFVCbpbaiamK3qSkVGuYVhD
         k2ly/RVmz5hQKuXWPvRmSmur84Osf/WJw6Yz/HiZcRya0thBG9hGUIapw3P/iOZbnDJI
         6B8poiwn+SHCgFtRerJul7o1wSZ2LeSL3J6XUIWqT4hgqJmatRdDRBZm/8uqR+S5aksF
         RHVg==
X-Gm-Message-State: AOAM530RnI87Kd1wEItLmFxAkPiLecFK7H7EvIhc3KXTcH4nhIfWJthv
        gMcGpEwTNQgycorsvJVRqUn6KszRI+21/RJb9Sg=
X-Google-Smtp-Source: ABdhPJy7mTXjny0vLuS+De6ESOYh5G7Q+IrOqDl4n91k1yR2w0Srh5TIrGgP1dDVkRYa5iN0w2w/M8MmlJCcI4p6x6s=
X-Received: by 2002:a05:6808:16ac:b0:2f9:52e5:da90 with SMTP id
 bb44-20020a05680816ac00b002f952e5da90mr17308310oib.5.1652829300570; Tue, 17
 May 2022 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <Ynka4u+jCvFefgwJ@krava> <20220517015726.96131-1-chengdongli@tencent.com>
In-Reply-To: <20220517015726.96131-1-chengdongli@tencent.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 May 2022 16:14:49 -0700
Message-ID: <CAM9d7chhpuKkUOet1YqvTsR4cc8WHrLTkofjA_meFY9-D_a7Mg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] perf tools: fix callstack entries and nr print message
To:     Chengdong Li <brytonlee01@gmail.com>
Cc:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, likexu@tencent.com,
        chengdongli@tencent.com
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

Hello,

On Mon, May 16, 2022 at 6:57 PM Chengdong Li <brytonlee01@gmail.com> wrote:
>
> From: Chengdong Li <chengdongli@tencent.com>
>
> when generating callstack information from branch_stack(Intel LBR),
> the actual number of callstack entry should be bigger than the number
> of branch_stack, for example:
>
>         branch_stack records:
>                 B() -> C()
>                 A() -> B()
>         converted callstack records should be:
>                 C()
>                 B()
>                 A()
> though, the number of callstack equals
> to the number of branch stack plus 1.
>
> This patch fixes above issue in branch_stack__printf(). For example,
>
>         # echo 'scale=2000; 4*a(1)' > cmd
>         # perf record --call-graph lbr bc -l < cmd
>
> Before applying this patch, `perf script -D` output:
>
>         1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
>         ... LBR call chain: nr:8
>         .....  0: fffffffffffffe00
>         .....  1: 000000000040a410
>         .....  2: 000000000040573c
>         .....  3: 0000000000408650
>         .....  4: 00000000004022f2
>         .....  5: 00000000004015f5
>         .....  6: 00007f5ed6dcb553
>         .....  7: 0000000000401698
>         ... FP chain: nr:2
>         .....  0: fffffffffffffe00
>         .....  1: 000000000040a6d8
>         ... branch callstack: nr:6    # which is not consistent with LBR records.
>         .....  0: 000000000040a410
>         .....  1: 0000000000408650    # ditto
>         .....  2: 00000000004022f2
>         .....  3: 00000000004015f5
>         .....  4: 00007f5ed6dcb553
>         .....  5: 0000000000401698
>          ... thread: bc:17990
>          ...... dso: /usr/bin/bc
>         bc 17990 1220022.677386:     894172 cycles:
>                           40a410 [unknown] (/usr/bin/bc)
>                           40573c [unknown] (/usr/bin/bc)
>                           408650 [unknown] (/usr/bin/bc)
>                           4022f2 [unknown] (/usr/bin/bc)
>                           4015f5 [unknown] (/usr/bin/bc)
>                     7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
>                           401698 [unknown] (/usr/bin/bc)
>
> After applied:
>
>         1220022677386876 0x2a40 [0xd8]: PERF_RECORD_SAMPLE(IP, 0x4002): 17990/17990: 0x40a6d6 period: 894172 addr: 0
>         ... LBR call chain: nr:8
>         .....  0: fffffffffffffe00
>         .....  1: 000000000040a410
>         .....  2: 000000000040573c
>         .....  3: 0000000000408650
>         .....  4: 00000000004022f2
>         .....  5: 00000000004015f5
>         .....  6: 00007f5ed6dcb553
>         .....  7: 0000000000401698
>         ... FP chain: nr:2
>         .....  0: fffffffffffffe00
>         .....  1: 000000000040a6d8
>         ... branch callstack: nr:7
>         .....  0: 000000000040a410
>         .....  1: 000000000040573c
>         .....  2: 0000000000408650
>         .....  3: 00000000004022f2
>         .....  4: 00000000004015f5
>         .....  5: 00007f5ed6dcb553
>         .....  6: 0000000000401698
>          ... thread: bc:17990
>          ...... dso: /usr/bin/bc
>         bc 17990 1220022.677386:     894172 cycles:
>                           40a410 [unknown] (/usr/bin/bc)
>                           40573c [unknown] (/usr/bin/bc)
>                           408650 [unknown] (/usr/bin/bc)
>                           4022f2 [unknown] (/usr/bin/bc)
>                           4015f5 [unknown] (/usr/bin/bc)
>                     7f5ed6dcb553 __libc_start_main+0xf3 (/usr/lib64/libc-2.17.so)
>                           401698 [unknown] (/usr/bin/bc)
>
> Change from v1:
>         - refined code style according to Jiri's review comments.
>
> Signed-off-by: Chengdong Li <chengdongli@tencent.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/session.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f9a320694b85..a7f93f5a1ac8 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1151,9 +1151,20 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>         struct branch_entry *entries = perf_sample__branch_entries(sample);
>         uint64_t i;
>
> -       printf("%s: nr:%" PRIu64 "\n",
> -               !callstack ? "... branch stack" : "... branch callstack",
> -               sample->branch_stack->nr);
> +       if (!callstack) {
> +               printf("%s: nr:%" PRIu64 "\n", "... branch stack", sample->branch_stack->nr);
> +       } else {
> +               /* the reason of adding 1 to nr is because after expanding
> +                * branch stack it generates nr + 1 callstack records. e.g.,
> +                *         B()->C()
> +                *         A()->B()
> +                * the final callstack should be:
> +                *         C()
> +                *         B()
> +                *         A()
> +                */
> +               printf("%s: nr:%" PRIu64 "\n", "... branch callstack", sample->branch_stack->nr+1);
> +       }
>
>         for (i = 0; i < sample->branch_stack->nr; i++) {
>                 struct branch_entry *e = &entries[i];
> @@ -1169,8 +1180,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>                                 (unsigned)e->flags.reserved,
>                                 e->flags.type ? branch_type_name(e->flags.type) : "");
>                 } else {
> -                       printf("..... %2"PRIu64": %016" PRIx64 "\n",
> -                               i, i > 0 ? e->from : e->to);
> +                       if (i == 0) {
> +                               printf("..... %2"PRIu64": %016" PRIx64 "\n"
> +                                      "..... %2"PRIu64": %016" PRIx64 "\n",
> +                                               i, e->to, i+1, e->from);
> +                       } else {
> +                               printf("..... %2"PRIu64": %016" PRIx64 "\n", i+1, e->from);
> +                       }
>                 }
>         }
>  }
> --
> 2.27.0
>
