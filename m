Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF390484F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiAEIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:48:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29323 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiAEIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:48:32 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JTNRJ2SdXzbjr6;
        Wed,  5 Jan 2022 16:47:56 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:48:30 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 16:48:30 +0800
Subject: Re: [PATCH v2] ata: libata-scsi: Make __ata_scsi_queuecmd()
 parameters check more clearly
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
CC:     "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>
References: <20220105202747.1963919-1-haowenchao@huawei.com>
 <ff55e8d2037fa1f11812329fb8da39e746abe878.camel@wdc.com>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <bbe9581c-1d8e-a1b2-dd5d-60027946941b@huawei.com>
Date:   Wed, 5 Jan 2022 16:48:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ff55e8d2037fa1f11812329fb8da39e746abe878.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/5 15:39, Damien Le Moal wrote:
> On Wed, 2022-01-05 at 15:27 -0500, Wenchao Hao wrote:
>> This is just a clean code. Since each branch of "if" state would check
>> scmd->cmd_len, so move the check of scmd->cmd_len out of "if" state to
>> simplify input parameters check.
>>
>> And remove redundant init of xlat_func at hand
>>
>> The patch do not change origin function logic.
>>
>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>> ---
>>   drivers/ata/libata-scsi.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 313e9475507b..ab8a2833dfec 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -4023,16 +4023,15 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>>   	ata_xlat_func_t xlat_func;
>>   	int rc = 0;
>>   
>> +	if (unlikely(!scmd->cmd_len))
>> +		goto bad_cdb_len;
>> +
>>   	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
>> -		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
>> +		if (unlikely(scmd->cmd_len > dev->cdb_len))
>>   			goto bad_cdb_len;
>>   
>>   		xlat_func = ata_get_xlat_func(dev, scsi_op);
>>   	} else {
>> -		if (unlikely(!scmd->cmd_len))
>> -			goto bad_cdb_len;
>> -
>> -		xlat_func = NULL;
>>   		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
>>   			/* relay SCSI command to ATAPI device */
>>   			int len = COMMAND_SIZE(scsi_op);
> 
> Did you miss my reply ?
> This change is OK, but while at it, let's cleanup this function further.
> I suggested something like this, which includes your changes.
> 

Maybe I misunderstood your previous reply. I think you ask me to change 
prefix.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a16ef0030667..ed8be585a98f 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3958,42 +3958,39 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
> struct ata_device *dev)
>   {
>   	u8 scsi_op = scmd->cmnd[0];
>   	ata_xlat_func_t xlat_func;
> -	int rc = 0;
> +
> +	if (unlikely(!scmd->cmd_len))
> +		goto bad_cdb_len;
> 
>   	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
> -		if (unlikely(!scmd->cmd_len || scmd->cmd_len > dev->cdb_len))
> +		if (unlikely(scmd->cmd_len > dev->cdb_len))
>   			goto bad_cdb_len;
> 
>   		xlat_func = ata_get_xlat_func(dev, scsi_op);
> -	} else {
> -		if (unlikely(!scmd->cmd_len))
> -			goto bad_cdb_len;
> +	} else if (scsi_op != ATA_16 || !atapi_passthru16) {
> +		/* relay SCSI command to ATAPI device */
> +		int len = COMMAND_SIZE(scsi_op);
> 
> -		xlat_func = NULL;
> -		if (likely((scsi_op != ATA_16) || !atapi_passthru16)) {
> -			/* relay SCSI command to ATAPI device */
> -			int len = COMMAND_SIZE(scsi_op);
> -			if (unlikely(len > scmd->cmd_len ||
> -				     len > dev->cdb_len ||
> -				     scmd->cmd_len > ATAPI_CDB_LEN))
> -				goto bad_cdb_len;
> +		if (unlikely(len > scmd->cmd_len ||
> +			     len > dev->cdb_len ||
> +			     scmd->cmd_len > ATAPI_CDB_LEN))
> +			goto bad_cdb_len;
> 
> -			xlat_func = atapi_xlat;
> -		} else {
> -			/* ATA_16 passthru, treat as an ATA command */
> -			if (unlikely(scmd->cmd_len > 16))
> -				goto bad_cdb_len;
> +		xlat_func = atapi_xlat;
> +	} else {
> +		/* ATA_16 passthru, treat as an ATA command */
> +		if (unlikely(scmd->cmd_len > 16))
> +			goto bad_cdb_len;
> 
> -			xlat_func = ata_get_xlat_func(dev, scsi_op);
> -		}
> +		xlat_func = ata_get_xlat_func(dev, scsi_op);
>   	}
> 
>   	if (xlat_func)
> -		rc = ata_scsi_translate(dev, scmd, xlat_func);
> -	else
> -		ata_scsi_simulate(dev, scmd);
> +		return ata_scsi_translate(dev, scmd, xlat_func);
> 
> -	return rc;
> +	ata_scsi_simulate(dev, scmd);
> +
> +	return 0;
> 
>    bad_cdb_len:
>   	scmd->result = DID_ERROR << 16;
> 
> Do you see any problem with this change ?
> 

This change looks good to me. Should I include this change in next 
patch? Or you would do this by youself?
