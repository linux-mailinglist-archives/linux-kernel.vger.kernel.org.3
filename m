Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2E51FC8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiEIMYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiEIMYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:24:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6052C676;
        Mon,  9 May 2022 05:20:49 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxgGK363Vzfb9J;
        Mon,  9 May 2022 20:19:37 +0800 (CST)
Received: from [10.67.77.175] (10.67.77.175) by dggpeml500023.china.huawei.com
 (7.185.36.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 20:20:47 +0800
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Besar Wicaksono <bwicaksono@nvidia.com>
CC:     <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <2f3000b9-6c31-7ef7-46c2-6b7a42fe893b@hisilicon.com>
Date:   Mon, 9 May 2022 20:20:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.77.175]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/9 18:02, Suzuki K Poulose wrote:
> Cc: Mike Williams, Mathieu Poirier
> 
> On 09/05/2022 10:28, Will Deacon wrote:
>> On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
>>> Add driver support for ARM CoreSight PMU device and event attributes for NVIDIA
>>> implementation. The code is based on ARM Coresight PMU architecture and ACPI ARM
>>> Performance Monitoring Unit table (APMT) specification below:
>>>   * ARM Coresight PMU:
>>>          https://developer.arm.com/documentation/ihi0091/latest
>>>   * APMT: https://developer.arm.com/documentation/den0117/latest
>>>
>>> Notes:
>>>   * There is a concern on the naming of the PMU device.
>>>     Currently the driver is probing "arm-coresight-pmu" device, however the APMT
>>>     spec supports different kinds of CoreSight PMU based implementation. So it is
>>>     open for discussion if the name can stay or a "generic" name is required.
>>>     Please see the following thread:
>>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2022-May/740485.html
>>>
>>> Besar Wicaksono (2):
>>>    perf: coresight_pmu: Add support for ARM CoreSight PMU driver
>>>    perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
>>>
>>>   arch/arm64/configs/defconfig                  |    1 +
>>>   drivers/perf/Kconfig                          |    2 +
>>>   drivers/perf/Makefile                         |    1 +
>>>   drivers/perf/coresight_pmu/Kconfig            |   10 +
>>>   drivers/perf/coresight_pmu/Makefile           |    7 +
>>>   .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317 +++++++++++++++++
>>>   .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
>>>   .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
>>>   .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>>>   9 files changed, 1802 insertions(+)
>>
>> How does this interact with all the stuff we have under
>> drivers/hwtracing/coresight/?
> 
> Absolutely zero, except for the name. The standard
> is named "CoreSight PMU" which is a bit unfortunate,
> given the only link, AFAIU, with the "CoreSight" architecture
> is the Lock Access Register(LAR). For reference, the
> drivers/hwtracing/coresight/ is purely "CoreSight" self-hosted
> tracing and the PMU is called "cs_etm" (expands to coresight etm).
> Otherwise the standard doesn't have anything to do with what
> exists already in the kernel.
> 
> That said, I am concerned that the "coresight_pmu" is easily confused
> with what exists today. Given that this is more of a "PMU" standard
> for the IPs in the Arm world, it would be better to name it as such
> avoiding any confusion with the existing PMUs.
> 
> One potential recommendation for the name is, "Arm PMU"  (The ACPI table is named Arm PMU Table).
> But then that could be clashing with the armv8_pmu :-(.
> 
> Some of the other options are :
> 
> "Arm Generic PMU"
> "Arm Uncore PMU"

To be honest, if wants to distinguish from Arm core PMU, the "Uncore PMU" is a
better choice just in my opinion. The x86 including Intel and AMD also do the
uncore PMU driver and with "uncore_" prefix.

Thanks,
Shaokun

> "Arm PMU"
> 
> Suzuki
> 
>>
>> Will
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
