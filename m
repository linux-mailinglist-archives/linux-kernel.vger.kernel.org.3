Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EB550B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiFSOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiFSOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:24:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78EADF0E;
        Sun, 19 Jun 2022 07:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63EE6B80D2E;
        Sun, 19 Jun 2022 14:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FE8C34114;
        Sun, 19 Jun 2022 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655648684;
        bh=lglb5lq3IdzlIW/sY6jHocKiCWTiCv4pt/JLOGVrB9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VXkiY0i4IutbbBWhuCRfv4ytN6VFem4MHeNx9VCXwtexb+6Mo0DtrYi+5tLPh0PEV
         /5zvlEam6LQ2bIVDa+TwaIWP0b7xuB6wdTNcNMxEgoNBRBdnnccOVUQp6ZsZR8VbUh
         hs81ZhF2ZBSOTki1xW8f1QG+hx83BDNuqIyW6hrPxMGzOa9bQAm3N+JIAjhJjJVS6f
         FpKlS6mO2J9iei087B+QUi2YaYB8JOm+48u85sXKTDJ8DkNF+KHlSolJnXgaYCCmYf
         EwCxnUY/kyz4PhtcIeNLUJUzrFy1YxyHyp4m0lrnSJEWs2D7/dK6oMkqI6VsrFIXd7
         oC+fM92dnWZpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 590294096F; Sun, 19 Jun 2022 11:24:41 -0300 (-03)
Date:   Sun, 19 Jun 2022 11:24:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf metrics: Ensure at least 1 id per metric
Message-ID: <Yq8xqdUnAv428foN@kernel.org>
References: <20220618013957.999321-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618013957.999321-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 17, 2022 at 06:39:57PM -0700, Ian Rogers escreveu:
> We may have no events for a metric evaluated to a constant. In such a
> case ensure a tool event is at least evaluated for metric parsing and
> displaying.

Thanks, applied.

- Arnaldo

 
> Fixes: 8586d2744ff3 ("perf metrics: Don't add all tool events for sharing")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ee8fcfa115e5..8f7baeabc5cf 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1372,6 +1372,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
>  
>  	*out_evlist = NULL;
>  	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
> +		bool added_event = false;
>  		int i;
>  		/*
>  		 * We may fail to share events between metrics because a tool
> @@ -1393,8 +1394,16 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
>  				if (!tmp)
>  					return -ENOMEM;
>  				ids__insert(ids->ids, tmp);
> +				added_event = true;
>  			}
>  		}
> +		if (!added_event && hashmap__size(ids->ids) == 0) {
> +			char *tmp = strdup("duration_time");
> +
> +			if (!tmp)
> +				return -ENOMEM;
> +			ids__insert(ids->ids, tmp);
> +		}
>  	}
>  	ret = metricgroup__build_event_string(&events, ids, modifier,
>  					      has_constraint);
> -- 
> 2.37.0.rc0.104.g0611611a94-goog

-- 

- Arnaldo
