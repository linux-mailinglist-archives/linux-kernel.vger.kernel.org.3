Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B4846BD02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhLGN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:58:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4225 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhLGN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:58:14 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7hZf2C7Cz67jkw;
        Tue,  7 Dec 2021 21:52:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 14:54:42 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 13:54:41 +0000
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     <Ajish.Koshy@microchip.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <Viswas.G@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <Niklas.Cassel@wdc.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
Date:   Tue, 7 Dec 2021 13:54:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 10:36, Ajish.Koshy@microchip.com wrote:
> Well I could see this kernel panic [  126.843958] RIP: 0010:pm80xx_chip_smp_req+0x1d6/0x2e0 [pm80xx] with respect to existing driver on my current system x86 64bit after enabling the following 2 kernel boot arguments:
> -intel_iommu=on
> -iommu.passthrough=0
>
OK, so it seems that it was the kernel which was just not enabling the 
IOMMU previously, which would be consistent with what Niklas mentioned.

Anyway, please supply reviewed-by and/or tested-by tags so that the SCSI 
maintainers can pick it up.

I suppose that we should also have:

Fixes: f5860992db55 ("[SCSI] pm80xx: Added SPCv/ve specific hardware
functionalities and relevant changes in common files")

Thanks for testing,
John
