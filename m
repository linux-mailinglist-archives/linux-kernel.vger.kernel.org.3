Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C1528655
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbiEPOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiEPOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:02:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F439176
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709750; x=1684245750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK7baB8oU4=;
  b=h3sjEqPLIkfrG1Z8UNreXTrxEt7PqT5s/TCKzqlfz2UVTdvnkw9FVbdY
   mJYI5VWS0uga1DQWHVz5xx5syTiijYGfksrRUbX8zkHc50RME41rs/jkp
   A58uwWZKzRLS4hqBDGTI7SJgqkDwWIMTmD8mnA0BOwFMU9Kr5DSQTPIbd
   /pmMGG9Mj5jiEXneInFeXS6vPUsNPqHM7maoPjn42zfjNJp167PdBExzk
   bL+jfQWU+kzcvM6g0LxDfov2wRXdh+8eIhF+Xe6yIOB9q8pyJeW291jZx
   aqwG6bG4MxQ+w9dcfjnkSdhqOKlnv2V0xhLmMYokAoPCSGCUtT4wq8JVO
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205306646"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:02:27 +0800
IronPort-SDR: JxXELMoCwXGsluAfC8G5CdiElAtDfDRN/HcELpsAtX7En6JAaM3N82YZ+nJ+zRaAc0zbB6YbAc
 Kn73q30kBzqkjshfp+4H6sKv6+n+SrU7m/lnNdCAdrCkHRVRgsBXDIhiZikSwS2hJOY8jkmFpP
 j1shQXRE1rx79g8uQrPQLjGGDGi8nuhHDD4dB75KN0LpDN1v8oYw4IoUc8AKu/fQxv+mFHww32
 MhqkAmrqro0nIpUafd4XbDCMnYX6aCUWocG7RBNMdeIpao5MNa4jFM+22dL/sKpVF5xJVy+6dk
 2U3L5Mjb8UnAFq+ylGBVOZ5o
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:28:10 -0700
IronPort-SDR: o8xbXSNY1v7+RZzXDuD5FUdce6KuoY7/qqH+NyT3YlW4OEq97zQXkcy+jcthgL3ssaKzXg4miF
 2HXwAY8dy6ZNi8vzxLqPFo5JxBQxo1IQ7WcoNKvuUnbMdHB5ls3OYK3iNsq53NOXiyVD14ka1E
 dUrnhharUw8cbW6lg6Jy7aOAQNymhyzLt+tiiuk3gPigQu5tk3GpV91LLBuNsBQ4oEmdO95vb4
 MHtnmvWp2QlN3oxRjvU5xu6jfC9E4YirGFyEp3Eg5aoN5CfWYoyObSnjnGrkUv2zUuKELqexvN
 IyM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:02:28 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L21Cm0pnFz1SVp4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:02:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709747; x=1655301748; bh=xGZDTf4qfj90dVVU9I5TmSQhq50AE4kFyxK
        7baB8oU4=; b=BfBYgNsZ+siIAOaFFV8ORNyI1hHayTk2+IZ97SuE/RQw3f85/g+
        iOHRQ6DIbLehX2BUg43EH2PfJ84Mhi1w7NepehdOw0H3+rdx6hosakiN8UFeC/ZZ
        qrqwo60Sqgsl3aoxlvs3BcQ/dsdIOjV4/UH253I9MDD1EKQccyOkMEXjWDM+laUP
        48HjBexyerRk07a4NhdGMFwEniePnYNtolwQkfP2dQ297lFyVth1X4bTN8zMPPD/
        z42+sRJ9viAKZSWKafIgxT5YvljUKLuprFO0yFNAhCR4Rqa1SG6W/5JiFmqJNdeb
        iHbO8fFnXQN9uxrsANwRUroe3kkzWhokSWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HQd6WaBtS1ZT for <linux-kernel@vger.kernel.org>;
        Mon, 16 May 2022 07:02:27 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L21Cb6yPlz1Rvlc;
        Mon, 16 May 2022 07:02:19 -0700 (PDT)
Message-ID: <501aba4d-f4a3-8a4d-ec2a-99c7319b6a4d@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [dm-devel] [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     jiangbo.365@bytedance.com, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, bvanassche@acm.org,
        Chris Mason <clm@fb.com>, matias.bjorling@wdc.com,
        gost.dev@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        jonathan.derrick@linux.dev, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4@eucas1p1.samsung.com>
 <20220516133921.126925-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/zns.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4d..65d2aa68a 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>  
>  	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>  				   sizeof(struct nvme_zone_descriptor);
>  
> +	/*
> +	 * Division is used to calculate nr_zones with no special handling
> +	 * for power of 2 zone sizes as this function is not invoked in a
> +	 * hot path
> +	 */

Comment not very useful.

>  	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>  
>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	int ret, zone_idx = 0;
>  	unsigned int nz, i;
>  	size_t buflen;
> +	u64 remainder = 0;
>  
>  	if (ns->head->ids.csi != NVME_CSI_ZNS)
>  		return -EINVAL;
> @@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>  	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>  	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>  
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * rounddown the sector value to the nearest zone size. roundown macro
> +	 * provided in math.h will not work for 32 bit architectures.
> +	 * Division is used here with no special handling for power of 2
> +	 * zone sizes as this function is not invoked in a hot path
> +	 */

Please simplify this to:

	/* Round down the sector value to the nearest zone start */

> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;
>  	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>  		memset(report, 0, buflen);
>  


-- 
Damien Le Moal
Western Digital Research
