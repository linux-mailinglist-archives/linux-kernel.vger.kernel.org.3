Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13615AC88E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiIEBdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIEBds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:33:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED411EED1;
        Sun,  4 Sep 2022 18:33:47 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MLWG112H2zrS7H;
        Mon,  5 Sep 2022 09:31:53 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 09:33:44 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 09:33:44 +0800
Subject: Re: [PATCH RESEND v4] perf/core: Fix reentry problem in
 perf_output_read_group
To:     Steven Rostedt <rostedt@goodmis.org>
References: <0ed8a3fe-f2f3-ed47-413a-b53b6fd9ac8f@huawei.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <5aec1311-6fa9-b7f9-bbef-e58a6ab6eb73@huawei.com>
Date:   Mon, 5 Sep 2022 09:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <0ed8a3fe-f2f3-ed47-413a-b53b6fd9ac8f@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/9/5 9:25, Yang Jihong wrote:
> On Fri, Sep 02, 2022 at 04:29:18PM +0800, Yang Jihong wrote:
>  > perf_output_read_group may respond to IPI request of other cores and
>  > invoke __perf_install_in_context function. As a result, hwc 
> configuration is modified.
>  > causing inconsistency and unexpected consequences.
>  >
>  > Interrupts are not disabled when perf_output_read_group reads PMU 
> counter.
>  > In this case, IPI request may be received from other cores.
>  > As a result, PMU configuration is modified and an error occurs when
>  > reading PMU counter:
>  >
>  >                    CPU0                                         CPU1
>  > __se_sys_perf_event_open
>  > perf_install_in_context
>  > perf_output_read_group smp_call_function_single
>  >   for_each_sibling_event(sub, leader) { generic_exec_single
>  >     if ((sub != event) && remote_function
>  >         (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
>  > <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
>  > __perf_install_in_context
>  >   ctx_resched
>  >     event_sched_out
>  >       armpmu_del
>  >         ...
>  >         hwc->idx = -1; // event->hwc.idx is set to -1 ...
>  > <exit IPI>
>  >             sub->pmu->read(sub);
>  >               armpmu_read
>  >                 armv8pmu_read_counter
>  >                   armv8pmu_read_hw_counter
>  >                     int idx = event->hw.idx; // idx = -1
>  >                     u64 val = armv8pmu_read_evcntr(idx);
>  >                       u32 counter = ARMV8_IDX_TO_COUNTER(idx); // 
> invalid counter = 30
>  >                       read_pmevcntrn(counter) // undefined instruction
>  >
>  > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>  > ---
> 
> Right; thanks for reminding me. I had hoped you'd pick up and test the 
> extra assertion some, but I'll just do that on top.
> .
OK, if you want me to do assertion testing on any scenarios,
please send me the patch.

Thanks,
Yang
