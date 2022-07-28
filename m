Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E25835D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiG1AAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiG1AAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:00:51 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF773BE06;
        Wed, 27 Jul 2022 17:00:47 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-10e49d9a59bso480174fac.5;
        Wed, 27 Jul 2022 17:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+oQUWY05StzsJvhE+BaApcn8j4FoC6AtwezEzT7oX0=;
        b=rWkjMr9Sa7TN0ybcv5H4lp5PBUrfb6s5tWC00sWKLmwpx3yir/8gMKAYZDlb0KcyTE
         gwslKIeMPb2/cWg+nndgYQq76qlPIRXD4kNUcMLejUJ0YiTFerPk/UCgHQy6mu0xpqwz
         p/fhMEHc+aAanMMboaKHngt0pH1UvFueq/wkCRWwoy5b8AMbP54mTck4Xa5a6LBlvn5m
         R2EgDtPzswp3ReZnU1qUq0/AQ7xl7aI6XzOWz3xor2vaK+FscII4hPiuy54BuBhAOhPl
         aL0IAtyfhMFZ53WpH8ox9zoyhDvannOiV7aJ1Bm81/FgK15zgwF4cV317wIbi3+0ptLJ
         R/Bw==
X-Gm-Message-State: AJIora+3lPSIeM/dagvQV/lTPheigsHvO5GAYFXa9kn1TMC8+etl38a1
        00RGB0kfW98eZwj7p8u92ydU38wAlyZvl3B/Jls=
X-Google-Smtp-Source: AGRyM1viIoXr0rlMUG/E0FM08nH62aWSlzNyzw1mjtt3Ds673zB0a1i9H/FYZP+R2SCW7l7K6CLmAJubY4b6PdcNMgI=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr3466726oaf.5.1658966447128; Wed, 27 Jul
 2022 17:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220709015033.38326-1-yangjihong1@huawei.com> <20220709015033.38326-7-yangjihong1@huawei.com>
In-Reply-To: <20220709015033.38326-7-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 17:00:36 -0700
Message-ID: <CAM9d7chkZzYmuuo3XZ4NdpAErv-5ermDBtOQ+ZaO30t=KuTNQg@mail.gmail.com>
Subject: Re: [RFC v3 06/17] perf kwork: Implement perf kwork report
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Paul Clarke <pc@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Implements framework of perf kwork report, which is used to report time
> properties such as run time and frequency:
>
> Test cases:
>
>   # perf kwork
>
>    Usage: perf kwork [<options>] {record|report}
>
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue, etc)
>       -v, --verbose         be more verbose (show symbol address, etc)
>
>   # perf kwork report -h
>
>    Usage: perf kwork report [<options>]
>
>       -C, --cpu <cpu>       list of cpus to profile
>       -i, --input <file>    input file name
>       -n, --name <name>     event name to profile
>       -s, --sort <key[,key2...]>
>                             sort by key(s): runtime, max, count
>       -S, --with-summary    Show summary with statistics
>           --time <str>      Time span for analysis (start,stop)
>
>   # perf kwork report
>
>     Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
>    --------------------------------------------------------------------------------------------------------------------------------
>    --------------------------------------------------------------------------------------------------------------------------------
>
>   # perf kwork report -S
>
>     Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
>    --------------------------------------------------------------------------------------------------------------------------------
>    --------------------------------------------------------------------------------------------------------------------------------
>     Total count            :         0
>     Total runtime   (msec) :     0.000 (0.000% load average)
>     Total time span (msec) :     0.000
>    --------------------------------------------------------------------------------------------------------------------------------
>
>   # perf kwork report -C 0,100
>   Requested CPU 100 too large. Consider raising MAX_NR_CPUS
>   Invalid cpu bitmap
>
>   # perf kwork report -s runtime1
>     Error: Unknown --sort key: `runtime1'
>
>    Usage: perf kwork report [<options>]
>
>       -C, --cpu <cpu>       list of cpus to profile
>       -i, --input <file>    input file name
>       -n, --name <name>     event name to profile
>       -s, --sort <key[,key2...]>
>                             sort by key(s): runtime, max, count
>       -S, --with-summary    Show summary with statistics
>           --time <str>      Time span for analysis (start,stop)
>
>   # perf kwork report -i perf_no_exist.data
>   failed to open perf_no_exist.data: No such file or directory
>
>   # perf kwork report --time 00FFF,
>   Invalid time span
>
> Since there are no report supported events, the output is empty.
>
> Briefly describe the data structure:
> 1. "class" indicates event type. For example, irq and softiq correspond
> to different types.
> 2. "cluster" refers to a specific event corresponding to a type. For
> example, RCU and TIMER in softirq correspond to different clusters,
> which contains three types of events: raise, entry, and exit.

Maybe I'm too late... but it's now "work", right?

> 3. "atom" includes time of each sample and sample of the previous phase.
> (For example, exit corresponds to entry, which is used for timehist.)
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/Documentation/perf-kwork.txt |  33 +
>  tools/perf/builtin-kwork.c              | 859 +++++++++++++++++++++++-
>  tools/perf/util/kwork.h                 | 161 +++++
>  3 files changed, 1051 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
> index c5b52f61da99..b79b2c0d047e 100644
> --- a/tools/perf/Documentation/perf-kwork.txt
> +++ b/tools/perf/Documentation/perf-kwork.txt
> @@ -17,8 +17,11 @@ There are several variants of 'perf kwork':
>    'perf kwork record <command>' to record the kernel work
>    of an arbitrary workload.
>
> +  'perf kwork report' to report the per kwork runtime.
> +
>      Example usage:
>          perf kwork record -- sleep 1
> +        perf kwork report
>
>  OPTIONS
>  -------
> @@ -38,6 +41,36 @@ OPTIONS
>  --verbose::
>         Be more verbose. (show symbol address, etc)
>
> +OPTIONS for 'perf kwork report'
> +----------------------------
> +
> +-C::
> +--cpu::
> +       Only show events for the given CPU(s) (comma separated list).
> +
> +-i::
> +--input::
> +       Input file name. (default: perf.data unless stdin is a fifo)
> +
> +-n::
> +--name::
> +       Only show events for the given name.
> +
> +-s::
> +--sort::
> +       Sort by key(s): runtime, max, count
> +
> +-S::
> +--with-summary::
> +       Show summary with statistics
> +
> +--time::
> +       Only analyze samples within given time window: <start>,<stop>. Times
> +       have the format seconds.microseconds. If start is not given (i.e., time
> +       string is ',x.y') then analysis starts at the beginning of the file. If
> +       stop time is not given (i.e, time string is 'x.y,') then analysis goes
> +       to end of file.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1]
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 8086236b7513..9c488d647995 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -25,6 +25,460 @@
>  #include <linux/time64.h>
>  #include <linux/zalloc.h>
>
> +/*
> + * report header elements width
> + */
> +#define PRINT_CPU_WIDTH 4
> +#define PRINT_COUNT_WIDTH 9
> +#define PRINT_RUNTIME_WIDTH 10
> +#define PRINT_TIMESTAMP_WIDTH 17
> +#define PRINT_KWORK_NAME_WIDTH 30
> +#define RPINT_DECIMAL_WIDTH 3
> +#define PRINT_TIME_UNIT_SEC_WIDTH 2
> +#define PRINT_TIME_UNIT_MESC_WIDTH 3

MSEC ?

Thanks,
Namhyung


> +#define PRINT_RUNTIME_HEADER_WIDTH (PRINT_RUNTIME_WIDTH + PRINT_TIME_UNIT_MESC_WIDTH)
> +#define PRINT_TIMESTAMP_HEADER_WIDTH (PRINT_TIMESTAMP_WIDTH + PRINT_TIME_UNIT_SEC_WIDTH)
> +
