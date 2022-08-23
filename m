Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884A59E5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiHWPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiHWPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:07:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43D32A6AC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:36:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121910euoutp010f289860782e111efde02b7008071cac~N_JO1nQiZ1729817298euoutp01T
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220823121910euoutp010f289860782e111efde02b7008071cac~N_JO1nQiZ1729817298euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257150;
        bh=fOgcHWBTKngr4edtg4i63nscIP4FtbRrZLjdCL9iolE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROsjSwDEeDbMEExRyjvMcjnXxp+PuQMYu/PHh72k8UGyZM71d7z54cSjJjH2eXDVC
         Dy47rPafNv7URJSHiyeM3s+4hNqDH0/7LCfqI5N/0bE5iXHxbPmmYw3ARJ/DRcgWTq
         DJferGd0F5RgkJYNix+dnaU6SVZwXihyJXJ0x/Q8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121908eucas1p27f2127263e2af4e2b8857a3cfc1b7969~N_JMm3e2P2413924139eucas1p2o;
        Tue, 23 Aug 2022 12:19:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.82.29727.CB5C4036; Tue, 23
        Aug 2022 13:19:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823121907eucas1p27664a441113cb557af8fce3ef2800e34~N_JMGP0hN2415624156eucas1p2F;
        Tue, 23 Aug 2022 12:19:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121907eusmtrp21f6442a1b3bae68f057c358297d87160~N_JMFKWjZ2697126971eusmtrp2i;
        Tue, 23 Aug 2022 12:19:07 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-89-6304c5bcb881
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.12.07473.BB5C4036; Tue, 23
        Aug 2022 13:19:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121907eusmtip216d80b6051329442a5bf0ffbaa5d553e~N_JLz4EDR1999619996eusmtip2N;
        Tue, 23 Aug 2022 12:19:07 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v12 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Tue, 23 Aug 2022 14:18:52 +0200
Message-Id: <20220823121859.163903-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7djPc7p7jrIkGyw7KGax/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK6Oz
        ia3guHTFjdZzrA2My8W7GDk5JARMJF4dXsfexcjFISSwglHia/d3JgjnC6PEvasXWCGcz4wS
        D45sYYJpuXRhL1TVckaJ4zuuQjkvGCVWbfzB2MXIwcEmoCXR2MkO0iAikC7x9esGRhCbWeAO
        k8S367kgtrBApMSz6cuZQWwWAVWJp99fsIHYvAJWEueOLWSFWCYvMfPSd7A5nALWEvOWnmKE
        qBGUODnzCQvETHmJ5q2zmUFukBDYzCkx5dYUdpAbJARcJO62mEDMEZZ4dXwLO4QtI/F/53yo
        Z6olnt74DdXbwijRv3M9G0SvtUTfmRwQk1lAU2L9Ln2IckeJwy8vsUBU8EnceCsIcQGfxKRt
        05khwrwSHW1CENVKEjt/PoFaKiFxuWkOC4TtIbHk5iPmCYyKs5D8MgvJL7MQ9i5gZF7FKJ5a
        WpybnlpsmJdarlecmFtcmpeul5yfu4kRmAxP/zv+aQfj3Fcf9Q4xMnEwHmKU4GBWEuGtvsiQ
        LMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoGJdeXf69a8
        /ZVTl6Xw9M3TmCR8lofRsPfO9rZf3baNOyT109WdQsX8T+6N2cW67mL93g0JTPurBH/f3b21
        9v7zDTv2zL7t//+K70b9DO2q99d7LtmdmxVnNmP6EbvvHq90djbZ7wnjTflzYFKCiqgtR3l6
        +45Hj3cosLuasBRzLzgwTTtcROR0mvVkU2U3JSEb/7h/IqfvL3ymo3aroT58ws3vK1xS0+eL
        vr75JePo6RZ/Dvbte/seT/T7fmK1u3iv8vGmzD/i68/b7rCLmrj0FsdTaSWFZwG/f2WHH7c4
        1f+7x2JZ1jddn+ptz7dLGeYeuXX8bUf+/tape/7/KPm07qO2r2aXfVh/ncf1JH8dJZbijERD
        Leai4kQAJfWo2PUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7q7j7IkG2zZZWSx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6Ozia3guHTFjdZzrA2My8W7GDk5
        JARMJC5d2MvUxcjFISSwlFHiz8e7jBAJCYnbC5ugbGGJP9e62CCKnjFK/J76HCjBwcEmoCXR
        2MkOUiMikCtxePMEsEHMAm+YJI7+a2EFqREWCJd4eLQEpIZFQFXi6fcXbCA2r4CVxLljC1kh
        5stLzLz0HWwOp4C1xLylp8D2CgHVzL/1CapeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDI
        tIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwcrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4a2+
        yJAsxJuSWFmVWpQfX1Sak1p8iNEU6O6JzFKiyfnA1JFXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cC0RHle1ZyoV9wSMYzpkYvuxm7KrW75Kb3gac7PzIlTjTlW
        p1yKnMp37F1AaaBd08X/7d8VK+o+1Wtebiq2nnJn1hThXZ/nnHl7+53i2XvPf60LTb40Rc/5
        0rfAg4ulYp/fSed9LBm2Z3WGQfmDe+cLnT99WPwy8Yhg6KX3mc0/t2scEp2sH/twm4rwLVWF
        tuNmj+q61y8SOuble6JPaN/PCh33zfX/N92U7FsWlxzz2KB6S1vLiZgYA7fWzC1Bek9yZnVc
        tNQ/q39HpeiZHle4WrW1xEn1h1zBk34cNT7w6cyqkyUhbusU/E/V8+puXOPeF2z++JRx3vGZ
        /7onrF8hGPy2du0O3oPrF2hGdvyRUWIpzkg01GIuKk4EAIOFNLhlAwAA
X-CMS-MailID: 20220823121907eucas1p27664a441113cb557af8fce3ef2800e34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121907eucas1p27664a441113cb557af8fce3ef2800e34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121907eucas1p27664a441113cb557af8fce3ef2800e34
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121907eucas1p27664a441113cb557af8fce3ef2800e34@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the power-of-2(po2) based calculation with zone size to be generic
in null_zone_no with optimization for po2 zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for po2 zone sizes as this function is
called only during the initialization and will not be invoked in the hot
path.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c     |  5 ++---
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    | 18 +++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..3b24125d8594 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1976,9 +1976,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("Invalid zero zone size\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..f63b6bed1bb3 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -83,6 +83,7 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	unsigned int zone_size_sects_shift;
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..015f6823706c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,7 +16,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -65,10 +68,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -86,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
 
+	if (is_power_of_2(dev->zone_size_sects))
+		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
+	else
+		dev->zone_size_sects_shift = 0;
+
+	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
+					      dev->zone_size_sects);
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
-- 
2.25.1

