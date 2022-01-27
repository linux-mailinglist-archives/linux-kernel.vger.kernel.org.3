Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38849E1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiA0L4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:56:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4524 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiA0L4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:01 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JkzYf13V1z6H8Ws;
        Thu, 27 Jan 2022 19:55:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 12:55:58 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 27 Jan
 2022 11:55:57 +0000
Subject: Re: [PATCH 01/16] scsi: libsas: Use enum for response frame DATAPRES
 field
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@cloud.ionos.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>, <damien.lemoal@opensource.wdc.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-2-git-send-email-john.garry@huawei.com>
 <4a2986a4-8293-2a25-8ee1-109ff8aa0bc3@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <63938cd5-a739-9ebb-cd3c-1b7f8ff81af3@huawei.com>
Date:   Thu, 27 Jan 2022 11:55:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <4a2986a4-8293-2a25-8ee1-109ff8aa0bc3@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 11:31, chenxiang (M) wrote:
>> +
> 
> I find that iu->datapres is also used in other drivers with 0/1/2, and 
> maybe it is worth to replace all of them with those enum.
> 
>    2    290 
> /home/chenxiang/kernel_next/kernel-dev/drivers/scsi/aic94xx/aic94xx_tmf.c <<<unknown>>> 
> 
>               if (ru->datapres == 1)
> 5   1055 
> /home/chenxiang/kernel_next/kernel-dev/drivers/scsi/isci/request.c 
> <<<unknown>>>
>               if (datapres == 1 || datapres == 2) {
>     6   1740 
> /home/chenxiang/kernel_next/kernel-dev/drivers/scsi/isci/request.c 
> <<<unknown>>>
>               if (resp_iu->datapres == 0x01 ||
>     7   1741 
> /home/chenxiang/kernel_next/kernel-dev/drivers/scsi/isci/request.c 
> <<<unknown>>>
>                   resp_iu->datapres == 0x02) {
>   17   1641 
> /home/chenxiang/kernel_next/kernel-dev/drivers/scsi/mvsas/mv_sas.c 
> <<<unknown>>>
>               iu->datapres = 2;
> 
>>   /* fill task_status_struct based o

OK, I can move that enum to libsas.h and use in those drivers.

But I will also check that they are not duplicating code already in libsas.h

Thanks,
John
