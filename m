Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FAC58FE58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiHKObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiHKOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:30:57 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99E647FA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143051euoutp01de47badcaba00ba8521f5428582e4ed8~KUMxsXJx92164821648euoutp01M
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143051euoutp01de47badcaba00ba8521f5428582e4ed8~KUMxsXJx92164821648euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228251;
        bh=tGdXrZOo82rW1rnRJeQcvmwRabixUhHDV5CM9X+9nHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIIVgrmdDjVY7c6oUankpYVIjETFb1jFWYQyCvWLeMj8aHxZBr++3Pu5U3A7LbLdb
         lT7GQJjgYhlpAuMrvH3Y427Z7xiEuAVwsqDoyQLEiHQUiUlu1lMx20HKy48c0fVhFN
         Os7p2qwwfb3WWQVzL0EtAayOFht3NatXh5861rbM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143049eucas1p27cb8b7758e8a5e7b59456f22fb326720~KUMwHY_MB1006810068eucas1p2M;
        Thu, 11 Aug 2022 14:30:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.3A.09664.99215F26; Thu, 11
        Aug 2022 15:30:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143049eucas1p141d029f2efd6703b596bbea71ab69204~KUMvfQPuc0779607796eucas1p1j;
        Thu, 11 Aug 2022 14:30:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143049eusmtrp1e3aae0de0e516634df21100a3c33ba88~KUMvdqMez2320623206eusmtrp1b;
        Thu, 11 Aug 2022 14:30:49 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-ee-62f51299c5cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.10.09038.99215F26; Thu, 11
        Aug 2022 15:30:49 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143048eusmtip11fa620b806bf661c7086d78210f8c4d5~KUMvLFObd3242632426eusmtip1D;
        Thu, 11 Aug 2022 14:30:48 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v10 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Thu, 11 Aug 2022 16:30:34 +0200
Message-Id: <20220811143043.126029-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7ozhb4mGfzYYmix/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2P2
        plssBaf4K561bGNtYFzC28XIySEhYCLxfO8mNhBbSGAFo8SZOfpdjFxA9hdGiQfb/rFBOJ8Z
        JS69+scG09F0ZykjRGI5o8TJu1uhnBeMEv0//7B0MXJwsAloSTR2soM0iAikS6xfsJwFpIZZ
        oJ9ZYsG/5WCThAUiJc5NuA1WxCKgKjF1yyYwm1fASmLq/ovMENvkJWZe+g4W5xSwlpiw6CIT
        RI2gxMmZT1hAbGagmuats5lBFkgIbOeU+HXmK9SpLhKvljYzQtjCEq+Ob2GHsGUkTk/uYYGw
        qyWe3vgN1dwC9MHO9WwgH0gAbes7kwNiMgtoSqzfpQ9R7ijR1DKDCaKCT+LGW0GIE/gkJm2b
        zgwR5pXoaBOCqFaS2PnzCdRSCYnLTXOglnpI3Pr2jXECo+IsJM/MQvLMLIS9CxiZVzGKp5YW
        56anFhvmpZbrFSfmFpfmpesl5+duYgQmxNP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeMsWfU4S
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwNR4VZt9vkC0
        QKflupotd1aor+Cpl9uYYLAsObDCZ32w9qH5Jvf9ztgGnO9h4g6QO/2sz3XS96YaxlsvZz05
        ELBXIaX4u8Odk7aHV6xPfdNTdlhHLPQVO+e1X6onhON3H67qLxI7dz6F2Xlee5L3CiGZ5Sv3
        cbtGr3/548OSDs39c/b7ui3bwsjTZ+u7VDFcrmDenj3JgsXqvNPYEhIemZz8vct9rvUZmdWf
        7fdM1HDlMTqYprDv8AOeiZl5KqmyKf+27nlZJJGR0qvEJlrf6XRONeDxmvjwfDcV/dxXoVxt
        u/3fTT31zHmm7cnJWSJenEfnJEw9fE7vYdwH8Ser+9hnOQn75+d0lHue0m/6pMRSnJFoqMVc
        VJwIAHpOmKb3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7ozhb4mGVxYxGax/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P2plssBaf4K561bGNtYFzC28XI
        ySEhYCLRdGcpI4gtJLCUUeJzTxxEXELi9sImRghbWOLPtS62LkYuoJpnjBLH22azdjFycLAJ
        aEk0drKDmCICuRIHjwSClDALzGeWeNn/HKxEWCBc4sCueJAxLAKqElO3bGIHsXkFrCSm7r/I
        DDFeXmLmpe9gcU4Ba4kJiy4yQZxjJTGh4xhUvaDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWA
        kWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYNxuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMJb
        tuhzkhBvSmJlVWpRfnxRaU5q8SFGU6C7JzJLiSbnAxNHXkm8oZmBqaGJmaWBqaWZsZI4r2dB
        R6KQQHpiSWp2ampBahFMHxMHp1QDk1VZ0G9JZS2XSSqGCXv91oRXZTmEivcFnt4U7p/2fubE
        E/tUNr2JXz7B/alLs7bWHaevQtyXT7Hfa4jp/Tr3LUcwq+uFHe5JF+PX7k54qrVj1srju6+9
        jMoyuKN6OmOByQ6P/XeU3uzL+bj+1p8Oh1vvV9+NVd8x5WjJsgnqF9jOX43SmuW6p3p7nQt7
        9FPhjaL1qmUKb3adjOHS/pD6/7ULj9Ky+tgki/2x3CqWom+77vzQMrYwlz6vXfPE9cVxLc/d
        5coPpjoI7Xi0fev08xnHJ2+b1bqReYaZ/qc9H1WPPfnTw3Z2rv9Upo+uWakvWrJf7fvSUPxn
        7aRG+3snru5VvRD5fjPDRrsbl9KDp3QqsRRnJBpqMRcVJwIASf8/ImQDAAA=
X-CMS-MailID: 20220811143049eucas1p141d029f2efd6703b596bbea71ab69204
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143049eucas1p141d029f2efd6703b596bbea71ab69204
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143049eucas1p141d029f2efd6703b596bbea71ab69204
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143049eucas1p141d029f2efd6703b596bbea71ab69204@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
support for zoned devices with non po2 zone size.

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
index d0d66a0db224..b2636dcca105 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1340,6 +1340,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
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

