Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4773F5087FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353105AbiDTMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiDTMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:24:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0FA31217;
        Wed, 20 Apr 2022 05:21:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EAEC21118;
        Wed, 20 Apr 2022 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650457300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK1r6VYYIt7hQrJ5dgHOs6wdcfyWeyUTEorKnVY1GCc=;
        b=tb0SXgOpxO9hJ7cHc8EZwwW2GR7DXAkFGFCMZBezwuJiz1+h4z7ew/vd7lAeOT6i/CzohK
        oaNFI/sxI1eE2YnImaIoEwzvi4iEdnJebn1M6IC7oJFyioMxJiLxyu1KecDb2B2zeqzKaM
        B7NTOvI5srPygt4ZKoIf62QB/9E0vNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650457300;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK1r6VYYIt7hQrJ5dgHOs6wdcfyWeyUTEorKnVY1GCc=;
        b=ba/xWdB7dUDuFdWlkX+w2EccmN4BPb5FEB0y69Fy8JwzRxyW3I3yG8Wc8Q7hwO8BEOry73
        pQsYbzPluHOa3OAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3784613A30;
        Wed, 20 Apr 2022 12:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ek+ZC9T6X2JXYQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Apr 2022 12:21:40 +0000
Message-ID: <929aede0-9e58-9c3d-5951-6151a3281edd@suse.de>
Date:   Wed, 20 Apr 2022 14:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/4] scsi: libsas: Add sas_execute_internal_abort_single()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-2-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1646309930-138960-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 13:18, John Garry wrote:
> The internal abort feature is common to hisi_sas and pm8001 HBAs, and the
> driver support is similar also, so add a common handler.
> 
> Two modes of operation will be supported:
> - single: Abort a single tagged command
> - device: Abort all commands associated with a specific domain device
> 
> A new protocol is added, SAS_PROTOCOL_INTERNAL_ABORT, so the common queue
> command API may be re-used.
> 
> Only add "single" support as a first step.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 75 +++++++++++++++++++++++++++++
>   include/scsi/libsas.h               | 14 ++++++
>   include/scsi/sas.h                  |  2 +
>   3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 5b5747e33dbd..0d05826e6e8c 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -920,6 +920,81 @@ void sas_task_internal_timedout(struct timer_list *t)
>   #define TASK_TIMEOUT			(20 * HZ)
>   #define TASK_RETRY			3
>   
> +static int sas_execute_internal_abort(struct domain_device *device,
> +				      enum sas_internal_abort type, u16 tag,
> +				      unsigned int qid, void *data)
> +{
> +	struct sas_ha_struct *ha = device->port->ha;
> +	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
> +	struct sas_task *task = NULL;
> +	int res, retry;
> +
> +	for (retry = 0; retry < TASK_RETRY; retry++) {
> +		task = sas_alloc_slow_task(GFP_KERNEL);
> +		if (!task)
> +			return -ENOMEM;
> +
> +		task->dev = device;
> +		task->task_proto = SAS_PROTOCOL_INTERNAL_ABORT;
> +		task->task_done = sas_task_internal_done;
> +		task->slow_task->timer.function = sas_task_internal_timedout;
> +		task->slow_task->timer.expires = jiffies + TASK_TIMEOUT;
> +		add_timer(&task->slow_task->timer);
> +
> +		task->abort_task.tag = tag;
> +		task->abort_task.type = type;
> +
> +		res = i->dft->lldd_execute_task(task, GFP_KERNEL);
> +		if (res) {
> +			del_timer_sync(&task->slow_task->timer);
> +			pr_err("Executing internal abort failed %016llx (%d)\n",
> +			       SAS_ADDR(device->sas_addr), res);
> +			break;
> +		}
> +
> +		wait_for_completion(&task->slow_task->completion);
> +		res = TMF_RESP_FUNC_FAILED;
> +
> +		/* Even if the internal abort timed out, return direct. */
> +		if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
> +			pr_err("Internal abort: timeout %016llx\n",
> +			       SAS_ADDR(device->sas_addr));
> +
> +			res = -EIO;
> +			break;
> +		}
> +
> +		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> +			task->task_status.stat == SAS_SAM_STAT_GOOD) {
> +			res = TMF_RESP_FUNC_COMPLETE;
> +			break;
> +		}
> +
> +		if (task->task_status.resp == SAS_TASK_COMPLETE &&
> +			task->task_status.stat == TMF_RESP_FUNC_SUCC) {
> +			res = TMF_RESP_FUNC_SUCC;
> +			break;
> +		}
> +
> +		pr_err("Internal abort: task to dev %016llx response: 0x%x status 0x%x\n",
> +		       SAS_ADDR(device->sas_addr), task->task_status.resp,
> +		       task->task_status.stat);
> +		sas_free_task(task);
> +		task = NULL;
> +	}
> +	BUG_ON(retry == TASK_RETRY && task != NULL);
> +	sas_free_task(task);
> +	return res;
> +}
> +
> +int sas_execute_internal_abort_single(struct domain_device *device, u16 tag,
> +				      unsigned int qid, void *data)
> +{
> +	return sas_execute_internal_abort(device, SAS_INTERNAL_ABORT_SINGLE,
> +					  tag, qid, data);
> +}
> +EXPORT_SYMBOL_GPL(sas_execute_internal_abort_single);
> +
>   int sas_execute_tmf(struct domain_device *device, void *parameter,
>   		    int para_len, int force_phy_id,
>   		    struct sas_tmf_task *tmf)
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index df2c8fc43429..2d30d57916e5 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -557,6 +557,16 @@ struct sas_ata_task {
>   	int    force_phy_id;
>   };
>   
> +/* LLDDs rely on these values */
> +enum sas_internal_abort {
> +	SAS_INTERNAL_ABORT_SINGLE	= 0,
> +};
> +

Why don't you use the existing TMF_XXX values here?
Your 'single' method pretty much _is_ a TMF_ABORT_TASK, and the 'device' 
method _is_ a TMF_ABORT_TASK_SET, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
