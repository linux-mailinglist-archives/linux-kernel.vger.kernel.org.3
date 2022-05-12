Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A85244A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbiELFBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348701AbiELFBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:01:36 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021B134E6B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:01:27 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id z5-20020a9d62c5000000b00606041d11f1so1925625otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3wInYbrb2ph6YiCnffdbd2YSOMAfkQ2KVeL3NrQ5bo=;
        b=ba7x74AMCDAO4eCruwC0T05nJsQKgKU2f6Np81t9DVcJO6tZWtRgeItpmxIYNrHCMa
         agZfvPnLLdjA/Vi9muXK2+yk8YdCbzuCVwdQaA2kAC2OfkxOM0rDNaHZ7V86mZrmyQ+0
         QGPrUfk4t8YhOIKrg9P17wWlKoaBidgUS+OnN5EGkXKzsRVfvRzLgtcH4GzFcXOZEQWJ
         EiL0bU7ioby2eVxnRJ3BHSFaSClbrnj6k8oWtEcSAsPkSDWZVEzQpbOmLOIVw2XX0tA3
         nwsfTT4wO2BmxQSWk87XEGkB81mxUa5NhWS/Cfhs52s89AwUuTNJXixbQ96iKfCfD+p5
         xJHQ==
X-Gm-Message-State: AOAM530vdipTkqhErDDR1cyFWp86ewF6mSOF1HxFN8F05X6LfssGJsRI
        LpgVpV9pxZkuye5eLoNMdrxvt6VpXI778kV22YQ=
X-Google-Smtp-Source: ABdhPJxbZrNQH9zpsPFRkcgFoMpKHA7ETPM90wfXQZ/FDgRa22OPIfUWioHxnnh3slym7Se03G0fav5WCYpfRgUMtHc=
X-Received: by 2002:a9d:6645:0:b0:605:fb52:3739 with SMTP id
 q5-20020a9d6645000000b00605fb523739mr11198015otm.124.1652331686731; Wed, 11
 May 2022 22:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com> <1bce56f9-2e4c-6cff-c668-d62cab038591@intel.com>
 <CAM9d7cgTpZ1KFLMG5DT63twJZUgoxQ6zhUeMkSya0x4O6U9TMg@mail.gmail.com> <531bca30-c458-c0f6-61e0-08d64bdb1b3d@intel.com>
In-Reply-To: <531bca30-c458-c0f6-61e0-08d64bdb1b3d@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 May 2022 22:01:15 -0700
Message-ID: <CAM9d7cj_P27f=Mi=-he3v66G7DiOtGwo1=RdijC_hQ86LQ5isw@mail.gmail.com>
Subject: Re: [PATCH V3 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Wed, May 11, 2022 at 9:33 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/05/22 01:50, Namhyung Kim wrote:
> > On Wed, May 11, 2022 at 12:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
> >> event that sets up the system-wide maps before map propagation.
> >>
> >> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> >> whether or not the event needs to be system-wide.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>
> >> Changes in V3: Amended comment about all CPUs.
> >>
> >>  tools/perf/util/evlist.c | 45 ++++++++++++++++++++++++++++++++++++++++
> >>  tools/perf/util/evlist.h |  5 +++++
> >>  2 files changed, 50 insertions(+)
> >>
> >> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >> index 78c47cbafbc2..2b2900434bba 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -264,6 +264,51 @@ int evlist__add_dummy(struct evlist *evlist)
> >>         return 0;
> >>  }
> >>
> >> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> >> +{
> >> +       evsel->core.system_wide = true;
> >> +
> >> +       /*
> >> +        * All CPUs.
> >> +        *
> >> +        * Note perf_event_open() does not accept CPUs that are not online, so
> >> +        * in fact this CPU list will include only all online CPUs.
> >> +        */
> >> +       perf_cpu_map__put(evsel->core.own_cpus);
> >> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> >> +       perf_cpu_map__put(evsel->core.cpus);
> >> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> >
> > Maybe I'm missing something.. Wouldn't it be overwritten
> > by the user requested cpus during map propagation in
> > evlist__add()?
>
> Yes.  That gets changed in patch 22 "perf tools: Allow system-wide
> events to keep their own CPUs"

Oh, I see.  I'll take a look.

Thanks,
Namhyung
