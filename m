Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAEB597B71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiHRCYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiHRCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:24:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25D6CF5B;
        Wed, 17 Aug 2022 19:23:59 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7TDd0WW9zGpdW;
        Thu, 18 Aug 2022 10:22:25 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:23:58 +0800
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 10:23:57 +0800
Subject: Re: [PATCH v3] perf/core: Fix reentry problem in
 perf_output_read_group
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220816091103.257702-1-yangjihong1@huawei.com>
 <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <42e62907-2895-1267-8942-fcad544dca35@huawei.com>
Date:   Thu, 18 Aug 2022 10:23:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YvumDL1qz1NjpfEC@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/8/16 22:13, Peter Zijlstra wrote:
> On Tue, Aug 16, 2022 at 05:11:03PM +0800, Yang Jihong wrote:
>> perf_output_read_group may respond to IPI request of other cores and invoke
>> __perf_install_in_context function. As a result, hwc configuration is modified.
>> As a result, the hwc configuration is modified, causing inconsistency and
>> unexpected consequences.
> 
>>   read_pmevcntrn+0x1e4/0x1ec arch/arm64/kernel/perf_event.c:423
>>   armv8pmu_read_evcntr arch/arm64/kernel/perf_event.c:467 [inline]
>>   armv8pmu_read_hw_counter arch/arm64/kernel/perf_event.c:475 [inline]
>>   armv8pmu_read_counter+0x10c/0x1f0 arch/arm64/kernel/perf_event.c:528
>>   armpmu_event_update+0x9c/0x1bc drivers/perf/arm_pmu.c:247
>>   armpmu_read+0x24/0x30 drivers/perf/arm_pmu.c:264
>>   perf_output_read_group+0x4cc/0x71c kernel/events/core.c:6806
>>   perf_output_read+0x78/0x1c4 kernel/events/core.c:6845
>>   perf_output_sample+0xafc/0x1000 kernel/events/core.c:6892
>>   __perf_event_output kernel/events/core.c:7273 [inline]
>>   perf_event_output_forward+0xd8/0x130 kernel/events/core.c:7287
>>   __perf_event_overflow+0xbc/0x20c kernel/events/core.c:8943
>>   perf_swevent_overflow kernel/events/core.c:9019 [inline]
>>   perf_swevent_event+0x274/0x2c0 kernel/events/core.c:9047
>>   do_perf_sw_event kernel/events/core.c:9160 [inline]
>>   ___perf_sw_event+0x150/0x1b4 kernel/events/core.c:9191
>>   __perf_sw_event+0x58/0x7c kernel/events/core.c:9203
>>   perf_sw_event include/linux/perf_event.h:1177 [inline]
> 
>> Interrupts is not disabled when perf_output_read_group reads PMU counter.
> 
> s/is/are/ due to 'interrupts' being plural
> 
> Anyway, yes, I suppose this is indeed so. That code expects to run with
> IRQs disabled but in the case of software events that isn't so.
> 
The v4 patch only corrects the commit message because it is not 
determined whether to check the software event.
If processing is improper, please tell me and will resend the patch.

Thanks,
Yang
