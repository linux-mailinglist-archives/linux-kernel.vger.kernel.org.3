Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55614F8CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiDHBE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiDHBEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:04:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671E219AD0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:02:21 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZKg52BYSzgYVD;
        Fri,  8 Apr 2022 09:00:33 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 09:02:18 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 8 Apr
 2022 09:02:18 +0800
Subject: Re: [PATCH v3 0/3] genirq: Managed affinity fixes
To:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        David Decotigny <ddecotig@google.com>
References: <20220405185040.206297-1-maz@kernel.org>
 <b14b61cc-ab47-e90d-7f81-f05197645dc6@huawei.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c3f3a519-b81b-abe1-b6ea-599561478abf@huawei.com>
Date:   Fri, 8 Apr 2022 09:02:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b14b61cc-ab47-e90d-7f81-f05197645dc6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/8 1:29, John Garry wrote:
> On 05/04/2022 19:50, Marc Zyngier wrote:
>> John (and later on David) reported[1] a while ago that booting with
>> maxcpus=1, managed affinity devices would fail to get the interrupts
>> that were associated with offlined CPUs.
>>
>> Similarly, Xiongfeng reported[2] that the GICv3 ITS would sometime use
>> non-housekeeping CPUs instead of the affinity that was passed down as
>> a parameter.
>>
>> [1] can be fixed by not trying to activate these interrupts if no CPU
>> that can satisfy the affinity is present (a patch addressing this was
>> already posted[3])
>>
>> [2] is a consequence of affinities containing non-online CPUs being
>> passed down to the interrupt controller driver and the ITS driver
>> trying to paper over that by ignoring the affinity parameter and doing
>> its own (stupid) thing. It would be better to (a) get the core code to
>> remove the offline CPUs from the affinity mask at all times, and (b)
>> fix the drivers so that they can trust the core code not to trip them.
>>
>> This small series, based on 5.18-rc1, addresses the above.
> 
> Hi Marc,
> 
> Please let me know if you require anything more from me on this one. I was
> hoping that Xiongfeng would verify that his "housekeeping" issues were fixed.

I have tested the V2 version. It works well and fixed both issues, the
'maxcpus=1' issue and 'housekeeping' issue. Let me know if you need me test this
V3 version. I am not seeing much change, only context change.

Thanks,
Xiongfeng

> 
> Cheers
> 
>>
>> Thanks,
>>
>>     M.
>>
>>> From v2 [4]:
>>    - Rebased on 5.18-rc1
>>
>> [1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
>> [2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
>> [3] https://lore.kernel.org/r/20220307190625.254426-1-maz@kernel.org
>> [4] https://lore.kernel.org/r/20220321193608.975495-1-maz@kernel.org
>>
>> Marc Zyngier (3):
>>    genirq/msi: Shutdown managed interrupts with unsatifiable affinities
>>    genirq: Always limit the affinity to online CPUs
>>    irqchip/gic-v3: Always trust the managed affinity provided by the core
>>      code
>>
>>   drivers/irqchip/irq-gic-v3-its.c |  2 +-
>>   kernel/irq/manage.c              | 25 +++++++++++++++++--------
>>   kernel/irq/msi.c                 | 15 +++++++++++++++
>>   3 files changed, 33 insertions(+), 9 deletions(-)
>>
> 
> .
