Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAB463E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbhK3TbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:31:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56508 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbhK3TbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:31:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 435A5CE1AF9;
        Tue, 30 Nov 2021 19:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46616C53FC7;
        Tue, 30 Nov 2021 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638300468;
        bh=fmLnsRS4NhKdrk0FPk2Q9BN104x1W3jRCg9prAY+Ufw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLGHgv0mlF8I6KwVcbiWTyFI06p08MHY7VLqOKkolbaDicAnEHkcPzrvYGM18VSBe
         9CSVVK0zMu3ehW2RwSZwoqGR9f8tiflkf6evYLK+/BQA5BieLE93sY+DhXlLnk2L94
         aRVM9AVyoDG4ZkamFRjm/shiwj3rLkzUy61o5U5e4K33RgVnCcsqSxMR++WP0gPoV6
         UYjnufJnbQfylqOLVHO97iiIXhU9G60PSz/BLmCPA640L7qyUQAfcUKZTsKADpHUr4
         HryYcKl2O+2SVvOeqtmR8tvxvTEc29aNz3RRel6SI4vKVD6Gb3QNWRhHPuCd7rCOT+
         8mEnTLYlwJKmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF08B40002; Tue, 30 Nov 2021 16:27:45 -0300 (-03)
Date:   Tue, 30 Nov 2021 16:27:45 -0300
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
Subject: Re: [PATCH v3 1/2] perf evlist: Allow setting arbitrary leader
Message-ID: <YaZ7MUK7Ie4mHvTg@kernel.org>
References: <20211130174945.247604-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130174945.247604-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 30, 2021 at 09:49:44AM -0800, Ian Rogers escreveu:
> The leader of a group is the first, but allow it to be an arbitrary
> list member so that for Intel topdown events slots may always be the
> group leader.
> 
> v3. Switched list_entry to list_first_entry as suggested by Arnaldo
>     Carvalho de Melo <acme@kernel.org>.

Thanks, applied both patches.

- Arnaldo

 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evlist.c                  | 15 +++++++++------
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/util/parse-events.c           |  4 ++--
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index e37dfad31383..245acbc53bd3 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
>  	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
>  }
>  
> -void __perf_evlist__set_leader(struct list_head *list)
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
>  {
> -	struct perf_evsel *evsel, *leader;
> +	struct perf_evsel *first, *last, *evsel;
>  
> -	leader = list_entry(list->next, struct perf_evsel, node);
> -	evsel = list_entry(list->prev, struct perf_evsel, node);
> +	first = list_first_entry(list, struct perf_evsel, node);
> +	last = list_last_entry(list, struct perf_evsel, node);
>  
> -	leader->nr_members = evsel->idx - leader->idx + 1;
> +	leader->nr_members = last->idx - first->idx + 1;
>  
>  	__perf_evlist__for_each_entry(list, evsel)
>  		evsel->leader = leader;
> @@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
>  void perf_evlist__set_leader(struct perf_evlist *evlist)
>  {
>  	if (evlist->nr_entries) {
> +		struct perf_evsel *first = list_entry(evlist->entries.next,
> +						struct perf_evsel, node);
> +
>  		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
> -		__perf_evlist__set_leader(&evlist->entries);
> +		__perf_evlist__set_leader(&evlist->entries, first);
>  	}
>  }
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index f366dbad6a88..6f74269a3ad4 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  
>  void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
>  
> -void __perf_evlist__set_leader(struct list_head *list);
> +void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 5bfb6f892489..c2935aca4b67 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
>  		return;
>  
> -	__perf_evlist__set_leader(list);
> -	leader = list_entry(list->next, struct evsel, core.node);
> +	leader = list_first_entry(list, struct evsel, core.node);
> +	__perf_evlist__set_leader(list, &leader->core);
>  	leader->group_name = name ? strdup(name) : NULL;
>  }
>  
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog

-- 

- Arnaldo
