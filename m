Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB715889CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiHCJtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiHCJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4A58B7C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094817euoutp0155f89085f454c1b1e3956d460c8769ff~HzLx49B5g0037100371euoutp01C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094817euoutp0155f89085f454c1b1e3956d460c8769ff~HzLx49B5g0037100371euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520097;
        bh=aEZ9MVfXnixWs6H2frFA0ZxvwrL43KBWv8pJqvNry+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX6hi0cjpqpAsjLjSUz4UsZqYJ6G4DfLvJPSV+1Qb2wBrnvxwxA6i0h9cYlItEXxv
         wPUV++0qXayyvUzuP+dloHz4HAA7e77pGbChcycHUpaPn0jP6LWW7KsCudmSY8iOaq
         b0OehLT19PH51gu4SAT20h0eUc0U82UjuvBHi3E0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220803094815eucas1p1bd55c673d1b14f80f9ba075b862f4c30~HzLwNksfA3109731097eucas1p1c;
        Wed,  3 Aug 2022 09:48:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2D.06.10067.F544AE26; Wed,  3
        Aug 2022 10:48:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d~HzLvvi38C1528815288eucas1p2r;
        Wed,  3 Aug 2022 09:48:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803094815eusmtrp12a4dd3bd318933996e4c815d9bdf1bd0~HzLvuqSpX2000320003eusmtrp1o;
        Wed,  3 Aug 2022 09:48:15 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-69-62ea445fd98a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EE.9B.09038.F544AE26; Wed,  3
        Aug 2022 10:48:15 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094814eusmtip145d6ac2a5c84936e935c88f18387aeec~HzLvY-4Yi2555925559eusmtip1m;
        Wed,  3 Aug 2022 09:48:14 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 12/13] dm: introduce DM_EMULATED_ZONES target type
Date:   Wed,  3 Aug 2022 11:48:00 +0200
Message-Id: <20220803094801.177490-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87rxLq+SDD7f0LRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDK+vV7LUnBM
        tOLWkQOsDYztQl2MHBwSAiYSt/7ldzFycQgJrGCU2PvvGjOE84VR4siDbWwQzmdGibnXVrHB
        dOxdEQARX84o8eHuRFYI5yWjxMZF18CK2AS0JBo72UHiIgLNjBJ3//aAFTELzGCS6PjYx9LF
        yMkhLOAqsb/pJDuIzSKgKvH+1Ccwm1fAWuLU2ctgNRIC8hIzL30Hi3MCxaf8+8cMUSMocXLm
        E7AaZqCa5q2zwe6WENjMKfHo52ZmiGYXiaNL1zJB2MISr45vYYewZSROT+6BWlAt8fTGb6jm
        FkaJ/p3rof60lug7kwNiMgtoSqzfpQ9R7ijRN6WLBaKCT+LGW0GIE/gkJm2bzgwR5pXoaBOC
        qFaS2PnzCdRSCYnLTXOglnpIfNj4jGUCo+IsJM/MQvLMLIS9CxiZVzGKp5YW56anFhvlpZbr
        FSfmFpfmpesl5+duYgSmwdP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeO+4PE8S4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwJThfUD9Rm/su6gpiyIzA/i9
        N1ntisj553Rrsf9n7VVqn2xXy6pqyEguVDkjXMD9nT/QJv7pxI18e8Q28JTJlWvZa4ptmRrT
        8vn15DbjxMqwhabWNVVLrBenmffLaN06f4hZ7sbsqNjX4ZrZh23mh1jt0ZwfubBVipPFxsrz
        mt5jp/SO3R1mmh4aKu3sRhyKT1KZp02Zmdd2++RdvT+VLMJnm73uLN0soGa81VkupY99vqP+
        gjkXnVoinjFqunAJTPbtdVk47cLb0K/Tl5vIPn6poWDOoGm8g6lz7d1MbzGTi/aRVXOU2Pva
        RZVur/pc0HDzGB9XgERN5nNupsPzFj9Qe+jzP1/B/VB+4VElluKMREMt5qLiRAAwZMLo8gMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7rxLq+SDHae5rRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK+vV7LUnBMtOLWkQOsDYztQl2MHBwSAiYS
        e1cEdDFycQgJLGWUOHFrOVMXIydQXELi9sImRghbWOLPtS42iKLnjBLzjz1nAmlmE9CSaOxk
        B4mLCHQzSlw+c44VxGEWWMYk0fTlOhtIt7CAq8T+ppPsIDaLgKrE+1OfwGxeAWuJU2cvs0Bs
        kJeYeek7WJwTKD7l3z9mEFtIwEpi3d9ZrBD1ghInZz4Bq2cGqm/eOpt5AqPALCSpWUhSCxiZ
        VjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG7LZjP7fsYFz56qPeIUYmDsZDjBIczEoivHdc
        nicJ8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4waeSVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTBZ6veHz7ZQivwh/ePr8sgFG3t2urb8Wnv7C19oqKuwfIrM
        q6+zz07fonMspcXWSOyVwiOTnI4n83hcNomu2+mycCqrcf5UMxdWx5Cnq5Vuvsuo3/JDZ1f7
        JEup4Cr2X+Yn303a75/mv6H10RrTfVZRH6ebSM4VNtyvo857a7FLT+odGeEu3tk89SE/PixU
        O3LiVMt/wZeFL6axXNu4iTf+ztfHPOVSe47cbpJdZJlTlsibMvOrTsKJ6c+uWcp5ea7I/pvQ
        YbsstldPYOPF2+3LfjLIrEmZKPpxm8XeOM62fdb3fCZdkTpuuc/qXbBIdqPdihVznyc7vP35
        Xe3R/J2lD9Mjd9i4eVaovF0c+ZtNiaU4I9FQi7moOBEAmzuTD2IDAAA=
X-CMS-MailID: 20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094815eucas1p2dfab477daf4f2eb05342d756fdf7f14d@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new target type DM_EMULATED_ZONES for targets with
a different zone number of sectors than the underlying device zone
number of sectors.

This target type is introduced as the existing zoned targets assume
that the target and the underlying device have the same zone
number of sectors. The new target: dm-po2zone will use this new target
type as it emulates the zone boundary that is different from the
underlying zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c         | 13 ++++++++++---
 include/linux/device-mapper.h |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 31eb1d29d136..b37991ea3ffb 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1614,13 +1614,20 @@ static bool dm_table_supports_zoned_model(struct dm_table *t,
 	return true;
 }
 
-static int device_not_matches_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
+/*
+ * Callback function to check for device zone sector across devices. If the
+ * DM_TARGET_EMULATED_ZONES target feature flag is not set, then the target
+ * should have the same zone sector as the underlying devices.
+ */
+static int check_valid_device_zone_sectors(struct dm_target *ti, struct dm_dev *dev,
 					   sector_t start, sector_t len, void *data)
 {
 	unsigned int *zone_sectors = data;
 
-	if (!bdev_is_zoned(dev->bdev))
+	if (!bdev_is_zoned(dev->bdev) ||
+	    dm_target_supports_emulated_zones(ti->type))
 		return 0;
+
 	return bdev_zone_sectors(dev->bdev) != *zone_sectors;
 }
 
@@ -1645,7 +1652,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 	if (!zone_sectors)
 		return -EINVAL;
 
-	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
+	if (dm_table_any_dev_attr(t, check_valid_device_zone_sectors, &zone_sectors)) {
 		DMERR("%s: zone sectors is not consistent across all zoned devices",
 		      dm_device_name(t->md));
 		return -EINVAL;
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 04c6acf7faaa..83e20de264c9 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -294,6 +294,15 @@ struct target_type {
 #define dm_target_supports_mixed_zoned_model(type) (false)
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
+#define DM_TARGET_EMULATED_ZONES	0x00000400
+#define dm_target_supports_emulated_zones(type) \
+	((type)->features & DM_TARGET_EMULATED_ZONES)
+#else
+#define DM_TARGET_EMULATED_ZONES	0x00000000
+#define dm_target_supports_emulated_zones(type) (false)
+#endif
+
 struct dm_target {
 	struct dm_table *table;
 	struct target_type *type;
-- 
2.25.1

