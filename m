Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810351C178
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380270AbiEENzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380150AbiEENyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:54:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761357110
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:51:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135105euoutp02240f53b68a05e844191e5550b7395df6~sOcFJ5MDd0043500435euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:51:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505135105euoutp02240f53b68a05e844191e5550b7395df6~sOcFJ5MDd0043500435euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758665;
        bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9vcZ7tQ94f3VdiXUlJw+T1XLGmoWXNflO074KduS8EF9ysX5kXm1rt2m1oyipPJF
         U50l3s5pkVpoTOl0YLZI8MqqXX9N6AQmW707OVASef5mBymqwItd13057wGOgNgTDD
         KO6hTkj5nwC4MhPJeWVTwHKOJIMsISUeYasAXfkU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220505135103eucas1p23cfe1abbea461339e96795ea1bacf823~sOcDQPzY83233532335eucas1p2q;
        Thu,  5 May 2022 13:51:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1C.AC.09887.746D3726; Thu,  5
        May 2022 14:51:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505135102eucas1p10efc01a623d97cbd6634943faa506353~sOcCcJ-_r2600826008eucas1p1D;
        Thu,  5 May 2022 13:51:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220505135102eusmtrp2d6c56ae84c8e8295e4cea35a306dff91~sOcCX3XLs2658826588eusmtrp2C;
        Thu,  5 May 2022 13:51:02 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-e9-6273d6477c32
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.F2.09522.646D3726; Thu,  5
        May 2022 14:51:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135102eusmtip1164954ce909a59d1b207a210c6e6fd14~sOcCAQS_N0093500935eusmtip1F;
        Thu,  5 May 2022 13:51:02 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v2 04/11] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Thu,  5 May 2022 15:47:04 +0200
Message-Id: <20220505134710.132630-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxiHc+69vb1UW6/FyZkumjXKFBTFme1sGja3JZ5EDQvbH7rvonfI
        VhBbihuMCLTCCvId2doBwgSRD1cKlVHAjHUOJNBBVmXthG4aajal6ASGBaGjvZj53/Oe87zn
        977JYUjpvGANE5+YzCkT5QoZLaLaeryDW/cOq2K3/1WyHjWOFtKo7L6XRHO2QRINPcwkkLPb
        QqCub0sIVN/4M4HGjAYSne6+T6F67U0Sua8bCHT593Bk7yin0dnzbiEqyp4mkaPIDdBkrVaI
        mpxuCn139x71ajC2X9uHF6420dhiGBXiQZeJwnabGrc06GhcnXGGxK01J3GnM4PG+ZqJRevU
        HwJcYG4A2Gi+TuHW/jQ82bIO53TnEW+y74h2H+EU8SmcclvUR6Kjg54hIskn+UzvdIEM4Fye
        C4IYyO6EFdoJKheIGCl7AcBzraalYgrAHMM5IV9MAthumwOPW+51dgVYytYBeLuG4PlvAG/Y
        ns8FDEOzYTBTF+hdxeYBaNOMB14l2WkCXs6aFfobgtmDUGeeFviZYjfCiw5f4CEx+zI8f6uO
        5MPWQ/2vMwE/iN0Fy3U3BbyzEvbpxyg/k4uO5tI3S74rCBqvCHh+Az7qcy9xMLzTaxby/Az0
        Wc4SPKdBt2OO9A8HWS2AhRYj7d8ALoYVDCj8SLKbobFjG6/vgT/mVgt5QwIdnpX8BBJY0vYV
        yR+L4ZfZUt6WQYt3bCkUQntWOcUzhhW3KkEReNbwxC6GJ3Yx/J9bBcgGEMKpVQlxnGpHInci
        QiVPUKkT4yIOH0toAYs/tH+hd6od1N35J8IKCAZYAWRI2Srx67VJsVLxEfnnqZzy2IdKtYJT
        WcFahpKFiA/HN8ulbJw8mfuU45I45eNbgglak0GU6nczX8yOp9f1r167ovFktWizyFRWseGt
        1zw/hKfl+S6KvVFzipGfnFWFzcULO8Eh6wFvWbx56KWwcbW9xOMLYfNPvdc45Xg6NkofY++1
        vh/ZevVfzxYwsScySxY63+Q1NIP9MQ1R6avVSX8+yCvt9IRqU9or+rtPxz/3fUd9+okdbc6s
        rj5sMZfNF3wwMWBMbcnXVGUX+2zWaNfwvoNbBo5vXbGp8kKK5JFa8kAxMvPwk+Se2Y177aFf
        /5azXeL+5ZqpFpe+QLuWc1W6ZeGll158m75rqi6Oju4KPTD8ruXj/T2bjs9XbnhFeyOmJ9Xz
        VOayK7dHD43MoHW7cmr6NNIxGaU6Ko8MI5Uq+X8AVbthEAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7pu14qTDL5MUbNYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2eLp1VlMFntvaVtc
        3jWHzWL+sqfsFhPavjJb3JjwlNHi89IWdos1N5+yWKx7/Z7FQdjj8hVvj38n1rB57Jx1l93j
        /L2NLB6Xz5Z6bFrVyeaxsGEqs8fmJfUeu282sHn0Nr8Dqmq9z+rRt2UVo8f6LVdZPDafrvb4
        vEnOo/1AN1OAQJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexvm3F5gK/vNVzLx5j7GB8SZPFyMnh4SAicT73XsYuxi5OIQEljJKbD15lwUiISFx
        e2ETI4QtLPHnWhcbRNFzRok57e3MXYwcHGwCWhKNnewgcRGBqYwSF7ZfAGtmFmhkltj5xxbE
        FhYIk1j96y4riM0ioCqx9sZ/JhCbV8BKYtmj5cwQC+QlZl76zg5icwpYS8zpfAhWLwRUM/Hh
        OzaIekGJkzOfQM2Xl2jeOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+du
        YgRG/LZjPzfvYJz36qPeIUYmDsZDjBIczEoivM5LC5KEeFMSK6tSi/Lji0pzUosPMZoC3T2R
        WUo0OR+YcvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGphKuspK
        bD6uuW+lPm/djEuaGncerrdn0hZYvHhpON+hnNMh/32tbD11n+ifXqBesupTKRNr12uJtHPd
        /lHCDRY5dUJPGDVUWLiDl03duFNN33jqvZ1Nj/cxa7Yr33r9qqOorGXt+3Pe6+cut18j/O/x
        JA+pWYes32zcd/1T/Ldbu3PLIjPqbZdw7XC54SxzY2e9dtDLTwZpksfWlarPtlPiKyti2Zh3
        Wa9+n8qnm6+fZp66Y/84Y94uiwKp1udFrprqVmfaJbc1OWx/f2rvpS2s52/7rPaX6FtvGa8+
        a+X65yGxqetNzVd+7WoMnmD388vu4xdvONxZ+uxbjFPqgfqkucuXbI6VsFJ+J6fx/M09JZbi
        jERDLeai4kQAFrE/TYEDAAA=
X-CMS-MailID: 20220505135102eucas1p10efc01a623d97cbd6634943faa506353
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135102eucas1p10efc01a623d97cbd6634943faa506353
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135102eucas1p10efc01a623d97cbd6634943faa506353
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135102eucas1p10efc01a623d97cbd6634943faa506353@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32d7bd7b1..967790f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
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

