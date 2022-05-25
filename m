Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19E55340B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiEYPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiEYPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:50:08 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D81B0A42
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:50:07 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155006euoutp02f839f9c1fa5728d668d501a4787a785f~yY9ssHz5E0354103541euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:50:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155006euoutp02f839f9c1fa5728d668d501a4787a785f~yY9ssHz5E0354103541euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653493806;
        bh=9W1pLbbKKEsanlon70WFxiL7DVRrcoEEPxlxXdEW3tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUtqN6UoLdNj6uWhYdhS76kwjBfchXAD6tXcjKypXGQ5Zor9Uv0/pySK48uRJXz2Q
         Mxjpz9wLtPAQAt3vBJyqK5aFYKN+YiBxC47cgh17iOxGWX9J+/YAmUi3SuV0Tl01RD
         OEM7kEUVkpnnfgszDWcWjmmLA/FzWiceeimxHmRk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525155004eucas1p2dfa1a7a6b945f9b09d92979e69409947~yY9rKj9GH0574305743eucas1p2V;
        Wed, 25 May 2022 15:50:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.43.09887.C205E826; Wed, 25
        May 2022 16:50:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220525155004eucas1p162c6f43536424f93800ba788ed045363~yY9qwmLNY1064710647eucas1p1p;
        Wed, 25 May 2022 15:50:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220525155004eusmtrp26fd7b673c6e99ce337989ba209192d6f~yY9qvwSZQ0177001770eusmtrp2Z;
        Wed, 25 May 2022 15:50:04 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-6c-628e502c8c17
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.9E.09404.B205E826; Wed, 25
        May 2022 16:50:03 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220525155003eusmtip11ab0a9c1aac41be6c73f997f027f7090~yY9qdZ3lV1835018350eusmtip1C;
        Wed, 25 May 2022 15:50:03 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 4/8] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Wed, 25 May 2022 17:49:53 +0200
Message-Id: <20220525154957.393656-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87o6AX1JBgcOy1isvtvPZjHtw09m
        i99nzzNb7H03m9Xiwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxeJv1z0mi723tC0u
        75rDZjF/2VN2ixsTnjJafF7awm7RtvEro4Ogx+Ur3h7/Tqxh87h8ttRj06pONo/NS+o9dt9s
        YPPY2Xqf1eP9vqtsHn1bVjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBGcdmkpOZklqUW6dslcGWc
        XGNZcJK/Yte5x+wNjPN4uxg5OSQETCS+7VjN3sXIxSEksIJRYu+u86wQzhdGiWNrGpkhnM+M
        EksvdrHDtOxeepcNIrGcUeLhrP2MEM4LRom+DXOYuhg5ONgEtCQaO8Hmigg0MkpMfXkCrIhZ
        4BuTxJI53Uwgo4QFwiS+vl0DNpZFQFXi6MWP7CDNvAJWEvPnREFsk5eYeek7WAmngLXE/P2f
        mUFsXgFBiZMzn7CA2MxANc1bZ4OdKiGwnVNiydU9bBDNLhIn9m+EsoUlXh3fAvWCjMT/nfOZ
        IOxqiac3fkM1tzBK9O9czwZyhATQtr4zOSAms4CmxPpd+hDljkD3fGCHqOCTuPFWEOIEPolJ
        26YzQ4R5JTrahCCqlSR2/nwCtVRC4nLTHBYI20Pix6OJTBMYFWcheWYWkmdmIexdwMi8ilE8
        tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzAlnv53/MsOxuWvPuodYmTiYDzEKMHBrCTCe+Fp
        b5IQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGpqqEc/Mc
        zy2ou3L5HN9ttYl8J5Lf+s6RKHoc6xg+U+nNiV/Bvsm6X1L04oOu3W/IDWbJtVMQ6ntfYHhV
        LeSB0vmrqw81Ky6MyPfcuuMEV4vuC6ZnkkeYTBVeNL6I3MZ3V0oi4xC71d8k1vg8rq9boucV
        TFlTb/uA/8CNrdumbFI6W+z8WOCwxWqL5yndvV1CYY6/DtzN3bhFc+a3L60MS2ceOHq9ZsW5
        8k+XTBtEl94pffvuXV9Cg1bGvBcRP57L/FKPlN0bf+jpzVyL6PL9rQ9WMty5wpuix+XJXi65
        d8X36K38exJ87x803rApYH/m3Ud23iv/XpWde3teF7Ojn96pdXMcLnw8yfhAeU6US64SS3FG
        oqEWc1FxIgAWfEAC+AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7raAX1JBqcf2lisvtvPZjHtw09m
        i99nzzNb7H03m9Xiwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxeJv1z0mi723tC0u
        75rDZjF/2VN2ixsTnjJafF7awm7RtvEro4Ogx+Ur3h7/Tqxh87h8ttRj06pONo/NS+o9dt9s
        YPPY2Xqf1eP9vqtsHn1bVjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBG6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWcXGNZcJK/Yte5x+wNjPN4uxg5
        OSQETCR2L73LBmILCSxllFh6IwciLiFxe2ETI4QtLPHnWhdQDRdQzTNGiYYnF4ESHBxsAloS
        jZ3sIHERgU5GiTn7WsEcZoEmZolzC9czgxQJC4RIvG3jABnEIqAqcfTiR3aQMK+AlcT8OVEQ
        8+UlZl76zg5icwpYS8zf/5kZ4h4ria93vrKC2LwCghInZz5hAbGZgeqbt85mnsAoMAtJahaS
        1AJGplWMIqmlxbnpucVGesWJucWleel6yfm5mxiBkbvt2M8tOxhXvvqod4iRiYPxEKMEB7OS
        CO+Fp71JQrwpiZVVqUX58UWlOanFhxhNgc6eyCwlmpwPTB15JfGGZgamhiZmlgamlmbGSuK8
        ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M3JOrAro0JyveN36aE7Q8uXR/7N4vigU7mxfWMifo
        8r8PZFLqeBS8VmmefMwJM80HkkbLtigt8uQvyD/9bWuLKO9mLzHpxq2MnKeFXEv2CKjb/wj+
        tmT2nLDoRxceKlWVXJn7ZL/vZGOf7gp/EVH5lksN/cqPXXZOritM1HjEU2j+o0Y1S3JvfuT5
        qDef77y+M3vmry1lphNNfhcsc9n2/yXfrNPP4rMChefc/CeSLKMwY/muZ1xHzoa+msRTtcVl
        a/n/vXWGGdPaJPQ0hbWu1l5YaLn99L27CgI+LTXf2Gc7nNhfs32S0Vu5ZxXvO57FZczdvv8u
        Y25qV/wLmwdX/z33LPv+azO3g5aRdliMEktxRqKhFnNRcSIANKoc7WUDAAA=
X-CMS-MailID: 20220525155004eucas1p162c6f43536424f93800ba788ed045363
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155004eucas1p162c6f43536424f93800ba788ed045363
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155004eucas1p162c6f43536424f93800ba788ed045363
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155004eucas1p162c6f43536424f93800ba788ed045363@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

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
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b09550..e41b6a6ef048 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -243,7 +243,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f5c7a41032ba..ed8742a72dcb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1382,6 +1382,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

