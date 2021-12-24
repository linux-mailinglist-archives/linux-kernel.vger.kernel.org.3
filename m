Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D776E47ED6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhLXItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:49:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4322 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbhLXItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:49:41 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JL0xV4zSPz67cpv;
        Fri, 24 Dec 2021 16:45:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 09:49:38 +0100
Received: from [10.195.32.200] (10.195.32.200) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 08:49:37 +0000
Subject: Re: [PATCH v3] perf test: Make metric testing more robust.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20211223185622.3435128-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e078ac0f-6165-9670-926f-d1f2c536ea9e@huawei.com>
Date:   Fri, 24 Dec 2021 08:49:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211223185622.3435128-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.32.200]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2021 18:56, Ian Rogers wrote:
> When testing metric expressions we fake counter values from 1 going
> upward. For some metrics this can yield negative values that are clipped
> to zero, and then cause divide by zero failures. Such clipping is
> questionable but may be a result of tools automatically generating
> metrics. A workaround for this case is to try a second time with counter
> values going in the opposite direction.
> 
> This case was seen in a metric like:
>    event1 / max(event2 - event3, 0)
> But it may also happen in more sensible metrics like:
>    event1 / (event2 + event3 - 1 - event4)
> 
> v2. Rebase and more detail in commit message.
> v3. Is a rebase.

Incorrect location for this info

> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index df1c9a3cc05b..b2ddf928d32a 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -962,8 +962,18 @@ static int test__parsing(struct test_suite *test __maybe_unused,
>   			}
>   
>   			if (expr__parse(&result, ctx, pe->metric_expr)) {
> -				expr_failure("Parse failed", map, pe);
> -				ret++;
> +				/*
> +				 * Parsing failed, make numbers go from large to
> +				 * small which can resolve divide by zero

can or may?

> +				 * issues.
> +				 */
> +				k = 1024;
> +				hashmap__for_each_entry(ctx->ids, cur, bkt)
> +					expr__add_id_val(ctx, strdup(cur->key), k--);
> +				if (expr__parse(&result, ctx, pe->metric_expr)) {
> +					expr_failure("Parse failed", map, pe);
> +					ret++;
> +				}
>   			}
>   		}
>   	}
> @@ -1022,10 +1032,20 @@ static int metric_parse_fake(const char *str)
>   		}
>   	}
>   
> -	if (expr__parse(&result, ctx, str))
> -		pr_err("expr__parse failed\n");
> -	else
> -		ret = 0;
> +	ret = 0;
> +	if (expr__parse(&result, ctx, str)) {
> +		/*
> +		 * Parsing failed, make numbers go from large to small which can
> +		 * resolve divide by zero issues.
> +		 */
> +		i = 1024;
> +		hashmap__for_each_entry(ctx->ids, cur, bkt)
> +			expr__add_id_val(ctx, strdup(cur->key), i--);
> +		if (expr__parse(&result, ctx, str)) {
> +			pr_err("expr__parse failed\n");
> +			ret = -1;
> +		}
> +	}
>   
>   out:
>   	expr__ctx_free(ctx);
> 

