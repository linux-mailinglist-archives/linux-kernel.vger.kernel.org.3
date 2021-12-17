Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98DF47889E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhLQKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:20:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4302 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhLQKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:20:02 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JFlKh4mnQz6896L;
        Fri, 17 Dec 2021 18:17:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 11:19:59 +0100
Received: from [10.47.26.158] (10.47.26.158) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 17 Dec
 2021 10:19:58 +0000
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
Date:   Fri, 17 Dec 2021 10:19:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211214184240.24215-2-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.158]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2021 18:42, Andrew Kilroy wrote:
> This patch implements the --topdown option by making use of metrics to
> dictate what counters are obtained in order to show the various topdown
> columns, e.g.  Frontend Bound, Backend Bound, Retiring and Bad
> Speculation.
> 
> The MetricGroup name is used to identify which set of metrics are to be
> shown.  For the moment use TopDownL1 and enable for arm64
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>

This works in that it gives results, but does not supply the same output 
format as for x86 nor has same restrictions in usage (-a commandline 
required, for example, below).

For my x86 broadwell:

john@localhost:~/linux/tools/perf> sudo ./perf stat --topdown  sleep 1
top down event configuration requires system-wide mode (-a)

john@localhost:~/linux/tools/perf> sudo ./perf stat --topdown -a sleep 1
Performance counter stats for 'system wide':

                                    retiring      bad speculation 
frontend bound        backend bound
S0-D0-C0           2                29.2%                 6.3% 
      37.4%                27.1%
S0-D0-C1           2                20.4%                 6.2% 
      42.1%                31.3%

       0.998007338 seconds time elapsed

john@localhost:~/linux/tools/perf>

---

Then my arm64 hip08 platform:

john@debian:~/kernel-dev/tools/perf$ sudo ./perf stat  --topdown sleep 1

  Performance counter stats for 'sleep 1':

             retiring      bad_speculation        backend_bound 
frontend_bound
                 0.19                 0.17                 0.27 
        0.37

        1.000832714 seconds time elapsed

        0.000891000 seconds user
        0.000000000 seconds sys

And there is no colouring for results which are above/below standard 
thresholds (see stat-shadow.c:get_radio_color()).

My impression is that we're not plugging the results from 
metricgroup__parse_groups_to_evlist() into the --topdown print 
functionality properly.

Thanks,
John
