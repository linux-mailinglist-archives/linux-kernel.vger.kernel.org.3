Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740CF463E96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhK3T16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:27:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40338 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhK3T15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0437B81BEF;
        Tue, 30 Nov 2021 19:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7489FC53FC7;
        Tue, 30 Nov 2021 19:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638300275;
        bh=RDjAjTT2Axoh9tpgNPzL6dph+lg0w6WidvQZF5Tmhls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LG6Q21+UW6ZutW7RQfv4P5i7HpUWwouxw+qtmcXrsGH4FYWSjNKbyjdSXvaLi2lub
         jDan2Uhh9tl1G1GNLGIyUfR70XfQvZT09RkrhckEm9OVWfTNrcAy0tJGM/LkBPPa2N
         Q5gbhdTeOYEG4+Gm2J3yZOZGlyIYXBkyW3UevcLxQFrIXIlvMszPyXBAWMqr+TnBZk
         EKy/r8z2akPohLVKKjXDT2xIltIlUUUSjAJtF8XtGXOi6WV1eV4x9DhopJ+1IwMz3x
         Wo3Zs27mjTvBDk5h9LpXyojzBTWe3A5pBuwE3pMSAfrOGfUd0UcCVmXpna1zLx5vey
         FEwrK8EkBzXYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76E3E40002; Tue, 30 Nov 2021 16:24:33 -0300 (-03)
Date:   Tue, 30 Nov 2021 16:24:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
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
Subject: Re: [PATCH v2] perf metric: Reduce multiplexing with duration_time
Message-ID: <YaZ6cVidgo1e4h0g@kernel.org>
References: <20211124015226.3317994-1-irogers@google.com>
 <YaOs+DjuoQvuqIrC@krava>
 <CAP-5=fXBRa7+ugLAWjuOkwr3vqWtaby86e8zovUvkX2wmYV4ag@mail.gmail.com>
 <YaZpWOi26cLgYnPz@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZpWOi26cLgYnPz@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 30, 2021 at 07:11:36PM +0100, Jiri Olsa escreveu:
> On Mon, Nov 29, 2021 at 09:46:31AM -0800, Ian Rogers wrote:
> > On Sun, Nov 28, 2021 at 8:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Nov 23, 2021 at 05:52:26PM -0800, Ian Rogers wrote:
> > > > It is common to use the same counters with and without
> > > > duration_time. The ID sharing code treats duration_time as if it
> > > > were a hardware event placed in the same group. This causes
> > > > unnecessary multiplexing such as in the following example where
> > > > l3_cache_access isn't shared:
> > > >
> > > > $ perf stat -M l3 -a sleep 1
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >          3,117,007      l3_cache_miss             #    199.5 MB/s  l3_rd_bw
> > > >                                                   #     43.6 %  l3_hits
> > > >                                                   #     56.4 %  l3_miss               (50.00%)
> > > >          5,526,447      l3_cache_access                                               (50.00%)
> > > >          5,392,435      l3_cache_access           # 5389191.2 access/s  l3_access_rate  (50.00%)
> > > >      1,000,601,901 ns   duration_time
> > > >
> > > >        1.000601901 seconds time elapsed
> > > >
> > > > Fix this by placing duration_time in all groups unless metric
> > > > sharing has been disabled on the command line:
> > > >
> > > > $ perf stat -M l3 -a sleep 1
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >          3,597,972      l3_cache_miss             #    230.3 MB/s  l3_rd_bw
> > > >                                                   #     48.0 %  l3_hits
> > > >                                                   #     52.0 %  l3_miss
> > > >          6,914,459      l3_cache_access           # 6909935.9 access/s  l3_access_rate
> > > >      1,000,654,579 ns   duration_time
> > > >
> > > >        1.000654579 seconds time elapsed
> > > >
> > > > $ perf stat --metric-no-merge -M l3 -a sleep 1
> > > >
> > > >  Performance counter stats for 'system wide':
> > > >
> > > >          3,501,834      l3_cache_miss             #     53.5 %  l3_miss               (24.99%)
> > > >          6,548,173      l3_cache_access                                               (24.99%)
> > > >          3,417,622      l3_cache_miss             #     45.7 %  l3_hits               (25.04%)
> > > >          6,294,062      l3_cache_access                                               (25.04%)
> > > >          5,923,238      l3_cache_access           # 5919688.1 access/s  l3_access_rate  (24.99%)
> > > >      1,000,599,683 ns   duration_time
> > > >          3,607,486      l3_cache_miss             #    230.9 MB/s  l3_rd_bw           (49.97%)
> > > >
> > > >        1.000599683 seconds time elapsed
> > > >
> > > > v2. Doesn't count duration_time in the metric_list_cmp function that
> > > >     sorts larger metrics first. Without this a metric with duration_time
> > > >     and an event is sorted the same as a metric with two events,
> > > >     possibly not allowing the first metric to share with the second.
> > >
> > > hum, isn't the change about adding duration_time in every metric?
> > > or you could still end up with metric without duration_time
> > 
> > It is about adding duration_time to all metrics. Sorting of the
> > metrics by number of IDs happens before we insert duration_time which
> > happens just prior to parsing. duration_time needn't be inserted if
> > --metric-no-merge is passed.
> 
> I see, so that sorting takes place before it's added, makes sense then
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

