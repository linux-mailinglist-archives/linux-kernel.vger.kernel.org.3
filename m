Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4075889C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiHCJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiHCJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201226553
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094811euoutp01fc444d8524f86f982b9fdf5cb594d2aa~HzLsLjDpB3139831398euoutp01I
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094811euoutp01fc444d8524f86f982b9fdf5cb594d2aa~HzLsLjDpB3139831398euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520091;
        bh=bYKKaKRKmRv+AlsOpjlNiS5TmS3H8P6AuWd0B5dlWjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOZLqQmzYe7WXI82OHiGlc7RJe5IHjymyK3wn8D3iGcG5cnIqUjv5b78xCMQvv/Nm
         h36tugyo3QJj2lbQLo+6Tocv4a+J+4J/4R/1nWmbIFzgKJxPTU9PhorTRStgYeg8Bs
         lPrugj9UC/lb3rwrIslye3U58C0D69ELXKeR/e14=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220803094809eucas1p19bd8547e3fcb23e3f951c4f85f06f852~HzLqgfac10754107541eucas1p1_;
        Wed,  3 Aug 2022 09:48:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7D.F5.10067.9544AE26; Wed,  3
        Aug 2022 10:48:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220803094809eucas1p1e24ddc3076eaa05db0658b88fd34ffd4~HzLqABfkC1902519025eucas1p1K;
        Wed,  3 Aug 2022 09:48:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220803094809eusmtrp261e43580a71933c10a45bfb080762358~HzLp_Bq0z0985609856eusmtrp2w;
        Wed,  3 Aug 2022 09:48:09 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-46-62ea4459ad8a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.DB.09095.8544AE26; Wed,  3
        Aug 2022 10:48:08 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094808eusmtip11dc1bc750fcb0c384f4ce3c02685227a~HzLppsgZ-2551225512eusmtip1f;
        Wed,  3 Aug 2022 09:48:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v9 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Wed,  3 Aug 2022 11:47:54 +0200
Message-Id: <20220803094801.177490-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87qRLq+SDI4sVLBYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlbFs
        XTt7wWXpit8XPjA2MG4U72Lk5JAQMJG49X0DaxcjF4eQwApGie4v39khnC+MEhv2b2KCcD4z
        SuxetIwNpqX76UmoluWMEi9Ow1S9ZJQ4/mg5UD8HB5uAlkRjJ9goEYFmRom7f3vAOpgFDjBJ
        3NxyiwlklLBAhMS6xzNZQWwWAVWJqcvusYA08wpYSTzqsobYJi8x8xLITZwcnALWElP+/WMG
        sXkFBCVOznzCAmIzA9U0b53NDDJfQmA3p0TDrJNQp7pIbLw+nR3CFpZ4dXwLlC0j8X/nfCYI
        u1ri6Y3fUM0tjBL9O9ezgRwhAbSt70wOiMksoCmxfpc+RLmjxPrHu6Eq+CRuvBWEOIFPYtK2
        6cwQYV6JjjYhiGoliZ0/n0AtlZC43DSHBcL2kFjQ0802gVFxFpJnZiF5ZhbC3gWMzKsYxVNL
        i3PTU4uN8lLL9YoTc4tL89L1kvNzNzECU+Lpf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrx3XJ4n
        CfGmJFZWpRblxxeV5qQWH2KU5mBREudNztyQKCSQnliSmp2aWpBaBJNl4uCUamCqO3x0b535
        stclDxaHaB9iZd2w3fDN1EVP3ixV2KeRniebXrHrVhvHtR2xzT6PtTf9XLJef16B6dLLPmJb
        D/+IqGXbPN+lL8hX4Ydfljh3a0K+6sffHBd2vA79onjldfI/j53PbFv2im73UzZ7JL8w4/hr
        p7YJlZOfrivetET5l8iZ+E8iT8PmPHA2W+3v8XpbEoNWcmj4j4WrNpwsuGNRcq+TLztPxP+q
        yqOaj7/UJhtvXzn70ZXrC5aban2TO6pwRJi/RXCr/b/2uxV+aRYPp13cc3ERw8cvTnGp3iyt
        qnxLLuu9PbJ9pkNtEs8bkQrZ68vW/p04z1Xv8S3BosD4tGiG5E4Xc676NTM7XVzjlViKMxIN
        tZiLihMBwpB7+fgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7oRLq+SDN48srZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBOlZ1OUX1qSqpCRX1xiqxRt
        aGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7FsXTt7wWXpit8XPjA2MG4U72Lk
        5JAQMJHofnqSFcQWEljKKPF3tgdEXELi9sImRghbWOLPtS62LkYuoJrnjBJHZzWydzFycLAJ
        aEk0drKDxEUEuhklLp85xwriMAucY5KY8/QBG0i3sECYRPOv9WA2i4CqxNRl91hAmnkFrCQe
        dVlDLJCXmHnpOzuIzSlgLTHl3z9miIOsJNb9nQV2HK+AoMTJmU9YQGxmoPrmrbOZJzAKzEKS
        moUktYCRaRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg7G479nPzDsZ5rz7qHWJk4mA8xCjB
        wawkwnvH5XmSEG9KYmVValF+fFFpTmrxIUZToLMnMkuJJucDk0deSbyhmYGpoYmZpYGppZmx
        kjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT0eYNAr1HLuSxVIg+7T4eo3fV3NLx1UHrOV57
        bmzkv67jEBZ/ZFHv4n1PSg7qvxbiWO1XvG5ykpndnhMSM0q6lh0tLW5VOv2m9Lu+TvW/HXfy
        dHWy+FKCFy8/Wfdp/mGf4xyNJ08sWX1NkEtG+qOib+QV27+sh02t+LKeGq/ZHP2uRl9+bu0e
        jSuCL7Y89bd5mPNHbVbZG62Ytx/+Kz48Udy2dNW9dhXPMOtS9cRfOyRdZz8IXDRFovxUdeva
        t8sWMzo/fLv+44cqz16WYr519x46vg21q3xi/v4y47bulTacX/JvNO20u6H8Vez0Ep5oQ0cP
        nfaO1q6fjzzEgi+uDecvfHlw7QWVA/V1hgI1SizFGYmGWsxFxYkAB/+Yf2YDAAA=
X-CMS-MailID: 20220803094809eucas1p1e24ddc3076eaa05db0658b88fd34ffd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094809eucas1p1e24ddc3076eaa05db0658b88fd34ffd4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094809eucas1p1e24ddc3076eaa05db0658b88fd34ffd4
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094809eucas1p1e24ddc3076eaa05db0658b88fd34ffd4@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the power-of-2(po2) based calculation with zone size to be generic
in null_zone_no with optimization for po2 based zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for po2 based zone sizes as
this function is called only during the initialization and will not be
invoked in the hot path.

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
index c451c477978f..f1e0605dee94 100644
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

