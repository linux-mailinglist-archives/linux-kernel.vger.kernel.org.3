Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E154451C165
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380165AbiEENyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380128AbiEENyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:54:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A832AE13
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:51:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135102euoutp025f4d82bb804e227c2dd70b90ee88e2b5~sOcCkZ0aW0043500435euoutp02W
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:51:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505135102euoutp025f4d82bb804e227c2dd70b90ee88e2b5~sOcCkZ0aW0043500435euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758662;
        bh=UsMZc8nrA7AxKVTJxVI8cGyE/RIyWy6Qqg8/sjz0/6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJet69sF1q9Aykra4Vt7GFXQCGtPdXe91oI2cZjt+v/6dRo/QdzO8B3L2M87GvQQE
         KLKiMzEFAjCipzVE6pYJ8He/VMZ5FZR8lmN2pKpR9mr5/Y62dAs6XlCoVaKrNzaVzU
         mcS4iAic9zHeUkToSH6fPLp9i3fsp+jpssAPvhlw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135100eucas1p178adb274f14a57ae0ae2b6e79ce51c4e~sOcAqnyeI2591125911eucas1p15;
        Thu,  5 May 2022 13:51:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 67.72.10260.446D3726; Thu,  5
        May 2022 14:51:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220505135100eucas1p29e1b1452cc81a76460b938df339cb91a~sOcAA6CLu3233032330eucas1p2s;
        Thu,  5 May 2022 13:51:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135100eusmtrp1f71c125d5d60ed706b2635b94212d3d9~sOb--zSZQ1281012810eusmtrp1j;
        Thu,  5 May 2022 13:51:00 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-a4-6273d6446a33
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.5A.09404.446D3726; Thu,  5
        May 2022 14:51:00 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135059eusmtip1b42a646b99359fa1cfd66ec590497861~sOb-pmuio0093500935eusmtip1E;
        Thu,  5 May 2022 13:50:59 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Thu,  5 May 2022 15:47:02 +0200
Message-Id: <20220505134710.132630-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7ou14qTDI5MN7BYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2WLvLW2Ly7vmsFlM
        aPvKbHFjwlNGi89LW9gt1tx8yuIg4HH5irfHvxNr2Dx2zrrL7nH5bKnHplWdbB4LG6Yye+y+
        2QAUb73P6tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwBvFJdNSmpOZllqkb5dAlfG/q/t7AVf
        VSumtC1hamC8JNfFyMkhIWAicevkMaYuRi4OIYEVjBLTntxngXC+MEosefYbyvnMKPGtfzsr
        TEvbrEPsEInljBKtb5azQjgvGSWez29h62Lk4GAT0JJo7AQrEhHoZpQ42/yGBaSbWaCLSWL2
        Gx4QW1ggWuLpsRYmkHoWAVWJTyfNQcK8AlYSO7bMYYdYJi8x89J3MJtTwFpiTudDVogaQYmT
        M59AjZSXaN46mxlkl4TAZk6JV/t/MEI0u0ism7UPapCwxKvjW6BsGYnTk3tYIOxqiac3fkM1
        tzBK9O9cD/aABNC2vjM5ICazgKbE+l36EOWOEl87LjNDVPBJ3HgrCHECn8SkbdOhwrwSHW1C
        ENVKEjt/PoFaKiFxuWkOC0SJh8ThiX4TGBVnIfllFpJfZiGsXcDIvIpRPLW0ODc9tdg4L7Vc
        rzgxt7g0L10vOT93EyMwEZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawkwuu8tCBJiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA9OMCTdf6jA2vlp9+No6TvHl
        u0MuTQ4wubGzzFOlJubbz7sCSyLZy9smZjtffnJDfGu1Ru3W/84HpDm5c1488Z7wV6FgguSy
        3BqdrR+2dj7tVNn4Xqix4MfXBf0nGZqXS23ZVz/X7NBf0a8TWn++W15uxX7VecqBN7vP9B6U
        UrW5YKat7aIsWSThPrvbM+LC5ZkzD87Yp7jsVsCFTbs53Dgb1U1NVq+ON3gaLbKPh+3S7WAr
        ZtcKu7t6VdM73yQG3Hu1O/Z9Tu/0BQ2zRS2SeI9N8PDbXmdYsqSynUkk/s2s0w/dlp074cJ/
        T6JS6p5bbJ9cU31J552NZg/Sv7/J9847W/p8VYuTKG/elsW8UgpKLMUZiYZazEXFiQD1SyKK
        8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7ou14qTDLZtZ7FYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2WLvLW2Ly7vmsFlM
        aPvKbHFjwlNGi89LW9gt1tx8yuIg4HH5irfHvxNr2Dx2zrrL7nH5bKnHplWdbB4LG6Yye+y+
        2QAUb73P6tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwBvlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G/q/t7AVfVSumtC1hamC8JNfFyMkhIWAi
        0TbrEDuILSSwlFHi/147iLiExO2FTYwQtrDEn2tdbF2MXEA1zxkllm3/zNTFyMHBJqAl0djJ
        DhIXEZjKKHFh+wUWEIdZYAqTxJfrM1hAuoUFIiWunD7DCtLAIqAq8emkOUiYV8BKYseWOewQ
        C+QlZl76DmZzClhLzOl8yApxkJXExIfv2CDqBSVOznwCNpIZqL5562zmCYwCs5CkZiFJLWBk
        WsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYtduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8Dov
        LUgS4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5Hxg2sgriTc0MzA1NDGzNDC1NDNWEuf1LOhI
        FBJITyxJzU5NLUgtgulj4uCUamDK2F/Fc44p6PmNhT5ezg/O+mx/Pffo4xRlryv7LgpLFkj2
        muiKuPJfjk9j43m9a+f9roakBfe+M23fZS1TyrJfek9SaPH8id12Zoapa9d2pGZz983PfXs2
        MLQu9u1/xYyb33ednK4oYnHh3Yd5NbYy5TIvy5cfczhjF11WdG6uGk+xeMPdL8sMtLk7D7fE
        HP22dtLF83F3vk28rJNnZqPZ41Okqq8oeE1RZcvWCJ6y6f8P/56cWm74cccib6b3K9Zyn81b
        pLPiHsv0SuvnC9e3M4pMn+r388jkhF8XnjpVsbXezfE5XCnUzN//mU9WxufkjBuz70ct89zi
        6LNI03Gv+okKx8zzqlLvnk8xbjuvxFKckWioxVxUnAgAKQciuGMDAAA=
X-CMS-MailID: 20220505135100eucas1p29e1b1452cc81a76460b938df339cb91a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135100eucas1p29e1b1452cc81a76460b938df339cb91a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135100eucas1p29e1b1452cc81a76460b938df339cb91a
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135100eucas1p29e1b1452cc81a76460b938df339cb91a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if a given sector is aligned to a zone is a common
operation that is performed for zoned devices. Add
blk_queue_is_zone_start helper to check for this instead of opencoding it
everywhere.

Convert the calculations on zone size to be generic instead of relying on
power_of_2 based logic in the block layer using the helpers wherever
possible.

The only hot path affected by this change for power_of_2 zoned devices
is in blk_check_zone_append() but blk_queue_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes. Note that the append
path cannot be accessed by direct raw access to the block device but only
through a filesystem abstraction.

Finally, allow non power of 2 zoned devices provided that their zone
capacity and zone size are equal. The main motivation to allow non
power_of_2 zoned device is to remove the unmapped LBA between zcap and
zsze for devices that cannot have a power_of_2 zcap.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  3 +--
 block/blk-zoned.c      | 27 +++++++++++++++++++++------
 include/linux/blkdev.h | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f305cb66c..b7051b7ea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (pos & (blk_queue_zone_sectors(q) - 1) ||
-	    !blk_queue_zone_is_seq(q, pos))
+	if (!blk_queue_is_zone_start(q, pos) || !blk_queue_zone_is_seq(q, pos))
 		return BLK_STS_IOERR;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a09a2eef9..4a90a999c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -290,10 +290,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!blk_queue_is_zone_start(q, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!blk_queue_is_zone_start(q, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -491,14 +491,29 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zone size",
+				disk->disk_name);
+			return -ENODEV;
+		}
+
+		/*
+		 * Don't allow zoned device with non power_of_2 zone size with
+		 * zone capacity less than zone size.
+		 */
+		if (!is_power_of_2(zone->len) &&
+		    zone->capacity < zone->len) {
+			pr_warn("%s: Invalid zoned size with non power of 2 zone size and zone capacity < zone size",
+				disk->disk_name);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		/*
+		 * Division is used to calculate nr_zones for both power_of_2
+		 * and non power_of_2 zone sizes as it is not in the hot path.
+		 */
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22fe512ee..32d7bd7b1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -686,6 +686,22 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
+{
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	u64 remainder = 0;
+
+	if (!blk_queue_is_zoned(q))
+		return false;
+
+	if (is_power_of_2(zone_sectors))
+		return IS_ALIGNED(sec, zone_sectors);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	/* if there is a remainder, then the sector is not aligned */
+	return remainder == 0;
+}
+
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 					 sector_t sector)
 {
@@ -732,6 +748,12 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 {
 	return 0;
 }
+
+static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int queue_max_open_zones(const struct request_queue *q)
 {
 	return 0;
-- 
2.25.1

