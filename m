Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BDC595D11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiHPNQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiHPNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169E1606B1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:53 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131552euoutp01ad0894ec65a30de181563ce40edafe11~L1ZvGMqrL0139901399euoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131552euoutp01ad0894ec65a30de181563ce40edafe11~L1ZvGMqrL0139901399euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655752;
        bh=ZgoaFDwLzDUOxKE5rEa1NqlfNa53+tMH9mlTVfvbwSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6CWcXzf4VhCBb1ep6HnQQBy4onEEBfOlxNcfu1PpH8wlBzY6gBIwMhG1ZqCHnSaO
         xPm7W6vFwFD2yCCZkw9zgpdhQflhYGKhR/h4XcD8vdjoFaqk+YIYN6lyNjdLwZl+fP
         N1Y+K2gRpHbda8p3qKe726B7NahxJ898I0mxgLEk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131550eucas1p1d3561ab84d8887214456758aca5634b1~L1Ztdo4fF0141901419eucas1p1Y;
        Tue, 16 Aug 2022 13:15:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.75.09580.6889BF26; Tue, 16
        Aug 2022 14:15:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131550eucas1p2d13098e9f0ed146ed1d01dc4dd984820~L1ZtFFlZx0994909949eucas1p2b;
        Tue, 16 Aug 2022 13:15:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131550eusmtrp1acf217c5bc9f2b00b0e437c738c2547c~L1ZtEAb6N0519705197eusmtrp1K;
        Tue, 16 Aug 2022 13:15:50 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-fb-62fb9886a3d5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.B0.09095.6889BF26; Tue, 16
        Aug 2022 14:15:50 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131550eusmtip1176fce6aa3539b535662242fc445cd4c~L1Zs0h-n42991329913eusmtip1c;
        Tue, 16 Aug 2022 13:15:50 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 12/13] dm: introduce DM_EMULATED_ZONES target type
Date:   Tue, 16 Aug 2022 15:15:35 +0200
Message-Id: <20220816131536.189406-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7ptM34nGfzbb2Cx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGU0LRQpaBCr
        uDR3G1MD426hLkYODgkBE4n1axO6GLk4hARWMEqsn7yaHcL5wijR93EyE4TzmVGi+cIHti5G
        TrCOi4tnsUIkljNKbD/RxQLhvGCUePB0IiPIXDYBLYnGTnaQBhGBdIkpLS/BapgFtjFJvLk0
        gREkISzgJtHeMB+siEVAVWLet16wDbwC1hITTzcxQ2yTl5h56TtYDSdQ/F/DKhaIGkGJkzOf
        gNnMQDXNW2czgyyQEFjPKfFq+k9WiGYXieUHtrBA2MISr45vYYewZSROT+6BildLPL3xG6q5
        hVGif+d6NkjIWEv0nckBMZkFNCXW79KHKHeU+PT2KQtEBZ/EjbeCECfwSUzaNp0ZIswr0dEm
        BFGtJLHz5xOopRISl5vmQC31kNh5aCPbBEbFWUiemYXkmVkIexcwMq9iFE8tLc5NTy02zkst
        1ytOzC0uzUvXS87P3cQITIKn/x3/uoNxxauPeocYmTgYDzFKcDArifAKvviRJMSbklhZlVqU
        H19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoGpNvJeWKZEi3eC6RK/fatK
        5Er6rLcvFe1ZsMDrqBRH6lSrGRNrdyZm//njc32BylLFnX6XtFJfedwRl1/9TG32U+/zh5Yv
        rarZx9iwee7V7wdPsWZ99fa4xM/hqs4uxb54pW/iUR8Hs4ecM87/bf67rkVpiUJ94GrrLzkx
        C3WkZBQ4RJz/n5nFcZaj46tY3iWHI3/ORxzZ1/WCu7ZNjivsesDtLqsFSR2rr731t+lZeuCf
        0fSiL/uMTRuS7n9evefts7zUr9FdnR0ah7lFvpaZvNpdeD70YUJ1Q1BU4f21wYlXXNomJ+qo
        GX9hr2Io95wio8o4J+CJKqOuz/oFe30l/klm//51N7/xZ2vH+fNKLMUZiYZazEXFiQDpKH8t
        8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7ptM34nGXz5K26x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GU0LRQpaBCruDR3G1MD426hLkZODgkBE4mL
        i2exdjFycQgJLGWU+NlxmhUiISFxe2ETI4QtLPHnWhcbRNEzRomumdeBHA4ONgEticZOdpAa
        EYFciUXLOsAGMQscYZJYMH05M0hCWMBNor1hPlgRi4CqxLxvvWwgNq+AtcTE003MEAvkJWZe
        +g5WwwkU/9ewigXEFhKwkmg7dpkZol5Q4uTMJ2BxZqD65q2zmScwCsxCkpqFJLWAkWkVo0hq
        aXFuem6xoV5xYm5xaV66XnJ+7iZGYMRuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIr+OJHkhBv
        SmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnA1NGXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpi
        SWp2ampBahFMHxMHp1QD09Zqo9NfBbK+Ogoc33Sd1ad3KYeo8HJRzZVbSph0Jov/8eTd71Ew
        YfuFle37Tv4TvvghPP+jQcdSTqsF65KW7JgWsJ7NL6j89/p/RnN9FDje/BM8r1Xu052x/uHa
        Zz1HNJZE1bN+Z81oil410/hl5Y2/u5d+v7Df0y7y1nrXL4fnr7WUfdmnLbB52TFBp1lJpoo7
        WF709uy5tqw+b82kYOVHM5/VPjr84PBUxYucO04LLnzPLzw15dIZoZItNQsvPrO6l5ByXP15
        7DMVz+DJgmH8rP2+U7Zl8z8z9at/V7rfYf2eG9aM6ku05xfoRm5YacjNu33/JAf+3paT8lem
        NTtu+urceJc/SmXuttKl08qVWIozEg21mIuKEwEcj+o+YQMAAA==
X-CMS-MailID: 20220816131550eucas1p2d13098e9f0ed146ed1d01dc4dd984820
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131550eucas1p2d13098e9f0ed146ed1d01dc4dd984820
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131550eucas1p2d13098e9f0ed146ed1d01dc4dd984820
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131550eucas1p2d13098e9f0ed146ed1d01dc4dd984820@eucas1p2.samsung.com>
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

