Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A848CA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355850AbiALR6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:58:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48362 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbiALR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:58:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EDBC616C1;
        Wed, 12 Jan 2022 17:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC21C36AE5;
        Wed, 12 Jan 2022 17:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010330;
        bh=r9CJAibGsK4OZgWc2GYrncKtUPNzsfsPE8izkKbx9P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6isxRMP7oOqP3lPpESN3Oj6MI72FmEcqzbYL5bov91z9KSf0iLtVuUeb3FyzqNU2
         601Kcl+EssNVGQmY52Ex0UpcN7bCLjLOF1qBqUTALHBM87G1GVBZX2DwW/lctYwqnm
         Rw/tFKJSw1gbS51OsA1c75xthUEx1OfrWYU7VTPgg6Jx0PZr4sWzabiucDx5LwBnFN
         2Fl4NcCsi+1dAu/HmDnkppYBmSW7CK3Lm2X9N1ZzpjcOZye0jgo3gfgSFMtpINj8kK
         a/77fwmYuwyXsQfPMv3z1wqECE6fIez51Irpe6ib7GS2oGzl3/ryj4814fFPe7MZiA
         arg1UlbtywwWw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A90A240714; Wed, 12 Jan 2022 14:58:47 -0300 (-03)
Date:   Wed, 12 Jan 2022 14:58:47 -0300
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
Message-ID: <Yd8W15KBArfhmqTx@kernel.org>
References: <20211126071305.3733878-1-irogers@google.com>
 <CAP-5=fU2kEq3T8UCpX0tAmwcGhZ+1h92uRPbzyuLDNpeCD7ffQ@mail.gmail.com>
 <Yd8To1ASO73135LK@kernel.org>
 <Yd8Vpo/I7LiMyfI6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yd8Vpo/I7LiMyfI6@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 02:53:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 12, 2022 at 02:45:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jan 12, 2022 at 09:22:51AM -0800, Ian Rogers escreveu:
> > > On Thu, Nov 25, 2021 at 11:13 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > This patch changes MetricExpr to be written out in the same case. This
> > > > enables events in metrics to use modifiers like 'G' which currently
> > > > yield parse errors when made lower case. To keep tests passing the
> > > > literal #smt_on is compared in a non-case sensitive way - #SMT_on is
> > > > present in at least SkylakeX metrics.
> > > 
> > > Ping.
> > 
> > I tried applying 20211124001231.3277836-1-irogers@google.com on top of
> > your perf_cpu series, it failed, will check.
> > 
> > BTW, I got the two other patches in that series:
> > 
> > ⬢[acme@toolbox perf]$ git log --oneline -2
> > 6dd8646939a770e4 (HEAD -> perf/core) perf tools: Probe non-deprecated sysfs path 1st
> > 0ce05781f4905fcf perf tools: Fix SMT fallback with large core counts
> > ⬢[acme@toolbox perf]$
> 
> Ok, I have that one now on, but could Andi or somebody else that works
> more frequently with that code provide an Acked-by or Reviewed-by?

Its there since since MetricExpr was introduced:

commit 00636c3b48e8acac2acd2601274c6eab4ecf8201
Author: Andi Kleen <ak@linux.intel.com>
Date:   Mon Mar 20 13:17:07 2017 -0700

    perf pmu: Support MetricExpr header in JSON event list

    Add support for parsing the MetricExpr header in the JSON event lists
    and storing them in the alias structure.

    Used in the next patch.

    v2: Change DividedBy to MetricExpr
    v3: Really catch all uses of DividedBy

    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Link: http://lkml.kernel.org/r/20170320201711.14142-10-andi@firstfloor.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>o

-----------------------------

There is no explanation as to why it should be lowercased, and Ian's
reason not to lowercase it is valid, not to lose information, so I'll
apply the patch, please holler if there is some other subtlety I'm
missing...

- Arnaldo

> > > > This patch is on top of:
> > > > https://lore.kernel.org/lkml/20211124001231.3277836-1-irogers@google.com/
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/pmu-events/jevents.c | 2 --
> > > >  tools/perf/util/expr.c          | 2 +-
> > > >  2 files changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > > index 2e7c4153875b..1a57c3f81dd4 100644
> > > > --- a/tools/perf/pmu-events/jevents.c
> > > > +++ b/tools/perf/pmu-events/jevents.c
> > > > @@ -672,8 +672,6 @@ static int json_events(const char *fn,
> > > >                                 addfield(map, &je.metric_constraint, "", "", val);
> > > >                         } else if (json_streq(map, field, "MetricExpr")) {
> > > >                                 addfield(map, &je.metric_expr, "", "", val);
> > > > -                               for (s = je.metric_expr; *s; s++)
> > > > -                                       *s = tolower(*s);
> > > >                         } else if (json_streq(map, field, "ArchStdEvent")) {
> > > >                                 addfield(map, &arch_std, "", "", val);
> > > >                                 for (s = arch_std; *s; s++)
> > > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > > index cdbab4f959fe..5cd6b9ff2489 100644
> > > > --- a/tools/perf/util/expr.c
> > > > +++ b/tools/perf/util/expr.c
> > > > @@ -397,7 +397,7 @@ double expr__get_literal(const char *literal)
> > > >         static struct cpu_topology *topology;
> > > >         double result = NAN;
> > > >
> > > > -       if (!strcmp("#smt_on", literal)) {
> > > > +       if (!strcasecmp("#smt_on", literal)) {
> > > >                 result =  smt_on() > 0 ? 1.0 : 0.0;
> > > >                 goto out;
> > > >         }
> > > > --
> > > > 2.34.0.rc2.393.gf8c9666880-goog
> > > >
> > 
> > -- 
> > 
> > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
