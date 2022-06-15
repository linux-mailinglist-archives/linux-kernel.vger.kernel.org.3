Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E421E54C6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354465AbiFOLCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353964AbiFOLBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:01:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0BB53A60
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655290903; x=1686826903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+YwahbjUCLImppA=;
  b=Y6J3DmMLb29RSEJXZvpkX99FsW3N5rgWtDNUB/vqgelW0N7fCd7HPM3f
   +W6LPKwOC75UcC83CdLYE0R7J7yv2SPnn4Ch79h3S1YcvdT2MoHjUICrx
   vKZlJpQBXM3FOFbVpIZ1huRnPm5eFbZY8U8uufdifQBbOQWBgAGUEnA/p
   CQro+4GASnrtNpRlWRlK/RTBT7ofyIrNQHggeP/5lIBaWcXZmwq70dTX+
   a4h7HXyo8249dKb75PCwHmomWa0HZcW2mOAvuPTYoKSBtwhqnzYv2bV81
   7VcjBFnvMuou4t/GuelZ0h/ZkXfXvWM9SFQSPiXHyPLG0KiNFdzS/hCVN
   g==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="208069841"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 19:01:42 +0800
IronPort-SDR: pP58WgwrU5S+8UsAbPTJ/Uvpcrbw+Z5i93SMhfThOA48PH04CSL7DTr0QTCYRlslILAtqx2tVw
 NkmD6S3uOx7dLii9oJPd0pxVP8IDcoRJkjXFMYBOJ7V5KeeVKUsD3SbjSHnk7TqFfW7wiM7nBL
 +qu+e5w+MQdByrAU+Sf9ihdLzOKcBXHNWaRba0snmCAEgWcp2DmTcC6bO1p7wtQoVJm6AM0b7z
 I3b/FC4B+1Tq4uxdmGPw3gAqvbyPS0KDCBb181YXB3Ffz5c2mlCljABJNnUqL+i+5Wyw29qE+o
 uzA6lHrH2NUfvZlpNnxJQ8xM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 03:20:07 -0700
IronPort-SDR: Kz/0/4cZDB6cgyl0WGcOcEhQ1294ENv6WRJ9LR6Aumknmpz5kTj1vCUbmG7+pSx8zYHoFnx906
 eWwfMXwfT6ZAJNwJUDei/D1E2OPFo4pN2AWkskuQC1RpHlcMZP3DRyWq5OyNj9DA2qvvjoZPS9
 PrsDNxQDykseF+ERlgnQgiTWXOFJB1calmzv9qJP/gaNsboS2oQmLEpFiAoKrdJS2wFT3Q1mht
 Mz0sy7c/1F92LlOT9RMduLHWG4oHK4ClnSbnidyZgNu6FgNFpFAUuipT4hpk0jzirDafjoV1SR
 QOc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 04:01:42 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNMnL0j6pz1SVp2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:01:41 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655290901; x=1657882902; bh=NX4SXzXOcEm6Wa/wGxya5bBYUkYI+Ywahbj
        UCLImppA=; b=T6O853cQSCc1Q4cmoll53tWhQlua3CRnPGD/JHULr+pEpWjg8h7
        0Xgdl1p1eKFllYxujnUn3MuRx05W5yg4eH94W33801uIFWBS8B9RszzJp2zORP9p
        HVZSGFXj5JVVwR10o2jqDeBJ5IvVQgbePcZUasIHK8IWm6QmBkd4ZdVkji1cMrkl
        ydZnuHIvZc3PW48cZj3PH/YYcej3sIF68hcr6jxIE1o8HHqMzHXNmreRtF4+ubtW
        VpLV2MkpVYtuubSm3kEQhuLMCm+BwvB4svyqyRNH9MUWiG5kh8MJfbVqki9g9R0O
        4fondWDP/36O5pyKLGIwjOL7J83eecHT3LA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GkISh8sXw48z for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 04:01:41 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNMnG1fD0z1Rvlc;
        Wed, 15 Jun 2022 04:01:38 -0700 (PDT)
Message-ID: <f7b586a3-5370-f3b9-72dc-f9bea0b63f1f@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 20:01:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH v7 12/13] dm: call dm_zone_endio after the
 target endio callback for zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, pankydev8@gmail.com, gost.dev@samsung.com,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102007eucas1p1106f9520e2a86beb3792107dffd8071b@eucas1p1.samsung.com>
 <20220615101920.329421-13-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615101920.329421-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 19:19, Pankaj Raghav wrote:
> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore. Call dm_zone_endio for zoned devices
> after calling the target's endio function
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> @Damien and @Hannes: I couldn't come up with a testcase that uses endio callback and
> zone append or append emulation for zoned devices to test for
> regression in this change. It would be great if you can suggest
> something. This change is required for the npo2 target as we update the
> clone bio sector in the endio callback function and the orig bio should
> be updated only after the endio callback for zone appends.

Running zonefs tests on top of dm-crypt will exercise DM zone append
emulation.

> 
>  drivers/md/dm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3f17fe1de..3a74e1038 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1025,10 +1025,6 @@ static void clone_endio(struct bio *bio)
>  			disable_write_zeroes(md);
>  	}
>  
> -	if (static_branch_unlikely(&zoned_enabled) &&
> -	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))
> -		dm_zone_endio(io, bio);
> -
>  	if (endio) {
>  		int r = endio(ti, bio, &error);
>  		switch (r) {
> @@ -1057,6 +1053,10 @@ static void clone_endio(struct bio *bio)
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&zoned_enabled) &&
> +	    unlikely(blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))))

blk_queue_is_zoned(bdev_get_queue(bio->bi_bdev))) ->
bdev_is_zoned(bio->bi_bdev)

> +		dm_zone_endio(io, bio);
> +
>  	if (static_branch_unlikely(&swap_bios_enabled) &&
>  	    unlikely(swap_bios_limit(ti, bio)))
>  		up(&md->swap_bios_semaphore);


-- 
Damien Le Moal
Western Digital Research
