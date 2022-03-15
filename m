Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AB24D9269
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbiCOCDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiCOCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:03:13 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56FF13CE8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:02:02 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id i18so9355784vkr.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HAPVMUD1lxYCnamxONVJx9ic0StEWbLmBaj3VaUmNk=;
        b=ASCtFuerHqUmD1H8gbfpEbjk+0bDByLuwQg02wRbxMokEiwqIBprAIOG9M7v0UOg8f
         tLPsebpL6ksJeTGw5U1p7vUDgJ707RXr4zdGeBZJa/7o9tJW2H7D/Bops/w5X8Ssrp5w
         6MooG/t+9b8UA36JLp1D8K+U9cVyNTDlBXbt2QmSaKxE/dYoin7Ykvbs2gXj3ZAVECXm
         irpc+Pu2OOdn9jZ4xicXGIEeTZCckmNxCjhP1XeoKsn7NFkm1Se4meNoCyIDrFjiWqzQ
         2CftgPWQQPjptp+fyT1bSJj+a4+oBV//KA8WiuHisDDNu6d384sJ1GZWrKy/KB+6beFc
         sEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HAPVMUD1lxYCnamxONVJx9ic0StEWbLmBaj3VaUmNk=;
        b=zUqRFtYLEjbfCkkplZUApL/W8YLGuNC651A4tVi0MTUlg6fQy6KqIy1JJBXegcj/kS
         wuo5EDDFYT/ymSLtvXwzOzpGiT8AsapTLIOUHEoCmCq/TRSDUCvpOzK9btn9wRQBd8zO
         lfVDQ2ZgJqLvr/69TBRkTv6lGUuSBVTLSHyODYmMg2yElao3ud3GuabxEAz4vjxZIdgP
         34P/sGHLHaqQJbrbN3zfpz3mH/mLC1DlkTZH6QfbRv0/0hcwmXCaIqOPZlTUToV+80TG
         8bw3YDZanFZwr0zTSYWhalKOPO/yzJZ26+Dc8g2r/HfJEHHxhifLOEmWnsMNe8eGdKUg
         fwjQ==
X-Gm-Message-State: AOAM531dQvtZjnauxzjAb6BkNyUgiHEa2oBLvNsbWAfyvx6xAO4GAZHK
        oOV1oi9Jlaqtr/43dgNVaRfr6Tw5xK9xDuziRKqMNuyVxhoSZg==
X-Google-Smtp-Source: ABdhPJzxaZXYOAQeql12ZxZ/JtqGE7Wz+aqcct1Dy2jmWiwJoPI+Kv6RkcA7wDqdozyjaqYmJB9uYohDCh1r0Npne60=
X-Received: by 2002:a1f:348a:0:b0:32d:34f:7941 with SMTP id
 b132-20020a1f348a000000b0032d034f7941mr10374403vka.13.1647309721755; Mon, 14
 Mar 2022 19:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com> <20220208211637.2221872-11-eranian@google.com>
In-Reply-To: <20220208211637.2221872-11-eranian@google.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 14 Mar 2022 19:01:49 -0700
Message-ID: <CABPqkBSzc167wNbJpWu7msfZ-KrGu-nMtFdw-naN+M7Q0py-vA@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] perf tools: Improve IBS error handling
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

Hi Kim,

On Tue, Feb 8, 2022 at 1:17 PM Stephane Eranian <eranian@google.com> wrote:
>
> From: Kim Phillips <kim.phillips@amd.com>
>
> improve the error message returned on failed perf_event_open() on AMD when
> using IBS.
>
> Output of executing 'perf record -e ibs_op// true' BEFORE this patch:
>
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)for event (ibs_op//u).
> /bin/dmesg | grep -i perf may provide additional information.
>
> Output after:
>
> AMD IBS cannot exclude kernel events.  Try running at a higher privilege level.
>
> Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:
>
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
> /bin/dmesg | grep -i perf may provide additional information.
>
> Output after:
>
> Error:
> AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Robert Richter <robert.richter@amd.com>
> Cc: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 22d3267ce294..d42f63a484df 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2847,9 +2847,22 @@ static bool find_process(const char *name)
>         return ret ? false : true;
>  }
>
> +static bool is_amd(const char *arch, const char *cpuid)
> +{
> +       return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
> +}
> +
> +static bool is_amd_ibs(struct evsel *evsel)
> +{
> +       return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
> +}
> +
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                          int err, char *msg, size_t size)
>  {
> +       struct perf_env *env = evsel__env(evsel);
> +       const char *arch = perf_env__arch(env);
> +       const char *cpuid = perf_env__cpuid(env);


This code dies for me on the latest tip.git because env = NULL and
perf_env_cpuid() is broken for NULL argument.
I don't quite know where this env global variable is set but I hope
there is a better way of doing this, maybe using
the evsel__env() function in the same util/evsel.c file.

Similarly, the is_amd_ibs() suffers from a NULL pointer dereference
because evsel->pmu_name maybe NULL:

$ perf record -e rc2 .....

causes a NULL pmu_name.

Could you please send me an updated version to integrate with the
branch sampling code?

Thanks.


>
>         char sbuf[STRERR_BUFSIZE];
>         int printed = 0, enforced = 0;
>
> @@ -2949,6 +2962,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                         return scnprintf(msg, size,
>         "Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
>                                         evsel__name(evsel));
> +               if (is_amd(arch, cpuid)) {
> +                       if (is_amd_ibs(evsel)) {
> +                               if (evsel->core.attr.exclude_kernel)
> +                                       return scnprintf(msg, size,
> +       "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
> +                               if (!evsel->core.system_wide)
> +                                       return scnprintf(msg, size,
> +       "AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
> +                       }
> +               }
> +
>                 break;
>         case ENODATA:
>                 return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> --
> 2.35.0.263.gb82422642f-goog
>
