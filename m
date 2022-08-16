Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE45595D12
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiHPNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiHPNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:52 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36855A2F7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131549euoutp012d191db8b79258dcc018bb3cc18a6d1d~L1ZscEx4g0136201362euoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131549euoutp012d191db8b79258dcc018bb3cc18a6d1d~L1ZscEx4g0136201362euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655749;
        bh=rIbhfxDBpj+Ii51tIIt4kTVb6ZA8NV8eQeaNrvmy2UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFHmCgW3scAwFETWgtohASUPy96lLu279gtR4xXWKKnOc2aAvfbb1Xwx+anLwtQ5p
         cUSJDJ7b2AZLQJCw4T2EwznPWbT0esV5ONj6njbS/+oODe5CtkIvmoQDYgR/27pS12
         M37na7QEV1qHMAkb++L+0/+k0QsS1QKJHwlSJGWw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131547eucas1p117ca36a8d41704af1b16d1b46b5efa8e~L1ZqrC7Nm0139001390eucas1p1O;
        Tue, 16 Aug 2022 13:15:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.C7.10067.3889BF26; Tue, 16
        Aug 2022 14:15:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131547eucas1p1b38862475577332351efe91e5428e295~L1ZqCucnG0139001390eucas1p1N;
        Tue, 16 Aug 2022 13:15:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816131547eusmtrp1e5ef2ac3da3c85514713642b4ff8e425~L1ZqBB7Ss0149801498eusmtrp1M;
        Tue, 16 Aug 2022 13:15:47 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-24-62fb9883d59f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.B0.09095.3889BF26; Tue, 16
        Aug 2022 14:15:47 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131546eusmtip1b8b1d7f74048b66552e093a2a310cee5~L1ZpvD_qw2676726767eusmtip1X;
        Tue, 16 Aug 2022 13:15:46 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v11 09/13] dm-zone: use generic helpers to calculate offset
 from zone start
Date:   Tue, 16 Aug 2022 15:15:32 +0200
Message-Id: <20220816131536.189406-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djP87rNM34nGWz9qGux/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2PZ
        4W/MBR3cFVffKzUw9nJ2MXJySAiYSOx6O425i5GLQ0hgBaPE2dYrTBDOF0aJl82dbBDOZ0aJ
        jqWvWWFaJk2/zwxiCwksZ5TYt9gWougFo8Tuk89Yuhg5ONgEtCQaO9lBakQE0iWmtLxkAalh
        FrjDJHHq3VZ2kBphgViJhvM5IDUsAqoS65dfZwMJ8wpYSzS+yYRYJS8x89J3sDGcQOF/DatY
        QGxeAUGJkzOfgNnMQDXNW2eDfSAhsJ1T4mzXN6g7XSQO/2hng7CFJV4d38IOYctInJ7cwwJh
        V0s8vfEbqrmFUaJ/53qwIySAtvWdyQExmQU0Jdbv0ocod5Ro+beeCaKCT+LGW0GIE/gkJm2b
        zgwR5pXoaBOCqFaS2PnzCdRSCYnLTXOglnpI/Nz3k2UCo+IsJM/MQvLMLIS9CxiZVzGKp5YW
        56anFhvlpZbrFSfmFpfmpesl5+duYgSmwtP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeAVf/EgS
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwKS9Y+63vykP
        90lP/S1590rZvydljy88em6Qsjuq1cSiQsjNxPuB4/MSHfPLu9mbVq88Z60Y8tlXW0ROVXt1
        /O4t3v/q9bvXhk734Pc7fNj35owcPe1P+tstD/xU97e+G2xStXV6p1bYvIgpy+UCNSVvbZxS
        5bd4eeLjjcE9Hf/22h9WY+t63aBm2HfXufjVsUNr74nbbErcqv7yj80Zg6rcM5+22aX8LG2P
        82PhlFv8JVltvs20w+fWVmpZ3Jj6o0BZdPeJeJP4lpb5nM/cdr/wE/f9+Wf2z5s3uG62rK0/
        6e8jlNtwf1WnBrcl8zzZXwk2H0RuWZlNTa6cYC9RF1NYGcPcGTBzqcGGyJ62N0osxRmJhlrM
        RcWJAKO7wC/0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7rNM34nGVy7xWGx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PZ4W/MBR3cFVffKzUw9nJ2MXJy
        SAiYSEyafp+5i5GLQ0hgKaPE0S2tLBAJCYnbC5sYIWxhiT/Xutggip4xSuxZNBuog4ODTUBL
        orGTHaRGRCBXYtGyDlaQGmaBN0wSH+Z/YgJJCAtES7zafh1sEIuAqsT65dfZQHp5BawlGt9k
        QsyXl5h56TvYHE6g8L+GVWA3CAlYSbQdu8wMYvMKCEqcnPkELM4MVN+8dTbzBEaBWUhSs5Ck
        FjAyrWIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM3G3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVE
        eAVf/EgS4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5Hxg6sgriTc0MzA1NDGzNDC1NDNWEuf1
        LOhIFBJITyxJzU5NLUgtgulj4uCUamBaUyflGGLNmJvIsPwMlxqPmajmL2ZfJpm8U2W+Z5Ou
        vFnYfjFFuCKOXeyT5cKJSwsi7SJ5d26+HaAsMaPD3cTzZ+uv/QEv6+aKG70MnXihiqHvUMgn
        o0495Xe7t387vXdTkm3O630T17X9ElqqodW/TM3rhLuBpPJmSaHsO++vczR/Z1PONuN6dDT6
        csqDG+dtlYsfvL9+4xRvyFvn6IQrnmbHRe8LXvu237zv4NQHn73S9ycbsz41tvB+557/8F3+
        pIXhn2e7BHHM0ecWK1rN9OV65bXbJ2v8dX4s1/v64r3PluCt9s9WW/BcDLihKM/083y2xJTL
        cz8c9915Y12NyPb/lrPnzeP/Uubm9u68EktxRqKhFnNRcSIA2wH34GUDAAA=
X-CMS-MailID: 20220816131547eucas1p1b38862475577332351efe91e5428e295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131547eucas1p1b38862475577332351efe91e5428e295
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131547eucas1p1b38862475577332351efe91e5428e295
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131547eucas1p1b38862475577332351efe91e5428e295@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the bdev_offset_from_zone_start() helper function to calculate
the offset from zone start instead of using power of 2 based
calculation.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-zone.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3dafc0e8b7a9..ac6fc1293d41 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -390,7 +390,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 		/* Writes must be aligned to the zone write pointer */
-		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
+		if (bdev_offset_from_zone_start(md->disk->part0,
+						clone->bi_iter.bi_sector) != zwp_offset)
 			return false;
 		break;
 	case REQ_OP_ZONE_APPEND:
@@ -602,11 +603,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
 		 */
 		if (clone->bi_status == BLK_STS_OK &&
 		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
-			sector_t mask =
-				(sector_t)bdev_zone_sectors(disk->part0) - 1;
-
 			orig_bio->bi_iter.bi_sector +=
-				clone->bi_iter.bi_sector & mask;
+				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
 		}
 
 		return;
-- 
2.25.1

