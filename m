Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9909659E6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiHWQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244503AbiHWQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:16:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B3B2CC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:37:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121916euoutp021d15475f80e8f8850fa6bff8efdba494~N_JUC4xgR2228922289euoutp02J
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121916euoutp021d15475f80e8f8850fa6bff8efdba494~N_JUC4xgR2228922289euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257156;
        bh=ZgoaFDwLzDUOxKE5rEa1NqlfNa53+tMH9mlTVfvbwSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILeXtx5SOEIUVVyTJ6NEoEyCU07OfNQ+qbpeoibZ99bX0VDdCEKc6LYImgLi7o51o
         a/guuiM/oYJj07xL3YKEwTbC1qeU5R3jXtwZuW86NECfXEGSweZnejL7DJHPERQJln
         vqHieqDk6t509Y2CZbYfwwiiNHWgdN/jIICUMMRg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121914eucas1p2b272b58f52732f8a017ae5ee989828c0~N_JSUpOAa2019720197eucas1p20;
        Tue, 23 Aug 2022 12:19:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.92.29727.2C5C4036; Tue, 23
        Aug 2022 13:19:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b~N_JR47K-S2414724147eucas1p2Z;
        Tue, 23 Aug 2022 12:19:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121914eusmtrp2d0acb2e5be4246137d66d4842c4d5bef~N_JR4CQoA2723427234eusmtrp2u;
        Tue, 23 Aug 2022 12:19:14 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-a2-6304c5c27dad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.12.07473.2C5C4036; Tue, 23
        Aug 2022 13:19:14 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121913eusmtip1d3149f2100c5b272d65462700b955ce7~N_JRkSCzx0463404634eusmtip1Z;
        Tue, 23 Aug 2022 12:19:13 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Date:   Tue, 23 Aug 2022 14:18:58 +0200
Message-Id: <20220823121859.163903-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87qHjrIkGxzvVLRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDKaFooUNIhV
        XJq7jamBcbdQFyMnh4SAicTDY3fYuhi5OIQEVjBK/NnwjgXC+cIo0dG9nRXC+cwo0XS5CaiM
        A6xl6vwEkG4hgeWMEruWhkDUvGCUuLTiKzNIDZuAlkRjJztIjYhAusTXrxsYQWqYBbYxSfy6
        e4kFJCEs4Cbx88MxJpB6FgFViYZ2G5Awr4C1xNNfS9ghrpOXmHnpO5jNCRSft/QUI0SNoMTJ
        mU/AxjAD1TRvnc0MMl9CYD2nxJJZ05gg7nSRmLImB2KOsMSr41ugZspI/N85nwnCrpZ4euM3
        VG8Lo0T/zvVQP1pL9J3JATGZBTQl1u/Shyh3lLj5djs7RAWfxI23ghAX8ElM2jadGSLMK9HR
        Bg1aJYmdP59ALZWQuNw0hwXC9pB4tOkS2wRGxVlIfpmF5JdZCHsXMDKvYhRPLS3OTU8tNsxL
        LdcrTswtLs1L10vOz93ECEx/p/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwVl9kSBbiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXA5HOrQkNpjpfWYccYmzjP
        1xw7551ni63x3vN/7+Qwt9mSl5p/XypoWujG8ll65oUDQmrhaf9WHWNXaMl68Z3tt/yxlTV3
        JZ5ExO+Vfh5S2f3v7cON//nepN24vcbj7wLTFXpPe1P7W9yVJt3W+/B4zqTbyrYHn09h2Ln6
        dXL7m1jdr/uaG9nFmRYX9LLvUGKIPdW8c4ZY9IKOHcllsYb6U8RNT89uY7z1bX1iRsPPs72m
        FuX6VW3pHPN0NbIFvuyW6fv1vIph7nsPc08r59PzI9TjLujXMjjy7rScrazNJfxn8ReBuOmf
        IibNsengOLuec4fYoYyeRtl5BfPFv2y0FZtlajP5qXXmXEn58AlvlViKMxINtZiLihMB5psD
        w+4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7qHjrIkG8w4zWyx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0LRQpaBCruDR3G1MD426hLkYODgkBE4mp
        8xO6GLk4hASWMkq83NzI2sXICRSXkLi9sIkRwhaW+HOtiw2i6BmjRMe1OWwgzWwCWhKNnewg
        NSICuRKHN09gAqlhFjjCJLG6cS3YIGEBN4mfH44xgdSzCKhKNLTbgIR5Bawlnv5awg4xX15i
        5qXvYDYnUHze0lNge4UErCTm3/rEBlEvKHFy5hMWEJsZqL5562zmCYwCs5CkZiFJLWBkWsUo
        klpanJueW2yoV5yYW1yal66XnJ+7iREYrduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8FZfZEgW
        4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5HxgusgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamBqk9t88cvijl/2Uux3ljBJvdzjwde0bXJckSyv3Bs5xYe+G8tE
        T7QX7/T1Pqz1uVJ+z06PF79vm5S0qG+YaDJ3RqzD8pUvZj553dLCdHD37ql7wjea1b18pza3
        2tq05LBk8Ovw+DSHL5UN+1ZPflvdP+PcjO0H3Jyd7VJ/72B7lhajeUSxeWLuVbMT2cW2qXMK
        Dy/cmsxjcnNes+U8vbIlC/6nBL9QWXV40zznLQ67NHZtWM+8dEZLeZ+7+LxH3y3sF1sLmfwT
        2rhM6BBfbsh533NGcTmqDl/WrPrppL/ZVOnuvSvXV3l6l9++xW9vdffsy1QFLvWy5y+35e1b
        0vt8+ZrAC/wOz4KuzmUXnXf2uBJLcUaioRZzUXEiAOExlkxfAwAA
X-CMS-MailID: 20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
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

Introduce a new target type DM_EMULATED_ZONES for targets with
a different number of sectors per zone (aka zone size) than the underlying
device zone size.

This target type is introduced as the existing zoned targets assume
that the target and the underlying device have the same zone size.
The new target: dm-po2zone will use this new target
type as it emulates the zone boundary that is different from the
underlying zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

