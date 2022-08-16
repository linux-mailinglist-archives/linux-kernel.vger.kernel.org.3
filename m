Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52F595D10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiHPNQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiHPNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:53 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197815C343
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131550euoutp01a072ef1f97f15e2a5b0514d01d60e430~L1ZtT7HS50136201362euoutp01U
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131550euoutp01a072ef1f97f15e2a5b0514d01d60e430~L1ZtT7HS50136201362euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655750;
        bh=rwrR95VBKntQTDKdi+ldY8ggDErFsfT3t9lp/si7I3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwEzvTlqqgikNH93hU+Wqj/ChkKX3GhOECyZDjXopkbEIFKsNwqJprwN84qto1Fwk
         HXWEOZo5VP2WJGLOMWg7zqqSpCs02kq2EeQpd571ScwzCUhIBBNegRxFTqFX9TABjH
         BB1r6J7+z17fndIbBJoN94ubzkdTLbdTA+meWvsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816131548eucas1p2375e0cebff6f39ce61cc4c543cb9036a~L1ZrqxO3D3101631016eucas1p2K;
        Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 59.A3.09664.4889BF26; Tue, 16
        Aug 2022 14:15:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131548eucas1p1f480f8312e3060d0f633d97a90d7c84b~L1ZrPO_8J0139801398eucas1p1Z;
        Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131548eusmtrp19e72020fa360af0f686a4a7fae4fc41d~L1ZrObTgs0519705197eusmtrp1H;
        Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-18-62fb9884a47c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 95.B0.09095.4889BF26; Tue, 16
        Aug 2022 14:15:48 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131547eusmtip2daaaaf59270cb91624eece8d5d73d1b6~L1ZqwGvIF1363513635eusmtip2j;
        Tue, 16 Aug 2022 13:15:47 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Tue, 16 Aug 2022 15:15:33 +0200
Message-Id: <20220816131536.189406-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87otM34nGcx9Z2ax/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVcvn+HteAI
        b8Wqhy2MDYwfuLoYOTkkBEwkVj9/wAhiCwmsYJQ4Pj2ti5ELyP7CKPGoaz0bhPOZUWL1hXks
        MB3fF+5ggkgsZ5RYPv8lI4TzglHi2Iwu5i5GDg42AS2Jxk52kAYRgXSJKS0vWUBqmAW2MUm8
        uTQBbJ+wQKTEigffmEFsFgFViQ+zVoA18ApYS7z6eJAZYpu8xMxL38HinEDxfw2rWCBqBCVO
        znwCZjMD1TRvnc0MskBCYD2nxMrm2VCnuki0r1rKBGELS7w6voUdwpaROD25B6qmWuLpjd9Q
        zS2MEv07QZ7mAHKsJfrO5ICYzAKaEut36UNEHSX+PPGGMPkkbrwVhLiAT2LStunMEGFeiY42
        IYjZShI7fz6B2ikhcblpDtROD4kb52+zTWBUnIXkl1lIfpmFsHYBI/MqRvHU0uLc9NRiw7zU
        cr3ixNzi0rx0veT83E2MwCR4+t/xTzsY5776qHeIkYmD8RCjBAezkgiv4IsfSUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqYvF7VFr03bEuKKY+VOvWv
        77jBhKfRb8xnqF6b+V81nuHb8YCXU7gUs/1FHk3av98pR+rB/Nu/RZpmp27eMcd1VXOKgPOR
        q1Xpx5V16iIeTkruaN5tWvHvKF/IJ7fqoBfRnVdkPvpOfG4ptv+kV7HgMbHvySm3u2OTXj1R
        f5/8drWTcl9Knt+fEAlf63eJN2OOXTy4RW21mp/E/7DS8OiCVe2MSpXH5W17pPr8dU6atntu
        27a012uD1MxNx3k6H8558ijv4KsPjrpT3l7qu2B2zr8l8lxew2aRnN3RaTbN3cpt1+SF+vJW
        K5ZqsW+cuajK9zbLe27FfX9M9DlztVWtBL3EUr+I/1vop7Hkb7USS3FGoqEWc1FxIgC1p2xR
        8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7otM34nGTy7xGex/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcvn+HteAIb8Wqhy2MDYwfuLoYOTkkBEwk
        vi/cwdTFyMUhJLCUUWLVvZtsEAkJidsLmxghbGGJP9e6wOJCAs8YJd7PDepi5OBgE9CSaOxk
        BwmLCORKLFrWwQoyh1ngCJPEgunLmUESwgLhEntmrgIrYhFQlfgwawWYzStgLfHq40FmiPny
        EjMvfQeLcwLF/zWsYoHYZSXRduwyM0S9oMTJmU/A4sxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR
        1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCI3Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEV/DFjyQh
        3pTEyqrUovz4otKc1OJDjKZAd09klhJNzgemjLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0
        xJLU7NTUgtQimD4mDk6pBibfloOiOivy/xmvuWt5UCxuQvg0yQXnHh4IndWafOJ1+LYoZcZ7
        rAlzj0Yv7k15JvzpMXv4U961yrphK/Ku635bqvLt3kKJP1rvFDcnX3uwLDvJnENRed/UhuNu
        Gsd0a/4rWLv85jg3h2nue/50synGz3d9ZHgv/5yhdl7d0wsfGxQaTkpePr3pKm/cmb7OotNZ
        hQyB6Y4vz/y9ZKDVYNsW1hX1xPOc6huHezvXfPn9fan8Lp27B+V+GT1JjP3FJSV0SNXz2/rl
        RVkKndUCh67aBGxdWR6llOz5sbuc20uMP+ty4t4d0cGZE3azyPtnJk85ctl4jnSCy0/pi0rF
        2UtSjVZ/3cMRrnn16rmn15OVWIozEg21mIuKEwFRic8nYQMAAA==
X-CMS-MailID: 20220816131548eucas1p1f480f8312e3060d0f633d97a90d7c84b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131548eucas1p1f480f8312e3060d0f633d97a90d7c84b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131548eucas1p1f480f8312e3060d0f633d97a90d7c84b
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131548eucas1p1f480f8312e3060d0f633d97a90d7c84b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
the block layer now supports it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..31eb1d29d136 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1642,8 +1642,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

