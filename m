Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DBA59E56F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiHWO4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242894AbiHWOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:55:30 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4AEEC5F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:20:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121905euoutp02b8570692394e66dc602e2758f687bae0~N_JJxhUzH1887718877euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121905euoutp02b8570692394e66dc602e2758f687bae0~N_JJxhUzH1887718877euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257145;
        bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4wmJnw5agbYv6zZfJxXTejU84mDfZADGerYA3jVaP2GU8IQw/kh9MMHUyOUKikNM
         IN2KNRX/4pHf7lRDTpLp3GI3B5SprjkP1CsCqwb3XwlbeU453e/SgNb7U/9dwPRDFO
         yY4oZjrAzDBEc5k2RueUiyiXKFgTf1l7Y3QbzIMA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121903eucas1p22311fd0c7e7894838285e8fa895ecb24~N_JHw-kQW2413924139eucas1p2h;
        Tue, 23 Aug 2022 12:19:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 54.82.29727.7B5C4036; Tue, 23
        Aug 2022 13:19:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823121902eucas1p21176f8fff1a4f928bee6e03141cdf69a~N_JGxAtzq2017520175eucas1p2c;
        Tue, 23 Aug 2022 12:19:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823121902eusmtrp15e4721a9aee4988894600e9acf4800ba~N_JGu9gxN1042010420eusmtrp1x;
        Tue, 23 Aug 2022 12:19:02 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-6e-6304c5b763dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FB.71.10862.6B5C4036; Tue, 23
        Aug 2022 13:19:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121901eusmtip1435b20acbbbd983cb29e65ca921d4ca3~N_JGYtfun0901809018eusmtip1D;
        Tue, 23 Aug 2022 12:19:01 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v12 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date:   Tue, 23 Aug 2022 14:18:47 +0200
Message-Id: <20220823121859.163903-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7djPc7rbj7IkG8x/zm0x/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF5
        1xw2i/nLnrJbTGj7ymxxY8JTRovPS1vYLdbcfMpiceKWtIOwx+Ur3h47Z91l97h8ttRj06pO
        No/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1bVjF6bD5d7fF5k5xH+4FupgCeKC6blNSczLLUIn27
        BK6Mv1PbmQquilQ8m/CKrYFxlmAXIyeHhICJRNPO2axdjFwcQgIrGCUe/d7PBuF8YZRYt6wN
        yvnMKLFo5RRWmJbFK88ygdhCAssZJS5OcYUoesEo8aflB1CCg4NNQEuisZMdpEZEIF3i69cN
        jCA1zAJdzBJL/x5hA6kRFkiSWL5GHaSGRUBV4tHy18wgYV4BK4mn8x0hVslLzLz0HWwMp4C1
        xLylpxhBbF4BQYmTM5+wgNjMQDXNW2czg4yXENjPKbFy2wk2iGYXiZedvSwQtrDEq+Nb2CFs
        GYnTk3ug4tUST2/8hmpuYZTo37ke7DYJoG19Z3JATGYBTYn1u/Qhyh0lVv88BlXBJ3HjrSDE
        CXwSk7ZNZ4YI80p0tAlBVCtJ7Pz5BGqphMTlpjlQSz0kjly/yjKBUXEWkmdmIXlmFsLeBYzM
        qxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQKT4ul/xz/tYJz76qPeIUYmDsZDjBIczEoi
        vNUXGZKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MKXk
        cJ3ljt0bU8EheuWUl/l7p+PnHv2c8mTbkUntr8wZtxtP1llsLrGfIzJ/59+Td15zTgrQeX15
        3uPoo1dNps+rjuEXeKekEZN4avEN+c2H3wQFXXSZEtpw0GdN3fv3wTOji15N/7fSJNCtisOg
        /bXU9Ts3fkzl+LeQ40f/ZTHG4++CNp/3uDA/JenGy59dK3d+jQ8zdvx2/avpiSusdsI+xVNP
        rF1efGLHG+n8z7GG3pN6TJR7LkVM2H1M4+zq1u1tvMdavs2c6dz57NWKNTf2CKwyvD/xjdrl
        uLvelTkpGnq9qdW7Qzyvnwk+Mmd1SsOXnRuri4NezHtskytncW1C82zW1ZYn93a0Np9xUjHQ
        U2Ipzkg01GIuKk4EAPS5l9/5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7rbjrIkG+x7yWox/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF5
        1xw2i/nLnrJbTGj7ymxxY8JTRovPS1vYLdbcfMpiceKWtIOwx+Ur3h47Z91l97h8ttRj06pO
        No/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1bVjF6bD5d7fF5k5xH+4FupgCeKD2bovzSklSFjPzi
        ElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mv1PbmQquilQ8m/CKrYFx
        lmAXIyeHhICJxOKVZ5lAbCGBpYwSl746QcQlJG4vbGKEsIUl/lzrYuti5AKqecYo0dZwlrmL
        kYODTUBLorGTHaRGRCBX4vDmCUwgNcwCs5gl/tyZygySEBZIkFjct5AFxGYRUJV4tPw1WC+v
        gJXE0/mOEPPlJWZe+g42h1PAWmLe0lOMEPdYScy/9YkNxOYVEJQ4OfMJ2BhmoPrmrbOZJzAK
        zEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgBG879nPLDsaVrz7qHWJk4mA8
        xCjBwawkwlt9kSFZiDclsbIqtSg/vqg0J7X4EKMp0NkTmaVEk/OBKSSvJN7QzMDU0MTM0sDU
        0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGpr3+KmXJ7r9eDpV8PyPPueCe7QcPpMmPv
        4qzs60yhAtItjrYzoxbtNG0qOKwQt9Qm8rLN6dsHwha9FrbQcJqc/kY0gm87J+8u9R+Jxw1+
        fn4iPTOs3WE2/9PGivf9cppVHjk2q89/edesquqxseTtzk/Ts8573v13Z9LGCt5jpw9ltOpk
        OiqVit55c3r2I8NE3ez2MyvS1mekhbQ1rPyZwlh589InVb3Whfp3ffYZHyssFZsp8PWi3i+Z
        HS+e2iepTNyowLp2b/vRszoP41hWy3VdmDHbklH6/u9be87G/F/49PzZF9kip40dJpyJtpnT
        LMZaXRPySj3+KIf9OubNwRuUu5YGvnxeufnUm8kOSizFGYmGWsxFxYkAahUkaWkDAAA=
X-CMS-MailID: 20220823121902eucas1p21176f8fff1a4f928bee6e03141cdf69a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121902eucas1p21176f8fff1a4f928bee6e03141cdf69a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121902eucas1p21176f8fff1a4f928bee6e03141cdf69a
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121902eucas1p21176f8fff1a4f928bee6e03141cdf69a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt bdev_nr_zones and disk_zone_no functions so that they can
also work for non-power-of-2 zone sizes.

As the existing deployments assume that a device zone size is a power of
2 number of sectors, power-of-2 optimized calculation is used for those
devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 13 +++++++++----
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a264621d4905..dce9c95b4bcd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,17 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * bdev_nr_zones - Get number of zones
  * @bdev:	Target device
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int bdev_nr_zones(struct block_device *bdev)
 {
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
+	sector_t capacity = bdev_nr_sectors(bdev);
 
 	if (!bdev_is_zoned(bdev))
 		return 0;
-	return (bdev_nr_sectors(bdev) + zone_sectors - 1) >>
-		ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(bdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 84b13fdd34a7..ab82d1ff0cce 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -674,9 +674,15 @@ static inline unsigned int disk_nr_zones(struct gendisk *disk)
 
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return sector >> ilog2(disk->queue->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
-- 
2.25.1

