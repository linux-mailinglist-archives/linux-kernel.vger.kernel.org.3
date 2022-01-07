Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58248766C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbiAGLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:24:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4368 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiAGLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:24:54 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVgjm2KHrz67Ntg;
        Fri,  7 Jan 2022 19:19:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 12:24:52 +0100
Received: from [10.47.89.210] (10.47.89.210) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:24:51 +0000
Subject: Re: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
 <87a6g8vp8k.wl-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <19d55cdf-9ef7-e4a3-5ae5-0970f0d7751b@huawei.com>
Date:   Fri, 7 Jan 2022 11:24:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87a6g8vp8k.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.89.210]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>> So it's the driver call to pci_alloc_irq_vectors_affinity() which
>> errors [1]:
>>
>> [    9.619070] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
> Can you log what error is returned from pci_alloc_irq_vectors_affinity()?

-EINVAL

> 
>> Some details:
>> - device supports 32 MSI
>> - min and max msi for that function is 17 and 32, respect.
> This 17 is a bit odd, owing to the fact that MultiMSI can only deal
> with powers of 2. You will always allocate 32 in this case. Not sure
> why that'd cause an issue though. Unless...

Even though 17 is the min, we still try for nvec=32 in 
msi_capability_init() as possible CPUs is 96.

> 
>> - affd pre and post are 16 and 0, respect.
>>
>> I haven't checked to see what the issue is yet and I think that the
>> pci_alloc_irq_vectors_affinity() usage is ok...
> ... we really end-up with desc->nvec_used == 32 and try to activate
> past vector 17 (which is likely to fail). Could you please check this?

Yeah, that looks to fail. Reason being that in the GIC ITS driver when 
we try to activate the irq for this managed interrupt all cpus in the 
affinity mask are offline. Calling its_irq_domain_activate() -> 
its_select_cpu() it gives cpu=nr_cpu_ids. The affinity mask for that 
interrupt is 24-29.

Thanks,
John
