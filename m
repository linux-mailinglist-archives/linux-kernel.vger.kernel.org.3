Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F21462870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhK2XmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhK2Xl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:41:59 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FCAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:38:41 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w4so19200872ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cM4LLC7Ra6uzwcuWSM5NZXc4z65RXTzgZXg9TfzcrF0=;
        b=NjvrXefV+Tyz/6qIt23esO3IWA1rwOrUFvNgUnPxtLiRG8g5rEQxg9nsMJLXpZr3FK
         tU4ts056l/QVt0QnFbNLCAmiWh1+34UbklkMHozBzMVJfUe/vaRiB5ZYIu8Wx5nKspwL
         U+8KBLfAqLorkIDfctmoyGJ9T3ma4NnUm7KUTB/NKv4dYWw6iRyv/YlJDMlTmSue5KaW
         qWpNqaMvQ7NTbDnoXJ0dBTT6aL+nkUEFZZg1wgCxy92+V1kih/O98c8JHHCB/6+jP/92
         y8DvUnwagDbvGsCMClD+gGtexD2VsxNZIl+N3WABP7cE5SZIJlR/ahYfAiuN99RxsPoW
         oPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM4LLC7Ra6uzwcuWSM5NZXc4z65RXTzgZXg9TfzcrF0=;
        b=jQvz05a4t3NTaVtH/Wad2Lc8etglQdSKFC+STN+XjS8A6oQx/sOLN3/4F+ZViOaV8n
         kBHmANQZjQFK1ZFAsq+8XqVp/fIwLecgo94iL7hXayyJMqTNQ87wy/WkQRdw7/UOH314
         Oa02L0H+9OsSeeOTZyNMhbvNvvFZN47x/To+Q7bqeezE05h3YAxpW+PwkbKkcoxaHT6a
         oXqXmwo5hD9TKFA3NtmBWxWCB6+eaD43dY83nd610Kg4rXNg3x2PqzOhhWq1kpWmQ+T9
         M4tEFtMHr62sSNqpfvl63sG8Dlu4WyzGIHh2rZl/Ns6MCwFHb6N6bJgQl5QMO2rGHL+E
         QLqw==
X-Gm-Message-State: AOAM530mqxiQ2rG0PmJrzsCw0kO8Vv2zue2cDw0SSqq96P5Pyqnc8AZb
        wMUNai5tPMyxcPo6c+WQy+Vu73d3F9gNrusBCuV7Iw==
X-Google-Smtp-Source: ABdhPJzK9K+KVbfmPIZ+m0ojXFZFrobizxDicP6iM3RcGMNmXCBfxijWX476XWcc/i38FLLnoATKPFzu88o5GajmOqc=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr38013668ilj.2.1638229120515;
 Mon, 29 Nov 2021 15:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20211118201730.2302927-1-irogers@google.com> <YaOkbojVb2gZtfCk@krava>
In-Reply-To: <YaOkbojVb2gZtfCk@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Nov 2021 15:38:28 -0800
Message-ID: <CAP-5=fVRE8dcDtivYaAm=DQze4d2966X7oWTWVzstzWeC-xeSw@mail.gmail.com>
Subject: Re: [PATCH] perf header: Fix memory leaks
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 7:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Nov 18, 2021 at 12:17:30PM -0800, Ian Rogers wrote:
> > These leaks were found with leak sanitizer running "perf pipe recording
> > and injection test". In pipe mode feat_fd may hold onto an events struct
> > that needs freeing. When string features are processed they may
> > overwrite an already created string, so free this before the overwrite.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/header.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 79cce216727e..e3c1a532d059 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2321,6 +2321,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
> >  #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
> >  static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
> >  {\
> > +     free(ff->ph->env.__feat_env);                \
>
> hm, how is this set before this callback is triggered?

I see it for cpuid which is initially set in:
#0  perf_env__read_cpuid (env=0x62b000007240) at util/env.c:363
#1  0x0000555556325153 in perf_env__cpuid (env=0x62b000007240) at util/env.c:456
#2  0x00005555564002ff in evlist__init_trace_event_sample_raw
(evlist=0x61e000000080) at util/sample-raw.c:17
#3  0x00005555563f01f4 in __perf_session__new (data=0x7fffffffb8b0,
repipe=false, repipe_fd=-1, tool=0x7fffffffbaa0)
    at util/session.c:228
#4  0x000055555615f26b in perf_session__new (data=0x7fffffffb8b0,
tool=0x7fffffffbaa0) at util/session.h:70
#5  0x000055555616d991 in cmd_report (argc=0, argv=0x7fffffffe468) at
builtin-report.c:1408
#6  0x00005555562f36b8 in run_builtin (p=0x5555586bacd0
<commands+240>, argc=5, argv=0x7fffffffe468) at perf.c:313
#7  0x00005555562f3c11 in handle_internal_command (argc=5,
argv=0x7fffffffe468) at perf.c:365
#8  0x00005555562f3fce in run_argv (argcp=0x7fffffffe240,
argv=0x7fffffffe250) at perf.c:409
#9  0x00005555562f47bd in main (argc=5, argv=0x7fffffffe468) at perf.c:539

And then overwritten causing the leak:
#0  0x00005555563b965a in process_cpuid (ff=0x7fffffffad50, data=0x0)
at util/header.c:2333
#1  0x00005555563c53d2 in perf_event__process_feature
(session=0x62b000007200, event=0x621000006500) at util/header.c:4144
#2  0x000055555615fdef in process_feature_event
(session=0x62b000007200, event=0x621000006500) at builtin-report.c:230
#3  0x00005555563fa033 in perf_session__process_user_event
(session=0x62b000007200, event=0x621000006500, file_offset=868)
    at util/session.c:1668
#4  0x00005555563fae08 in perf_session__process_event
(session=0x62b000007200, event=0x621000006500, file_offset=868)
    at util/session.c:1803
#5  0x00005555563fc4e6 in __perf_session__process_pipe_events
(session=0x62b000007200) at util/session.c:2044
#6  0x00005555563ff005 in perf_session__process_events
(session=0x62b000007200) at util/session.c:2418
#7  0x000055555616508a in __cmd_report (rep=0x7fffffffbaa0) at
builtin-report.c:940
#8  0x000055555616f5c9 in cmd_report (argc=0, argv=0x7fffffffe468) at
builtin-report.c:1629
#9  0x00005555562f36b8 in run_builtin (p=0x5555586bacd0
<commands+240>, argc=5, argv=0x7fffffffe468) at perf.c:313
#10 0x00005555562f3c11 in handle_internal_command (argc=5,
argv=0x7fffffffe468) at perf.c:365
#11 0x00005555562f3fce in run_argv (argcp=0x7fffffffe240,
argv=0x7fffffffe250) at perf.c:409
#12 0x00005555562f47bd in main (argc=5, argv=0x7fffffffe468) at perf.c:539

Thanks,
Ian

> jirka
>
> >       ff->ph->env.__feat_env = do_read_string(ff); \
> >       return ff->ph->env.__feat_env ? 0 : -ENOMEM; \
> >  }
> > @@ -4124,6 +4125,7 @@ int perf_event__process_feature(struct perf_session *session,
> >       struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
> >       int type = fe->header.type;
> >       u64 feat = fe->feat_id;
> > +     int ret = 0;
> >
> >       if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
> >               pr_warning("invalid record type %d in pipe-mode\n", type);
> > @@ -4141,11 +4143,13 @@ int perf_event__process_feature(struct perf_session *session,
> >       ff.size = event->header.size - sizeof(*fe);
> >       ff.ph = &session->header;
> >
> > -     if (feat_ops[feat].process(&ff, NULL))
> > -             return -1;
> > +     if (feat_ops[feat].process(&ff, NULL)) {
> > +             ret = -1;
> > +             goto out;
> > +     }
> >
> >       if (!feat_ops[feat].print || !tool->show_feat_hdr)
> > -             return 0;
> > +             goto out;
> >
> >       if (!feat_ops[feat].full_only ||
> >           tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
> > @@ -4154,8 +4158,9 @@ int perf_event__process_feature(struct perf_session *session,
> >               fprintf(stdout, "# %s info available, use -I to display\n",
> >                       feat_ops[feat].name);
> >       }
> > -
> > -     return 0;
> > +out:
> > +     free_event_desc(ff.events);
> > +     return ret;
> >  }
> >
> >  size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
>
