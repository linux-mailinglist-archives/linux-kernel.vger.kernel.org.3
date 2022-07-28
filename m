Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C74583781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbiG1D0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1D0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:26:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD6B488
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978760; x=1690514760;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6B0J7rPhKOuMBD6783EPbpQrY4+wGpoPU7fiO6rW+lQ=;
  b=MkNlvSvPhU/mvjc+lVwIzVBrgO/W4C69uTVIvlPLn3ndAy/r6Blxu67d
   C5ZuaMBwB5fHD7pb67wX1FA2BFILtiRM543cXw1nNUG/EL47X+pjOo7aK
   TkOs/lsJyx6FB5IWh/yJUbd8RtYQZxgkV5ky2RoiIaL5V9ymrUZ9KKaWp
   vPb8LZusNJM41cFwKBu8H7QMLGvYdoT2HnsYo6dmPvjFh61/vKdiWLqiP
   ALtJV1Eb6Liw34EmJ+IXYn58YIhhkn0n/sGMaJxm/EXTI9fySdAXkLO/r
   UooeP85rNSPlU4RxQTqYdWrV1mT6asjhR5E5Z7PwcZzjBATd/ccykirny
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212067809"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:25:59 +0800
IronPort-SDR: hgJCCFhJHNHf6C67Ps63bHwLu6HqltsRkSGZuhlaanh1j31pvnW5nZfQRGHXh3pLC8JucLwYqe
 cJ/xRMVdv9sLca+0A+gGLI4CN1EWipJW1835kPJWgdkt92gDEWJc0xMcfUx36s9qw4cn3vuH5L
 1mp0ZIn7q/+WBcIhvpAn0l5H8WDrnb7kmkqRy/eQyiQ5vb5Sx1D94bEacGYK5dIn1TK8ACJs2W
 K41S6WEfJ0K0nYniSgvsDPxpbmoTTWpDD20dIFBmTjK8P25udDPZPJsUlm4FBd++3R/xssiB3j
 rXovjTUL9fyHxxOA3ttsD7fV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:47:11 -0700
IronPort-SDR: fIcZzwDmRWbPHHVisP86AM4/tj8FDO4C9OYqQsI4CycdOBXxeAzUJY/jft0sNLgPDMjlyKNTDi
 Mtyve2m5NZ1skCIU2ciHBXff+nsWyH0ZsOfIP+r1ZLrJrhzcq99qAgpzOIIB2dyWgGf5yvA/4M
 FWnWV6+mmIb6+XoLD3wEPWkdMbmqk9LJjnX4LIl9m+C6WwqkEOHndPxkTm8g05S1EQS9gOi5N5
 RTZ7S7UYUOdC6E7IpWWyNnX1BEm3Bl4GC2Vz/XPo4Pq2s4cDa7h/6OvKWS/CAst6G/03wi+4WI
 fPY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:26:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ltbdg3kJ6z1Rws0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:25:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658978758; x=1661570759; bh=6B0J7rPhKOuMBD6783EPbpQrY4+wGpoPU7f
        iO6rW+lQ=; b=O3F0JLsKAAFttSPzysRoIMXHUwn4u4OZgC+3BCxcyjZy8KRr6Gs
        fzxhp1XdB7+DpH1UFGhLmGs6miIzdVpywmElhdqBXKj31nE4EarZP8ZlftO63wdj
        fX5a/agnYxZiIlDR7MjDXuFDzaug3gFboPTwmlhxpRHy2dzwmdcGXteq0k2N7rCS
        IFNacezDDvtj68K74FF3v7otR6Na1BHvS7bgT54vhsEq45VFfQ6L4KIMfUU0TVj3
        Jp1W6APGE2mtLiEChk/IkxjFExuRVdbV2CjHzDogUr9iD4GZvzQIRi5dN+G5Ht2w
        H6SoWH/DjZuP6ZbzQX2rnw6VRgEBE4bNgwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gad6nCFI2a-9 for <linux-kernel@vger.kernel.org>;
        Wed, 27 Jul 2022 20:25:58 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ltbdb6fMYz1RtVk;
        Wed, 27 Jul 2022 20:25:55 -0700 (PDT)
Message-ID: <2b1ab4ac-a355-dfb4-6ca4-82fe36a38433@opensource.wdc.com>
Date:   Thu, 28 Jul 2022 12:25:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 10/11] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd@eucas1p2.samsung.com>
 <20220727162245.209794-11-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 01:22, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore. Call dm_zone_endio for zoned devices
> after calling the target's endio function
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 03ac6143b8aa..bc410ee04004 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1123,10 +1123,6 @@ static void clone_endio(struct bio *bio)
>  			disable_write_zeroes(md);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled) &&
> -	    unlikely(bdev_is_zoned(bio->bi_bdev)))
> -		dm_zone_endio(io, bio);
> -
>  	if (endio) {
>  		int r = endio(ti, bio, &error);
>  		switch (r) {
> @@ -1155,6 +1151,10 @@ static void clone_endio(struct bio *bio)
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&zoned_enabled) &&
> +	    unlikely(bdev_is_zoned(bio->bi_bdev)))
> +		dm_zone_endio(io, bio);
> +
>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>  	    unlikely(swap_bios_limit(ti, bio)))
>  		up(&md->swap_bios_semaphore);

This patch seems completely unrelated to the series topic. Is that a bug
fix ? How do you trigger it ? Our tests do not show any issues here...
If this triggers only with non power of 2 zone size devices, then this
should be squashed in patch 8. And patch 9 could also be squashed with
patch 8 too.

-- 
Damien Le Moal
Western Digital Research
