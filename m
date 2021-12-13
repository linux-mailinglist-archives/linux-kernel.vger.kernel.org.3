Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA4472397
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhLMJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:16:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4251 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhLMJQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:16:25 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JCG781HrNz67v1F;
        Mon, 13 Dec 2021 17:15:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 10:16:23 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 13 Dec
 2021 09:16:22 +0000
Subject: Re: [PATCH v2] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <Ajish.Koshy@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1639158706-18446-1-git-send-email-john.garry@huawei.com>
 <5d1b0c7c-90c6-8aba-3153-29df6eac865d@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <63cc50a5-b7ce-5930-68f1-039a71178b48@huawei.com>
Date:   Mon, 13 Dec 2021 09:16:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <5d1b0c7c-90c6-8aba-3153-29df6eac865d@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.94]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2021 00:26, Damien Le Moal wrote:
>> ss
>> @@ -4320,20 +4324,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>>   		pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
>>   		for (i = 0; i < length; i++)
>>   			if (i < 16) {
>> -				smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
>> +				smp_cmd.smp_req16[i] = *(payload+i);
> Maybe add spacs around the "+" as you did above ?

Yeah, right. I noticed now that only strict mode of checkpatch picks up 
on this.

> 
>>   				pm8001_dbg(pm8001_ha, IO,
>>   					   "Byte[%d]:%x (DMA data:%x)\n",
>>   					   i, smp_cmd.smp_req16[i],

...

>>   	}
>> -
>> +	kunmap_atomic(to);
>>   	build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
>>   				&smp_cmd, pm8001_ha->smp_exp_mode, length);
>>   	rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
> Otherwise, looks OK to me.

cheers
