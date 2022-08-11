Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB658FE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiHKObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiHKOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:55 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E36CD11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143048euoutp01b29950f056d86f49435d448e4089cf7e~KUMuqmh_c2261422614euoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143048euoutp01b29950f056d86f49435d448e4089cf7e~KUMuqmh_c2261422614euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228248;
        bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnL2YnjAOjY9wL4Wt4C64w9KF1nFRqZdaZW/RDnlmzzKZIiBg8J4TFoE+2N8hsPIG
         DQOZaXUJGT6OwD2yA6ljG3xTF1AdF/bEc5qPJ3wD7qNQyKXJeVYAHdOY4+lxJ8AJKF
         HuVER4Y91IZPsdaCukU9YV9lkh8JP5DXOhm2/9Vc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143046eucas1p2aca499e896bb89a154e4a4b1bdf718e2~KUMs082vL1006810068eucas1p2D;
        Thu, 11 Aug 2022 14:30:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.8C.09580.69215F26; Thu, 11
        Aug 2022 15:30:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143045eucas1p2773a7e7bbe9f3667d1105cc1465dac42~KUMsXYqvE2328423284eucas1p2G;
        Thu, 11 Aug 2022 14:30:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143045eusmtrp2a1accb11028d7272eec67818e141c2aa~KUMsWeF4W0786307863eusmtrp2t;
        Thu, 11 Aug 2022 14:30:45 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-a0-62f51296b42f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FB.00.09038.59215F26; Thu, 11
        Aug 2022 15:30:45 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143045eusmtip2ddbb16a5b5589429fc9855578ecfe1d6~KUMsA2dat1262412624eusmtip2w;
        Thu, 11 Aug 2022 14:30:45 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v10 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date:   Thu, 11 Aug 2022 16:30:31 +0200
Message-Id: <20220811143043.126029-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djP87rThL4mGRx8KmAx/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF5
        1xw2i/nLnrJbTGj7ymxxY8JTRovPS1vYLdbcfMpiceKWtIOwx+Ur3h47Z91l97h8ttRj06pO
        No/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1bVjF6bD5d7fF5k5xH+4FupgCeKC6blNSczLLUIn27
        BK6Mv1PbmQquilQ8m/CKrYFxlmAXIyeHhICJRNPrMyxdjFwcQgIrGCXObFzPDuF8YZRo7Z7O
        COF8ZpSYPuUZO0zLjvZFTBCJ5YwSnTcmM0M4Lxglzr/YAlTFwcEmoCXR2AnWICKQLrF+wXKw
        HcwCXcwSj07+ZwZJCAskSUy+fYEFxGYRUJXoeraHFcTmFbCS2Nn9nBVim7zEzEvfwQZxClhL
        TFh0kQmiRlDi5MwnYL3MQDXNW2eDHSEhsJ9T4taew1CnukicP/aGBcIWlnh1fAtUXEbi/875
        TBB2tcTTG7+hmlsYJfp3rmcD+UACaFvfmRwQk1lAU2L9Ln2IckeJ8xv+MkJU8EnceCsIcQKf
        xKRt05khwrwSHW1CENVKEjt/PoFaKiFxuWkO1DEeEi/OLWKewKg4C8kzs5A8Mwth7wJG5lWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBqfH0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd6y
        RZ+ThHhTEiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTBNbVA8
        1+645NPqrYJKLZfUlCJe7D7cNnnb8e9FkSnmjhcsuDIWqMqt9lni0GanvjX2R9vEE19vuLqI
        v7y0WqKtQSVytsK1YxKHWfRd7h76WCveqn9d26nXUK3PXves7NUyu4TIzQd4F7C6WX0Sf6q8
        1Cc+Jl7+c6FxcJur+Is9XdnZe1N/WTo8TFhfovxGg13/wDnJ3yd/5hb77lnBIsO7f86ePVva
        elhVKlZ+OaRtcYExePeyiAM35NmETF+IvT3tumlunV3a5OnN/6sL3jYfNAp+v9qyokib9d7k
        DUkb/mUs3eg/97iXje6sVXGO9Wcd7ncdqJ0mv3ebzPZSR42MnF6mbjXfOTUPj8znmanEUpyR
        aKjFXFScCAB3M5S3/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7pThb4mGXT161hMP6xosf7UMWaL
        1Xf72SymffjJbPH77Hlmi73vZrNa3Dywk8liz6JJTBYrVx9lsniyfhazxd+ue0wWe29pW1ze
        NYfNYv6yp+wWE9q+MlvcmPCU0eLz0hZ2izU3n7JYnLgl7SDscfmKt8fOWXfZPS6fLfXYtKqT
        zWPzknqP3Tcb2Dx2tt5n9Xi/7yqbR9+WVYwem09Xe3zeJOfRfqCbKYAnSs+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j79R2poKrIhXPJrxia2Cc
        JdjFyMkhIWAisaN9EROILSSwlFHib2cxRFxC4vbCJkYIW1jiz7Uuti5GLqCaZ4wSj6++Y+li
        5OBgE9CSaOxkBzFFBHIlDh4JBClhFpjFLHHj4QE2kF5hgQSJ0633mUFsFgFVia5ne1hBbF4B
        K4md3c9ZIebLS8y89J0dxOYUsJaYsOgi1D1WEhM6jrFD1AtKnJz5hAXEZgaqb946m3kCo8As
        JKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbwtmM/t+xgXPnqo94hRiYOxkOM
        EhzMSiK8ZYs+JwnxpiRWVqUW5ccXleakFh9iNAW6eyKzlGhyPjCF5JXEG5oZmBqamFkamFqa
        GSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MO0s39O89Zd3gz+XWZqRQ+At63VSpTM3fVk5
        5S73vGPKOXUZ8ZF7k+yqRd58W/l1VbPOgg18ewNux0ptasgKzfQ2Ot7Hkvvh4DMR67/hN19m
        1Kx7rRTyy2B1wdvt0z3/5nNJH9fZv/Lm90zm2Vc3zVwpPbt0cc05yVeVqnJuLQ5hE6ZMXrTq
        STHLhS9n0kslGStDo+of3Be7WHfs6CXbovqpjSc77u9zUUtSl51z69rk26XLvxTdFXPnTz4h
        td7V4OiVJV+ZGA72rkysPr7nFKsex20ncempbVXKt171a4r6rd88MTF5Zk7hxJoJOl6F+Z/9
        5Z9fm64daeIvIp51e0fjy4n2c6u2i520+iz+7boSS3FGoqEWc1FxIgAWpoobaQMAAA==
X-CMS-MailID: 20220811143045eucas1p2773a7e7bbe9f3667d1105cc1465dac42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143045eucas1p2773a7e7bbe9f3667d1105cc1465dac42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143045eucas1p2773a7e7bbe9f3667d1105cc1465dac42
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143045eucas1p2773a7e7bbe9f3667d1105cc1465dac42@eucas1p2.samsung.com>
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

