Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF950DAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiDYISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiDYIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:17:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1625AEC9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:14:14 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KmyP35GMVz67KBg;
        Mon, 25 Apr 2022 16:10:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:14:11 +0200
Received: from [10.47.92.213] (10.47.92.213) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 09:14:10 +0100
Message-ID: <94786075-d0b4-a067-ae08-b696a120ac98@huawei.com>
Date:   Mon, 25 Apr 2022 09:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3 2/2] drivers/perf: hisi: add driver for HNS3 PMU
To:     "huangguangbin (A)" <huangguangbin2@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "Fangjian (Jay)" <f.fangjian@huawei.com>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        "shenjian (K)" <shenjian15@huawei.com>,
        moyufeng <moyufeng@huawei.com>
References: <20220329113930.37631-1-huangguangbin2@huawei.com>
 <20220329113930.37631-3-huangguangbin2@huawei.com>
 <2a66d1d7-cf85-1ce0-1adf-f72a27243fe1@huawei.com>
 <5f23529e-0ddf-57bf-9bc3-5246fbec92c2@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <5f23529e-0ddf-57bf-9bc3-5246fbec92c2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.92.213]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +F:    drivers/perf/hisilicon/hns3_pmu.c
>>> +
>>>   HISILICON QM AND ZIP Controller DRIVER
>>>   M:    Zhou Wang <wangzhou1@hisilicon.com>
>>>   L:    linux-crypto@vger.kernel.org
>>> diff --git a/drivers/perf/hisilicon/Kconfig 
>>> b/drivers/perf/hisilicon/Kconfig
>>> index 5546218b5598..171bfc1b6bc2 100644
>>> --- a/drivers/perf/hisilicon/Kconfig
>>> +++ b/drivers/perf/hisilicon/Kconfig
>>> @@ -14,3 +14,13 @@ config HISI_PCIE_PMU
>>>         RCiEP devices.
>>>         Adds the PCIe PMU into perf events system for monitoring 
>>> latency,
>>>         bandwidth etc.
>>> +
>>> +config HNS3_PMU
>>> +    tristate "HNS3 PERF PMU"
>>> +    depends on ARM64 || COMPILE_TEST
>>
>> is see hns3_pmu_readq() below, so you need to ensure the arch supports 
>> readq - so I think that you need to depend on 64b. I assume that you 
>> never built this for a 32b arch
>>
> Our CPU arch is just arm64, so I set it to depend on ARM64. Yeah, I 
> never built this for a 32b arch because we would never run this driver 
> on 32b CPU.
> Are you mean that hns3_pmu_readq() will be compiled failed for 32b arch?

Yes. That is the point of COMPILE_TEST - we may compile for other 
architectures (even though in they will never been seen in reality on 
other architectures). For me I find it useful to test compile drivers 
for HW only seen on arm machines from my x86 machine without cross 
compiling.

 > So I think that I need to delete COMPILE_TEST to prevent from this case.

No, please keep it. So I think you have 2x options:
- Add additional Kconfig dependency on CONFIG_64BIT
- include io-64-nonatomic-hi-lo.h
