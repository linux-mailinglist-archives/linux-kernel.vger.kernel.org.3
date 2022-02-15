Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7A4B6000
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiBOB2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:28:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiBOB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:27:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE74108BF0;
        Mon, 14 Feb 2022 17:27:40 -0800 (PST)
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyNdL1mJlzZfdl;
        Tue, 15 Feb 2022 09:23:18 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 09:27:38 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 09:27:37 +0800
Subject: Re: [PATCH 2/2] perf jevents: Add support for HiSilicon CPA PMU
 aliasing
To:     John Garry <john.garry@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>
References: <20220214114228.40859-1-liuqi115@huawei.com>
 <20220214114228.40859-3-liuqi115@huawei.com>
 <1da1252e-59d0-77d1-0419-242528739392@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <dfa69bbf-726c-558a-b929-aa97dd6590aa@huawei.com>
Date:   Tue, 15 Feb 2022 09:27:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1da1252e-59d0-77d1-0419-242528739392@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/2/14 20:04, John Garry wrote:
> On 14/02/2022 11:42, Qi Liu wrote:
>> Add support for HiSilicon CPA PMU aliasing.
>>
>> The kernel driver is in drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
>>
>> Signed-off-by: Qi Liu<liuqi115@huawei.com>
> 
> You realy should cc the perf tool list and maintainers there also.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
>> +    },
>> +    {
>> +        "MetricExpr": "(p0_wr_dat * 64 + p0_rd_dat_64b * 64 + 
>> p0_rd_dat_32b * 32) / cpa_cycles",
>> +        "BriefDescription": "Average bandwidth of CPA Port 0",
>> +        "MetricGroup": "CPA",
> 
Hi john,

> nit: maybe this should have a more distrinct name

got it, will change metric's name next version.

> 
>> +        "MetricName": "p0_avg_bw",
>> +        "Compat": "0x00000030",
> 
> JFYI, I have a rewrite of the perf tool system pmu metric support that 
> will not require us to add the compat here.
> 
great! I'm very glad to test it using CPA PMU.

Thanks,
Qi
>> +        "Unit": "hisi_sicl,cpa"
> 
> Thanks,
> John
> .
