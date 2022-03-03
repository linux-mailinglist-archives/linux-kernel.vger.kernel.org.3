Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C14CC2ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiCCQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiCCQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:37:20 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8F19D628
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646325393; x=1677861393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=osewmkWarZIdeq2RkCL8AI1IGAFZUgV8uvvvxQblAtM=;
  b=PkUcwsJCL+VkB5fZ0DrIXfFd4q94jhxmPD95FF6MGY/v+jx0NXGvLat3
   k4nf7FYCEKtjHj2koF87p8/EQjNNZXBcXwTpNWoncZjrX3z/nWwWryatT
   Npge19vSK/JWCFKmLEFEND9jZPY9c+GUZZ9Ia1Lc8b7vuISk8qEZp9pQW
   hkLF8uW6C0C+i83b4B1LRbomS12tRMKnlMtweahHX1rx7kRTJDSdhYRo1
   v86jmZhYfFnSpO9nRfJQnaXpZvms3Ghg/Gd/G7aXm90NhACLdAWTc0ARR
   F5DCS1dDg4NcsQkDgEXosQDYju7u4oGkP18c0KG5wCU3b6gbIa4UJIbJg
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="199245008"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 00:36:31 +0800
IronPort-SDR: fYMgs5m1iOuSH5/8Yz8zPM9rft7aTuOpUOZIp73qaXUhTYS2aPFYixfHvNAdboIkAEqBFnbYzf
 NdvtpNbvA1jZ3T2YzUG5hWgNpQ1hqXbIClFs2MZUtC5UePDIEfZTQe2nKRY3nhlPb4p5Me1spU
 stfKnc7l0xdBvxJxJyXb6FqNFlRC0iu3WEjnU76funD3V46cJ05U6vy6LDVy+uz9OrlXKOeIXM
 qm9x1gwZOI+YhQfeP0PWqznAZ7fN7wjaILvXmFPdYRT03Pq/aR6dq9rh5fJIOUBf4KusyzcfqJ
 fcntFu0RL+neNkDD4R5s0drz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:07:53 -0800
IronPort-SDR: yVbyJvrX78VisiOOleM+Amr3uVpOQZylx4R0tS/iXJxpXo7DlRKLG7YYv33Ty0xtM727kQieDB
 WkscpsC6F0Di4lQp5cQic6K2UZcn+5tCYgdTs7XzbiK7wMKfdfEEc5gw/gQLOGWAvVfZconv82
 gTodkSLkZqyfuEo/nzN0lk0KpMwlgUdwD0VQNdNrDaJe4vv/rjTYAYVsSoYVYDje6PYcXq42w/
 BkIQPLZwJmpzZB/2dt5S9iuN1NTRBgJzELYaSkFEaQOxbwXZhqcO95HDY5sPcz9LseBRLdAHNS
 PuQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:36:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8c7f6hwGz1SVp5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:36:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646325388; x=1648917389; bh=osewmkWarZIdeq2RkCL8AI1IGAFZUgV8uvv
        vxQblAtM=; b=XTYGfc7UcHEGoYvo/Ng2DDnYKuF7fba5mF8CNVhPtfagMPZ/FnK
        z40LkVt+jV6Lm18pUaOEoJLNDqZsCwsxh44/fkntEsPcBwmL+NHppLUz4FOO0uF1
        MCkulM5DkY+GfDRolIVTvE4WgMkDhZoO5ixR6UnTemfYGoj3O0gKcLQhKnvi4mq8
        o4vlnXxbzxAY1uUQsj2Zl56VqYFZKXbc3N0HhC3o44Dny5iRLhLJBLApC4S54k95
        qQobcA6HekxVrYFkLqEqLfLEodMw4TgbA2eTQMHLUliRhAb3iZjYUXO7kV00uKpZ
        QxSpRpJeXQPp8SVao3iyLpEMj77LyBa9QHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id odIF0JrTWnQb for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 08:36:28 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8c7X64lgz1Rvlx;
        Thu,  3 Mar 2022 08:36:24 -0800 (PST)
Message-ID: <85a33515-043d-00f4-3bd3-ecb9a1349a68@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 18:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] scsi: pm8001: Use libsas internal abort support
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1646309930-138960-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/03 14:18, John Garry wrote:
> New special handling is added for SAS_PROTOCOL_INTERNAL_ABORT proto so that
> we may use the common queue command API.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c |  27 +++--
>  drivers/scsi/pm8001/pm8001_hwi.h |   5 -
>  drivers/scsi/pm8001/pm8001_sas.c | 186 +++++++++++--------------------
>  drivers/scsi/pm8001/pm8001_sas.h |   6 +-
>  drivers/scsi/pm8001/pm80xx_hwi.h |   5 -
>  5 files changed, 82 insertions(+), 147 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 048ff41852c9..84402a9dddbf 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4477,22 +4477,25 @@ pm8001_chip_isr(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  }
>  
>  static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
> -	u32 dev_id, u8 flag, u32 task_tag, u32 cmd_tag)
> +	u32 dev_id, enum sas_internal_abort type, u32 task_tag, u32 cmd_tag)
>  {
>  	struct task_abort_req task_abort;
>  
>  	memset(&task_abort, 0, sizeof(task_abort));
> -	if (ABORT_SINGLE == (flag & ABORT_MASK)) {
> +	if (type == SAS_INTERNAL_ABORT_SINGLE) {
>  		task_abort.abort_all = 0;
>  		task_abort.device_id = cpu_to_le32(dev_id);
>  		task_abort.tag_to_abort = cpu_to_le32(task_tag);
> -		task_abort.tag = cpu_to_le32(cmd_tag);
> -	} else if (ABORT_ALL == (flag & ABORT_MASK)) {
> +	} else if (type == SAS_INTERNAL_ABORT_DEV) {
>  		task_abort.abort_all = cpu_to_le32(1);
>  		task_abort.device_id = cpu_to_le32(dev_id);
> -		task_abort.tag = cpu_to_le32(cmd_tag);
> +	} else {
> +		pm8001_dbg(pm8001_ha, EH, "unknown type (%d)\n", type);
> +		return -EIO;
>  	}
>  
> +	task_abort.tag = cpu_to_le32(cmd_tag);
> +
>  	return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
>  				    sizeof(task_abort), 0);
>  }
> @@ -4501,12 +4504,16 @@ static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
>   * pm8001_chip_abort_task - SAS abort task when error or exception happened.
>   */
>  int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
> -	struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag, u32 cmd_tag)
> +	struct pm8001_ccb_info *ccb)
>  {
> -	u32 opc, device_id;
> +	struct sas_task *task = ccb->task;
> +	struct sas_internal_abort_task *abort = &task->abort_task;
> +	struct pm8001_device *pm8001_dev = ccb->device;
>  	int rc = TMF_RESP_FUNC_FAILED;
> +	u32 opc, device_id;
> +
>  	pm8001_dbg(pm8001_ha, EH, "cmd_tag = %x, abort task tag = 0x%x\n",
> -		   cmd_tag, task_tag);
> +		   ccb->ccb_tag, abort->tag);
>  	if (pm8001_dev->dev_type == SAS_END_DEVICE)
>  		opc = OPC_INB_SSP_ABORT;
>  	else if (pm8001_dev->dev_type == SAS_SATA_DEV)
> @@ -4514,8 +4521,8 @@ int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
>  	else
>  		opc = OPC_INB_SMP_ABORT;/* SMP */
>  	device_id = pm8001_dev->device_id;
> -	rc = send_task_abort(pm8001_ha, opc, device_id, flag,
> -		task_tag, cmd_tag);
> +	rc = send_task_abort(pm8001_ha, opc, device_id, abort->type,
> +		abort->tag, ccb->ccb_tag);

Nit: Can you indent this together with "(" ? I find it easier to read :)

>  	if (rc != TMF_RESP_FUNC_COMPLETE)
>  		pm8001_dbg(pm8001_ha, EH, "rc= %d\n", rc);
>  	return rc;
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm8001_hwi.h
> index d1f3aa93325b..961d0465b923 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.h
> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
> @@ -434,11 +434,6 @@ struct task_abort_req {
>  	u32	reserved[11];
>  } __attribute__((packed, aligned(4)));
>  
> -/* These flags used for SSP SMP & SATA Abort */
> -#define ABORT_MASK		0x3
> -#define ABORT_SINGLE		0x0
> -#define ABORT_ALL		0x1
> -
>  /**
>   * brief the data structure of SSP SATA SMP Abort Response
>   * use to describe SSP SMP & SATA Abort Response ( 64 bytes)
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index ac9c40c95070..d1224674173e 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -324,6 +324,18 @@ static int pm8001_task_prep_ata(struct pm8001_hba_info *pm8001_ha,
>  	return PM8001_CHIP_DISP->sata_req(pm8001_ha, ccb);
>  }
>  
> +/**
> +  * pm8001_task_prep_internal_abort - the dispatcher function, prepare data
> +  *				      for internal abort task
> +  * @pm8001_ha: our hba card information
> +  * @ccb: the ccb which attached to sata task
> +  */
> +static int pm8001_task_prep_internal_abort(struct pm8001_hba_info *pm8001_ha,
> +					   struct pm8001_ccb_info *ccb)
> +{
> +	return PM8001_CHIP_DISP->task_abort(pm8001_ha, ccb);
> +}
> +
>  /**
>    * pm8001_task_prep_ssp_tm - the dispatcher function, prepare task management data
>    * @pm8001_ha: our hba card information
> @@ -367,6 +379,43 @@ static int sas_find_local_port_id(struct domain_device *dev)
>  #define DEV_IS_GONE(pm8001_dev)	\
>  	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
>  
> +
> +static int pm8001_deliver_command(struct pm8001_hba_info *pm8001_ha,
> +				  struct pm8001_ccb_info *ccb)
> +{
> +	struct sas_task *task = ccb->task;
> +	enum sas_protocol task_proto = task->task_proto;
> +	struct sas_tmf_task *tmf = task->tmf;
> +	int is_tmf = !!tmf;
> +	int rc;
> +
> +	switch (task_proto) {
> +	case SAS_PROTOCOL_SMP:
> +		rc = pm8001_task_prep_smp(pm8001_ha, ccb);
> +		break;
> +	case SAS_PROTOCOL_SSP:
> +		if (is_tmf)
> +			rc = pm8001_task_prep_ssp_tm(pm8001_ha, ccb, tmf);
> +		else
> +			rc = pm8001_task_prep_ssp(pm8001_ha, ccb);
> +		break;
> +	case SAS_PROTOCOL_SATA:
> +	case SAS_PROTOCOL_STP:
> +		rc = pm8001_task_prep_ata(pm8001_ha, ccb);
> +		break;
> +	case SAS_PROTOCOL_INTERNAL_ABORT:
> +		rc = pm8001_task_prep_internal_abort(pm8001_ha, ccb);
> +		break;
> +	default:
> +		dev_err(pm8001_ha->dev, "unknown sas_task proto: 0x%x\n",
> +			task_proto);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;

rc variable is not very useful here. Why not use return directly for each case ?

> +}
> +
>  /**
>    * pm8001_queue_command - register for upper layer used, all IO commands sent
>    * to HBA are from this interface.
> @@ -379,16 +428,15 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  	enum sas_protocol task_proto = task->task_proto;
>  	struct domain_device *dev = task->dev;
>  	struct pm8001_device *pm8001_dev = dev->lldd_dev;
> +	bool internal_abort = sas_is_internal_abort(task);
>  	struct pm8001_hba_info *pm8001_ha;
>  	struct pm8001_port *port = NULL;
>  	struct pm8001_ccb_info *ccb;
> -	struct sas_tmf_task *tmf = task->tmf;
> -	int is_tmf = !!task->tmf;
>  	unsigned long flags;
>  	u32 n_elem = 0;
>  	int rc = 0;
>  
> -	if (!dev->port) {
> +	if (!internal_abort && !dev->port) {
>  		ts->resp = SAS_TASK_UNDELIVERED;
>  		ts->stat = SAS_PHY_DOWN;
>  		if (dev->dev_type != SAS_SATA_DEV)
> @@ -410,7 +458,8 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  	pm8001_dev = dev->lldd_dev;
>  	port = &pm8001_ha->port[sas_find_local_port_id(dev)];
>  
> -	if (DEV_IS_GONE(pm8001_dev) || !port->port_attached) {
> +	if (!internal_abort && (DEV_IS_GONE(pm8001_dev) ||
> +				!port->port_attached)) {

Wrapping the line after "&&" would make this a lot cleaner and easier to read.

>  		ts->resp = SAS_TASK_UNDELIVERED;
>  		ts->stat = SAS_PHY_DOWN;
>  		if (sas_protocol_ata(task_proto)) {
> @@ -448,27 +497,7 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  
>  	atomic_inc(&pm8001_dev->running_req);
>  
> -	switch (task_proto) {
> -	case SAS_PROTOCOL_SMP:
> -		rc = pm8001_task_prep_smp(pm8001_ha, ccb);
> -		break;
> -	case SAS_PROTOCOL_SSP:
> -		if (is_tmf)
> -			rc = pm8001_task_prep_ssp_tm(pm8001_ha, ccb, tmf);
> -		else
> -			rc = pm8001_task_prep_ssp(pm8001_ha, ccb);
> -		break;
> -	case SAS_PROTOCOL_SATA:
> -	case SAS_PROTOCOL_STP:
> -		rc = pm8001_task_prep_ata(pm8001_ha, ccb);
> -		break;
> -	default:
> -		dev_printk(KERN_ERR, pm8001_ha->dev,
> -			   "unknown sas_task proto: 0x%x\n", task_proto);
> -		rc = -EINVAL;
> -		break;
> -	}
> -
> +	rc = pm8001_deliver_command(pm8001_ha, ccb);
>  	if (rc) {
>  		atomic_dec(&pm8001_dev->running_req);
>  		if (!sas_protocol_ata(task_proto) && n_elem)
> @@ -668,87 +697,7 @@ void pm8001_task_done(struct sas_task *task)
>  	complete(&task->slow_task->completion);
>  }
>  
> -static void pm8001_tmf_timedout(struct timer_list *t)
> -{
> -	struct sas_task_slow *slow = from_timer(slow, t, timer);
> -	struct sas_task *task = slow->task;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&task->task_state_lock, flags);
> -	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
> -		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
> -		complete(&task->slow_task->completion);
> -	}
> -	spin_unlock_irqrestore(&task->task_state_lock, flags);
> -}
> -
>  #define PM8001_TASK_TIMEOUT 20
> -static int
> -pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
> -	struct pm8001_device *pm8001_dev, struct domain_device *dev, u32 flag,
> -	u32 task_tag)
> -{
> -	int res, retry;
> -	struct pm8001_ccb_info *ccb;
> -	struct sas_task *task = NULL;
> -
> -	for (retry = 0; retry < 3; retry++) {
> -		task = sas_alloc_slow_task(GFP_KERNEL);
> -		if (!task)
> -			return -ENOMEM;
> -
> -		task->dev = dev;
> -		task->task_proto = dev->tproto;
> -		task->task_done = pm8001_task_done;
> -		task->slow_task->timer.function = pm8001_tmf_timedout;
> -		task->slow_task->timer.expires =
> -			jiffies + PM8001_TASK_TIMEOUT * HZ;
> -		add_timer(&task->slow_task->timer);
> -
> -		ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
> -		if (!ccb) {
> -			res = -SAS_QUEUE_FULL;
> -			break;
> -		}
> -
> -		res = PM8001_CHIP_DISP->task_abort(pm8001_ha, pm8001_dev, flag,
> -						   task_tag, ccb->ccb_tag);
> -		if (res) {
> -			del_timer(&task->slow_task->timer);
> -			pm8001_dbg(pm8001_ha, FAIL,
> -				   "Executing internal task failed\n");
> -			pm8001_ccb_free(pm8001_ha, ccb);
> -			break;
> -		}
> -
> -		wait_for_completion(&task->slow_task->completion);
> -		res = TMF_RESP_FUNC_FAILED;
> -
> -		/* Even TMF timed out, return direct. */
> -		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
> -			pm8001_dbg(pm8001_ha, FAIL, "TMF task timeout.\n");
> -			break;
> -		}
> -
> -		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> -			task->task_status.stat == SAS_SAM_STAT_GOOD) {
> -			res = TMF_RESP_FUNC_COMPLETE;
> -			break;
> -		}
> -
> -		pm8001_dbg(pm8001_ha, EH,
> -			   " Task to dev %016llx response: 0x%x status 0x%x\n",
> -			   SAS_ADDR(dev->sas_addr),
> -			   task->task_status.resp,
> -			   task->task_status.stat);
> -		sas_free_task(task);
> -		task = NULL;
> -	}
> -
> -	BUG_ON(retry == 3 && task != NULL);
> -	sas_free_task(task);
> -	return res;
> -}
>  
>  /**
>    * pm8001_dev_gone_notify - see the comments for "pm8001_dev_found_notify"
> @@ -769,8 +718,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
>  			   pm8001_dev->device_id, pm8001_dev->dev_type);
>  		if (atomic_read(&pm8001_dev->running_req)) {
>  			spin_unlock_irqrestore(&pm8001_ha->lock, flags);
> -			pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -							dev, 1, 0);
> +			sas_execute_internal_abort_dev(dev, 0, NULL);
>  			while (atomic_read(&pm8001_dev->running_req))
>  				msleep(20);
>  			spin_lock_irqsave(&pm8001_ha->lock, flags);
> @@ -893,8 +841,7 @@ int pm8001_I_T_nexus_reset(struct domain_device *dev)
>  			goto out;
>  		}
>  		msleep(2000);
> -		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -						     dev, 1, 0);
> +		rc = sas_execute_internal_abort_dev(dev, 0, NULL);
>  		if (rc) {
>  			pm8001_dbg(pm8001_ha, EH, "task abort failed %x\n"
>  				   "with rc %d\n", pm8001_dev->device_id, rc);
> @@ -939,8 +886,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
>  			goto out;
>  		}
>  		/* send internal ssp/sata/smp abort command to FW */
> -		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -						     dev, 1, 0);
> +		sas_execute_internal_abort_dev(dev, 0, NULL);
>  		msleep(100);
>  
>  		/* deregister the target device */
> @@ -955,8 +901,7 @@ int pm8001_I_T_nexus_event_handler(struct domain_device *dev)
>  		wait_for_completion(&completion_setstate);
>  	} else {
>  		/* send internal ssp/sata/smp abort command to FW */
> -		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -						     dev, 1, 0);
> +		sas_execute_internal_abort_dev(dev, 0, NULL);
>  		msleep(100);
>  
>  		/* deregister the target device */
> @@ -983,8 +928,7 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
>  	DECLARE_COMPLETION_ONSTACK(completion_setstate);
>  	if (dev_is_sata(dev)) {
>  		struct sas_phy *phy = sas_get_local_phy(dev);
> -		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -						     dev, 1, 0);
> +		sas_execute_internal_abort_dev(dev, 0, NULL);
>  		rc = sas_phy_reset(phy, 1);
>  		sas_put_local_phy(phy);
>  		pm8001_dev->setds_completion = &completion_setstate;
> @@ -1084,8 +1028,7 @@ int pm8001_abort_task(struct sas_task *task)
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
>  	if (task->task_proto & SAS_PROTOCOL_SSP) {
>  		rc = sas_abort_task(task, tag);
> -		pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -			pm8001_dev->sas_device, 0, tag);
> +		sas_execute_internal_abort_single(dev, tag, 0, NULL);
>  	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
>  		task->task_proto & SAS_PROTOCOL_STP) {
>  		if (pm8001_ha->chip_id == chip_8006) {
> @@ -1158,8 +1101,7 @@ int pm8001_abort_task(struct sas_task *task)
>  			 * is removed from the ccb. on success the caller is
>  			 * going to free the task.
>  			 */
> -			ret = pm8001_exec_internal_task_abort(pm8001_ha,
> -				pm8001_dev, pm8001_dev->sas_device, 1, tag);
> +			ret = sas_execute_internal_abort_dev(dev, 0, NULL);
>  			if (ret)
>  				goto out;
>  			ret = wait_for_completion_timeout(
> @@ -1175,14 +1117,12 @@ int pm8001_abort_task(struct sas_task *task)
>  				pm8001_dev, DS_OPERATIONAL);
>  			wait_for_completion(&completion);
>  		} else {
> -			rc = pm8001_exec_internal_task_abort(pm8001_ha,
> -				pm8001_dev, pm8001_dev->sas_device, 0, tag);
> +			ret = sas_execute_internal_abort_single(dev, tag, 0, NULL);
>  		}
>  		rc = TMF_RESP_FUNC_COMPLETE;
>  	} else if (task->task_proto & SAS_PROTOCOL_SMP) {
>  		/* SMP */
> -		rc = pm8001_exec_internal_task_abort(pm8001_ha, pm8001_dev,
> -			pm8001_dev->sas_device, 0, tag);
> +		rc = sas_execute_internal_abort_single(dev, tag, 0, NULL);
>  
>  	}
>  out:
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index d522bd0bb46b..060ab680a7ed 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -196,8 +196,7 @@ struct pm8001_dispatch {
>  	int (*phy_ctl_req)(struct pm8001_hba_info *pm8001_ha,
>  		u32 phy_id, u32 phy_op);
>  	int (*task_abort)(struct pm8001_hba_info *pm8001_ha,
> -		struct pm8001_device *pm8001_dev, u8 flag, u32 task_tag,
> -		u32 cmd_tag);
> +		struct pm8001_ccb_info *ccb);
>  	int (*ssp_tm_req)(struct pm8001_hba_info *pm8001_ha,
>  		struct pm8001_ccb_info *ccb, struct sas_tmf_task *tmf);
>  	int (*get_nvmd_req)(struct pm8001_hba_info *pm8001_ha, void *payload);
> @@ -683,8 +682,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
>  				struct pm8001_ccb_info *ccb,
>  				struct sas_tmf_task *tmf);
>  int pm8001_chip_abort_task(struct pm8001_hba_info *pm8001_ha,
> -				struct pm8001_device *pm8001_dev,
> -				u8 flag, u32 task_tag, u32 cmd_tag);
> +				struct pm8001_ccb_info *ccb);
>  int pm8001_chip_dereg_dev_req(struct pm8001_hba_info *pm8001_ha, u32 device_id);
>  void pm8001_chip_make_sg(struct scatterlist *scatter, int nr, void *prd);
>  void pm8001_work_fn(struct work_struct *work);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
> index b9d9d113809b..acf6e3005b84 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -672,11 +672,6 @@ struct task_abort_req {
>  	u32	reserved[27];
>  } __attribute__((packed, aligned(4)));
>  
> -/* These flags used for SSP SMP & SATA Abort */
> -#define ABORT_MASK		0x3
> -#define ABORT_SINGLE		0x0
> -#define ABORT_ALL		0x1
> -
>  /**
>   * brief the data structure of SSP SATA SMP Abort Response
>   * use to describe SSP SMP & SATA Abort Response ( 64 bytes)


-- 
Damien Le Moal
Western Digital Research
