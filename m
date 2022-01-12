Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A448C3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbiALMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 07:25:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4404 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbiALMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 07:24:54 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JYms641BNz67wql;
        Wed, 12 Jan 2022 20:22:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 13:24:50 +0100
Received: from [10.47.88.157] (10.47.88.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 12 Jan
 2022 12:24:50 +0000
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>
References: <20210917184240.2181186-1-irogers@google.com>
 <YU4iVcVc6uYAWft4@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <158a1451-9d69-d67d-3fad-9e947112f9e6@huawei.com>
Date:   Wed, 12 Jan 2022 12:24:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YU4iVcVc6uYAWft4@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.157]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2021 20:09, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 17, 2021 at 11:42:39AM -0700, Ian Rogers escreveu:
>> Test every metric and metricgroup with 'true' as a workload. For
>> metrics, check that we see the metric printed or get unsupported. If the
>> 'true' workload executes too quickly retry with 'perf bench internals
>> synthesize'.
>>
>> v3. Fix test condition (thanks to Paul A. Clarke<pc@us.ibm.com>). Add a
>>      fallback case of a larger workload so that we don't ignore "<not
>>      counted>".
>> v2. Switched the workload to something faster.

Hi Ian,

I just noticed that this test fails on my broadwell machine.

I am using acme perf/core @ 09dd3c22daaf

metricgroup Memory_Bw fails, and it seems because of the "true" argument 
to "perf stat" (or any argument, like sleep 1):

john@localhost:~/kernel-dev9/tools/perf> sudo ./perf stat -M Memory_BW
^C
  Performance counter stats for 'system wide':

              2,184      arb/event=0x84,umask=0x1/ #     0.26 
DRAM_BW_Use
          2,954,938      arb/event=0x81,umask=0x1/ 

        736,368,852 ns   duration_time 

         58,202,980      l1d_pend_miss.pending_cycles #     2.34 MLP 
                  (80.11%)
        136,293,194      l1d_pend_miss.pending 
               (19.89%)
        736,368,852 ns   duration_time 

          1,065,656      longest_lat_cache.miss    #     0.09 
L3_Cache_Fill_BW         (39.71%)
        736,368,852 ns   duration_time 

          5,365,477      l2_lines_in.all           #     0.47 
L2_Cache_Fill_BW         (59.80%)
        736,368,852 ns   duration_time 

          3,557,362      l1d.replacement           #     0.31 
L1D_Cache_Fill_BW        (79.90%)
        736,368,852 ns   duration_time 


        0.736368852 seconds time elapsed


john@localhost:~/kernel-dev9/tools/perf> sudo ./perf stat -M Memory_BW true
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) 
for event (arb/event=0x84,umask=0x1/).
/bin/dmesg | grep -i perf may provide additional information.

john@localhost:~/kernel-dev9/tools/perf>

Anyone any idea on this before I start digging?

Thanks,
John
