Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E1E4CC317
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiCCQnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiCCQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:43:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0919D752
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646325741; x=1677861741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VuA6XlWxa/tMWUagno3I6z39ZFx7AGTcQMjcnIppmVA=;
  b=rwcfnI40hRUFVVlsfUTSMbI4ZzCKI/eAQ9oEyAu7mmJjHoJdRknCDsyu
   SquL5hzPIw2PT8k2XLMnTcHIvLOWoK5vZJdt44NQQOB1MqhwjUcmbdo7J
   8VlRX/Xy0XoMGN4yKQpNj69zSzR0Vd0Jcs4b2b8DOPCHWRIwdV1kWQwUQ
   EHaP4KiY/8k5MvEcEvmi24eoFsjoOVNSlB64I6suirQTHB53q4qjsfkXy
   wgdvOV0ZCEfyyW42zVSXrc07Hfx+eMjeEctWoda3TmFNlaMoAIBSi+CnK
   o3O11n6f+ujbbTRfG6v6qfWqn8+JSwycKlmpIvupgmQoBC8o7LbOgwx3Z
   g==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="195366425"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2022 00:42:18 +0800
IronPort-SDR: kdmCmDCKtU20pdSwzS2Vc651CZyI3m/oI8k27ZrKD1GDo1PG69Lo/dupQu4CiV+RpOE8nusV/f
 rTZLDYD582j3cuENgbA9hhEz+oxUd4ExYKaD0F5O4lZr9p8kII+AclK5z9vlSUWjjiErd5eq9g
 mL2PvTIPvEdezDEk7ODqQe582Gaei77E1CYrV+dTMqQHTDKvBXQrM9vSz2PUQwLupc3ApPWIac
 SgKcSTbxw1N7NwSXDl5DNTTk/0JRA+EdIeN1XVQjO1/XH7sdHmsviG27PdZDxJpoDwjgGaoElx
 vHs6wl9G0gT+HJVzpiSRhc3e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:13:39 -0800
IronPort-SDR: reGyGvRtpe/jm2Kf8Sfo3ueivp3MsoinlSQuPBlcZm+tJtK5jvX/AoMDrocvJkFVc9SEXvB/Cm
 CaV2/mlJ1r3NjMMF+Q3ek7LIGV/wcq71wGVtCFF5oeX5RS9aVr6QtD+kkAyiLrSjlKLr1wJEkw
 3HOWK0sGdZBoiwizxzv7ZVOb5Y1yPilj0bmf4Ap80fjJbu7RjHUmxyFGIykErEuZZ24GrRRn23
 8UeGOtQP+Wv5MHWRw7RdNfgczmnGlFKBOEOD0U7hhc07HLOrL+TFrLWB5rm9jSbmSyxHyncsBf
 BKY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 08:42:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K8cGK1CDgz1SVp5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:42:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646325733; x=1648917734; bh=VuA6XlWxa/tMWUagno3I6z39ZFx7AGTcQMj
        cnIppmVA=; b=P4DbjT5UIxd5+5YhvOoMM6ydaT1sfyPDuzidWGLPBjbfBubsxjv
        gYgZaZsjIk5VHU8bvAFOOjdNf6OG10ycdcaOKudbS5y1M/BK1BrVwsErP4hdch2q
        gLWdV1gFcEBmjRbeWAiX+68Px+clw/qqDUg0mf13s3YfWHtaqy/aRlI7SA1ACkAJ
        NV+wD0IcWik7+MTwzGwwA+r0HRzrXdJClonU9JTipKfnyI5P41p+GCaPLe/tNdku
        AuH5ixmjV7jOQUetoZb+q1uuL6Pd/Og4zh9WjZf0HDRN+WrF/64Nri8fn/HNVFhb
        vgIyPY4olXVcUQoTgwWMjjVCKZ/+kfpKg5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dWrsqT4Pfzac for <linux-kernel@vger.kernel.org>;
        Thu,  3 Mar 2022 08:42:13 -0800 (PST)
Received: from [10.225.33.67] (unknown [10.225.33.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K8cG92GRVz1Rvlx;
        Thu,  3 Mar 2022 08:42:09 -0800 (PST)
Message-ID: <fdded2c0-c382-75b1-9679-e10ba47084d7@opensource.wdc.com>
Date:   Thu, 3 Mar 2022 18:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH 4/4] scsi: hisi_sas: Use libsas internal abort support
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-5-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1646309930-138960-5-git-send-email-john.garry@huawei.com>
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
> Use the common libsas internal abort functionality.
> 
> In addition, this driver has special handling for internal abort timeouts -
> specifically whether to reset the controller in that instance, so extend
> the API for that.
> 
> Timeout is now increased to 20 * Hz from 6 * Hz.
> 
> We also retry for failure now, but this should not make a difference.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

A couple of nits below.

> ---
>  drivers/scsi/hisi_sas/hisi_sas.h       |   8 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 453 +++++++++----------------
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  18 +-
>  drivers/scsi/libsas/sas_scsi_host.c    |  12 +-
>  include/scsi/libsas.h                  |   2 +
>  6 files changed, 182 insertions(+), 322 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
> index 99ceffad4bd9..24c83bc4f5dc 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas.h
> +++ b/drivers/scsi/hisi_sas/hisi_sas.h
> @@ -133,11 +133,6 @@ struct hisi_sas_rst {
>  	bool done;
>  };
>  
> -struct hisi_sas_internal_abort {
> -	unsigned int flag;
> -	unsigned int tag;
> -};
> -
>  #define HISI_SAS_RST_WORK_INIT(r, c) \
>  	{	.hisi_hba = hisi_hba, \
>  		.completion = &c, \
> @@ -325,8 +320,7 @@ struct hisi_sas_hw {
>  	void (*prep_stp)(struct hisi_hba *hisi_hba,
>  			struct hisi_sas_slot *slot);
>  	void (*prep_abort)(struct hisi_hba *hisi_hba,
> -			  struct hisi_sas_slot *slot,
> -			  int device_id, int abort_flag, int tag_to_abort);
> +			  struct hisi_sas_slot *slot);
>  	void (*phys_init)(struct hisi_hba *hisi_hba);
>  	void (*phy_start)(struct hisi_hba *hisi_hba, int phy_no);
>  	void (*phy_disable)(struct hisi_hba *hisi_hba, int phy_no);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index cd8ec851e760..461ef8a76c4c 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -10,10 +10,6 @@
>  #define DEV_IS_GONE(dev) \
>  	((!dev) || (dev->dev_type == SAS_PHY_UNUSED))
>  
> -static int
> -hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
> -			     struct domain_device *device,
> -			     int abort_flag, int tag, bool rst_to_recover);
>  static int hisi_sas_softreset_ata_disk(struct domain_device *device);
>  static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
>  				void *funcdata);
> @@ -21,6 +17,10 @@ static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
>  				  struct domain_device *device);
>  static void hisi_sas_dev_gone(struct domain_device *device);
>  
> +struct hisi_sas_internal_abort_data {
> +	bool rst_ha_timeout; /* reset the HA for timeout */
> +};
> +
>  u8 hisi_sas_get_ata_protocol(struct host_to_dev_fis *fis, int direction)
>  {
>  	switch (fis->command) {
> @@ -263,11 +263,9 @@ static void hisi_sas_task_prep_ata(struct hisi_hba *hisi_hba,
>  }
>  
>  static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
> -		struct hisi_sas_internal_abort *abort,
> -		struct hisi_sas_slot *slot, int device_id)
> +				     struct hisi_sas_slot *slot)
>  {
> -	hisi_hba->hw->prep_abort(hisi_hba, slot,
> -			device_id, abort->flag, abort->tag);
> +	hisi_hba->hw->prep_abort(hisi_hba, slot);
>  }
>  
>  static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
> @@ -397,8 +395,7 @@ static
>  void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
>  			   struct hisi_sas_slot *slot,
>  			   struct hisi_sas_dq *dq,
> -			   struct hisi_sas_device *sas_dev,
> -			   struct hisi_sas_internal_abort *abort)
> +			   struct hisi_sas_device *sas_dev)
>  {
>  	struct hisi_sas_cmd_hdr *cmd_hdr_base;
>  	int dlvry_queue_slot, dlvry_queue;
> @@ -439,19 +436,15 @@ void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
>  		break;
>  	case SAS_PROTOCOL_SATA:
>  	case SAS_PROTOCOL_STP:
> -	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
> +	case SAS_PROTOCOL_STP_ALL:
>  		hisi_sas_task_prep_ata(hisi_hba, slot);
>  		break;
> -	case SAS_PROTOCOL_NONE:
> -		if (abort) {
> -			hisi_sas_task_prep_abort(hisi_hba, abort, slot, sas_dev->device_id);
> -			break;
> -		}
> +	case SAS_PROTOCOL_INTERNAL_ABORT:
> +		hisi_sas_task_prep_abort(hisi_hba, slot);
> +		break;
>  	fallthrough;
>  	default:
> -		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
> -			task->task_proto);
> -		break;
> +		return;
>  	}
>  
>  	WRITE_ONCE(slot->ready, 1);
> @@ -467,6 +460,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  	struct domain_device *device = task->dev;
>  	struct asd_sas_port *sas_port = device->port;
>  	struct hisi_sas_device *sas_dev = device->lldd_dev;
> +	bool internal_abort = sas_is_internal_abort(task);
>  	struct scsi_cmnd *scmd = NULL;
>  	struct hisi_sas_dq *dq = NULL;
>  	struct hisi_sas_port *port;
> @@ -484,7 +478,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  		 * libsas will use dev->port, should
>  		 * not call task_done for sata
>  		 */
> -		if (device->dev_type != SAS_SATA_DEV)
> +		if (device->dev_type != SAS_SATA_DEV && !internal_abort)
>  			task->task_done(task);
>  		return -ECOMM;
>  	}
> @@ -492,59 +486,85 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  	hisi_hba = dev_to_hisi_hba(device);
>  	dev = hisi_hba->dev;
>  
> -	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags))) {
> -		if (!gfpflags_allow_blocking(gfp_flags))
> -			return -EINVAL;
> +	switch (task->task_proto) {
> +	case SAS_PROTOCOL_SSP:
> +	case SAS_PROTOCOL_SMP:
> +	case SAS_PROTOCOL_SATA:
> +	case SAS_PROTOCOL_STP:
> +	case SAS_PROTOCOL_STP_ALL:
> +		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags))) {
> +			if (!gfpflags_allow_blocking(gfp_flags))
> +				return -EINVAL;
>  
> -		down(&hisi_hba->sem);
> -		up(&hisi_hba->sem);
> -	}
> +			down(&hisi_hba->sem);
> +			up(&hisi_hba->sem);
> +		}
>  
> -	if (DEV_IS_GONE(sas_dev)) {
> -		if (sas_dev)
> -			dev_info(dev, "task prep: device %d not ready\n",
> -				 sas_dev->device_id);
> -		else
> -			dev_info(dev, "task prep: device %016llx not ready\n",
> -				 SAS_ADDR(device->sas_addr));
> +		if (DEV_IS_GONE(sas_dev)) {
> +			if (sas_dev)
> +				dev_info(dev, "task prep: device %d not ready\n",
> +					 sas_dev->device_id);
> +			else
> +				dev_info(dev, "task prep: device %016llx not ready\n",
> +					 SAS_ADDR(device->sas_addr));
>  

This blank line could be removed too, no ?

> -		return -ECOMM;
> -	}
> +			return -ECOMM;
> +		}
>  
> -	if (task->uldd_task) {
> -		struct ata_queued_cmd *qc;
> +		port = to_hisi_sas_port(sas_port);
> +		if (!port->port_attached) {
> +			dev_info(dev, "task prep: %s port%d not attach device\n",
> +				 dev_is_sata(device) ? "SATA/STP" : "SAS",
> +				 device->port->id);
>  
> -		if (dev_is_sata(device)) {
> -			qc = task->uldd_task;
> -			scmd = qc->scsicmd;
> -		} else {
> -			scmd = task->uldd_task;
> +				return -ECOMM;

One tab too many for the indentation here, no ?

>  		}
> -	}
>  
> -	if (scmd) {
> -		unsigned int dq_index;
> -		u32 blk_tag;
> +		if (task->uldd_task) {
> +			struct ata_queued_cmd *qc;
>  
> -		blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> -		dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
> -		dq = &hisi_hba->dq[dq_index];
> -	} else {
> -		struct Scsi_Host *shost = hisi_hba->shost;
> -		struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> -		int queue = qmap->mq_map[raw_smp_processor_id()];
> +			if (dev_is_sata(device)) {
> +				qc = task->uldd_task;
> +				scmd = qc->scsicmd;
> +			} else {
> +				scmd = task->uldd_task;
> +			}
> +		}
>  
> -		dq = &hisi_hba->dq[queue];
> -	}
> +		if (scmd) {
> +			unsigned int dq_index;
> +			u32 blk_tag;
>  
> -	port = to_hisi_sas_port(sas_port);
> -	if (port && !port->port_attached) {
> -		dev_info(dev, "task prep: %s port%d not attach device\n",
> -			 (dev_is_sata(device)) ?
> -			 "SATA/STP" : "SAS",
> -			 device->port->id);
> +			blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> +			dq_index = blk_mq_unique_tag_to_hwq(blk_tag);
> +			dq = &hisi_hba->dq[dq_index];
> +		} else {
> +			struct Scsi_Host *shost = hisi_hba->shost;
> +			struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> +			int queue = qmap->mq_map[raw_smp_processor_id()];
>  
> -		return -ECOMM;
> +			dq = &hisi_hba->dq[queue];
> +		}
> +		break;
> +	case SAS_PROTOCOL_INTERNAL_ABORT:
> +		if (!hisi_hba->hw->prep_abort)
> +			return TMF_RESP_FUNC_FAILED;
> +
> +		if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
> +			return -EIO;
> +
> +		hisi_hba = dev_to_hisi_hba(device);
> +
> +		if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
> +			return -EINVAL;
> +
> +		port = to_hisi_sas_port(sas_port);
> +		dq = &hisi_hba->dq[task->abort_task.qid];
> +		break;
> +	default:
> +		dev_err(hisi_hba->dev, "task prep: unknown/unsupported proto (0x%x)\n",
> +			task->task_proto);
> +		return -EINVAL;
>  	}
>  
>  	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
> @@ -558,7 +578,7 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  			goto err_out_dma_unmap;
>  	}
>  
> -	if (hisi_hba->hw->slot_index_alloc)
> +	if (!internal_abort && hisi_hba->hw->slot_index_alloc)
>  		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
>  	else
>  		rc = hisi_sas_slot_index_alloc(hisi_hba, scmd);
> @@ -573,10 +593,10 @@ static int hisi_sas_queue_command(struct sas_task *task, gfp_t gfp_flags)
>  	slot->port = port;
>  
>  	slot->tmf = task->tmf;
> -	slot->is_internal = task->tmf;
> +	slot->is_internal = !!task->tmf || internal_abort;
>  
>  	/* protect task_prep and start_delivery sequence */
> -	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, NULL);
> +	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev);
>  
>  	return 0;
>  
> @@ -1088,6 +1108,29 @@ static void hisi_sas_dereg_device(struct hisi_hba *hisi_hba,
>  		hisi_hba->hw->dereg_device(hisi_hba, device);
>  }
>  
> +static int
> +hisi_sas_internal_task_abort_dev(struct hisi_sas_device *sas_dev,
> +				 bool rst_ha_timeout)
> +{
> +	struct hisi_sas_internal_abort_data data = { rst_ha_timeout };
> +	struct domain_device *device = sas_dev->sas_device;
> +	struct hisi_hba *hisi_hba = sas_dev->hisi_hba;
> +	int i, rc;
> +
> +	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
> +		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
> +		const struct cpumask *mask = cq->irq_mask;
> +
> +		if (mask && !cpumask_intersects(cpu_online_mask, mask))
> +			continue;
> +		rc = sas_execute_internal_abort_dev(device, i, &data);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void hisi_sas_dev_gone(struct domain_device *device)
>  {
>  	struct hisi_sas_device *sas_dev = device->lldd_dev;
> @@ -1100,8 +1143,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
>  
>  	down(&hisi_hba->sem);
>  	if (!test_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags)) {
> -		hisi_sas_internal_task_abort(hisi_hba, device,
> -					     HISI_SAS_INT_ABT_DEV, 0, true);
> +		hisi_sas_internal_task_abort_dev(sas_dev, true);
>  
>  		hisi_sas_dereg_device(hisi_hba, device);
>  
> @@ -1216,32 +1258,6 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
>  	return ret;
>  }
>  
> -static void hisi_sas_task_done(struct sas_task *task)
> -{
> -	del_timer_sync(&task->slow_task->timer);
> -	complete(&task->slow_task->completion);
> -}
> -
> -static void hisi_sas_tmf_timedout(struct timer_list *t)
> -{
> -	struct sas_task_slow *slow = from_timer(slow, t, timer);
> -	struct sas_task *task = slow->task;
> -	unsigned long flags;
> -	bool is_completed = true;
> -
> -	spin_lock_irqsave(&task->task_state_lock, flags);
> -	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
> -		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
> -		is_completed = false;
> -	}
> -	spin_unlock_irqrestore(&task->task_state_lock, flags);
> -
> -	if (!is_completed)
> -		complete(&task->slow_task->completion);
> -}
> -
> -#define INTERNAL_ABORT_TIMEOUT		(6 * HZ)
> -
>  static void hisi_sas_fill_ata_reset_cmd(struct ata_device *dev,
>  		bool reset, int pmp, u8 *fis)
>  {
> @@ -1426,9 +1442,7 @@ static void hisi_sas_terminate_stp_reject(struct hisi_hba *hisi_hba)
>  		if ((sas_dev->dev_type == SAS_PHY_UNUSED) || !device)
>  			continue;
>  
> -		rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -						  HISI_SAS_INT_ABT_DEV, 0,
> -						  false);
> +		rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>  		if (rc < 0)
>  			dev_err(dev, "STP reject: abort dev failed %d\n", rc);
>  	}
> @@ -1536,6 +1550,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
>  
>  static int hisi_sas_abort_task(struct sas_task *task)
>  {
> +	struct hisi_sas_internal_abort_data internal_abort_data = { false };
>  	struct domain_device *device = task->dev;
>  	struct hisi_sas_device *sas_dev = device->lldd_dev;
>  	struct hisi_hba *hisi_hba;
> @@ -1575,9 +1590,8 @@ static int hisi_sas_abort_task(struct sas_task *task)
>  		int rc2;
>  
>  		rc = sas_abort_task(task, tag);
> -		rc2 = hisi_sas_internal_task_abort(hisi_hba, device,
> -						   HISI_SAS_INT_ABT_CMD, tag,
> -						   false);
> +		rc2 = sas_execute_internal_abort_single(device, tag,
> +				slot->dlvry_queue, &internal_abort_data);
>  		if (rc2 < 0) {
>  			dev_err(dev, "abort task: internal abort (%d)\n", rc2);
>  			return TMF_RESP_FUNC_FAILED;
> @@ -1597,9 +1611,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
>  	} else if (task->task_proto & SAS_PROTOCOL_SATA ||
>  		task->task_proto & SAS_PROTOCOL_STP) {
>  		if (task->dev->dev_type == SAS_SATA_DEV) {
> -			rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -							  HISI_SAS_INT_ABT_DEV,
> -							  0, false);
> +			rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>  			if (rc < 0) {
>  				dev_err(dev, "abort task: internal abort failed\n");
>  				goto out;
> @@ -1613,9 +1625,9 @@ static int hisi_sas_abort_task(struct sas_task *task)
>  		u32 tag = slot->idx;
>  		struct hisi_sas_cq *cq = &hisi_hba->cq[slot->dlvry_queue];
>  
> -		rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -						  HISI_SAS_INT_ABT_CMD, tag,
> -						  false);
> +		rc = sas_execute_internal_abort_single(device,
> +						       tag, slot->dlvry_queue,
> +						       &internal_abort_data);
>  		if (((rc < 0) || (rc == TMF_RESP_FUNC_FAILED)) &&
>  					task->lldd_task) {
>  			/*
> @@ -1635,12 +1647,12 @@ static int hisi_sas_abort_task(struct sas_task *task)
>  
>  static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
>  {
> +	struct hisi_sas_device *sas_dev = device->lldd_dev;
>  	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
>  	struct device *dev = hisi_hba->dev;
>  	int rc;
>  
> -	rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -					  HISI_SAS_INT_ABT_DEV, 0, false);
> +	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>  	if (rc < 0) {
>  		dev_err(dev, "abort task set: internal abort rc=%d\n", rc);
>  		return TMF_RESP_FUNC_FAILED;
> @@ -1713,12 +1725,12 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
>  
>  static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
>  {
> +	struct hisi_sas_device *sas_dev = device->lldd_dev;
>  	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
>  	struct device *dev = hisi_hba->dev;
>  	int rc;
>  
> -	rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -					  HISI_SAS_INT_ABT_DEV, 0, false);
> +	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>  	if (rc < 0) {
>  		dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
>  		return TMF_RESP_FUNC_FAILED;
> @@ -1766,8 +1778,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
>  	int rc = TMF_RESP_FUNC_FAILED;
>  
>  	/* Clear internal IO and then lu reset */
> -	rc = hisi_sas_internal_task_abort(hisi_hba, device,
> -					  HISI_SAS_INT_ABT_DEV, 0, false);
> +	rc = hisi_sas_internal_task_abort_dev(sas_dev, false);
>  	if (rc < 0) {
>  		dev_err(dev, "lu_reset: internal abort failed\n");
>  		goto out;
> @@ -1862,203 +1873,48 @@ static int hisi_sas_query_task(struct sas_task *task)
>  	return rc;
>  }
>  
> -static int
> -hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
> -				  struct hisi_sas_internal_abort *abort,
> -				  struct sas_task *task,
> -				  struct hisi_sas_dq *dq)
> +static bool hisi_sas_internal_abort_timeout(struct sas_task *task,
> +					    void *data)
>  {
>  	struct domain_device *device = task->dev;
> -	struct hisi_sas_device *sas_dev = device->lldd_dev;
> -	struct device *dev = hisi_hba->dev;
> -	struct hisi_sas_port *port;
> -	struct asd_sas_port *sas_port = device->port;
> -	struct hisi_sas_slot *slot;
> -	int slot_idx;
> -
> -	if (unlikely(test_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags)))
> -		return -EINVAL;
> -
> -	if (!device->port)
> -		return -1;
> -
> -	port = to_hisi_sas_port(sas_port);
> -
> -	/* simply get a slot and send abort command */
> -	slot_idx = hisi_sas_slot_index_alloc(hisi_hba, NULL);
> -	if (slot_idx < 0)
> -		goto err_out;
> -
> -	slot = &hisi_hba->slot_info[slot_idx];
> -	slot->n_elem = 0;
> -	slot->task = task;
> -	slot->port = port;
> -	slot->is_internal = true;
> -
> -	hisi_sas_task_deliver(hisi_hba, slot, dq, sas_dev, abort);
> -
> -	return 0;
> -
> -err_out:
> -	dev_err(dev, "internal abort task prep: failed[%d]!\n", slot_idx);
> -
> -	return slot_idx;
> -}
> -
> -/**
> - * _hisi_sas_internal_task_abort -- execute an internal
> - * abort command for single IO command or a device
> - * @hisi_hba: host controller struct
> - * @device: domain device
> - * @abort_flag: mode of operation, device or single IO
> - * @tag: tag of IO to be aborted (only relevant to single
> - *       IO mode)
> - * @dq: delivery queue for this internal abort command
> - * @rst_to_recover: If rst_to_recover set, queue a controller
> - *		    reset if an internal abort times out.
> - */
> -static int
> -_hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
> -			      struct domain_device *device, int abort_flag,
> -			      int tag, struct hisi_sas_dq *dq, bool rst_to_recover)
> -{
> -	struct sas_task *task;
> -	struct hisi_sas_device *sas_dev = device->lldd_dev;
> -	struct hisi_sas_internal_abort abort = {
> -		.flag = abort_flag,
> -		.tag = tag,
> -	};
> -	struct device *dev = hisi_hba->dev;
> -	int res;
> -	/*
> -	 * The interface is not realized means this HW don't support internal
> -	 * abort, or don't need to do internal abort. Then here, we return
> -	 * TMF_RESP_FUNC_FAILED and let other steps go on, which depends that
> -	 * the internal abort has been executed and returned CQ.
> -	 */
> -	if (!hisi_hba->hw->prep_abort)
> -		return TMF_RESP_FUNC_FAILED;
> -
> -	if (test_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags))
> -		return -EIO;
> -
> -	task = sas_alloc_slow_task(GFP_KERNEL);
> -	if (!task)
> -		return -ENOMEM;
> -
> -	task->dev = device;
> -	task->task_proto = SAS_PROTOCOL_NONE;
> -	task->task_done = hisi_sas_task_done;
> -	task->slow_task->timer.function = hisi_sas_tmf_timedout;
> -	task->slow_task->timer.expires = jiffies + INTERNAL_ABORT_TIMEOUT;
> -	add_timer(&task->slow_task->timer);
> -
> -	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
> -						&abort, task, dq);
> -	if (res) {
> -		del_timer_sync(&task->slow_task->timer);
> -		dev_err(dev, "internal task abort: executing internal task failed: %d\n",
> -			res);
> -		goto exit;
> -	}
> -	wait_for_completion(&task->slow_task->completion);
> -	res = TMF_RESP_FUNC_FAILED;
> -
> -	/* Internal abort timed out */
> -	if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
> -		if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
> -			queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
> -
> -		if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
> -			struct hisi_sas_slot *slot = task->lldd_task;
> -
> -			set_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags);
> -
> -			if (slot) {
> -				struct hisi_sas_cq *cq =
> -					&hisi_hba->cq[slot->dlvry_queue];
> -				/*
> -				 * sync irq to avoid free'ing task
> -				 * before using task in IO completion
> -				 */
> -				synchronize_irq(cq->irq_no);
> -				slot->task = NULL;
> -			}
> -
> -			if (rst_to_recover) {
> -				dev_err(dev, "internal task abort: timeout and not done. Queuing reset.\n");
> -				queue_work(hisi_hba->wq, &hisi_hba->rst_work);
> -			} else {
> -				dev_err(dev, "internal task abort: timeout and not done.\n");
> -			}
> -
> -			res = -EIO;
> -			goto exit;
> -		} else
> -			dev_err(dev, "internal task abort: timeout.\n");
> -	}
> -
> -	if (task->task_status.resp == SAS_TASK_COMPLETE &&
> -		task->task_status.stat == TMF_RESP_FUNC_COMPLETE) {
> -		res = TMF_RESP_FUNC_COMPLETE;
> -		goto exit;
> -	}
> +	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
> +	struct hisi_sas_internal_abort_data *timeout = data;
>  
> -	if (task->task_status.resp == SAS_TASK_COMPLETE &&
> -		task->task_status.stat == TMF_RESP_FUNC_SUCC) {
> -		res = TMF_RESP_FUNC_SUCC;
> -		goto exit;
> -	}
> +	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct[0].itct)
> +		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
>  
> -exit:
> -	dev_dbg(dev, "internal task abort: task to dev %016llx task=%pK resp: 0x%x sts 0x%x\n",
> -		SAS_ADDR(device->sas_addr), task,
> -		task->task_status.resp, /* 0 is complete, -1 is undelivered */
> -		task->task_status.stat);
> -	sas_free_task(task);
> +	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
> +		pr_err("Internal abort: timeout %016llx\n",
> +		       SAS_ADDR(device->sas_addr));
> +	} else {
> +		struct hisi_sas_slot *slot = task->lldd_task;
>  
> -	return res;
> -}
> +		set_bit(HISI_SAS_HW_FAULT_BIT, &hisi_hba->flags);
>  
> -static int
> -hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
> -			     struct domain_device *device,
> -			     int abort_flag, int tag, bool rst_to_recover)
> -{
> -	struct hisi_sas_slot *slot;
> -	struct device *dev = hisi_hba->dev;
> -	struct hisi_sas_dq *dq;
> -	int i, rc;
> +		if (slot) {
> +			struct hisi_sas_cq *cq =
> +				&hisi_hba->cq[slot->dlvry_queue];
> +			/*
> +			 * sync irq to avoid free'ing task
> +			 * before using task in IO completion
> +			 */
> +			synchronize_irq(cq->irq_no);
> +			slot->task = NULL;
> +		}
>  
> -	switch (abort_flag) {
> -	case HISI_SAS_INT_ABT_CMD:
> -		slot = &hisi_hba->slot_info[tag];
> -		dq = &hisi_hba->dq[slot->dlvry_queue];
> -		return _hisi_sas_internal_task_abort(hisi_hba, device,
> -						     abort_flag, tag, dq,
> -						     rst_to_recover);
> -	case HISI_SAS_INT_ABT_DEV:
> -		for (i = 0; i < hisi_hba->cq_nvecs; i++) {
> -			struct hisi_sas_cq *cq = &hisi_hba->cq[i];
> -			const struct cpumask *mask = cq->irq_mask;
> -
> -			if (mask && !cpumask_intersects(cpu_online_mask, mask))
> -				continue;
> -			dq = &hisi_hba->dq[i];
> -			rc = _hisi_sas_internal_task_abort(hisi_hba, device,
> -							   abort_flag, tag,
> -							   dq, rst_to_recover);
> -			if (rc)
> -				return rc;
> +		if (timeout->rst_ha_timeout) {
> +			pr_err("Internal abort: timeout and not done %016llx. Queuing reset.\n",
> +			       SAS_ADDR(device->sas_addr));
> +			queue_work(hisi_hba->wq, &hisi_hba->rst_work);
> +		} else {
> +			pr_err("Internal abort: timeout and not done %016llx.\n",
> +			       SAS_ADDR(device->sas_addr));
>  		}
> -		break;
> -	default:
> -		dev_err(dev, "Unrecognised internal abort flag (%d)\n",
> -			abort_flag);
> -		return -EINVAL;
> +
> +		return true;
>  	}
>  
> -	return 0;
> +	return false;
>  }
>  
>  static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
> @@ -2176,6 +2032,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>  	.lldd_port_formed	= hisi_sas_port_formed,
>  	.lldd_write_gpio	= hisi_sas_write_gpio,
>  	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
> +	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
>  };
>  
>  void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 441ac4b6f1f4..455d49299ddf 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -2603,14 +2603,15 @@ static void hisi_sas_internal_abort_quirk_timeout(struct timer_list *t)
>  }
>  
>  static void prep_abort_v2_hw(struct hisi_hba *hisi_hba,
> -		struct hisi_sas_slot *slot,
> -		int device_id, int abort_flag, int tag_to_abort)
> +			     struct hisi_sas_slot *slot)
>  {
>  	struct sas_task *task = slot->task;
> +	struct sas_internal_abort_task *abort = &task->abort_task;
>  	struct domain_device *dev = task->dev;
>  	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
>  	struct hisi_sas_port *port = slot->port;
>  	struct timer_list *timer = &slot->internal_abort_timer;
> +	struct hisi_sas_device *sas_dev = dev->lldd_dev;
>  
>  	/* setup the quirk timer */
>  	timer_setup(timer, hisi_sas_internal_abort_quirk_timeout, 0);
> @@ -2622,13 +2623,13 @@ static void prep_abort_v2_hw(struct hisi_hba *hisi_hba,
>  			       (port->id << CMD_HDR_PORT_OFF) |
>  			       (dev_is_sata(dev) <<
>  				CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
> -			       (abort_flag << CMD_HDR_ABORT_FLAG_OFF));
> +			       (abort->type << CMD_HDR_ABORT_FLAG_OFF));
>  
>  	/* dw1 */
> -	hdr->dw1 = cpu_to_le32(device_id << CMD_HDR_DEV_ID_OFF);
> +	hdr->dw1 = cpu_to_le32(sas_dev->device_id << CMD_HDR_DEV_ID_OFF);
>  
>  	/* dw7 */
> -	hdr->dw7 = cpu_to_le32(tag_to_abort << CMD_HDR_ABORT_IPTT_OFF);
> +	hdr->dw7 = cpu_to_le32(abort->tag << CMD_HDR_ABORT_IPTT_OFF);
>  	hdr->transfer_tags = cpu_to_le32(slot->idx);
>  }
>  
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 914ae4e82f5e..79f87d7c3e68 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -1452,28 +1452,28 @@ static void prep_ata_v3_hw(struct hisi_hba *hisi_hba,
>  }
>  
>  static void prep_abort_v3_hw(struct hisi_hba *hisi_hba,
> -		struct hisi_sas_slot *slot,
> -		int device_id, int abort_flag, int tag_to_abort)
> +			     struct hisi_sas_slot *slot)
>  {
>  	struct sas_task *task = slot->task;
> +	struct sas_internal_abort_task *abort = &task->abort_task;
>  	struct domain_device *dev = task->dev;
>  	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
>  	struct hisi_sas_port *port = slot->port;
> +	struct hisi_sas_device *sas_dev = dev->lldd_dev;
> +	bool sata = dev_is_sata(dev);
>  
>  	/* dw0 */
> -	hdr->dw0 = cpu_to_le32((5U << CMD_HDR_CMD_OFF) | /*abort*/
> +	hdr->dw0 = cpu_to_le32((5U << CMD_HDR_CMD_OFF) | /* abort */
>  			       (port->id << CMD_HDR_PORT_OFF) |
> -				   (dev_is_sata(dev)
> -					<< CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
> -					(abort_flag
> -					 << CMD_HDR_ABORT_FLAG_OFF));
> +				(sata << CMD_HDR_ABORT_DEVICE_TYPE_OFF) |
> +				(abort->type << CMD_HDR_ABORT_FLAG_OFF));
>  
>  	/* dw1 */
> -	hdr->dw1 = cpu_to_le32(device_id
> +	hdr->dw1 = cpu_to_le32(sas_dev->device_id
>  			<< CMD_HDR_DEV_ID_OFF);
>  
>  	/* dw7 */
> -	hdr->dw7 = cpu_to_le32(tag_to_abort << CMD_HDR_ABORT_IPTT_OFF);
> +	hdr->dw7 = cpu_to_le32(abort->tag << CMD_HDR_ABORT_IPTT_OFF);
>  	hdr->transfer_tags = cpu_to_le32(slot->idx);
>  }
>  
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 8d6c83d15148..9c82e5dc4fcc 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -943,6 +943,7 @@ static int sas_execute_internal_abort(struct domain_device *device,
>  
>  		task->abort_task.tag = tag;
>  		task->abort_task.type = type;
> +		task->abort_task.qid = qid;
>  
>  		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
>  		if (res) {
> @@ -957,11 +958,16 @@ static int sas_execute_internal_abort(struct domain_device *device,
>  
>  		/* Even if the internal abort timed out, return direct. */
>  		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
> -			pr_err("Internal abort: timeout %016llx\n",
> -			       SAS_ADDR(device->sas_addr));
> +			bool quit = true;
>  
> +			if (i->dft->lldd_abort_timeout)
> +				quit = i->dft->lldd_abort_timeout(task, data);
> +			else
> +				pr_err("Internal abort: timeout %016llx\n",
> +				       SAS_ADDR(device->sas_addr));
>  			res = -EIO;
> -			break;
> +			if (quit)
> +				break;
>  		}
>  
>  		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 71f632b2d2bd..ff04eb6d250b 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -565,6 +565,7 @@ enum sas_internal_abort {
>  
>  struct sas_internal_abort_task {
>  	enum sas_internal_abort type;
> +	unsigned int qid;
>  	u16 tag;
>  };
>  
> @@ -671,6 +672,7 @@ struct sas_domain_function_template {
>  	/* Special TMF callbacks */
>  	void (*lldd_tmf_exec_complete)(struct domain_device *dev);
>  	void (*lldd_tmf_aborted)(struct sas_task *task);
> +	bool (*lldd_abort_timeout)(struct sas_task *task, void *data);
>  
>  	/* Port and Adapter management */
>  	int (*lldd_clear_nexus_port)(struct asd_sas_port *);


-- 
Damien Le Moal
Western Digital Research
