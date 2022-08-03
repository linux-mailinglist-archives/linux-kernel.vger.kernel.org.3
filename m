Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8E5889AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbiHCJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiHCJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1926553
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094807euoutp01e088b78b6b61cab57d01110756abd4c2~HzLoHyA913234332343euoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094807euoutp01e088b78b6b61cab57d01110756abd4c2~HzLoHyA913234332343euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520087;
        bh=nWR/3EtmjCPRzM7IHtW3EB0aleuY4H+/CRFeCI52+CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCNzAhNyp5IN+LRWzmAkmWK2SvtLCzPNiY9rgKn7pFVrk16GG5xJZdwFO8dDi7NyG
         Wv/sNUp8PKByDCiN65g31fOP9WxN2fSiv4vLO/005mp85H68zmvr9OgXDoe4RqULhA
         y5NWYjd0KCk/9nCCjbIgZ4ezVpxdss13OMMtI+iI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094805eucas1p2fb2e6683b85d89ad1c79c6978055ad18~HzLmlH4_X1615116151eucas1p2u;
        Wed,  3 Aug 2022 09:48:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.FF.09664.5544AE26; Wed,  3
        Aug 2022 10:48:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803~HzLmH9IqN1902519025eucas1p1H;
        Wed,  3 Aug 2022 09:48:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094804eusmtrp28c08a2adda8796fdf9c233c636159095~HzLmHClmQ0972009720eusmtrp2Y;
        Wed,  3 Aug 2022 09:48:04 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-79-62ea44553828
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.9B.09038.4544AE26; Wed,  3
        Aug 2022 10:48:04 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094804eusmtip23b70977da7da3b653211630caa4bac3a~HzLlvVUMC1623516235eusmtip2k;
        Wed,  3 Aug 2022 09:48:04 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 02/13] block:rearrange
 bdev_{is_zoned,zone_sectors,get_queue} helpers in blkdev.h
Date:   Wed,  3 Aug 2022 11:47:50 +0200
Message-Id: <20220803094801.177490-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7qhLq+SDBr2iVqsP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBnHH95nL9gu
        WnHgyGb2Bsbngl2MnBwSAiYS+9ZdZASxhQRWMEps2B/VxcgFZH9hlJjdsIwdwvkM5PStZYHp
        mLnsNhNEx3JGic4ZRRBFLxklVu1YATSKg4NNQEuisROsWUSgmVHi7t8eVhCHWWAGk0THxz6w
        ScICaRLre16C2SwCqhKT9/0Es3kFrCRuvnnCDLFNXmLmpe/sIDangLXElH//mCFqBCVOznwC
        Vs8MVNO8dTYzyAIJgc2cEj+XLYJqdpE49GwTE4QtLPHq+BZ2CFtG4v/O+VDxaomnN35DNbcw
        SvTvXM8G8oIE0La+MzkgJrOApsT6XfoQ5Y4SH6ecZYao4JO48VYQ4gQ+iUnbpkOFeSU62oQg
        qpUkdv58ArVUQuJy0xxoGHpInH0/i20Co+IsJM/MQvLMLIS9CxiZVzGKp5YW56anFhvmpZbr
        FSfmFpfmpesl5+duYgSmwdP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeO+4PE8S4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwNTqxjenYN1Uqe6S4rNuM0SK
        mERDM5fs6nq4lGnlJ5bCFJHwXawOX8Uetbu8NxVJ3Tcn75fF+hfm7j+Spzm6nZ26UuR0/MJ+
        yarYvd0WT1fY/bG44Pju8cJ658muKbc+O/evvPfia5LymY/Caekph0Wqpy7uU12RvUw4SntO
        ddvnk1ueN81QND7w8q9z6TKR8j2/U5IY9Y0P2m/qr7MLulWzwex/n8Kq8InREko1e8IVuQyr
        Ay1UObtEF/pkxl3bxXdNZNKevyY/Oa+Z/X56RVHqxVKhh1vVeKN6GZWUpIp6Q8773tYNkFlR
        tkHUjSPTfXGQS8iX88pSDenpRxpqVjDc/b1S8BD/pPKORTliSizFGYmGWsxFxYkAkFdT+fID
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7ohLq+SDG536lusP3WM2WL13X42
        i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
        v+wpu8WEtq/MFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
        5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnHH95nL9guWnHgyGb2Bsbngl2MnBwSAiYS
        M5fdZupi5OIQEljKKLH63DZmiISExO2FTYwQtrDEn2tdbBBFzxklLmxewtrFyMHBJqAl0djJ
        DhIXEehmlLh85hwriMMssIxJounLdTaQbmGBFInV59uYQGwWAVWJyft+soDYvAJWEjffPIHa
        Ji8x89J3dhCbU8BaYsq/f2BxIaCadX9nsULUC0qcnPkErJcZqL5562zmCYwCs5CkZiFJLWBk
        WsUoklpanJueW2ykV5yYW1yal66XnJ+7iREYtduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8N5x
        eZ4kxJuSWFmVWpQfX1Sak1p8iNEU6O6JzFKiyfnAtJFXEm9oZmBqaGJmaWBqaWasJM7rWdCR
        KCSQnliSmp2aWpBaBNPHxMEp1cAU9UA7NLPHUNj3zRotSYUTWikPxE2tTd78eldqJ3RFc8e2
        RQ63rENfR5xZe+XOudUPameql7pHP90qq+UYJr4i46Da69k5xz5l/2t5G3jO/oOsvfiHjskL
        Kv7qJ03g29z69pKkg439pgP7+ioybDdNW9Cp/bfMSFfRd8MidbbyNdOrqk+cUQlwzDB8d4vb
        lS39gfrBJl9JtofnlO51TPkY8nOW4ME+fd3i1Nerij9KVb+08dnheOVym0veT467svpMvWx5
        XlvuL9oc/Tb1lWen36Rdm7nmz9UqcNmkwLip88kPvcsR84siHvH2/WZjemm/bomEVmCFYGKv
        lXfTXdFa9ZKLSgb/VCYaT2/d5avEUpyRaKjFXFScCAAG7hpFYwMAAA==
X-CMS-MailID: 20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094804eucas1p1feea4b1bdae819f4c8750994ddd94803@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define bdev_is_zoned(), bdev_zone_sectors() and bdev_get_queue() earlier
in the blkdev.h include file.

This commit has no functional change, and it is a prep patch for allowing
zoned devices with non-power-of-2 zone sizes in the block layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab82d1ff0cce..22f97427b60b 100644
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
@@ -666,6 +671,25 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
+static inline bool bdev_is_zoned(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return blk_queue_is_zoned(q);
+
+	return false;
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
@@ -892,11 +916,6 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags);
 int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 			unsigned int flags);
 
-static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-{
-	return bdev->bd_queue;	/* this is never NULL */
-}
-
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
 const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
 
@@ -1296,25 +1315,6 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
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

