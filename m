Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936B8548070
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiFMHQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiFMHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:16:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A91A828
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655104585; x=1686640585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EPDBR3zIPt7rRmwu4Ziipqqlcg4evRJWn7liFflbhis=;
  b=BhkT0PaO6LSA5xhOdSRTTiFVgUZcXKlEhcdBq8DUT6Mz37ZzcKARKkpI
   vMEnNY1ANa0HzvoWdp6snctmG8T5wT14SCW0pUnBbtW0Jp3YiFEfBYkrk
   FBaNz1zNn/5SrIfrjf2pd8sHyzDp2pPcTR3Rg6ogJFEN/7HsGQV5ZRFt/
   zNQKFwwDf2cvEMvcN/lArNw5M+Ht/sE3em+sw5RyVaBEZCUDCjIoVpIdg
   Ro1Fw8OZGQxfl2T0SvbF3BedPh+pCtfyKa+xUC1CN+sjlJMNAxlU+jS8x
   Jy+Za/UYzkK/B88llP3yuqoV1673yweJIlnqoneSiSc2raP8qVs2HkEjT
   w==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="207826631"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:16:24 +0800
IronPort-SDR: CQzHIWi/hl719+kXvKnl+wFzU/DY8rK8h19Vv4NCyR9v9W7BOkE33eBOY0mqnWBbvRioMQ6ZZM
 Aasn/IdTNBd78BK8EU+XEQNioVkX35py14ZSP0EBJLenZsoAi69Q1Ddc94LBzYhB+QANHmyL40
 u1SNsfM1rkOu2B6/YmK71bJfawgEJp/+Tz0iMdn8OJmPxYvpQLu3AOv+WHYLyPYRmhuR0/pMV0
 Jl1fYzUIFHVrovwHhSuKaolDW0dMW34nP4AIe91KB+HTSjhrhCRDc2ZwsG4ry63qm5MVhgqiG3
 MPFr7VLhuS2t2ONtDN0uDZQK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:35:04 -0700
IronPort-SDR: NS5D4PJi+HDOyxgrx89GBLAzDbSL8gUuMOSWazdCOkn4mRTvblPVXO95wnDcSauFtZ+wIsAggS
 yYpYFggppRlgmEntFlcjHfIHHf5F3fhZ4ttFkmrf2DKpOSD5WoQmIE6WVhB1vTND4aV5YdFmqw
 Ly6KaEU1WcrlvfhzVpPlJP1VZXpOv3o6k5mXD+/ih1gHZaDQr9fsgNCjrxtaHLfQXVf/Kyqv9L
 FGEELRqx1lObEkfoPI26VyDpH728zf2cw/wDLMQtmer1lMRm/BgZogRrETpLl3EKG3Q8gns4DQ
 Dxg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:16:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM2tH4zSkz1SVp5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:16:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655104582; x=1657696583; bh=EPDBR3zIPt7rRmwu4Ziipqqlcg4evRJWn7l
        iFflbhis=; b=asnsycXMe2O7nEaoOSKFhaEb/fGGHjM6sQ1v9FwCaWqickekIqW
        Xl6d3mwryF0wayMxgZNpplbVmTS8bqVaw9zy8uJY1qQoi3KeFHuJ/uz7ilFpwn8T
        KINnWGct9IkE5dfqwhKm3PKgCsPQBLHG2xvPbUIHxzGX8VX6YnVg0FXNZAOjSB1o
        4BAfUqJ01NU/e/Of29wmDbdChiWIkK9Jjch64B4+XxTL5WsbzLb4Bby2/uXhuP4r
        yBV2soUlIAHn386SoJbhoHrFgsq9ng9mcJ1h1UsoxSEaDD0m40za+rsx988T67sO
        xyRMhfAMgBMLpAQSLcx3Ehg26/1lR4hrjtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A_zSGtAOxmSG for <linux-kernel@vger.kernel.org>;
        Mon, 13 Jun 2022 00:16:22 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM2tD5tDrz1Rvlc;
        Mon, 13 Jun 2022 00:16:20 -0700 (PDT)
Message-ID: <da6a77ff-0dde-b0b4-4d6c-047eab48d595@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:16:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 07/18] libata-scsi: Add ata_internal_queuecommand()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-8-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-8-git-send-email-john.garry@huawei.com>
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
> Add callback to queue reserved commands - call it "internal" as this is
> what libata uses.
> 
> Also add it to the base ATA SHT, and set nr_reserved_cmds = 1, which
> matches tag ATA_TAG_INTERNAL.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 14 ++++++++++++++
>  include/linux/libata.h    |  6 +++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index baac35dd17ca..b2702ab0183b 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1114,6 +1114,20 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  	return 0;
>  }
>  
> +int ata_internal_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmd)

ata_scsi_internal_queuecommand()

But given that this is used for the .reserved_queuecommand() method, I
would call it ata_scsi_reserved_queuecommand().

> +{
> +	struct ata_port *ap;
> +	int res;
> +
> +	ap = ata_shost_to_port(shost);

You can move this to ap declaration.

	struct ata_port *ap = ata_shost_to_port(shost);

> +	spin_lock_irq(ap->lock);

spin_lock_irqsave() ?

> +	res = ata_sas_queuecmd(scmd, ap);
> +	spin_unlock_irq(ap->lock);
> +
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(ata_internal_queuecommand);
> +
>  /**
>   *	ata_scsi_slave_config - Set SCSI device attributes
>   *	@sdev: SCSI device to examine
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 43f4bcfe9a5f..5fa6f56bba81 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1141,6 +1141,8 @@ extern int ata_std_bios_param(struct scsi_device *sdev,
>  			      sector_t capacity, int geom[]);
>  extern void ata_scsi_unlock_native_capacity(struct scsi_device *sdev);
>  extern int ata_scsi_slave_config(struct scsi_device *sdev);
> +extern int ata_internal_queuecommand(struct Scsi_Host *shost,
> +				struct scsi_cmnd *scmd);
>  extern void ata_scsi_slave_destroy(struct scsi_device *sdev);
>  extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
>  				       int queue_depth);
> @@ -1390,7 +1392,9 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>  	.proc_name		= drv_name,			\
>  	.slave_destroy		= ata_scsi_slave_destroy,	\
>  	.bios_param		= ata_std_bios_param,		\
> -	.unlock_native_capacity	= ata_scsi_unlock_native_capacity
> +	.unlock_native_capacity	= ata_scsi_unlock_native_capacity,\
> +	.nr_reserved_cmds = 1,\
> +	.reserved_queuecommand = ata_internal_queuecommand
>  
>  #define ATA_SUBBASE_SHT(drv_name)				\
>  	__ATA_BASE_SHT(drv_name),				\


-- 
Damien Le Moal
Western Digital Research
