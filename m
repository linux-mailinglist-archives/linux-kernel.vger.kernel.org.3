Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580B582AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiG0QYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiG0QXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:23:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6994D4FE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:22:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162253euoutp01f03cf89780b710c7f357cc6679d7ff17~FvDT6eekC2257722577euoutp01g
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162253euoutp01f03cf89780b710c7f357cc6679d7ff17~FvDT6eekC2257722577euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938973;
        bh=bmsUIhH5Krf3Y93QZk8wMGkt40E+vbrfCAl2ZfzXFsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8QLFiZfxGNaCEKMnvfjEjYvySW8dKoJtmUhqnBSNbRJUuJ8SldtiziT3U1wCUS+/
         wllPoEGA8PFpqxWYUS4DM6THyrjxH14NWcoTd/txHoWrZWHTej0W1vI4XYoE+qDzRD
         FJJ/w5bZ7ejNIdCur3atdEkKNk4p2Ft+rAs/XfJo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162252eucas1p2d1d5681c130281324a73b4703be63e00~FvDSn8ez52169521695eucas1p2l;
        Wed, 27 Jul 2022 16:22:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.C3.09664.B5661E26; Wed, 27
        Jul 2022 17:22:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f~FvDSJxEkF1290212902eucas1p1C;
        Wed, 27 Jul 2022 16:22:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727162251eusmtrp2555dbc48e32b198aa34ad92aed686343~FvDSJEXCA0811608116eusmtrp2w;
        Wed, 27 Jul 2022 16:22:51 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-ec-62e1665b6998
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8A.1E.09095.B5661E26; Wed, 27
        Jul 2022 17:22:51 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162251eusmtip1dfc3f183a47358335b251e9c7f2f11bb~FvDRv8eGX0448504485eusmtip1C;
        Wed, 27 Jul 2022 16:22:51 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v8 05/11] null_blk: allow non power of 2 zoned devices
Date:   Wed, 27 Jul 2022 18:22:39 +0200
Message-Id: <20220727162245.209794-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7djP87oxaQ+TDCZPZbJYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDLO7TIvmG5S
        sffefpYGxiuaXYwcHBICJhL/j6h1MXJxCAmsYJRYNX0rK4TzhVHi64wF7BDOZ0aJ/e0r2LoY
        OcE6vr/9B1W1nFFi+4cvTBDOc0aJaf8nM4LMZRPQkmjsZAdpEBEolnj4rpUFpIZZ4ACTxIPb
        LWCThAXcJE49vcICYrMIqEpMvTuTCcTmFbCS+HR/CTPENnmJmZe+gw3iFLCW2DxlHlSNoMTJ
        mU/AepmBapq3zoaqX88pcX1aPYTtInFpxUsWCFtY4tXxLewQtozE/53zmSDsaomnN34zgxwn
        IdDCKNG/cz0bJGCsJfrO5ICYzAKaEut36UOUO0pceXWcCaKCT+LGW0GIC/gkJm2bzgwR5pXo
        aBOCqFaS2PnzCdRSCYnLTXOgjvGQWPi9n3kCo+IsJL/MQvLLLIS9CxiZVzGKp5YW56anFhvm
        pZbrFSfmFpfmpesl5+duYgSmwNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeBOi7ycJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYMp5dS7k5NkT4VwfOBtc
        brYuXdYjsHa3or5M/URT58aU50U/FVr57tpe/8G3ce576z/clcabCow8Q+YyHOubW8JmVs34
        8bHi518Ge5g92U9N+ZtZsipssZNaJPsBx3XHm0NmzViZ+knxVsmz2h8f57z3CP7FYq38ZWX1
        38uJPXsYd3W927r0jk3hmpqZ1vJTTGJ+zxHpOWYzZ4t33/tCvtNPBfhOztqz98Y8D/vktf82
        8a6P6S6xFJQScnoi5zo1/XD5Odbsng2dD8PzAqw1vUWFfVaFyd76f/Gax/wU02nzdcpOxfb9
        NCss+Ge6iHdypM9aqU7OqzfffJmg0B4V//+BjvabK3VnXxkuFOJULlRiKc5INNRiLipOBABO
        FLOe8AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7rRaQ+TDO6vlbJYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLO7TIvmG5SsffefpYGxiuaXYycHBICJhLf
        3/5j7WLk4hASWMooMeXFJnaIhITE7YVNjBC2sMSfa11sEEVPGSWebrgG1MHBwSagJdHYyQ5i
        ighUSpz9IgtSwixwjkni5sVrbCC9wgJuEqeeXmEBsVkEVCWm3p3JBGLzClhJfLq/hBlivrzE
        zEvfwfZyClhLbJ4yD6xGCKjm2YOPbBD1ghInZz4Bm8MMVN+8dTbzBEaBWUhSs5CkFjAyrWIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM123Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeBOi7ycJ
        8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wYeSVxBuaGZgamphZGphamhkrifN6FnQkCgmk
        J5akZqemFqQWwfQxcXBKNTDlJqUZ8yxlf7JMvfTZonvHfzL9/1LyuHTnDv11pz+vi5kY7KzE
        xvz7jLr9w4831VfU789ccmDlFfm7wocY4znuW0WmXLGfWXJl8qYmWY1tmkwS7wO/BBuetU1c
        3XGcsWPW3XligkFhf7ffO5p9zop5ymrxyuhrAlxPft1+s+art4emxoGg6YtP3e6P3FbWk7Uv
        rGfD5OeLt9cqzuc9qZkQWN/NvODg3VsiTOv01gQsrzP70/pW78hPvkrNxM9cX5aJPTzvHrgj
        7rTBMuu36bYuL2+JNn1TP3TlJMeJj/cOhH5Ks893UBHY28H7ku3M5HmHJ/g+/N2o98Hm0Vv1
        JZO+5EalPShcLtHCNPNyK4vaNCWW4oxEQy3mouJEAIWhMsdgAwAA
X-CMS-MailID: 20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162251eucas1p12939ac3864fd8705ae139eb2d1087d8f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/block/null_blk/main.c     |  5 ++---
 drivers/block/null_blk/null_blk.h |  6 ++++++
 drivers/block/null_blk/zoned.c    | 18 +++++++++++-------
 3 files changed, 19 insertions(+), 10 deletions(-)

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
index 94ff68052b1e..ece6dded9508 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -83,6 +83,12 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	/*
+	 * zone_size_sects_shift is only useful when the zone size is
+	 * power of 2. This variable is set to zero when zone size is non
+	 * power of 2.
+	 */
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

