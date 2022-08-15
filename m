Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93E5593015
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiHONil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHONih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:38:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9A2127A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:38:36 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220815133833euoutp02c6ec885b9071696e57d5ed18024a3279~LiEPyvs2M0396003960euoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:38:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220815133833euoutp02c6ec885b9071696e57d5ed18024a3279~LiEPyvs2M0396003960euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660570713;
        bh=uinaqvipRzgM4fZTJ7/seCP1gQZj63jPFUT+oy/zEQo=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=VTiOrSLC1BJ2t0y+nUyCM22s7H/Cy3I7EQG73gzv5eHbmNwd9NyResP0c+WBn+T/D
         LDyoLcAfcqwAr4AvtJdGLDQS5k5xVEx7mhkxE7D2p0f6SKen50XzcUHyEoEHJl3m9r
         Zn/PQq8puYJQQFyP3g14bLA3JLQheUvaeN/lzUnc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220815133832eucas1p17529f151ac4728837b2786a4b87087d8~LiEPK3P4M1197311973eucas1p1-;
        Mon, 15 Aug 2022 13:38:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.BD.09580.85C4AF26; Mon, 15
        Aug 2022 14:38:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220815133831eucas1p12bee88eaaf35ad2445603641816ad773~LiEOwjgJl1998419984eucas1p1T;
        Mon, 15 Aug 2022 13:38:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220815133831eusmtrp2d0350406e80c2d8c17641c33ffdbcb3e~LiEOvg62u1625116251eusmtrp2W;
        Mon, 15 Aug 2022 13:38:31 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-4e-62fa4c582b28
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.16.09038.75C4AF26; Mon, 15
        Aug 2022 14:38:31 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220815133831eusmtip28ecf5948d863ea24ae979c7e57830b70~LiEOgBsYl1524415244eusmtip2B;
        Mon, 15 Aug 2022 13:38:31 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 Aug 2022 14:38:30 +0100
Message-ID: <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
Date:   Mon, 15 Aug 2022 15:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <snitzer@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <agk@redhat.com>
CC:     <linux-block@vger.kernel.org>, <Johannes.Thumshirn@wdc.com>,
        <bvanassche@acm.org>, <matias.bjorling@wdc.com>, <hare@suse.de>,
        <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
        <jaegeuk@kernel.org>, <pankydev8@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
Content-Language: en-US
In-Reply-To: <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djP87oRPr+SDK494LNYf+oYs8Xqu/1s
        FtM+/GS2+H32PLNFa/s3Jou972azWuxZNInJYuXqo0wWT9bPYrb423UPKHFL2+LyrjlsFvOX
        PWW3mND2ldlizc2nLBYnbkk7CHhcvuLtsXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j52t91k9
        3u+7ChQ6Xe3xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujFvzDrIWPJGqeNH7k7WB8ZRoFyMn
        h4SAicSpNQ+Zuhi5OIQEVjBKbGy+yQrhfGGUuL65gRHC+cwosbenjR2mpbFzCTtEYjmjRMuG
        KaxwVesvfIUatptR4te1A2AtvAJ2Ei/m7mQFsVkEVCX+PlnPChEXlDg58wkLiC0qECmxZvdZ
        oHoODjYBLaAVYKawQLbExA4bkJEiAg2MEtP3bwGbzyzwg0liy6dpTCC9zALiEreezAezOQXc
        JFYfXskMEdeUaN3+mx3ClpfY/nYOM8QLShIT5t1ng7BrJdYeOwP2joTAM06Jnh93WCASLhIr
        vr6AKhKWeHV8C9T/MhL/d0IskxColnh64zczRHMLo0T/zvVsIGdLCFhL9J3JgahxBHryFlSY
        T+LGW0GIe/gkJm2bzjyBUXUWUlDMQvLOLCQvzELywgJGllWM4qmlxbnpqcXGeanlesWJucWl
        eel6yfm5mxiBSfH0v+NfdzCuePVR7xAjEwfjIUYJDmYlEV7BFz+ShHhTEiurUovy44tKc1KL
        DzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTBJX1yok74mrWp9X6yXY+aaee/a+UIX
        pTHJTNgdeOMCx8O0aiflskS5Up31h86oMbsl7T32xjBK1+nmzsmzbb6qfos+2JByydRoZu3+
        Pr3r326/ldqhyD41uGrPViPVJdZpoT7HV01c11F5T8VzidesaQdmnju8dkNjpia/7M4D75sT
        TYWtNjkb9+VwX94o63BNNTdH4I1G+wJvdkfXcr9P8vdX8y7bufbtP5HFXXw7J5XvTfEUu5e6
        dnVD86ffW2QK36p+8RfIMEtsvjaHubl2ztPv9h/eH6t69uyRs9q5X+svq6q8uDTd2Sai7MvX
        z5pTZp9/qdR6gF3kY7CT+Czzxxf4S/Y3JLs6bwvecrRDiaU4I9FQi7moOBEAIL9EsfkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7rhPr+SDLrP6FmsP3WM2WL13X42
        i2kffjJb/D57ntmitf0bk8Xed7NZLfYsmsRksXL1USaLJ+tnMVv87boHlLilbXF51xw2i/nL
        nrJbTGj7ymyx5uZTFosTt6QdBDwuX/H22DnrLrvH5bOlHptWdbJ5bF5S77H7ZgObx87W+6we
        7/ddBQqdrvb4vEnOo/1AN1MAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexq15B1kLnkhVvOj9ydrAeEq0i5GTQ0LARKKxcwl7FyMXh5DAUkaJ
        fR0/2SASMhKfrnxkh7CFJf5c62KDKPrIKPFw0n1GCGc3o8SqTRvBqngF7CRezN3JCmKzCKhK
        /H2ynhUiLihxcuYTFhBbVCBS4uGyJqYuRg4ONgEtoNXsIKawQLbExA4bkJEiAg2MEtP3b2EC
        cZgFfjBJbPk0jQmkV0jgD6PEhPXMIDazgLjErSfzweKcAm4Sqw+vhIprSrRu/80OYctLbH87
        hxniAyWJCfPuQ31WK/Hq/m7GCYyis5CcNwvJ2FlIRs1CMmoBI8sqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwESy7djPLTsYV776qHeIkYmD8RCjBAezkgiv4IsfSUK8KYmVValF+fFFpTmp
        xYcYTYFhNJFZSjQ5H5jK8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4
        OKUamDYzZc0Ln6szfWOr8tQwTv7v26Uf9y/ZHqHqYpdtGOL4/lb05XfHTCtsLuq4cr/uF3uu
        2RK+zuC1L+PDyw/1d/sczmpeGLz1dpPO39tBH/vmLfjqM+ur8gG76Dez9p8oWuzO7HR3cXpr
        +ov7eV0HE3yFF6pw7nJytGuePrcvlF1wS2/RweibqzI7IkyVJ4qvs815F5d2pfL/Id4LPzZP
        tc9Iux1W62ab3XRq5Y26EMacY0tS5aXyzSuWCSfZCGx+V2Custqg/dzEsutpB6/FC4rENb04
        xvcwrkS3g0fkiIP/LbsFm5R9I/gvt0i+r5Gv+7SctZq7P3jWU/5vKxOv8JfN1fOa7nvNcO2W
        RFEmJZbijERDLeai4kQAXL0Z2K0DAAA=
X-CMS-MailID: 20220815133831eucas1p12bee88eaaf35ad2445603641816ad773
X-Msg-Generator: CA
X-RootMTR: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143058eucas1p247291685ffff7a75186947fd30b5c13f
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
        <20220811143043.126029-14-p.raghav@samsung.com>
        <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

>> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
>> +					  struct bio *bio)
> 
> This really should be called dm_po2z_handle_read() since it handles both cases
> of read commands, with and without the accept partial. Note that this is
> retesting the need for a split after that was already tested in dm_po2z_map()
> with bio_across_emulated_zone_area(). So the code should be better organized to
> avoid that repetition.
> 
> You can simplify the code by having bio_across_emulated_zone_area() return 0 for
> a bio that does not cross the zone capacity and return the number of sectors up
> to the zone capacity from the bio start if there is a cross. That value can then
The offset will also be zero if the BIO starts at the zone capacity and
dm_po2z_map will assume that the bio did not cross the emulated zone boundary.

> be used to call dm_accept_partial_bio() directly in dm_po2z_map() for read
> commands. That will make this function much simpler and essentially turn it into
> dm_po2z_read_zeroes().
> 
>> +{

What about something like this? We have one function:
bio_in_emulated_zone_area() that checks if a BIO is partly or completely in the
emulated zone area and also returns the offset from bio to the emulated zone
boundary (zone capacity of the device).

/**
 * bio_in_emulated_zone_area - check if bio is in the emulated zone area
 * @dmh:	pozone target data
 * @bio:	bio
 * @offset:	bio offset to emulated zone boundary
 *
 * Check if a @bio is partly or completely in the emulated zone area. If the
 * @bio is partly in the emulated zone area, @offset
 * can be used to split the @bio across the emulated zone boundary. @offset
 * will be negative if the @bio completely lies in the emulated area.
 *  */
static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
					  struct bio *bio, int *offset)
{
	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
	sector_t relative_sect_in_zone =
		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);

	*offset = dmh->zone_size - relative_sect_in_zone;

	return (relative_sect_in_zone + nr_sectors) > dmh->zone_size;
}

static int dm_po2z_read_zeroes(struct bio *bio)
{
	zero_fill_bio(bio);
	bio_endio(bio);
	return DM_MAPIO_SUBMITTED;
}

static int dm_po2z_remap_sector(struct dm_po2z_target *dmh, struct bio *bio)
{
	bio->bi_iter.bi_sector =
		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
	return DM_MAPIO_REMAPPED;
}

static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
{
	struct dm_po2z_target *dmh = ti->private;

	bio_set_dev(bio, dmh->dev->bdev);
	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
		int split_io_pos;
		if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos)) {
			return dm_po2z_remap_sector(dmh, bio);
		}
		/*
		 * Read operation on the emulated zone area (between zone capacity
		 * and zone size) will fill the bio with zeroes. Any other operation
		 * in the emulated area should return an error.
		 */
		if (bio_op(bio) == REQ_OP_READ) {
			if (split_io_pos > 0) {
				dm_accept_partial_bio(bio, split_io_pos);
				return dm_po2z_remap_sector(dmh, bio);
			}
			return dm_po2z_read_zeroes(bio);
		}
		return DM_MAPIO_KILL;
	}
	return DM_MAPIO_REMAPPED;
}

Let me know what you think.
