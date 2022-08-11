Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F058FE50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiHKObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiHKOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC172EC7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:56 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143053euoutp018418dcd26dbaaaaf32678b5b5d912fe9~KUMzd61yi2261422614euoutp01I
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143053euoutp018418dcd26dbaaaaf32678b5b5d912fe9~KUMzd61yi2261422614euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228253;
        bh=hLglEsgs8ISJExGYQKv645MJDunEKMqaZXVaT8ARNsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOIX5xaTOZ6NelpiBhQrY8C2ZrcsCvPTF4Aoj8mSdsKAgfXEqKBRb0GLs3jAKjat3
         mhSZ+yrdtZDPd7DvC4LAGIYKcQryhkqGkok0+TKfWmfu3JKIZrQvgM5bAFLxXXmvIa
         6hc0YqAcuC5pOwzJqgyDNkqDnubk4lmasVQoFdMk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143051eucas1p22c12a3fad3aa2314c7907177ad872b77~KUMx7BKQL2328523285eucas1p2M;
        Thu, 11 Aug 2022 14:30:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5D.8C.09580.B9215F26; Thu, 11
        Aug 2022 15:30:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143051eucas1p24c16e378cd8080b0b22f5fb4d7659cf0~KUMxcTM6Q1006810068eucas1p2R;
        Thu, 11 Aug 2022 14:30:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143051eusmtrp1d7496c7528a7fa92d9ac255c5c0b907e~KUMxbLITs2320623206eusmtrp1g;
        Thu, 11 Aug 2022 14:30:51 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-b2-62f5129b3da4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 25.10.09038.B9215F26; Thu, 11
        Aug 2022 15:30:51 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143050eusmtip1008edb8f42bfb1b0c7b8a2557599ca5a~KUMxC32YU3243132431eusmtip1C;
        Thu, 11 Aug 2022 14:30:50 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v10 06/13] null_blk: allow zoned devices with non power-of-2
 zone sizes
Date:   Thu, 11 Aug 2022 16:30:36 +0200
Message-Id: <20220811143043.126029-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7qzhb4mGbT+1rRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLW5MeMpo8XlpC7vFmptPWSxO3JJ2EPK4fMXbY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1sHjtb77N6vN93lc2jb8sqRo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlTFr
        91/mguPSFQ/n/WdvYFwu3sXIySEhYCLx+8sGpi5GLg4hgRWMEu//n2OEcL4wSnxq2cQKUiUk
        8JlR4vzCGpiOSat7GSHiyxklJqxzgmh4wSjR0X0EKMHBwSagJdHYyQ5SIyKQLrF+wXIWkBpm
        gTtMEt/v9bCBJIQFIiX2tE4AK2IRUJXo7tvIBGLzClhJbOj/wgqxTF5i5qXvYDWcAtYSExZd
        hKoRlDg58wkLiM0MVNO8dTYzyAIJgd2cEq8mnGKBaHaR+Ph4FtQgYYlXx7ewQ9gyEqcn90DV
        VEs8vfEbqrmFUaJ/53o2kA8kgLb1nckBMZkFNCXW79KHKHeUeP16KSNEBZ/EjbeCECfwSUza
        Np0ZIswr0dEmBFGtJLHz5xOopRISl5vmQC31kNh79jzbBEbFWUiemYXkmVkIexcwMq9iFE8t
        Lc5NTy02zkst1ytOzC0uzUvXS87P3cQITIen/x3/uoNxxauPeocYmTgYDzFKcDArifCWLfqc
        JMSbklhZlVqUH19UmpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoHJSIvvam9G
        lCrv+s2BJz9IqVY5fdMRbyr+y8/6NqNE7MgWCTfTea6HQp9Xishssv/EVupxsKn8vUz/k0UP
        rj56qsH65kjDD9tfU5MmuzjEGOqc+HvgcMoZo+T3EZvc2vgtVsgYflR2uGY1gXN+/Mvc0Gv5
        q1YJPUz+k7Fk/4RyvTLundsm7bB2YOJOOn6JUSs44bvtaa7qezs///Rcs7BLXjxE+MwBh6SE
        s/rf0tIm/ugr8TvOdlbAw6YqNvZy/MG+//p6tQu3s0Wx/zTiNtvkIhFb8vx3VNwnfa3kBz3b
        V7TvWC3gq+gU4MAVfv/HF9N4gwLJc7ZPoy4rrZzMkWd1u0xx4iLTTs9V2rEeL5VYijMSDbWY
        i4oTAWjBbZ32AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7qzhb4mGZxYxGWx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PW7r/MBcelKx7O+8/ewLhcvIuR
        k0NCwERi0upexi5GLg4hgaWMEhOP/2GDSEhI3F7YxAhhC0v8udbFBlH0jFFixf79rF2MHBxs
        AloSjZ3sIKaIQK7EwSOBICXMAm+YJDqv72EB6RUWCJeYdPIAK4jNIqAq0d23kQnE5hWwktjQ
        /4UVYr68xMxL39lBbE4Ba4kJiy6C1QgB1UzoOMYOUS8ocXLmE7CZzED1zVtnM09gFJiFJDUL
        SWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwNjdduznlh2MK1991DvEyMTBeIhRgoNZ
        SYS3bNHnJCHelMTKqtSi/Pii0pzU4kOMpkB3T2SWEk3OByaPvJJ4QzMDU0MTM0sDU0szYyVx
        Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpsa3QXqLTXNncO3Zs0Yherfn5zcpnyfzLtL2S2na
        orflw80EsbVbL2y/pZB1ICtg1buNdpdZcjnV2vOET2vd+9fKHay3+N5HhwNzsj0vbXWYfXyH
        Sp5L8oz1ZWXKdh03fpiYdMZnRcvsKm65Y16kdilafVlX0D82hZVrJV2XeLSlidSWfjHSiP7W
        dX/S/I2e63lOXV7QuMZjk1vNb+O6yUF3T5d/ZLtpOGflpRt2EpdrO/vW79u1/Wf21INnvE9F
        2VyO+iS54/86haAY5um7F88p+W5br9txzlhc6+XzxXuj/r716eOZyZP4+/qS7fM1pxwuTIwM
        Vw6xNHxovpfpOvPXhBszFZb+atK+crH3Z5ASS3FGoqEWc1FxIgBNyj/zZgMAAA==
X-CMS-MailID: 20220811143051eucas1p24c16e378cd8080b0b22f5fb4d7659cf0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143051eucas1p24c16e378cd8080b0b22f5fb4d7659cf0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143051eucas1p24c16e378cd8080b0b22f5fb4d7659cf0
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143051eucas1p24c16e378cd8080b0b22f5fb4d7659cf0@eucas1p2.samsung.com>
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

