Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36455CA23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiF0OcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiF0OcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:32:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74145B53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:32:00 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWqsg1wJ9z9sx3;
        Mon, 27 Jun 2022 22:31:19 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 22:31:56 +0800
Received: from [10.67.102.67] (10.67.102.67) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 27 Jun
 2022 22:31:55 +0800
Subject: Re: [RESEND PATCH V7 2/2] drivers/perf: hisi: add driver for HNS3 PMU
To:     Will Deacon <will@kernel.org>
CC:     <john.garry@huawei.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <lipeng321@huawei.com>,
        <shenjian15@huawei.com>
References: <20220525005211.57059-1-huangguangbin2@huawei.com>
 <20220525005211.57059-3-huangguangbin2@huawei.com>
 <20220627105211.GD22095@willie-the-truck>
From:   "huangguangbin (A)" <huangguangbin2@huawei.com>
Message-ID: <639b6a40-139e-60c4-6792-b65b965ab844@huawei.com>
Date:   Mon, 27 Jun 2022 22:31:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220627105211.GD22095@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/27 18:52, Will Deacon wrote:
> On Wed, May 25, 2022 at 08:52:11AM +0800, Guangbin Huang wrote:
>> HNS3(HiSilicon Network System 3) PMU is RCiEP device in HiSilicon SoC NIC,
>> supports collection of performance statistics such as bandwidth, latency,
>> packet rate and interrupt rate.
>>
>> NIC of each SICL has one PMU device for it. Driver registers each PMU
>> device to perf, and exports information of supported events, filter mode of
>> each event, bdf range, hardware clock frequency, identifier and so on via
>> sysfs.
>>
>> Each PMU device has its own registers of control, counters and interrupt,
>> and it supports 8 hardware events, each hardward event has its own
>> registers for configuration, counters and interrupt.
>>
>> Filter options contains:
>> event        - select event
>> port         - select physical port of nic
>> tc           - select tc(must be used with port)
>> func         - select PF/VF
>> queue        - select queue of PF/VF(must be used with func)
>> intr         - select interrupt number(must be used with func)
>> global       - select all functions of IO DIE
>>
>> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   MAINTAINERS                       |    6 +
>>   drivers/perf/hisilicon/Kconfig    |   10 +
>>   drivers/perf/hisilicon/Makefile   |    1 +
>>   drivers/perf/hisilicon/hns3_pmu.c | 1662 +++++++++++++++++++++++++++++
>>   include/linux/cpuhotplug.h        |    1 +
>>   5 files changed, 1680 insertions(+)
>>   create mode 100644 drivers/perf/hisilicon/hns3_pmu.c
> 
> This mostly looks good to me, but I have one niggling concern with the ABI:
> 
>> +#define HNS3_PMU_FILTER_ATTR(_name, _config, _start, _end)               \
>> +	static inline u64 hns3_pmu_get_##_name(struct perf_event *event) \
>> +	{                                                                \
>> +		return FIELD_GET(GENMASK_ULL(_end, _start),              \
>> +				 event->attr._config);                   \
>> +	}
>> +
>> +HNS3_PMU_FILTER_ATTR(event, config, 0, 16);
>> +HNS3_PMU_FILTER_ATTR(subevent, config, 0, 7);
>> +HNS3_PMU_FILTER_ATTR(event_type, config, 8, 15);
>> +HNS3_PMU_FILTER_ATTR(ext_counter_used, config, 16, 16);
>> +HNS3_PMU_FILTER_ATTR(real_event, config, 0, 15);
> 
> How does perf tool deal with overlapping fields like this? It seems like
> quite a bad idea to allow things like "event=0xffff,subevent=0" when they
> are no longer distinct and I don't _think_ any other drivers do this.
> 
> Can you remove 'event' and 'real_event' for now, or are they needed?
> 
> Will
> .
> 
Ok, I will modify this part.
