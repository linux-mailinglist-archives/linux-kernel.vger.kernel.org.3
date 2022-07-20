Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213057AB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiGTAjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGTAj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:39:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76C4F198
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:39:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b26so23952482wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCCNsqvKf+swu9cU+kMO+BvpcV+KmN7njx2itJKwxsE=;
        b=PwGVkB1OBitQ9l/Sccgdw4R8+vOV9bQ8umxDZTG2CKoRm3az63O/5ZgjYFyBeYTxT5
         6Mqif0eVEUXP/vZFhbcGWOzcaEXgIopjahx1Dw/v2p9KnMefMyGbJzriXWdRxXYvaS4K
         kH4k/vk2MJWhfAiuWySUG6XMYYGevdT1hMST+0WK8TqJrlUBeUfTylJAknyOp9c2JYwg
         3HrZP3Vbbl5dppn30nhRFLyblJY3Z6bQXZxiGDMEN2jYH2dG1IBt+RTegprOnlknYnNw
         bQ0QHzuSs4UMvatGfJuXo9wSt+uTVEvHyj9tUEovRgv/bt6+KRGo/EGzxcTEYovrraPX
         cNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCCNsqvKf+swu9cU+kMO+BvpcV+KmN7njx2itJKwxsE=;
        b=runzn561sV0pXA46cEe+qhUgZ2A2q9gYHTU0/AALL4oNzzUy1ioBVk8Wg+RkHqPjHF
         UirrIb5pwOFSkesqRHAP0/S9ercQ9mpGezsAmo24qxhKkAsrnO0UqzNysKzOh+FCiH8S
         sPKYPLGhCKdRBXUungflgrjbPfToPSehTvG1X57TjzqF6I6EjS0iiFaPuf9zNaU9oO5D
         aCyx6T8VKUZFqcD9uRH9GydSk56Qmdu3QbcHQwDVSgyjeYHI0OucKmQAZoD4f7X/QIJh
         r7HWXOy/y3u3vBKxwwE+z+aRf0OY+Bb5I05awKTL8PAdoznE/1hY5paFp5cLx5kfs4xI
         Do+w==
X-Gm-Message-State: AJIora8FWcCUiWWjQFeEhC9FVzE9DSuKXBfwCzfVCeKfJ54omq8G2sV/
        zXHtF0iO/JHCVubn+UqdU9ptkxKX46uhgbXlSw8LRQ==
X-Google-Smtp-Source: AGRyM1vz3786oon6hZyydXOyOq8KcZZutBQMJxbZa+UHCbxAKJUDy4KYnLFkMeYBCBsoj848NvxOtM7G003ZnLeQX9E=
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id
 f14-20020a0560001a8e00b0021da7a854f4mr29347169wry.654.1658277564483; Tue, 19
 Jul 2022 17:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-16-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-16-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 17:39:12 -0700
Message-ID: <CAP-5=fVC0Vx+NWLW1NE4PuKLn0XHBG2MZhnTfLPZxhqE1To3jA@mail.gmail.com>
Subject: Re: [PATCH 15/35] perf script: Add machine_pid and vcpu
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add fields machine_pid and vcpu. These are displayed only if machine_pid is
> non-zero.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt |  7 ++++++-
>  tools/perf/builtin-script.c              | 11 +++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index e250ff5566cf..c09cc44e50ee 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -133,7 +133,8 @@ OPTIONS
>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>          brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
> -        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat.
> +        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> +        machine_pid, vcpu.
>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> @@ -226,6 +227,10 @@ OPTIONS
>         The ipc (instructions per cycle) field is synthesized and may have a value when
>         Instruction Trace decoding.
>
> +       The machine_pid and vcpu fields are derived from data resulting from using
> +       perf insert to insert a perf.data file recorded inside a virtual machine into

Presumably 'perf inject' ?

Thanks,
Ian

> +       a perf.data file recorded on the host at the same time.
> +
>         Finally, a user may not set fields to none for all event types.
>         i.e., -F "" is not allowed.
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4b00a50faf00..ac19fee62d8e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -125,6 +125,8 @@ enum perf_output_field {
>         PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 34,
>         PERF_OUTPUT_INS_LAT         = 1ULL << 35,
>         PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
> +       PERF_OUTPUT_MACHINE_PID     = 1ULL << 37,
> +       PERF_OUTPUT_VCPU            = 1ULL << 38,
>  };
>
>  struct perf_script {
> @@ -193,6 +195,8 @@ struct output_option {
>         {.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
>         {.str = "ins_lat", .field = PERF_OUTPUT_INS_LAT},
>         {.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
> +       {.str = "machine_pid", .field = PERF_OUTPUT_MACHINE_PID},
> +       {.str = "vcpu", .field = PERF_OUTPUT_VCPU},
>  };
>
>  enum {
> @@ -746,6 +750,13 @@ static int perf_sample__fprintf_start(struct perf_script *script,
>         int printed = 0;
>         char tstr[128];
>
> +       if (PRINT_FIELD(MACHINE_PID) && sample->machine_pid)
> +               printed += fprintf(fp, "VM:%5d ", sample->machine_pid);
> +
> +       /* Print VCPU only for guest events i.e. with machine_pid */
> +       if (PRINT_FIELD(VCPU) && sample->machine_pid)
> +               printed += fprintf(fp, "VCPU:%03d ", sample->vcpu);
> +
>         if (PRINT_FIELD(COMM)) {
>                 const char *comm = thread ? thread__comm_str(thread) : ":-1";
>
> --
> 2.25.1
>
