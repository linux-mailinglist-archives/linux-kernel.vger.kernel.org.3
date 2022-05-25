Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA65340B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiEYPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245384AbiEYPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:50:11 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA5AE250
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:50:10 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155009euoutp02c669be071d29cfa104d9603afbcba4a2~yY9vhuS3n0354103541euoutp02J
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155009euoutp02c669be071d29cfa104d9603afbcba4a2~yY9vhuS3n0354103541euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653493809;
        bh=P6EDzhGk0ayJTp7pXFhq177m6nGhM9MaOSlB/71yZmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Crr0yUXuNj30M5OPKZe8/aGWbIGby/Qq2pgTDs0eegsFYKeJDPx9uMUKCj8V0i1fZ
         JRijPviBNy2nN4P+7gCrTQQydUYKnL2VEx74A7P6+/TSRce0skb8m38afsM2z3TCER
         Whe6m44tDwy68DOWN2lu9ioYs5nw2E5BX47WVa3M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525155007eucas1p2185abd17ca07eb32c8ea94cfdafaacdd~yY9trtP3W2563825638eucas1p2j;
        Wed, 25 May 2022 15:50:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2A.43.09887.F205E826; Wed, 25
        May 2022 16:50:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220525155006eucas1p13888214b1d9e23a26d04a75fbc5bf72b~yY9tDdGgB0654006540eucas1p1F;
        Wed, 25 May 2022 15:50:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220525155006eusmtrp1449a627ca162306b71ed53844a557768~yY9tCXqfN1510315103eusmtrp1H;
        Wed, 25 May 2022 15:50:06 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-70-628e502ff18c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.17.09522.E205E826; Wed, 25
        May 2022 16:50:06 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220525155006eusmtip1be55a7f5deec1bf03df36d46d1ca929d~yY9suny0c1835018350eusmtip1E;
        Wed, 25 May 2022 15:50:06 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 6/8] null_blk: use zone_size_sects_shift for power of 2
 zoned devices
Date:   Wed, 25 May 2022 17:49:55 +0200
Message-Id: <20220525154957.393656-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87r6AX1JBr9mc1isvtvPZvH77Hlm
        i9b2b0wWe9/NZrW48KORyeLmgZ1MFnsWTWKyWLn6KJPFk/WzmC16DnxgsfjbdQ+o7pa2xeVd
        c9gs5i97ym5xY8JTRovPS1vYLdo2fmV0EPT4d2INm8fls6Uem1Z1snlsXlLvsftmA5vHztb7
        rB7v911l8+jbsorRY/2Wqywem09Xe3zeJOfRfqCbKYAnissmJTUnsyy1SN8ugSvj4ddDbAXN
        whXNC7rZGhhbBLoYOTgkBEwk7uyx6WLk5BASWMEo8eNpXBcjF5D9hVHiy+atLBDOZ0aJJdMn
        MoNUgTTcON/FDpFYziixf/tXNgjnBaPE2bal7CBj2QS0JBo7wYpEBBoZJaa+PMEI4jALHGWS
        uHZuChPIKGGBKImDR+aANbAIqErsmmgFEuYVsJJY2PuXEWKbvMTMS9/ZQWxOAWuJ+fs/M0PU
        CEqcnPmEBcRmBqpp3job6rr1nBJXTwVA2C4Sc3/dYIGwhSVeHd/CDmHLSJye3AMVr5Z4euM3
        M8htEgItjBL9O9ezQcLFWqLvTA6IySygKbF+lz5EuaPEkx+vmCAq+CRuvBWEuIBPYtK26cwQ
        YV6JjjYhiGoliZ0/n0AtlZC43DQHaqmHREfTH6YJjIqzkPwyC8kvsxD2LmBkXsUonlpanJue
        WmyUl1quV5yYW1yal66XnJ+7iRGYBk//O/5lB+PyVx/1DjEycTAeYpTgYFYS4b3wtDdJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1Nwv3dG+RMzf6Vz
        q7e/93jZo/9+eV4LQxVTt8OPC1En/H+x/mA9sbgu6/zEKvlfry2+mm5RWtDCIOzx0U1F7XTh
        tA+8K7UWLo+Orjquc/bJnaNvDrQcOxa3VIXf5sTFcJa1Pj9faZTsklmam+xUEGT+YNX0jjxF
        H/v9Dyas38k4Xy30/M7vLx7XMzJZLGO5w3i1s9ko5MxvDs6nW052ed/waAz62Gz9mFvaXVJE
        aMtaYVFFrjWfSk5XBYpXrzjydIqMpGz/Gk8mlrSPUbtrez6Fr1XlyTujemBTyP37NWuDfiux
        /J+wpMf/VoHMqy1Hjj5vy7buie3P/C+UMfFn8Sn/OwZPPLXtP1lPOnNW7osSS3FGoqEWc1Fx
        IgAbKyd+8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7p6AX1JBoc/yFmsvtvPZvH77Hlm
        i9b2b0wWe9/NZrW48KORyeLmgZ1MFnsWTWKyWLn6KJPFk/WzmC16DnxgsfjbdQ+o7pa2xeVd
        c9gs5i97ym5xY8JTRovPS1vYLdo2fmV0EPT4d2INm8fls6Uem1Z1snlsXlLvsftmA5vHztb7
        rB7v911l8+jbsorRY/2Wqywem09Xe3zeJOfRfqCbKYAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j4ddDbAXNwhXNC7rZGhhbBLoYOTkkBEwk
        bpzvYu9i5OIQEljKKPF62VRWiISExO2FTYwQtrDEn2tdbBBFzxgl+t9uBCri4GAT0JJo7ARr
        FhHoZJSYs6+VHaSBWeAik8T5LgsQW1ggQmL7/A52kHoWAVWJXROtQMK8AlYSC3v/Qs2Xl5h5
        6TtYK6eAtcT8/Z+ZQWwhoJqvd76yQtQLSpyc+YQFYry8RPPW2cwTGAVmIUnNQpJawMi0ilEk
        tbQ4Nz232FCvODG3uDQvXS85P3cTIzBqtx37uXkH47xXH/UOMTJxMB5ilOBgVhLhvfC0N0mI
        NyWxsiq1KD++qDQntfgQoynQ2ROZpUST84FpI68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9
        sSQ1OzW1ILUIpo+Jg1OqgSmgQ6B37l+jWu67jxNaOkq3yPxweiFh1KG9dnvbrUoTtv8Kd31+
        Gen+ji/SLDx1/87f4Me6nQyNt17MZph9zPnQzc9RzFa8kzdKznR+cC7XceVn2wzt5R8armnO
        eHxHpSz2n+Cvup0z9+q5iizeNS9UYJcg9zdlhTT/etaEr/YJ26/7TItnXH3xW7kco7CMTL3m
        83vc4hzcm6eueSS6d/GFbpZFO/Kelax+sHBVfZ/arjBWntSOa81bt+rNEWtj+MG36dLirQVb
        0xtO/BKdHGuU9vfJzoYEx/PORn/eigi9eJPf3jb7doTcoQsrNvntdvs9RyFAK/zVRL7Pd2o2
        zDp3R5X34NoXX69/dL2rxlGsxFKckWioxVxUnAgA+pWRW2MDAAA=
X-CMS-MailID: 20220525155006eucas1p13888214b1d9e23a26d04a75fbc5bf72b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155006eucas1p13888214b1d9e23a26d04a75fbc5bf72b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155006eucas1p13888214b1d9e23a26d04a75fbc5bf72b
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155006eucas1p13888214b1d9e23a26d04a75fbc5bf72b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
the zone_size_sects_shift variable and use it for power of 2 zoned
devices.

This variable will be set to zero for non power of 2 zoned devices.

Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/null_blk.h |  6 ++++++
 drivers/block/null_blk/zoned.c    | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 78eb56b0ca55..3d6e41a9491f 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -74,6 +74,12 @@ struct nullb_device {
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
index b79091b5e4b1..a8be1011def5 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,8 +13,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	if (is_power_of_2(dev->zone_size_sects))
-		return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
 
 	return div64_u64(sect, dev->zone_size_sects);
 }
@@ -82,9 +82,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+
+	if (is_power_of_2(dev->zone_size_sects))
+		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
+	else
+		dev->zone_size_sects_shift = 0;
+
 	dev->nr_zones =	DIV_ROUND_UP_SECTOR_T(dev_capacity_sects,
 					      dev->zone_size_sects);
-
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
-- 
2.25.1

