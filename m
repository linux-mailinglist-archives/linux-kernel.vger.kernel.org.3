Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA658A145
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiHDTbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiHDTbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:31:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ECB6E2C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:31:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q30so861610wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aGjkhmIvnwcqLQbSOFBCkR1cfjJE7Hbwa+5fNevRKuc=;
        b=QaVYvQCz30zqEprRDkqypJhLvUiWaB4HFXQtkkrHtZSTC55M9bFdWYP9Fhi3TJhUkp
         grFlEeAySbHkix58AxR9WzAvLQG8UkV5srm0Srzp5r7xmg452kovuHWCEbNcm7/IYsw8
         HK8BO2Ty/iW3zrj7ftgMnxvuwm8Uem0BFKfYefgl703v0mupkMJJOUGwOAclEd/9RnJg
         mxGg+f5w9xUiFrZ6KO1SKTWkRV52RzGgrmG+h7mld1ktX1qa9TUp1U5vCyFzKXhSleeG
         LW+lNqrn9KoBWR0xxzPasviGm2ZKSRMGX1zxsv9eSrNTlHiv0rGAyDd/y94Um6MDywSh
         qwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aGjkhmIvnwcqLQbSOFBCkR1cfjJE7Hbwa+5fNevRKuc=;
        b=1hzn8HQtkreAiDHUVZsMhNvzYEzmYp+B/F6NZbw7DjRpqwA2Ct19YILgwL0mficlB9
         PitDrvhkf4QwFdVSvuW+gQvT4kn5IMCuByv0A2jlZabQ8M6GA06aFYbeQMzg0cznKrSI
         jtUDhiaXR+9H1F6rgaMTJ6wGy8IzN2wNh5AyBgk1IuZId2BfzRRlklkX0Z5SCnBTb4r1
         KzBJxwhWVeNJzxrLUGMybTSm+5O0XIaLqAFe4MIXBKlgrcWwumgQmHLLeXVJ1NL6N6LG
         DaLSoamr85Hy6tbXbSu0Yk1AKQ9W6gKvrn2XJmPvzz1RFsHX/PAUoEwP+2Xi3MXQd0HR
         ayMg==
X-Gm-Message-State: ACgBeo0G0sMr0qXN6uj25L46/qd0K1FzhgLuArPK7knUhjl4hVY/8hs/
        5YqoXxUB5li/TcO9qOJh1fxc7Qswdvqu9rsDhzR86Q==
X-Google-Smtp-Source: AA6agR7hwbiLDEMDY3c9luxh08xLMPlqCqTgN45hujP0/9+cQ6JmTeyry+yvDwOpIiFeCXDDIGDzrYSdS14twZuN2ZE=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr2278375wri.300.1659641466133; Thu, 04
 Aug 2022 12:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-7-irogers@google.com>
 <YuZ4CEnken8U4HO5@krava>
In-Reply-To: <YuZ4CEnken8U4HO5@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 Aug 2022 12:30:53 -0700
Message-ID: <CAP-5=fVczMiasS15UovH8kzOaNw=TC_adeqjC+xBzv8jVJ3DTQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] perf cpumap: Add range data encoding
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 5:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > +     event = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
> >       if (!event)
> >               return NULL;
> >
> > +     syn_data.data = &event->data;
> >       event->header.type = PERF_RECORD_CPU_MAP;
> > -     event->header.size = size;
> > -     event->data.type   = type;
> > -
> > -     cpu_map_data__synthesize(&event->data, map, type, max);
> > +     event->header.size = syn_data.size;
> > +     cpu_map_data__synthesize(&syn_data);
> >       return event;
> >  }
> >
> > +
> >  int perf_event__synthesize_cpu_map(struct perf_tool *tool,
> >                                  const struct perf_cpu_map *map,
> >                                  perf_event__handler_t process,
> > @@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
> >  int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
> >                                            perf_event__handler_t process)
> >  {
> > -     size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
> > +     struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
> >       struct perf_record_event_update *ev;
> > -     int max, err;
> > -     u16 type;
> > -
> > -     if (!evsel->core.own_cpus)
> > -             return 0;
>
> all seems fine, just looks like we no longer do this check,
> might not be needed anymore, as that changed in past

This function is called in a test and in this file. The caller already
does this test and so the check is redundant plus a little confusing:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/synthetic-events.c?h=perf/core#n2062
As you say, it wasn't needed any more and so I removed it.

Thanks,
Ian

> thanks,
> jirka
>
> > +     int err;
> >
> > -     ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
> > +     ev = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) + 2 * sizeof(u64));
> >       if (!ev)
> >               return -ENOMEM;
> >
> > +     syn_data.data = &ev->cpus.cpus;
> >       ev->header.type = PERF_RECORD_EVENT_UPDATE;
> > -     ev->header.size = (u16)size;
> > +     ev->header.size = (u16)syn_data.size;
> >       ev->type        = PERF_EVENT_UPDATE__CPUS;
> >       ev->id          = evsel->core.id[0];
> > -
> > -     cpu_map_data__synthesize(&ev->cpus.cpus, evsel->core.own_cpus, type, max);
> > +     cpu_map_data__synthesize(&syn_data);
> >
> >       err = process(tool, (union perf_event *)ev, NULL, NULL);
> >       free(ev);
> > --
> > 2.36.1.476.g0c4daa206d-goog
> >
