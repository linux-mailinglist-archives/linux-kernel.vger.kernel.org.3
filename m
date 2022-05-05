Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFC51C830
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383983AbiEESqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383122AbiEESqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:46:37 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E2E1084
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:35:17 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id m203so2503005vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 11:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JufbdLt+SWfkYpTCJFhIgk7esk5wdurajt/xNIS8xPY=;
        b=Qu2w4rFzXy/2R1G5811MRpp76vihYyyBHhn0BmMDGdCm4ddX1nnKpSKuXxelwrYetI
         p0NEa+GDbKeznpP+OtMD8I4dYD+AzVv9CpXny+htAdSFqEwCQCYRXH9MEW0FXxvCsHF8
         mn43RtA3ObRe3RSSXKk1pKOX/qyrJBoS3kNBwUztpIU8mkq3NBO31vyaLqfb8wXpl8Ig
         txRrylOYynvYtRCM5nDFK6Iw3h5YcbfjZdfflCQkUQakbURAcEtSOA5+bZMdq8KZ6VVy
         7SZZx0McNjZ0tvNSkDhBPRfy6WMULQqh4Zv40BGHYphuiJ8ZJVYrpbwv0mP/ws13iHd5
         eeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JufbdLt+SWfkYpTCJFhIgk7esk5wdurajt/xNIS8xPY=;
        b=E3GKOQAyIkEMmFtCEAa2+s+/kSdzBkfl1jyxXr2D9TV8DAU9dwm6DmdKPAwmxbXYaq
         YtWdiEoqwZuzB4AEzGfVvwY8RIgYLAVwrmdVTPs9IyMdxnZ60VvUT3eZQuCIh4lfQzmt
         vP+wtI0ZoBjSnY5WpbTQBRL2MxnJ7XTctkXmO2Fh/nD/l+Mnp0FnRPUvFenRfSZUTq07
         je6ofYj1P6SCPLr5/Vj2mNbv+E1VRbYo21V7mqSnBcAdpD9UQk+w66sZuiqoVkipTSbk
         D1ijpLEdRGv727pW0uiqFpz38/nr99CRBlI3S3wjYsG6cKzx7I7kI/4gSMM/8xetyp8B
         AvdA==
X-Gm-Message-State: AOAM530dorh1E2vA2OFek5dUabW4PBZPquwmfWNX0YbGPfiG0tntcJ24
        p6NdQa2rIihqtNxMETYueEzuIoknerfQ/B/aKKQGfA==
X-Google-Smtp-Source: ABdhPJypVe9Pe0paMzSMAvDCyrSNjXlEgOxD3XeX+Ux7c5JlavGbQh16rbe7I4ef5S2MwY0NzzxsoqxgVrD4LCstJT0=
X-Received: by 2002:a05:6122:1810:b0:34e:8f1c:749d with SMTP id
 ay16-20020a056122181000b0034e8f1c749dmr8271054vkb.20.1651775716626; Thu, 05
 May 2022 11:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <20220505043846.3165303-2-irogers@google.com>
 <cb6065af-7e3f-53fa-5d82-67be04ca833f@linux.intel.com> <CAP-5=fV6Sj3PMjVBYtCRZUXXrwOJC9ETffQYscvcgJZ7gm2tFw@mail.gmail.com>
 <e11e873c-6e61-5d50-ba6a-a99045e486bc@linux.intel.com>
In-Reply-To: <e11e873c-6e61-5d50-ba6a-a99045e486bc@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 11:35:03 -0700
Message-ID: <CAP-5=fUGDkVS6zYUkeYWHMrgkX50Fao0iSKs95Yvyts+wUxpxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add basic stat and topdown group test
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 5, 2022 at 11:19 AM Liang, Kan <kan.liang@linux.intel.com> wrot=
e:
>
> On 5/5/2022 11:22 AM, Ian Rogers wrote:
> > On Thu, May 5, 2022 at 5:12 AM Liang, Kan <kan.liang@linux.intel.com> w=
rote:
> >>
> >> On 5/5/2022 12:38 AM, Ian Rogers wrote:
> >>> Add a basic stat test.
> >>> Add two tests of grouping behavior for topdown events. Topdown events
> >>> are special as they must be grouped with the slots event first.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>    tools/perf/tests/shell/stat.sh | 65 ++++++++++++++++++++++++++++++=
++++
> >>>    1 file changed, 65 insertions(+)
> >>>    create mode 100755 tools/perf/tests/shell/stat.sh
> >>>
> >>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/=
stat.sh
> >>> new file mode 100755
> >>> index 000000000000..80869ea6debc
> >>> --- /dev/null
> >>> +++ b/tools/perf/tests/shell/stat.sh
> >>> @@ -0,0 +1,65 @@
> >>> +#!/bin/sh
> >>> +# perf stat tests
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +set -e
> >>> +
> >>> +err=3D0
> >>> +test_default_stat() {
> >>> +  echo "Basic stat command test"
> >>> +  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for=
 'true':"
> >>> +  then
> >>> +    echo "Basic stat command test [Failed]"
> >>> +    err=3D1
> >>> +    return
> >>> +  fi
> >>> +  echo "Basic stat command test [Success]"
> >>> +}
> >>> +
> >>> +test_topdown_groups() {
> >>> +  # Topdown events must be grouped with the slots event first. Test =
that
> >>> +  # parse-events reorders this.
> >>> +  echo "Topdown event group test"
> >>> +  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
> >>> +  then
> >>> +    echo "Topdown event group test [Skipped event parsing failed]"
> >>> +    return
> >>> +  fi
> >>> +  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<=
not supported>"
> >>> +  then
> >>> +    echo "Topdown event group test [Failed events not supported]"
> >>> +    err=3D1
> >>> +    return
> >>> +  fi
> >>> +  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<=
not supported>"
> >>> +  then
> >>> +    echo "Topdown event group test [Failed slots not reordered first=
]"
> >>> +    err=3D1
> >>> +    return
> >>> +  fi
> >>> +  echo "Topdown event group test [Success]"
> >>> +}
> >>> +
> >>> +test_topdown_weak_groups() {
> >>> +  # Weak groups break if the perf_event_open of multiple grouped eve=
nts
> >>> +  # fails. Breaking a topdown group causes the events to fail. Test =
a very large
> >>> +  # grouping to see that the topdown events aren't broken out.
> >>> +  echo "Topdown weak groups test"
> >>> +  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdow=
n-fe-bound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,c=
ache-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,r=
ef-cycles,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
> >>> +  then
> >>> +    echo "Topdown weak groups test [Skipped event parsing failed]"
> >>> +    return
> >>> +  fi
> >>> +  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-=
fe-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cach=
e-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-=
cycles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not sup=
ported>"
> >>> +  then
> >>> +    echo "Topdown weak groups test [Failed events not supported]"
> >>> +    err=3D1
> >>> +    return
> >>> +  fi
> >>> +  echo "Topdown weak groups test [Success]"
> >>> +}
> >>> +
> >>
> >> Should we check the existence of the slots event before the test?
> >> The perf metrics feature only be available on the new platform after
> >> ICL. It doesn't work on Atom.
> >>
> >> Also, I think the test may fails on the hybrid platform, since big cor=
e
> >> and small core have different formula for the topdown. I think we shou=
ld
> >> avoid the test for the hybrid platform for now.
> >> +Zhengjun, who is fixing the topdown gap for the hybrid platform. I
> >> think he may take care of the hybrid support later.
> >
> > Thanks Kan, the test filters out systems that don't support the events
> > and silently skips the test. The main purpose of the test is to make
> > sure the somewhat complicated grouping operations for Icelake have
> > some coverage. Adding more coverage for hybrid would be great, but not
> > something I think gates this change.
> >
>
> Sure, we can add the coverage for hybrid later. But please make sure the
> test can filter out both the systems which doesn't support perf metircs
> and the hybrid system.
>
> Thanks,
> Kan

If the test fails on hybrid then that feels like value add :-) We
genuinely have broken grouping functions. We could just add to the
test a skip if /sys/devices/cpu_core and /sys/devices/cpu_atom
directories exist (making assumptions on where sysfs is mounted). I'm
not yet able to test on Alderlake hence not wanting to have a lot of
untested code.

Thanks,
Ian

> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>> +test_default_stat
> >>> +test_topdown_groups
> >>> +test_topdown_weak_groups
> >>> +exit $err
