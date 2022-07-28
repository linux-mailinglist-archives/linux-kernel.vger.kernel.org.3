Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5295C583E12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiG1LvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiG1Luu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:50:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F7422E9;
        Thu, 28 Jul 2022 04:50:48 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LtplZ2ws8zWf1Q;
        Thu, 28 Jul 2022 19:46:50 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:50:45 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:50:44 +0800
Subject: Re: [RFC v3 02/17] perf kwork: Add irq kwork record support
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
 <20220709015033.38326-3-yangjihong1@huawei.com>
 <CAM9d7civBT2-u0C1rK6OvSLAT7fzXRb8ku4xaHbF3wbUv+m1rw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <a88bb1f9-546a-53c4-9e37-c8dbb4ff5cb6@huawei.com>
Date:   Thu, 28 Jul 2022 19:50:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7civBT2-u0C1rK6OvSLAT7fzXRb8ku4xaHbF3wbUv+m1rw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hello Namhyung,

On 2022/7/28 7:42, Namhyung Kim wrote:
> On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Record interrupt events irq:irq_handler_entry & irq_handler_exit
>>
>> Test cases:
>>
>>   # perf kwork record -o perf_kwork.date -- sleep 1
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Captured and wrote 0.556 MB perf_kwork.date ]
>>    #
>>    # perf evlist -i perf_kwork.date
>>    irq:irq_handler_entry
>>    irq:irq_handler_exit
>>    dummy:HG
>>    # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
>>    #
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>   tools/perf/Documentation/perf-kwork.txt |  2 +-
>>   tools/perf/builtin-kwork.c              | 15 ++++++++++++++-
>>   tools/perf/util/kwork.h                 |  1 +
>>   3 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
>> index dc1e36da57bb..57bd5fa7d5c9 100644
>> --- a/tools/perf/Documentation/perf-kwork.txt
>> +++ b/tools/perf/Documentation/perf-kwork.txt
>> @@ -32,7 +32,7 @@ OPTIONS
>>
>>   -k::
>>   --kwork::
>> -       List of kwork to profile
>> +       List of kwork to profile (irq, etc)
>>
>>   -v::
>>   --verbose::
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index f3552c56ede3..a26b7fde1e38 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -25,7 +25,20 @@
>>   #include <linux/time64.h>
>>   #include <linux/zalloc.h>
>>
>> +const struct evsel_str_handler irq_tp_handlers[] = {
>> +       { "irq:irq_handler_entry", NULL, },
>> +       { "irq:irq_handler_exit",  NULL, },
>> +};
>> +
>> +static struct kwork_class kwork_irq = {
>> +       .name           = "irq",
>> +       .type           = KWORK_CLASS_IRQ,
>> +       .nr_tracepoints = 2,
> 
> Nit: I don't think it's gonna change frequently but
> it'd be better to use ARRAY_SIZE(irq_tp_handlers)
> for future changes.
> 
OK, I'll fix in next patch,thanks for your review.

Regards,
Jihong
