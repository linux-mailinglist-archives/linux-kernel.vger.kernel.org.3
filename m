Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABDA4A6523
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiBATqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:46:38 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38495 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiBATqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:46:37 -0500
Received: by mail-lj1-f169.google.com with SMTP id e17so25665012ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:46:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxCY3YXvJeg9FvYiKetuXpSQ46IOVB31nvPyUzA0Rl0=;
        b=oxCfh1AvgqJwT9T2+ln/bz66VeDgpDtPsTKDq/JJ7qveWboxGcBas8Ps9DYUHiKn6f
         +KpXEPtEtmcPKAwd32NJLnB5Ds6eAjdtqOyBHhNtOhH6JbmkNjV9Y9ZfkcOhz5JRvwHy
         4U/T5BemEzEg9g86XgtmlmjgH7dCLXUXAVF5A51GZMApN8xUtDFuxzeGIGuGf6XjmpV9
         ZCfPad6gSdXiA29PhZCjweLH2a6fpVybZfjjCB7jYMcFLqg+PTrRJsP7elS2Y0IvHfhW
         FHnaR2mmkMnCM0X7NwwZxz8hXVM/8+f/vlAwDnJG5049LTNKLgY4mQMM7mjgqxjZpneo
         wH2A==
X-Gm-Message-State: AOAM531Pki+N94+RsjRqiK+MMXSJLpFep37k6kvRLPcMNp/vJw2NtnZU
        jIqr5oQrxLwEU21Wn8Dfit96T9uvoYXAhg4fE9o=
X-Google-Smtp-Source: ABdhPJwEHdAOtP6g3cNHfU9CbyK8qKz1SAI2EpLTR7Js79m4FnHwB3PeG1DBhAZvuquDI1dk7eyZkq7hEtzCTo4OKUQ=
X-Received: by 2002:a2e:9090:: with SMTP id l16mr18006221ljg.366.1643744796154;
 Tue, 01 Feb 2022 11:46:36 -0800 (PST)
MIME-Version: 1.0
References: <YflZqY0rYQ3d1bKt@kernel.org>
In-Reply-To: <YflZqY0rYQ3d1bKt@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Feb 2022 11:46:25 -0800
Message-ID: <CAM9d7cgVmH=sKH07+fPVzEPzCfDiKaMs_-kNgFHFc6W+0F9MfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf beauty: Make the prctl arg regexp more strict to
 cope with PR_SET_VMA
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Colin Cross <ccross@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Feb 1, 2022 at 8:02 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> FYI, I'm carrying this on the perf tools tree:
>
> ---
>
> This new PR_SET_VMA value isn't in sequence with all the other prctl
> arguments and instead uses a big, 0x prefixed hex number: 0x53564d41 (S V M A).

It seems that we also have PR_SET_PTRACER: 0x59616d61.

>
> This makes it harder to generate a string table as it would be rather
> sparse, so make the regexp more stricter to avoid catching those.
>
> A followup patch for 'perf trace' to cope with such oddities will be
> needed, but then its a matter for the next merge window.
>
> The next patch will update the prctl.h file to cope with this perf build
> warning:
>
>   Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from latest version at 'include/uapi/linux/prctl.h'
>   diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
>
> Here is the output of this script:
>
>   $ tools/perf/trace/beauty/prctl_option.sh
>   static const char *prctl_options[] = {
>         [1] = "SET_PDEATHSIG",
>         [2] = "GET_PDEATHSIG",
>         [3] = "GET_DUMPABLE",
>         [4] = "SET_DUMPABLE",
>         [5] = "GET_UNALIGN",
>         [6] = "SET_UNALIGN",
>         [7] = "GET_KEEPCAPS",
>         [8] = "SET_KEEPCAPS",
>         [9] = "GET_FPEMU",
>         [10] = "SET_FPEMU",
>         [11] = "GET_FPEXC",
>         [12] = "SET_FPEXC",
>         [13] = "GET_TIMING",
>         [14] = "SET_TIMING",
>         [15] = "SET_NAME",
>         [16] = "GET_NAME",
>         [19] = "GET_ENDIAN",
>         [20] = "SET_ENDIAN",
>         [21] = "GET_SECCOMP",
>         [22] = "SET_SECCOMP",
>         [23] = "CAPBSET_READ",
>         [24] = "CAPBSET_DROP",
>         [25] = "GET_TSC",
>         [26] = "SET_TSC",
>         [27] = "GET_SECUREBITS",
>         [28] = "SET_SECUREBITS",
>         [29] = "SET_TIMERSLACK",
>         [30] = "GET_TIMERSLACK",
>         [31] = "TASK_PERF_EVENTS_DISABLE",
>         [32] = "TASK_PERF_EVENTS_ENABLE",
>         [33] = "MCE_KILL",
>         [34] = "MCE_KILL_GET",
>         [35] = "SET_MM",
>         [36] = "SET_CHILD_SUBREAPER",
>         [37] = "GET_CHILD_SUBREAPER",
>         [38] = "SET_NO_NEW_PRIVS",
>         [39] = "GET_NO_NEW_PRIVS",
>         [40] = "GET_TID_ADDRESS",
>         [41] = "SET_THP_DISABLE",
>         [42] = "GET_THP_DISABLE",
>         [43] = "MPX_ENABLE_MANAGEMENT",
>         [44] = "MPX_DISABLE_MANAGEMENT",
>         [45] = "SET_FP_MODE",
>         [46] = "GET_FP_MODE",
>         [47] = "CAP_AMBIENT",
>         [50] = "SVE_SET_VL",
>         [51] = "SVE_GET_VL",
>         [52] = "GET_SPECULATION_CTRL",
>         [53] = "SET_SPECULATION_CTRL",
>         [54] = "PAC_RESET_KEYS",
>         [55] = "SET_TAGGED_ADDR_CTRL",
>         [56] = "GET_TAGGED_ADDR_CTRL",
>         [57] = "SET_IO_FLUSHER",
>         [58] = "GET_IO_FLUSHER",
>         [59] = "SET_SYSCALL_USER_DISPATCH",
>         [60] = "PAC_SET_ENABLED_KEYS",
>         [61] = "PAC_GET_ENABLED_KEYS",
>         [62] = "SCHED_CORE",
>   };
>   static const char *prctl_set_mm_options[] = {
>         [1] = "START_CODE",
>         [2] = "END_CODE",
>         [3] = "START_DATA",
>         [4] = "END_DATA",
>         [5] = "START_STACK",
>         [6] = "START_BRK",
>         [7] = "BRK",
>         [8] = "ARG_START",
>         [9] = "ARG_END",
>         [10] = "ENV_START",
>         [11] = "ENV_END",
>         [12] = "AUXV",
>         [13] = "EXE_FILE",
>         [14] = "MAP",
>         [15] = "MAP_SIZE",
>   };
>   $
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Colin Cross <ccross@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/trace/beauty/prctl_option.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
> index 3109d7b05e113bb5..3d278785fe574a0e 100755
> --- a/tools/perf/trace/beauty/prctl_option.sh
> +++ b/tools/perf/trace/beauty/prctl_option.sh
> @@ -4,7 +4,7 @@
>  [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
>
>  printf "static const char *prctl_options[] = {\n"
> -regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
> +regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'

I'm not sure what the last parenthesis takes care of.

>  egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \

Maybe just adding PR_SET_VMA here is enough?

Thanks,
Namhyung


>         sed -r "s/$regex/\2 \1/g"       | \
>         sort -n | xargs printf "\t[%s] = \"%s\",\n"
> --
> 2.34.1
>
