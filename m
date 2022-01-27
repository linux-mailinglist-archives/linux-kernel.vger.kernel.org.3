Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C957B49DFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiA0KrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:47:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4523 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiA0Kq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:46:59 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jky2023Tvz6H8Vl;
        Thu, 27 Jan 2022 18:46:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 11:46:56 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 10:46:55 +0000
Subject: Re: [PATCH 08/16] scsi: libsas: Add sas_execute_ssp_tmf()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>,
        <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-9-git-send-email-john.garry@huawei.com>
 <YfJy26K2zTxbVjDK@infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <442fa3a6-3e6b-0a5e-47a4-87fcfc696f8b@huawei.com>
Date:   Thu, 27 Jan 2022 10:46:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YfJy26K2zTxbVjDK@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 10:24, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 07:32:44PM +0800, John Garry wrote:
>> Add a function to issue an SSP TMF.
>>
>> Add a temp prototype to keep make W=1 happy.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/scsi/libsas/sas_scsi_host.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
>> index 93ca6da63104..cfdf4a031be0 100644
>> --- a/drivers/scsi/libsas/sas_scsi_host.c
>> +++ b/drivers/scsi/libsas/sas_scsi_host.c
>> @@ -938,6 +938,11 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
>>   		task->dev = device;
>>   		task->task_proto = device->tproto;
>>   
>> +		if (dev_is_sata(device)) {
>> +		} else {
>> +			memcpy(&task->ssp_task, parameter, para_len);
>> +		}
> 
> This looks strange,
> 

I'm trying to be too cute. I did this as I add in the 'if' part in a 
later patch.

In hindsight, I don't think it's a good practice and I'll code as suggested.

 >  why not:
> 		if (!dev_is_sata(device))
> 			memcpy(&task->ssp_task, parameter, para_len);
> .
> 

Thanks,
John

