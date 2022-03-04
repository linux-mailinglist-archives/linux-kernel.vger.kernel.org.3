Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0081B4CD48C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiCDMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiCDMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:54:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9739BAD6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:53:35 -0800 (PST)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K977g4RdZz67KmH;
        Fri,  4 Mar 2022 20:53:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 4 Mar 2022 13:53:33 +0100
Received: from [10.47.95.117] (10.47.95.117) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 12:53:32 +0000
Message-ID: <1cbe7daa-8003-562b-06fa-5a50f7ee6ed2@huawei.com>
Date:   Fri, 4 Mar 2022 12:53:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: PCI MSI issue for maxcpus=1
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>, <wangxiongfeng2@huawei.com>
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org>
 <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
 <87v8yjyjc0.wl-maz@kernel.org> <87k0ey9122.wl-maz@kernel.org>
 <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com>
In-Reply-To: <5f529b4e-1f6c-5a7d-236c-09ebe3a7db29@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.117]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...

> 
> [ 7.961007]  valid_col+0x14/0x24
> [ 7.964223]  its_send_single_command+0x4c/0x150
> [ 7.968741]  its_irq_domain_activate+0xc8/0x104
> [ 7.973259]  __irq_domain_activate_irq+0x5c/0xac
> [ 7.977865]  __irq_domain_activate_irq+0x38/0xac
> [ 7.982471]  irq_domain_activate_irq+0x3c/0x64
> [ 7.986902]  __msi_domain_alloc_irqs+0x1a8/0x2f4
> [ 7.991507]  msi_domain_alloc_irqs+0x20/0x2c
> [ 7.995764]  __pci_enable_msi_range+0x2ec/0x590
> [ 8.000284]  pci_alloc_irq_vectors_affinity+0xe0/0x140
> [ 8.005410]  hisi_sas_v3_probe+0x300/0xbe0
> [ 8.009494]  local_pci_probe+0x44/0xb0
> [ 8.013232]  work_for_cpu_fn+0x20/0x34
> [ 8.016969]  process_one_work+0x1d0/0x354
> [ 8.020966]  worker_thread+0x2c0/0x470
> [ 8.024703]  kthread+0x17c/0x190
> [ 8.027920]  ret_from_fork+0x10/0x20
> [ 8.031485] ---[ end trace bb67cfc7eded7361 ]---
> 

...

> Ah, of course. the CPU hasn't booted yet, so its collection isn't
> mapped. I was hoping that the core code would keep the interrupt in
> shutdown state, but it doesn't seem to be the case...
> 
>  > Apart from this, I assume that if another cpu comes online later in
>  > the affinity mask I would figure that we want to target the irq to
>  > that cpu (which I think we would not do here).
> 
> That's probably also something that should come from core code, as
> we're not really in a position to decide this in the ITS driver.
> .


Hi Marc,

Have you had a chance to consider this issue further?

So I think that x86 avoids this issue as it uses matrix.c, which handles 
CPUs being offline when selecting target CPUs for managed interrupts.

So is your idea still that core code should keep the interrupt in 
shutdown state (for no CPUs online in affinity mask)?

Thanks,
John



