Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC41522905
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiEKBfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiEKBfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:35:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D885AE;
        Tue, 10 May 2022 18:35:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h16so198670wrb.2;
        Tue, 10 May 2022 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlMoWf+WcK7FsmAzwI9Eo6ALWogmpghWPuTvTMBTBJw=;
        b=evSf+lRM97X/jQOFLYOZVyXgJeez+rbkfQSUwKKBpMBA9AanvyIkbd/DPd4DDGF0CW
         F2p63Qvw8Vl8Xh0UdwglVwReVpDPQm5BSapTgEhUhDdUbadwggKppY0g39uD8Bfoc/aM
         G68Ra6kaBmLbkDZRYUSh0nuoGfD3anj5168F2jJ2oXZsgoSeXx7U429vIMJCu/KCXjHu
         +zjdoPSHSPwknobhuBbVMRY92faQdJBnEQ0TAQdTUtodbvAddNy2F0Uv0b0vmoex+2/t
         0MIWf31jgT8PMBS3wkLPaQRfcqIHwyfs90hHDFOVP1qTsvW6bbbrk9x1JmLu85H7xVth
         p7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlMoWf+WcK7FsmAzwI9Eo6ALWogmpghWPuTvTMBTBJw=;
        b=rpfMHcYJpOvnNQLQ3kpJyFc5xIKmx77uanzIZw4K83pa7LsgU6FDbl8tRXQGy0W873
         z23XeAvNM7K7n1zK+95HcYnZd16HIgQOM0Eau7iYafb4cm+Ese8uesObS8Zsp6SQF5wK
         HDcFjf7TOKNUS7mT1xYK+Fj23iM4af3RIUJ9uOfTCXUpDvB1YVC7+IluTn7l22CZ1zoh
         wtO2bG0mzZEGOiiv9E0cfpRFRO3CnPAi/uBDNspGPQyt8+eBcI1bL8b7AaOEy4f5X/Zf
         kykPGJ/3wlPPo3xiPEy7jC+NL4HGvFYLO1xznjbzdHOlT5Ncivsl/Ck8MbVfKzpbGjLI
         02xg==
X-Gm-Message-State: AOAM533Mhhtf0it6uCwOQz1+4BKSmmSqAPvW+66u8cmYJrNtu1M4RCr2
        lLF5RNdfhEntwliYefzbugNTgO0SroWv0TbRi/4=
X-Google-Smtp-Source: ABdhPJwGAbd3O30QasDeDkOpiVbiH5Mxwc+d8N6dOkladkWmXa1L/P8SnKwcpnV08NjmcnGx2dezoWjEbFvylBndiuQ=
X-Received: by 2002:a5d:6ac4:0:b0:20a:dd04:81da with SMTP id
 u4-20020a5d6ac4000000b0020add0481damr19947871wrw.705.1652232938013; Tue, 10
 May 2022 18:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <Ynka4u+jCvFefgwJ@krava> <20220510004057.68284-1-chengdongli@tencent.com>
In-Reply-To: <20220510004057.68284-1-chengdongli@tencent.com>
From:   Bryton Lee <brytonlee01@gmail.com>
Date:   Wed, 11 May 2022 09:35:26 +0800
Message-ID: <CAC2pzGdkXz+wJsiSLOV5quMugXDvbMbF-WpiJshXfMM9Qt3FRQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: fix callstack entries and nr print message
To:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com,
        mark.rutland@arm.com, mingo@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        german.gomez@arm.com, rickyman7@gmail.com,
        Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
        alexey.v.bayduraev@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Could you kindly review my patch again? I sent out my updates
yesterday. I am happy to know your guidance.

Thanks,
Chengdong

On Tue, May 10, 2022 at 8:41 AM Chengdong Li <brytonlee01@gmail.com> wrote:
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


-- 
Best Regards

Bryton.Lee
