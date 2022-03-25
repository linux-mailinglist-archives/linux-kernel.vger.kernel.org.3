Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E464E6C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiCYBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356161AbiCYBks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:40:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D565517DF;
        Thu, 24 Mar 2022 18:39:02 -0700 (PDT)
Received: from kwepemi500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KPl7R4CLTzCrYt;
        Fri, 25 Mar 2022 09:36:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500021.china.huawei.com (7.221.188.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 09:39:00 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 09:38:59 +0800
Subject: Re: [PATCH] perf/x86: Unify format of events sysfs show
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220324031957.135595-1-yangjihong1@huawei.com>
 <20220324101107.GC8939@worktop.programming.kicks-ass.net>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <a4a0758f-b183-8244-d59c-10d31d8e0a3a@huawei.com>
Date:   Fri, 25 Mar 2022 09:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220324101107.GC8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2022/3/24 18:11, Peter Zijlstra wrote:
> On Thu, Mar 24, 2022 at 11:19:57AM +0800, Yang Jihong wrote:
>> Sysfs show formats of files in /sys/devices/cpu/events/ are not unified,
>> some end with "\n", and some do not. Modify sysfs show format of events
>> defined by EVENT_ATTR_STR to end with "\n".
> 
> Did you test all the userspace that consumes these fields to make sure
> none of them break? I suppose it's mostly perf tool, but I'm fairly sure
> there's others out there as well.
> 
Yes, I tested "perf record" and "perf stat" commands on my machine 
against the modified events, and the results are as follows:

$ perf stat -e 
topdown-fetch-bubbles,topdown-recovery-bubbles,topdown-slots-issued,topdown-slots-retired,topdown-total-slots 
-a sleep 1

  Performance counter stats for 'system wide':

            2356235      topdown-fetch-bubbles     #   1211.9% frontend 
bound
             226132      topdown-recovery-bubbles  #    182.9% bad 
speculation
            1073595      topdown-slots-issued      #  -1780.4% backend bound
             944133      topdown-slots-retired     #    485.6% retiring
             194420      topdown-total-slots

        0.987394388 seconds time elapsed


$ perf record -e 
topdown-fetch-bubbles,topdown-recovery-bubbles,topdown-slots-issued,topdown-slots-retired,topdown-total-slots 
-a sleep 1
Lowering default frequency rate from 4000 to 3000.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
Couldn't synthesize bpf events.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.300 MB perf.data (2620 samples) ]

$ perf evlist
topdown-fetch-bubbles
topdown-recovery-bubbles
topdown-slots-issued
topdown-slots-retired
topdown-total-slots
dummy:HG

.


Thanks,
Jihong
> .
> 
