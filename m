Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39974851C5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiAEL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:28:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4349 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiAEL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:28:29 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTRxf2fn9z67nQW;
        Wed,  5 Jan 2022 19:25:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 12:28:26 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 11:28:25 +0000
Subject: Re: [PATCH RFT] scsi: pm8001: Fix FW crash for maxcpus=1
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <Ajish.Koshy@microchip.com>,
        <Viswas.G@microchip.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vishakhavc@google.com>, <ipylypiv@google.com>,
        <Ruksar.devadi@microchip.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
References: <1641320780-81620-1-git-send-email-john.garry@huawei.com>
 <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2746563e-28ce-b328-3494-f91ace1599f1@huawei.com>
Date:   Wed, 5 Jan 2022 11:28:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <d2d3c903-fb91-e218-9e0a-aeb2ff9e401a@opensource.wdc.com>
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

On 05/01/2022 04:03, Damien Le Moal wrote:
> On 1/5/22 03:26, John Garry wrote:
>> According to the comment in check_fw_ready() we should not check the
>> IOP1_READY field in register SCRATCH_PAD_1 for 8008 or 8009 controllers.
>>
>> However we check this very field in process_oq() for processing the highest
>> index interrupt vector. Change that function to not check IOP1_READY for
>> those mentioned controllers, but do check ILA_READY in both cases.
>>
>> The reason I assume that this was not hit earlier was because we always
>> allocated 64 MSI(X), and just did not pass the vector index check in
>> process_oq(), i.e.  the handler never ran for vector index 63.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>>
>> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
>> index 2101fc5761c3..77b8bb30615b 100644
>> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
>> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
>> @@ -4162,9 +4162,16 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
>>   	u32 regval;
>>   
>>   	if (vec == (pm8001_ha->max_q_num - 1)) {
>> +		u32 mipsall_ready;
>> +
>> +		if ((pm8001_ha->chip_id == chip_8008) ||
>> +		    (pm8001_ha->chip_id == chip_8009))
> nit: no need for the inner brackets here.

ok, I can fix that.

But I would also like opinion from microchip guys/maintainer on why this 
code is here at all. Seems strange in the way we check in this register 
in the interrupt handler for only a specific vector and, also, why we 
check at all in an interrupt handler.
> 
>> +			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_8PORT;
>> +		else
>> +			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_16PORT;
>> +
>>   		regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
>> -		if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
>> -					SCRATCH_PAD_MIPSALL_READY) {
>> +		if ((regval & mipsall_ready) != mipsall_ready) {
>>   			pm8001_ha->controller_fatal_error = true;
>>   			pm8001_dbg(pm8001_ha, FAIL,
>>   				   "Firmware Fatal error! Regval:0x%x\n",
>> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
>> index c7e5d93bea92..c41ed039c92a 100644
>> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
>> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
>> @@ -1405,8 +1405,12 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
>>   #define SCRATCH_PAD_BOOT_LOAD_SUCCESS	0x0
>>   #define SCRATCH_PAD_IOP0_READY		0xC00
>>   #define SCRATCH_PAD_IOP1_READY		0x3000
>> -#define SCRATCH_PAD_MIPSALL_READY	(SCRATCH_PAD_IOP1_READY | \
>> +#define SCRATCH_PAD_MIPSALL_READY_16PORT	(SCRATCH_PAD_IOP1_READY | \
>>   					SCRATCH_PAD_IOP0_READY | \
>> +					SCRATCH_PAD_ILA_READY | \
>> +					SCRATCH_PAD_RAAE_READY)
>> +#define SCRATCH_PAD_MIPSALL_READY_8PORT	(SCRATCH_PAD_IOP0_READY | \
>> +					SCRATCH_PAD_ILA_READY | \
>>   					SCRATCH_PAD_RAAE_READY)
>>   
>>   /* boot loader state */
> Otherwise, looks OK to me.
> I tested with and without max_cpus=1 with a ATTO Technology, Inc.
> ExpressSAS 12Gb/s SAS/SATA HBA (rev 06) adapter and everything is OK.
> That adapter uses chip_8072 though, not 8008 or 8009.
> 
> Feel free to add:
> 
> Reviewed-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>
> Tested-by: Damien Le Moal<damien.lemoal@opensource.wdc.com>

Thanks!

john

