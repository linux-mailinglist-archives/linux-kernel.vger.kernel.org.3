Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D583251C3D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381263AbiEEP0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiEEP0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:26:08 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EEE562E4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:22:29 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id x5so1779924uap.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qPfQvLyUbmHVNZw+TAo0YgVkjOr4uX9NXBiJG8Mn/l8=;
        b=nSfw2fQyJsl7DKOxKW4Xwy1DGfVltFyP9da0IbVvD2QTVqa2245czWi4oGozeeV5qY
         muiUUE2Mk5D90HSE+fDn6+18Tadnbpo8/T1JZJYR+AVL+rNFYDZpOucN/CDQtp8ZdBbA
         zYBIpc6HV4mAijPIpD3Lp+XzeuRJ8PLG/eHB0Dq5vTCYNJaTLJ4NkpSodbziqJ/pt/V7
         oNSrkph6Gy8FioTleMP/T5SCdSZCDArNgB8++d908AQ+NplA90o3txi8RPspfg5N7gQ+
         KDj8tVGWLqkjZqOZDXHF+E6DdL4IYiTAcd8yzwhl3GJir9Ex88PV8p9THc/WNygKqrb4
         tQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qPfQvLyUbmHVNZw+TAo0YgVkjOr4uX9NXBiJG8Mn/l8=;
        b=uC1F0gcArNBhTaYJVj0mqnTGmfWMHlebFXUOsGSJV88bZQLjvjmwgnTdyK/+7ru/P+
         tCOViAVEFtcGQku8lihpcYtENc5OQpaSPWlnfp9qS7qrxd0TAozfeDWQOgHVn9ZxafGy
         LK9qQ3zzfxVPos0Uxn7y34cxdw3KBZ10lPaDQZB7eCH0xH3uPovmSGnN1xeBRok062QR
         X+otX9lCgWbg38YRVrYuKQXwNpic4OXslCZBbbXgksbvXT+xo54ZmjoBRqgMDZZ2oa+z
         ThsM6iV/O0RjuLrX9olSl9RrsntA/+CQqRoadKYL2Brz1a5ZE8efZL2POL1GeYD7gr09
         eT3w==
X-Gm-Message-State: AOAM531HFTowkVQEN33bZDBssoSKE9MKQiKMQkzrDlYpGxvWFmB9z2IW
        oDRjqmr0mUXg2J3HMo3ZPAorlmG0V3SDCDVhixI+uA==
X-Google-Smtp-Source: ABdhPJwbz5sQPxXCrjImAmPsDa2i0PbxuSSm2hbm+OVphjRIsqQavkMTrDIRP76ZbM2Z5EMeVcHLlAVg3qndoBvXNpA=
X-Received: by 2002:a9f:2048:0:b0:352:9b4f:ac98 with SMTP id
 66-20020a9f2048000000b003529b4fac98mr8489353uam.12.1651764148121; Thu, 05 May
 2022 08:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <20220505043846.3165303-2-irogers@google.com>
 <cb6065af-7e3f-53fa-5d82-67be04ca833f@linux.intel.com>
In-Reply-To: <cb6065af-7e3f-53fa-5d82-67be04ca833f@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 08:22:15 -0700
Message-ID: <CAP-5=fV6Sj3PMjVBYtCRZUXXrwOJC9ETffQYscvcgJZ7gm2tFw@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 5:12 AM Liang, Kan <kan.liang@linux.intel.com> wrote=
:
>
> On 5/5/2022 12:38 AM, Ian Rogers wrote:
> > Add a basic stat test.
> > Add two tests of grouping behavior for topdown events. Topdown events
> > are special as they must be grouped with the slots event first.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/tests/shell/stat.sh | 65 +++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 65 insertions(+)
> >   create mode 100755 tools/perf/tests/shell/stat.sh
> >
> > diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/st=
at.sh
> > new file mode 100755
> > index 000000000000..80869ea6debc
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat.sh
> > @@ -0,0 +1,65 @@
> > +#!/bin/sh
> > +# perf stat tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +err=3D0
> > +test_default_stat() {
> > +  echo "Basic stat command test"
> > +  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for '=
true':"
> > +  then
> > +    echo "Basic stat command test [Failed]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Basic stat command test [Success]"
> > +}
> > +
> > +test_topdown_groups() {
> > +  # Topdown events must be grouped with the slots event first. Test th=
at
> > +  # parse-events reorders this.
> > +  echo "Topdown event group test"
> > +  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
> > +  then
> > +    echo "Topdown event group test [Skipped event parsing failed]"
> > +    return
> > +  fi
> > +  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<no=
t supported>"
> > +  then
> > +    echo "Topdown event group test [Failed events not supported]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<no=
t supported>"
> > +  then
> > +    echo "Topdown event group test [Failed slots not reordered first]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Topdown event group test [Success]"
> > +}
> > +
> > +test_topdown_weak_groups() {
> > +  # Weak groups break if the perf_event_open of multiple grouped event=
s
> > +  # fails. Breaking a topdown group causes the events to fail. Test a =
very large
> > +  # grouping to see that the topdown events aren't broken out.
> > +  echo "Topdown weak groups test"
> > +  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-=
fe-bound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cac=
he-misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref=
-cycles,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
> > +  then
> > +    echo "Topdown weak groups test [Skipped event parsing failed]"
> > +    return
> > +  fi
> > +  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe=
-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-=
misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cy=
cles,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not suppo=
rted>"
> > +  then
> > +    echo "Topdown weak groups test [Failed events not supported]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Topdown weak groups test [Success]"
> > +}
> > +
>
> Should we check the existence of the slots event before the test?
> The perf metrics feature only be available on the new platform after
> ICL. It doesn't work on Atom.
>
> Also, I think the test may fails on the hybrid platform, since big core
> and small core have different formula for the topdown. I think we should
> avoid the test for the hybrid platform for now.
> +Zhengjun, who is fixing the topdown gap for the hybrid platform. I
> think he may take care of the hybrid support later.

Thanks Kan, the test filters out systems that don't support the events
and silently skips the test. The main purpose of the test is to make
sure the somewhat complicated grouping operations for Icelake have
some coverage. Adding more coverage for hybrid would be great, but not
something I think gates this change.

Thanks,
Ian

> Thanks,
> Kan
> > +test_default_stat
> > +test_topdown_groups
> > +test_topdown_weak_groups
> > +exit $err
