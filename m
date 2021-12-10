Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F9446FEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhLJKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:48:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4243 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbhLJKsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:48:17 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J9SCq6nGXz686Sr;
        Fri, 10 Dec 2021 18:42:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 11:44:41 +0100
Received: from [10.47.85.63] (10.47.85.63) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 10:44:40 +0000
Subject: Re: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     <Ajish.Koshy@microchip.com>, <jinpu.wang@cloud.ionos.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <a93da7a3-9cbe-b278-36ce-1ac860ad43d6@huawei.com>
 <PH0PR11MB51122D76F40E164C31AFEE54EC719@PH0PR11MB5112.namprd11.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <eb82b0ab-912a-4879-f1b2-d5cbef5bfc41@huawei.com>
Date:   Fri, 10 Dec 2021 10:44:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB51122D76F40E164C31AFEE54EC719@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.63]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 10:23, Ajish.Koshy@microchip.com wrote:
> Hi John,

Please config your editor to wrap at ~72 characters and don't top-post.

> 
> In my humble opinion what we observed very earlier was with respect smp_request()/response() crash and this patch resolved it. Given that the issue was not only specific to ARM, issue was observed on x86 too with IOMMU enabled. Device discovery went fine post application of this patch on x86.
> 
> What we are observing right now on error handling/timeouts for commands on drives will be altogether different issue that needs separate debugging on ARM platform with separate patch since this is a very initial execution of pm80xx driver on ARM platform.
> 
> This patch is acceptable. Let me know your further views.
> 

As I mentioned earlier about this patch, a v2 is needed as we need 
kmap_atomic() in both cases. But I would rather resolve all issues 
before getting that merged - it has been broken this way for a long time.

So I mentioned a new issue in my response to Damien - maxcpus=1 on the 
command line crashes on boot. I can imagine that x86 also has that issue.

As for the timeouts, why would the FW not respond in the way I 
described? I would always expect a completion, even for erroneous 
commands. Maybe it is an interrupt issue in the driver. Is there some 
diagnostics I can check - there seems to be a lot of "stuff" in the 
sysfs scsi_host folder.

Thanks,
John

> Thanks,
> Ajish
> 
> On 26/11/2021 15:35, John Garry wrote:
>>        /*
>> @@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>>                pm8001_ha->smp_exp_mode = SMP_INDIRECT;
>>
>>
>> -     tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
>> -     preq_dma_addr = (char *)phys_to_virt(tmp_addr);
>> +     smp_req = &task->smp_task.smp_req;
>> +     to = kmap(sg_page(smp_req));
> This should be a kmap_atomic() as well, as I see the following for when
> CONFIG_DEBUG_ATOMIC_SLEEP is enabled:

