Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE675265E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381873AbiEMPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381853AbiEMPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:19:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69E67D3B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:19:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so7131024wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvr9XHdx0qxVi7/a69y2j5WI3jpk5pCGizGaQ78gnbw=;
        b=cXAdYjghbJB5VyDatvmZoHYYnDnaq49xRZFmRneNHVhMdWj2qOXJ1vyMyPn6YsDl6f
         QL2ObYAUbDPzwmzk+loqUOaBSoz0fu1xFp24wWBNQeuC4gB8faHQpmXdFi1SCDklvbHO
         qyD7LuoU2d0mM06yiMH4VMsnosL64M4hayJfjgY3V9RKS/wKlVT5fljAhvTdsZYCASp1
         85U8AIiflnUsnnVGzd2RHvd+2UkfP9t+o+bZuFBn2Ty/lpHq69IF+Z8Jd60dmYQCwSlI
         5+D11n48Jh3d6UyJGAJFgvx1TXjGBp42x8tD1WNUl8gsv7nbbHbFHAtF7Sk5/yxjTO3g
         6SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvr9XHdx0qxVi7/a69y2j5WI3jpk5pCGizGaQ78gnbw=;
        b=Lf00U5UwzgxG2fRODKxWm+DyhfVvetgU9pOh3G+/0w2exLWjy3BSyQ0AlF2sqvHOKC
         etgb+tY8bokP8faM+YORtEm5Hmk0V9Qy2A1BcaXcQncJGtVwW1lPKaQZ0RlUTB+CeR/j
         ek49zApDvIDlkbzDm+ZD1nlRLZMl6FdIaY7zYZ/OYKxMaUkSHQFIPbvLfumrHnLpelBu
         FETDH+9xiWwFBLP8F+Tgu8glRXRTPEZEObpkL6/5PR2zGkw3BQ48oYrsSS9NehhnjODo
         BS8eirJP5rNcRRk+vtkukxmJIMhTYd6SzJxRJdstYZbbl1dMfNq8qkBGwwzdXrh0Mej/
         cbGg==
X-Gm-Message-State: AOAM531wpun2CPxH9bx/+r4XZd84NwYZC8zhbK3NAtofCcSAHaHjro+y
        6dpo6fm1vffDgvYiGdqAR62Y83B9MW4yRO/BUeXEIA==
X-Google-Smtp-Source: ABdhPJzPkrGoy4a/xoVw8mWXDb0nSGCHP4Ckc0NEY1vte+swInqwionk6DZRJZGCJvzDy95WRyC597CPmsjvhpAdJU0=
X-Received: by 2002:a05:600c:19cc:b0:394:8dc2:a23b with SMTP id
 u12-20020a05600c19cc00b003948dc2a23bmr15471129wmq.182.1652455152508; Fri, 13
 May 2022 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220512061308.1152233-1-irogers@google.com> <8ba20985-8116-c7f7-a082-ec30152d9adb@linux.intel.com>
In-Reply-To: <8ba20985-8116-c7f7-a082-ec30152d9adb@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 08:18:59 -0700
Message-ID: <CAP-5=fXS2r245frPSdzjkQUPMQK_Yrm5+g_cfKQRFiAkoi7Ocg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix topdown event weak grouping
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
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

On Fri, May 13, 2022 at 7:25 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
> On 5/12/2022 2:13 AM, Ian Rogers wrote:
> > Keep topdown events within a group when a weak group is broken. This
> > is a requirement as topdown events must form a group.
> >
> > Add perf stat testing including for required topdown event group
> > behaviors.
> >
> > Note: as with existing topdown evsel/evlist code topdown events are
> > assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
> > also be tested. Future changes can fix Alderlake.
>
> I will send a follow-up patch to fix the weak grouping for the hybrid
> platform shortly.
>
> For the non-hybrid platform, the patch set looks good to me.

Thanks. I was looking into things like perf_pmu__for_each_hybrid_pmu:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu-hybrid.h?h=perf/core#n13

The issue is that we only really care about "cpu_core" and "cpu" for
topdown events, so using a loop isn't clearly beneficial as it'll
include "cpu_atom". Also, the hybrid parsing code only works for
Intel:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu-hybrid.c?h=perf/core#n28
so I have a hard time seeing this kind of code as making things more generic.

What we really want in this case is some way of iterating over PMUs
for CPU like things (note the property is CPU like, not hybrid). There
is an unfortunate naming for ARM where this property got called core:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmu.c?h=perf/core#n679

The PMUs iterated are architecture specific and should probably be set
up via a function on a weak symbol - the default to just use "cpu".
Unfortunately Intel uses a cpus file in sysfs to indicate hybrid and
that is set up differently on ARM.

So with all that said my hybrid support code is to change:

if (pmu_have_event("cpu", "slots"))

to:

if (pmu_have_event("cpu", "slots")) || pmu_have_event("cpu_core", "slots"))

Longer term I think we need to rethink hybrid. I'm not sure hybrid is
the correct term, we want all hard coded "cpu" to be a set of things
like "cpu", "cpu_core", "cpu_atom" or the appropriate PMU on ARM. As I
said in:
https://lore.kernel.org/lkml/CAP-5=fWRRZsyJZ-gky-FOFz79zW_3r78d_0APpj5sf66HqTpLw@mail.gmail.com/
I think the sane way to do this is to turn all "event sources" into a
sysfs like file system and to have clear discovery rules. The problem
right now is to clean up and transition to that, while maintaining
existing code working. Let me know if there's a better way to have
this conversation. My own work pushing in that direction is currently
gated by these changes landing:
https://lore.kernel.org/lkml/20220511211526.1021908-1-irogers@google.com/

Thanks,
Ian



> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan
>
> >
> > v2. Correct behavior wrt pmu prefixed events and avoid the test using
> >      deprecated events: Suggested-by: Liang, Kan <kan.liang@linux.intel.com>
> >
> > Ian Rogers (2):
> >    perf evlist: Keep topdown counters in weak group
> >    perf test: Add basic stat and topdown group test
> >
> >   tools/perf/arch/x86/util/evsel.c | 12 ++++++
> >   tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
> >   tools/perf/util/evlist.c         | 16 +++++++-
> >   tools/perf/util/evsel.c          | 10 +++++
> >   tools/perf/util/evsel.h          |  3 ++
> >   5 files changed, 106 insertions(+), 2 deletions(-)
> >   create mode 100755 tools/perf/tests/shell/stat.sh
> >
