Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0E595D03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiHPNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiHPNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:49 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18F5E306
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131542euoutp011591e604c71062a932fb0dede72cbade~L1ZlhOC4O2896828968euoutp01c
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131542euoutp011591e604c71062a932fb0dede72cbade~L1ZlhOC4O2896828968euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655742;
        bh=6P1R/E9YGiOBn04IzPo5prb2SpaL2SRQk5AKU4iXtGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rxgJrkYmDNav+8n2hLlQSMbGqvsoS5yLZ7lvDF37BQmATyOjPJvL4foUtDzFWipuT
         62pm3nFi2KJnBNHA/sPQOieqcBc9vm1IJPUiOcajbr7B1K2IdtKO0cINXhSRUqZrAA
         xTDj7NJ5kq+e1WqF1EQ8q4Q7XmUV4Gy2ml87SsQU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816131540eucas1p226ff379faf0d84c5021a3cd93e20489c~L1Zjq9F3J3098130981eucas1p2A;
        Tue, 16 Aug 2022 13:15:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.65.09580.C789BF26; Tue, 16
        Aug 2022 14:15:40 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131539eucas1p171840f8cb3a2983274fce0322c0f4901~L1Zi8uyZc0141901419eucas1p1P;
        Tue, 16 Aug 2022 13:15:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131539eusmtrp2842c1f8d2fd4e4b1b2aa3d3368f5a790~L1Zi7syvS0621306213eusmtrp2B;
        Tue, 16 Aug 2022 13:15:39 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-da-62fb987ccf45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.21.09038.B789BF26; Tue, 16
        Aug 2022 14:15:39 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131539eusmtip24b3a859c602c2943e28d2ca0379f9d29~L1Ziif3yT1196811968eusmtip2Z;
        Tue, 16 Aug 2022 13:15:39 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Date:   Tue, 16 Aug 2022 15:15:25 +0200
Message-Id: <20220816131536.189406-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87o1M34nGXzbzWex/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPHKJpeCF
        aMWT05fYGhhnC3UxcnBICJhINB4s7WLk4hASWMEoMfFGNyuE84VR4sikz0wQzmdGia2v7zB2
        MXKCdZxb28AOkVjOKLF+1VI2COcFUP/p60wgc9kEtCQaO9lBGkQE0iWmtLxkAalhFtjGJPHm
        0gSwScJAic+HT7KA2CwCqhJfL20Bs3kFrCQmbnzOBLFNXmLmpe9ggzgFrCX+NayCqhGUODnz
        CZjNDFTTvHU2M8gCCYH1nBJre5YyQzS7SMx/PYkFwhaWeHV8CzuELSPxf+d8qAXVEk9v/IZq
        bmGU6N+5ng0SMtYSfWdyQExmAU2J9bv0IcodJdbc3s0MUcEnceOtIMQJfBKTtk2HCvNKdLQJ
        QVQrSez8+QRqqYTE5aY5UMd4SHzdfoFlAqPiLCTPzELyzCyEvQsYmVcxiqeWFuempxYb56WW
        6xUn5haX5qXrJefnbmIEpsHT/45/3cG44tVHvUOMTByMhxglOJiVRHgFX/xIEuJNSaysSi3K
        jy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cBU9GuJ8ZnCSW0vfyxwPDN1
        pthcjp+W/Jf7/zLJrMq03cd8PGxdfH3Ik92R069MP786dZ3694vcRZpzNE90P4+TaZf/EuO1
        z+rp7yJrA5bdj50z0p/+2n/6kxmLpH7hr73GXjHarw7w5Escz7C1VN5a4jO3veoiZ9B541dF
        fWHl3+T/eOoo3PB6W7h6XZfueZ79wqZRKZdtpAXFZ5b6/nm8sdT/QsTUi4c3ZiyokljWnR+/
        fe8h1k574bdv7tlO43L5oRZgI6zfEP6fizd78z67J2nbUt8KPfiw/M10Q0OfKpapc5mf8RjP
        vTt3voW0+/86qVub/2vyG957wrh9le+ldz1VU9qKalbOEMw66CilxFKckWioxVxUnAgAu7mA
        O/IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7rVM34nGRw/KWmx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsPHKJpeCFaMWT05fYGhhnC3UxcnJICJhI
        nFvbwA5iCwksZZT4PEsYIi4hcXthEyOELSzx51oXWxcjF1DNM0aJe0dXsHQxcnCwCWhJNHaC
        9YoI5EosWtbBClLDLHCESWLB9OXMIAlhgVSJqa/OsYHYLAKqEl8vbWEBsXkFrCQmbnzOBLFA
        XmLmpe9ggzgFrCX+NaxigTjISqLt2GVmiHpBiZMzn4DFmYHqm7fOZp7AKDALSWoWktQCRqZV
        jCKppcW56bnFRnrFibnFpXnpesn5uZsYgRG77djPLTsYV776qHeIkYmD8RCjBAezkgiv4Isf
        SUK8KYmVValF+fFFpTmpxYcYTYHunsgsJZqcD0wZeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlC
        AumJJanZqakFqUUwfUwcnFINTA0Xmk3mL7ioEmV91i/GtVFwy29mDvG5v/7FeC14rHJDL+w2
        X8mKNSVtG/VuXNQxyOwMXluuVqG/eX3BNvN7e+Zunm3jtbM56VrR2Z3t9/pV1zw/+eFq0V4b
        o8KeNceVzIU+fZ90Lrn45INjzYpr10yx7sjjzwrp0M/tXl7f1H76S/ikS46Rb/+GinqdZXfJ
        3m0za4/p2iNanHO7RTezLRFZvOO4yuZNhffKJk0qNAo4dqLwZ4W5QuHf+UZtsXlnxAw3Kh48
        fymVheN51p9rtd6d3ifkins3Vn7J1TANVmvO/5igNbUg8lRITc1ykZLHDX+tvcO/ysgczbuc
        d93q97tZ7Yw/5qcUXPl3YUvCViWW4oxEQy3mouJEANnt15lhAwAA
X-CMS-MailID: 20220816131539eucas1p171840f8cb3a2983274fce0322c0f4901
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131539eucas1p171840f8cb3a2983274fce0322c0f4901
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131539eucas1p171840f8cb3a2983274fce0322c0f4901
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131539eucas1p171840f8cb3a2983274fce0322c0f4901@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

