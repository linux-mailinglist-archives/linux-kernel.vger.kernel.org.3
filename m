Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124D583753
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiG1DJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiG1DJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:09:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF635C349
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658977782; x=1690513782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19tnc3ApLbI=;
  b=kXKmbgJsCqgRypVEyQHAc6vF9L0p94L9rGhdsUe25TALoHWK7b5imudC
   3k+tszEqkSrPSXBN6RodMom1BXbxSo77zIZI0TwmkgEiDyL6FQCktfnlM
   8o1YanjW0z6FZVbaijTlswvL6B2WQlHvre/0KIOoDFU92pcdI/RMDNRbK
   iw2NiZJA8mUCMc3WebISSOnHuBpsHCvOsJNesRb0pIVZD0LnW6WLIViq5
   2OKsxw6WsSxZheFuX55WxwGH2zP/wHcB/yplRz4M71JTLdO/Ol++/+tVq
   LCTttraTWFIyMVdXa6ryP8NGZ/WDwyZjEKnff9f5laeJOo7VB76+YUy9H
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="319201606"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:09:42 +0800
IronPort-SDR: uIjb6tjRbEEDr2ERlaufB4la3gpqfQOsy6BxEY7jq5f4fwLMOt0EfGPOCkzUD+dnQi6066hcxu
 KHNIQwbbzZEbSqzv2+cA1KuwzAvipj0E+m+LWE01y9gSLvVISuxAHFFtefdnSQvaZ1wpOT04Pb
 sbI0XCe5kSccbflxTYXcCvtS5S1zsTme60AVN3RZb8H6jwrpTdhsDCMayQdgFKxu+9hH67yg4l
 kJEtymAR9C4KCDADfgDB1w4wf/6vj6pPdFVB3hwFg+n7xepTLPL/V8htyTmpdk9CgdlRsufqhY
 bikgy+IxQzXMdMqUUzMky0gc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:30:53 -0700
IronPort-SDR: XYPLiYoL2LvCPxK6omzH+WjDf0AWHHaspVA/jBY8o7Z7xkLGhiMRW4Wh6fRXUL4qDsVw3yn5fo
 m27/uMUpSrFxKbJfk/KW6ntYMLEDM9Ucz9P4WOj14NyJ39YthD4za1ScEiV09yvfudIXpmuxdv
 h60GsWTmDJcDt6EGXi+iOMadVXpgwIX9MzueBlY2rS9xCTUZMYc4faVZoQt16UBJh5Mv9UyESB
 a5IjWxLibKlQgQqe/v674dFrPv0g5/ehYxcAx1HUTZthqzcZhyuRMT9SIgNPX4SwBkLqr/FqVk
 VN8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:09:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbGs3dGdz1Rws4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:09:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658977780; x=1661569781; bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19t
        nc3ApLbI=; b=oc9CDihBx7buzRKUoSXFQyWp75MA8Dc8QpAYlEk9hQvUsBAy436
        HfjAMgEBhEjPykStP9IUZNCjt5Cv85QeXUcksLXEolRvParZ8thNQtO/CuYQQY5S
        ZUUpezITIbIkVxpCCD3TO7CSJtFvj4yEvhMn0VhKY2wDh3bRQ1ztlpDa6CuzFQX9
        iIEFx78nv8BH0XASa09ugNN28hAAL7QuYQXIkjQGSKfCIrN1BfsGDX2RmBFw0+jF
        SMwQS2+tu5KkmxDe8OofnBw0KnpbCCsrtkIi3Ep7YhLHTjipAPz1KewZOtERHWn2
        pBr4VsWwFmps3RDzhsHRgR2hBddEwflJ0FA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Km8Bbj9pfhiL for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:09:40 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbGp0d8bz1RtVk;
        Wed, 27 Jul 2022 20:09:37 -0700 (PDT)
Message-ID: <137b8772-a2cc-f195-1c0d-476214fabd52@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:09:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 04/11] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162250eucas1p133e8a814fee934f7161866122ef93273@eucas1p1.samsung.com>
 <20220727162245.209794-5-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place and adds now
> support for npo2 zone devices.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/target/zns.c | 3 +--
>  include/linux/blkdev.h    | 5 +++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c7ef69f29fe4..662f1a92f39b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
>  {
>  	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>  
> -	return bdev_nr_zones(req->ns->bdev) -
> -		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
> +	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
>  }

This change should go into patch 3. Otherwise, adding patch 3 only will
break the nvme target zone code.

>  
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1be805223026..d1ef9b9552ed 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1350,6 +1350,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	return disk_zone_no(bdev->bd_disk, sec);
> +}
> +

This should go into a prep patch before patch 3.

>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
