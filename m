Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3600E59738E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiHQQFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiHQQFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:05:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466E9FAAF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660752283; x=1692288283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iJMTfVOI37QeGt217N6kQJxWbagpJ4mWzHbxwog8cvQ=;
  b=d0isv/EiF4tjHksOfY5NFVuVcBNhuTDBNEPkckCmsbOSZVxDGFxrJX4F
   F02+fMR+rU3WT3mTzndFiqsI2CeUDfoqXYps62qN9yBAVV/zysLXn4CgK
   N9PHfX5jRqo/K3aOCIQTLX1wPjf4wL/EdNwVBZjjZHph22w8CPAzLAKL2
   sdGaw/2qVmAoTKCeVZ3KinvNo2m7hpsy+BmabG5d1xAS7HKfBJoUYNzqI
   vgVGlFwIDvtlRgYdwZPIr9iLQV7Fd7UFwLAZmG3zKYAGMhep0AjmdaZK3
   m9zky4s6M97cPaAHFj675IRmLsqEEAKhE3CdKWumhWApgmWzQHRPXrNQy
   w==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="209482552"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 00:04:40 +0800
IronPort-SDR: 0uqDd2a+whNR98uv5OwVcBNXQxl/O7Gilu2wuiREh/Kr8hW3x8L6JTXNHc3eigj8lDctOUTWEY
 TjVrCyqfG2Yx0MMM9+MPL8G2ZLdJJX0lKKCW/8mIDdm4eQV9+aLpbOMSGxvygZMjtaxGlmKa7j
 0yIifcZrpLadmY4iWRhk++xYdhVrVsEW1/WuXtyiUSPnUncJD9kZAhKthn/6BAwV2sqoQWmdpd
 34ptLJ+tFEoqFaZ+G2n4cWI4zlvH5y0nRXx3YEkV3MgCQ05pcxm7r4CvfWdItAdWrYUJAfuh6w
 g6ncERCk88tZF4Vz2ob1mAbM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:25:27 -0700
IronPort-SDR: d1ZLhkWgR+V2KKYNPQDfc6umA30Z0HLg1+gnQbBIgQUDb3udre8PwgxMX2JVs9pXLL7ta6vx9+
 TCgDAPC4ksGRPytoRW2VsPv2bEsnD0RGNSVVfZnjGUmCfYOWUZ7BBk/awU1Oo1Y1bfY8pa2OQ3
 Yf/nenF8KanmqE3IODMI/4nmly18YW+UVOWX5U8ODMx5q8bI+5x8BjJrGFErxC+SOzymFe7Nze
 Q10WmD/wMVIVhoVk3+oh9p9WxGNh10NjH5ArFsECsZ6BWIkmpc1qJvv6hxGr5hg/CY2A606lkW
 B58=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:04:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7CWr0Vmdz1Rwqy
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:04:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660752279; x=1663344280; bh=iJMTfVOI37QeGt217N6kQJxWbagpJ4mWzHb
        xwog8cvQ=; b=qi8FG0mPWVIX9IRJzPDmyU3xdHzA/2NqlR5ANkBx1nkpNlhq50I
        FzNmNbqyeYfLZvKVfEhTif54p0VtMHo+2SFBWlFY08r5BGG/l/HaA1S8kk4Wz5nX
        De6Ked4aMt1JLX2y85n1aS68z+OV72iBMBX8XiJ1Mus/lXYPuGpxpBAUeBBQ4cf2
        1xy8gkou0Z+N19zHuiNdmSD4b+3XeLuk3vlrdTt6202QmnIzgnQnOAtWPQC15WJp
        GQGuCGKZ8pLm9AuwYJh+c3vL0CpxSGYaZXRdlLXRgGUKa0AXrE1CXilglF28P75f
        Dmsf4MpqR1W9r97lJPf7nuG5Xbh4kU1xODQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6WSo00NI7OEQ for <linux-kernel@vger.kernel.org>;
        Wed, 17 Aug 2022 09:04:39 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7CWp6SkRz1RtVk;
        Wed, 17 Aug 2022 09:04:38 -0700 (PDT)
Message-ID: <0bb6b134-7bad-7c39-ad6d-25d57bd343eb@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 09:04:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/6] scsi: libsas: Add sas_ata_device_link_abort()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        yangxingui@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, hare@suse.de
References: <1660747934-60059-1-git-send-email-john.garry@huawei.com>
 <1660747934-60059-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1660747934-60059-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/17 7:52, John Garry wrote:
> Similar to how AHCI handles NCQ errors in ahci_error_intr() ->
> ata_port_abort() -> ata_do_link_abort(), add an NCQ error handler for LLDDs
> to call to initiate a link abort.
> 
> This will mark all outstanding QCs as failed and kick-off EH.
> 
> Note:
> The ATA_EH_RESET flag is set for following reasons:
> - For hisi_sas, SATA device resources during error handling will only be
>   released during reset for ATA EH.
>   ATA EH could decide during autopsy that EH would not be required, so
>   ensure that it happens (by setting the flag).
> - Similar to hisi_sas, pm8001 NCQ error handling requires a hardreset to
>   ensure necessary recovery commands are sent (so again we require flag
>   ATA_EH_RESET to be set as an insurance policy).
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/libsas/sas_ata.c | 11 +++++++++++
>  include/scsi/sas_ata.h        |  5 +++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index d35c9296f738..9daae64be37e 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -861,6 +861,17 @@ void sas_ata_wait_eh(struct domain_device *dev)
>  	ata_port_wait_eh(ap);
>  }
>  
> +void sas_ata_device_link_abort(struct domain_device *device)
> +{
> +	struct ata_port *ap = device->sata_dev.ap;
> +	struct ata_link *link = &ap->link;
> +
> +	link->eh_info.err_mask |= AC_ERR_DEV;
> +	link->eh_info.action |= ATA_EH_RESET;

I am still not convinced that we should set this here. ata_eh_link_autopsy() and
ata_eh_analyze_serror() are supposed to set the action based on the error. Can't
you reuse the link autopsy function ?

> +	ata_link_abort(link);
> +}
> +EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
> +
>  int sas_execute_ata_cmd(struct domain_device *device, u8 *fis, int force_phy_id)
>  {
>  	struct sas_tmf_task tmf_task = {};
> diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
> index a1df4f9d57a3..cad0b33064a5 100644
> --- a/include/scsi/sas_ata.h
> +++ b/include/scsi/sas_ata.h
> @@ -32,6 +32,7 @@ void sas_probe_sata(struct asd_sas_port *port);
>  void sas_suspend_sata(struct asd_sas_port *port);
>  void sas_resume_sata(struct asd_sas_port *port);
>  void sas_ata_end_eh(struct ata_port *ap);
> +void sas_ata_device_link_abort(struct domain_device *dev);
>  int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
>  			int force_phy_id);
>  int sas_ata_wait_after_reset(struct domain_device *dev, unsigned long deadline);
> @@ -87,6 +88,10 @@ static inline void sas_ata_end_eh(struct ata_port *ap)
>  {
>  }
>  
> +static inline void sas_ata_device_link_abort(struct domain_device *dev)
> +{
> +}
> +
>  static inline int sas_execute_ata_cmd(struct domain_device *device, u8 *fis,
>  				      int force_phy_id)
>  {


-- 
Damien Le Moal
Western Digital Research
