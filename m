Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B154C5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347243AbiFOKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346521AbiFOKTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA153F89F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101930euoutp0233f9dfa02dc8a1ce377cc800fe365d07~4xACslHCr2915529155euoutp02B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615101930euoutp0233f9dfa02dc8a1ce377cc800fe365d07~4xACslHCr2915529155euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288370;
        bh=Owj5SwDy5cIi235KyiliqrWe09HaL8B16ylUw06/YSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtXOC52fvw37hNrubcz1a6F9mtfmezXeGipERA4vXY/EXRwA/1rXreHjJotmcopow
         by1Zu7fyx04YH79lQrGQhoYIs6H3q2EM2rMCgriWfKn+HIj+V84Beq/tBfhs/s+2Kd
         GQZgt1idh7YvWW/pKCMwu8u+jYgai/Poag5CBTYU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220615101928eucas1p1b977b0e4c5103c43695d0073172d222d~4xAA3t8X30963309633eucas1p1n;
        Wed, 15 Jun 2022 10:19:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D5.2B.09664.032B9A26; Wed, 15
        Jun 2022 11:19:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec~4xAAaJBok2789027890eucas1p1_;
        Wed, 15 Jun 2022 10:19:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101927eusmtrp21290cb4f6f1f11203710eaa6a045886f~4xAAZHNrb0349503495eusmtrp2H;
        Wed, 15 Jun 2022 10:19:27 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-b9-62a9b2307870
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.45.09095.F22B9A26; Wed, 15
        Jun 2022 11:19:27 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101926eusmtip2a4d1534f6d9fb211105b6da848dd27ef~4w--OR_FM0785907859eusmtip2F;
        Wed, 15 Jun 2022 10:19:26 +0000 (GMT)
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
Subject: [PATCH v7 01/13] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date:   Wed, 15 Jun 2022 12:19:08 +0200
Message-Id: <20220615101920.329421-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djP87oGm1YmGSz5wWOx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDKWn2tiLmgTqfh/dAtzA+NVgS5GTg4JAROJrUvXs3cxcnEICaxg
        lFi3/xmU84VR4v+rk4wQzmdGiSOdn5lgWtbsPQ+VWM4oMWtGPwuE85JRYs7hv8xdjBwcbAJa
        Eo2d7CANIgLhEkf33ANrZhboY5Z48rIOxBYWSJZY8nopK4jNIqAqsfvobhYQm1fASqJ30Reo
        ZfISMy99B5vDKWAtsWN2DytEjaDEyZlPWCBmyks0b53NDHKDhMAlTom+2fdZIJpdJI6+3ssI
        YQtLvDq+hR3ClpH4v3M+1IJqiac3fkM1tzBK9O9czwbygATQtr4zOSAms4CmxPpd+hDljhJX
        7n9hhqjgk7jxVhDiBD6JSdumQ4V5JTrahCCqlSR2/nwCtVRC4nLTHKjDPCQ2nLrFOIFRcRaS
        Z2YheWYWwt4FjMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPn6X/HP+1gnPvqo94h
        RiYOxkOMEhzMSiK8ZsErk4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1I
        LYLJMnFwSjUwpVj1Ta71m7jyyqYizpRu8wUJTla89a79s0y+RhyZ+jfCllP7zXVRtn/rLJ8J
        2+yx2Bv4ZHKVezOHwlWuE6+Yvi7r1o//aCxraXxHJT/3jJyH9dNcdceuLmtuBsE1fz9oCB8y
        O7UiV1xx81xF3RfPN23rEdn+22lLeevteZe0OMV3C/sJt9y8phsmajJp4XR9JdPkQxxXFmgu
        eXfZVOqfvOxlZdb8JsYFN579OnVxa8ztf/Vh4TM5vM51TbIsvPtU2nm5wZGSkzXV1x2Wt8Yf
        /5K4ZcrJBm2n+3H8ElXbow/Hu22K+phuFnEgoybJ8c2+c0cXcAfkv9AWfnl8584XhjNli5qf
        zM9ay3nhyGsuJZbijERDLeai4kQA603WCwwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xe7r6m1YmGXSt0rJYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
        tC0u75rDZjF/2VN2ixsTnjJafF7awm6x5uZTFou2jV8ZHYQ9Ll/x9vh3Yg2bx85Zd9k9Lp8t
        9di0qpPNY2HDVGaPzUvqPXbfbADKtd5n9Xi/7yqbR9+WVYwe67dcZfHYfLra4/MmOY/2A91M
        AfxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnL
        zzUxF7SJVPw/uoW5gfGqQBcjJ4eEgInEmr3nGbsYuTiEBJYySqw9+ZQZIiEhcXthEyOELSzx
        51oXG0TRc0aJyYsagRwODjYBLYnGTnaQGhGBaInOm+/BapgFFjBLnL4zASwhLJAoMXVXP9gg
        FgFVid1Hd7OA2LwCVhK9i74wQSyQl5h56TtYPaeAtcSO2T2sIPOFgGp2vYuHKBeUODnzCVgr
        M1B589bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMq3Hfu5eQfj
        vFcf9Q4xMnEwHmKU4GBWEuE1C16ZJMSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wDSTVxJv
        aGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAFBNS5ufWOfVzzaOzt+ew
        bLi6Lfn2PpWmCcdKJHJYXa62XH21J4lDoXnF2huz1rCenv3htnuK2rXVT3vvigWUzfG17f5x
        bt/Ue8tMzO4/P5UxXyRxb9sqtWivu3qFO9sjrux+mmP/tfm9mLL+pccXl+87sWTP+dTUifuX
        za7iYdv1pKTpgM2+Go6r5/8GGAXyF4QzhfMYnuuwmTjZ8d+ZjML793JO+DVJfVDaEHfVgflz
        QOSDM6acTBO1nu/0PDnRl/v71itK92+dqj0dtlNgilJlhtJjG8NMZR+xZwtF38i96p+68d1k
        xyWbHCYwq9YLr50Sr+z6UHvGleqqK9vXzjv7L+GJLHdg5bvbwgtfzWlXYinOSDTUYi4qTgQA
        q9mqDXsDAAA=
X-CMS-MailID: 20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101927eucas1p17220c7a36f69f59ff8ddd560b42967ec@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 12 +++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8..8b0615287 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,22 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	return DIV_ROUND_UP_SECTOR_T(capacity, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 914c613d8..39017ae9d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -681,9 +681,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1

