Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1525881A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiHBSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiHBSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:05:22 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE910113A;
        Tue,  2 Aug 2022 11:05:20 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so18037019fac.13;
        Tue, 02 Aug 2022 11:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UHeuO4m1+0J5UAlSgd6a8rj3eBaXa+1Xip7NqoHiSmg=;
        b=NGrthaA8IXRcLwThaq0CE0GNaIEMB/4kzBAKzYrdS9YZBG89CeF7+5COgWR8oyg9de
         wrOFJBXEWjPLxNGdPr5WAdNIVrzkwEvxaDRmkVy9rooxfiXx+z0sAQWuzZqdMs1PXeCM
         0QEO/hcrtcObr+qIwPM8Pe0riQBQntLamG0aIDBGEnKED9JoPDIc4ES3u7Ok1d8NYz7J
         Fcdi/t/+kdLsMenrM9xxq5iODYfdL4Pm1vDSfhg0pO6QdmJpuVqAELxPmgjOfZt3z3Zd
         fvOO2NsVy2g33O4t6cI6oNPVZ9u+iWScxI3+lmizht8SwgWcFmeIdbcpb+iVral6HTU2
         I6kQ==
X-Gm-Message-State: ACgBeo23cnuwqozp9lHnqQ8dH6RbDcc+0OeYo06CeRHqwC9KT2v4suWR
        82hxGr+ABpsokxru6S1ThJKWvAROy46IlQ9UuAeozWGd
X-Google-Smtp-Source: AA6agR4jnsOeta38tYWDtd4Yqm1aG3kaThX1Nbcmx08uVJCpjEDUj5U8hpXpb0zZWYrLeCa+xwTKJPdrp1x5jy7WsQ0=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr310078oaf.5.1659463520100; Tue, 02 Aug
 2022 11:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220802073511.299459-1-namhyung@kernel.org> <20220802073511.299459-2-namhyung@kernel.org>
 <YuliN2UDbls5uW3u@kernel.org>
In-Reply-To: <YuliN2UDbls5uW3u@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Aug 2022 11:05:09 -0700
Message-ID: <CAM9d7chZT-mociK=+iF_6SO=1JuD2xaL1HpE4eeo=myngq9vTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf lock: Add -m/--map-length option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
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

On Tue, Aug 2, 2022 at 10:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 02, 2022 at 12:35:10AM -0700, Namhyung Kim escreveu:
> > The -m/--map-length option is to control number of max entries in the
> > perf lock contention BPF maps.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-lock.txt |  4 ++++
> >  tools/perf/builtin-lock.c              | 23 ++++++++++++++++++++++-
> >  tools/perf/util/bpf_lock_contention.c  |  3 +++
> >  tools/perf/util/lock-contention.h      |  1 +
> >  4 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> > index 7949d2e6891b..2101644785e0 100644
> > --- a/tools/perf/Documentation/perf-lock.txt
> > +++ b/tools/perf/Documentation/perf-lock.txt
> > @@ -145,6 +145,10 @@ CONTENTION OPTIONS
> >  --tid=::
> >          Record events on existing thread ID (comma separated list).
> >
> > +-m::
> > +--map-length::
> > +     Maximum number of BPF map entries (default: 10240).
>
> --map-nr-entries?
>
> I think we use this jargon "nr-entries" for arrays, lists, etc, better
> try to stick to it.

Makes sense, will change.

>
> Also what do you think about not using single letter options for things
> that are not that used?
>
> The map size has a default, one that seems generous, so changing it
> should be something uncommon, and then, if it becomes common that more
> entries are needed by default, we can change the default in the tool.

Fair enough, I'll remove the single letter option.

Thanks,
Namhyung
