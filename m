Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2071F4DB93E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbiCPUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354584AbiCPUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:17:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB96D94A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:16:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so2005489wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsIQz2Pkn6O8UOCJWUPHs3KUK5w6eLsc7Z0MCX/OzYY=;
        b=CoxlTDpPnw67QhX6lNxht0V1XLTaD3guuATfSlTW+4qA09bH1Vhjgptc/B73fbvCAK
         1j/jrxkdg9FI2eIig8EdNnLdTwUstauj94LjaAtQoaSmcN9c1Jipy0UoK1qHEMQEsW3G
         oQ7xzxg0NFonQAyzY++SEsZtGjCq7n/6JO2uYwgbmuWPI0m7x6WYFKy9r0ZiyRy2EKzy
         PvNXNRDDJcYA0GTx+xa3YRJH2LlC2LfvKqZI5Tv8/wNlGwIwZn5I4o4ZwUeFUy0x8ZDp
         WGa02qzA2ti8cod+zck9Bym/ucARRGPmyG+dnrwkgAvkRCFLFkZCwAX0KKIpnpFH6bka
         J5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsIQz2Pkn6O8UOCJWUPHs3KUK5w6eLsc7Z0MCX/OzYY=;
        b=zEUPlNeZ0/AUWVnFzHsgDjd+UWic1s3Yt2T7P/D9xKDQcHoZ8/E3R0VtpkadWEPGzT
         xWHu+FPyrt4ATIXMpJv6w1lI3u7dwA0D6F828BeHPlDaXzTSQnHSmY23/nknA1PnVBzQ
         qo4e0E1cgvAJ8GVBVtkgSpZo2Ac76MQ6HvyX6qI3Eexux6lBQ9IAXQMJzl9yVk80mjOO
         uZRwJZ7fZdY9Tf538NRRL7UArznRhIkYlNxqbTI3Com0lJ8/50HOhhAbGSv+Tjm+vCjW
         LJJb0wXpVIcwonlrWmvbq2EU46gN2tOFEbl0VNreJFs612fTX8TXAE0bnjKVeqmKPuVz
         bWjA==
X-Gm-Message-State: AOAM5303U2DqpE4NUQxYkzYqDytUr+Nk35UyqZv+ynEOVyzR6ke4MpLo
        0DjX7GLlO97FCNx0n9fEUjC1u+Eopo4/ihX7xC627eOOehY=
X-Google-Smtp-Source: ABdhPJzo5AgwZWU9D2SGLWVhoQ8j72mgNFYPe66/P7razkfABS6wbEWoecxkthxv8v9oAHsZJ0MNISSmC/DYOVsoevU=
X-Received: by 2002:a1c:c907:0:b0:37b:f983:5d4e with SMTP id
 f7-20020a1cc907000000b0037bf9835d4emr1141678wmb.174.1647461802210; Wed, 16
 Mar 2022 13:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220316071049.2368250-1-irogers@google.com> <YjHvB4q7VZyKsIUU@krava>
In-Reply-To: <YjHvB4q7VZyKsIUU@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 13:16:30 -0700
Message-ID: <CAP-5=fUkgp0G+Hj8fnO0RdMdbcKMesEHHE5SgS5OPpj_iW_D9w@mail.gmail.com>
Subject: Re: [PATCH] perf evlist: Avoid iteration for empty evlist.
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Mar 16, 2022 at 7:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Mar 16, 2022 at 12:10:49AM -0700, Ian Rogers wrote:
> > As seen with 'perf stat --null ..' and reported in:
> > https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/
> >
> > Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evlist.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 8134d45e2164..a2dba9e00765 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -354,7 +354,10 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
> >               .affinity = affinity,
> >       };
> >
> > -     if (itr.affinity) {
> > +     if (evlist__empty(evlist)) {
> > +             /* Ensure the empty list doesn't iterate. */
> > +             itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
>
> I can't see the crash anymore, but I'm bit confused with the code
>
> if evlist is empty then itr.evsel is bogus.. and the loop code
> __run_perf_stat is just lucky, right?

The itr.evsel is the list head, so bogus.

> I think we need to set itr.evsel to NULL and skip the loop in
> case evlist is empty

So that's the effect of this change except that the evsel is the list
head. I'm not sure it is worth adding the condition to setting the
evsel to capture that given that with the end condition having been
met it would be invalid to read it. There's a similar problem for the
other fields of the iterator.

Thanks,
Ian

> thanks,
> jirka
>
> > +     } else if (itr.affinity) {
> >               itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
> >               affinity__set(itr.affinity, itr.cpu.cpu);
> >               itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
> > --
> > 2.35.1.723.g4982287a31-goog
> >
