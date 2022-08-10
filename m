Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279A858F0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiHJQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiHJQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:50:17 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792DB82
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660150216; x=1691686216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MPhBPhAk4HW37DruWZIta9vgWfqSrvKcKI7Hck6kxrg=;
  b=MOEnCuWcpSyFxCu1P4JBPCROtOg9oEzy+BQUZh6nqan1rmUHf42ExY4Z
   z2q3NtAvy5UtXfp+zn2bgrXtT17Ra2o6NEVZHAgNRoofRmklty7fjzdiS
   xptyVZlqYPsOirf12uwRefSLeji2PVf+6RwA/qasR9OGnbOx55+LxsZmR
   /KSCNFGfbn9zoOCkjkA67YYE9fx1+Xsz4a/qwkQcY04Fes1uw2ZVjq25r
   eBlliX7D2UsOmOJkhjkU/yLwNCbWRkR/SnnJVD2EyzVGzFv8XVam5SFpN
   nUdRffspBa8NHFYj0KIu5Mo+zhh9OIiDgXEb4CKhaQ2YydyVAUzFY+go0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="208361420"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 00:50:12 +0800
IronPort-SDR: ieV2qMCFkyDB93XPhzTtz5W20QvJf/CsfEDWScNRsAAg5cU2C2OKoEi1saO/kVVJK7UPhxjCVc
 K0G5kpF4fg6f7nEywnIAq8M4VzGfwJS0XmOeezANYJgn2cQs+O+y9grdlzbvFWNr4oNRQmjBgB
 Wa6mCC/3mTWF8TBlKVMqSLyopOHksAQYeeTrsulG2guWLU/ccB1PViqDP1jjMeAFwLkKwvlFAg
 DrCyIFR3SU2dIESjWPrFAzgOfMub5UG0Q+kurGpkBJSI3YnEhSMPrCw7JH+Dx0tiYulTFZ6jq2
 tyFFSd8Ed3xdlLBPZUy/vXo6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:05:49 -0700
IronPort-SDR: f8nHcNwfYKkdAULtIHerjmg8Pg1M7tpHXaGlcFvf4KN+ZdMNEly3zlOLL5oOUKHqtl3mEvl6xz
 IDiEktKiPPHrXdPxiuYPZUSqudUSkoT/pSH8Iyp5bAiXjlvvO5VvwfNxHjFhifKbANFEqorUNP
 w2XOEsUYt5TK+8Sdn3SrdVzBckN4Rf1xjmJxzJOj+82yn/xDuqwEN+iUJg1v6oljgAyQGypFIZ
 86V052MjydvyVwrKQNhRCOYzlvVU4UAAHQEN56BnHImiAN/P0arMk5NzCmd3Ik5lWuVV4qNuc7
 jjI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:50:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2wsd5DGyz1Rws4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:50:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660150212; x=1662742213; bh=MPhBPhAk4HW37DruWZIta9vgWfqSrvKcKI7
        Hck6kxrg=; b=Hus+eB7k8UsnGk3IrIrjCE803v/xkjX6BsuABSkqcW3s0ul8lt0
        Z/JpUwIzXwz4s1+dDJELUqxf6Kd1b+InfY59QBO9Wj/h2ODDQIsphLl5y8jYrqDe
        Y+13rfSUz26uDXpAgSZysJQBgAcIpSF60W4xbva8IBIb7JUaAfGbFDIv4KgL2mcE
        IL4IS1hxRHtu356kOnM0+AxxCNrReglKYk3AtQApx4NvwIdwk3knKGJoFX0xjw+K
        LNmhTt6/TygfFwH9uAesFy1U9pRnvXMwoJ5apvOALGePuIH9yvYKCNMReClcM9wr
        1+IhP8ZvTdrEPu+YsIpXAOkKFxaEURpZD3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qexZYwQBBjFT for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 09:50:12 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2wsb51npz1RtVk;
        Wed, 10 Aug 2022 09:50:11 -0700 (PDT)
Message-ID: <700a5080-aea2-1a56-6bac-bebb03be8b47@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 09:50:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803@eucas1p1.samsung.com>
 <20220803094801.177490-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-3-p.raghav@samsung.com>
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
> in the blkdev.h include file.
> 
> This commit has no functional change, and it is a prep patch for allowing
> zoned devices with non-power-of-2 zone sizes in the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blkdev.h | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ab82d1ff0cce..22f97427b60b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
>  	return q->mq_ops;
>  }
>  
> +static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> +{
> +	return bdev->bd_queue;	/* this is never NULL */
> +}
> +
>  #ifdef CONFIG_PM
>  static inline enum rpm_status queue_rpm_status(struct request_queue *q)
>  {
> @@ -666,6 +671,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  	}
>  }
>  
> +static inline bool bdev_is_zoned(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (q)
> +		return blk_queue_is_zoned(q);

As noted with the comment in bdev_get_queue(), q is never null. So this all
could be simplified to:

	return blk_queue_is_zoned(bdev_get_queue(bdev));

This could be done in a separate patch, or here as well.

> +
> +	return false;
> +}
> +
> +static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!blk_queue_is_zoned(q))
> +		return 0;
> +	return q->limits.chunk_sectors;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
> @@ -892,11 +916,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
>  int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
>  			unsigned int flags);
>  
> -static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> -{
> -	return bdev->bd_queue;	/* this is never NULL */
> -}
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
>  
> @@ -1296,25 +1315,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> -static inline bool bdev_is_zoned(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> -}
> -
> -static inline sector_t bdev_zone_sectors(struct block_device *bdev)
> -{
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (!blk_queue_is_zoned(q))
> -		return 0;
> -	return q->limits.chunk_sectors;
> -}
> -
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research
