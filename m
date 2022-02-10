Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33984B0CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiBJLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:46:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiBJLqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:46:14 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C963A1028
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644493574; x=1676029574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nNT+6etgfHwRrPexkq71I3atfas3j0CphXtZr7HVBUU=;
  b=hMYP5oD6LFx+ZzjtLeK9pOPSHrm2ZUkah+z8ihqjWVvmu+VrfADMGzC3
   PGRXxfhrasDzlBEvnN8ZcsuBSJbY3SZmR+84UTsV/9K1JYkSCPWv5kmED
   UCCs67lv9ntRM9MmFC7GsLfaAF8c65nIPQdWl+6Sys1SxwHv5TkQlcxPg
   yc4nhpzOATsOMWEISJ+WrQc82zN1BzzoSOocZj07+twm318+qm1HrgBrV
   U2admv3x7Zcvw3SjUdPFAbwj2zJQyWK8CCC406S4pMKxMdlETP1PAX8FA
   RIPTaMJmkcxAddX2j9jNBy86ymlpze0TwylNSMHqTd28WN50/88mVOcU2
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="192592748"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 19:46:13 +0800
IronPort-SDR: VDcBEhxhSIhiCMLIwNThdnHcNknRz9l6e6wm9g0H1xNd/XPh/LG8qYqZYBajR3Tgp6dV7HBZmo
 VePNR9KoSg7s4yEwlJ+1ITI1BkPaBOoPCQJEAGGp68fuRC16bCJvZEEUXF4mms4zBOGrVS3XHy
 AaNRP0nmgk2AjsBKUCQ9ucx72Edy+I0FyS2gQJ4WN0JtsO2EADI6x7EoqO3hwTSa9Ve9DwXW0w
 DOlo0urnalGdCucwxEnVWHgUEYt8Zfjf84xtwarfkb9+1ATsO1YmnP+a0z+G+t8r3wmNDYwpkb
 HSi/e6wqOrSWYj37nYMNL+YS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:18:01 -0800
IronPort-SDR: GXCltpNGWQJBwVWVYJAFF6JCYkB/HOXeUmSWLuy6XvOrHCJlk5Rm08CwJXDpMxaoB8/RzJUbvQ
 hrTzVp16uHIZz9KvVzobSVDy9HTbjlL7Ex2koqN9OSyWz/xVtmR7svwghRihsb91pUqAeQfcKA
 H1kaJizbEANiN/s02KV0K8ae9NAAjLNw+X7MQ+EWxiFISWpBH8AcYEw+lvGKRjVzxC6XnqloUI
 qip74//A7UtvkaQxw2GgREchhgsWrJsT2z/FHwyDjcVLi8oriModta3rYr3JE70gnhzDEya7J5
 bIc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:46:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JvZhP2BSmz1SVp4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:46:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644493571; x=1647085572; bh=nNT+6etgfHwRrPexkq71I3atfas3j0CphXt
        Zr7HVBUU=; b=MYMsHTPM3LPvNE2Lue1PVkMWc1slxm2fJQ0z/At+uh4n7H7AQ92
        9q3o6hVJ4/TdV7VqFlwNuiDnRCpDJBTx6P/wfArbkvPgnnWfHoRfhK5CyIAgThmz
        5dV0ZJhv63ejZzEXuusgz7MV8XiLCgBG5WUWZ9l8bSp6jSpkFzcEposnqnHphZZd
        0EE3BMJ9Z+tuQ/l/DcKRJIhh86jMCWdToExXk7KKmKwlmPWn8aSaR0yDQTCKe5U8
        lpX6VewwB6g/893qaqas2cQoFy9nL8E7NVGprEp8dIvZHYQvob+6BX1Cgfi4Wg3H
        P29QVlZiHoZyMSeq05HeyFdx+Z88m6rhG3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jUkGtfGSKv5L for <linux-kernel@vger.kernel.org>;
        Thu, 10 Feb 2022 03:46:11 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JvZhK2nL6z1Rwrw;
        Thu, 10 Feb 2022 03:46:09 -0800 (PST)
Message-ID: <09d01980-aedf-f62b-4729-2a30c422cf63@opensource.wdc.com>
Date:   Thu, 10 Feb 2022 20:46:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] scsi: libsas: Drop SAS_TASK_AT_INITIATOR
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, artur.paszkiewicz@intel.com,
        jinpu.wang@cloud.ionos.com
Cc:     chenxiang66@hisilicon.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com, hch@lst.de
References: <1644489804-85730-1-git-send-email-john.garry@huawei.com>
 <1644489804-85730-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1644489804-85730-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 19:43, John Garry wrote:
> This flag is now only ever set, so delete it.
> 
> This also avoids a use-after-free in the pm8001 queue path, as reported
> in the following:
> https://lore.kernel.org/linux-scsi/c3cb7228-254e-9584-182b-007ac5e6fe0a@huawei.com/T/#m28c94c6d3ff582ec4a9fa54819180740e8bd4cfb
> https://lore.kernel.org/linux-scsi/0cc0c435-b4f2-9c76-258d-865ba50a29dd@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

No mor use-after-free, finally :)

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

> ---
>  drivers/scsi/aic94xx/aic94xx_task.c    |  9 ---------
>  drivers/scsi/hisi_sas/hisi_sas_main.c  |  8 +-------
>  drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  3 +--
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  3 +--
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  3 +--
>  drivers/scsi/isci/request.c            |  3 +--
>  drivers/scsi/isci/task.c               | 10 +++-------
>  drivers/scsi/mvsas/mv_sas.c            |  6 +-----
>  drivers/scsi/pm8001/pm8001_hwi.c       |  7 -------
>  drivers/scsi/pm8001/pm8001_sas.c       |  4 ----
>  drivers/scsi/pm8001/pm80xx_hwi.c       |  5 -----
>  include/scsi/libsas.h                  |  1 -
>  12 files changed, 9 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
> index c6b63eae28f5..ed119a3f6f2e 100644
> --- a/drivers/scsi/aic94xx/aic94xx_task.c
> +++ b/drivers/scsi/aic94xx/aic94xx_task.c
> @@ -322,7 +322,6 @@ static void asd_task_tasklet_complete(struct asd_ascb *ascb,
>  
>  	spin_lock_irqsave(&task->task_state_lock, flags);
>  	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	task->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((task->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		struct completion *completion = ascb->completion;
> @@ -532,7 +531,6 @@ int asd_execute_task(struct sas_task *task, gfp_t gfp_flags)
>  	struct sas_task *t = task;
>  	struct asd_ascb *ascb = NULL, *a;
>  	struct asd_ha_struct *asd_ha = task->dev->port->ha->lldd_ha;
> -	unsigned long flags;
>  
>  	res = asd_can_queue(asd_ha, 1);
>  	if (res)
> @@ -575,10 +573,6 @@ int asd_execute_task(struct sas_task *task, gfp_t gfp_flags)
>  		}
>  		if (res)
>  			goto out_err_unmap;
> -
> -		spin_lock_irqsave(&t->task_state_lock, flags);
> -		t->task_state_flags |= SAS_TASK_AT_INITIATOR;
> -		spin_unlock_irqrestore(&t->task_state_lock, flags);
>  	}
>  	list_del_init(&alist);
>  
> @@ -597,9 +591,6 @@ int asd_execute_task(struct sas_task *task, gfp_t gfp_flags)
>  			if (a == b)
>  				break;
>  			t = a->uldd_task;
> -			spin_lock_irqsave(&t->task_state_lock, flags);
> -			t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
> -			spin_unlock_irqrestore(&t->task_state_lock, flags);
>  			switch (t->task_proto) {
>  			case SAS_PROTOCOL_SATA:
>  			case SAS_PROTOCOL_STP:
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index ebf5ec38891b..1873707ca599 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -405,7 +405,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
>  	struct hisi_sas_cmd_hdr *cmd_hdr_base;
>  	int dlvry_queue_slot, dlvry_queue;
>  	struct sas_task *task = slot->task;
> -	unsigned long flags;
>  	int wr_q_index;
>  
>  	spin_lock(&dq->lock);
> @@ -457,10 +456,6 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
>  		break;
>  	}
>  
> -	spin_lock_irqsave(&task->task_state_lock, flags);
> -	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
> -	spin_unlock_irqrestore(&task->task_state_lock, flags);
> -
>  	WRITE_ONCE(slot->ready, 1);
>  
>  	spin_lock(&dq->lock);
> @@ -1035,8 +1030,7 @@ static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task
>  		ts->resp = SAS_TASK_COMPLETE;
>  		ts->stat = SAS_ABORTED_TASK;
>  		spin_lock_irqsave(&task->task_state_lock, flags);
> -		task->task_state_flags &=
> -			~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
> +		task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  		if (!slot->is_internal && task->task_proto != SAS_PROTOCOL_SMP)
>  			task->task_state_flags |= SAS_TASK_STATE_DONE;
>  		spin_unlock_irqrestore(&task->task_state_lock, flags);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index 3059d19e4368..6914e992a02e 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -1200,8 +1200,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
>  	sas_dev = device->lldd_dev;
>  
>  	spin_lock_irqsave(&task->task_state_lock, flags);
> -	task->task_state_flags &=
> -		~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
> +	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  	task->task_state_flags |= SAS_TASK_STATE_DONE;
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 64ed3e472e65..eaaf9e8b4ca4 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -2344,8 +2344,7 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
>  	sas_dev = device->lldd_dev;
>  
>  	spin_lock_irqsave(&task->task_state_lock, flags);
> -	task->task_state_flags &=
> -		~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
> +	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
>  	memset(ts, 0, sizeof(*ts));
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index a01a3a7b706b..52e306c1ece2 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -2217,8 +2217,7 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
>  	sas_dev = device->lldd_dev;
>  
>  	spin_lock_irqsave(&task->task_state_lock, flags);
> -	task->task_state_flags &=
> -		~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
> +	task->task_state_flags &= ~SAS_TASK_STATE_PENDING ;
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
>  	memset(ts, 0, sizeof(*ts));
> diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
> index b48ec64f745a..b45e4e81dd19 100644
> --- a/drivers/scsi/isci/request.c
> +++ b/drivers/scsi/isci/request.c
> @@ -2934,8 +2934,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
>  	if (test_bit(IREQ_COMPLETE_IN_TARGET, &request->flags)) {
>  		/* Normal notification (task_done) */
>  		task->task_state_flags |= SAS_TASK_STATE_DONE;
> -		task->task_state_flags &= ~(SAS_TASK_AT_INITIATOR |
> -					    SAS_TASK_STATE_PENDING);
> +		task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  	}
>  	spin_unlock_irqrestore(&task->task_state_lock, task_flags);
>  
> diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
> index 14738702d4c9..c82d07978532 100644
> --- a/drivers/scsi/isci/task.c
> +++ b/drivers/scsi/isci/task.c
> @@ -91,8 +91,7 @@ static void isci_task_refuse(struct isci_host *ihost, struct sas_task *task,
>  
>  	/* Normal notification (task_done) */
>  	task->task_state_flags |= SAS_TASK_STATE_DONE;
> -	task->task_state_flags &= ~(SAS_TASK_AT_INITIATOR |
> -				    SAS_TASK_STATE_PENDING);
> +	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  	task->lldd_task = NULL;
>  	spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
> @@ -164,7 +163,6 @@ int isci_task_execute_task(struct sas_task *task, gfp_t gfp_flags)
>  		} else {
>  			struct isci_request *ireq;
>  
> -			task->task_state_flags |= SAS_TASK_AT_INITIATOR;
>  			/* do common allocation and init of request object. */
>  			ireq = isci_io_request_from_tag(ihost, task, tag);
>  			spin_unlock_irqrestore(&task->task_state_lock, flags);
> @@ -531,8 +529,7 @@ int isci_task_abort_task(struct sas_task *task)
>  		*/
>  		spin_lock_irqsave(&task->task_state_lock, flags);
>  		task->task_state_flags |= SAS_TASK_STATE_DONE;
> -		task->task_state_flags &= ~(SAS_TASK_AT_INITIATOR |
> -					    SAS_TASK_STATE_PENDING);
> +		task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  		spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
>  		ret = TMF_RESP_FUNC_COMPLETE;
> @@ -580,8 +577,7 @@ int isci_task_abort_task(struct sas_task *task)
>  			 test_bit(IDEV_GONE, &idev->flags));
>  
>  		spin_lock_irqsave(&task->task_state_lock, flags);
> -		task->task_state_flags &= ~(SAS_TASK_AT_INITIATOR |
> -					    SAS_TASK_STATE_PENDING);
> +		task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  		task->task_state_flags |= SAS_TASK_STATE_DONE;
>  		spin_unlock_irqrestore(&task->task_state_lock, flags);
>  
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 1e52bc7febfa..a8d1f3dd607a 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -815,9 +815,6 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
>  	slot->port = tei.port;
>  	task->lldd_task = slot;
>  	list_add_tail(&slot->entry, &tei.port->list);
> -	spin_lock(&task->task_state_lock);
> -	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
> -	spin_unlock(&task->task_state_lock);
>  
>  	mvi_dev->running_req++;
>  	++(*pass);
> @@ -1721,8 +1718,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
>  	mvi_dev = dev->lldd_dev;
>  
>  	spin_lock(&task->task_state_lock);
> -	task->task_state_flags &=
> -		~(SAS_TASK_STATE_PENDING | SAS_TASK_AT_INITIATOR);
> +	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
>  	task->task_state_flags |= SAS_TASK_STATE_DONE;
>  	/* race condition*/
>  	aborted = task->task_state_flags & SAS_TASK_STATE_ABORTED;
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 9ec310b795c3..4683fee87b84 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1561,7 +1561,6 @@ void pm8001_work_fn(struct work_struct *work)
>  			atomic_dec(&pm8001_dev->running_req);
>  		spin_lock_irqsave(&t->task_state_lock, flags1);
>  		t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -		t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  		t->task_state_flags |= SAS_TASK_STATE_DONE;
>  		if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  			spin_unlock_irqrestore(&t->task_state_lock, flags1);
> @@ -2105,7 +2104,6 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  		   psspPayload->ssp_resp_iu.status);
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -2273,7 +2271,6 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -2665,7 +2662,6 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -3022,7 +3018,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -3696,7 +3691,6 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	spin_unlock_irqrestore(&t->task_state_lock, flags);
>  	pm8001_ccb_task_free(pm8001_ha, t, ccb, tag);
> @@ -4336,7 +4330,6 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>  			ts->resp = SAS_TASK_COMPLETE;
>  			ts->stat = SAS_SAM_STAT_GOOD;
>  			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  			task->task_state_flags |= SAS_TASK_STATE_DONE;
>  			if (unlikely((task->task_state_flags &
>  					SAS_TASK_STATE_ABORTED))) {
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 32edda3e55c6..8c12fbb9c476 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -487,9 +487,6 @@ static int pm8001_task_exec(struct sas_task *task,
>  			goto err_out_tag;
>  		}
>  		/* TODO: select normal or high priority */
> -		spin_lock(&t->task_state_lock);
> -		t->task_state_flags |= SAS_TASK_AT_INITIATOR;
> -		spin_unlock(&t->task_state_lock);
>  	} while (0);
>  	rc = 0;
>  	goto out_done;
> @@ -983,7 +980,6 @@ void pm8001_open_reject_retry(
>  			atomic_dec(&pm8001_dev->running_req);
>  		spin_lock_irqsave(&task->task_state_lock, flags1);
>  		task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -		task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  		task->task_state_flags |= SAS_TASK_STATE_DONE;
>  		if (unlikely((task->task_state_flags
>  				& SAS_TASK_STATE_ABORTED))) {
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 9d20f8009b89..b83500ef3d86 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -2178,7 +2178,6 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  		   psspPayload->ssp_resp_iu.status);
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -2362,7 +2361,6 @@ static void mpi_ssp_event(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -2787,7 +2785,6 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -3199,7 +3196,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>  	}
>  	spin_lock_irqsave(&t->task_state_lock, flags);
>  	t->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -	t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  	t->task_state_flags |= SAS_TASK_STATE_DONE;
>  	if (unlikely((t->task_state_flags & SAS_TASK_STATE_ABORTED))) {
>  		spin_unlock_irqrestore(&t->task_state_lock, flags);
> @@ -4722,7 +4718,6 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>  			ts->resp = SAS_TASK_COMPLETE;
>  			ts->stat = SAS_SAM_STAT_GOOD;
>  			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
> -			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
>  			task->task_state_flags |= SAS_TASK_STATE_DONE;
>  			if (unlikely((task->task_state_flags &
>  					SAS_TASK_STATE_ABORTED))) {
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 698f2032807b..549232d66b40 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -617,7 +617,6 @@ struct sas_task_slow {
>  #define SAS_TASK_STATE_DONE         2
>  #define SAS_TASK_STATE_ABORTED      4
>  #define SAS_TASK_NEED_DEV_RESET     8
> -#define SAS_TASK_AT_INITIATOR       16
>  
>  extern struct sas_task *sas_alloc_task(gfp_t flags);
>  extern struct sas_task *sas_alloc_slow_task(gfp_t flags);


-- 
Damien Le Moal
Western Digital Research
