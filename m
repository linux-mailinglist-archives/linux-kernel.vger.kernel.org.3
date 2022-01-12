Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D26148CA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343965AbiALRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:45:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355904AbiALRpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:45:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB9161923;
        Wed, 12 Jan 2022 17:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19120C36AEA;
        Wed, 12 Jan 2022 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642009509;
        bh=x9hEP+2tT9P+EVZeVkf/TCyxC2sORkhR0Mg0yn52QUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhVyE6yaY5M98cQi/+xugcjPe1VQkiaSmA20sy3KYY08jRWMRox0/3YFdPC7XHkJ1
         mC865em+hOGIDOK3j1iuEnBrIQK7YTwHCZx3zRgQyBSSC8LGqXQrEx52wSdxNimcrE
         0xhP9ccYKCyjUSMX2R71PSxusrPKre6L4M5Q/mhZjlNzngHBYo0vp3qtB/OrjIphhQ
         H0SkTp0K+nbEoMM+BhUARYO4+6RVjBcmKYIxh3Yba5/beRq81CwSQfnO8LmAqScIRi
         qbJv191NWR+Ry4SNLHVnaTnnfiVUG8c0AGtDaV9J6cofVTBdYN2OnRRpOn37ep9Bfb
         2uBHR6tG0Di7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14C6740714; Wed, 12 Jan 2022 14:45:07 -0300 (-03)
Date:   Wed, 12 Jan 2022 14:45:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [RFC PATCH] perf pmu-events: Don't lower case MetricExpr
Message-ID: <Yd8To1ASO73135LK@kernel.org>
References: <20211126071305.3733878-1-irogers@google.com>
 <CAP-5=fU2kEq3T8UCpX0tAmwcGhZ+1h92uRPbzyuLDNpeCD7ffQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU2kEq3T8UCpX0tAmwcGhZ+1h92uRPbzyuLDNpeCD7ffQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 09:22:51AM -0800, Ian Rogers escreveu:
> On Thu, Nov 25, 2021 at 11:13 PM Ian Rogers <irogers@google.com> wrote:
> >
> > This patch changes MetricExpr to be written out in the same case. This
> > enables events in metrics to use modifiers like 'G' which currently
> > yield parse errors when made lower case. To keep tests passing the
> > literal #smt_on is compared in a non-case sensitive way - #SMT_on is
> > present in at least SkylakeX metrics.
> 
> Ping.

I tried applying 20211124001231.3277836-1-irogers@google.com on top of
your perf_cpu series, it failed, will check.

BTW, I got the two other patches in that series:

⬢[acme@toolbox perf]$ git log --oneline -2
6dd8646939a770e4 (HEAD -> perf/core) perf tools: Probe non-deprecated sysfs path 1st
0ce05781f4905fcf perf tools: Fix SMT fallback with large core counts
⬢[acme@toolbox perf]$

- Arnaldo
 
> Thanks,
> Ian
> 
> > This patch is on top of:
> > https://lore.kernel.org/lkml/20211124001231.3277836-1-irogers@google.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/jevents.c | 2 --
> >  tools/perf/util/expr.c          | 2 +-
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index 2e7c4153875b..1a57c3f81dd4 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -672,8 +672,6 @@ static int json_events(const char *fn,
> >                                 addfield(map, &je.metric_constraint, "", "", val);
> >                         } else if (json_streq(map, field, "MetricExpr")) {
> >                                 addfield(map, &je.metric_expr, "", "", val);
> > -                               for (s = je.metric_expr; *s; s++)
> > -                                       *s = tolower(*s);
> >                         } else if (json_streq(map, field, "ArchStdEvent")) {
> >                                 addfield(map, &arch_std, "", "", val);
> >                                 for (s = arch_std; *s; s++)
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index cdbab4f959fe..5cd6b9ff2489 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -397,7 +397,7 @@ double expr__get_literal(const char *literal)
> >         static struct cpu_topology *topology;
> >         double result = NAN;
> >
> > -       if (!strcmp("#smt_on", literal)) {
> > +       if (!strcasecmp("#smt_on", literal)) {
> >                 result =  smt_on() > 0 ? 1.0 : 0.0;
> >                 goto out;
> >         }
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >

-- 

- Arnaldo
