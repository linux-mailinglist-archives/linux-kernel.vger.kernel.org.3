Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A785314AA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiEWQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiEWQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:16:14 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A002B1A7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:16:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220523161612euoutp029d156265565c799f774a0d674d461173~xyB6_qEz81844818448euoutp02c
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:16:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220523161612euoutp029d156265565c799f774a0d674d461173~xyB6_qEz81844818448euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653322572;
        bh=OFfAgqCN0vZ0Zqcth1qSFEK5EzmfN28cnHFopHkhfn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdoBCwFkp4q28h9SbrzAMEOuZCEbIw8zjzsvXLpjZA11w8yWG3Jaac5wWpr3RmsHh
         l0ZHY6KfQHAiKzs6JGWu0z3+vsMAeCx3SdGFfufYlElbHjh5CMUASUjZmS8QEEVjV6
         N4oxQ3CIlGJDUlSJah4l72xRfwJCC55K0BaGykps=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523161611eucas1p1cb228cf2f9f73b3efa1d9b2c0fb0f3ea~xyB5gEiiO2464724647eucas1p1t;
        Mon, 23 May 2022 16:16:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 78.7E.09887.A43BB826; Mon, 23
        May 2022 17:16:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220523161610eucas1p212e81eda6b03a2d1ce8b763c9ec933ca~xyB5FGQZM1825618256eucas1p26;
        Mon, 23 May 2022 16:16:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523161610eusmtrp2991c48c105296293b567a7e3bdadb98e~xyB5EUZl_0219002190eusmtrp2P;
        Mon, 23 May 2022 16:16:10 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-1b-628bb34aa273
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.92.09522.A43BB826; Mon, 23
        May 2022 17:16:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220523161610eusmtip108e35c0ea0f8fe117da6b4fe20402e3b~xyB4ukA2_2143421434eusmtip1h;
        Mon, 23 May 2022 16:16:10 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 5/7] null_blk: allow non power of 2 zoned devices
Date:   Mon, 23 May 2022 18:15:59 +0200
Message-Id: <20220523161601.58078-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523161601.58078-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87pem7uTDJ7ts7JYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLH423WPyWLvLW2Ly7vmsFnM
        X/aU3eLGhKeMFp+XtrBbtG38yugg4PHvxBo2j8tnSz02repk89i8pN5j980GNo+drfdZPd7v
        u8rm0bdlFaPH+i1XWTw2n672+LxJzqP9QDdTAE8Ul01Kak5mWWqRvl0CV8bEF0vZC17rVsy8
        e4u9gXGHShcjJ4eEgInEnhudrCC2kMAKRolJS/S7GLmA7C+MEi0/mhghnM+MEp0XJ7HCdGze
        9YYRomM5o8S7C8IQRS8YJZ4ee8nexcjBwSagJdHYyQ4SFxFoZJR4f3QeK4jDLDCbSeLcg2tg
        k4QFXCQWXJ0BZrMIqEr8Ov2BCcTmFbCUaNn/nwlim7zEzEvf2UFsTgErietXr7JB1AhKnJz5
        hAXEZgaqad46mxlkgYTAek6JJe272CGaXSTWfNkIdbawxKvjW6DiMhL/d86HWlAt8fTGb6jm
        FkaJ/p3r2UBekBCwlug7kwNiMgtoSqzfpQ9R7ihxbncfK0QFn8SNt4IQJ/BJTNo2nRkizCvR
        0SYEUa0ksfPnE6ilEhKXm+awQNgeEr2/l7JNYFScheSZWUiemYWwdwEj8ypG8dTS4tz01GKj
        vNRyveLE3OLSvHS95PzcTYzABHj63/EvOxiXv/qod4iRiYPxEKMEB7OSCO/2xI4kId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUy2rHtuWVeeTW/dvun6
        ryCziMY7S368fx2yz/3XdN3F5hzCL8JmnTrl2CHSsyLj3ovZP15+qjuu9bA7TWfeYaEb+T9v
        qoisObVmc9iyX3GV54RE+6N1Vzz88v526CXnNQt57oUbiuTsKrS/GqYS5C9bJ+TVa58cYzvh
        iVjY3gO8t0//LclP+eQlUh5/riH7bskB5WU1rk1Zsyr4fgpL+T43Xibm5GXx4oBhu63n/1LW
        6kWzmzctTzsVYnJ159GtjC9K4k4Gzu014WI9vC9h8oLc95P/FuhcOn4xca1i1Xzf3g1SWTGR
        6/7aa+fL2kit8Vgf65RjwLvQYku16+aW+TeT9OS37tyvdytrroL9nGVKLMUZiYZazEXFiQDs
        I4Y07wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7pem7uTDHrnSVisvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbnFjwlNGi89LW9gt2jZ+ZXQQ8Ph3Yg2bx+WzpR6bVnWyeWxeUu+x+2YDm8fO1vusHu/3
        XWXz6NuyitFj/ZarLB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pii6XsBa91K2bevcXewLhDpYuRk0NCwERi8643
        jF2MXBxCAksZJZr+r2WHSEhI3F7YxAhhC0v8udbFBmILCTxjlPg6V6aLkYODTUBLorGTHaRX
        RKCTUeLoilMsIA6zwHImiZdrFoM1Cwu4SCy4OoMVxGYRUJX4dfoDE4jNK2Ap0bL/PxPEAnmJ
        mZe+gy3mFLCSuH71KtQyS4lT6yewQ9QLSpyc+YQFxGYGqm/eOpt5AqPALCSpWUhSCxiZVjGK
        pJYW56bnFhvqFSfmFpfmpesl5+duYgRG67ZjPzfvYJz36qPeIUYmDsZDjBIczEoivNsTO5KE
        eFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+YLvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTS
        E0tSs1NTC1KLYPqYODilGphyevRc4pPzeKtCjVy9y1c28J3q+WhsuPoxy7Z8AZkTjE+tWi1c
        vC92vNtyYjVfb/S3B253G8MbJis+ODRpbk2qx+MTs+/xCrPEbZi2TWD7+tuO6ZcMCneKvjnl
        3te+rFZi9vETU38VaZR1VmdsLZt5aLeYTlD2tgK7wiNaJy1WtK3468EbMVt8u+8howybBbb6
        skLf/j/5sP921OpH/s2SfSo3Ppz4/ivymKvH5JOXLohpTrSc87ZHQoVJ7FoMw8u6OLs7mYar
        lGb/jc9j2WvQ9T79jnhL59ZM8b5jiqwml3QXfn/9dKHvGbuTEvv7r0h6PZmw9c+3dOc8+Sf6
        GQ3cWtcesx8MmPy8KdaBRVaJpTgj0VCLuag4EQAQOx/4XwMAAA==
X-CMS-MailID: 20220523161610eucas1p212e81eda6b03a2d1ce8b763c9ec933ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523161610eucas1p212e81eda6b03a2d1ce8b763c9ec933ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161610eucas1p212e81eda6b03a2d1ce8b763c9ec933ca
References: <20220523161601.58078-1-p.raghav@samsung.com>
        <CGME20220523161610eucas1p212e81eda6b03a2d1ce8b763c9ec933ca@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/block/null_blk/zoned.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c441a4972064..1dec51d69674 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1930,9 +1930,8 @@ static int null_validate_conf(struct nullb_device *dev)
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
index dae54dd1aeac..00c34e65ef0a 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (is_power_of_2(dev->zone_size_sects))
+		return sect >> ilog2(dev->zone_size_sects);
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
+	dev->nr_zones =
+		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
+			  dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.25.1

