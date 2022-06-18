Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF785501B7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358481AbiFRBmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiFRBmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:42:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD55A17C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:42:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso3120251wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImA2TsTKHG7+vdC/F5W3JR4P1g4uMzx7I/ft34Eowdw=;
        b=seBZhPQDYCD66pKqf8TJgaCXBg+qa/mcq7pRIManL+VY0q/o8Mxp7h1OlpvqENcQuW
         vQq4Azd4ZOXqml6SKFgsyAn+EvetF3YRRkwQjFMOybUFJvdctcWl2cSYLTUnxLqHCQlc
         qGN6EsMmIkqQ3B7ujOe2rD/o8cPe1ypVvryJRvpejIkGqrU0lR4dtwUS0EwE86bGB9YG
         76rrd+lQ0Z4NBO+K3v6biSTmZcldMjqhPIhCY9y1BrMYezpILwx9uMWdIXPqZ0wFyxVG
         kNYNvEe2Rzpy3fwLb/RwU1jG1yAWkXcSlObhk3Zf2YCjjnK5MGxiBThf3LVIy9fqEumU
         vfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImA2TsTKHG7+vdC/F5W3JR4P1g4uMzx7I/ft34Eowdw=;
        b=FPs9dIMjMMNdWLyVehZr4DXDg9HfyyDE4lWqWliJLikm5ccWSlmg1mXiuWUVf/Yp78
         i8hW7AwNRxPnjciFZqYKxAtinfChyRp9xhRLrA58IX7+jZ18p5tr2mTFWK2E2lDassbs
         ikEb/IAZePyl3exXrQYRd+S+ez0fhsGV33Qp8YeJliDXgkA1Gdd314NC1q0mZFteMl/2
         OpNMieRkv8/knxUZYM2XnFqiCEuKKqYrvouztvVdtMww/UyKEiI/KOADtRejpOR/FxxO
         POKlv5445X60urdzsxbwqPZxn5ebJmCRRbM8irwX0VSZKIqwLNjXGldn6TUE7wd2WT88
         Ldbg==
X-Gm-Message-State: AJIora8JuWsa+G70mkd53aSyvZX+DCoZAqUHMR16BdariAxiaXDxV69h
        m0ZQZ5SQm6jtBZwLh/Ex8s6r/jGWWEb54uHuCTMFuQ==
X-Google-Smtp-Source: AGRyM1uJAVgMC+FdPKXuDnS8BkERCAtpEBQ/QwnGY07QPhz0sSjWHadTqyyK+cNCrTlIFQ7Cy65OUeE2LA3WOcgamu4=
X-Received: by 2002:a7b:cb58:0:b0:39e:f121:f7d4 with SMTP id
 v24-20020a7bcb58000000b0039ef121f7d4mr3161742wmj.174.1655516522408; Fri, 17
 Jun 2022 18:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220618000907.433350-1-irogers@google.com> <d3b39b1c-7d2e-0acd-fa92-8e05a3bad1fb@linux.intel.com>
In-Reply-To: <d3b39b1c-7d2e-0acd-fa92-8e05a3bad1fb@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Jun 2022 18:41:50 -0700
Message-ID: <CAP-5=fUVWsVz2WguxDgiAEqG=eVAmJ+qkKDndDcfancsd8V2+A@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 5:23 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi Ian,
>
> On 6/18/2022 8:09 AM, Ian Rogers wrote:
> > New architectures bring new complexity, such as Intel's hybrid
> > models. jevents provides an alternative to specifying events in the
> > kernel and exposing them through sysfs, however, it is difficult to
> > work with. For example, an error in the json input would yield an
> > error message but no json file or location. It is also a challenge to
> > update jsmn.c given its forked nature.
> >
> > The changes here switch from jevents.c to a rewrite in python called
> > jevents.py. This means there is a build time dependency on python, but
> > such a dependency already exists for asciidoc (used to generate perf's
> > man pages). If the build detects that python isn't present or is older
> > than version 3.6 (released Dec. 2016) then an empty file is
> > substituted for the generated one.
> >
> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
> >
> > v6. Fixes an annotation and use of removesuffix that aren't present in
> >      Python 3.6. Linter issues are also fixed.The code was tested on
> >      Python 3.6 and 3.8 with docker.
>
> I just test it, now it can be built successfully with python 3.8.

Great! Tested-by/Reviewed-by/Acked-by always welcome :-)

Ian

> > v5. Adds a 2>/dev/null as suggested by David Laight
> >      <David.Laight@aculab.com>.
> > v4. Fixes the build for systems with python2 installed by adding a
> >      patch that makes python3 the preferred python (Reported-by: John
> >      Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
> >      jevents-test.sh and fixes the handling of an empty string for a
> >      metric BriefDescription as one was added for sapphirerapids in the
> >      metric Execute.
> > v3. Updates the patches for merged changes (on
> >      acme/tmp.perf/core). Re-runs all comparisons to make sure the
> >      generated pmu-events.c isn't altered at all by this change. Adds
> >      the jevents.c ExtSel fix in:
> >      https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
> >      Bumps the python version from 3.5 to 3.6, as f-strings weren't
> >      introduced until 3.6.
> >
> > v2. Fixes the build for architectures that don't have pmu-events json
> >      (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
> >      build for python not being present or too old (Suggested-by: Peter
> >      Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> >
> > Ian Rogers (4):
> >    perf python: Prefer python3
> >    perf jevents: Add python converter script
> >    perf jevents: Switch build to use jevents.py
> >    perf jevents: Remove jevents.c
> >
> >   tools/perf/Makefile.config               |   27 +-
> >   tools/perf/Makefile.perf                 |   16 +-
> >   tools/perf/pmu-events/Build              |   15 +-
> >   tools/perf/pmu-events/empty-pmu-events.c |   21 +
> >   tools/perf/pmu-events/jevents.c          | 1342 ----------------------
> >   tools/perf/pmu-events/jevents.py         |  409 +++++++
> >   tools/perf/pmu-events/jsmn.h             |   68 --
> >   tools/perf/pmu-events/json.c             |  162 ---
> >   tools/perf/pmu-events/json.h             |   39 -
> >   9 files changed, 465 insertions(+), 1634 deletions(-)
> >   create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
> >   delete mode 100644 tools/perf/pmu-events/jevents.c
> >   create mode 100755 tools/perf/pmu-events/jevents.py
> >   delete mode 100644 tools/perf/pmu-events/jsmn.h
> >   delete mode 100644 tools/perf/pmu-events/json.c
> >   delete mode 100644 tools/perf/pmu-events/json.h
> >
>
> --
> Zhengjun Xing
