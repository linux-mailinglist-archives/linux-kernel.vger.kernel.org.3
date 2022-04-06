Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489C34F5B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbiDFJlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584362AbiDFJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:35:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F328AC74
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649209651; x=1680745651;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4QNGhCVjyn8LK6USs8COB4Sf+wqXGaxVxcHDk7fwkI=;
  b=QuQ8Lsd+ZRwySoloi3nj6M5/pJuTq65QcTmixC8S1yfCU7vGAC2LE1l+
   MoF2uhvfEHGtW+GKax4MI8r/oRrWGsed376LdpaUCpNmK6sPMCU2ge+v3
   2FrG1icregQQJnugwzTpCpWhGVAAJZDbzWGEUz7u5MCNbimnVM9IODSX1
   PvnTuxOWcoUZdkZvw0B4N0Mzz1DaGnhN+kSnXKJktwW0scorCRVq8Jjwc
   mkmkJf5ciepyoG5M1RYRsuH/gThZzYtcyYyUDWbmk4sDbq2AOKPR7snbF
   6n4KpimSlTfyI6VYtjBeqsBW6Ci3BLbOALSc/SSP8EmEwMw8KXI1yPURs
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="202037172"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 09:47:30 +0800
IronPort-SDR: oqwoWS6Aa3yKn9FWdqfzW+BQFITi9fatvRfx2w6kwVtUxAUAIqpadYN//mglpE+z1wAk7REJ59
 HO5WAHhmX2ZEXTA1v/99luheoiMDtS/B0TEMuH6i76BQH8hYLOi/LCa1Z2YzNzkEdm8J9Bkag7
 /kyly5Effzdkkv3aIx+XoE97xlAeqhT7gHJdD0t0c2EnfE/szek2vXdh2jXlGy2t2/wATy45WT
 O2NChwqnWOV3gaLjOr2uNxFfNi0pIMPsx2KRxud74SnSIabrhBw3FUoA9lNEZ9PiaXIOM8iYe/
 mTs8J3tYc7cgoKVYlykN71Z/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:18:13 -0700
IronPort-SDR: TnNJ+eOBcZlzyTghWp58f1M5Pc5BQAW4Z80aPlU0NiLWimWTB4seDdmy8fAys42LOLi39rK9N3
 C7N8PW1Gos1Roxy0BZS9qSo0rXaMcOIVW9z03hl2dU+Uyy9EAcbKqjxlByTJbaZ/MwNsDjtlhx
 kRlIx/VgVKGTOLME+6wbfEfmZO1PQvFFVR/ZsKoMoqWGJRNQ0btDAYcEEPuz81z8CVLStdeNP1
 VYa2S4NXWGBv3kIV83yi1N13UkwrLxs+tlsY2RNHn4snpLVf9Rvk42J6dq/B0siHSE72rw3lH0
 PlM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:47:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY6pB2qrCz1SHwl
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:47:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649209649; x=1651801650; bh=y4QNGhCVjyn8LK6USs8COB4Sf+wqXGaxVxc
        HDk7fwkI=; b=Why92KATSaTWDTRdXay89bhrCfE+1JZ8pl0W5gEX0tMou80PTaH
        +cKUGzGsZCK6oc3VuDa8Xhh/tvyH6TebYFLsblvcOBGCaf+ggmkdIMaN7BNdjVj5
        i5cWlDtI0X190r1EGVdNK39W/3Lo11pBsdSrHaZB8CWuwtnZ0KEJylov7/z02FCL
        ErgJX4RoTpQPSzWVVjQEtHuTaS3tEPVrQdVxTOm9/eJtkgQlZoewFbAPFVqIfhRH
        2A04PTkig8CZ55is1S++NeHTWd9A74rs6gSyNyel9IdCFHA6DRSNt8Tn/aE5Ux4l
        h1lX45PHMXe4PMN7ZcKqV4fdn93iv2GXc1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ODEZjpbsY1xd for <linux-kernel@vger.kernel.org>;
        Tue,  5 Apr 2022 18:47:29 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY6p83wbmz1Rvlx;
        Tue,  5 Apr 2022 18:47:28 -0700 (PDT)
Message-ID: <06820834-409e-5a53-b7b2-e3787a16d329@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 10:47:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1649083990-207133-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 23:53, John Garry wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> It is a bit pointless to have ata_qc_new_init() in libata-core.c since it
> pokes scsi internals, so inline it in ata_scsi_qc_new() (in libata-scsi.c).
> 
> <Christoph, please provide signed-off-by>
> [jpg, Take Christoph's change from list and form into a patch]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   Documentation/driver-api/libata.rst | 11 -------
>   drivers/ata/libata-core.c           | 44 +---------------------------
>   drivers/ata/libata-sata.c           |  8 -----
>   drivers/ata/libata-scsi.c           | 45 ++++++++++++++++++++++-------
>   drivers/ata/libata.h                | 12 --------
>   5 files changed, 35 insertions(+), 85 deletions(-)
> 
> diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
> index d477e296bda5..311af516a3fd 100644
> --- a/Documentation/driver-api/libata.rst
> +++ b/Documentation/driver-api/libata.rst
> @@ -424,12 +424,6 @@ How commands are issued
>   -----------------------
>   
>   Internal commands
> -    First, qc is allocated and initialized using :c:func:`ata_qc_new_init`.
> -    Although :c:func:`ata_qc_new_init` doesn't implement any wait or retry
> -    mechanism when qc is not available, internal commands are currently
> -    issued only during initialization and error recovery, so no other
> -    command is active and allocation is guaranteed to succeed.
> -
>       Once allocated qc's taskfile is initialized for the command to be
>       executed. qc currently has two mechanisms to notify completion. One
>       is via ``qc->complete_fn()`` callback and the other is completion
> @@ -447,11 +441,6 @@ SCSI commands
>       translated. No qc is involved in processing a simulated scmd. The
>       result is computed right away and the scmd is completed.
>   
> -    For a translated scmd, :c:func:`ata_qc_new_init` is invoked to allocate a
> -    qc and the scmd is translated into the qc. SCSI midlayer's
> -    completion notification function pointer is stored into
> -    ``qc->scsidone``.
> -
>       ``qc->complete_fn()`` callback is used for completion notification. ATA
>       commands use :c:func:`ata_scsi_qc_complete` while ATAPI commands use
>       :c:func:`atapi_qc_complete`. Both functions end up calling ``qc->scsidone``
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1067b2e2be28..5e7d6ccad5da 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4563,43 +4563,6 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
>   #endif /* __BIG_ENDIAN */
>   }
>   
> -/**
> - *	ata_qc_new_init - Request an available ATA command, and initialize it
> - *	@dev: Device from whom we request an available command structure
> - *	@scmd: scmd for which to get qc
> - *
> - *	LOCKING:
> - *	None.
> - */
> -
> -struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd)
> -{
> -	int tag = scsi_cmd_to_rq(scmd)->tag;
> -	struct ata_port *ap = dev->link->ap;
> -	struct ata_queued_cmd *qc;
> -
> -	/* no command while frozen */
> -	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> -		return NULL;
> -
> -	/* libsas case */
> -	if (ap->flags & ATA_FLAG_SAS_HOST) {
> -		tag = ata_sas_get_tag(scmd);
> -		if (tag < 0)
> -			return NULL;
> -	}
> -
> -	qc = __ata_qc_from_tag(ap, tag);
> -	qc->tag = qc->hw_tag = tag;
> -	qc->scsicmd = NULL;
> -	qc->ap = ap;
> -	qc->dev = dev;
> -
> -	ata_qc_reinit(qc);
> -
> -	return qc;
> -}
> -
>   /**
>    *	ata_qc_free - free unused ata_queued_cmd
>    *	@qc: Command to complete
> @@ -4612,13 +4575,8 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd
>    */
>   void ata_qc_free(struct ata_queued_cmd *qc)
>   {
> -	unsigned int tag;
> -
> -	WARN_ON_ONCE(qc == NULL); /* ata_qc_from_tag _might_ return NULL */
> -
>   	qc->flags = 0;
> -	tag = qc->tag;
> -	if (ata_tag_valid(tag))
> +	if (ata_tag_valid(qc->tag))
>   		qc->tag = ATA_TAG_POISON;
>   }
>   
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index c3e9fd7d920c..7a5fe41aa5ae 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1268,14 +1268,6 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>   }
>   EXPORT_SYMBOL_GPL(ata_sas_queuecmd);
>   
> -int ata_sas_get_tag(struct scsi_cmnd *scmd)
> -{
> -	if (WARN_ON_ONCE(scmd->budget_token >= ATA_MAX_QUEUE))
> -		return -1;
> -
> -	return scmd->budget_token;
> -}
> -
>   /**
>    *	sata_async_notification - SATA async notification handler
>    *	@ap: ATA port where async notification is received
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 61dd7f7c7743..50ef132ec48c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -638,24 +638,47 @@ EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
>   static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
>   					      struct scsi_cmnd *cmd)
>   {
> +	struct ata_port *ap = dev->link->ap;
>   	struct ata_queued_cmd *qc;
> +	int tag;
>   
> -	qc = ata_qc_new_init(dev, cmd);
> -	if (qc) {
> -		qc->scsicmd = cmd;
> -		qc->scsidone = scsi_done;
> -
> -		qc->sg = scsi_sglist(cmd);
> -		qc->n_elem = scsi_sg_count(cmd);
> +	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
> +		goto fail;
>   
> -		if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
> -			qc->flags |= ATA_QCFLAG_QUIET;
> +	if (ap->flags & ATA_FLAG_SAS_HOST) {
> +		/*
> +		 * SAS hosts may queue > ATA_MAX_QUEUE commands so use
> +		 * unique per-device budget token as a tag.
> +		 */
> +		if (WARN_ON_ONCE(cmd->budget_token >= ATA_MAX_QUEUE))
> +			goto fail;
> +		tag = cmd->budget_token;
>   	} else {
> -		cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
> -		scsi_done(cmd);
> +		tag = scsi_cmd_to_rq(cmd)->tag;
>   	}
>   
> +	qc = __ata_qc_from_tag(ap, tag);
> +	qc->tag = qc->hw_tag = tag;
> +	qc->scsicmd = NULL;
> +	qc->ap = ap;
> +	qc->dev = dev;
> +
> +	ata_qc_reinit(qc);
> +
> +	qc->scsicmd = cmd;
> +	qc->scsidone = scsi_done;
> +
> +	qc->sg = scsi_sglist(cmd);
> +	qc->n_elem = scsi_sg_count(cmd);
> +
> +	if (scsi_cmd_to_rq(cmd)->rq_flags & RQF_QUIET)
> +		qc->flags |= ATA_QCFLAG_QUIET;

Please add a blank line here.
I like to have return statements stand out :)

>   	return qc;
> +
> +fail:
> +	cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;

While at it, it may be better to use:

	set_host_byte(cmd, DID_OK);
	set_status_byte(cmd, SAM_STAT_TASK_SET_FULL);

> +	scsi_done(cmd);
> +	return NULL;
>   }
>   
>   static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 92e52090165b..926a7f41303d 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -44,7 +44,6 @@ static inline void ata_force_cbl(struct ata_port *ap) { }
>   #endif
>   extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
>   extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
> -extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, struct scsi_cmnd *scmd);
>   extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
>   			   u64 block, u32 n_block, unsigned int tf_flags,
>   			   unsigned int tag, int class);
> @@ -91,17 +90,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>   
>   #define to_ata_port(d) container_of(d, struct ata_port, tdev)
>   
> -/* libata-sata.c */
> -#ifdef CONFIG_SATA_HOST
> -int ata_sas_get_tag(struct scsi_cmnd *scmd);
> -#else
> -static inline int ata_sas_get_tag(struct scsi_cmnd *scmd)
> -{
> -	return -EOPNOTSUPP;
> -}
> -static inline void ata_sas_free_tag(unsigned int tag, struct ata_port *ap) { }
> -#endif
> -
>   /* libata-acpi.c */
>   #ifdef CONFIG_ATA_ACPI
>   extern unsigned int ata_acpi_gtf_filter;


-- 
Damien Le Moal
Western Digital Research
