Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEF472334
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhLMIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:48:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4249 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhLMIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:48:16 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JCFVf68Smz67tWy;
        Mon, 13 Dec 2021 16:46:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 09:48:14 +0100
Received: from [10.47.80.231] (10.47.80.231) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 13 Dec
 2021 08:48:13 +0000
Subject: Re: [PATCH v2] perf util: Fix use after free in metric__new
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>, <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211212115818.267011-1-jose.exposito89@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <690406fd-306c-9786-bacc-fd27e2e531fb@huawei.com>
Date:   Mon, 13 Dec 2021 08:47:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211212115818.267011-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.80.231]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 11:58, José Expósito wrote:
> Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)
> Addresses-Coverity-ID: 1494000
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> 
> ---
> 
> v2: Add Fixes and Acked-by tags
> ---
>   tools/perf/util/metricgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index fffe02aae3ed..4d2fed3aefd1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_event *pe,
>   	m->metric_name = pe->metric_name;
>   	m->modifier = modifier ? strdup(modifier) : NULL;
>   	if (modifier && !m->modifier) {
> -		free(m);
>   		expr__ctx_free(m->pctx);
> +		free(m);
>   		return NULL;
>   	}
>   	m->metric_expr = pe->metric_expr;
> 

