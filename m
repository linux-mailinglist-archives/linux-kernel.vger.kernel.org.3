Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12E258F138
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiHJRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHJRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:08:28 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA2F6D555
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151307; x=1691687307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HLAG2MAdQMkynHzaOpUgDbLqFXb4qGmeTI64Ae+vFXc=;
  b=EQwXjZlbfE9l0BhHfl36Q2UNYkOOJl/jfl+1M3Exhu9tcuihAwa2xzV1
   opBghp3sI183B7idOPrTzjxfhxcCLrTqZ7XJgRJJpXIdPDuAexjCUUDWE
   KRX3z3YNTktw4eJXOkOfOdAAGHGaDvgXj/iS0axn0E2Rke7ydQaZihU9K
   XJOc8LD1rSob5cLTbg01/4QE3Jeoxtavm4XEJAPQpwsZUbNg6oO3Rvswm
   Qks7iauGArF+y0/jRafMNvMzTxO37iA4Eqm76oTKYCx0JUFg6FYsxDip/
   7FbtCR55YRnyX4RkuXRnhTZGu2Im8t+Vyt8M0HnhI0bpFA/rnu6mNeZQD
   w==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="312648478"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:05:04 +0800
IronPort-SDR: EJzeyO2Rzo0xerI4eXBQT9wMUsb7e0JlUXxXxdyIiRIaVJA0jikkYfvEIRdtbZvcDQZU65LSo5
 3/v7+9NT5WP5y88utsmNsZ6Y497hSTrAaSnTnhpurqvzD66eZvdWFDqlRi7s23JhS3SnMo5q8m
 nCxTA/D4+u51lq9sAiEV/XIcL+fi1Wl/vjC97dcN+03ObxCmtk+MNpFdpF8OaNhkxVRzEYy6P/
 A0No4ZfYMm4obwDVSRZ4M5LVKD5pe7tMkJo2RaAzryCB03VcCoTcH5ksvv/i6UYsPtyg+PIAHl
 A7pWeVLX3+2jwzDM5YqawQzc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:20:34 -0700
IronPort-SDR: RizA7CHEPqooW+aPZbtiP767KSk6GZb2F5kw1Zyy2N7Q0RSMjuv1thSEcZpj5KCJ6kBj1wRgdm
 BoDFBmM8SbJlnfxOc8Iw72MocYJcZCe2vXS9jcXou4J+deECxW3Hou/tHzqtqpDkYVFJ5Qdvz/
 KY44cqa+jmCDRdwF/ryFpPuomn0JfVAxn587UJdG6qx2pkwpchZvGRXiQDcCd3U/NUKKbdLFIh
 6XBRuQDhpt/UUyKIzWitn8izOJFw4GijnInyfndYbj92qu+5ak4kOe7kVZPHk7ruiTqF0t//Gd
 vnk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:04:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xBd6MBCz1Rwqy
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 10:04:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660151096; x=1662743097; bh=HLAG2MAdQMkynHzaOpUgDbLqFXb4qGmeTI6
        4Ae+vFXc=; b=TdfgDS5faJoHWDTYREJ381G9CP4HfuOIRXtpaJJLW4wBI1b/SHP
        AAkVbsUoTm+239ekFaNGKrcFMFe97CSgbrthryJciRMN50+Hj71pirupyCdhqi6T
        nVjIHr240xCCGgE7SICObVKAbOpVhYujaiuVVwgYovQXuEeGbelXwwXLVAvBIp8G
        Y4ubnW7OIfiPkDXk7oDgjAqg3dlQDL2sDsz9Ur2ZXZZM5JcQtGlXBakRDQavd7i/
        D06VIMSlVdwwuwlNK5Pfp2LCEkLucBn9DWwygSFnmvhJ6s2UUTlJF/BlKW1FQ4cS
        RW73Ij0jIvGIaehRGYHzOcu12QVeBBmbZxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bbd-GxJ61qon for <linux-kernel@vger.kernel.org>;
        Wed, 10 Aug 2022 10:04:56 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xBb523Qz1RtVk;
        Wed, 10 Aug 2022 10:04:55 -0700 (PDT)
Message-ID: <89327143-48b1-297a-bf16-1ea7a2128595@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae@eucas1p2.samsung.com>
 <20220803094801.177490-5-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-5-p.raghav@samsung.com>
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
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place and adds now
> support for zoned devices with non po2 zone size.
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
>  
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5aa15172299d..ead848a15946 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1345,6 +1345,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	return disk_zone_no(bdev->bd_disk, sec);
> +}
> +
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;

I know that it is generally better to introduce a new helper together with its
user, but in this case, these 2 changes belong to different subsystems. So I
think it really may be better to have 2 patches here. Jens can decide about this
though.

-- 
Damien Le Moal
Western Digital Research
