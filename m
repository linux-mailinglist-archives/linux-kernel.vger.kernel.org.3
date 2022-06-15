Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB854C5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiFOKUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbiFOKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:19:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398214B875
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:49 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101947euoutp01fe675e9d5cc950b3bae49b3473f58b74~4xAS_8wNj2579825798euoutp01O
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615101947euoutp01fe675e9d5cc950b3bae49b3473f58b74~4xAS_8wNj2579825798euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288387;
        bh=4jPwwWbQfF9zLvI8kpVWdO4LLyoyD4CJkiZ6uOQN+Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+HJxDk4JOont+x2vYqrrxujtLibpvxEN8f7FL/OFKCfGrBc29lBxwQgaXDl5OulC
         RIW5fnWaTdVC4DzCFKXhdhCdicwkEwP1hlUNEKbsu8fq3UNaNWcnrmNDovTXnvz+1m
         8gvAw/WE46ez8dd1YRy3HdPfGBRr4mBA1Esz38pM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220615101945eucas1p1d5342ae55cf549f7f52be0f3f500a61c~4xARRJUWa2260522605eucas1p1F;
        Wed, 15 Jun 2022 10:19:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 39.3B.09664.142B9A26; Wed, 15
        Jun 2022 11:19:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2~4xAQvVa5T1177311773eucas1p1k;
        Wed, 15 Jun 2022 10:19:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101945eusmtrp22c89343c319808137c8290492d5eddfa~4xAQudBoS0361403614eusmtrp2X;
        Wed, 15 Jun 2022 10:19:45 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-f7-62a9b24146d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.55.09095.142B9A26; Wed, 15
        Jun 2022 11:19:45 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101943eusmtip1dcf863a2a0f7ec36b4725dadaac7a2c0~4xAPefbdk0536005360eusmtip1f;
        Wed, 15 Jun 2022 10:19:43 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 06/13] null_blk: use zone_size_sects_shift for power of 2
 zoned devices
Date:   Wed, 15 Jun 2022 12:19:13 +0200
Message-Id: <20220615101920.329421-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7djPc7qOm1YmGVzYbWSx+m4/m8W0Dz+Z
        LX6fPc9s0dr+jcli77vZrBYXfjQyWdw8sJPJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW+y9pW1xedccNov5y56yW9yY8JTR4vPSFnaLNTefsli0bfzK6CDicfmKt8e/E2vYPHbO
        usvucflsqcemVZ1sHgsbpjJ7bF5S77H7ZgNQrvU+q8f7fVfZPPq2rGL0WL/lKovH5tPVHp83
        yXm0H+hmCuCP4rJJSc3JLEst0rdL4MpofXqaseC7UMWqX0vYGxh/8HcxcnJICJhI9H/6xQZi
        CwmsYJSYsjWpi5ELyP7CKPFu0zJGCOczo8Si0y+ZYDren13NBJFYziixt3E7M4TzklFixdJ1
        7F2MHBxsAloSjZ3sIA0iAuESR/fcA2tgFtjBLLGs5SHYPmGBGIljm6eBTWURUJU4f/YYI0gv
        r4CVxJJrGRDL5CVmXvoONodTwFpix+weVhCbV0BQ4uTMJywgNjNQTfPW2WA3SAjc45Q4evww
        O0Szi8SdfY1QtrDEq+NboGwZif8750N9Uy3x9MZvqOYWRon+nevZQI6QANrWdyYHxGQW0JRY
        v0sfIuoo8W5KJoTJJ3HjrSDEBXwSk7ZNZ4YI80p0tAlBzFaS2PnzCdROCYnLTXNYIGwPiXtd
        cxknMCrOQvLLLCS/zEJYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgAj397/in
        HYxzX33UO8TIxMF4iFGCg1lJhNcseGWSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLp
        iSWp2ampBalFMFkmDk6pBqZAlo5EsdWOtufWGi7td+G7dPHPop8b2PjvWvEbnambViN4vY7n
        mH9f2vSIaI/e3N8HTEq1erPkjtQHTr5+iX2T3ictbcnNuw/9Ou6zYmXBojX7y9uvn2mbFyTn
        +qr8Vtyk6YnaFxx3vm/ekvj7RMnRj6ohvt42OowKGpUeklU6c+6XrK0JTfRUn9yjWd4b2nxE
        /JagBfNUK6UDwTV7Dun/2xVWa3Tfbfv72KdTssxsuwxmLg0+ev7Lgjc7Fh9yZGzoqdCyvvk5
        ZI+L4bGdeVlzcua0n99Qf6VIWfrfKRW9bTZTasLW5TKyTxVXm5YovlgqM6w8+0VliVbdfa9t
        X79vute9TTA155OITtqt10osxRmJhlrMRcWJAGn10hkPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7qOm1YmGZybxWmx+m4/m8W0Dz+Z
        LX6fPc9s0dr+jcli77vZrBYXfjQyWdw8sJPJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW+y9pW1xedccNov5y56yW9yY8JTR4vPSFnaLNTefsli0bfzK6CDicfmKt8e/E2vYPHbO
        usvucflsqcemVZ1sHgsbpjJ7bF5S77H7ZgNQrvU+q8f7fVfZPPq2rGL0WL/lKovH5tPVHp83
        yXm0H+hmCuCP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst
        0rdL0MtofXqaseC7UMWqX0vYGxh/8HcxcnJICJhIvD+7mqmLkYtDSGApo8TJRQ3sEAkJidsL
        mxghbGGJP9e62CCKnjNKHF23lrmLkYODTUBLorETrF5EIFqi8+Z7sBpmgVPMEltmvWcCSQgL
        RElsObmFBcRmEVCVOH/2GCNIL6+AlcSSaxkQ8+UlZl76DjaHU8BaYsfsHlaQEiGgkl3v4kHC
        vAKCEidnPgGbwgxU3rx1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
        CIz2bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4zYJXJgnxpiRWVqUW5ccXleakFh9iNAW6eiKz
        lGhyPjDd5JXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MG3/4vx+
        ZuC+DPEPhw4bi3SvWiSTp625OfFez8MyJaZLxqpGr1wepvrsFZ8w797jmnc/RPfurPm+u2e2
        ZsltLi/ZuI7OSsb/9adXPrtl82516wauLTE1Pa9SE5cYKgXe159+MMK0uIKd++VM9doju/su
        r9t8Mu7yomUTOIPESqbOdJUOPjz/RvSta7djshc49G34efXxjdQ1Vp497BWell4qXw9H21zL
        6VwaafBh5bck4btl2e8vLzr66Elr1tXfs5/cufhv0tVb4rO/2VzpWRK0+kCQ9Q+ZGp3yv/b7
        J/6YHV71Ju69/hGdsq6i5c73f5ltidkvHHtEUdwok1NYRuK2yJ7W7IOVmnyrUlwvMy1VYinO
        SDTUYi4qTgQABDAVGH8DAAA=
X-CMS-MailID: 20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101945eucas1p16fa264e81d9b6027ff131dd311ed91e2@eucas1p1.samsung.com>
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
index 8359b4384..3bc7cbf25 100644
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
index daf327015..5f929944b 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -16,8 +16,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	if (is_power_of_2(dev->zone_size_sects))
-		return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
 
 	return div64_u64(sect, dev->zone_size_sects);
 }
@@ -85,9 +85,14 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
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

