Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9523595CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiHPNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiHPNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:45 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7B5AC48
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:43 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131541euoutp0111420936160f2d1395a97fe7309946af~L1ZkWg3BK2881628816euoutp01f
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131541euoutp0111420936160f2d1395a97fe7309946af~L1ZkWg3BK2881628816euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655741;
        bh=AD8v/RK3vFIqsgabYiTtVZbPbcAOQ4zUOz/AmbfbvbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYyKZA123aDKiTjZZO+uI37rOfEKyULct3Zl6s9XnlhQlb3/lN5lcEhAER3/roNBg
         fMiTKMZAynq6Xf2XhVsDLtZ6+V5xXwWOJeYuEebr0KvGiJU9lKC8gSu3Cn3T5lerjQ
         v6kKmqoyYG/knT+dY62H1nd2dOukeH0b3660ZwI0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816131539eucas1p26d86a5a1304108a25edff82219a984be~L1ZiaG4wu1906819068eucas1p2w;
        Tue, 16 Aug 2022 13:15:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5F.93.09664.A789BF26; Tue, 16
        Aug 2022 14:15:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131538eucas1p173e1c91bada451ae8a37d5b4ba3550b0~L1Zh8-0O_0140201402eucas1p1T;
        Tue, 16 Aug 2022 13:15:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131538eusmtrp1dfb31e16cfbde621e18d525b910130f4~L1Zh8CkPw0149801498eusmtrp19;
        Tue, 16 Aug 2022 13:15:38 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-ff-62fb987ae852
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.A0.09095.A789BF26; Tue, 16
        Aug 2022 14:15:38 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131538eusmtip2f55ebca3bea1379ed12c7563f930fe9d~L1ZhpwYZX1242312423eusmtip2t;
        Tue, 16 Aug 2022 13:15:38 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: [PATCH v11 01/13] block: make bdev_nr_zones and disk_zone_no
 generic for npo2 zone size
Date:   Tue, 16 Aug 2022 15:15:24 +0200
Message-Id: <20220816131536.189406-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djPc7pVM34nGdzYb24x/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF5
        1xw2i/nLnrJbTGj7ymxxY8JTRovPS1vYLdbcfMpiceKWtIOwx+Ur3h47Z91l97h8ttRj06pO
        No/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1bVjF6bD5d7fF5k5xH+4FupgCeKC6blNSczLLUIn27
        BK6Mv1PbmQquilQ8m/CKrYFxlmAXIyeHhICJxJwXL5m6GLk4hARWMErMvXOcDcL5wiixf/5h
        FgjnM6PEusOLWWBabj/8wwqRWM4oMWfmGqiWF4wS8z9+BnI4ONgEtCQaO9lBGkQE0iWmtLwE
        m8Qs0MUscffmcbCEsECSxNsbB5lBbBYBVYmFHUvZQXp5Bawk2ve5QiyTl5h56TtYOaeAtcS/
        hlVgR/AKCEqcnPkEzGYGqmneOpsZZL6EwG5OiQ2XJjBCNLtIrLl9nQnCFpZ4dXwLO4QtI3F6
        cg/UN9UST2/8hmpuYZTo37ke7AEJoG19Z3JATGYBTYn1u/Qhyh0luvYtYoGo4JO48VYQ4gQ+
        iUnbpjNDhHklOtqEIKqVJHb+fAK1VELictMcqKUeEtsf3GKZwKg4C8kzs5A8Mwth7wJG5lWM
        4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBifH0v+OfdjDOffVR7xAjEwfjIUYJDmYlEV7B
        Fz+ShHhTEiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAxvDvy
        ++3RF/qTpAwfcXx6pFvllSqypsew6Z5shsx81VBnzqdr3PjbFy68fHPFpmf+c7QPvq0p2fPk
        VlWNT1NB50yp780nXqm81M3o19n23WaJ7+/m6DX6fybrzC9qmfdoQyPPyoPzGx/Y2LR1Z9/m
        fLfsivWkKKNtLb8uM2qZ5F4N5NVczNhzJ8zCVcnHsfP4tH8q0b7MCVLvtVRUzOoW35iw/4uR
        Uej5jScsve5/WRGQWreaJ1A2Vi48rcfwLPPDqDfLZvG9k/58niN+gtFmjxXln1SruWLlSqsq
        zx5uYNBX4M6KU/6d+bpffLdYyRqxlIb5F3esXu8uHjFhuRvzb0HDKVPswp6EXgupfaTEUpyR
        aKjFXFScCABAPECt+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7pVM34nGez7L2ox/bCixfpTx5gt
        Vt/tZ7OY9uEns8Xvs+eZLfa+m81qcfPATiaLPYsmMVmsXH2UyeLJ+lnMFn+77jFZ7L2lbXF5
        1xw2i/nLnrJbTGj7ymxxY8JTRovPS1vYLdbcfMpiceKWtIOwx+Ur3h47Z91l97h8ttRj06pO
        No/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1bVjF6bD5d7fF5k5xH+4FupgCeKD2bovzSklSFjPzi
        ElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mv1PbmQquilQ8m/CKrYFx
        lmAXIyeHhICJxO2Hf1i7GLk4hASWMkrsvHCGDSIhIXF7YRMjhC0s8edaFxtE0TNGifsPmli6
        GDk42AS0JBo72UFqRARyJRYt6wAbxCwwi1ni3LdJYIOEBRIk7u1aBmazCKhKLOxYyg7Syytg
        JdG+zxVivrzEzEvfweZwClhL/GtYxQJiCwGVtB27zAxi8woISpyc+QQszgxU37x1NvMERoFZ
        SFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzhbcd+bt7BOO/VR71DjEwcjIcY
        JTiYlUR4BV/8SBLiTUmsrEotyo8vKs1JLT7EaAp09kRmKdHkfGASySuJNzQzMDU0MbM0MLU0
        M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDKVOCt+IvKjxbubL7tXMXBf3RXzKXORndlD
        +YCfRWW/X3v7BbO83/OXwSKtU+tG19asLIc9LBN+76lLeCDqtX+JVbBs+3z+JW0fbJfo1e+M
        mnTA+Cn/2d3R999KmFl9s3Hg0D3RJXvv8isZ/c86fL0yy7PW2QRsmzDHuFNu1q0zjzcq5y7R
        EdkgpiB79utSh/huy6UN6iu8tX/Wtf8JfNx3cu/tHUFOGu+mWsewBbDo/0jrDly69O7K9suv
        3T4WBtQuMHghzMS94SvvlUb1itQTbx74FscISHNfLctcZbZOiL8/9XpIx1YLu/jzVV8TMoL0
        tgdqPawzlV7z2/HI3cgYtyi1h7o7A165L7lVqcRSnJFoqMVcVJwIALROnPtqAwAA
X-CMS-MailID: 20220816131538eucas1p173e1c91bada451ae8a37d5b4ba3550b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131538eucas1p173e1c91bada451ae8a37d5b4ba3550b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131538eucas1p173e1c91bada451ae8a37d5b4ba3550b0
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131538eucas1p173e1c91bada451ae8a37d5b4ba3550b0@eucas1p1.samsung.com>
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

