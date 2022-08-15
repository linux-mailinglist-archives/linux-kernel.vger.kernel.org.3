Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAEF593D92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiHOUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243529AbiHOUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E6EDEA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660589765; x=1692125765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/9pWEV0IM=;
  b=pitYxZyMLK+REI+EurRcy/tpWLEJDFEVJIi1FYF51fEvfSEDQOrS8/e3
   g85WadfNH0rSJApoQ9Din4/odQQQW7LQox9zKQYh+RT5E8CzVjLvGUvJs
   ROYZFpGo7iy2LlKAIjdQHEsasGO5KhckxwrKx0by4JPrtr1Vm05CX7Wh/
   op1isfNkFQnJgljbYi0/GV8bWfoAXpKusAUzU80Z0MxQU1HiUazPSlxb+
   kuLZpzyFyT2ZG60DIrBU4/VKKdSoExFYCYTgp4knfI69xRcWsgpCKiq+c
   5MI4ge0ciNVjkrzvLhNTRGwkaPiSbKi8WDVe7KYujFLP4FIRQXftiQrIW
   w==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654531200"; 
   d="scan'208";a="320854674"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 02:56:04 +0800
IronPort-SDR: QPCAinqKYkgwWONS598Cp1X3hJ7ygMz3ivgsEF3p6z8utUre011BSWuVtoCViecXF5Oj9a3Jja
 ltHOd2+FaEPVisEVsy7AxCpgR7fT6Fivt0tP2aB1wdK9VoUEX/pdNR7pFOQh2F5Ds2aFmnbLtu
 Fxm1a4RnVMY4JRUkMrBbw/AnKQ9iJGTKVeQkzMY0kGWzPYzHjmSxmZYUaHoudJ3RHXGTJynngB
 TVYgCK0tVsp9rVHaWqdbGBvplL8OZSTXQpFRLRvxKAiVpzGJYPwICOLU0SXLjceHuYOPb3y0u7
 pax0Vx77+Yg7InVPRung0g0T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:11:34 -0700
IronPort-SDR: q5JvKtLj7EYeK3bnmJ2y6nykoFApnjzNXx9Rt0lHhSeRlYUzd6FYtddrCkQAlTUZkZNZc/Sj64
 5h6LpPx8Ezrib8yWtpx78NNIApVMt9xfC1v0VgDqADIDAkyEud6cmWgHosik0KpICPn8ch001U
 tWRENYia1xc02ZDgopxDjayLwKVG8EALxoat2eGFAuXpoqvSr5JLHNG6Mie9KhHwaHmMeD65RB
 s+UnvEQZ5QZul3P8VkY9uQMPAWBzfScEDTmS97iU5KRi1WR/ZF2bofNMzQ/WAI3d3fiSyzSTBE
 Hno=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:56:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M63QX1tGMz1Rws4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660589763; x=1663181764; bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/
        9pWEV0IM=; b=cVDPi0Kzmzep2M8EqbqerFRmNFoCzwAWbOj49TmDAhX+LD4UCaY
        Cu/8kISW5TTQjQoXXq5GIOG6cDv01dng/UeI8zZzrI7QOlT+Bs+E/55TUL4BKYks
        TUVkhsU9i+QuCZCUKDcmfCnSl3gC4HeZNgOS0Ks4RuWeVYoZgZF46Gr5uJ/oElz0
        AT1tRvaEpFm3UCnJTto+JubxBpyWER7qwvosuu75e+ozyN8f8uUz7qqfGdvf3Xjp
        +UE2mjvKQtKTTuhao8LQoYETzhYUPGqQveWajxIvwokYLcuQxC4CcQAo1VLKbLwy
        X3ZpKiTUFbceakcDnLArV9shPg/mZTqGRBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yUTCVRQyIPBm for <linux-kernel@vger.kernel.org>;
        Mon, 15 Aug 2022 11:56:03 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M63QT4j3Gz1RtVk;
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
Message-ID: <d4735d9e-31b6-0872-82a7-acbbd0cb5af5@opensource.wdc.com>
Date:   Mon, 15 Aug 2022 11:56:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
 <20220811143043.126029-14-p.raghav@samsung.com>
 <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
 <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/15 6:38, Pankaj Raghav wrote:
> Hi Damien,
> 
>>> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
>>> +					  struct bio *bio)
>>
>> This really should be called dm_po2z_handle_read() since it handles both cases
>> of read commands, with and without the accept partial. Note that this is
>> retesting the need for a split after that was already tested in dm_po2z_map()
>> with bio_across_emulated_zone_area(). So the code should be better organized to
>> avoid that repetition.
>>
>> You can simplify the code by having bio_across_emulated_zone_area() return 0 for
>> a bio that does not cross the zone capacity and return the number of sectors up
>> to the zone capacity from the bio start if there is a cross. That value can then
> The offset will also be zero if the BIO starts at the zone capacity and
> dm_po2z_map will assume that the bio did not cross the emulated zone boundary.
> 
>> be used to call dm_accept_partial_bio() directly in dm_po2z_map() for read
>> commands. That will make this function much simpler and essentially turn it into
>> dm_po2z_read_zeroes().
>>
>>> +{
> 
> What about something like this? We have one function:
> bio_in_emulated_zone_area() that checks if a BIO is partly or completely in the
> emulated zone area and also returns the offset from bio to the emulated zone
> boundary (zone capacity of the device).
> 
> /**
>  * bio_in_emulated_zone_area - check if bio is in the emulated zone area
>  * @dmh:	pozone target data
>  * @bio:	bio
>  * @offset:	bio offset to emulated zone boundary
>  *
>  * Check if a @bio is partly or completely in the emulated zone area. If the
>  * @bio is partly in the emulated zone area, @offset
>  * can be used to split the @bio across the emulated zone boundary. @offset
>  * will be negative if the @bio completely lies in the emulated area.
>  *  */
> static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
> 					  struct bio *bio, int *offset)
> {
> 	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
> 	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> 	sector_t relative_sect_in_zone =

Nit: Could simply call this sector_offset.

> 		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
> 
> 	*offset = dmh->zone_size - relative_sect_in_zone;
> 
> 	return (relative_sect_in_zone + nr_sectors) > dmh->zone_size;

No need for the parenthesis.

> }
> 
> static int dm_po2z_read_zeroes(struct bio *bio)

Make that an inline.

> {
> 	zero_fill_bio(bio);
> 	bio_endio(bio);
> 	return DM_MAPIO_SUBMITTED;
> }
> 
> static int dm_po2z_remap_sector(struct dm_po2z_target *dmh, struct bio *bio)

Inline this one too.

> {
> 	bio->bi_iter.bi_sector =
> 		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
> 	return DM_MAPIO_REMAPPED;
> }
> 
> static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> {
> 	struct dm_po2z_target *dmh = ti->private;
> 
> 	bio_set_dev(bio, dmh->dev->bdev);
> 	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
> 		int split_io_pos;

Blank line needed here.

> 		if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos)) {
> 			return dm_po2z_remap_sector(dmh, bio);
> 		}

No need for the curly brackets.

> 		/*
> 		 * Read operation on the emulated zone area (between zone capacity
> 		 * and zone size) will fill the bio with zeroes. Any other operation
> 		 * in the emulated area should return an error.
> 		 */
> 		if (bio_op(bio) == REQ_OP_READ) {
> 			if (split_io_pos > 0) {
> 				dm_accept_partial_bio(bio, split_io_pos);
> 				return dm_po2z_remap_sector(dmh, bio);
> 			}
> 			return dm_po2z_read_zeroes(bio);
> 		}
> 		return DM_MAPIO_KILL;
> 	}
> 	return DM_MAPIO_REMAPPED;
> }
> 
> Let me know what you think.

I think this is way better. But I would still reorganize this like this:

static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
{
        struct dm_po2z_target *dmh = ti->private;
        int split_io_pos;

        bio_set_dev(bio, dmh->dev->bdev);

        if (op_is_zone_mgmt(bio_op(bio)))
                return dm_po2z_remap_sector(dmh, bio);

        if (!bio_sectors(bio))
                return DM_MAPIO_REMAPPED;

        /*
         * Read operation on the emulated zone area (between zone capacity
         * and zone size) will fill the bio with zeroes. Any other operation
         * in the emulated area should return an error.
         */
        if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
                return dm_po2z_remap_sector(dmh, bio);

        if (bio_op(bio) == REQ_OP_READ) {
                if (split_io_pos > 0) {
                        dm_accept_partial_bio(bio, split_io_pos);
                        return dm_po2z_remap_sector(dmh, bio);
                }
                return dm_po2z_read_zeroes(bio);
        }

        return DM_MAPIO_KILL;
}

I find the code easier to follow this way.



-- 
Damien Le Moal
Western Digital Research
