Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE659135A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiHLP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbiHLP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:57:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F456ACA34
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660319838; x=1691855838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ivWCmtcKObajXTb64gQw6NqZXTRUIX+bqGfcqguzbqU=;
  b=dybwJNfk9YOBGriywguyL7c6Htdc/Nad3p3LHYgra8gBwrjuPTZV/353
   tiusArpcua+1FlS/sKJcdlz6s6x+Z9jdX1Qq9VHawSoS4xIat274RT9/m
   uJ6dawQaeECo6yylgGjr6f8P2X6ER15GLKoIYwKe3c8762DCuwMRP05QF
   ZYBLiMNhtIcsEOP8X7jmP1jna+N+uSWdFsrVBAJ1aTZICz8SHgT7uPiXG
   Ia+rEPzmpE9PQgLzvhlKjD2j2+tX9fab2glMZNIT9+GGk38T2MZNvYdoK
   K63DcZNJzbbw5o8tGjkxshNM0sht9Icvn/9Va0oWJPLfTpy3yLVrAqjeU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="209100940"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2022 23:57:15 +0800
IronPort-SDR: q+bAVcab8SsNSahQ1lw2TIglQm16iYQKbCHm2kzZcKQgHyzO+fSdlb+Cxn4ggayPuq4/WXurjj
 DKUr8ppsF8/vGY7ZV4hXlE/iervgK0rs1bPko9gp7SjdTvAoC6KiFXRhGyTPrbq13alxWZiok/
 lrTEG+ex69vk5T67CJiThCofOdpX02woBZQXn+fJZBzOKqYidamhDzcp3kLKWo09COUDd3mjRp
 7Fkf6NkShaEx7Zx94Ua1f4e8usEfqWVfo2Lz4FnqDi1MwRKytgaQROV61Q60Fxw+ahs+5lKRsc
 IwtDjyS+G6DzLrw/nSJzQ6bA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 08:18:08 -0700
IronPort-SDR: EHmI8mGyLW5tVd5A8YtqywRO5v/au8vR0JDIOEYlLioAnNR5wAfWn6ha+CtIsxu+IVWQIX4rAJ
 jMAvRs8ib4dlsz1Prp5J+IFpBzCObUOJU6Uwyb8aH7Zd0kMLgBfimgtjaH6WldZDua2VW7llRy
 urEv3LdkfqLM0EEXkFmUBDiqRGJ4oRKseiUK1JnJ5IqNF8xfLwvouNj0tPDoOR9vMlATQhRC9G
 UwMiDTGf0p+95yEWn2hsLYRyHRhpgCd630+0AE6s7f6zC9qDcJzD2LvmyTCSvR8riyns3DuhWB
 bTI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2022 08:57:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M47bb0dp1z1RwsB
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:57:14 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660319831; x=1662911832; bh=ivWCmtcKObajXTb64gQw6NqZXTRUIX+bqGf
        cqguzbqU=; b=q+0fOWbP++Sh1sQFTGQyIjTEZLogao15tyIVpt4ulmhqZELxylC
        5kva/QUJkTO7sXJ3NlFThrhDe2LZ2HWcn8naumhybO2yndvj2DmQLA8MVrCeZUWV
        n2BlrT3ZwrNn3s/Y9kGH0QaE4OwWHvufOjyFNlJLDspSZ2eEmwl1GVMWDynvSfNI
        bLY0QzaCKTBAZQfzfgzln71r1kswBsJ7wrk0/y97nz7WgpBQpCpa3XChkbOwLBJC
        jKvzp1n1nUiumOOJlBB3sOsEHZij22bwhpXm7oEn9algxVvyI26XPNpK85fvHWKo
        QgwiG5WlB/rjjzT+maWW/q0r7Pohd5USDeA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jq4Nci6ZzXL6 for <linux-kernel@vger.kernel.org>;
        Fri, 12 Aug 2022 08:57:11 -0700 (PDT)
Received: from [10.225.89.57] (cnd1221sqt.ad.shared [10.225.89.57])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M47bT00yTz1RtVk;
        Fri, 12 Aug 2022 08:57:08 -0700 (PDT)
Message-ID: <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
Date:   Fri, 12 Aug 2022 08:57:08 -0700
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220811143043.126029-14-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/08/11 7:30, Pankaj Raghav wrote:
> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 size zoned target so that file systems can initially work
> without any explicit changes by using this target.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> number of sectors.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> 
> Note that the target does not support partial mapping of the underlying
> device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Joel Granados <j.granados@samsung.com>
> ---
>  .../admin-guide/device-mapper/dm-po2zone.rst  |  71 +++++
>  .../admin-guide/device-mapper/index.rst       |   1 +
>  drivers/md/Kconfig                            |  10 +
>  drivers/md/Makefile                           |   2 +
>  drivers/md/dm-po2zone-target.c                | 245 ++++++++++++++++++
>  5 files changed, 329 insertions(+)
>  create mode 100644 Documentation/admin-guide/device-mapper/dm-po2zone.rst
>  create mode 100644 drivers/md/dm-po2zone-target.c
> 
> diff --git a/Documentation/admin-guide/device-mapper/dm-po2zone.rst b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> new file mode 100644
> index 000000000000..19dc215fbcca
> --- /dev/null
> +++ b/Documentation/admin-guide/device-mapper/dm-po2zone.rst
> @@ -0,0 +1,71 @@
> +==========
> +dm-po2zone
> +==========
> +The dm-po2zone device mapper target exposes a zoned block device with a
> +non-power-of-2(npo2) number of sectors per zone as a power-of-2(po2)
> +number of sectors per zone(zone size).
> +The filesystems that support zoned block devices such as F2FS and BTRFS
> +assume po2 zone size as the kernel has traditionally only supported
> +those devices. However, as the kernel now supports zoned block devices with
> +npo2 zone sizes, the filesystems can run on top of the dm-po2zone target before
> +adding native support.
> +
> +Partial mapping of the underlying device is not supported by this target.
> +
> +Algorithm
> +=========
> +The device mapper target maps the underlying device's zone size to the
> +zone capacity and changes the zone size to the nearest po2 zone size.
> +The gap between the zone capacity and the zone size is emulated in the target.
> +E.g., a zoned block device with a zone size (and capacity) of 3M will have an
> +equivalent target layout with mapping as follows:
> +
> +::
> +
> +  0M           3M  4M        6M 8M
> +  |             |  |          |  |
> +  +x------------+--+x---------+--+x-------  Target
> +  |x            |  |x         |  |x
> +   x               x             x
> +   x               x             x
> +   x              x             x
> +   x             x             x
> +  |x            |x            |x
> +  +x------------+x------------+x----------  Device
> +  |             |             |
> +  0M           3M            6M
> +
> +A simple remap is performed for all the BIOs that do not cross the
> +emulation gap area, i.e., the area between the zone capacity and size.
> +
> +If a BIO crosses the emulation gap area, the following operations are performed:
> +
> +	Read:
> +		- If the BIO lies entirely in the emulation gap area, then zero out the BIO and complete it.
> +		- If the BIO spans the emulation gap area, split the BIO across the zone capacity boundary
> +                  and remap only the BIO within the zone capacity boundary. The other part of the split BIO
> +                  will be zeroed out.
> +
> +	Other operations:
> +                - Return an error
> +
> +Table parameters
> +================
> +
> +::
> +
> +  <dev path>
> +
> +Mandatory parameters:
> +
> +    <dev path>:
> +        Full pathname to the underlying block-device, or a
> +        "major:minor" device-number.
> +
> +Examples
> +========
> +
> +::
> +
> +  #!/bin/sh
> +  echo "0 `blockdev --getsz $1` po2zone $1" | dmsetup create po2z
> diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
> index cde52cc09645..1fd04b5b0565 100644
> --- a/Documentation/admin-guide/device-mapper/index.rst
> +++ b/Documentation/admin-guide/device-mapper/index.rst
> @@ -23,6 +23,7 @@ Device Mapper
>      dm-service-time
>      dm-uevent
>      dm-zoned
> +    dm-po2zone
>      era
>      kcopyd
>      linear
> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index 998a5cfdbc4e..638801b2449a 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -518,6 +518,16 @@ config DM_FLAKEY
>  	help
>  	 A target that intermittently fails I/O for debugging purposes.
>  
> +config DM_PO2ZONE
> +	tristate "Zoned block devices target emulating a power-of-2 number of sectors per zone"
> +	depends on BLK_DEV_DM
> +	depends on BLK_DEV_ZONED
> +	help
> +	  A target that converts a zoned block device with non-power-of-2(npo2)
> +	  number of sectors per zone to be power-of-2(po2). Use this target for
> +	  zoned block devices with npo2 number of sectors per zone until native
> +	  support is added to the filesystems and applications.
> +
>  config DM_VERITY
>  	tristate "Verity target support"
>  	depends on BLK_DEV_DM
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 84291e38dca8..c23f81cc8789 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
>  dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
>  dm-verity-y	+= dm-verity-target.o
>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
> +dm-po2zone-y	+= dm-po2zone-target.o
>  
>  md-mod-y	+= md.o md-bitmap.o
>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
> @@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
>  obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
>  obj-$(CONFIG_DM_DUST)		+= dm-dust.o
>  obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
> +obj-$(CONFIG_DM_PO2ZONE)	+= dm-po2zone.o
>  obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
>  obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
>  obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
> diff --git a/drivers/md/dm-po2zone-target.c b/drivers/md/dm-po2zone-target.c
> new file mode 100644
> index 000000000000..d7610463245d
> --- /dev/null
> +++ b/drivers/md/dm-po2zone-target.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Samsung Electronics Co., Ltd.
> + */
> +
> +#include <linux/device-mapper.h>
> +
> +#define DM_MSG_PREFIX "po2zone"
> +
> +struct dm_po2z_target {
> +	struct dm_dev *dev;
> +	sector_t zone_size; /* Actual zone size of the underlying dev*/
> +	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
> +	unsigned int zone_size_po2_shift;
> +	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
> +	unsigned int nr_zones;
> +};
> +
> +static inline unsigned int npo2_zone_no(struct dm_po2z_target *dmh,
> +					sector_t sect)
> +{
> +	return div64_u64(sect, dmh->zone_size);
> +}
> +
> +static inline unsigned int po2_zone_no(struct dm_po2z_target *dmh,
> +				       sector_t sect)
> +{
> +	return sect >> dmh->zone_size_po2_shift;
> +}
> +
> +static inline sector_t target_to_device_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect - (po2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +static inline sector_t device_to_target_sect(struct dm_po2z_target *dmh,
> +					     sector_t sect)
> +{
> +	return sect + (npo2_zone_no(dmh, sect) * dmh->zone_size_diff);
> +}
> +
> +/*
> + * This target works on the complete zoned device. Partial mapping is not
> + * supported.
> + * Construct a zoned po2 logical device: <dev-path>
> + */
> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> +{
> +	struct dm_po2z_target *dmh = NULL;
> +	int ret;
> +	sector_t zone_size;
> +	sector_t dev_capacity;
> +
> +	if (argc != 1)
> +		return -EINVAL;
> +
> +	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
> +	if (!dmh)
> +		return -ENOMEM;
> +
> +	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
> +			    &dmh->dev);
> +	if (ret) {
> +		ti->error = "Device lookup failed";
> +		kfree(dmh);
> +		return ret;
> +	}
> +
> +	if (!bdev_is_zoned(dmh->dev->bdev)) {
> +		DMERR("%pg is not a zoned device", dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	zone_size = bdev_zone_sectors(dmh->dev->bdev);
> +	dev_capacity = get_capacity(dmh->dev->bdev->bd_disk);
> +	if (ti->len != dev_capacity || ti->begin) {
> +		DMERR("%pg Partial mapping of the target not supported",
> +		      dmh->dev->bdev);
> +		kfree(dmh);
> +		return -EINVAL;
> +	}
> +
> +	if (is_power_of_2(zone_size))
> +		DMWARN("%pg: underlying device has a power-of-2 number of sectors per zone",
> +		       dmh->dev->bdev);
> +
> +	dmh->zone_size = zone_size;
> +	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
> +	dmh->zone_size_po2_shift = ilog2(dmh->zone_size_po2);
> +	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
> +	ti->private = dmh;
> +	ti->max_io_len = dmh->zone_size_po2;
> +	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
> +	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
> +
> +	return 0;
> +}
> +
> +static int dm_po2z_report_zones_cb(struct blk_zone *zone, unsigned int idx,
> +				   void *data)
> +{
> +	struct dm_report_zones_args *args = data;
> +	struct dm_po2z_target *dmh = args->tgt->private;
> +
> +	zone->start = device_to_target_sect(dmh, zone->start);
> +	zone->wp = device_to_target_sect(dmh, zone->wp);
> +	zone->len = dmh->zone_size_po2;
> +	args->next_sector = zone->start + zone->len;
> +
> +	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
> +}
> +
> +static int dm_po2z_report_zones(struct dm_target *ti,
> +				struct dm_report_zones_args *args,
> +				unsigned int nr_zones)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t sect = po2_zone_no(dmh, args->next_sector) * dmh->zone_size;
> +
> +	return blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
> +				   dm_po2z_report_zones_cb, args);
> +}
> +
> +static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
> +			  blk_status_t *error)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
> +		bio->bi_iter.bi_sector =
> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
> +
> +	return DM_ENDIO_DONE;
> +}
> +
> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	limits->chunk_sectors = dmh->zone_size_po2;
> +}
> +
> +static bool bio_across_emulated_zone_area(struct dm_po2z_target *dmh,
> +					  struct bio *bio)
> +{
> +	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
> +	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +	return (bio->bi_iter.bi_sector + nr_sectors) >
> +	       (zone_idx << dmh->zone_size_po2_shift) + dmh->zone_size;
> +}
> +
> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
> +					  struct bio *bio)

This really should be called dm_po2z_handle_read() since it handles both cases
of read commands, with and without the accept partial. Note that this is
retesting the need for a split after that was already tested in dm_po2z_map()
with bio_across_emulated_zone_area(). So the code should be better organized to
avoid that repetition.

You can simplify the code by having bio_across_emulated_zone_area() return 0 for
a bio that does not cross the zone capacity and return the number of sectors up
to the zone capacity from the bio start if there is a cross. That value can then
be used to call dm_accept_partial_bio() directly in dm_po2z_map() for read
commands. That will make this function much simpler and essentially turn it into
dm_po2z_read_zeroes().

> +{
> +	sector_t start_sect = bio->bi_iter.bi_sector;
> +	unsigned int zone_idx = po2_zone_no(dmh, start_sect);
> +	sector_t relative_sect_in_zone = start_sect - (zone_idx << dmh->zone_size_po2_shift);

Long line. Please split it after the "=".

> +	sector_t split_io_pos;
> +
> +	/*
> +	 * If the starting sector is in the emulated area then fill
> +	 * all the bio with zeros. If bio is across emulated zone boundary,
> +	 * split the bio across boundaries and fill zeros only for the
> +	 * bio that is between the zone capacity and the zone size.
> +	 */
> +	if (relative_sect_in_zone < dmh->zone_size) {
> +		split_io_pos = (zone_idx * dmh->zone_size_po2) + dmh->zone_size;

Use bit shift here please.

> +		dm_accept_partial_bio(bio, split_io_pos - start_sect);
> +		bio->bi_iter.bi_sector = target_to_device_sect(dmh, start_sect);
> +
> +		return DM_MAPIO_REMAPPED;
> +	}
> +
> +	zero_fill_bio(bio);
> +	bio_endio(bio);
> +	return DM_MAPIO_SUBMITTED;
> +}
> +
> +static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +
> +	bio_set_dev(bio, dmh->dev->bdev);
> +	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
> +		if (!bio_across_emulated_zone_area(dmh, bio)) {
> +			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
> +								       bio->bi_iter.bi_sector);

Long line. Split it after "=".

> +			return DM_MAPIO_REMAPPED;
> +		}
> +		/*
> +		 * Read operation on the emulated zone area (between zone capacity
> +		 * and zone size) will fill the bio with zeroes. Any other operation
> +		 * in the emulated area should return an error.
> +		 */
> +		if (bio_op(bio) == REQ_OP_READ)
> +			return dm_po2z_map_read_emulated_area(dmh, bio);
> +
> +		return DM_MAPIO_KILL;
> +	}
> +	return DM_MAPIO_REMAPPED;
> +}
> +
> +static int dm_po2z_iterate_devices(struct dm_target *ti,
> +				   iterate_devices_callout_fn fn, void *data)
> +{
> +	struct dm_po2z_target *dmh = ti->private;
> +	sector_t len = dmh->nr_zones * dmh->zone_size;
> +
> +	return fn(ti, dmh->dev, 0, len, data);
> +}
> +
> +static struct target_type dm_po2z_target = {
> +	.name = "po2zone",
> +	.version = { 1, 0, 0 },
> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,
> +	.map = dm_po2z_map,
> +	.end_io = dm_po2z_end_io,
> +	.report_zones = dm_po2z_report_zones,
> +	.iterate_devices = dm_po2z_iterate_devices,
> +	.module = THIS_MODULE,
> +	.io_hints = dm_po2z_io_hints,
> +	.ctr = dm_po2z_ctr,
> +};
> +
> +static int __init dm_po2z_init(void)
> +{
> +	return dm_register_target(&dm_po2z_target);
> +}
> +
> +static void __exit dm_po2z_exit(void)
> +{
> +	dm_unregister_target(&dm_po2z_target);
> +}
> +
> +/* Module hooks */
> +module_init(dm_po2z_init);
> +module_exit(dm_po2z_exit);
> +
> +MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
> +MODULE_LICENSE("GPL");
> +


-- 
Damien Le Moal
Western Digital Research
