Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0791758358F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiG0XQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiG0XQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:16:36 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25352DC9;
        Wed, 27 Jul 2022 16:16:35 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id s206so134801pgs.3;
        Wed, 27 Jul 2022 16:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9RCSjgTld4jFxyRMFpo8i47HSyAGNN8HsW/U7jGMYJo=;
        b=QeGCaJI4fAnLKXeTObVUI4leA8+QZPaQB82gpcc9mmhHuR2cZUVzi9GJ9SQoYNFuRm
         lMBWZFOccJuEb/fZKzPvoFURFdnSI4ZDC0ke8zcSJbHyy0EiMT101uwHfdfmx3BLdfo+
         uEghJOZuBOBKkRwyIaJTb9YPcIq0hXWOo2UCeRhsBzflybxz+o1ZzDrNx5/WVtpZHMHh
         HD3OcBFz/DHAtZcwCqwyxIRhY+0Nuj33kJR3benttgBMrHXVHzdDFah+aMxUnPRc2/z+
         EVmASvkglVw0IdBhqlUUhVopZCSLkyX2Jsx+th/j0KJdlbwiqURlbPDfMGYU9mwU4itP
         cJJQ==
X-Gm-Message-State: AJIora/KVEtxP+hlQeTiyyibq5/WzTTWcsZiAWzHzQJvFpoY68YmfaAT
        vgYwmKb6quqZjCQ9uXEEf3HWvke536RECg==
X-Google-Smtp-Source: AGRyM1vSsVlL/urmNVN47qPHjbOavQDlMzKZVyvZFSg6UpuKUdlr1Wsfk2LxjLM4G7rsl977tP28Ug==
X-Received: by 2002:a05:6a00:114f:b0:528:2c7a:634c with SMTP id b15-20020a056a00114f00b005282c7a634cmr23853833pfm.41.1658963794531;
        Wed, 27 Jul 2022 16:16:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id f25-20020a635559000000b0041983a8d8c2sm12585044pgm.39.2022.07.27.16.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 16:16:33 -0700 (PDT)
Message-ID: <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
Date:   Wed, 27 Jul 2022 16:16:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
 <20220727162245.209794-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727162245.209794-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 09:22, Pankaj Raghav wrote:
> Checking if a given sector is aligned to a zone is a common
> operation that is performed for zoned devices. Add
> bdev_is_zone_start helper to check for this instead of opencoding it
> everywhere.

I can't find the bdev_is_zone_start() function in this patch?

> To make this work bdev_get_queue(), bdev_zone_sectors() and
> bdev_is_zoned() are moved earlier without modifications.

Can that change perhaps be isolated into a separate patch?

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3d286a256d3d..1f7e9a90e198 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -570,7 +570,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>   		return BLK_STS_NOTSUPP;
>   
>   	/* The bio sector must point to the start of a sequential zone */
> -	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	if (!bdev_is_zone_aligned(bio->bi_bdev, bio->bi_iter.bi_sector) ||
>   	    !bio_zone_is_seq(bio))
>   		return BLK_STS_IOERR;

The bdev_is_zone_start() name seems more clear to me than 
bdev_is_zone_aligned(). Has there already been a discussion about which 
name to use for this function?

> +		/*
> +		 * Non power-of-2 zone size support was added to remove the
> +		 * gap between zone capacity and zone size. Though it is technically
> +		 * possible to have gaps in a non power-of-2 device, Linux requires
> +		 * the zone size to be equal to zone capacity for non power-of-2
> +		 * zoned devices.
> +		 */
> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
> +				disk->disk_name);

Given the severity of this error, shouldn't the zone capacity and length 
be reported in the error message?

Thanks,

Bart.
