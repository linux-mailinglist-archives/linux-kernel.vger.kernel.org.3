Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E031A59E6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbiHWQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244512AbiHWQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:16:22 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E05E32E083
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:37:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121905euoutp0262bbd72fc39524e351ad42cea87eb3ae~N_JKREv6m2185121851euoutp02O
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121905euoutp0262bbd72fc39524e351ad42cea87eb3ae~N_JKREv6m2185121851euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257145;
        bh=6P1R/E9YGiOBn04IzPo5prb2SpaL2SRQk5AKU4iXtGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QeHS5rKgu0j20EdL4dm7Hsc12Lz1jmX0rDcJU5/xjr6N62JWeqQmAQ5jhg8+JNItp
         vtOHVNRtZ0kNajkgf8O23jlGeoQ6+kdIDFfthXPTbiLaTG5CfbwSOA4klvADgCBVUF
         HR3F1Flgj1bLUpruGneAt0AzVu+hLs1JPmaMcO/0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121904eucas1p21882ea32eaa14c1822e3cc091f51cfe0~N_JIrXXlB1780717807eucas1p2i;
        Tue, 23 Aug 2022 12:19:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.82.29727.8B5C4036; Tue, 23
        Aug 2022 13:19:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823121903eucas1p230518b312d5260d28e356ba911a27469~N_JIAX5Sx2020620206eucas1p2N;
        Tue, 23 Aug 2022 12:19:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823121903eusmtrp14bf9acadd2de37d63b4d534af5195731~N_JH-ndbR1042010420eusmtrp11;
        Tue, 23 Aug 2022 12:19:03 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-75-6304c5b86dd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4E.71.10862.7B5C4036; Tue, 23
        Aug 2022 13:19:03 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121903eusmtip21130b9482eb3022901311def411bb039~N_JHsahh32346623466eusmtip2C;
        Tue, 23 Aug 2022 12:19:03 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Date:   Tue, 23 Aug 2022 14:18:48 +0200
Message-Id: <20220823121859.163903-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87o7jrIkG3ybzm2x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPHKJpeCF
        aMWT05fYGhhnC3UxcnJICJhIPH35mRnEFhJYwSix6F8JhP2FUeJqh34XIxeQ/ZlRorN9NjtM
        w/amo0wQieWMEl1P1jNDOC8YJWbO3M3SxcjBwSagJdHYCdYgIpAu8fXrBkaQGmaBbUwSv+5e
        YgFJCIMkLrwCK2IRUJU4OOkrK4jNK2AlsejeHxaIbfISMy99B6vhFLCWmLf0FCNEjaDEyZlP
        wGqYgWqat84GO0JCYD2nxJEPi5ggml0k5rx+DnW2sMSr41ugbBmJ05N7oBZUSzy98RuquYVR
        on/nejaQDySAtvWdyQExmQU0Jdbv0ocod5T4c+cxVAWfxI23ghAn8ElM2jadGSLMK9HRBg1c
        JYmdP59ALZWQuNw0B2qph8TbHa0sExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXYMC+1XK84
        Mbe4NC9dLzk/dxMjMAme/nf80w7Gua8+6h1iZOJgPMQowcGsJMJbfZEhWYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVANTq7b98nNvOK0qYmLfBVTX9tSf
        nbTy9rTNmVdfWvG8su39c2hNTN+tHuGM2J0V/1a08yw113E8nHzuc1qS2gmVePEv51b0b+6Q
        urlXwuSbx4zXMy58V9hoqBl18d7pBVrdk38flw3oSpLMORzx4o9awOog5hqRd/eud25IVhba
        FTl5VVjQ56PmWtFbshf4iClI5EdMnsMnac1yg2HVUqmHcs9dtle/PqeYcPLKVrZMOy/B3MKP
        j+d/W26z5ajg/rDdfMFMll2Zh8UU2qccq0p+LO6eXXb43/WTn3gSHufIHv7w+t05+ZiplbP0
        npy/+VFrfvbGQyZOijkTN7EuEf3hdML8j/3jrVM211y6tnxxkBJLcUaioRZzUXEiAJ9hjJ3x
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7rbj7IkG6xfJGGx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsPHKJpeCFaMWT05fYGhhnC3UxcnJICJhI
        bG86ytTFyMUhJLCUUeL9hfXsEAkJidsLmxghbGGJP9e62CCKnjFKbN/+kqWLkYODTUBLorET
        rF5EIFfi8OYJYIOYBY4wSaxuXMsKkhAWSJXYefsY2CAWAVWJg5O+gsV5BawkFt37wwKxQF5i
        5qXvYIM4Bawl5i09BVYvBFQz/9YnNoh6QYmTM5+A1TMD1Tdvnc08gVFgFpLULCSpBYxMqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQJjdtuxn1t2MK589VHvECMTB+MhRgkOZiUR3uqLDMlC
        vCmJlVWpRfnxRaU5qcWHGE2B7p7ILCWanA9MGnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLp
        iSWp2ampBalFMH1MHJxSDUyL67UEN+tPbficdih617b1IrnJfHY5Jx9JsPY9u6LgnjAtUdjq
        1lyBniNPdulOmzbHzUxJTn1W1DrBLFOVcE9X1utJKid+GM09k8kz85fWxt6P3fMEVv1pZwzd
        7R1jt7cuhEWd8dIxdb1H6b8W+ObomnYYdp9ak+Znlnbo2c/vIckffHccYHH/6eBSl8SbOMXU
        c9JbnrX2KjfWJ79irEl+f0llouiBLRv/PDTtUROap+op/mta+/Egp4I3rJyCPyT3t+7MVOm+
        qne6dk3+7087H8l8ePHJ9urCxkXCp/3b1pdV9P1UORE6k3u+n4FwVYGb5iE1+/8Xtp5J5L78
        uC3iwpuP2y/sN2ZafLrsRKoSS3FGoqEWc1FxIgCJP07aYgMAAA==
X-CMS-MailID: 20220823121903eucas1p230518b312d5260d28e356ba911a27469
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121903eucas1p230518b312d5260d28e356ba911a27469
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121903eucas1p230518b312d5260d28e356ba911a27469
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121903eucas1p230518b312d5260d28e356ba911a27469@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
in the blkdev.h include file. Simplify bdev_is_zoned() by removing the
superfluous NULL check for request queue while we are at it.

This commit has no functional change, and it is a prep patch for allowing
zoned devices with non-power-of-2 zone sizes in the block layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 include/linux/blkdev.h | 43 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab82d1ff0cce..84e7881262e3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -635,6 +635,11 @@ static inline bool queue_is_mq(struct request_queue *q)
 	return q->mq_ops;
 }
 
+static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
+{
+	return bdev->bd_queue;	/* this is never NULL */
+}
+
 #ifdef CONFIG_PM
 static inline enum rpm_status queue_rpm_status(struct request_queue *q)
 {
@@ -666,6 +671,20 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
+static inline bool bdev_is_zoned(struct block_device *bdev)
+{
+	return blk_queue_is_zoned(bdev_get_queue(bdev));
+}
+
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!blk_queue_is_zoned(q))
+		return 0;
+	return q->limits.chunk_sectors;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline unsigned int disk_nr_zones(struct gendisk *disk)
 {
@@ -892,11 +911,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
 
-static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-{
-	return bdev->bd_queue;	/* this is never NULL */
-}
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -1296,25 +1310,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
-static inline bool bdev_is_zoned(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return blk_queue_is_zoned(q);
-
-	return false;
-}
-
-static inline sector_t bdev_zone_sectors(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!blk_queue_is_zoned(q))
-		return 0;
-	return q->limits.chunk_sectors;
-}
-
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1

