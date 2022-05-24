Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B447753226A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiEXFWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEXFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:22:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCC97523B;
        Mon, 23 May 2022 22:22:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16494219FE;
        Tue, 24 May 2022 05:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653369769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GLvmgEcXiba5nd15D94qUgg8T1Rge4swFj4Nc7zveY=;
        b=Gu5tpl9pHHLcy0h4gI4eNyZKKn8OlcjJs6HHHkn0hV9hwH5f7rdkZBX+34bKGW9Ae25UtH
        /ar50f8k1i5WEy/X+f23ZWt42kjM1VWHo1i1Nn0Vab+YcyENhwLeXz8r5nVI/YLa5nKwZn
        eQb1KG3pMGW0m1NDGq0Wg2F4lnU2bUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653369769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GLvmgEcXiba5nd15D94qUgg8T1Rge4swFj4Nc7zveY=;
        b=d2YwGc8+Yl6E6c8QbCc0m3r5RjtUToQD7Em/kfsOubDZ/Hn0gkzdxHnpZQTA7Pktgogeev
        T9rcW8mkSnKjkbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B708013ADF;
        Tue, 24 May 2022 05:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nXFgK6hrjGIBGwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 May 2022 05:22:48 +0000
Message-ID: <3d387876-342d-1516-92aa-24d39aa3f95c@suse.de>
Date:   Tue, 24 May 2022 07:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 6/7] null_blk: use zone_size_sects_shift for power of 2
 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161612eucas1p102a76ba431c934230309042521018915@eucas1p1.samsung.com>
 <20220523161601.58078-7-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220523161601.58078-7-p.raghav@samsung.com>
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

On 5/23/22 18:16, Pankaj Raghav wrote:
> Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
> the zone_size_sects_shift variable and use it for power of 2 zoned
> devices.
> 
> This variable will be set to zero for non power of 2 zoned devices.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/block/null_blk/null_blk.h |  6 ++++++
>   drivers/block/null_blk/zoned.c    | 10 ++++++++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 78eb56b0ca55..3d6e41a9491f 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -74,6 +74,12 @@ struct nullb_device {
>   	unsigned int imp_close_zone_no;
>   	struct nullb_zone *zones;
>   	sector_t zone_size_sects;
> +	/*
> +	 * zone_size_sects_shift is only useful when the zone size is
> +	 * power of 2. This variable is set to zero when zone size is non
> +	 * power of 2.
> +	 */
> +	unsigned int zone_size_sects_shift;
>   	bool need_zone_res_mgmt;
>   	spinlock_t zone_res_lock;
>   
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 00c34e65ef0a..806bef98ac83 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -13,8 +13,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
>   
>   static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>   {
> -	if (is_power_of_2(dev->zone_size_sects))
> -		return sect >> ilog2(dev->zone_size_sects);
> +	if (dev->zone_size_sects_shift)
> +		return sect >> dev->zone_size_sects_shift;
>   
>   	return div64_u64(sect, dev->zone_size_sects);
>   }
> @@ -82,6 +82,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>   	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>   	dev_capacity_sects = mb_to_sects(dev->size);
>   	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> +
> +	if (is_power_of_2(dev->zone_size_sects))
> +		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
> +	else
> +		dev->zone_size_sects_shift = 0;
> +
>   	dev->nr_zones =
>   		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
>   			  dev->zone_size_sects);
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
