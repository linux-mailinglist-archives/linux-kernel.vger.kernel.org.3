Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF00583E06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiG1LtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiG1LtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:49:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CA691ED;
        Thu, 28 Jul 2022 04:48:57 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ltpkc2pKQzjXVh;
        Thu, 28 Jul 2022 19:46:00 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:48:55 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 19:48:54 +0800
Subject: Re: [RFC v3 01/17] perf kwork: New tool
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
 <20220709015033.38326-2-yangjihong1@huawei.com>
 <CAM9d7cjRPSsoAk22xTO=BFQTVn+HmMZkcm7grNehHkbtRWwhgw@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <289300c6-f822-03de-9a6b-f2352421097b@huawei.com>
Date:   Thu, 28 Jul 2022 19:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cjRPSsoAk22xTO=BFQTVn+HmMZkcm7grNehHkbtRWwhgw@mail.gmail.com>
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

On 2022/7/28 7:33, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jul 8, 2022 at 6:53 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> The perf-kwork tool is used to trace time properties of kernel work
>> (such as irq, softirq, and workqueue), including runtime, latency,
>> and timehist, using the infrastructure in the perf tools to allow
>> tracing extra targets.
>>
>> This is the first commit to reuse perf_record framework code to
>> implement a simple record function, kwork is not supported currently.
>>
>> Test cases:
>>
>>    # perf
>>
>>     usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
>>
>>     The most commonly used perf commands are:
>>    <SNIP>
>>       iostat          Show I/O performance metrics
>>       kallsyms        Searches running kernel for symbols
>>       kmem            Tool to trace/measure kernel memory properties
>>       kvm             Tool to trace/measure kvm guest os
>>       kwork           Tool to trace/measure kernel work properties (latencies)
>>       list            List all symbolic event types
>>       lock            Analyze lock events
>>       mem             Profile memory accesses
>>       record          Run a command and record its profile into perf.data
>>    <SNIP>
>>     See 'perf help COMMAND' for more information on a specific command.
>>
>>    # perf kwork
>>
>>     Usage: perf kwork [<options>] {record}
>>
>>        -D, --dump-raw-trace  dump raw trace in ASCII
>>        -f, --force           don't complain, do it
>>        -k, --kwork <kwork>   list of kwork to profile
>>        -v, --verbose         be more verbose (show symbol address, etc)
>>
>>    # perf kwork record -- sleep 1
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Captured and wrote 1.787 MB perf.data ]
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
> [SNIP]
>> +
>> +static int perf_kwork__record(struct perf_kwork *kwork,
>> +                             int argc, const char **argv)
>> +{
>> +       const char **rec_argv;
>> +       unsigned int rec_argc, i, j;
>> +       struct kwork_class *class;
>> +
>> +       const char *const record_args[] = {
>> +               "record",
>> +               "-a",
>> +               "-R",
>> +               "-m", "1024",
>> +               "-c", "1",
> 
> Please consider adding '--synth task' to skip costly synthesis
> if you don't need user space symbols.
> 
Yes, we don't need user space symbols now, I'll add this option in next 
fix patch,thanks for your suggestion.

Regards,
Jihong
> .
> 
