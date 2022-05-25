Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A505340BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiEYPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245366AbiEYPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:50:08 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372C9B043D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:50:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155004euoutp02ca06ceea0308e0c43d9d72cf00f067da~yY9rh2SFU0232402324euoutp02f
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:50:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155004euoutp02ca06ceea0308e0c43d9d72cf00f067da~yY9rh2SFU0232402324euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653493804;
        bh=+Hy87tAmG/yyKADBgWzp15ysBeZyafQHy3LFCyQAgp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSbAE9O+IMpDkfslzuGHPy9CTHc5z0NZMQWhy3cvl+dNrSgBOSDB1VTmDQxPczIt8
         qFuUzjNvD29O6mOPpMG/rApSx9c9Yb0k21df6eThMnvszXWrsm5jQ6MmWdo1lW8N2q
         7wVzUd+sJXRRBKr6sxWyg1Afq84EHHZqp5ncN270=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525155003eucas1p2a7c20e3afb1e439dfd265ea1aa7fa777~yY9p0V1-R0965609656eucas1p2D;
        Wed, 25 May 2022 15:50:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.5B.10009.B205E826; Wed, 25
        May 2022 16:50:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220525155002eucas1p140ca05edf5219f38e8f1a45801c2ed62~yY9pVc3d-1064210642eucas1p1p;
        Wed, 25 May 2022 15:50:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220525155002eusmtrp1ec4acfdd9bb2e4d1110f65446f4f7953~yY9pUNjfc1510315103eusmtrp17;
        Wed, 25 May 2022 15:50:02 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-3b-628e502babe3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.17.09522.A205E826; Wed, 25
        May 2022 16:50:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220525155002eusmtip1994e3f4509e63f9dac1bc8358a0fcfad~yY9o4AQn_1835018350eusmtip1B;
        Wed, 25 May 2022 15:50:01 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 3/8] nvme: zns: Allow ZNS drives that have non-power_of_2
 zone size
Date:   Wed, 25 May 2022 17:49:52 +0200
Message-Id: <20220525154957.393656-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87raAX1JBuf6WSxW3+1ns/h99jyz
        xd53s1ktLvxoZLK4eWAnk8WeRZOYLFauPspk8WT9LGaLngMfWCz+dt1jsth7S9vi8q45bBbz
        lz1lt7gx4SmjxeelLewWbRu/MjoIePw7sYbN4/LZUo9NqzrZPDYvqffYfbOBzWNn631Wj/f7
        rrJ59G1ZxeixfstVFo/Np6s9Pm+S82g/0M0UwBPFZZOSmpNZllqkb5fAlbF5dz9rQaNYxa+z
        j5gaGPuEuhg5OSQETCT+PJjG1MXIxSEksIJRYknfanYI5wujxJmb3xlBqoQEPjNKXDsV3cXI
        Adbx/ZUXRM1yoJoFsxkhnBeMEls+r2YFKWIT0JJo7AQbJCLQyCgx9eUJsCJmgdlMEvO+TQab
        KiwQIdE3ZQEziM0ioCrxdtsjsDivgJXE1qUrWSHuk5eYeek7O4jNKWAtMX//Z2aIGkGJkzOf
        sIDYzEA1zVtnM4MskBBYzSnx8vRMZohmF4lTL2ZBDRKWeHV8CzuELSNxenIPC4RdLfH0xm+o
        5hZGif6d69kg/rSW6DuTA2IyC2hKrN+lD1HuKHHqai8rRAWfxI23ghAn8ElM2jadGSLMK9HR
        Bg1dJYmdP59ALZWQuNw0B2qph8TRE22MExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXYMC+1
        XK84Mbe4NC9dLzk/dxMjMAGe/nf80w7Gua8+6h1iZOJgPMQowcGsJMJ74WlvkhBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQamKcs2nVJPuqtzfNPehYFW
        CYcPTvrd1Vvzbc+UqLb8fcej+ze7sh1YcU/wmrpA/a3tM1fW7lWdWOLnnZe/SfFD1lrZx6dm
        bTk8+dmc/o+PuRhWrC5b+cB269T+t8mCLhrbFR4+K7Q9qz9/g8tB/2tchaERjWks/b7m2r8N
        Nxy587nn/40XN67FS6qKKDGHLfVz8jp366HH9ZXm11oDzlq9nnaxZLXX6iMPb7LXmofGvzZv
        Zeqsuf6FVVX9kVWui+KyPcK+FuXLijsvO59J37/hRrNBdlrfkfiDs88LZN7/rC3TnnbaZ/Fn
        697bh4od92xa9fNDYtb61RtKT9x9abZaxXfenXObfLb/vMDzYU5h4E0lluKMREMt5qLiRACR
        SfxG7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7paAX1JBk/2yVusvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
        XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pz7n7Wgkaxil9nHzE1MPYJdTFycEgImEh8f+XV
        xcjFISSwlFHi1LfFzF2MnEBxCYnbC5sYIWxhiT/XuthAbCGBZ4wSqw+kgfSyCWhJNHayg/SK
        CHQySszZ1wrmMAssZ5J4/mkR2CBhgTCJuyd62UFsFgFVibfbHoEN5RWwkti6dCUrxAJ5iZmX
        voPVcApYS8zf/5kZYpmVxNc7X1kh6gUlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVS
        S4tz03OLDfWKE3OLS/PS9ZLzczcxAmN127Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeC097k4R4
        UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5gs8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNIT
        S1KzU1MLUotg+pg4OKUamPY3hSXcU3l/KfBNS/5Tfqc3E0WnLD0WOCnhsKBQ0zEJkcuHp6WE
        dlZGJf+XLtZziaixF/7uuYw5evnUPYcn5UjsO5G0LEAmVFjfqIUp/nuI7Z19OsZH7Ga/4uXP
        acmsOCi+ZlvrsdV7z3LM8Z9YsHhCnrRuaW60kIivt1b6gcMuNR1eYeebTouZHJqiUSli/Zvj
        eovW++2nfi1OWHlupWsFr6RZtcj6g4WdsfwdD5SNzXNOzjQ3WGUaZKyT+O7P7aCtj6caVG5K
        UqspOiwzV+2yRhHjlCmrvZ99s5VPyd/stGvl2idbZrftdHR8yxI1qSueIXTJOy6f5Xfel+88
        HpJy/MbG05Mutz9Y88xmhxJLcUaioRZzUXEiACNXaLVeAwAA
X-CMS-MailID: 20220525155002eucas1p140ca05edf5219f38e8f1a45801c2ed62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155002eucas1p140ca05edf5219f38e8f1a45801c2ed62
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155002eucas1p140ca05edf5219f38e8f1a45801c2ed62
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155002eucas1p140ca05edf5219f38e8f1a45801c2ed62@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

The power_of_2 calculation has been replaced directly with generic
calculation without special handling. Both modified functions are not
used in hot paths, they are only used during initialization &
revalidation of the ZNS device.

As rounddown macro from math.h does not work for 32 bit architectures,
round down operation is open coded.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4df4e..d92f937d5cb9 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
+	/*
+	 * Division is used to calculate nr_zones with no special handling
+	 * for power of 2 zone sizes as this function is not invoked in a
+	 * hot path
+	 */
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +196,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/*
+	 * Round down the sector value to the nearest zone start
+	 */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1

