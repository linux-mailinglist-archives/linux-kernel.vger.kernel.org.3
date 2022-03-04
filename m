Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBC4CD174
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbiCDJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiCDJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:42:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A061606FF;
        Fri,  4 Mar 2022 01:41:21 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K92rg2vJdz67tXN;
        Fri,  4 Mar 2022 17:40:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 10:41:19 +0100
Received: from [10.47.95.117] (10.47.95.117) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 09:41:17 +0000
Message-ID: <966a1048-cd14-d796-8b9d-734605796652@huawei.com>
Date:   Fri, 4 Mar 2022 09:41:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/4] scsi: pm8001: Use libsas internal abort support
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Ajish.Koshy@microchip.com>, <linuxarm@huawei.com>,
        <Viswas.G@microchip.com>, <hch@lst.de>, <liuqi115@huawei.com>,
        <chenxiang66@hisilicon.com>
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-4-git-send-email-john.garry@huawei.com>
 <85a33515-043d-00f4-3bd3-ecb9a1349a68@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <85a33515-043d-00f4-3bd3-ecb9a1349a68@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.117]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 16:36, Damien Le Moal wrote:
>> -	rc = send_task_abort(pm8001_ha, opc, device_id, flag,
>> -		task_tag, cmd_tag);
>> +	rc = send_task_abort(pm8001_ha, opc, device_id, abort->type,
>> +		abort->tag, ccb->ccb_tag);
> Nit: Can you indent this together with "(" ? I find it easier to read:)

ok, I can align it.

> 
>>   	if (rc != TMF_RESP_FUNC_COMPLETE)
>>   		pm8001_dbg(pm8001_ha, EH, "rc= %d\n", rc);
>>   	return rc;
>> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
>> index d1f3aa93325b..961d0465b923 100644
>> --- a/drivers/scsi/pm8001/pm8001_hwi.h
>> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
>> @@ -434,11 +434,6 @@ struct task_abort_req {
>>   	u32	reserved[11];
>>   } __attribute__((packed, aligned(4)));
>>   
>> -/* These flags used for SSP SMP & SATA Abort */
>> -#define ABORT_MASK		0x3
>> -#define ABORT_SINGLE		0x0
>> -#define ABORT_ALL		0x1
>> -
>>   /**
>>    * brief the data structure of SSP SATA SMP Abort Response
>>    * use to describe SSP SMP & SATA Abort Response ( 64 bytes)
>> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
>> index ac9c40c95070..d1224674173e 100644
>> --- a/drivers/scsi/pm8001/pm8001_sas.c
>> +++ b/drivers/scsi/pm8001/pm8001_sas.c
>> @@ -324,6 +324,18 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
>>   	return PM8001_CHIP_DISP->sata_req(pm8001_ha, ccb);
>>   }
>>   
>> +/**
>> +  * pm8001_task_prep_internal_abort - the dispatcher function, prepare data
>> +  *				      for internal abort task
>> +  * @pm8001_ha: our hba card information
>> +  * @ccb: the ccb which attached to sata task
>> +  */
>> +static int pm8001_task_prep_internal_abort(struct pm8001_hba_info *pm8001_ha,
>> +					   struct pm8001_ccb_info *ccb)
>> +{
>> +	return PM8001_CHIP_DISP->task_abort(pm8001_ha, ccb);
>> +}
>> +
>>   /**
>>     * pm8001_task_prep_ssp_tm - the dispatcher function, prepare task management data
>>     * @pm8001_ha: our hba card information
>> @@ -367,6 +379,43 @@ static int sas_find_local_port_id(struct domain_device *dev)
>>   #define DEV_IS_GONE(pm8001_dev)	\
>>   	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
>>   
>> +
>> +static int pm8001_deliver_command(struct pm8001_hba_info *pm8001_ha,
>> +				  struct pm8001_ccb_info *ccb)
>> +{
>> +	struct sas_task *task = ccb->task;
>> +	enum sas_protocol task_proto = task->task_proto;
>> +	struct sas_tmf_task *tmf = task->tmf;
>> +	int is_tmf = !!tmf;
>> +	int rc;
>> +
>> +	switch (task_proto) {
>> +	case SAS_PROTOCOL_SMP:
>> +		rc = pm8001_task_prep_smp(pm8001_ha, ccb);
>> +		break;
>> +	case SAS_PROTOCOL_SSP:
>> +		if (is_tmf)
>> +			rc = pm8001_task_prep_ssp_tm(pm8001_ha, ccb, tmf);
>> +		else
>> +			rc = pm8001_task_prep_ssp(pm8001_ha, ccb);
>> +		break;
>> +	case SAS_PROTOCOL_SATA:
>> +	case SAS_PROTOCOL_STP:
>> +		rc = pm8001_task_prep_ata(pm8001_ha, ccb);
>> +		break;
>> +	case SAS_PROTOCOL_INTERNAL_ABORT:
>> +		rc = pm8001_task_prep_internal_abort(pm8001_ha, ccb);
>> +		break;
>> +	default:
>> +		dev_err(pm8001_ha->dev, "unknown sas_task proto: 0x%x\n",
>> +			task_proto);
>> +		rc = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return rc;
> rc variable is not very useful here. Why not use return directly for each case ?


ok, I can make that change.

> 
>> +}
>> +
>>   /**
>>     * pm8001_queue_command - register for upper layer used, all IO commands sent
>>     * to HBA are from this interface.
>> @@ -379,16 +428,15 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>   	enum sas_protocol task_proto = task->task_proto;
>>   	struct domain_device *dev = task->dev;
>>   	struct pm8001_device *pm8001_dev = dev->lldd_dev;
>> +	bool internal_abort = sas_is_internal_abort(task);
>>   	struct pm8001_hba_info *pm8001_ha;
>>   	struct pm8001_port *port = NULL;
>>   	struct pm8001_ccb_info *ccb;
>> -	struct sas_tmf_task *tmf = task->tmf;
>> -	int is_tmf = !!task->tmf;
>>   	unsigned long flags;
>>   	u32 n_elem = 0;
>>   	int rc = 0;
>>   
>> -	if (!dev->port) {
>> +	if (!internal_abort && !dev->port) {
>>   		ts->resp = SAS_TASK_UNDELIVERED;
>>   		ts->stat = SAS_PHY_DOWN;
>>   		if (dev->dev_type != SAS_SATA_DEV)
>> @@ -410,7 +458,8 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>   	pm8001_dev = dev->lldd_dev;
>>   	port = &pm8001_ha->port[sas_find_local_port_id(dev)];
>>   
>> -	if (DEV_IS_GONE(pm8001_dev) || !port->port_attached) {
>> +	if (!internal_abort && (DEV_IS_GONE(pm8001_dev) ||
>> +				!port->port_attached)) {
> Wrapping the line after "&&" would make this a lot cleaner and easier to read.

Agreed, I can do it.

But if you can see any neater ways to skip these checks for internal 
abort in the common queue command path then I would be glad to hear it.

> 
>>   		ts->resp = SAS_TASK_UNDELIVERED;
>>   		ts->stat = SAS_PHY_DOWN;
>>   		if (sas_protocol_ata(task_proto)) {
>> @@ -448,27 +497,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>>   
Thanks,
John
