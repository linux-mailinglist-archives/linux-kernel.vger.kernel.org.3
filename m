Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075A8583E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbiG1Lzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiG1Lzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:55:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0E39B9B;
        Thu, 28 Jul 2022 04:55:45 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ltpts2kMvzlVw5;
        Thu, 28 Jul 2022 19:53:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:55:43 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:55:42 +0800
Subject: Re: [RFC v3 06/17] perf kwork: Implement perf kwork report
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, "Paul Clarke" <pc@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <20220709015033.38326-7-yangjihong1@huawei.com>
 <CAM9d7chkZzYmuuo3XZ4NdpAErv-5ermDBtOQ+ZaO30t=KuTNQg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <d27ab7d1-bb9c-6086-1ea1-345ec82adeea@huawei.com>
Date:   Thu, 28 Jul 2022 19:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7chkZzYmuuo3XZ4NdpAErv-5ermDBtOQ+ZaO30t=KuTNQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Namhyung ,

On 2022/7/28 8:00, Namhyung Kim wrote:
> On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Implements framework of perf kwork report, which is used to report time
>> properties such as run time and frequency:
>>
>> Test cases:
>>
>>    # perf kwork
>>
>>     Usage: perf kwork [<options>] {record|report}
>>
>>        -D, --dump-raw-trace  dump raw trace in ASCII
>>        -f, --force           don't complain, do it
>>        -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue, etc)
>>        -v, --verbose         be more verbose (show symbol address, etc)
>>
>>    # perf kwork report -h
>>
>>     Usage: perf kwork report [<options>]
>>
>>        -C, --cpu <cpu>       list of cpus to profile
>>        -i, --input <file>    input file name
>>        -n, --name <name>     event name to profile
>>        -s, --sort <key[,key2...]>
>>                              sort by key(s): runtime, max, count
>>        -S, --with-summary    Show summary with statistics
>>            --time <str>      Time span for analysis (start,stop)
>>
>>    # perf kwork report
>>
>>      Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
>>     --------------------------------------------------------------------------------------------------------------------------------
>>     --------------------------------------------------------------------------------------------------------------------------------
>>
>>    # perf kwork report -S
>>
>>      Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
>>     --------------------------------------------------------------------------------------------------------------------------------
>>     --------------------------------------------------------------------------------------------------------------------------------
>>      Total count            :         0
>>      Total runtime   (msec) :     0.000 (0.000% load average)
>>      Total time span (msec) :     0.000
>>     --------------------------------------------------------------------------------------------------------------------------------
>>
>>    # perf kwork report -C 0,100
>>    Requested CPU 100 too large. Consider raising MAX_NR_CPUS
>>    Invalid cpu bitmap
>>
>>    # perf kwork report -s runtime1
>>      Error: Unknown --sort key: `runtime1'
>>
>>     Usage: perf kwork report [<options>]
>>
>>        -C, --cpu <cpu>       list of cpus to profile
>>        -i, --input <file>    input file name
>>        -n, --name <name>     event name to profile
>>        -s, --sort <key[,key2...]>
>>                              sort by key(s): runtime, max, count
>>        -S, --with-summary    Show summary with statistics
>>            --time <str>      Time span for analysis (start,stop)
>>
>>    # perf kwork report -i perf_no_exist.data
>>    failed to open perf_no_exist.data: No such file or directory
>>
>>    # perf kwork report --time 00FFF,
>>    Invalid time span
>>
>> Since there are no report supported events, the output is empty.
>>
>> Briefly describe the data structure:
>> 1. "class" indicates event type. For example, irq and softiq correspond
>> to different types.
>> 2. "cluster" refers to a specific event corresponding to a type. For
>> example, RCU and TIMER in softirq correspond to different clusters,
>> which contains three types of events: raise, entry, and exit.
> 
> Maybe I'm too late... but it's now "work", right?
> 
Yes, The code has been changed to "work" according to previous 
suggestion, but commit message forgets to modify ...

>> 3. "atom" includes time of each sample and sample of the previous phase.
>> (For example, exit corresponds to entry, which is used for timehist.)
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/Documentation/perf-kwork.txt |  33 +
>>   tools/perf/builtin-kwork.c              | 859 +++++++++++++++++++++++-
>>   tools/perf/util/kwork.h                 | 161 +++++
>>   3 files changed, 1051 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
>> index c5b52f61da99..b79b2c0d047e 100644
>> --- a/tools/perf/Documentation/perf-kwork.txt
>> +++ b/tools/perf/Documentation/perf-kwork.txt
>> @@ -17,8 +17,11 @@ There are several variants of 'perf kwork':
>>     'perf kwork record <command>' to record the kernel work
>>     of an arbitrary workload.
>>
>> +  'perf kwork report' to report the per kwork runtime.
>> +
>>       Example usage:
>>           perf kwork record -- sleep 1
>> +        perf kwork report
>>
>>   OPTIONS
>>   -------
>> @@ -38,6 +41,36 @@ OPTIONS
>>   --verbose::
>>          Be more verbose. (show symbol address, etc)
>>
>> +OPTIONS for 'perf kwork report'
>> +----------------------------
>> +
>> +-C::
>> +--cpu::
>> +       Only show events for the given CPU(s) (comma separated list).
>> +
>> +-i::
>> +--input::
>> +       Input file name. (default: perf.data unless stdin is a fifo)
>> +
>> +-n::
>> +--name::
>> +       Only show events for the given name.
>> +
>> +-s::
>> +--sort::
>> +       Sort by key(s): runtime, max, count
>> +
>> +-S::
>> +--with-summary::
>> +       Show summary with statistics
>> +
>> +--time::
>> +       Only analyze samples within given time window: <start>,<stop>. Times
>> +       have the format seconds.microseconds. If start is not given (i.e., time
>> +       string is ',x.y') then analysis starts at the beginning of the file. If
>> +       stop time is not given (i.e, time string is 'x.y,') then analysis goes
>> +       to end of file.
>> +
>>   SEE ALSO
>>   --------
>>   linkperf:perf-record[1]
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index 8086236b7513..9c488d647995 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -25,6 +25,460 @@
>>   #include <linux/time64.h>
>>   #include <linux/zalloc.h>
>>
>> +/*
>> + * report header elements width
>> + */
>> +#define PRINT_CPU_WIDTH 4
>> +#define PRINT_COUNT_WIDTH 9
>> +#define PRINT_RUNTIME_WIDTH 10
>> +#define PRINT_TIMESTAMP_WIDTH 17
>> +#define PRINT_KWORK_NAME_WIDTH 30
>> +#define RPINT_DECIMAL_WIDTH 3
>> +#define PRINT_TIME_UNIT_SEC_WIDTH 2
>> +#define PRINT_TIME_UNIT_MESC_WIDTH 3
> 
> MSEC ?
> 
Yes, I'll fix in next patch,thanks for your review.

Regards,
Jihong
.
