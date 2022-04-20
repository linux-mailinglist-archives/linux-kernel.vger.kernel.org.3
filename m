Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126B508806
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378490AbiDTMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357045AbiDTMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:25:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B895338BF0;
        Wed, 20 Apr 2022 05:22:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D0F621115;
        Wed, 20 Apr 2022 12:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650457361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHPjzzOO54qwc4Uzs2IsZR10ev/XyXj4PFhP8vWexWQ=;
        b=ix3HWDGRLUOZCCZEPEmw5KeLE9w2iGFPkNfbRnlZ/ynXJd2JBk4o/Ro3aSZYBTiIWP/HMY
        OsMRXg0TiQlwMtaBRT0+G4TQ10v4vtt5JReMNfrlX0L1i25GDCJzW7MDQnQ3MoVSA4Xqd6
        YogH05//3Muk7cAw620RHcnEubR8Rps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650457361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHPjzzOO54qwc4Uzs2IsZR10ev/XyXj4PFhP8vWexWQ=;
        b=UT9LthruI0/sp/QuHtb2Os6u3DxwOVMJS5GwR/HBUk9nV1VwATTyiN1Mdvi+0vvxBIeJDy
        8ebYaFLXmUVLsZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EA5D13A30;
        Wed, 20 Apr 2022 12:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7eNODRH7X2LQYQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Apr 2022 12:22:41 +0000
Message-ID: <3e9c9954-8b0d-6bf5-3321-4deeb4ca77bf@suse.de>
Date:   Wed, 20 Apr 2022 14:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/4] scsi: libsas: Add sas_execute_internal_abort_dev()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
References: <1646309930-138960-1-git-send-email-john.garry@huawei.com>
 <1646309930-138960-3-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1646309930-138960-3-git-send-email-john.garry@huawei.com>
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
> Add support for a "device" variant of internal abort, which will abort all
> pending IOs for a specific device.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 8 ++++++++
>   include/scsi/libsas.h               | 8 ++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 0d05826e6e8c..8d6c83d15148 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -995,6 +995,14 @@ int sas_execute_internal_abort_single(struct domain_device *device, u16 tag,
>   }
>   EXPORT_SYMBOL_GPL(sas_execute_internal_abort_single);
>   
> +int sas_execute_internal_abort_dev(struct domain_device *device,
> +				   unsigned int qid, void *data)
> +{
> +	return sas_execute_internal_abort(device, SAS_INTERNAL_ABORT_DEV,
> +					  SCSI_NO_TAG, qid, data);
> +}
> +EXPORT_SYMBOL_GPL(sas_execute_internal_abort_dev);
> +
>   int sas_execute_tmf(struct domain_device *device, void *parameter,
>   		    int para_len, int force_phy_id,
>   		    struct sas_tmf_task *tmf)
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index 2d30d57916e5..71f632b2d2bd 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -560,6 +560,7 @@ struct sas_ata_task {
>   /* LLDDs rely on these values */
>   enum sas_internal_abort {
>   	SAS_INTERNAL_ABORT_SINGLE	= 0,
> +	SAS_INTERNAL_ABORT_DEV		= 1,
>   };
>   
>   struct sas_internal_abort_task {
> @@ -641,6 +642,11 @@ extern struct sas_task *sas_alloc_task(gfp_t flags);
>   extern struct sas_task *sas_alloc_slow_task(gfp_t flags);
>   extern void sas_free_task(struct sas_task *task);
>   
> +static inline bool sas_is_internal_abort(struct sas_task *task)
> +{
> +	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
> +}
> +
>   struct sas_domain_function_template {
>   	/* The class calls these to notify the LLDD of an event. */
>   	void (*lldd_port_formed)(struct asd_sas_phy *);
> @@ -697,6 +703,8 @@ extern int sas_bios_param(struct scsi_device *, struct block_device *,
>   int sas_execute_internal_abort_single(struct domain_device *device,
>   				      u16 tag, unsigned int qid,
>   				      void *data);
> +int sas_execute_internal_abort_dev(struct domain_device *device,
> +				   unsigned int qid, void *data);
>   extern struct scsi_transport_template *
>   sas_domain_attach_transport(struct sas_domain_function_template *);
>   extern struct device_attribute dev_attr_phy_event_threshold;

Same comment as in the previous patch: Please use the existing TMF_XXX 
values.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
