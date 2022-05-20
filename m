Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822E52F648
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354152AbiETXeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiETXeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:34:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C81A7D2B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653089648; x=1684625648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxD0WkTRuBGs7QMn33plUCWC3KT9kbapNpgQIUmBMA8=;
  b=WU5QGbVXgqoJSzhNmD0ZQxyYaacyb/Ed78b452a9wN95QxdWblf1U4RN
   C6yLFNm52sfJAzzO+yeoEuZL39zb+iLQE8GgXSP1nIH09XTVpEM0ILyfo
   WCByek4HZobNKbDysRkyAU0D/sCncSg70flQ2tGU2kYkdZw7p0nizW1lT
   4TnZRnpAOXgjbfu2i57q77IKeTDRXsWx59Gj75CO5aqppWURkJbJL4IDS
   DvwJEarG0WhhoGHRVbo6p/soc1qATBAbHgcoT51CQ7wu1vgX0/GToGOEW
   3wU4gk0X5fUQV5n39vVnDyNXi2O+83znuSUDcJvKyYBaQ1NsM8MH//oaU
   w==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; 
   d="scan'208";a="200966409"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:34:07 +0800
IronPort-SDR: Yc2OuQSEFpK0b/9UukqWftPoMtnutwETM2S5cpmH/9XHGc/K903w1x0JgM4P6AjUK4fXzyIsKD
 ZTWWo3J4tjB+KFLYfc61cj77JJ/4UGnH/B++ZGsa3s4Zdhi6tf3EtKdGdCxJut2/wktcEoxz54
 xhy1DQnPXfiCcL8h+Tsa9H6Dgq5W9ZOWgujIhZPyAYQ6TTxaPt7GYW0xJ03vxvnNoi0155ZF9r
 fAoVlg1AXHWzS+vho2ERgnJW9LtWAp/nF7ysuC0vQsYcVkaD+i63BxFGMybofLbUlEqJ6S1mL8
 u0ArP4pviGNgxxLrE9yYGHEJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 15:56:51 -0700
IronPort-SDR: kXTB591zHXOaGYjbc/XthMr+rNfXtv2v9xMZk2uWc6OIH7TC5dIXiH77S/oMvQtE3ZSjKKn3iC
 nlDF5tDf36Zl6pKMvtdV0bfNerQs2aYpbQ5zyprBbOq4IZDoBUcEy8JE2oHCc+Tx6KiUHGf9Ft
 a+nZMFcLDIggbGuA/CLpP/S9tTERgR34oEZ8YSO+R8pIn+Wq5MMKk/mm1tjxY7yfbmWETmIF0+
 jQnW4/B9oxFG/3vkCqKgR60G58eK/5C/yg5i0A7W7bHnnqIVUUZ8L/1Hi9KWtF/jGmz+Qekylr
 FUk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2022 16:34:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jjW0x04z1SVp7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:34:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653089646; x=1655681647; bh=cxD0WkTRuBGs7QMn33plUCWC3KT9kbapNpg
        QIUmBMA8=; b=IAZfh2N/A1jItIRu6RNK4GCq/n7NLG1+opKeFCVPmNoD3nU4SpR
        bC6akAQHrRKjwDRGh4NXwXV/FMrBCZ6GcNYZcuC2ARib1r2sjAHkGU9Ep1cDFwop
        mDfqvuMSQssge51ujkq7vQ5pCjovouoGBfDz3E5IaM9G2Qqp9uzAo46qFsID7yHl
        Vw6amvteVP/EJl7jEGH7Boh6b3YkUpvvr5IwG9eq9uJub53GSlGzOb852GLfBhb/
        JW5MGlFzL5zQEqnjhAL3oRx/o0N9qjqNC1su+SaebsoCtTk5dX1J8MyoLkNh1FZr
        qCDdMdkk9R1i9CbzUDAwGjlwztQvrlS+5aw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J_-CnV0JDusr for <linux-kernel@vger.kernel.org>;
        Fri, 20 May 2022 16:34:06 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jjS0PF4z1Rvlc;
        Fri, 20 May 2022 16:34:03 -0700 (PDT)
Message-ID: <1a683059-d718-9536-e8fe-d7d47e25e935@opensource.wdc.com>
Date:   Sat, 21 May 2022 08:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] libata-scsi: Cap ata_device->max_sectors according to
 shost->max_sectors
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, liyihang6@hisilicon.com,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-5-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 17:23, John Garry wrote:
> ATA devices (struct ata_device) have a max_sectors field which is
> configured internally in libata. This is then used to (re)configure the
> associated sdev request queue max_sectors value from how it is earlier set
> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
> according to shost limits, which includes host DMA mapping limits.
> 
> Cap the ata_device max_sectors according to shost->max_sectors to respect
> this shost limit.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-scsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 06c9d90238d9..25fe89791641 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1036,6 +1036,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  		dev->flags |= ATA_DFLAG_NO_UNLOAD;
>  
>  	/* configure max sectors */
> +	dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
>  	blk_queue_max_hw_sectors(q, dev->max_sectors);
>  
>  	if (dev->class == ATA_DEV_ATAPI) {

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
