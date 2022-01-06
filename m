Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9044866C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiAFPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:33:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4356 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240432AbiAFPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:33:10 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JV9Jb2fr3z67K2n;
        Thu,  6 Jan 2022 23:29:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:33:08 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 15:33:07 +0000
Subject: Re: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
To:     <Ajish.Koshy@microchip.com>, <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <Viswas.G@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishakhavc@google.com>, <ipylypiv@google.com>,
        <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
 <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
 <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
 <PH0PR11MB5112F9E9BB9F029DB9A67739EC4C9@PH0PR11MB5112.namprd11.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c19c2b0b-d502-b393-db8a-cb5c57c00feb@huawei.com>
Date:   Thu, 6 Jan 2022 15:32:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <PH0PR11MB5112F9E9BB9F029DB9A67739EC4C9@PH0PR11MB5112.namprd11.prod.outlook.com>
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

On 06/01/2022 13:03, Ajish.Koshy@microchip.com wrote:
>>   only a specific vector and, also, why we check at all in
>> an interrupt handler.
> Here is my initial understanding so far based on the code
> and data sheet
> 
> 1. Controller has the capability to communicate
> to the host about fatal error condition via configured
> interrupt vector MSI/MSI-X.
> 2. This capability is achieved by setting two fields
>   a. Enable Controller Fatal error notification
>      Dowrd 0x1C, Bit[0].
>      1 - Enable; 0 - Disable
>      Code: pm8001_ha->main_cfg_tbl.pm80xx_tbl.
>      fatal_err_interrupt = 0x01;
>   b. Fatal Error Interrupt Vector Dword 0x1C, bit[15:8]
>      This parameter configures which interrupt vector
>      is used to notify the host of the fatal error.
>      Code: /* Update Fatal error interrupt vector */
>      pm8001_ha->main_cfg_tbl.pm80xx_tbl.
>      fatal_err_interrupt |=
>      ((pm8001_ha->max_q_num - 1) << 8);
> 
> Probably this will be the reason why we check
> the vector in process_oq() for processing
> controller fatal error
> 
> if (vec == (pm8001_ha->max_q_num - 1)) {
>   
> Please do let me know if it helped in clarification.
> 

Sounds reasonable. And we only discover the issue for 8008/8009 now as 
we have that (pm8001_ha->max_q_num - 1) vector being used for standard IO.

So let me know of any other issue, otherwise I'll send a v2 with the 
coding style fixup.

Thanks,
John
