Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D248F929
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiAOUHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:07:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42064 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiAOUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:07:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB62BB80B22;
        Sat, 15 Jan 2022 20:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF0C36AE7;
        Sat, 15 Jan 2022 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642277258;
        bh=9eB2RbmltV02P15qASAJG5h7XFKhpTtPFKJhPLs5SqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZquKnK2G9J45YyrOAoO2CMvllV39jB7BmKDD4Ar2bocj4UGS06haAFqhqvlAVbun
         0impTEGqa9tYZXe9r4rQrWG+Jfdtq8qVe3p+m4sgmjJVBfLFx4X5o1f91e/cJaOBHW
         OOwGCpAIw58WTJ/G/0y5tNL3hlNA9kLnLvdV3GJkQkSFtL6j2Oytqg8L0/gA+bCCSv
         CgLDUyvr/Wbxc2NkYNjUs4/1yl7DpOo4e89G3gSM36JxNiseFWAEZKUE7OjxS37kXg
         AN+dSxyqZjT1keYRWEDjZuAVH5GO1twJmrhK1xdQlJ12u0njbsn6bsFymtDjh3jv8c
         cmWrMXpp3XqWw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42B7940714; Sat, 15 Jan 2022 17:07:35 -0300 (-03)
Date:   Sat, 15 Jan 2022 17:07:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH] perf metric: Fix metric_leader
Message-ID: <YeMph54WM/vHi7fU@kernel.org>
References: <20220115062852.1959424-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115062852.1959424-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 14, 2022 at 10:28:52PM -0800, Ian Rogers escreveu:
> Multiple events may have a metric_leader to aggregate into. This happens
> for uncore events where, for example, uncore_imc is expanded into
> uncore_imc_0, uncore_imc_1, etc. Such events all have the same metric_id
> and should aggregate into the first event. The change introducing
> metric_ids had a bug where the metric_id was compared to itself,
> creating an always true condition. Correct this by comparing the
> event in the metric_evlist and the metric_leader.

Thanks, applied.

- Arnaldo

 
> Fixes: ec5c5b3d2c21 ("perf metric: Encode and use metric-id as qualifier")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 51c99cb08abf..1f1b78b0388f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -314,7 +314,7 @@ static int setup_metric_events(struct hashmap *ids,
>  		 */
>  		metric_id = evsel__metric_id(ev);
>  		evlist__for_each_entry_continue(metric_evlist, ev) {
> -			if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
> +			if (!strcmp(evsel__metric_id(ev), metric_id))
>  				ev->metric_leader = metric_events[i];
>  		}
>  	}
> -- 
> 2.34.1.703.g22d0c6ccf7-goog

-- 

- Arnaldo
