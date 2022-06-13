Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD1548034
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiFMHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiFMHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:12:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B901A39E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655104371; x=1686640371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mwWtBRJWqJTQqkv9N+KiDQ+C5naTYFLMDpQnieAA+9k=;
  b=biHkAXs3voItoCkdHKjv/GcWEcTE3MJL1jdHLZ5xLZuvhFeAHYZrdzfD
   NH+iyPylsotxySNxhyiaMLW5op6Zswt7mxt/Z6p5E48SndTm0pcYWZBSo
   MV5HHiqdp/j0LEzy9v64yot/F1hEdhKyQSdWet/BpqZhFLHQFSkDLp8rM
   G1Dr2kQAVzpJOd7FUy4/xgU8UO9vkTlmGVT8w+MDUbsHQRgdrW7YzVmFa
   TRQkmGm8K3jungJ+ITVRH5DQ2FPIiOaUtZCDT/vn7DCj9Yl2dpAhbME3e
   L7bwHzyBHkVyi2pX4ZVqtXMDBN6TdTwVvxIWIqSxQepEOpuZJPabkj6v2
   g==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="307260573"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:12:50 +0800
IronPort-SDR: C/VjquhbL9Bi0y89fvcQufCqbnflSlYosctqvpvEcD8t0QodBMCJAwypGwd20M/tjy2Z+caY+r
 HpoWNgG2uIXp2YBeDcb+7rbOTEICvDhg2urx6cthA93azeUqBxHIQhJFPHYWONuMRNkmmibV1T
 RCZbHNy0E9isJDHdG883bD/0HYTDuFg3C07Aw2HdI0eNUSmsBlI40BLa+6HrWB9rEC9i7fGab8
 1o6OurKePDWWfq1L9yRMxGElBAkKo0RugFZy+wzKtp1qgQZEbvS7RZ4UMn+63iqsu6dr0S5QEv
 fwPXMlHl+5xqNexsbufs3hkt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:31:29 -0700
IronPort-SDR: J7PBh852tpBC06ryOfLQdj0FrlBFOtmcGC+zCaz5jEO+Xt1HTjHsPG+IWUZoS4HGHNO+JcmGfn
 Mj0cRPCj3eGCWKUj3Nv6uAxrWRS968Y8Ow94mfzJv6E1momuV2hXcRvXXVc2+nYhFidCt3Mf9Z
 TkCwtO4e83+z7NBufrDRjuMqONvAw940oM5FWgevTXszoNLtRdS9WKWSE1Rh7SFcoQVxIdv+JI
 32hyknZ8LWCmObiFilAol0VCDEneLyVOgZ/ruIeeneSzzKa/Kof9FK1FdX1QenHhJN6Fqy6o8c
 PHk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:12:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM2p85tQtz1SVp5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:12:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655104368; x=1657696369; bh=mwWtBRJWqJTQqkv9N+KiDQ+C5naTYFLMDpQ
        nieAA+9k=; b=gO24qBoEkI05WHC2emPW2LkwMhMFNWvB4ifkMFxwRnT4jvGNFUt
        Xtufnd6o7AOSAeu7R8MsOeusuvcbiHbIWvX8ohyV4OR99MVRsAloNUjqyQqonmkv
        FYO9VZGMET5f/ebEloNXrc2TiOsw7MLqX9+dAmJWrYjrd9cW2BG9muaSkTTij+/L
        XsGbYWujcbaf6xzbkozGdhyG/I9ooVIr/SgXohsb1j0zT8nKBv8UVRWO71aBo3kA
        6xO3vwBetpdT4JyiC2sYbtkew58mnF/VQtyDAJGs2JMII6LnbM9nw2J+07HrIshA
        WN1nW+zeqfJwq/6SvjWvdlr/Ba5Kh1KnSxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IlyDCXLBrP1L for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 00:12:48 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM2p55NkMz1Rvlc;
        Mon, 13 Jun 2022 00:12:45 -0700 (PDT)
Message-ID: <5b4d17c2-9ee6-7d44-e4cd-6402b0a61c01@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:12:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 06/18] libata-scsi: Add ata_scsi_queue_internal()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-7-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 19:29, John Garry wrote:
> Add a function to handle queued ATA internal SCSI cmnds - does much the
> same as ata_exec_internal_sg() does (which will be fixed up later to
> actually queue internal cmnds through this function).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 47 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/libata.h    |  6 +++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 42cecf95a4e5..baac35dd17ca 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3963,6 +3963,49 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  	return NULL;
>  }
>  
> +static unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
> +					    struct ata_device *dev)
> +{
> +	struct ata_link *link = dev->link;
> +	struct ata_port *ap = link->ap;
> +	struct ata_queued_cmd *qc;
> +
> +	/* no internal command while frozen */
> +	if (ap->pflags & ATA_PFLAG_FROZEN)
> +		goto did_err;
> +
> +	/* initialize internal qc */
> +	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
> +	link->preempted_tag = link->active_tag;
> +	link->preempted_sactive = link->sactive;
> +	ap->preempted_qc_active = ap->qc_active;
> +	ap->preempted_nr_active_links = ap->nr_active_links;
> +	link->active_tag = ATA_TAG_POISON;
> +	link->sactive = 0;
> +	ap->qc_active = 0;
> +	ap->nr_active_links = 0;> +
> +	if (qc->dma_dir != DMA_NONE) {
> +		int n_elem;
> +
> +		n_elem = 1;
> +		qc->n_elem = n_elem;
> +		qc->sg = scsi_sglist(scmd);
> +		qc->nbytes = qc->sg->length;
> +		ata_sg_init(qc, qc->sg, n_elem);
> +	}
> +
> +	scmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
> +
> +	ata_qc_issue(qc);
> +
> +	return 0;
> +did_err:
> +	scmd->result = (DID_ERROR << 16);
> +	scsi_done(scmd);
> +	return 0;
> +}
> +
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  {
>  	u8 scsi_op = scmd->cmnd[0];
> @@ -3971,7 +4014,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  	if (unlikely(!scmd->cmd_len))
>  		goto bad_cdb_len;
>  
> -	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
> +	if (scsi_is_reserved_cmd(scmd)) {
> +		return ata_scsi_queue_internal(scmd, dev);
> +	} else if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {

No need for the else here.

>  		if (unlikely(scmd->cmd_len > dev->cdb_len))
>  			goto bad_cdb_len;
>  
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 732de9014626..43f4bcfe9a5f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -767,7 +767,9 @@ struct ata_link {
>  
>  	struct device		tdev;
>  	unsigned int		active_tag;	/* active tag on this link */
> +	unsigned int		preempted_tag;
>  	u32			sactive;	/* active NCQ commands */
> +	u32			preempted_sactive;
>  
>  	unsigned int		flags;		/* ATA_LFLAG_xxx */
>  
> @@ -861,6 +863,10 @@ struct ata_port {
>  #ifdef CONFIG_ATA_ACPI
>  	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
>  #endif
> +
> +	u64 preempted_qc_active;
> +	int preempted_nr_active_links;
> +
>  	/* owned by EH */
>  	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
>  };


-- 
Damien Le Moal
Western Digital Research
