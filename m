Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67D4A5A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiBAKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:39:05 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4589 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiBAKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:39:04 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp1Wh0vNsz67fYK;
        Tue,  1 Feb 2022 18:34:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:39:01 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 10:38:59 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 01/26] perf test: Allow skip for all metrics test
To:     Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220201015858.1226914-1-irogers@google.com>
 <20220201015858.1226914-2-irogers@google.com>
Message-ID: <566a72ee-b46f-4ee2-93dd-9a12723f969f@huawei.com>
Date:   Tue, 1 Feb 2022 10:39:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220201015858.1226914-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2022 01:58, Ian Rogers wrote:

nit: the subject is a bit ambiguous, as it implies skipping all the 
tests, when we just may skip some now

> Some Intel TMA metrics compute a ratio that may divide by 0, which
> causes the metric not to print. This happens for metrics with FP_ARITH
> events. If we see these events in the result and would otherwise fail,
> then switch to a skip.
> Also, don't early exit when processing metrics.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   tools/perf/tests/shell/stat_all_metrics.sh | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> index 7f4ba3cad632..e7c59e5a7a98 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -4,6 +4,7 @@
>   
>   set -e
>   
> +err=0
>   for m in $(perf list --raw-dump metrics); do
>     echo "Testing $m"
>     result=$(perf stat -M "$m" true 2>&1)
> @@ -14,9 +15,14 @@ for m in $(perf list --raw-dump metrics); do
>       if [[ ! "$result" =~ "$m" ]]; then
>         echo "Metric '$m' not printed in:"
>         echo "$result"
> -      exit 1
> +      if [[ "$result" =~ "FP_ARITH" && "$err" != "1" ]]; then
> +        echo "Skip, not fail, for FP issues"
> +        err=2
> +      else
> +        err=1
> +      fi
>       fi
>     fi
>   done
>   
> -exit 0
> +exit "$err"
> 

