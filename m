Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29258666E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiHAIfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiHAIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:35:39 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A52BB02
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:35:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220801083533euoutp018fa77cacdc803111b4055e2b57c2b6ef~HK5tbhLaA2822728227euoutp01g
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:35:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220801083533euoutp018fa77cacdc803111b4055e2b57c2b6ef~HK5tbhLaA2822728227euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659342934;
        bh=HP8eD/aMT3AKaAJ2WAD6d8FpKTpf52a++/hiDHxi5m0=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=V9IjGG2VIY5pbJ2/pzLFuszcamUnloxHJCETXPT0hbw2xpJw8FQkCLUD2nrMdodUZ
         9muzwh77JS0ZXsEv8HSb0SeL4eoH7GlHwO1Dbg4e6ZSQ3ul0lMtKZQ1uHglpXLFiPj
         qCqJzzXouF+n/KqUNXCYtbX7lU5EJo+bazBNVmbs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220801083533eucas1p20ad0406141285ffc91e66b3e5cf3afe6~HK5s0RomX3271232712eucas1p2c;
        Mon,  1 Aug 2022 08:35:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.74.10067.55097E26; Mon,  1
        Aug 2022 09:35:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220801083532eucas1p2a193e31e0acae5e6f5b1507fe38a8e6d~HK5sTWaOn3271232712eucas1p2b;
        Mon,  1 Aug 2022 08:35:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220801083532eusmtrp2af5e516ad8286a967fedc71d5436a4d5~HK5sSYfp_0819408194eusmtrp2S;
        Mon,  1 Aug 2022 08:35:32 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-c3-62e790550efe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.2D.09038.45097E26; Mon,  1
        Aug 2022 09:35:32 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220801083532eusmtip17bc75bc5a969fc37f3bc9b5c20a11d18~HK5sFE1On0213002130eusmtip1F;
        Mon,  1 Aug 2022 08:35:32 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.8) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 1 Aug 2022 09:35:30 +0100
Message-ID: <24f29103-e7d5-abee-cc2a-30d4f8930dba@samsung.com>
Date:   Mon, 1 Aug 2022 10:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [PATCH v8 11/11] dm: add power-of-2 zoned target for
 non-power-of-2 zoned devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <snitzer@kernel.org>,
        <Johannes.Thumshirn@wdc.com>
CC:     <matias.bjorling@wdc.com>, <gost.dev@samsung.com>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>,
        <linux-block@vger.kernel.org>, <pankydev8@gmail.com>,
        <bvanassche@acm.org>, <jaegeuk@kernel.org>, <dm-devel@redhat.com>,
        <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <8fc11ae3-ddc4-4509-5374-04722a740bde@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.8]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7qhE54nGUzfwGex+m4/m8W0Dz+Z
        LX6fPc9s0dr+jcli77vZrBZ7Fk1isli5+iiTxZP1s5gt/nbdA0rc0ra4vGsOm8X8ZU/ZLSa0
        fWW2WHPzKYvFiVvSDvwel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOBzWNn631Wj/f7rgKF
        Tld7fN4k59F+oJspgDuKyyYlNSezLLVI3y6BK2PZs1mMBdfjK848nM/awPjDp4uRg0NCwERi
        1Vsgk4tDSGAFo8S5yV3MEM4XRol1a3+zQTifGSWOfT/L2MXICdbRdaGLESKxnFHi1fsGJriq
        t0ufskM4Oxglvj97zQzSwitgJ3H70xswm0VAReLlj1NMEHFBiZMzn7CA2KICkRJrdp9lB7GF
        BRIkTp34AWYzC4hL3HoyH6xeRKCHUeLvbrDVzAIbmCS+nl3OBvIFm4CWRGMnWD2ngJvE5Ncf
        WSF6NSVat/+GmiMvsf3tHGaIFxQl+r9vYIOwayXWHjsDdrSEwC1OifvnLrFAJFwkNnzoYoWw
        hSVeHd/CDmHLSPzfCXGQhEC1xNMbv5khmlsYJfp3rmeDBKu1RN+ZHIgaR4n23tPMEGE+iRtv
        BSHu4ZOYtG068wRG1VlIQTELycuzkLwwC8kLCxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl
        5+duYgQmwtP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeO+4PE8S4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwOR06kbVthmsu0/Imfo9K7p591DQG2OOG7Pz
        WIJvq0R9fNCzq2dmoJe7O0exztraUGeNltjm7mP6O0+nl93PEMkNqHbqT54gccRtxXKe7pMS
        bEqLMhn3NSkmZRdHxGxc/MTEe/bP5BQfzRXPw9a3HulliYpPX/8zx/BY23QXPvNtl6Kzl0/X
        NjnhfuLs7Wb+Xz3st9pXHv++dubC561m/Iduc/tGCZzL2KOifK9AsKu4pd9n0fJp/fk7t7xm
        iPS5902pxmNDtEJQnP+13gaJmye7f6wR995VwfU/fF3VsbnLL780iu4Pm/XR615O9OL9d6tm
        qijNFJYp8i2302r4e+ZG+BT2g51KTu6vFULmKbEUZyQaajEXFScCALUMV1vzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xu7ohE54nGZxqUbdYfbefzWLah5/M
        Fr/Pnme2aG3/xmSx991sVos9iyYxWaxcfZTJ4sn6WcwWf7vuASVuaVtc3jWHzWL+sqfsFhPa
        vjJbrLn5lMXixC1pB36Py1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA5rGz9T6rx/t9V4FC
        p6s9Pm+S82g/0M0UwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OS
        mpNZllqkb5egl7Hs2SzGguvxFWcezmdtYPzh08XIySEhYCLRdaGLsYuRi0NIYCmjxJF7D1gg
        EjISn658ZIewhSX+XOtigyj6yChx4ck/qI4djBLn5i4Gq+IVsJO4/ekNM4jNIqAi8fLHKSaI
        uKDEyZlPwKaKCkRKPFzWBBYXFkiQOHXiB1gvs4C4xK0n88HiIgI9jBJ/d4MtYBbYwCTx9exy
        qNV/GCWufNwA1MHBwSagJdHYCdbMKeAmMfn1R1aIQZoSrdt/Qw2Vl9j+dg4zxAuKEv3fN7BB
        2LUSr+7vZpzAKDoLyX2zkNwxC8moWUhGLWBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iRGY
        QLYd+7llB+PKVx/1DjEycTAeYpTgYFYS4b3j8jxJiDclsbIqtSg/vqg0J7X4EKMpMJAmMkuJ
        JucDU1heSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPT2g26/AGb
        DlqY5oaut+9zXz5f9PMfg0zfp2sP8G3jUgiV//Zx1jazE6Hn+Bj0RHsPbHIM/792u0zAF56C
        STvfqtttP7Z8yxxnvfYKrlkn5b0+L+G+wRcuxbRYIuXfocDP0x1SrxksOsu+ff78zx+yOWJD
        D+dwHFxRvz7D7u5y33UnNkyf5fBr384HFu12VlsdJ6dt6Gv8Z+eb7qnXstjRat+N0KZGJvsH
        Gd+28d3ndNv/aBvbXqWHV90/M8bo+9tzaZzlCOvdlRJmWML7Re+c75W5a7nKat5HrbAJlmrZ
        +f3j5WN/F0S3M+7MMQjZn68ivcufUUnmzMwm7Y7SB4vdHkY8vnVaNduiWdJXw2+GEktxRqKh
        FnNRcSIA5lMpIakDAAA=
X-CMS-MailID: 20220801083532eucas1p2a193e31e0acae5e6f5b1507fe38a8e6d
X-Msg-Generator: CA
X-RootMTR: 20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162257eucas1p2848a75c4aa7e559abb5d9ae0fbd374c1@eucas1p2.samsung.com>
        <20220727162245.209794-12-p.raghav@samsung.com>
        <8fc11ae3-ddc4-4509-5374-04722a740bde@opensource.wdc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 06:33, Damien Le Moal wrote:
>>
>> The area between target's zone capacity and zone size will be emulated
>> in the target.
>> The read IOs that fall in the emulated gap area will return 0 filled
>> bio and all the other IOs in that area will result in an error.
>> If a read IO span across the emulated area boundary, then the IOs are
>> split across them. All other IO operations that span across the emulated
>> area boundary will result in an error.
>>
>> The target can be easily created as follows:
>> dmsetup create <label> --table '0 <size_sects> po2z /dev/nvme<id>'
> 
> 0 -> <start offset> ? Or are you allowing only entire devices ?
> 
Yeah, partially mapping is not allowed.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
>> Suggested-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/md/Kconfig            |   9 ++
>>  drivers/md/Makefile           |   2 +
>>  drivers/md/dm-po2z-target.c   | 261 ++++++++++++++++++++++++++++++++++
>>  drivers/md/dm-table.c         |  13 +-
>>  drivers/md/dm-zone.c          |   1 +
>>  include/linux/device-mapper.h |   9 ++
>>  6 files changed, 292 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/md/dm-po2z-target.c
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index 998a5cfdbc4e..d58ccfee765b 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -518,6 +518,15 @@ config DM_FLAKEY
>>  	help
>>  	 A target that intermittently fails I/O for debugging purposes.
>>  
>> +config DM_PO2Z
> 
> Maybe DM_PO2_ZONE ?
> 
I prefer this.

> or DM_ZONE_PO2SIZE ?
> 
> To be clearer...
> 
>> +
>> +struct dm_po2z_target {
>> +	struct dm_dev *dev;
>> +	sector_t zone_size; /* Actual zone size of the underlying dev*/
>> +	sector_t zone_size_po2; /* zone_size rounded to the nearest po2 value */
>> +	sector_t zone_size_diff; /* diff between zone_size_po2 and zone_size */
>> +	u32 nr_zones;
> 
> s/u32/unsigned int. This is not a hw driver.
> 
Ok.
>> +}
>> +
>> +/*
>> + * This target works on the complete zoned device. Partial mapping is not
>> + * supported.
>> + * Construct a zoned po2 logical device: <dev-path>
>> + */
>> +static int dm_po2z_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>> +{
>> +	struct dm_po2z_target *dmh = NULL;
>> +	int ret;
>> +	sector_t zone_size;
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (is_power_of_2(zone_size)) {
>> +		DMERR("%pg: this target is not useful for power-of-2 zoned devices",
>> +		      dmh->dev->bdev);
>> +		return -EINVAL;
> 
> Same here.
> 
> And as suggested before, we could simply warn here but let the target be
> created. If used with a power of 2 zone size device, it should still work.
> 
I will do this in the next revision. I will change DMERR to DMWARN with
no return err.
>> +	}
>> +
>> +	dmh->zone_size = zone_size;
>> +	dmh->zone_size_po2 = 1 << get_count_order_long(zone_size);
>> +	dmh->zone_size_diff = dmh->zone_size_po2 - dmh->zone_size;
>> +	ti->private = dmh;
>> +	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
>> +	ti->len = dmh->zone_size_po2 * dmh->nr_zones;
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +static int dm_po2z_end_io(struct dm_target *ti, struct bio *bio,
>> +			  blk_status_t *error)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +
>> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
>> +		bio->bi_iter.bi_sector =
>> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
>> +
>> +	return DM_ENDIO_DONE;
>> +}
>> +
>> +static void dm_po2z_io_hints(struct dm_target *ti, struct queue_limits *limits)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +
>> +	limits->chunk_sectors = dmh->zone_size_po2;
>> +}
>> +
>> +static bool bio_across_emulated_zone_area(struct dm_po2z_target *dmh,
>> +					  struct bio *bio)
>> +{
>> +	u32 zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
>> +	sector_t size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> 
> Rename that to nr_sectors to be clear about the unit.
> 
>> +
>> +	return (bio->bi_iter.bi_sector - (zone_idx * dmh->zone_size_po2) +
>> +		size) > dmh->zone_size;
> 
> This is hard to read and actually seems very wrong. Shouldn't this be simply:
> 
> 	return bio->bi_iter.bi_sector + nr_sectors >
> 		zone_idx * dmh->zone_size_po2 + dmh->zone_size;
> 
> Thatis, check that the BIO goes beyond the zone capacity of the target.
> ?
> 
Yeah, this reads better. I will change it.
>> +}
>> +
>> +static int dm_po2z_map_read(struct dm_po2z_target *dmh, struct bio *bio)
>> +{
>> +	sector_t start_sect, size, relative_sect_in_zone, split_io_pos;
>> +	u32 zone_idx;
>> +
>> +	/*
>> +	 * Read does not extend into the emulated zone area (area between
>> +	 * zone capacity and zone size)
>> +	 */
>> +	if (!bio_across_emulated_zone_area(dmh, bio)) {
> 
> hu... why not use dm_accept_partial_bio() in dm_po2z_map() to never have
> to deal with this here ? That is, dm_po2z_map_read() is called for any
> read BIO fully within the zone capacity. And create a
> dm_po2z_map_read_zero() helper for any read BIO that is after the zone
> capacity. Way simpler I think.
> 
>> +		bio->bi_iter.bi_sector =
>> +			target_to_device_sect(dmh, bio->bi_iter.bi_sector);
>> +		return DM_MAPIO_REMAPPED;
>> +	}
>> +
>> +	start_sect = bio->bi_iter.bi_sector;
>> +	size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
>> +	zone_idx = po2_zone_no(dmh, start_sect);
>> +	relative_sect_in_zone = start_sect - (zone_idx * dmh->zone_size_po2);
>> +
>> +	/*
>> +	 * If the starting sector is in the emulated area then fill
>> +	 * all the bio with zeros. If bio is across emulated zone boundary,
>> +	 * split the bio across boundaries and fill zeros only for the
>> +	 * bio that is between the zone capacity and the zone size.
>> +	 */
>> +	if (relative_sect_in_zone < dmh->zone_size &&
>> +	    ((relative_sect_in_zone + size) > dmh->zone_size)) {
>> +		split_io_pos = (zone_idx * dmh->zone_size_po2) + dmh->zone_size;
>> +		dm_accept_partial_bio(bio, split_io_pos - start_sect);
> 
> See above. Do that in dm_po2z_map(). This will simplify this function.
> 
>> +		bio->bi_iter.bi_sector = target_to_device_sect(dmh, start_sect);
>> +
>> +		return DM_MAPIO_REMAPPED;
>> +	} else if (relative_sect_in_zone >= dmh->zone_size &&
>> +		   ((relative_sect_in_zone + size) > dmh->zone_size_po2)) {
> 
> No need for the else after return. And this can NEVER happen since BIOs
> can never cross zone boundaries.
> 
This did not happen and that is why this else if condition was
introduced. But I had missed assigning the t->max_io_len in the ctr
which led to bio crossing the zone boundary.

With t->max_io_len set to zone_nr_sectors, we don't need the else if
condition and we can simplify the map_read.
Thanks for pointing it out.
>> +		split_io_pos = (zone_idx + 1) * dmh->zone_size_po2;
>> +		dm_accept_partial_bio(bio, split_io_pos - start_sect);
>> +	}
>> +
>> +	zero_fill_bio(bio);
>> +	bio_endio(bio);
>> +	return DM_MAPIO_SUBMITTED;
>> +}
>> +
>> +static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +
>> +	bio_set_dev(bio, dmh->dev->bdev);
>> +	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
>> +		/*
>> +		 * Read operation on the emulated zone area (between zone capacity
>> +		 * and zone size) will fill the bio with zeroes. Any other operation
>> +		 * in the emulated area should return an error.
>> +		 */
>> +		if (bio_op(bio) == REQ_OP_READ)
>> +			return dm_po2z_map_read(dmh, bio);
>> +
>> +		if (!bio_across_emulated_zone_area(dmh, bio)) {
>> +			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
>> +								       bio->bi_iter.bi_sector);
>> +			return DM_MAPIO_REMAPPED;
>> +		}
>> +		return DM_MAPIO_KILL;
>> +	}
>> +	return DM_MAPIO_REMAPPED;
>> +}
>> +
>> +static int dm_po2z_iterate_devices(struct dm_target *ti,
>> +				   iterate_devices_callout_fn fn, void *data)
>> +{
>> +	struct dm_po2z_target *dmh = ti->private;
>> +	sector_t len = dmh->nr_zones * dmh->zone_size;
>> +
>> +	return fn(ti, dmh->dev, 0, len, data);
>> +}
>> +
>> +static struct target_type dm_po2z_target = {
>> +	.name = "po2z",
>> +	.version = { 1, 0, 0 },
>> +	.features = DM_TARGET_ZONED_HM | DM_TARGET_EMULATED_ZONES,
>> +	.map = dm_po2z_map,
>> +	.end_io = dm_po2z_end_io,
>> +	.report_zones = dm_po2z_report_zones,
>> +	.iterate_devices = dm_po2z_iterate_devices,
>> +	.module = THIS_MODULE,
>> +	.io_hints = dm_po2z_io_hints,
>> +	.ctr = dm_po2z_ctr,
>> +};
>> +
>> +static int __init dm_po2z_init(void)
>> +{
>> +	int r = dm_register_target(&dm_po2z_target);
>> +
>> +	if (r < 0)
>> +		DMERR("register failed %d", r);
>> +
>> +	return r;
> 
> Simplify:
> 
> 	return dm_register_target(&dm_po2z_target);
> 
>> +}
>> +
>> +static void __exit dm_po2z_exit(void)
>> +{
>> +	dm_unregister_target(&dm_po2z_target);
>> +}
>> +
>> +/* Module hooks */
>> +module_init(dm_po2z_init);
>> +module_exit(dm_po2z_exit);
>> +
>> +MODULE_DESCRIPTION(DM_NAME "power-of-2 zoned target");
>> +MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
>> +MODULE_LICENSE("GPL");
>> +
> 
> the changes below should be a different prep patch.
> 
Ok. `dm:introduce DM_EMULATED_ZONE target type` before introducing this
new target.

>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>> index 534fddfc2b42..d77feff124af 100644
>> --- a/drivers/md/dm-table.c
>> +++ b/drivers/md/dm-table.c
>> @@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
>>  	return true;
>>  }
>>  
>> -static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>> +/*
>> + * Callback function to check for device zone sector across devices. If the
>> + * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
>> + * should have the same zone sector as the underlying devices.
>> + */
>> +static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
>>  					   sector_t start, sector_t len, void *data)
>>  {
>>  	unsigned int *zone_sectors = data;
>>  
>> -	if (!bdev_is_zoned(dev->bdev))
>> +	if (!bdev_is_zoned(dev->bdev) ||
>> +	    dm_target_supports_emulated_zones(ti->type))
>>  		return 0;
>> +
>>  	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
>>  }
>>  
>> @@ -1646,7 +1653,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>>  	if (!zone_sectors)
>>  		return -EINVAL;
>>  
>> -	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
>> +	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
>>  		DMERR("%s: zone sectors is not consistent across all zoned devices",
>>  		      dm_device_name(t->md));
>>  		return -EINVAL;
>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index 31c16aafdbfc..2b6b3883471f 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -302,6 +302,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>>  	if (dm_table_supports_zone_append(t)) {
>>  		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
>>  		dm_cleanup_zoned_dev(md);
>> +
>>  		return 0;
>>  	}
>>  
>> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
>> index 920085dd7f3b..7dbd28b8de01 100644
>> --- a/include/linux/device-mapper.h
>> +++ b/include/linux/device-mapper.h
>> @@ -294,6 +294,15 @@ struct target_type {
>>  #define dm_target_supports_mixed_zoned_model(type) (false)
>>  #endif
>>  
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +#define DM_TARGET_EMULATED_ZONES	0x00000400
>> +#define dm_target_supports_emulated_zones(type) \
>> +	((type)->features & DM_TARGET_EMULATED_ZONES)
>> +#else
>> +#define DM_TARGET_EMULATED_ZONES	0x00000000
>> +#define dm_target_supports_emulated_zones(type) (false)
>> +#endif
>> +
>>  struct dm_target {
>>  	struct dm_table *table;
>>  	struct target_type *type;
> 
> 
