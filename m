Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F231D54C5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbiFOKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347618AbiFOKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:20:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C614C428
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:58 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101957euoutp01fe5ad35c80822125d6b5fac3889b336a~4xAb_j3OD2579825798euoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615101957euoutp01fe5ad35c80822125d6b5fac3889b336a~4xAb_j3OD2579825798euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288397;
        bh=HHYtJL7MZ8mJp034AQQHrXH5XtcFjyCN4mgNmFKgAG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6YMlDAXenX/cuoxfQW0lVotmTKVWJ6NUsScGHFoXpHaDcKk5elsjwhxyPDym6/YP
         T2nw6Drce9TIZRDxnI8mNuWwoL5LxAYBx2InN6Hgw/+eap3a9SXX/dFx42ztSdbD8D
         cP12bEUTq9iwCcRGjiWWT78ORrAhNBlmKLh7sWP8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220615101955eucas1p2eee10b45941965e4935abb0ebb017993~4xAaUbccm1132211322eucas1p2C;
        Wed, 15 Jun 2022 10:19:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.3B.09664.B42B9A26; Wed, 15
        Jun 2022 11:19:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220615101955eucas1p19b9d42ead7331f69f7dad1ec100312c2~4xAZ4G7zF1177311773eucas1p1q;
        Wed, 15 Jun 2022 10:19:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101955eusmtrp2c7777997ad5bfc414e0f88aef0add88c~4xAZ3Pb9R0349503495eusmtrp28;
        Wed, 15 Jun 2022 10:19:55 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-14-62a9b24bd01e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.24.09038.A42B9A26; Wed, 15
        Jun 2022 11:19:54 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101954eusmtip2aae9fd8bd11cf5ddb8d433d9ef34f41f~4xAZGNSD70755407554eusmtip2f;
        Wed, 15 Jun 2022 10:19:54 +0000 (GMT)
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
Subject: [PATCH v7 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Wed, 15 Jun 2022 12:19:16 +0200
Message-Id: <20220615101920.329421-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7djP87rem1YmGcx9J2+x+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDIm7hMt2MtV8XvKbPYGxuMcXYycHBICJhK7f55g7WLk4hASWMEo
        8Wr+R3YI5wujxIplj9kgnM+MEtO3HgMq4wBraT6qDBFfziix/ss+NpBRQgIvgZx5hiA1bAJa
        Eo2d7CBhEYFwiaN77jGB2MwCfcwST17WgdjCAjEST782g41kEVCVuP64BiTMK2AtsXzCTBaI
        4+QlZl76DjaGEyi+Y3YPK0SNoMTJmU9YIEbKSzRvnc0Mco6EwDlOiaWzG5ggml0kDi7fxQhh
        C0u8Or6FHcKWkfi/cz5UTbXE0xu/oZpbGCX6d65ng/jRWqLvTA6IySygKbF+lz5EuaPE1ul3
        WCAq+CRuvBWEOIFPYtK26cwQYV6JjjYhiGoliZ0/n0AtlZC43DQHqtNDov9/yARGxVlIfpmF
        5JdZCGsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEyYp/8d/7SDce6rj3qHGJk4
        GA8xSnAwK4nwmgWvTBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOm5y5IVFIID2xJDU7NbUgtQgm
        y8TBKdXA1PY4f6WvsEnbiw/3VMVT+qb9Uezhj/yeaKUutPnFoaDwuoPP3lcVxznOClQV2bGb
        s+lM9PJZ/FUfc+bPL7qXv8Zx9VPLsMXLrrz9u+iopOT1D2EPGxcEPLblvKm5Vvaszoy1atwr
        Yx5NYVZWWDHZqH+aG1u04InaBTJZP9KsVihPm1CSttd752elEne/YxMXqqyX+t+8PPSyW2z9
        1fJHj64d3vrGJZ7nxpnQPZOUrac8j5rySSl2MfdJfqvINLlEjQpd+4lTXkS/W7/m9MVdv/pO
        nH5hdfr6Aq74xwsb/1qvLPl2qeGYdCZrnOgK5e7XKZrnHe8p6P2XnH/e68aGLcl3H7gUW2ce
        8T18SMTxOoMSS3FGoqEWc1FxIgCbBCwoBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rem1YmGZzTslh9t5/NYtqHn8wW
        v8+eZ7bY+242q8WFH41MFjcP7GSy2LNoEpPFytVHmSyerJ/FbNFz4AOLxd+ue0CxlodAxbe0
        LS7vmsNmMX/ZU3aLGxOeMlp8XtrCbrHm5lMWi7aNXxkdhD0uX/H2+HdiDZvHzll32T0uny31
        2LSqk81jYcNUZo/NS+o9dt9sAMq13mf1eL/vKptH35ZVjB7rt1xl8dh8utrj8yY5j/YD3UwB
        /FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GRP3
        iRbs5ar4PWU2ewPjcY4uRg4OCQETieajyl2MXBxCAksZJc5/e8XcxcgJFJeQuL2wiRHCFpb4
        c62LDaLoOaPEzTf32ECa2QS0JBo72UFqRASiJTpvvgerYRZYwCxx+s4EsISwQJTE3WUrWEHq
        WQRUJa4/rgEJ8wpYSyyfMJMFYr68xMxL38HKOYHiO2b3gJULCVhJ7HoXD1EuKHFy5hOwcmag
        8uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4mRmB0bzv2c8sOxpWv
        PuodYmTiYDzEKMHBrCTCaxa8MkmINyWxsiq1KD++qDQntfgQoynQ1ROZpUST84HpJa8k3tDM
        wNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgWnm4qZLge3dfFP7Tk3bt8fM
        LK0keMM0Odc5fIvz3v5R+3Jqs51MavjaNQEls+SzPj98rauveXcL437umzLx+Z8+/v9x3Glb
        a+VN2QsbUxdPtTixq6Ptrc/yFYkpHbnMOsflL5xq5r1sl/bSpLS0rPpgy1Pj93cPh39f/uWe
        V6NOqE8c4y/P5ZtnNK5Y85b/tP7asJrsZ28OZAvdN7Q7Fem2bf3TBPd7euHP18Xcna2zunD+
        yz8KTBd4Vq1r/Tcj+816t0kVSYn6sybLuf/6eCvfxGGfe5lE9seXNxfcuNEuN0Pjvv7mgk1T
        Pp6oVk3td7D6s/zepNo96xR3Z3S8uelw9OJj3vyNTFdzOq7N/qkXqMRSnJFoqMVcVJwIAGEU
        qwx3AwAA
X-CMS-MailID: 20220615101955eucas1p19b9d42ead7331f69f7dad1ec100312c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101955eucas1p19b9d42ead7331f69f7dad1ec100312c2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101955eucas1p19b9d42ead7331f69f7dad1ec100312c2
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101955eucas1p19b9d42ead7331f69f7dad1ec100312c2@eucas1p1.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the blk_queue_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm-zone.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3e7b1fe15..af36d33f9 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -395,7 +395,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if ((blk_queue_offset_from_zone_start(md->queue,
+						      clone->bi_iter.bi_sector)) != zwp_offset)
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -608,10 +609,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask = (sector_t)blk_queue_zone_sectors(q) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				blk_queue_offset_from_zone_start(q, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1

