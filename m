Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90359EAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiHWSSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiHWSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:17:53 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D8B28
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:33:30 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id n125so14967523vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6UUggVno3NtXg6nTTBbURjdR2+xiDv89pi+m1jdDxQk=;
        b=XgpmVDbM+FApMFcUpkmb5yfvAY28J8ColrFltFSufxLYxszEwh808ROwBr1eTKW1QA
         K3EKc2qo/jsWRGwxlhrnZkETmQzsPOw/8rw6nJ93aEIGHqwygbo5dwLUly4+eEFMs6Wu
         jKcShrQJAnAA5rv0dobxKEOzTs7Juci4O6OUBRbV0EIXvdn012/tCC+il9JubxKtFrNh
         gqm8zYIcqXLJggfws/eXKgmEFKh1GLX0fagmdVJK9EA3DuKSST9pVZoN3XQppYtwokbQ
         iJs+aU3MQKxv8V5StQQD8b2APjQgeMK5EMDem1k50yRbTS3Ha1wXQF4wxzc6UV2yfXi5
         ShKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6UUggVno3NtXg6nTTBbURjdR2+xiDv89pi+m1jdDxQk=;
        b=KqJxtdhNiqczmnGwxKkx0pUvbb98740j6gW+SrGVSwQKCHeqdtSzCDy+fA5nfEpHM3
         GaQFAhB8tpvM9ExKly245XD8Jy10SmXcti7lJPM1On2HLUTGUjLIGmb4NP15Yw8abk2v
         N7XA+ORLONbnFvLI44yb+4UTY2LbVM7Iknqmh9EzMnspnzsveIRZ2nmWxZKU+ZclJbNf
         5pFyy4OJQYwqfSphT2LG21l2ebVCbrJF9dYkIwS6QuBOaS5ZWpgEFjNYzVyz4wHXg5fF
         PHl3ZNOTN6AyosnMTQocrycP5FGaJ4Ki/XMRQ+jSmVi0g6urbMOdKqDxfhMMPbCsuX5d
         6ZyA==
X-Gm-Message-State: ACgBeo2fRX1XvLvxir8JdBV+IEJO7CEnVXNcM81Lc0NKHl+PIub1EXDV
        7EC8177e4fTW/OeU5jcfyC74tAu8A3+jytX3zLnlkA==
X-Google-Smtp-Source: AA6agR45Wg2d3I7bbK0Yi/m4bUEcxSx2Ew4HCRi44gF3avGYxWzrpivLcQCdHaAJDk1xqqDdkv41URxbwXwRJuxSmTA=
X-Received: by 2002:a05:6102:ec7:b0:388:d2a2:41c5 with SMTP id
 m7-20020a0561020ec700b00388d2a241c5mr9212782vst.41.1661272408710; Tue, 23 Aug
 2022 09:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220822213352.75721-1-irogers@google.com> <YwTXXhVHeYAcXWmO@kernel.org>
In-Reply-To: <YwTXXhVHeYAcXWmO@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 23 Aug 2022 09:33:18 -0700
Message-ID: <CAP-5=fVk0JjSFm=tmJA+nqySCvBi9CzrbxrzpFdyzeLXZdHd7Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Tue, Aug 23, 2022 at 6:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Aug 22, 2022 at 02:33:51PM -0700, Ian Rogers escreveu:
> > If a weak group is broken then the reset_group flag remains set for
> > the next run. Having reset_group set means the counter isn't created
> > and ultimately a segfault.
> >
> > A simple reproduction of this is:
> > perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
> > which will be added as a test in the next patch.
>
> So doing this on that existing BPF related loop may solve the problem,
> but for someone looking just at the source code, without any comment,
> may be cryptic, no?
>
> And then the fixes tags talks about affinity, adding a bit more
> confusion, albeit being the part that does the weak logic :-\
>
> Can we have a comment just before:
>
> +             counter->reset_group = false;
>
> Stating that this is needed only when using -r?

It is possible to add a comment but thinking about it, it would have
said pretty much what the code was doing and so I skipped it. I'm wary
of comments that capture too much of the implementation as they are
prone to becoming stale. Logically this function is just iterating
over the evlist creating counters, but on top of that we have the
affinity optimization. The BPF code didn't need that and so has its
own evlist iteration. We could add another loop just to clear
reset_group, that didn't seem to make sense. It's unfortunate how that
relates to the fixes tag but I don't think we should optimize for that
case.

Thanks,
Ian

> - Arnaldo
>
> > Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7fb81a44672d..54cd29d07ca8 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -826,6 +826,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >       }
> >
> >       evlist__for_each_entry(evsel_list, counter) {
> > +             counter->reset_group = false;
> >               if (bpf_counter__load(counter, &target))
> >                       return -1;
> >               if (!evsel__is_bpf(counter))
> > --
> > 2.37.2.609.g9ff673ca1a-goog
>
> --
>
> - Arnaldo
