Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E154EE0A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378893AbiFPXt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379203AbiFPXtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:49:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7062BE9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655423359; x=1686959359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZMytOujssEcOtiMdUCJ4EFf5UjhPhqNXGPuMIYgyGew=;
  b=KUN5eBenh7Np6pJPJ7r6tRxm8wGCJoZRkQPgfHyNCcHVrIe1mxtfQti8
   JF75soyH8njSVzszHDehrBKM7+u/0c5Tt3F1vjs351Rq/bTq9SGtCaa6G
   C2anZLv38fUJDJxG3E7ASAstyExVbDuqWr04Yqwd4luIvyVEcjUVKgmK9
   AHmbnpg7LNkX8369NV4thGDYuhwT8sDOdZgbmczd9HSAvoOoLrIFISnMQ
   F9JabEZ8GSf6BmQBMahHrQkOk/+9oWNbtZ2EzMbzznO66xLKFuQp/lHIY
   2VesSq5kF+QwyZzInpDA/UID6gOZaeFPHCDc0DiLJ9+4rNIWlcGv+GhsD
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="202083453"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:49:18 +0800
IronPort-SDR: MMroMTHK39pYwwqj51GFaXKuoCqXr+7CDn4kpO4wKJ5Yk7UqbeJeMmFW9sZfdCEO5p4UcJDFEy
 1jaj2EDnPQyMR8qre2ncfV5maQUUQdXNlz7uw5toDWBPwPF0d/Yzcvs/hhcFu2JPJppFfGXyiO
 leNQ8xd03qZ7iGPvm4Xru+ze/Piyu0Fd6BeIjhX2n1Lc0bMZ1GwnfA+J3yqMiTjcjC0dW+CMn9
 WLgwQlo9Ttrk6eHWXA2LlaApp8p1PQdQMgwu3NHYkS+AeZg47d/+n/2L6tNm3m0xKx5w+mzTOK
 4Qk9aP3bpz752xwEl6m62hDA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:11:54 -0700
IronPort-SDR: +irRrFARZMt4b5JCHqk2pjopS6ftGF7IUZz8kjPCCygBAUcZGdU8uzHuvtgDAR98N8uMsyXzTy
 Di6362DsagBM7G9dEy47/GbCyyaB/DjShtiTncrPds0kyKkfetW18kbdKLsumWESW5//ej2AVB
 zdXXrOkyHftAktRtbXvb0DZCYE/aPt2KuxT1cxwaXPCvTZgUypfQRMYu7oLZF8Sy2HyFl49kpO
 OPih9vjfUwgMLu7mByybRyKbG4fUR/KpWylboRNZQ5wPp/4OaIVCdxaotAxlew42i8Koa/yQOv
 Z/8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:49:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJmZ38mqz1SVp7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:49:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655423355; x=1658015356; bh=ZMytOujssEcOtiMdUCJ4EFf5UjhPhqNXGPu
        MIYgyGew=; b=MY2781I8P6QIuOKbf4C3D9c+m5zqpH7HokQLlBMboN4Ua0KoU42
        pCuCGXhZf8PFV5ug93eb1GQgeKi92dJVfhGyCSkwYKnFRNKwXHoWOi3r7wu4yaGi
        7fZ+3omss2hUB2EerxihsAEAZM4copG9FcGA9SCGv/qqzNB5rzqjXmjT41kUuBQ6
        JJYpEReR7bfcuCTwuMjsuyP5CXO5l59uWXwgQhkBNBH2/wBxrMZQ3/+3iE41bRSc
        yXnDpeRSXe0Xq6YyDC27aDZr5V0WvgnHpQWTz/8n47zSJ7IyT6BJ6rPkYeWUDcys
        kFHOpeJw0QdXutgSEx1baEmTl1TpposmbjQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BVwiY3MQVJ2x for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 16:49:15 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJmQ3YPgz1Rvlc;
        Thu, 16 Jun 2022 16:49:10 -0700 (PDT)
Message-ID: <0c4f30f2-c206-0201-31e3-fbb9edbdf666@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:49:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
 <20220615101920.329421-14-p.raghav@samsung.com>
 <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
 <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 01:12, Pankaj Raghav wrote:
> Hi Damien,
> On 2022-06-15 13:49, Damien Le Moal wrote:
>> On 6/15/22 19:19, Pankaj Raghav wrote:
>>> Only power of 2(po2) zoned devices were supported in linux but now non
>>> power of 2(npo2) zoned device support has been added to the block layer.
>>>
>>> Filesystems such as F2FS and btrfs have support for zoned devices with
>>> po2 zone size assumption. Before adding native support for npo2 zoned
>>> devices, it was suggested to create a dm target for npo2 zoned device to
>>> appear as po2 device so that file systems can initially work without any
>>> explicit changes by using this target.
>>>
>>> The design of this target is very simple: introduce gaps between the zone
>>> capacity and the po2 zone size of the underlying device. All IOs will be
>>> remapped from target to the actual device location. For devices that use
>>> zone append, the bi_sector is remapped from device to target's layout.
>>
>> Nothing special for zone append in this respect. All IOs are remapped
>> likewise, right ?
>>
> This is what is being done: when we submit, we adjust the sector value
> from target to device, and the actual sector value from bio gets updated
> in the endio function where we transform from device -> target for zone
> appends.

I know all that. This was a remark intended at pointing out that this
commit message statement does not have any value, it does not help in
understanding any peculiarity of this target driver (if any). It seems
targeted at zone append only. Reword this to explain the remapping for all
IOs, and that zone management request and report zones also need remapping.

>>>
>>> The read IOs that fall in the "emulated" gap area will return 0 and all
>>> the other IOs in that area will result in an error. If an read IO span
>>> across the zone capacity boundary, then the IOs are split between the
>>> boundary. All other IO operations that span across a zone capacity
>>> boundary will result in an error.
>>>
>>> The target can be easily updated as follows:
>>
>> Updated ? you mean created, no ?
>>
> Yeah. I will fix it.
>>> dmsetup create <label> --table '0 <size_sects> zoned-npo2 /dev/nvme<id>'
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> Suggested-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>  drivers/md/Kconfig                |   9 +
>>>  drivers/md/Makefile               |   2 +
>>>  drivers/md/dm-zone.c              |   9 +
>>>  drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
>>>  4 files changed, 288 insertions(+)
>>>  create mode 100644 drivers/md/dm-zoned-npo2-target.c
>>>
>>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>>> index 998a5cfdb..773314536 100644
>>> --- a/drivers/md/Kconfig
>>> +++ b/drivers/md/Kconfig
>>> @@ -518,6 +518,15 @@ config DM_FLAKEY
>>>  	help
>>>  	 A target that intermittently fails I/O for debugging purposes.
>>>  
>>> +config DM_ZONED_NPO2
>>> +	tristate "Zoned non power of 2 target"
>>> +	depends on BLK_DEV_DM
>>> +	depends on BLK_DEV_ZONED
>>> +	help
>>> +	A target that converts a zoned device with non power of 2 zone size to
>>> +	be power of 2. This is done by introducing gaps in between the zone
>>> +	capacity and the power of 2 zone size.
>>> +
>>>  config DM_VERITY
>>>  	tristate "Verity target support"
>>>  	depends on BLK_DEV_DM
>>> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
>>> index 0454b0885..2863a94a7 100644
>>> --- a/drivers/md/Makefile
>>> +++ b/drivers/md/Makefile
>>> @@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
>>>  dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
>>>  dm-verity-y	+= dm-verity-target.o
>>>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
>>> +dm-zoned-npo2-y       += dm-zoned-npo2-target.o
>>
>> This naming is in my opinion very bad as it seems related to the dm-zoned
>> target. e.g. dm-po2z, dm-zp2, etc.
>>
> Probably dm-po2z sounds good. I will go for it if others don't have any
> objection.
>>>  
>>>  md-mod-y	+= md.o md-bitmap.o
>>>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
>>> @@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
>>>  obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
>>>  obj-$(CONFIG_DM_DUST)		+= dm-dust.o
>>>  obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
>>> +obj-$(CONFIG_DM_ZONED_NPO2)	+= dm-zoned-npo2.o
>>>  obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
>>>  obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
>>>  obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
>>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>>> index af36d33f9..5efb31ba0 100644
>>> --- a/drivers/md/dm-zone.c
>>> +++ b/drivers/md/dm-zone.c
>>> @@ -210,6 +210,11 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
>>>  		}
>>>  		md->zwp_offset[idx] = dm_get_zone_wp_offset(zone);
>>>  
>>> +		if (q->limits.chunk_sectors != zone->len) {
>>
>> Why is this if needed ?
>>
> Explanation below.
>>> +			blk_queue_chunk_sectors(q, zone->len);
>>> +			q->nr_zones = blkdev_nr_zones(md->disk);
>>> +		}
>>> +
>>>  		break;
>>>  	default:
>>>  		DMERR("Invalid zone type 0x%x at sectors %llu",
>>> @@ -307,6 +312,9 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>>>  	if (dm_table_supports_zone_append(t)) {
>>>  		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
>>>  		dm_cleanup_zoned_dev(md);
>>> +
>>
>> no need for the blank line.
>>
>>> +		if (!is_power_of_2(blk_queue_zone_sectors(q)))
>>> +			goto revalidate_zones;
>>>  		return 0;
>>>  	}
>>
>> Why do you need to change dm_set_zones_restrictions() at all ?
>>
> When the device mapper is created, the q->limits gets inherited from the
> underlying device. The chunk sectors of the target and the device will
> be the same but we want the chunk sector of the target to be different
> (rounded to po2) compared to the underlying device's chunk sector. This
> needs to be done only for the dm-po2z target and not for other targets
> that uses npo2 zoned devices (like dm-linear). So to perform this
> operation in a target independent way in dm-zone.c, I chose to always
> revalidate npo2 zoned device and update the chunk sector and nr_zones in
> dm_zone_revalidate_cb based on the zone information from the target.
> This allows to set the limits correctly for dm-po2z target.

But DM revalidate will be called for the target AFTER it is setup (after
its gendisk is added). So how can DM revalidate see the incorrect zone
size ? If that is the case, then the target constructor is broken or
missing something. DM revalidate zone is generic and only allocates the
zone bitmaps for the target device. There should be not need at all to
touch that function.

>>>  
> <snip>
> return -EINVAL;
>>> +	}
>>> +
>>> +	if (is_power_of_2(zsze)) {
>>> +		DMERR("%pg zone size is power of 2", dmh->dev->bdev);
>>
>> Hmmm... You would end up with no remapping needed so it would still
>> work... Why error this ? A warning would work too.
>>
> You mean a DMWARN and not return -EINVAL? I mean there is no usecase for
> po2 device to use this target so why allow it in the first place?

Why disallow it ? It will work. Either way is OK but I wanted to point out
that both path are I think equally valid.

>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dmh->zsze = zsze;
>>> +	dmh->zsze_po2 = 1 << get_count_order_long(zsze);
>>> +	dmh->zsze_diff = dmh->zsze_po2 - dmh->zsze;
>>> +
>>> +	ti->private = dmh;
>>> +	ti->num_flush_bios = 1;
>>> +	ti->num_discard_bios = 1;
>>> +	ti->num_secure_erase_bios = 1;
>>> +	ti->num_write_zeroes_bios = 1;
>>
>> Why all these ? I know dm-linear do that but I do not see why they would
>> be necessary for a single device target.
>>
> Good point. I will remove them
> 
> <snip>
>>> +		return DMZ_NPO2_IO_INSIDE_ZONE;
>>> +	else if (relative_sect >= dmh->zsze)
>>
>> no need for the else. And this is super confusing. This case correspond to
>> the BIO going beyond the zone capacity in the target address space,
>> meaning it is still WITHIN the target zone. But you call that "outside"
>> because it is for the device zone. Super confusing. It took me a lot of
>> rereading to finally get it.
>>
> Probably my naming choice was not correct here for the enum. It should
> be s/IO_INSIDE_ZONE/IO_INSIDE_ZONE_CAP, etc to be clear. I mainly wanted
> to handle the case where a read across zone capacity should return
> something valid instead of just an error as we emulate the LBAs from
> zone cap to zone size.

Your target information fields are also badly named and make things hard
to understand.

> 
> DMZ_NPO2_IO_INSIDE_ZONE_CAP:
>              zcap   zsize
> ---------------|-----|
>       <------>
>         bio
> Normal scenario we just send what is there in the device.
> 
> 
> DMZ_NPO2_IO_OUTSIDE_ZONE_CAP:
>              zcap       zsize
> ---------------|---------|
>                  <---->
>                    bio
> 
> Read should return zero filled bio and other operation will return an
> error because we are touching the emulated area.
> 
> DMZ_NPO2_IO_ACROSS_ZONE_CAP:
>              zcap   zsize
> ---------------|-----|
>            <------>
>               bio
> For reads, the bio should be split across zone cap and the bio on the
> left hand side returns what is there in the device and the split bio on
> the right hand side should just return zeroes. All other requests will
> return an error.
> 
>>> +		return DMZ_NPO2_IO_OUTSIDE_ZONE;
>>> +
>>> +	return DMZ_NPO2_IO_ACROSS_ZONE;
>>
>> So you BIO is eeither fully contained within the zone or it is not. So why
>> not just return a bool ?
>>
> As I explained above, I was considering the boundary as zone cap inside
> a zone. The bio can be within zone cap, across zone cap into the
> emulated zone size and outside zone capacity.
> 
> I didn't take into account the read across zone. I will make sure it is
> correctly handled in the next revision.

Please test properly. This should have been caught in testing before sending.

> 
>              zcap  zsize          zcap
> ---------------|-----|--------------|
>                   <------>
>                      bio
>>> +}
>>> +
>>> +static void split_io_across_zone_boundary(struct dmz_npo2_target *dmh,
>>> +					  struct bio *bio)
>>> +{
>>> +	sector_t sect = bio->bi_iter.bi_sector;
>>> +	sector_t sects_from_zone_start;
>>> +
>>> +	sect = target_to_device_sect(dmh, sect);
>>
>> 	sect = target_to_device_sect(dmh, bio->bi_iter.bi_sector);
>>
>> is more readable.
>>
>>> +	div64_u64_rem(sect, dmh->zsze, &sects_from_zone_start);
>>> +	dm_accept_partial_bio(bio, dmh->zsze - sects_from_zone_start);
>>
>> So if this is a read BIO starting exactly at the target zone capacity
>> (sects_from_zone_start == zsze), then you accept 0 sectors ? What am I
>> missing here ?
>>
> Your condition will not even touch this function. This function comes
> into play only when the bio runs across the zone capacity as I mentioned
> before.
>>> +	bio->bi_iter.bi_sector = sect;
>>> +}
>>> +
>>> +static int handle_zone_boundary_violation(struct dmz_npo2_target *dmh,
>>> +					  struct bio *bio,
>>> +					  enum dmz_npo2_io_cond cond)
>>> +{
>>> +	/* Read should return zeroed page */
>>> +	if (bio_op(bio) == REQ_OP_READ) {
>>> +		if (cond == DMZ_NPO2_IO_ACROSS_ZONE) {
>>> +			split_io_across_zone_boundary(dmh, bio);
>>> +			return DM_MAPIO_REMAPPED;
>>> +		}
>>> +		zero_fill_bio(bio);
>>> +		bio_endio(bio);
>>> +		return DM_MAPIO_SUBMITTED;
>>> +	}
>>> +	return DM_MAPIO_KILL;
>>> +}
>>> +
>>> +static int dmz_npo2_end_io(struct dm_target *ti, struct bio *bio,
>>> +			   blk_status_t *error)
>>> +{
>>> +	struct dmz_npo2_target *dmh = ti->private;
>>> +
>>> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
>>> +		bio->bi_iter.bi_sector =
>>> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
>>> +
>>> +	return DM_ENDIO_DONE;
>>> +}
>>> +
>>> +static int dmz_npo2_map(struct dm_target *ti, struct bio *bio)
>>> +{
>>> +	struct dmz_npo2_target *dmh = ti->private;
>>> +	enum dmz_npo2_io_cond cond;
>>> +
>>> +	bio_set_dev(bio, dmh->dev->bdev);
>>> +	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
>>> +		cond = check_zone_boundary_violation(dmh, bio->bi_iter.bi_sector,
>>> +						     bio->bi_iter.bi_size >> SECTOR_SHIFT);
>>
>> Why check this for zone management BIOs ? These have length = 0, always.
>>
>>> +
>>> +		/*
>>> +		 * If the starting sector is in the emulated area then fill
>>> +		 * all the bio with zeros. If bio is across boundaries,
>>> +		 * split the bio across boundaries and fill zeros only for the
>>> +		 * bio that is outside the zone capacity
>>> +		 */
>>> +		switch (cond) {
>>> +		case DMZ_NPO2_IO_INSIDE_ZONE:
>>> +			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
>>> +								       bio->bi_iter.bi_sector);
>>> +			break;
>>> +		case DMZ_NPO2_IO_ACROSS_ZONE:
>>> +		case DMZ_NPO2_IO_OUTSIDE_ZONE:
>>> +			return handle_zone_boundary_violation(dmh, bio, cond);
>>> +		}
>>> +	}
>>> +	return DM_MAPIO_REMAPPED;
>>
>> This entire function is very hard to read because everything is hidden in
>> helpers that are not super useful in my opinion. I would prefer seeing
>> cases for:
>> * zone management BIOs
>> * Reads and writes
>> * Everything else
>>
>> where tests against the bio sector and length are visible, so one can
>> understand what is going on. If you need helpers, have handle_zone_mgmt(),
>> handle_read() etc. Something clear.
>>
> Got it. I see the confusion here. I will rearrange it properly in the
> next revision. Thanks for this comment.
>>> +}
>>> +
>>> +static int dmz_npo2_iterate_devices(struct dm_target *ti,
>>> +				    iterate_devices_callout_fn fn, void *data)
>>> +{
>>> +	struct dmz_npo2_target *dmh = ti->private;
>>> +	sector_t len = 0;
>>> +
>>> +	len = dmh->nr_zones * dmh->zsze;
>>
>> Move this to the declaration instead of setting len to 0 for nothing.
>>
> Ok.
>>> +	return fn(ti, dmh->dev, 0, len, data);
> 


-- 
Damien Le Moal
Western Digital Research
