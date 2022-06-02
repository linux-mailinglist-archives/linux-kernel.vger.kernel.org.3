Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3E053B393
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiFBGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiFBGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:31:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9D21566F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:31:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so2234303wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaZ7ij0Wa+meDLextMIWiIiNGrk6ruzaTLbYxtYb9kw=;
        b=TTPHrl7iR1fifpf+Ewug4IGiCkcVeo+ik+A1WhzY2zwYrjOjNbMpSWjMd02nC+2InJ
         kqh6gKmbOpqHeTZ1ujgyUKAkyXfKfGrTNVv8twrUedxhDlm8Xv9o6CGaooVF2aYIT7CX
         fFC6AshXZoceKKssq6eRGnRiCmbPIJWIFOuB0Xxhx3/DEClbjGDWj6kqbLYR1GEj3LYL
         rabFe2b0/7jfIPP0eMXUsfAs6N4OCz8IVSxiFpKBd6vXeFyd5/5QVv7w0HBOFen8SkZ0
         5px258WV7dWZuJJch3yiJHQykE7jgA6O4xYzMVkcTvcvxmXRd8+yVrEqXSSQAIJagDh8
         2Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaZ7ij0Wa+meDLextMIWiIiNGrk6ruzaTLbYxtYb9kw=;
        b=TPfpijDikqb2O7tDh3T0/2zq7TR5yzABj92zwvNBN+z6ZjUKacgXF/RUp7VfyywI44
         4ftbaBDb9cI2PaNRKNRHpRq+6GcF/T4oRSQGKtWZ7qrjHIgZDX3Kimiec5PCaYPaxDTs
         9c0xlB00ymVyzKKaFvaLwstviATzCwQpBemtH/jkMTg7rP3kqffPKrUKg81QvXN06ZoP
         DYkwianYTtw+zn9IDDXWXx1Y0bW8MOyTItT2nA/r5Qt1xB/Z8YiQxBoNJenzeL5lZSJc
         z63X86O9QW/+lXJaR2NruW6OcU6ydzPFid0tea/xlSvpkz6em7jy42SYiZ65RCq7OEQb
         psdw==
X-Gm-Message-State: AOAM530IqqWIJfYjNToGRu1ZJ3HNoeHUpMr8gnIhnLFbozlFALU0R/vY
        rfT5FHfUIY9SRfJ7JSX24nSIKu7VGGyN2s/X63UjYw==
X-Google-Smtp-Source: ABdhPJxYywiqBU4GztfhpcSUJnofU7K0zVu2AOa0aJXrSjpogKxf75o9hAfm+85Yj1aW96wOVKtERufo6FTKyEwnPyc=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr31082529wmo.115.1654151489645; Wed, 01
 Jun 2022 23:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220601065846.456965-1-namhyung@kernel.org> <20220601065846.456965-6-namhyung@kernel.org>
In-Reply-To: <20220601065846.456965-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Jun 2022 23:31:16 -0700
Message-ID: <CAP-5=fUKLxL64M-OjokShgWwvbzS+WF_+Qxd8HPr2RXRurbNJg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf lock: Look up callchain for the contended locks
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
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

On Tue, May 31, 2022 at 11:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The lock contention tracepoints don't provide lock names.  All we can
> do is to get stack traces and show the caller instead.  To minimize
> the overhead it's limited to up to 8 stack traces and display the
> first non-lock function symbol name as a caller.
>
>   $ perf lock report -F acquired,contended,avg_wait
>
>                   Name   acquired  contended   avg wait (ns)
>
>    update_blocked_a...         40         40            3611
>    kernfs_fop_open+...          5          5            3636
>     _nohz_idle_balance          3          3            2650
>    tick_do_update_j...          1          1            6041
>     ep_scan_ready_list          1          1            3930
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 165 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 82cbf0f2e4cd..46a5b3b50f0b 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -9,6 +9,7 @@
>  #include "util/symbol.h"
>  #include "util/thread.h"
>  #include "util/header.h"
> +#include "util/callchain.h"
>
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
> @@ -19,6 +20,7 @@
>  #include "util/tool.h"
>  #include "util/data.h"
>  #include "util/string2.h"
> +#include "util/map.h"
>
>  #include <sys/types.h>
>  #include <sys/prctl.h>
> @@ -32,6 +34,7 @@
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <linux/err.h>
> +#include <linux/stringify.h>
>
>  static struct perf_session *session;
>
> @@ -120,6 +123,17 @@ static struct rb_root              thread_stats;
>  static bool combine_locks;
>  static bool show_thread_stats;
>
> +/*
> + * CONTENTION_STACK_DEPTH
> + * Number of stack trace entries to find callers
> + */
> +#define CONTENTION_STACK_DEPTH  8
> +
> +static u64 sched_text_start;
> +static u64 sched_text_end;
> +static u64 lock_text_start;
> +static u64 lock_text_end;
> +
>  static struct thread_stat *thread_stat_find(u32 tid)
>  {
>         struct rb_node *node;
> @@ -451,6 +465,18 @@ static struct lock_stat *pop_from_result(void)
>         return container_of(node, struct lock_stat, rb);
>  }
>
> +static struct lock_stat *lock_stat_find(u64 addr)
> +{
> +       struct hlist_head *entry = lockhashentry(addr);
> +       struct lock_stat *ret;
> +
> +       hlist_for_each_entry(ret, entry, hash_entry) {
> +               if (ret->addr == addr)
> +                       return ret;
> +       }
> +       return NULL;
> +}
> +
>  static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
>  {
>         struct hlist_head *entry = lockhashentry(addr);
> @@ -789,6 +815,116 @@ static int report_lock_release_event(struct evsel *evsel,
>         return 0;
>  }
>
> +static bool is_lock_function(u64 addr)
> +{
> +       if (!sched_text_start) {
> +               struct machine *machine = &session->machines.host;
> +               struct map *kmap;
> +               struct symbol *sym;
> +
> +               sym = machine__find_kernel_symbol_by_name(machine,
> +                                                         "__sched_text_start",
> +                                                         &kmap);
> +               if (!sym) {
> +                       /* to avoid retry */
> +                       sched_text_start = 1;
> +                       return false;
> +               }
> +
> +               sched_text_start = kmap->unmap_ip(kmap, sym->start);
> +
> +               /* should not fail from here */
> +               sym = machine__find_kernel_symbol_by_name(machine,
> +                                                         "__sched_text_end",
> +                                                         &kmap);
> +               sched_text_end = kmap->unmap_ip(kmap, sym->start);
> +
> +               sym = machine__find_kernel_symbol_by_name(machine,
> +                                                         "__lock_text_start",
> +                                                         &kmap);
> +               lock_text_start = kmap->unmap_ip(kmap, sym->start);
> +
> +               sym = machine__find_kernel_symbol_by_name(machine,
> +                                                         "__lock_text_end",
> +                                                         &kmap);
> +               lock_text_start = kmap->unmap_ip(kmap, sym->start);
> +       }
> +
> +       /* failed to get kernel symbols */
> +       if (sched_text_start == 1)
> +               return false;
> +
> +       /* mutex and rwsem functions are in sched text section */
> +       if (sched_text_start <= addr && addr < sched_text_end)
> +               return true;
> +
> +       /* spinlock functions are in lock text section */
> +       if (lock_text_start <= addr && addr < lock_text_end)
> +               return true;
> +
> +       return false;
> +}
> +
> +static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
> +                                 char *buf, int size)
> +{
> +       struct thread *thread;
> +       struct callchain_cursor *cursor = &callchain_cursor;
> +       struct symbol *sym;
> +       int skip = 0;
> +       int ret;
> +
> +       /* lock names will be replaced to task name later */
> +       if (show_thread_stats)
> +               return -1;
> +
> +       thread = machine__findnew_thread(&session->machines.host,
> +                                        -1, sample->pid);
> +       if (thread == NULL)
> +               return -1;
> +
> +       /* use caller function name from the callchain */
> +       ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> +                                       NULL, NULL, CONTENTION_STACK_DEPTH);
> +       if (ret != 0) {
> +               thread__put(thread);
> +               return -1;
> +       }
> +
> +       callchain_cursor_commit(cursor);
> +       thread__put(thread);
> +
> +       while (true) {
> +               struct callchain_cursor_node *node;
> +
> +               node = callchain_cursor_current(cursor);
> +               if (node == NULL)
> +                       break;
> +
> +               /* skip first 3 entries - for lock functions */
> +               if (++skip <= 3)
> +                       goto next;
> +
> +               sym = node->ms.sym;
> +               if (sym && !is_lock_function(node->ip)) {
> +                       struct map *map = node->ms.map;
> +                       u64 offset;
> +
> +                       offset = map->map_ip(map, node->ip) - sym->start;
> +
> +                       if (offset)
> +                               scnprintf(buf, size, "%s+%#lx", sym->name, offset);
> +                       else
> +                               strlcpy(buf, sym->name, size);
> +                       return 0;
> +               }
> +
> +next:
> +               callchain_cursor_advance(cursor);
> +       }
> +       return -1;
> +}
> +
>  static int report_lock_contention_begin_event(struct evsel *evsel,
>                                               struct perf_sample *sample)
>  {
> @@ -800,9 +936,18 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>         if (show_thread_stats)
>                 addr = sample->tid;
>
> -       ls = lock_stat_findnew(addr, "No name");
> -       if (!ls)
> -               return -ENOMEM;
> +       ls = lock_stat_find(addr);
> +       if (!ls) {
> +               char buf[128];
> +               const char *caller = buf;
> +
> +               if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
> +                       caller = "Unknown";
> +
> +               ls = lock_stat_findnew(addr, caller);
> +               if (!ls)
> +                       return -ENOMEM;
> +       }
>
>         ts = thread_stat_findnew(sample->tid);
>         if (!ts)
> @@ -1176,6 +1321,7 @@ static int __cmd_report(bool display_info)
>         struct perf_tool eops = {
>                 .sample          = process_sample_event,
>                 .comm            = perf_event__process_comm,
> +               .mmap            = perf_event__process_mmap,
>                 .namespaces      = perf_event__process_namespaces,
>                 .ordered_events  = true,
>         };
> @@ -1191,6 +1337,8 @@ static int __cmd_report(bool display_info)
>                 return PTR_ERR(session);
>         }
>
> +       /* for lock function check */
> +       symbol_conf.sort_by_name = true;
>         symbol__init(&session->header.env);
>
>         if (!perf_session__has_traces(session, "lock record"))
> @@ -1235,8 +1383,12 @@ static int __cmd_record(int argc, const char **argv)
>         const char *record_args[] = {
>                 "record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>         };
> +       const char *callgraph_args[] = {
> +               "--call-graph", "fp," __stringify(CONTENTION_STACK_DEPTH),
> +       };
>         unsigned int rec_argc, i, j, ret;
>         unsigned int nr_tracepoints;
> +       unsigned int nr_callgraph_args = 0;
>         const char **rec_argv;
>         bool has_lock_stat = true;
>
> @@ -1261,8 +1413,10 @@ static int __cmd_record(int argc, const char **argv)
>                 }
>         }
>
> +       nr_callgraph_args = ARRAY_SIZE(callgraph_args);
> +
>  setup_args:
> -       rec_argc = ARRAY_SIZE(record_args) + argc - 1;
> +       rec_argc = ARRAY_SIZE(record_args) + nr_callgraph_args + argc - 1;
>
>         if (has_lock_stat)
>                 nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
> @@ -1294,6 +1448,9 @@ static int __cmd_record(int argc, const char **argv)
>                 rec_argv[i++] = ev_name;
>         }
>
> +       for (j = 0; j < nr_callgraph_args; j++, i++)
> +               rec_argv[i] = callgraph_args[j];
> +
>         for (j = 1; j < (unsigned int)argc; j++, i++)
>                 rec_argv[i] = argv[j];
>
> --
> 2.36.1.255.ge46751e96f-goog
>
