Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED73491003
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiAQSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:04:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4424 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiAQSEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:04:37 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jd07W2FqNz681RY;
        Tue, 18 Jan 2022 02:00:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Mon, 17 Jan 2022 19:04:30 +0100
Received: from [10.47.92.236] (10.47.92.236) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 17 Jan
 2022 18:04:30 +0000
Subject: Re: [PATCH] perf metric: Fix metric_leader
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <eranian@google.com>
References: <20220115062852.1959424-1-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <660a0c4f-cecd-df97-3fea-3d75d45fa02b@huawei.com>
Date:   Mon, 17 Jan 2022 18:04:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220115062852.1959424-1-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.236]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2022 06:28, Ian Rogers wrote:
> Multiple events may have a metric_leader to aggregate into. This happens
> for uncore events where, for example, uncore_imc is expanded into
> uncore_imc_0, uncore_imc_1, etc. Such events all have the same metric_id
> and should aggregate into the first event. The change introducing
> metric_ids had a bug where the metric_id was compared to itself,
> creating an always true condition. Correct this by comparing the
> event in the metric_evlist and the metric_leader.
> 
> Fixes: ec5c5b3d2c21 ("perf metric: Encode and use metric-id as qualifier")
> Signed-off-by: Ian Rogers<irogers@google.com>
> ---

Looks ok and I quickly tested it:
Reviewed-by: John Garry <john.garry@huawei.com>
