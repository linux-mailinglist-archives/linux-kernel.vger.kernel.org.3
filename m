Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4B49B421
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350586AbiAYMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:39:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4509 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383416AbiAYMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:35:06 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjmRz52k3z687Zg;
        Tue, 25 Jan 2022 20:31:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 13:34:52 +0100
Received: from [10.47.95.36] (10.47.95.36) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 12:34:51 +0000
Subject: Re: [PATCHv3 0/4] perf tools: Add support for user defined metric
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "irogers@google.com" <irogers@google.com>
References: <20200511205307.3107775-1-jolsa@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2e2da73a-7085-b488-4764-705adbff70cc@huawei.com>
Date:   Tue, 25 Jan 2022 12:34:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200511205307.3107775-1-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.36]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2020 21:53, Jiri Olsa wrote:

+

Hi jirka,

Did you a plan to continue to work? I don't think that this support was 
ever merged.

We have a requirement to be able to tune parameters of metrics, and 
support here seems suitable.

Thanks,
John

> hi,
> Joe asked for possibility to add user defined metrics. Given that
> we already have metrics support, I added --metrics-file option that
> allows to specify custom metrics.
> 
>    $ cat metrics
>    # IPC
>    mine1 = instructions / cycles;
>    /* DECODED_ICACHE_UOPS% */
>    mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));
> 
>    $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
>    #           time       insn per cycle                mine1                mine2
>         1.000536263                0.71                   0.7                 41.4
>         2.002069025                0.31                   0.3                 14.1
>         3.003427684                0.27                   0.3                 14.8
>         4.004807132                0.25                   0.2                 12.1
>    ...
> 
> v3 changes:
>    - added doc for metrics file in perf stat man page
>    - reporting error line number now
>    - changed '#' style comment to C way with '//'
> 
> v2 changes:
>    - add new --metrics-file option
>    - rebased on current perf/core expression bison/flex enhancements
> 
> Also available in:
>    git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>    perf/metric
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (4):
>        perf expr: Add parsing support for multiple expressions
>        perf expr: Allow comments in custom metric file
>        perf stat: Add --metrics-file option
>        perf expr: Report line number with error
> 
>   tools/perf/Documentation/perf-stat.txt | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tools/perf/builtin-stat.c              |  7 +++++--
>   tools/perf/tests/expr.c                | 18 ++++++++++++++++++
>   tools/perf/util/expr.c                 |  6 ++++++
>   tools/perf/util/expr.h                 | 21 +++++++++++++++++++--
>   tools/perf/util/expr.l                 | 34 ++++++++++++++++++++++++++++++++++
>   tools/perf/util/expr.y                 | 21 +++++++++++++++++----
>   tools/perf/util/metricgroup.c          | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>   tools/perf/util/metricgroup.h          |  3 ++-
>   tools/perf/util/stat.h                 |  1 +
>   10 files changed, 242 insertions(+), 16 deletions(-)
> 
> .
> 

