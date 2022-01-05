Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F34851BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiAELYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:24:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4348 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiAELYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:24:01 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTRqd5ywhz67ZJW;
        Wed,  5 Jan 2022 19:20:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 12:23:59 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 11:23:58 +0000
From:   John Garry <john.garry@huawei.com>
Subject: PCI MSI issue for maxcpus=1
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC:     chenxiang <chenxiang66@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <78615d08-1764-c895-f3b7-bfddfbcbdfb9@huawei.com>
Date:   Wed, 5 Jan 2022 11:23:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.56]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Just a heads up, I noticed that commit 4c457e8cb75e ("genirq/msi: 
Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is set") is 
causing an issue on our arm64 D06 board where the SAS driver probe fails 
for maxcpus=1.

This seems different to issue [0].

So it's the driver call to pci_alloc_irq_vectors_affinity() which errors 
[1]:

[    9.619070] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2

Some details:
- device supports 32 MSI
- min and max msi for that function is 17 and 32, respect.
- affd pre and post are 16 and 0, respect.

I haven't checked to see what the issue is yet and I think that the 
pci_alloc_irq_vectors_affinity() usage is ok...

[0] 
https://lore.kernel.org/lkml/ea730f9b-c635-317d-c70d-4057590b1d1a@huawei.com/
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c?h=v5.11#n2388

Cheers,
John
