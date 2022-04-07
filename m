Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C994F8643
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346425AbiDGRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbiDGRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:32:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663F10DA5D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:30:04 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZ7cs0T8dz67XcG;
        Fri,  8 Apr 2022 01:27:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 19:30:01 +0200
Received: from [10.47.95.175] (10.47.95.175) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 18:30:00 +0100
Message-ID: <b14b61cc-ab47-e90d-7f81-f05197645dc6@huawei.com>
Date:   Thu, 7 Apr 2022 18:29:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/3] genirq: Managed affinity fixes
To:     Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
References: <20220405185040.206297-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220405185040.206297-1-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.175]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 19:50, Marc Zyngier wrote:
> John (and later on David) reported[1] a while ago that booting with
> maxcpus=1, managed affinity devices would fail to get the interrupts
> that were associated with offlined CPUs.
> 
> Similarly, Xiongfeng reported[2] that the GICv3 ITS would sometime use
> non-housekeeping CPUs instead of the affinity that was passed down as
> a parameter.
> 
> [1] can be fixed by not trying to activate these interrupts if no CPU
> that can satisfy the affinity is present (a patch addressing this was
> already posted[3])
> 
> [2] is a consequence of affinities containing non-online CPUs being
> passed down to the interrupt controller driver and the ITS driver
> trying to paper over that by ignoring the affinity parameter and doing
> its own (stupid) thing. It would be better to (a) get the core code to
> remove the offline CPUs from the affinity mask at all times, and (b)
> fix the drivers so that they can trust the core code not to trip them.
> 
> This small series, based on 5.18-rc1, addresses the above.

Hi Marc,

Please let me know if you require anything more from me on this one. I 
was hoping that Xiongfeng would verify that his "housekeeping" issues 
were fixed.

Cheers

> 
> Thanks,
> 
> 	M.
> 
>>From v2 [4]:
>    - Rebased on 5.18-rc1
> 
> [1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
> [2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
> [3] https://lore.kernel.org/r/20220307190625.254426-1-maz@kernel.org
> [4] https://lore.kernel.org/r/20220321193608.975495-1-maz@kernel.org
> 
> Marc Zyngier (3):
>    genirq/msi: Shutdown managed interrupts with unsatifiable affinities
>    genirq: Always limit the affinity to online CPUs
>    irqchip/gic-v3: Always trust the managed affinity provided by the core
>      code
> 
>   drivers/irqchip/irq-gic-v3-its.c |  2 +-
>   kernel/irq/manage.c              | 25 +++++++++++++++++--------
>   kernel/irq/msi.c                 | 15 +++++++++++++++
>   3 files changed, 33 insertions(+), 9 deletions(-)
> 

