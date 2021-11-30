Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7D463998
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbhK3PRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:17:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37602 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbhK3PJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:09:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE1CACE1A33;
        Tue, 30 Nov 2021 15:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40D3C53FC1;
        Tue, 30 Nov 2021 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638284761;
        bh=cQ2ta2KnJavaEcUz/4BnQNed6TgZ/ORE1gdu1CXK3lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6Nbny/4yuC58//4VOL+glWfpP0BKPShYfl931RkoOiZ5d6dDiij3imC2+1/zqxkb
         Hr0yfGWxuXUzkVU7CD6AaY9gh8w2dlALzyBvLyfRH2x9Ktq+Qx3Xx869K04qAtXEu7
         9z5Wv+Yo7tjFNfSmgOK8mxH/hjnfQqNsdBs0ZNdGt61Hgv6HHy4H2seVsgvBhJB0T4
         KjPpfsm94lLXfOnY2JenLXFnY71QmNn3ZjqZsBUgzS5r6v4p+ozhx9dP7tM43/N3nZ
         67YLPQrKjEXHFibTLU0C1ZZAiTBzv+7BdbzxnSuyHxRlToFoAzIf/1sPgnghODQBs+
         CAyNCXtDSxaBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 037EE40002; Tue, 30 Nov 2021 12:05:57 -0300 (-03)
Date:   Tue, 30 Nov 2021 12:05:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Subject: Re: [PATCH v2 2/2] perf parse-events: Architecture specific leader
 override
Message-ID: <YaY91Ytf3x4DGgJ+@kernel.org>
References: <20211118220647.2355999-1-irogers@google.com>
 <20211118220647.2355999-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118220647.2355999-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 18, 2021 at 02:06:47PM -0800, Ian Rogers escreveu:
> Currently topdown events must appear after a slots event:
> 
> $ perf stat -e '{slots,topdown-fe-bound}' /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>          3,183,090      slots
>            986,133      topdown-fe-bound
> 
> Reversing the events yields:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-fe-bound).
> 
> For metrics the order of events is determined by iterating over a
> hashmap, and so slots isn't guaranteed to be first which can yield this
> error.
> 
> Change the set_leader in parse-events, called when a group is closed, so
> that rather than always making the first event the leader, if the slots
> event exists then it is made the leader. It is then moved to the head of
> the evlist otherwise it won't be opened in the correct order.
> 
> The result is:
> 
> $ perf stat -e '{topdown-fe-bound,slots}' /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>          3,274,795      slots
>          1,001,702      topdown-fe-bound
> 
> A problem with this approach is the slots event is identified by name,
> names can be overwritten like 'cpu/slots,name=foo/' and this causes the
> leader change to fail.
> 
> The change also modifies and fixes mixed groups like, with the change:
> 
> $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>         5574985410      slots
>          971981616      instructions
>         1348461887      topdown-fe-bound
> 
>        2.001263120 seconds time elapsed
> 
> Without the change:
> 
> $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a -- sleep 2
> 
>  Performance counter stats for 'system wide':
> 
>      <not counted>      instructions
>      <not counted>      slots
>    <not supported>      topdown-fe-bound
> 
>        2.006247990 seconds time elapsed
> 
> Something that may be undesirable here is that the events are reordered
> in the output.
> 
> v2. Move the list_move operation into parse_events__set_leader as
>     suggested by Jiri Olsa <jolsa@redhat.com>.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 17 +++++++++++++++++
>  tools/perf/util/evlist.h          |  1 +
>  tools/perf/util/parse-events.c    |  8 +++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 0b0951030a2f..1624372b2da2 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -17,3 +17,20 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
>  	else
>  		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
>  }
> +
> +struct evsel *arch_evlist__leader(struct list_head *list)
> +{
> +	struct evsel *evsel, *first;
> +
> +	first = list_entry(list->next, struct evsel, core.node);

Can we make this:

	struct *evsel, *first = list_first_entry(list, struct evsel, core.node);

?

> +
> +	if (!pmu_have_event("cpu", "slots"))
> +		return first;
> +
> +	__evlist__for_each_entry(list, evsel) {
> +		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
> +			evsel->name && strstr(evsel->name, "slots"))
> +			return evsel;
> +	}
> +	return first;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 97bfb8d0be4f..993437ffe429 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -110,6 +110,7 @@ int __evlist__add_default_attrs(struct evlist *evlist,
>  	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>  
>  int arch_evlist__add_default_attrs(struct evlist *evlist);
> +struct evsel *arch_evlist__leader(struct list_head *list);
>  
>  int evlist__add_dummy(struct evlist *evlist);
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 6308ba739d19..774c163eae9c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1821,6 +1821,11 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>  	return ret;
>  }
>  
> +__weak struct evsel *arch_evlist__leader(struct list_head *list)
> +{
> +	return list_entry(list->next, struct evsel, core.node);
> +}
> +
>  void parse_events__set_leader(char *name, struct list_head *list,
>  			      struct parse_events_state *parse_state)
>  {
> @@ -1834,9 +1839,10 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>  		return;
>  
> -	leader = list_entry(list->next, struct evsel, core.node);
> +	leader = arch_evlist__leader(list);
>  	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
> +	list_move(&leader->core.node, list);
>  }
>  
>  /* list_event is assumed to point to malloc'ed memory */
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

-- 

- Arnaldo
