Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF9154E6B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378058AbiFPQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377141AbiFPQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:12:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8664476A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:12:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220616161211euoutp028704f425ae0bc193bf599970d9436792~5JdRWMwck2682526825euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:12:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220616161211euoutp028704f425ae0bc193bf599970d9436792~5JdRWMwck2682526825euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655395931;
        bh=YpSTGfJTj5ESqCEZoVxybV24L+dMaMmjttqOvj9zqkM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=nwU6/kgPheuRXgKxFbR6fcXquqEAYycpbnQBjPslIXAezuhCjVpIoidHYwCi0V0jx
         cgFpbx4SHiOI3b+qhbQ29TAeBYi5BKXdzKI61CvB/i9236DhHo69ZGRZsxwIbhEYkp
         fYIDmfMQ7IghWs5NVxUU8fP9k3Kz3PvVWXqQobh4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220616161211eucas1p295ba6d89667f807ae527a12483909950~5JdRAPlNH0245502455eucas1p2v;
        Thu, 16 Jun 2022 16:12:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.8F.09580.B565BA26; Thu, 16
        Jun 2022 17:12:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220616161210eucas1p115d523e8dc5355e1179e2b267cf9800d~5JdQTfYih1246312463eucas1p1Z;
        Thu, 16 Jun 2022 16:12:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220616161210eusmtrp2ef0db1527aba0e69896207e120906c94~5JdQShJpJ2110121101eusmtrp27;
        Thu, 16 Jun 2022 16:12:10 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-e6-62ab565bd508
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 21.2E.09095.A565BA26; Thu, 16
        Jun 2022 17:12:10 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220616161210eusmtip1cbfd7c21dec8ce375bc53c0501d87964~5JdQEJVXq1192611926eusmtip1F;
        Thu, 16 Jun 2022 16:12:10 +0000 (GMT)
Received: from [192.168.1.12] (106.210.248.244) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 16 Jun 2022 17:12:03 +0100
Message-ID: <0b819562-8b16-37b6-9220-28bf1960bccb@samsung.com>
Date:   Thu, 16 Jun 2022 18:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.9.1
Subject: Re: [PATCH v7 13/13] dm: add non power of 2 zoned target
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>, <hch@lst.de>,
        <snitzer@redhat.com>, <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
        <jiangbo.365@bytedance.com>, <hare@suse.de>, <pankydev8@gmail.com>,
        <dm-devel@redhat.com>, <jonathan.derrick@linux.dev>,
        <gost.dev@samsung.com>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
        <linux-nvme@lists.infradead.org>, <Johannes.Thumshirn@wdc.com>,
        <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.244]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7djPc7rRYauTDLY/lbJYfbefzWLah5/M
        Fr/Pnme2aG3/xmSx991sVosLPxqZLPYsmsRksXL1USaLJ+tnMVv0HPjAYvG36x5QrOUhs8Xe
        W9oWl3fNYbOYv+wpu8Wam09ZLNo2fmV0EPS4fMXb49+JNWweO2fdZfe4fLbUY9OqTjaPhQ1T
        mT02L6n32H2zASjXep/V4/2+q2we67dcZfHYfLra4/MmOY/2A91MAXxRXDYpqTmZZalF+nYJ
        XBmXLi5kL7iVUnFup1oD42z/LkYODgkBE4kDM9m6GLk4hARWMEq0LFvPBOF8YZQ483wzI4Tz
        mVFi7+RfLDAdN3dXQ8SXM0q82fmOGa5obed9qPZdjBK3dr1hBOngFbCT2Lo+p4uRk4NFQFVi
        xdYHLCA2r4CgxMmZT8BsUYEIiZWtb8AWCAs4SjSdSAIJMwuIS9x6Mp8JJCwikCcx718SyHRm
        gRZmia79D5lB4mwCWhKNnewgJqeAm8S2KfEQnZoSrdt/s0PY8hLb385hhrheWeLfTmaQsIRA
        rcTaY2fYQSZKCDRxSdzongOVcJHYvaCJCcIWlnh1fAs7hC0j8X/nfKh4tcTTG7+ZIZpbGCX6
        d65ng1hgLdF3JgeixlFiVcsTRogwn8SNt4IQ5/BJTNo2nXkCo+ospGCYheTfWUg+mIXkgwWM
        LKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzEC0+Xpf8e/7mBc8eqj3iFGJg7GQ4wSHMxK
        IrxmwSuThHhTEiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAZ
        +TRFehvHMVdI8+d4qRse6nmzxfHctgzvv8s+ue668OPUdc4rNxrWVX88zMtXIPZ8dsLhpSHs
        DBsVL54zPXXhwqZDwusvd5p5XP+5sKvo+nruUwoqtlEXGrM/VB+ZFKu2zjLu6tm1q8uWKh1a
        tXN9/+oj0avMGWcUlauo3c0INuw8Nlf+U8GF/i3FdQ84L+f+P1/A8vx7Vd/8M8/ldjsVrvng
        4Su/YM9jO4c+qY/lIQbhwRdXm5v7ng1NK9p0Z//lbZt/FGfe5Jkj9oiJ44vYddODnx39D8fI
        JcUf/av4wc77x9NPVnWbNZ/srnnmtuzzgRtvHjWqHulKc2M2VX/sdLJoc9on+4WJRhcvHORg
        VGIpzkg01GIuKk4EAG9QZ9EGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsVy+t/xu7pRYauTDOa3alqsvtvPZjHtw09m
        i99nzzNbtLZ/Y7LY+242q8WFH41MFnsWTWKyWLn6KJPFk/WzmC16DnxgsfjbdQ8o1vKQ2WLv
        LW2Ly7vmsFnMX/aU3WLNzacsFm0bvzI6CHpcvuLt8e/EGjaPnbPusntcPlvqsWlVJ5vHwoap
        zB6bl9R77L7ZAJRrvc/q8X7fVTaP9VuusnhsPl3t8XmTnEf7gW6mAL4oPZui/NKSVIWM/OIS
        W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxLFxeyF9xKqTi3U62BcbZ/
        FyMHh4SAicTN3dVdjFwcQgJLGSWW3pvB3sXICRSXkfh05SOULSzx51oXG4gtJPCRUeJ2rxRE
        wy5GiZcPHrGBDOIVsJPYuj4HpIZFQFVixdYHLCA2r4CgxMmZT8BsUYEIiU/LJrCClAsLOEo0
        nUgCCTMLiEvcejKfCSQsIpAnMe9fEsh0ZoEWZomu/Q+ZIVb9AVo79xE7SBGbgJZEYyeYySng
        JrFtSjzEGE2J1u2/2SFseYntb+cwQ3yoLPFvJzPEI7USr+7vZpzAKDoLyW2zkBwxC8mkWUgm
        LWBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iRGYZLYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS
        4TULXpkkxJuSWFmVWpQfX1Sak1p8iNEUGEATmaVEk/OBaS6vJN7QzMDU0MTM0sDU0sxYSZzX
        s6AjUUggPbEkNTs1tSC1CKaPiYNTqoEp36quXPHgOcnjBRMUv3HNlbC+ZXThlt2txy7q/lf8
        npzLOn7v4F3/LObj678VOXVMvfc3K6pkalxiw9KSVIHvM+VTmifP66hNZj5j2HrvZ/+xJXx2
        zor/9eO7OOyyTn6Rf9q1fEO9ja7IkmnNGsErfCy/SObvZHu8aLphxsvwa3vnSG9b7pJz4e6V
        HTOnZf5fuHQrR0xQ/aVjl+u02XIbWh1/Rp/RSPdslu98ITJj0Zm0WD0909N5apcfcj8N5hN/
        fDblzRoNsf1KB3Z0rX4h1jnL83dt0IbFihpTLLUmnnds/R0kI1qVPj2zsSoi5pFcz9vGR9Os
        /pY8d3z6abPBEe51lme3/3i6OmHqpAWKSizFGYmGWsxFxYkAAGyT5bsDAAA=
X-CMS-MailID: 20220616161210eucas1p115d523e8dc5355e1179e2b267cf9800d
X-Msg-Generator: CA
X-RootMTR: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
        <20220615101920.329421-14-p.raghav@samsung.com>
        <63b0cfb6-eb24-f058-e502-2637039c5a98@opensource.wdc.com>
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,
On 2022-06-15 13:49, Damien Le Moal wrote:
> On 6/15/22 19:19, Pankaj Raghav wrote:
>> Only power of 2(po2) zoned devices were supported in linux but now non
>> power of 2(npo2) zoned device support has been added to the block layer.
>>
>> Filesystems such as F2FS and btrfs have support for zoned devices with
>> po2 zone size assumption. Before adding native support for npo2 zoned
>> devices, it was suggested to create a dm target for npo2 zoned device to
>> appear as po2 device so that file systems can initially work without any
>> explicit changes by using this target.
>>
>> The design of this target is very simple: introduce gaps between the zone
>> capacity and the po2 zone size of the underlying device. All IOs will be
>> remapped from target to the actual device location. For devices that use
>> zone append, the bi_sector is remapped from device to target's layout.
> 
> Nothing special for zone append in this respect. All IOs are remapped
> likewise, right ?
> 
This is what is being done: when we submit, we adjust the sector value
from target to device, and the actual sector value from bio gets updated
in the endio function where we transform from device -> target for zone
appends.
>>
>> The read IOs that fall in the "emulated" gap area will return 0 and all
>> the other IOs in that area will result in an error. If an read IO span
>> across the zone capacity boundary, then the IOs are split between the
>> boundary. All other IO operations that span across a zone capacity
>> boundary will result in an error.
>>
>> The target can be easily updated as follows:
> 
> Updated ? you mean created, no ?
> 
Yeah. I will fix it.
>> dmsetup create <label> --table '0 <size_sects> zoned-npo2 /dev/nvme<id>'
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
>> Suggested-by: Hannes Reinecke <hare@suse.de>
>> ---
>>  drivers/md/Kconfig                |   9 +
>>  drivers/md/Makefile               |   2 +
>>  drivers/md/dm-zone.c              |   9 +
>>  drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
>>  4 files changed, 288 insertions(+)
>>  create mode 100644 drivers/md/dm-zoned-npo2-target.c
>>
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index 998a5cfdb..773314536 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -518,6 +518,15 @@ config DM_FLAKEY
>>  	help
>>  	 A target that intermittently fails I/O for debugging purposes.
>>  
>> +config DM_ZONED_NPO2
>> +	tristate "Zoned non power of 2 target"
>> +	depends on BLK_DEV_DM
>> +	depends on BLK_DEV_ZONED
>> +	help
>> +	A target that converts a zoned device with non power of 2 zone size to
>> +	be power of 2. This is done by introducing gaps in between the zone
>> +	capacity and the power of 2 zone size.
>> +
>>  config DM_VERITY
>>  	tristate "Verity target support"
>>  	depends on BLK_DEV_DM
>> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
>> index 0454b0885..2863a94a7 100644
>> --- a/drivers/md/Makefile
>> +++ b/drivers/md/Makefile
>> @@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
>>  dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
>>  dm-verity-y	+= dm-verity-target.o
>>  dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
>> +dm-zoned-npo2-y       += dm-zoned-npo2-target.o
> 
> This naming is in my opinion very bad as it seems related to the dm-zoned
> target. e.g. dm-po2z, dm-zp2, etc.
> 
Probably dm-po2z sounds good. I will go for it if others don't have any
objection.
>>  
>>  md-mod-y	+= md.o md-bitmap.o
>>  raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
>> @@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
>>  obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
>>  obj-$(CONFIG_DM_DUST)		+= dm-dust.o
>>  obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
>> +obj-$(CONFIG_DM_ZONED_NPO2)	+= dm-zoned-npo2.o
>>  obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
>>  obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
>>  obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index af36d33f9..5efb31ba0 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -210,6 +210,11 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
>>  		}
>>  		md->zwp_offset[idx] = dm_get_zone_wp_offset(zone);
>>  
>> +		if (q->limits.chunk_sectors != zone->len) {
> 
> Why is this if needed ?
> 
Explanation below.
>> +			blk_queue_chunk_sectors(q, zone->len);
>> +			q->nr_zones = blkdev_nr_zones(md->disk);
>> +		}
>> +
>>  		break;
>>  	default:
>>  		DMERR("Invalid zone type 0x%x at sectors %llu",
>> @@ -307,6 +312,9 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>>  	if (dm_table_supports_zone_append(t)) {
>>  		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
>>  		dm_cleanup_zoned_dev(md);
>> +
> 
> no need for the blank line.
> 
>> +		if (!is_power_of_2(blk_queue_zone_sectors(q)))
>> +			goto revalidate_zones;
>>  		return 0;
>>  	}
> 
> Why do you need to change dm_set_zones_restrictions() at all ?
> 
When the device mapper is created, the q->limits gets inherited from the
underlying device. The chunk sectors of the target and the device will
be the same but we want the chunk sector of the target to be different
(rounded to po2) compared to the underlying device's chunk sector. This
needs to be done only for the dm-po2z target and not for other targets
that uses npo2 zoned devices (like dm-linear). So to perform this
operation in a target independent way in dm-zone.c, I chose to always
revalidate npo2 zoned device and update the chunk sector and nr_zones in
dm_zone_revalidate_cb based on the zone information from the target.
This allows to set the limits correctly for dm-po2z target.
>>  
<snip>
return -EINVAL;
>> +	}
>> +
>> +	if (is_power_of_2(zsze)) {
>> +		DMERR("%pg zone size is power of 2", dmh->dev->bdev);
> 
> Hmmm... You would end up with no remapping needed so it would still
> work... Why error this ? A warning would work too.
> 
You mean a DMWARN and not return -EINVAL? I mean there is no usecase for
po2 device to use this target so why allow it in the first place?
>> +		return -EINVAL;
>> +	}
>> +
>> +	dmh->zsze = zsze;
>> +	dmh->zsze_po2 = 1 << get_count_order_long(zsze);
>> +	dmh->zsze_diff = dmh->zsze_po2 - dmh->zsze;
>> +
>> +	ti->private = dmh;
>> +	ti->num_flush_bios = 1;
>> +	ti->num_discard_bios = 1;
>> +	ti->num_secure_erase_bios = 1;
>> +	ti->num_write_zeroes_bios = 1;
> 
> Why all these ? I know dm-linear do that but I do not see why they would
> be necessary for a single device target.
> 
Good point. I will remove them

<snip>
>> +		return DMZ_NPO2_IO_INSIDE_ZONE;
>> +	else if (relative_sect >= dmh->zsze)
> 
> no need for the else. And this is super confusing. This case correspond to
> the BIO going beyond the zone capacity in the target address space,
> meaning it is still WITHIN the target zone. But you call that "outside"
> because it is for the device zone. Super confusing. It took me a lot of
> rereading to finally get it.
> 
Probably my naming choice was not correct here for the enum. It should
be s/IO_INSIDE_ZONE/IO_INSIDE_ZONE_CAP, etc to be clear. I mainly wanted
to handle the case where a read across zone capacity should return
something valid instead of just an error as we emulate the LBAs from
zone cap to zone size.

DMZ_NPO2_IO_INSIDE_ZONE_CAP:
             zcap   zsize
---------------|-----|
      <------>
        bio
Normal scenario we just send what is there in the device.


DMZ_NPO2_IO_OUTSIDE_ZONE_CAP:
             zcap       zsize
---------------|---------|
                 <---->
                   bio

Read should return zero filled bio and other operation will return an
error because we are touching the emulated area.

DMZ_NPO2_IO_ACROSS_ZONE_CAP:
             zcap   zsize
---------------|-----|
           <------>
              bio
For reads, the bio should be split across zone cap and the bio on the
left hand side returns what is there in the device and the split bio on
the right hand side should just return zeroes. All other requests will
return an error.

>> +		return DMZ_NPO2_IO_OUTSIDE_ZONE;
>> +
>> +	return DMZ_NPO2_IO_ACROSS_ZONE;
> 
> So you BIO is eeither fully contained within the zone or it is not. So why
> not just return a bool ?
> 
As I explained above, I was considering the boundary as zone cap inside
a zone. The bio can be within zone cap, across zone cap into the
emulated zone size and outside zone capacity.

I didn't take into account the read across zone. I will make sure it is
correctly handled in the next revision.

             zcap  zsize          zcap
---------------|-----|--------------|
                  <------>
                     bio
>> +}
>> +
>> +static void split_io_across_zone_boundary(struct dmz_npo2_target *dmh,
>> +					  struct bio *bio)
>> +{
>> +	sector_t sect = bio->bi_iter.bi_sector;
>> +	sector_t sects_from_zone_start;
>> +
>> +	sect = target_to_device_sect(dmh, sect);
> 
> 	sect = target_to_device_sect(dmh, bio->bi_iter.bi_sector);
> 
> is more readable.
> 
>> +	div64_u64_rem(sect, dmh->zsze, &sects_from_zone_start);
>> +	dm_accept_partial_bio(bio, dmh->zsze - sects_from_zone_start);
> 
> So if this is a read BIO starting exactly at the target zone capacity
> (sects_from_zone_start == zsze), then you accept 0 sectors ? What am I
> missing here ?
> 
Your condition will not even touch this function. This function comes
into play only when the bio runs across the zone capacity as I mentioned
before.
>> +	bio->bi_iter.bi_sector = sect;
>> +}
>> +
>> +static int handle_zone_boundary_violation(struct dmz_npo2_target *dmh,
>> +					  struct bio *bio,
>> +					  enum dmz_npo2_io_cond cond)
>> +{
>> +	/* Read should return zeroed page */
>> +	if (bio_op(bio) == REQ_OP_READ) {
>> +		if (cond == DMZ_NPO2_IO_ACROSS_ZONE) {
>> +			split_io_across_zone_boundary(dmh, bio);
>> +			return DM_MAPIO_REMAPPED;
>> +		}
>> +		zero_fill_bio(bio);
>> +		bio_endio(bio);
>> +		return DM_MAPIO_SUBMITTED;
>> +	}
>> +	return DM_MAPIO_KILL;
>> +}
>> +
>> +static int dmz_npo2_end_io(struct dm_target *ti, struct bio *bio,
>> +			   blk_status_t *error)
>> +{
>> +	struct dmz_npo2_target *dmh = ti->private;
>> +
>> +	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
>> +		bio->bi_iter.bi_sector =
>> +			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
>> +
>> +	return DM_ENDIO_DONE;
>> +}
>> +
>> +static int dmz_npo2_map(struct dm_target *ti, struct bio *bio)
>> +{
>> +	struct dmz_npo2_target *dmh = ti->private;
>> +	enum dmz_npo2_io_cond cond;
>> +
>> +	bio_set_dev(bio, dmh->dev->bdev);
>> +	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
>> +		cond = check_zone_boundary_violation(dmh, bio->bi_iter.bi_sector,
>> +						     bio->bi_iter.bi_size >> SECTOR_SHIFT);
> 
> Why check this for zone management BIOs ? These have length = 0, always.
> 
>> +
>> +		/*
>> +		 * If the starting sector is in the emulated area then fill
>> +		 * all the bio with zeros. If bio is across boundaries,
>> +		 * split the bio across boundaries and fill zeros only for the
>> +		 * bio that is outside the zone capacity
>> +		 */
>> +		switch (cond) {
>> +		case DMZ_NPO2_IO_INSIDE_ZONE:
>> +			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
>> +								       bio->bi_iter.bi_sector);
>> +			break;
>> +		case DMZ_NPO2_IO_ACROSS_ZONE:
>> +		case DMZ_NPO2_IO_OUTSIDE_ZONE:
>> +			return handle_zone_boundary_violation(dmh, bio, cond);
>> +		}
>> +	}
>> +	return DM_MAPIO_REMAPPED;
> 
> This entire function is very hard to read because everything is hidden in
> helpers that are not super useful in my opinion. I would prefer seeing
> cases for:
> * zone management BIOs
> * Reads and writes
> * Everything else
> 
> where tests against the bio sector and length are visible, so one can
> understand what is going on. If you need helpers, have handle_zone_mgmt(),
> handle_read() etc. Something clear.
> 
Got it. I see the confusion here. I will rearrange it properly in the
next revision. Thanks for this comment.
>> +}
>> +
>> +static int dmz_npo2_iterate_devices(struct dm_target *ti,
>> +				    iterate_devices_callout_fn fn, void *data)
>> +{
>> +	struct dmz_npo2_target *dmh = ti->private;
>> +	sector_t len = 0;
>> +
>> +	len = dmh->nr_zones * dmh->zsze;
> 
> Move this to the declaration instead of setting len to 0 for nothing.
> 
Ok.
>> +	return fn(ti, dmh->dev, 0, len, data);

