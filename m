Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65E54C5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347658AbiFOKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346842AbiFOKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:46 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3848896
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101944euoutp02dc702958c66fcf3aea55fc04e819bbd2~4xAP637l52870528705euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615101944euoutp02dc702958c66fcf3aea55fc04e819bbd2~4xAP637l52870528705euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288384;
        bh=lLGMwfb5PJ6NL047GLNc1b0pwU2MRBCwYBHDN82Un+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdrNB5U4teXlJ07QyJI5RreD3ZSKda2lOTrsSMtUwWZRNKw16ihkVKx0980mO7A28
         41az5D4tITuTSVO12DRSxNeQgxdUonyULn/a9xj4VqWcvdwHMPiLOm4J4Fmf0l45e9
         d+V+56Ck/gG2urEjKbEnzwulUEx0eBU+5gBT5qGc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615101942eucas1p2fd692c0d27a96cd40f5934749dd545cb~4xAN_mTaf1910819108eucas1p2k;
        Wed, 15 Jun 2022 10:19:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.67.10067.E32B9A26; Wed, 15
        Jun 2022 11:19:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615101941eucas1p25e1c27b363e6b288b848521298e31705~4xANeL5hf2111721117eucas1p2a;
        Wed, 15 Jun 2022 10:19:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101941eusmtrp2ae19a360edb4529854235d5eddd10b32~4xANdYsXz0349503495eusmtrp2g;
        Wed, 15 Jun 2022 10:19:41 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-7c-62a9b23ea0ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.55.09095.D32B9A26; Wed, 15
        Jun 2022 11:19:41 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101940eusmtip1c41b5b3584b730806ea14d0625152f0a~4xAMZrl_t0899908999eusmtip17;
        Wed, 15 Jun 2022 10:19:40 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 05/13] null_blk: allow non power of 2 zoned devices
Date:   Wed, 15 Jun 2022 12:19:12 +0200
Message-Id: <20220615101920.329421-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7djPc7p2m1YmGTz7wW2x+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDJaWq6wFpzVrdjYsIW9gXGGShcjJ4eEgInEoq5+xi5GLg4hgRWM
        Er/O3oZyvjBKrL24Dsr5zCgx7/1L5i5GDrCW1XeSIeLLGSX2rmxhAhklJPCSUeLaJ0+QGjYB
        LYnGTnaQsIhAuMTRPffASpgF+pglnrysA7GFBdwkfpz6xQJiswioSmzs2cIE0sorYCWx57Ev
        xHHyEjMvfQcbwylgLbFjdg8riM0rIChxcuYTFoiR8hLNW2czg5wjIXCJU6L/QB87RLOLxPuZ
        DVC2sMSr41ugbBmJ/zvnM0HY1RJPb/yGam5hlOjfuZ4N4kdrib4zOSAms4CmxPpd+hBRR4nW
        2ewQJp/EjbeCEBfwSUzaNh0aNrwSHW1CELOVJHb+fAK1U0LictMcFgjbQ+LCr8VMExgVZyH5
        ZRaSX2YhrF3AyLyKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMGWe/nf8yw7G5a8+6h1i
        ZOJgPMQowcGsJMJrFrwySYg3JbGyKrUoP76oNCe1+BCjNAeLkjhvcuaGRCGB9MSS1OzU1ILU
        IpgsEwenVANTW6HtqbYXFyvkbk/dmfq7tjuJdZHp19W5XbvnflXa5vicqaBrXcWye58zFsv8
        tGeeyZYbqrBXcUVW2HmGffeWsu+VaGbclX++uiPh/+y8UwF/1R7nSvwNEIjcmRWz2ao4tnz3
        MrMb7mx/HP0cHKKMenc/FN2d9OZAY+f908q/6p5LBy/fFrd3ek6rwSFRp2vH0idfuu2RVVUm
        rfTZpnWhZfNpG53LKa2L7Is+Owvr3Wb82v6VQe3qWqlzpx2PCD+6Jlh+eevFWv2CGcqR8ROm
        5h7yv8fOZb1lEbt3Rcbr7Zv63CcdiuZizPwyZ8q7g02Bye+VGDUC3dtFjdMcF4u+z2O0k/sZ
        IHlLMvFsySUlluKMREMt5qLiRAB3puJKCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7q2m1YmGfxbpmWx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        Avij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJa
        Wq6wFpzVrdjYsIW9gXGGShcjB4eEgInE6jvJXYxcHEICSxklZk5cxNrFyAkUl5C4vbCJEcIW
        lvhzrYsNoug5o8TUli/sIM1sAloSjZ3sIDUiAtESnTffg9UwCyxgljh9ZwJYQljATeLHqV8s
        IDaLgKrExp4tTCC9vAJWEnse+0LMl5eYeek7WDmngLXEjtk9rCAlQkAlu97Fg4R5BQQlTs58
        AjaFGai8eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGOHbjv3c
        vINx3quPeocYmTgYDzFKcDArifCaBa9MEuJNSaysSi3Kjy8qzUktPsRoCnT1RGYp0eR8YIrJ
        K4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgilxjtmVVXYLa5/L2
        fnZOqRtvl8V1LN7w4aBrZ+97z7zqGVl2d+7lG65cLZQnGf84Y7Iby/UtByacv/PN8/716Z3P
        5CavubqS37lT4MWNgvxOFu1LV6+JxZd5BRomT9knYzJHtoa572AA29NHU/2viFWFPrt2V2Dr
        24cTXZ9/KeUxqNd8aXbuXPODAx577j9ycmKXz5ioxidn1fYm9OeVmX+M7lrPFY0U5v3gveDL
        Q/NFXZlP7A9w/l3/P1t564zkC+Ef+DwmHj9lzv/A8RbDBdHqGzwMnompSU5vw0wmRFcWbvo3
        6VehSmbHHRb30x//rAl8ZWFvMzHTZ+bXvX9X2/vyvV7FGGC0NFGI/8FiDiWW4oxEQy3mouJE
        AENZ9i55AwAA
X-CMS-MailID: 20220615101941eucas1p25e1c27b363e6b288b848521298e31705
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101941eucas1p25e1c27b363e6b288b848521298e31705
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101941eucas1p25e1c27b363e6b288b848521298e31705
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101941eucas1p25e1c27b363e6b288b848521298e31705@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the power of 2 based calculation with zone size to be generic in
null_zone_no with optimization for power of 2 based zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for power of 2 based zone sizes as
this function is called only during the initialization and will not
invoked in the hot path.

Performance Measurement:

Device:
zone size = 128M, blocksize=4k

FIO cmd:

fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
--loops=4

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:

x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
x-----------------x---------------------------------x---------------------------------x

Random read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
x-----------------x---------------------------------x---------------------------------x

Minor variations are noticed in Sequential write with io depth 8 and
in random read with io depth 16. But overall no noticeable differences
were noticed

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c  |  5 ++---
 drivers/block/null_blk/zoned.c | 13 ++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6b67088f4..6c170927c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("Invalid zero zone size\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 2fdd7b20c..daf327015 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,7 +16,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (is_power_of_2(dev->zone_size_sects))
+		return sect >> ilog2(dev->zone_size_sects);
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
@@ -86,8 +85,8 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
+	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
+					      dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.25.1

