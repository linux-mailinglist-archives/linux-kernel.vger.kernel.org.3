Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B4582AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiG0QYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiG0QXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:23:31 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6E4D4D0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:22:55 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162252euoutp0154bd0d4a6e3b2e8018fedb1962248efb~FvDTN-mEy2263722637euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220727162252euoutp0154bd0d4a6e3b2e8018fedb1962248efb~FvDTN-mEy2263722637euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938972;
        bh=Bsc7ffoy0LhMbxzEuozZQbbuFTeAK8Q+M0p1bOnBh8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rol1d1lh/PYatN0HckrvAq5/kTBvDZ0gaxF61NoQFKnMPZBPNOgShU6H4ErDfmuql
         Gs7DrNbM1K1pxjMhqqokS2uEqLZ3vAt1XhQVgRmqcM6Rncf3j7tVdGfiR5xYl+xihQ
         gSK8Q5Eej7yhGDqiMyDgHmSpJ8u8rn6UfT0gT+gg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162251eucas1p2adf92628ca134e6467ff47be0e7d1e12~FvDR4EsdW2169421694eucas1p2p;
        Wed, 27 Jul 2022 16:22:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.B3.09664.B5661E26; Wed, 27
        Jul 2022 17:22:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220727162250eucas1p133e8a814fee934f7161866122ef93273~FvDRCXbtT1278312783eucas1p1p;
        Wed, 27 Jul 2022 16:22:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727162250eusmtrp27808e4608f064ce737a401d79ddefcfa~FvDRBmw-E0809408094eusmtrp28;
        Wed, 27 Jul 2022 16:22:50 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-ea-62e1665ba4cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.1E.09095.A5661E26; Wed, 27
        Jul 2022 17:22:50 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162250eusmtip1cde27cb89575ab05491e19471e0ccebc~FvDQsZyIA0050700507eusmtip1f;
        Wed, 27 Jul 2022 16:22:50 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v8 04/11] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Wed, 27 Jul 2022 18:22:38 +0200
Message-Id: <20220727162245.209794-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxj33Ht7e8tWuJTOfpMJWqPLUPGRhdyAW+Zilhtd5iPxSTascCmN
        UElLtzGX0clL6iKNRQnl5YunjhJQsAyINFnLhmK2QkJVQGI7MwKodDgaAozLrZn//b7ze53v
        5FC47LFoFaXRZnE6rSpdSYYQbc5A/+bE1LETW4eaJcyN4WKSufQigDNz9x/gTNdUuYjx3LVj
        TOfVCxjTcONXjPHarDgzbxrBmK6HGxl3RwXJVNf6xIy5YAZnhsw+xPhr8sTMTY+PYHofRn4S
        zroH9rB267CYdd83sC2NRSTbej2H/cVjJFl7/qiIfd49SLLnbzUitrXvNOtviWIL757D9r19
        LGRHCpeu+ZrTbfn4eEhazWBMZnvYt+PzG4zootSEJBTQH0KdvZEwoRBKRtcjmLhSioThHwSL
        i91Bxo+god5NvrYM+KqCqjoEBeZykTA8Q5DbM7U0UBRJx8CPRWLeIKf1MDaVv5yE034Mbru6
        EE9E0Efg995KjMcEvR6ueXpJ3iul42GmM1gWDWV//rucI6EToLWkalkupcPhtzIvwWN8SZN7
        uxzn84G2SeBns0/M5wC9C4ZtXwk5ETDuuiUW8HuwaK/GBHwafENzQW8egmK7jRS8CXD+XjoP
        cfoDsHVsEeQ74VER/1y8IhSGJsOFG4TChbZSXDiWwtkCmaBWgj3gDZYCuM9UEAJm4bllHDej
        tdY3drG+sYv1/97LCG9ECs6gz1Bz+m1a7ptYvSpDb9CqY5NPZbSgpQ/Yt+CavoMqx1/GOhBG
        IQcCClfKpccTR0/IpCmq7O843akknSGd0ztQJEUoFdJkTbNKRqtVWdxJjsvkdK9ZjJKsMmKb
        /K/8HmeUem9Jata05klTAxG/Ztf78ryX5OFsw/djr/ak1X00E3WSPlaJcpnLi0/nvjj0U3j1
        u4WbHEkD2NN1xfNT04Mj7WZ1ghyb1XYeXDHQV/sgbqMluT8qdvJzy/REtFO7d2FiwXltXXdF
        deto0t9G5+bMEvYqkedt3l36WYvp8JemHxSfHm0/0xSYLfafW7E/UmGfVLiOSBQ1T8wRZU31
        VtdYIVb7IsYYkD5+hOLywSFfvb/Ay6Ymw0j0PUdKf6LHnWAojN/QvrVK/k7b6p6I2aN92W8F
        Kp+FdcXdWXkzZyar42xoieivnX/Mhm0X7bDYAleMhw7kanLWW3pGlIQ+TbUtBtfpVf8BjbmT
        Be8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7pRaQ+TDI59FbJYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKWXtUq2M5f8eqvWgPjVN4uRk4OCQETiStP
        5zF2MXJxCAksZZSYueAsE0RCQuL2wiZGCFtY4s+1LjaIoqeMEgeefQNKcHCwCWhJNHayg5gi
        ApUSZ7/IgpQwCzQyS0zqn80G0issECZxa8F9VhCbRUBVYvHNE2wg9bwCVhJf97BBjJeXmHnp
        OzuIzSlgLbF5yjywE4SASp49+AhWwysgKHFy5hMWEJsZqL5562zmCYwCs5CkZiFJLWBkWsUo
        klpanJueW2yoV5yYW1yal66XnJ+7iREYq9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8CZE308S
        4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5HxgssgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamAK+Pg4qcZ+gZCj2h3nhxFS/339RJ1VHy2KU187Kf9KW2G8FdMh
        Fqf43sWzeMOzDm76dV5lt6l0/pe5teUi/53F2hdee2CWG767ee7kc1JVex7P/HXfY05Odqeh
        nv9CQYfauN3f1xS7bJrUrSa1YWlJ1Urmm90vtxifta1Wljxs9Tm8LWnXZfYF7s/zBHefb/bK
        11FfdODfAn3Jj4eqOb0153I3bVl4QXB+eo/DwU/r93DvUxW0C17SeeYUq0bQWqEDnDNWKP83
        X7X6WOy/damCcddP9y87uTG+tTsmtfHEtuV/t/Ud82zv4ckqcTcyvcVTdvXSg+SbZbXLDusx
        Z5/vu/rHziu//sOaVUeW/1yoxFKckWioxVxUnAgAVOzeWV4DAAA=
X-CMS-MailID: 20220727162250eucas1p133e8a814fee934f7161866122ef93273
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162250eucas1p133e8a814fee934f7161866122ef93273
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162250eucas1p133e8a814fee934f7161866122ef93273
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162250eucas1p133e8a814fee934f7161866122ef93273@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A generic bdev_zone_no() helper is added to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..662f1a92f39b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1be805223026..d1ef9b9552ed 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1350,6 +1350,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	return disk_zone_no(bdev->bd_disk, sec);
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1

