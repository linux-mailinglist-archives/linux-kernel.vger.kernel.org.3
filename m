Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF674F57FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiDFI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381800AbiDFIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:25:04 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D6F3B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209150; x=1680745150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TT9Q4isZap5oDHSGhYBaqGSoWrgP4fin4Czsfd9WOAQ=;
  b=W/YXZkufQfg0IaFd5qvAAor1ONKmcVQoQYNjuNepnlI5JS1jpXYS+gbf
   +Aha+OWZ4Q65Sz6nQZwyp+RXI67pBlvM3ztRkO3NFgLYMjkpeNhSR17Ho
   A+0TSoCO/8tuz3GXmCZLCe6vvx0QdhrDdG2a49RQzVJ/MpLkNtueNnspy
   yMVQmBrekPlR5/R3hkTVTuA/ugZDtuPxRnCJBgvErbXYL/wmcte8YCMBS
   HVdrC4vDghoa99YrmhWZgjS1kRtrNdZ2IvzkdEOgmmZRCnzpXmPm/01Ym
   iUYNHPTnYTA7etVLuvGZRX9LiA60grPPsz7+jiwD5bAlA8t5CiCF4bcap
   w==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="301359980"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:39:07 +0800
IronPort-SDR: 59bnARjdBmP+6nJcoEYv31NOYpKf/rk/7Pzea+k4EkebanFRQocGE2CmQlKxjIF6nIk0lNYw/L
 BCAlnc3NylH/gQRt/yvlS3gF/X8TWoGeDjb9qFXfjlDlZv/0tngtEzS0aGThhGcwJpWjfLSOR7
 7f6cu2XrCM/irR0gM0se7tCstODq/5xCJ3QgFPFmlcg1uED0O0/BUrbYBzishEGoxjMihwwnFQ
 c0JPhhAWmfyjz7GLb1bezA82bKTRHJoFhKI20yZ4fTfFud/KWsoekECCn4nNJVUCocTWijUl4m
 AR4lfHPTeEXQHQu8mL2DXAzG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:10:40 -0700
IronPort-SDR: VJqAkegeYd9idoAUlc07ZCvohUjYexljMmS3pl7GeHtR9f+beE6GUWdWi3nZ6qBEieI0tgn7A9
 CShIQ+nnpcCEH5/qnujMQxrly3GNXKNwXVoMV41JzrgFdsv0dXTXONrMF+HPZ+XTonhtL/CAJA
 ghVInD3OZEG/PUEp6gB5SBp6VzSvDkp69DZGk67nvPzR0GCv4271sfGpc/Aj3hEa/7FWRg1K9W
 ggf6P0jgGRkyrArNM1H+Y6KZGSYJasGqe1w6vKKmsjbTKzOjNC93A3/k10gvw1rzea+OuIvAxQ
 /is=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:39:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY6cW3Stpz1SVny
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:39:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649209146; x=1651801147; bh=TT9Q4isZap5oDHSGhYBaqGSoWrgP4fin4Cz
        sfd9WOAQ=; b=WRW4DVvNBMFGKtulHYkhDYUO8cUtSlv2Z6c4RPattYWACJpHRzh
        U5l3AhjRTEaGABj2wJVaAdvg8oi9n9YfxwtbBTWuinQKQefbQbfE8FrPObuLyI46
        AVjb65oOtG1lYbym+3/7mRr2evI84bo32sZienDORA5jGgOPV+92EzhJ6wB77PZK
        ZmS3yLbQS3rj6yPyUlDjKJfOXchZRZgEsFO/D4pNFuEa2+U8eHmofHuGf84me0w/
        XhIM8rm1LQn6N4gLJTpROC9aHrOrnL/QdgdbTHIK+lt1t77kf7XdO9NG/7talRUQ
        /54J6vBjrTsI4m/XvfaLHiB+0kaH/YrzpQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id STKRoJw7iPMm for <linux-kernel@vger.kernel.org>;
        Tue,  5 Apr 2022 18:39:06 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY6cT5d2wz1Rvlx;
        Tue,  5 Apr 2022 18:39:05 -0700 (PDT)
Message-ID: <a3cce73f-2e91-309d-bee0-a34a30335a18@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 10:39:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] libata: Use scsi cmnd budget token for qc tag for
 SAS host
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1649083990-207133-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 23:53, John Garry wrote:
> For attaining a qc tag for a SAS host we need to allocate a bit in
> ata_port.sas_tag_allocated bitmap.
> 
> However we already have a unique tag per device in range
> [0, ATA_MAX_QUEUE) in the scsi cmnd budget token, so just use that
> instead.

The valid range is [0, ATA_MAX_QUEUE - 1]. Tag ATA_MAX_QUEUE is 
ATA_TAG_INTERNAL which is never allocated as a valid device tag but used 
directly in ata_exec_internal().

> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/ata/libata-core.c | 14 +++++---------
>   drivers/ata/libata-sata.c | 25 ++++---------------------
>   drivers/ata/libata-scsi.c |  2 +-
>   drivers/ata/libata.h      |  7 +++----
>   include/linux/libata.h    |  1 -
>   5 files changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index cceedde51126..1067b2e2be28 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4566,14 +4566,15 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>   /**
>    *	ata_qc_new_init - Request an available ATA command, and initialize it
>    *	@dev: Device from whom we request an available command structure
> - *	@tag: tag
> + *	@scmd: scmd for which to get qc
>    *
>    *	LOCKING:
>    *	None.
>    */
>   
> -struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
> +struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
>   {
> +	int tag = scsi_cmd_to_rq(scmd)->tag;
>   	struct ata_port *ap = dev->link->ap;
>   	struct ata_queued_cmd *qc;
>   
> @@ -4583,7 +4584,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
>   
>   	/* libsas case */
>   	if (ap->flags & ATA_FLAG_SAS_HOST) {
> -		tag = ata_sas_allocate_tag(ap);
> +		tag = ata_sas_get_tag(scmd);
>   		if (tag < 0)
>   			return NULL;
>   	}
> @@ -4611,19 +4612,14 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
>    */
>   void ata_qc_free(struct ata_queued_cmd *qc)
>   {
> -	struct ata_port *ap;
>   	unsigned int tag;
>   
>   	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
> -	ap = qc->ap;
>   
>   	qc->flags = 0;
>   	tag = qc->tag;
> -	if (ata_tag_valid(tag)) {
> +	if (ata_tag_valid(tag))
>   		qc->tag = ATA_TAG_POISON;
> -		if (ap->flags & ATA_FLAG_SAS_HOST)
> -			ata_sas_free_tag(tag, ap);
> -	}
>   }
>   
>   void __ata_qc_complete(struct ata_queued_cmd *qc)
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 044a16daa2d4..c3e9fd7d920c 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1268,29 +1268,12 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>   }
>   EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
>   
> -int ata_sas_allocate_tag(struct ata_port *ap)
> +int ata_sas_get_tag(struct scsi_cmnd *scmd)
>   {
> -	unsigned int max_queue = ap->host->n_tags;
> -	unsigned int i, tag;
> +	if (WARN_ON_ONCE(scmd->budget_token >= ATA_MAX_QUEUE))
> +		return -1;
>   
> -	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
> -		tag = tag < max_queue ? tag : 0;
> -
> -		/* the last tag is reserved for internal command. */
> -		if (ata_tag_internal(tag))
> -			continue;
> -
> -		if (!test_and_set_bit(tag, &ap->sas_tag_allocated)) {
> -			ap->sas_last_tag = tag;
> -			return tag;
> -		}
> -	}
> -	return -1;
> -}
> -
> -void ata_sas_free_tag(unsigned int tag, struct ata_port *ap)
> -{
> -	clear_bit(tag, &ap->sas_tag_allocated);
> +	return scmd->budget_token;
>   }
>   
>   /**
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 06c9d90238d9..61dd7f7c7743 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -640,7 +640,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>   {
>   	struct ata_queued_cmd *qc;
>   
> -	qc = ata_qc_new_init(dev, scsi_cmd_to_rq(cmd)->tag);
> +	qc = ata_qc_new_init(dev, cmd);
>   	if (qc) {
>   		qc->scsicmd = cmd;
>   		qc->scsidone = scsi_done;
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index c9c2496d91ea..92e52090165b 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -44,7 +44,7 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
>   #endif
>   extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
>   extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
> -extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
> +extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
>   extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>   			   u64 block, u32 n_block, unsigned int tf_flags,
>   			   unsigned int tag, int class);
> @@ -93,10 +93,9 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>   
>   /* libata-sata.c */
>   #ifdef CONFIG_SATA_HOST
> -int ata_sas_allocate_tag(struct ata_port *ap);
> -void ata_sas_free_tag(unsigned int tag, struct ata_port *ap);
> +int ata_sas_get_tag(struct scsi_cmnd *scmd);
>   #else
> -static inline int ata_sas_allocate_tag(struct ata_port *ap)
> +static inline int ata_sas_get_tag(struct scsi_cmnd *scmd)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 9b1d3d8b1252..16107122e587 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -820,7 +820,6 @@ struct ata_port {
>   	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
>   
>   	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
> -	unsigned long		sas_tag_allocated; /* for sas tag allocation only */
>   	u64			qc_active;
>   	int			nr_active_links; /* #links with active qcs */
>   	unsigned int		sas_last_tag;	/* track next tag hw expects */


-- 
Damien Le Moal
Western Digital Research
