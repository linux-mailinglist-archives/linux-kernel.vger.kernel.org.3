Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311AC532267
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiEXFVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEXFVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:21:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CB396B8;
        Mon, 23 May 2022 22:21:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0FE3219F5;
        Tue, 24 May 2022 05:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653369691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N0POl2iQ8Az4MtvrLWH5CpfHov/zRWX8h4ikAa4V9M=;
        b=F8qmKYzcqEYtyxAg3FCttUbpnzwR0DzGVBXkXpao09ZoeLrzMhcERj/SMncGjUaqLkqzHB
        ATTKnAGB4uYsQw5XOVmYR+egE9Mmg15nFVoEoo49eFeW9YkBlQbQejgaBY4yyxM8uVJcf1
        VndOEEphoQfGGZCrrrWXWusteoL8+Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653369691;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6N0POl2iQ8Az4MtvrLWH5CpfHov/zRWX8h4ikAa4V9M=;
        b=oSQEYDIT335op081U1V2un8S1fmeYacOPLEdvqbHm6FLK8ET2MCpBK5jvg5cmLRXNIZ8qJ
        yVVh1OVj0FqxWGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39A1413ADF;
        Tue, 24 May 2022 05:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1UwoDVtrjGK6GgAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 May 2022 05:21:31 +0000
Message-ID: <e7a0d9c4-de27-4713-cacd-7017faa1b0d6@suse.de>
Date:   Tue, 24 May 2022 07:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 3/7] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161607eucas1p2b6245eafb81dee3e2efbec3ab86a854d@eucas1p2.samsung.com>
 <20220523161601.58078-4-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220523161601.58078-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 18:15, Pankaj Raghav wrote:
> Remove the condition which disallows non-power_of_2 zone size ZNS drive
> to be updated and use generic method to calculate number of zones
> instead of relying on log and shift based calculation on zone size.
> 
> The power_of_2 calculation has been replaced directly with generic
> calculation without special handling. Both modified functions are not
> used in hot paths, they are only used during initialization &
> revalidation of the ZNS device.
> 
> As rounddown macro from math.h does not work for 32 bit architectures,
> round down operation is open coded.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/nvme/host/zns.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4e..d92f937d5cb9 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>   	}
>   
>   	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}
>   
>   	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
>   	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> @@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>   	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>   				   sizeof(struct nvme_zone_descriptor);
>   
> +	/*
> +	 * Division is used to calculate nr_zones with no special handling
> +	 * for power of 2 zone sizes as this function is not invoked in a
> +	 * hot path
> +	 */
>   	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(ns->disk) >> ilog2(ns->zsze));
> +			 div64_u64(get_capacity(ns->disk), ns->zsze));
>   
>   	bufsize = sizeof(struct nvme_zone_report) +
>   		nr_zones * sizeof(struct nvme_zone_descriptor);
> @@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>   	int ret, zone_idx = 0;
>   	unsigned int nz, i;
>   	size_t buflen;
> +	u64 remainder = 0;
>   
>   	if (ns->head->ids.csi != NVME_CSI_ZNS)
>   		return -EINVAL;
> @@ -197,7 +196,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
>   	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>   	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>   
> -	sector &= ~(ns->zsze - 1);
> +	/*
> +	 * Round down the sector value to the nearest zone start
> +	 */
> +	div64_u64_rem(sector, ns->zsze, &remainder);
> +	sector -= remainder;
>   	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
>   		memset(report, 0, buflen);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
