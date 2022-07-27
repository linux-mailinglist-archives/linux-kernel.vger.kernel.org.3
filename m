Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FC582AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiG0QZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiG0QYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:24:22 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55ED4E628
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:23:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162258euoutp02684575ac95d97323523b3f75cff87e44~FvDZCPxse0990709907euoutp02P
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220727162258euoutp02684575ac95d97323523b3f75cff87e44~FvDZCPxse0990709907euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658938979;
        bh=o0r9RyB9vOAXtqPhFs52TIGpjJ3od4KdTmNo2ZjXDoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCY2nrqvSVZvShtnBpRlxL1Eo1eK9cSI+xvAlVfHEklBFny/jMs45GlcoHB+CWcQw
         ziQ6LTNWkma0byf9IApZ5gETGKysjfj8scQz5KXukJAdiEqxlt1gT94X16g1wggIvs
         03Yk42m3gTZtqt5ghS0/Li5GJYWTwZqrOhTcBeBs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220727162257eucas1p2ba22d6ac666789dc7c83c0c09c8dd771~FvDXYuC2n0838408384eucas1p2E;
        Wed, 27 Jul 2022 16:22:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E9.E8.09580.16661E26; Wed, 27
        Jul 2022 17:22:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd~FvDXATaOk2238722387eucas1p2n;
        Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220727162256eusmtrp23d991b641b5e5403010138b48180dea3~FvDW-f_cM0811608116eusmtrp20;
        Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-ed-62e166617204
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.1E.09095.06661E26; Wed, 27
        Jul 2022 17:22:56 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220727162256eusmtip1be6834eb505d89c9e19b839ab128d9cd~FvDWoSEpk0050700507eusmtip1i;
        Wed, 27 Jul 2022 16:22:56 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        bvanassche@acm.org, jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v8 10/11] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Wed, 27 Jul 2022 18:22:44 +0200
Message-Id: <20220727162245.209794-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7qJaQ+TDH6f4bRYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
        6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPFJdNSmpOZllqkb5dAlfGqWc/mAo2c1V8v7GZ
        qYHxAEcXIyeHhICJxO/jk1i7GLk4hARWMErc6TnKBOF8YZToWdXNClIlJPCZUWJJkx9Mx/Zz
        j6CKljNKPJv0iRmi6DmjxMQ3wl2MHBxsAloSjZ3sIGERgWKJh+9aWUDqmQVmMUmcPvaYGaRG
        WCBF4kOnE0gNi4CqxI9595hAbF4Ba4nDP9+wQeySl5h56TvYHE6g+OYp86BqBCVOznzCAmIz
        A9U0b53NDDJfQmA5p8TbD//ZQeZLCLhIfD0jDjFHWOLV8S3sELaMxP+d85kg7GqJpzd+Q/W2
        MEr071zPBtFrLdF3JgfEZBbQlFi/Sx+i3FHiyKMJUBV8EjfeCkJcwCcxadt0Zogwr0RHmxBE
        tZLEzp9PoJZKSFxumsMCYXtIvDh3nHECo+IsJL/MQvLLLIS9CxiZVzGKp5YW56anFhvnpZbr
        FSfmFpfmpesl5+duYgSmvdP/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeBOi7ycJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYDJ7Xcc+O+ecdfDsz3v5qkVu
        mfmcvHH90Cc9MQfhI+H7euT4P3sIqi0uycmOm5mo/rjpwE++z/72+u4MAukfTi27ZZfpFlQ/
        VyfQkmk5p5l2s7mk9u4P4qt6P0opHzIw5DRe1nwjccEPtu9ZVkr6gov+5xsGbfAoXrtDp3re
        o2kFWuvfGEVtzvUzctYRSZXPtDv/TeXhqaQK51URTpFVR3gVtxl2nfez+mRuM/2iuRFH4OZX
        5mLbtkn9XHreocJ4Xu+qA7qGV3OWbNVYO2W2mumZSNYd5Sf6rh7gFuJ+WZv1Tsn79+RXk5V2
        uNR2ef/6xL73z5aYpNnu16awWhW+Wbrd4M5VkYjk9euXRdyrVmIpzkg01GIuKk4EAOeaQyvq
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7oJaQ+TDL5t0LBYfbefzWLah5/M
        Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
        oe0rs8XnpS3sFmtuPmWxOHFL2kHA4/IVb4+ds+6ye1w+W+qxaVUnm8fmJfUeu282sHnsbL3P
        6vF+31U2j74tqxg9Np+u9vi8Sc6j/UA3UwBPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
        nqGxeayVkamSvp1NSmpOZllqkb5dgl7GqWc/mAo2c1V8v7GZqYHxAEcXIyeHhICJxPZzj5i6
        GLk4hASWMkosnr2GDSIhIXF7YRMjhC0s8edaFxtE0VNGiTvbZzN3MXJwsAloSTR2soOYIgKV
        Eme/yIKUMwssY5LYcEIGxBYWSJK4++wbC4jNIqAq8WPePSYQm1fAWuLwzzdQq+QlZl76zg5i
        cwLFN0+ZB1YjJGAl8ezBRzaIekGJkzOfsEDMl5do3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem
        5xYb6hUn5haX5qXrJefnbmIERum2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrwJ0feThHhTEiur
        Uovy44tKc1KLDzGaAt09kVlKNDkfmCbySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNT
        UwtSi2D6mDg4pRqYZKbt4p879bvdx3Ct3saNzj7d6WVmr7f3/lVgFKxskTa8d9DxQWn0ph6G
        GczNNbZN6tN9K52inc1Moz8ePbfIPndaye6qTyt0rPbkSiy426n47cXrxODeEplT5pwpOpcN
        9xVXCl0Rkctzeb3FrU/VZ9oahpZwvu/HhBe3CrNslHos6Gl1Mo/FbP08273HZcVrnoefP608
        fZNpxfToG0tunL7d/mrXx1mJWV8iNSc38m054XrRrvl6weKynwbpqnc3svy6O1HlrXC63q+4
        pdzWyy54zH+16eIEe1uftZmi+mqmb98c1VKouJY+WfcY/37tqTtsPBIdrvqd4f5qUyl0ubQr
        250xdcNb1eTQDmYlluKMREMt5qLiRABGGKl5WwMAAA==
X-CMS-MailID: 20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd
References: <20220727162245.209794-1-p.raghav@samsung.com>
        <CGME20220727162256eucas1p284a15532173cce3eca46eee0cee3acdd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore. Call dm_zone_endio for zoned devices
after calling the target's endio function

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 03ac6143b8aa..bc410ee04004 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1123,10 +1123,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1155,6 +1151,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev)))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1

