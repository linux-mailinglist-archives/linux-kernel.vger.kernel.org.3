Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81074E4BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiCWDyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiCWDyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:54:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BC70F41
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:52:49 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KNZBm0YX5zCr3q;
        Wed, 23 Mar 2022 11:50:40 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 11:52:46 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 11:52:46 +0800
Subject: Re: [PATCH v2 0/3] genirq: Managed affinity fixes
To:     Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        David Decotigny <ddecotig@google.com>
References: <20220321193608.975495-1-maz@kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <a83da394-dcc0-c9a6-1569-9c30fbc291fd@huawei.com>
Date:   Wed, 23 Mar 2022 11:52:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220321193608.975495-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
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

Hi, Marc

On 2022/3/22 3:36, Marc Zyngier wrote:
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
> This small series, based on 5.17, addresses the above.

I have tested this patchset on D06. It works well with kernel parameter
'maxcpus=1' or 'nohz_full=1-127 isolcpus=nohz,domain,managed_irq,1-127'.
Also the 'effective_affinity' is correct. Thanks!
By the way, I merged the second patch manually because of conflicts.
Maybe I lack some patches on your local repo.

Thanks,
Xiongfeng

> 
> Thanks,
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com
> [2] https://lore.kernel.org/r/20220124073440.88598-1-wangxiongfeng2@huawei.com
> [3] https://lore.kernel.org/r/20220307190625.254426-1-maz@kernel.org
> 
> Marc Zyngier (3):
>   genirq/msi: Shutdown managed interrupts with unsatifiable affinities
>   genirq: Always limit the affinity to online CPUs
>   irqchip/gic-v3: Always trust the managed affinity provided by the core
>     code
> 
>  drivers/irqchip/irq-gic-v3-its.c |  2 +-
>  kernel/irq/manage.c              | 25 +++++++++++++++++--------
>  kernel/irq/msi.c                 | 15 +++++++++++++++
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
