Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A955792F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiFWL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiFWL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CAA4D271
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:57:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so27607179wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3ySZJDusRzirICooVQnq3Muwhk4u9wKcv/U8cr1I1Q=;
        b=MIaxpF2TZZA3FpFGmkf7iWuzW/e+FJLhNne/KTmdFaLIXQFCFGKtBdrlCC2JnGJeB8
         0eRcChSfkE/D9VXARFkCEMpq3bW6wM2ZVEMVM2pjKROzObn40jfAYNRkGRTReEc2RrbP
         bB9h4oqrZ55jkqHx/ksW0+tnLNBjXhbX3oZhs59XMwaAt94gZCEus5nDCyFpnctoH0Bn
         xk6uu0E0azOzs7HARrYISg21uigZaXOGDf9j72TOaV5uMiGL0EcbWArKQD/eCpZluQZA
         EdDOh4wm91p+05qK9w5D91ghd5WVEaoHDTqRKucObYUq/pKAr83QkofwKpCHkvEfpqYM
         rcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3ySZJDusRzirICooVQnq3Muwhk4u9wKcv/U8cr1I1Q=;
        b=dbXfE9CTZx1yS3QHQ5brhMgDO6miO4/E11lL/hA9E326DKOl1idZfEARhPPeSz4i3I
         pKhyMeRI3S0AkOLdnTvaIhsMQAFxYZDfMOMXGvnhRmuV0+lnY+3Rd/5wmSkg5yWFNULD
         L0wMEejZFdyyPwNki/HnE/axc7D9UAoFZEKxlLwhgvxAHvfg14blhL5Xk79wvVncFzMn
         jcjkDd+g09E/IMFWtX//XEnk5em2U7bAFh0CQBAkXnv9GfOq6zw5pu2uT6/xw8//jwgl
         l1WMNfy7L94CjZJ5wI8D+hdLe3t3EWuduHqkme6KzGKpdhEn4bdNnNvCpln86Z0lgzVr
         CRVQ==
X-Gm-Message-State: AJIora9QwH7KhrXulYverfaKOW+CARAswMy4f7IAxrHkYllaLPqRujRC
        rKO9ujt8BtvZ/qa4sUwN18OfUQ1U5r63Kdb9OysD7g==
X-Google-Smtp-Source: AGRyM1sVD9I3aAnpb/HGS8kvIzbhOxa+Mad9aCTXn7yixnbJgFwA0Irpw3jVe6TCur5lEYr108BlYSbGJ0TCikxRqkY=
X-Received: by 2002:a5d:5a1a:0:b0:21b:883a:28a1 with SMTP id
 bq26-20020a5d5a1a000000b0021b883a28a1mr8112947wrb.40.1655985434225; Thu, 23
 Jun 2022 04:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220618000907.433350-1-irogers@google.com> <YrLA5NMBv1uIx7UD@krava>
 <YrLGkqDMVidTtFMG@krava>
In-Reply-To: <YrLGkqDMVidTtFMG@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Jun 2022 04:57:01 -0700
Message-ID: <CAP-5=fVQ86hY_1z7rAXZTw=DRyrX3P28G6xx+WQT18skJYvwXQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:36 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jun 22, 2022 at 09:12:40AM +0200, Jiri Olsa wrote:
> > On Fri, Jun 17, 2022 at 05:09:03PM -0700, Ian Rogers wrote:
> > > New architectures bring new complexity, such as Intel's hybrid
> > > models. jevents provides an alternative to specifying events in the
> > > kernel and exposing them through sysfs, however, it is difficult to
> > > work with. For example, an error in the json input would yield an
> > > error message but no json file or location. It is also a challenge to
> > > update jsmn.c given its forked nature.
> > >
> > > The changes here switch from jevents.c to a rewrite in python called
> > > jevents.py. This means there is a build time dependency on python, but
> > > such a dependency already exists for asciidoc (used to generate perf's
> > > man pages). If the build detects that python isn't present or is older
> > > than version 3.6 (released Dec. 2016) then an empty file is
> > > substituted for the generated one.
> > >
> > > A challenge with this code is in avoiding regressions. For this reason
> > > the jevents.py produces identical output to jevents.c, validated with a
> > > test script and build target.
> > >
> > > v6. Fixes an annotation and use of removesuffix that aren't present in
> > >     Python 3.6. Linter issues are also fixed.The code was tested on
> > >     Python 3.6 and 3.8 with docker.
> >
> > hi,
> > I'm getting test failures with this:
> >
> >  10: PMU events                                                      :
> >  10.1: PMU event table sanity                                        : FAILED!
> >  10.2: PMU event map aliases                                         : FAILED!
> >  10.3: Parsing of PMU event table metrics                            : Ok
> >  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >
> > I can see that pass without the patchset, verbose run shows:
> >
> >       [jolsa@krava perf]$ sudo ./perf test -vv 'PMU event map aliases'
> >        10: PMU events                                                      :
> >        10.2: PMU event map aliases                                         :
> >       --- start ---
> >       test child forked, pid 272763
> >       Using CPUID GenuineIntel-6-8C-1
> >       intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> >       could not find test events map
> >       testing core PMU cpu aliases: failed
> >       test child finished with -1
> >       ---- end ----
> >       PMU events subtest 2: FAILED!
> >       [jolsa@krava perf]$ sudo ./perf test -vv 'PMU event table sanity'
> >        10: PMU events                                                      :
> >        10.1: PMU event table sanity                                        :
> >       --- start ---
> >       test child forked, pid 272771
> >       could not find test events map
> >       test child finished with -1
> >       ---- end ----
> >       PMU events subtest 1: FAILED!
>
> ah, ok I did not notice:
>
> Makefile.config:909: Python interpreter too old (older than 3.6) disabling jevent generation
>
> I installed python3-devel and it's ok
>
> should we make above tests SKIP in case there's empty pmu-events.c ?

Hmm.. I didn't know the empty case was failing, that seems
sub-optimal. It'd also be nice to report here a skip for not being
compiled in rather than a pass. Let me take a look later.

Thanks,
Ian

> thanks,
> jirka
