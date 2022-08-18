Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F58C598916
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbiHRQmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344893AbiHRQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:41:57 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F56C275C;
        Thu, 18 Aug 2022 09:41:56 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10ec41637b3so2406839fac.4;
        Thu, 18 Aug 2022 09:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TxrZFV8dUb259eoEHCfR6GzbKO/Pq7sBw8UepmiQD0I=;
        b=E+zRoEDbKA3nfswxa9+A38F9nlGxb5Q2BvyxvITmlmCyt+pY3we+8izNi/gQvJzcPU
         DZIbvyNL3H61qDhC6MVzC5VI2LlMASlk1xtyUnwx6cjwv4L734nPO/kUgeQF/C2oA7xv
         bZgTBKcm5SY80kh5ppuRshkITshvgABOceZhkzk5pvm37sgp4VGNDYvH4aDoOX5G8gWG
         ZfM8d2pvPC24sZ1fuHc2wpFDVJPpCVu9qqk94WuhoJ4NEAZOubSPxrYW5rjsQqtYepjP
         nAIeatNY584uTHOmpmMGiZt2eAx5rR/uRkWA+gECG3yo9SZjx765gAROevN7Y1Hz99Uh
         d9Ag==
X-Gm-Message-State: ACgBeo17I1t64sbRup7XnyEdfFSVjKIw5zLQd8+o9LKRibjx053w5rgR
        QtxazkYbMQbkGiabNcDl2RkclTO8mS2UDN2fesg=
X-Google-Smtp-Source: AA6agR4toXcD4OdN15w3bGskhC2TqAiqVZ0qIKUDZWBfePKQ0n7SI0sdS+hjXr8PL6yzZUuFV7WnaLb9+j9k3OtvJgA=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr1855071oab.92.1660840915842; Thu, 18
 Aug 2022 09:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220817053930.769840-1-irogers@google.com> <20220817053930.769840-6-irogers@google.com>
In-Reply-To: <20220817053930.769840-6-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Aug 2022 09:41:44 -0700
Message-ID: <CAM9d7ciBh2DhH7wEVFfXucxtvaog_BBVkuYcNC4vX_XQDx-QCw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] perf mutex: Fix thread safety analysis
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:39 PM Ian Rogers <irogers@google.com> wrote:
>
> Add annotations to describe lock behavior. Add missing unlocks to
> perf_sched__replay. Alter hist_iter__top_callback as the thread-safety
> analysis cannot follow pointers through local variables.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-sched.c | 8 ++++++++
>  tools/perf/builtin-top.c   | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0f52f73be896..a8a765ed28ce 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -658,6 +658,8 @@ static void *thread_func(void *ctx)
>  }
>
>  static void create_tasks(struct perf_sched *sched)
> +       EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
> +       EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
>  {
>         struct task_desc *task;
>         pthread_attr_t attr;
> @@ -687,6 +689,8 @@ static void create_tasks(struct perf_sched *sched)
>  }
>
>  static void wait_for_tasks(struct perf_sched *sched)
> +       EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> +       EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
>  {
>         u64 cpu_usage_0, cpu_usage_1;
>         struct task_desc *task;
> @@ -738,6 +742,8 @@ static void wait_for_tasks(struct perf_sched *sched)
>  }
>
>  static void run_one_test(struct perf_sched *sched)
> +       EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
> +       EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
>  {
>         u64 T0, T1, delta, avg_delta, fluct;
>
> @@ -3314,6 +3320,8 @@ static int perf_sched__replay(struct perf_sched *sched)
>         for (i = 0; i < sched->replay_repeat; i++)
>                 run_one_test(sched);
>
> +       mutex_unlock(&sched->start_work_mutex);
> +       mutex_unlock(&sched->work_done_wait_mutex);

But this would wake up the replay tasks and let them burn cpus unnecessarily.
Maybe we can make them exit at the moment.


>         return 0;
>  }
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 3757292bfe86..e832f04e3076 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -196,6 +196,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
>                                         struct hist_entry *he,
>                                         struct perf_sample *sample,
>                                         struct evsel *evsel, u64 ip)
> +       EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
>  {
>         struct annotation *notes;
>         struct symbol *sym = he->ms.sym;
> @@ -724,13 +725,13 @@ static void *display_thread(void *arg)
>  static int hist_iter__top_callback(struct hist_entry_iter *iter,
>                                    struct addr_location *al, bool single,
>                                    void *arg)
> +       EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
>  {
>         struct perf_top *top = arg;
> -       struct hist_entry *he = iter->he;
>         struct evsel *evsel = iter->evsel;
>
>         if (perf_hpp_list.sym && single)
> -               perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
> +               perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
>
>         hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
>                      !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),

Looks like a separate change.

Thanks,
Namhyung


> --
> 2.37.1.595.g718a3a8f04-goog
>
