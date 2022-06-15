Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D454D28A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiFOU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbiFOU2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:28:12 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435822CDDF;
        Wed, 15 Jun 2022 13:28:11 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so3256032pjn.0;
        Wed, 15 Jun 2022 13:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tCKjUEEB/O98mq0HYBwtkHqa14AHHAARD8/Yh00PhZE=;
        b=zdYTNHflv0v9sjpEUhInNYYIh731vcS7qaLFpi22DKch+yKlatmZCAc7wdwOHZsJRm
         wafk+2WQcJ0YTVVsszikpWj8PI0/qiJCrBc9V3mNj1nWBt30MH5bQ+ztarwNucgHbYE2
         cDOuV2rQ+zymFVkB8ojgvHCxXp6BN5xJJKP8uqYVrt5bMEt2cafWaoMj9E5ZVAlj7K8Z
         61GJ1ZkEQmh+4dv1CZd8iRIvtEAmfvijOfAs7gV/dlj3c8imi0SqvMdAuFh3zjcpt4uo
         PZbvidK34uDfdk0Gsyu+pSzZVPi7kyT3FiS/+gjCHf1SVkWyPl6b9F7QICr0ji6Sphzk
         b3+Q==
X-Gm-Message-State: AJIora/1r2tDgyRXcFGDvevrQ6GQYkQKrlZtJwtOKijBf69j/TAHJSg2
        gRG2uCRUXXGHszVWsFzbCzM=
X-Google-Smtp-Source: AGRyM1ssYRY17vRnuP2ETISK730/klJkF/7+lw/tAz1SHcUNuW29npshKuTZX6r5VdStdPt6uTHY9Q==
X-Received: by 2002:a17:90b:358d:b0:1ea:4718:82b8 with SMTP id mm13-20020a17090b358d00b001ea471882b8mr12165746pjb.244.1655324890558;
        Wed, 15 Jun 2022 13:28:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:36ac:cabd:84b2:80f6? ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm8523plk.302.2022.06.15.13.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:28:09 -0700 (PDT)
Message-ID: <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
Date:   Wed, 15 Jun 2022 13:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615101920.329421-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 03:19, Pankaj Raghav wrote:
> @@ -489,14 +489,27 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>   	 * smaller last zone.
>   	 */
>   	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zone size", disk->disk_name);
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Don't allow zoned device with non power_of_2 zone size with
> +		 * zone capacity less than zone size.
> +		 */

Please change "power_of_2" into "power-of-2".

> +		if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
> +				disk->disk_name);
>   			return -ENODEV;
>   		}

The above check seems wrong to me. I don't see why devices that report a 
capacity that is less than the zone size should be rejected.

> +		/*
> +		 * Division is used to calculate nr_zones for both power_of_2
> +		 * and non power_of_2 zone sizes as it is not in the hot path.
> +		 */

Shouldn't the above comment be moved to the patch description? I'm not 
sure whether having such a comment in the source code is valuable.

> +static inline sector_t blk_queue_offset_from_zone_start(struct request_queue *q,
> +							sector_t sec)
> +{
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	u64 remainder = 0;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return false;

"return false" should only occur in functions returning a boolean. This 
function returns type sector_t.

Thanks,

Bart.
