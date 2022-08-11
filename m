Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF2058FE60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiHKOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiHKObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:31:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B36C127
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:31:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143059euoutp02f16c7f309f6e85cd53861776d10397e2~KUM5bhcR81916719167euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220811143059euoutp02f16c7f309f6e85cd53861776d10397e2~KUM5bhcR81916719167euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228259;
        bh=ZgoaFDwLzDUOxKE5rEa1NqlfNa53+tMH9mlTVfvbwSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWoF1bMy6CKpts2llSxoX8miVOk3ZZmJgmPvPlQoZxbsGowDjhWrLMxPyG7ihx85n
         pYT+dQOezPbwT0z+jfoykl4/6mK8lWnfNb0DOM6HV36IQNabKJxGWehx/7/qy/+Y3G
         UFk2DGX+xo4d+snDV7nXVIXfH0vhD1lxOEv9foVc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220811143058eucas1p17dcf2b8581d292ab7fe10362a23a4ae1~KUM34Vt8V1645216452eucas1p1X;
        Thu, 11 Aug 2022 14:30:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.3A.09664.2A215F26; Thu, 11
        Aug 2022 15:30:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143057eucas1p1210aba036ebd96d290d74bfe0231299c~KUM3fVZDf2154221542eucas1p1E;
        Thu, 11 Aug 2022 14:30:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143057eusmtrp2433e006f90ec6fae8023f2db37972a14~KUM3ek6H_0786307863eusmtrp2A;
        Thu, 11 Aug 2022 14:30:57 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-0e-62f512a2c3d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.9F.09095.1A215F26; Thu, 11
        Aug 2022 15:30:57 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143057eusmtip13d5e96b5dd5157117d672e5efbd7ce57~KUM3LYK1X3243132431eusmtip1G;
        Thu, 11 Aug 2022 14:30:57 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 12/13] dm: introduce DM_EMULATED_ZONES target type
Date:   Thu, 11 Aug 2022 16:30:42 +0200
Message-Id: <20220811143043.126029-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87qLhL4mGZzt47BYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDKaFooUNIhV
        XJq7jamBcbdQFyMHh4SAicTG3zxdjFwcQgIrGCWe7TvBDOF8YZTYOHktlPOZUWL/sv9MXYyc
        YB0zbu1kgkgsZ5Q4dvMTK4TzglFi0t0vbCBz2QS0JBo72UEaRATSJdYvWM4CYjMLbGOS2PJA
        GMQWFnCTuHWjjxXEZhFQlbi25ymYzStgLbFm5kyoZfISMy99B5vDCRSfsOgiE0SNoMTJmU+g
        ZspLNG+dDXaphMBqTolbv/qgml0kjvw7ywphC0u8Or6FHcKWkfi/cz5UTbXE0xu/oZpbGCX6
        d65ngwSMtUTfmRwQk1lAU2L9Ln2IckeJwz++M0NU8EnceCsIcQKfxKRt06HCvBIdbUIQ1UoS
        O38+gVoqIXG5aQ4LhO0hsf38E/YJjIqzkDwzC8kzsxD2LmBkXsUonlpanJueWmyYl1quV5yY
        W1yal66XnJ+7iRGYAk//O/5pB+PcVx/1DjEycTAeYpTgYFYS4S1b9DlJiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA9OEzanz14sduH7li5QlP4OMwFvn
        CM9qC04el9WmMeY5e6P4Ar/qtkTW75USZT5x6c6ppubLprcvGL89tvFTjOf2y0tOqmr3/1ew
        z9p33eTF+oTkk5yRQem/A9R2/NlfmvGtVVj59bQzp7oNXzwPSj4Y8ToqXGjdiTtbYxMWya5/
        evYVp7GscgR7yZ7Y6mXbfjOHVPZN28E0LSVcc69aVOGv5Cma0eF+jGkqfx4q+028d7JkciPj
        y5mP79T9nTsvtW/rw1c6zte2ZMtHH7JhmHOo5uy7AxLv9eo5Y6tPpOnl3yyRfHxwz4yfHx/X
        NbGmrt5imeM1Z7LBdGE7UZ+1vWcyBJ7cWpUaKLBnzWQeDxklluKMREMt5qLiRAA31r0p8AMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7oLhb4mGUydo22x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0LRQpaBCruDR3G1MD426hLkZODgkBE4kZ
        t3YygdhCAksZJdaf4oWIS0jcXtjECGELS/y51sXWxcgFVPOMUWLugrPsXYwcHGwCWhKNnWCm
        iECuxMEjgSAlzAJHmCSa3+5iAekVFnCTuHWjjxXEZhFQlbi25ymYzStgLbFm5kwmiPnyEjMv
        fWcHsTmB4hMWXYS6x0piQscxdoh6QYmTM5+AzWQGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW
        56bnFhvqFSfmFpfmpesl5+duYgRG67ZjPzfvYJz36qPeIUYmDsZDjBIczEoivGWLPicJ8aYk
        VlalFuXHF5XmpBYfYjQFunsis5Rocj4wXeSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5ak
        ZqemFqQWwfQxcXBKNTDt/f1G3zn6R95p5Zh6lW/Ne6M49XQ+2x+S9A//eDl7dWuL6EuNiICV
        tr+KddSecXzgddPj2PhtcYjGz3b9+U3VsR4X7i8S8zuzQvrO7rrd7NUH2bcwPty1/ua2datm
        LjIyt3R663OjLjxAnWsG5/Et7o+f3f44wVk1/tty0fnZ/POv8SwMvpE25c0ln2PPQld7Tfm0
        8L6bvvbqtesNb/F7n555zPCcg0Bo1X/13gjpN2Hifmu0r5a+Z9x8+kfYpV3t9bw/Dl9+w/5I
        eMnWPypXKtYrFa5+o1nBMreqMcvyOF/5pv1zYtnvM53fZy251e/VPjvZV4+OZ/6U/XyK6fK7
        y/Ib2I1zU6fYVU75mKv6S4mlOCPRUIu5qDgRAIqwiJhfAwAA
X-CMS-MailID: 20220811143057eucas1p1210aba036ebd96d290d74bfe0231299c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143057eucas1p1210aba036ebd96d290d74bfe0231299c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143057eucas1p1210aba036ebd96d290d74bfe0231299c
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143057eucas1p1210aba036ebd96d290d74bfe0231299c@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

