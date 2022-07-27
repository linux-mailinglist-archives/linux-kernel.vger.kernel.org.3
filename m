Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06780582AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiG0QZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiG0QYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:19 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D094E614
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:23:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162256euoutp012b48621e8c9ba27010ef5ed877196938~FvDW1rwlF2487524875euoutp01w
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162256euoutp012b48621e8c9ba27010ef5ed877196938~FvDW1rwlF2487524875euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938976;
        bh=w5O8BVNbekPWS0uTFULfAlhiPgH30QywlTHY/GvNI4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cA3D1ANXcWA/rH5h2KjUSuHkVXTo/XeE9N9GDtTqRgvDpdJhytcc3g0b/g5LQEWdu
         k7VCRjMZDtr2JDr0durIrT3c8kETMYngI+T3o7Z+dy8gcQwJxYfZFLHBZEpSZj/iC/
         s85tBllNt5V7zzKkmObvEJd/DFWcet2AIUfhf+5s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162255eucas1p270f1762da9a9d8a41d40bde0664f9b65~FvDVcfZl82220522205eucas1p28;
        Wed, 27 Jul 2022 16:22:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 28.E8.09580.F5661E26; Wed, 27
        Jul 2022 17:22:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd~FvDVEOET21345313453eucas1p1m;
        Wed, 27 Jul 2022 16:22:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220727162254eusmtrp1ea1f3eb33ea28187ca0b488efe6d40d1~FvDVCBW6T0298902989eusmtrp1P;
        Wed, 27 Jul 2022 16:22:54 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-e7-62e1665f73bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.8D.09038.E5661E26; Wed, 27
        Jul 2022 17:22:54 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162254eusmtip16a6354516571bc22aef68af1faaca7ef~FvDUtVvM_0065000650eusmtip1G;
        Wed, 27 Jul 2022 16:22:54 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v8 08/11] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Wed, 27 Jul 2022 18:22:42 +0200
Message-Id: <20220727162245.209794-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djPc7rxaQ+TDFZuZrZYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDLeXzzNWnCe
        q2L+j80sDYzXOboYOTkkBEwkLrcsYQexhQRWMEpMnSLWxcgFZH9hlJh46TAbhPOZUeJQ+1lm
        mI4PtyaxQiSWM0psnzaPCcJ5ziixc/kJoFkcHGwCWhKNnWBjRQSKJR6+a2UBqWEWOMAk8eB2
        CxtIjbBAjMSEpzkgNSwCqhJN226ygti8AlYSO/Z+glomLzHz0newOZwC1hKbp4DsAqkRlDg5
        8wkLiM0MVNO8dTZU/XpOieZFCRC2i8SHvnNQcWGJV8e3sEPYMhKnJ/ewQNjVEk9v/GYGuU1C
        oIVRon/nerDbJICW9Z3JATGZBTQl1u/Shyh3lNj04yUTRAWfxI23ghAX8ElM2jadGSLMK9HR
        JgRRrSSx8+cTqKUSEpeb5kAt9ZBof3eUbQKj4iwkv8xC8ssshL0LGJlXMYqnlhbnpqcWG+el
        lusVJ+YWl+al6yXn525iBKbA0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4E6LvJwnxpiRWVqUW
        5ccXleakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpgUty+wlJ217rSvexOD5eG
        XHwWNt38yk7ecv8TsV7hvE5rYuqj3P7e614X3O5WvnkmX85ClVmCPwXeeuc+Mp/8b5a8vpvV
        aufQ/B9rq4uk837e+HJkQcX2XMeVIekeZsq/J7xnmyr4K37qvMx7eb8/qldVMPjfK3iiNZV/
        SmLOccFooylCNYFlL7Y0aij4WnIoXS7Tuylb+SQ1Nuqkfl+hQcZ/69LQVIu/p7cLde7SX9/1
        OLu6UGerzXFui4kaRmlHztdIP91w2aFurWmTTWRop/vUs9+WHdT3vnLayKvs5vdSQ/V7hQF/
        M6RuiMzRMTnSFLsl5FLy283TGafkKtb+nrLoPpvJxrNqrc+enstTYinOSDTUYi4qTgQARh0b
        a/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7pxaQ+TDOZPU7FYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLeXzzNWnCeq2L+j80sDYzXOboYOTkkBEwk
        PtyaxApiCwksZZS4s8wUIi4hcXthEyOELSzx51oXWxcjF1DNU0aJP3O3sXcxcnCwCWhJNHaC
        mSIClRJnv8iClDALnGOSuHnxGhtIr7BAlMSmL/eZQGwWAVWJpm03wXbxClhJ7Nj7iRlivrzE
        zEvf2UFsTgFric1T5jFB3GMl8ezBRzaIekGJkzOfsIDYzED1zVtnM09gFJiFJDULSWoBI9Mq
        RpHU0uLc9NxiI73ixNzi0rx0veT83E2MwHjdduznlh2MK1991DvEyMTBeIhRgoNZSYQ3Ifp+
        khBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnAxNGXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
        QHpiSWp2ampBahFMHxMHp1QDk0331ldGj1tDHp2wZy2qWFu/4cXNjveJF0vkP7NMY1H85pnH
        dLzr6ZvWrAvq9yMjZvffZytx8H/h475VmTfq/nRd2X+PEiS++vcYGp1Wv5EYd9lMZ3u306u5
        S+8EvFFe5eE21fHbSZZ9WvuDd08vPNA4O/DUhDxdzcSlbOEXJrmnZP85UVi4da0Dq+G9Nao7
        QoytN3339kta7979jeNTvz9PV5Xlzakiv4/VeiSKvJew5/vEc2DFK3flVRf4v4emXRFL2pny
        JbeWa1U4Vx6zmJq32EbNtYu1Ih8X7xXKSczukFCqbF3rNfGs3vo3TteC586/tnXZNQPfC84b
        d4p9+rTEQcdk4f8jvducBK2YlFiKMxINtZiLihMBaWW7FWADAAA=
X-CMS-MailID: 20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm-zone.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..31c16aafdbfc 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,9 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if ((bdev_offset_from_zone_start(md->disk->part0,
+						 clone->bi_iter.bi_sector)) != zwp_offset)
+
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +604,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1

