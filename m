Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8B51DC57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358500AbiEFPpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443071AbiEFPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:45:46 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CC4689A7
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651851723; x=1683387723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6HlQScgYRIU=;
  b=NnAcdmc4Wj1He+SrXK2jkiSegQy0esL5Fe+09tQoFcnjJ3jkWnyNFsBx
   Q8V79Ke1yWJW/Vbju1qeyaY8TQODsEd1QQ7Bs738ZcDNNY4AF8t9ld7AF
   9yq3LerEGrUK06+OGpbIWUy6sDWARLWxmJ8SmC53/CZmV2ylDoj7nm3VQ
   ncBqKNmXlK3tEF57+pP6YPBtRmJ9PA+uW9quhKZQBYrBdr+NNkFG9TA+r
   OqVHHOU+sK/yFy889goNbhYbB228JoJNF1nfkf3GPKoKXi+49gkwVbOnY
   eZ4EufAaxq0NG7/uroHjVbIwWIf6HPDN8U4MHBejESvPSMBENEvxXgyqH
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; 
   d="scan'208";a="199701357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 23:41:59 +0800
IronPort-SDR: 1TbXHsYAJ8KlcbNBKG4C+L97kHMB0FF7rZRTxlhsIQYNEpGy6HkWtGuBt3TZePUOZKsn8R8trb
 B/rw9zKX835g3eSB18uOwsn6Il937kSMJ/5a3vo2OUpe5IRFcUbVu3KeeZuLOokINKOT0ajXKx
 4F1buqaLUJX3F43L89yeoDy0/1UXEs7jGRpsQQ+FgglQQ+Xoh+RgjWm6vtjvipfEO1lPiXH9OS
 0FZVd1hkw156qnOEOJYOw2VWQbZA1Mht4mFOys0rQpI4xsDqnk63SxX0+VMyijRa/UJD+VIrUE
 UYY4k6teBVyv5TMpMhqccLzo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:12:16 -0700
IronPort-SDR: o8Xeb3jkmR6NmRYU+2z8OzpE934YyoD8GnlTGE4ffRbaaL9OF0E3X1wRtjfqdH/PXIJoxGkau5
 RIBaeiGWaCNL+bWc6+i8GzmzAeMn3JoAvXveDNMvI/YJPkAMTvhLDjxmqEsCfkSRKkM6qv29e5
 OY7fCzhnNLkU6mLuAycQXFKnhnrFPGIcKaD8ojPv2DZlcDJ3VfaufmoQ1YedrndxWR/RDxgeer
 wo4u+TDUzgrmpAGWwBfsyDPQxycWDDSHTpO7HyqUHQS5erhhYJu+YITtwR0xQJPxWgJBTEEP8s
 7yo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 08:42:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KvvvC1cVFz1SVp1
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:41:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651851718; x=1654443719; bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6Hl
        QScgYRIU=; b=WbBRu0S7iR1SmhEVR9i30Kql+kUpme4JxK84Ex4n5H1AfUhQ0EA
        s43ehh3Jxi03c/aa1PkPy9zpXcal9LS0jQoLHXDoQ8X64pfmVU8F+Y8nBgHjfgas
        nkAL+jnWw5ThcR+Jq1BNnuhc0o/mhwqQ5IiqOdwPxU5eHhWBbzcI7rR1dUJwE2Fi
        SMt7XqWc9/XGM7LK0GmzTFUNkZ+KteMkRDfpeOhq0if7HyNffaZrnfkJFK1T736p
        S4EMQmEAWtxxz4M7PkJBG2UGqoKaNk93iakpAHvYx7Hk5wLPL3e1zc9RYTuzeG/j
        dNxUKQCZnRC3KA89AxMPNpyTuxFnJGOFejw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vpZ_4uX-eBm3 for <linux-kernel@vger.kernel.org>;
        Fri,  6 May 2022 08:41:58 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvvv75djhz1Rvlc;
        Fri,  6 May 2022 08:41:55 -0700 (PDT)
Message-ID: <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
Date:   Sat, 7 May 2022 00:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        hare@suse.de, dsterba@suse.com, axboe@kernel.dk, hch@lst.de,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220506081105.29134-12-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/06 17:11, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3e7b1fe15..27dc4ddf2 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;

return -EINVAL;

The error propagates to dm_table_set_restrictions() so a proper error code must
be returned.


> +	}
>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research
