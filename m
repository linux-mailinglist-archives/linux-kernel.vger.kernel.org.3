Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1C54BF53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiFOBjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiFOBjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:39:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148C02FFDE;
        Tue, 14 Jun 2022 18:38:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LN7D60ZGXzRjXd;
        Wed, 15 Jun 2022 09:35:34 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:38:51 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:38:50 +0800
Subject: Re: [RFC 01/13] perf kwork: New tool
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
 <20220613094605.208401-2-yangjihong1@huawei.com>
 <CAM9d7ch-VL6siA7g79pN1OSgus4X2C0D2tptAt5u04KUqxOUTg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <f7ce4fd3-9631-015a-8b1f-81f704e82719@huawei.com>
Date:   Wed, 15 Jun 2022 09:38:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7ch-VL6siA7g79pN1OSgus4X2C0D2tptAt5u04KUqxOUTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Namhyung

On 2022/6/15 5:43, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> The perf-kwork tool is used to trace time properties of kernel work
>> (such as irq, softirq, and workqueue), including runtime, latency,
>> and timehist, using the infrastructure in the perf tools to allow
>> tracing extra targets:
>>
>>    # perf kwork -h
>>
>>     Usage: perf kwork [<options>] {record|report|latency|timehist}
>>
>>        -D, --dump-raw-trace  dump raw trace in ASCII
>>        -f, --force           don't complain, do it
>>        -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue etc)
>>        -v, --verbose         be more verbose (show symbol address, etc)
>>
>>    # perf kwork record -- sleep 1
>>    [ perf record: Woken up 0 times to write data ]
>>    [ perf record: Captured and wrote 1.696 MB perf.data ]
>>
>>    # perf kwork report -h
>>
>>     Usage: perf kwork report [<options>]
>>
>>        -C, --cpu <cpu>       list of cpus to profile
>>        -i, --input <file>    input file name
>>        -n, --name <name>     event name to profile
>>        -s, --sort <key[,key2...]>
>>                              sort by key(s): runtime, max, freq
>>        -S, --with-summary    Show summary with statistics
>>            --time <str>      Time span for analysis (start,stop)
>>
>>    # perf kwork latency -h
>>
>>     Usage: perf kwork latency [<options>]
>>
>>        -C, --cpu <cpu>       list of cpus to profile
>>        -i, --input <file>    input file name
>>        -n, --name <name>     event name to profile
>>        -s, --sort <key[,key2...]>
>>                              sort by key(s): avg, max, freq
>>            --time <str>      Time span for analysis (start,stop)
>>
>>    # perf kwork timehist -h
>>
>>     Usage: perf kwork timehist [<options>]
>>
>>        -C, --cpu <cpu>       list of cpus to profile
>>        -g, --call-graph      Display call chains if present
>>        -i, --input <file>    input file name
>>        -k, --vmlinux <file>  vmlinux pathname
>>        -n, --name <name>     event name to profile
>>            --kallsyms <file>
>>                              kallsyms pathname
>>            --max-stack <n>   Maximum number of functions to display backtrace.
>>            --symfs <directory>
>>                              Look for files with symbols relative to this directory
>>            --time <str>      Time span for analysis (start,stop)
> 
> I think you can add this and the documentation when you
> actually add the functionality later.
> 
OK, I'll fix in next version.


Thanks，
Jihong
.
