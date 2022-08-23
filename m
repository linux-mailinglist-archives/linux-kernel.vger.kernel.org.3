Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B799259E6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiHWQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbiHWQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:16:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C87D32E0A9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:37:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121915euoutp02d37123ee3f7590398cd7744ac5e750c6~N_JTP5pDf2224522245euoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121915euoutp02d37123ee3f7590398cd7744ac5e750c6~N_JTP5pDf2224522245euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257155;
        bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=he7UqnDU9WnUYjCJqX8Ht6sOECnGmtJaHW0VGZ1GlvcSk/i1k2t7LcOcA0LzGOo9s
         +CIPt7KjlDi/JF+TlW2Dlw/2y4+JAzv5/r98Udil53qwryirm3A7zqQi4NI2pykCby
         b5QnUJZE5BA6/m269SKu5CT950v5THWkRFpSJQxQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121913eucas1p2eb1edd7de7137d0b34853710351f9f4c~N_JRejali2219222192eucas1p2h;
        Tue, 23 Aug 2022 12:19:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.81.07817.1C5C4036; Tue, 23
        Aug 2022 13:19:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823121913eucas1p11c222f4c57a0132117bb9712e6018668~N_JQ9NkT_1881118811eucas1p1R;
        Tue, 23 Aug 2022 12:19:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121913eusmtrp224744fd36dea937628196c9b7c2a8349~N_JQ8O2XS2723427234eusmtrp2o;
        Tue, 23 Aug 2022 12:19:13 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-75-6304c5c1b5e9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.12.07473.0C5C4036; Tue, 23
        Aug 2022 13:19:13 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121912eusmtip29cb6f4238c390ed138f6b55e52d4b6a0~N_JQopUMk2346623466eusmtip2H;
        Tue, 23 Aug 2022 12:19:12 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Tue, 23 Aug 2022 14:18:57 +0200
Message-Id: <20220823121859.163903-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djPc7oHj7IkGyy8om6x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPK9a8Ja3
        YtafXvYGxqXcXYycHBICJhLNV4+wdDFycQgJrGCUuD5pFTuE84VRYvms1UwQzmdGiQvPVjLD
        tNzYtp4VIrGcUeLYk06olheMEvNfTAZyODjYBLQkGkHinBwiAukSX79uYASpYRbYxiTx6+4l
        FpCEsECqxPHO3awg9SwCqhKLVmiDhHkFrCUm7n7EArFMXmLmpe9gcziB4vOWnmKEqBGUODnz
        CVgNM1BN89bZzCDzJQTWc0pc2tXLDtHsIvHt93yoq4UlXh3fAhWXkfi/cz4ThF0t8fTGb6jm
        FkaJ/p3r2UAOkgDa1ncmB8RkFtCUWL9LH6LcUeLB4tusEBV8EjfeCkKcwCcxadt0Zogwr0RH
        mxBEtZLEzp9PoJZKSFxumgP1lYfE4vZljBMYFWcheWYWkmdmIexdwMi8ilE8tbQ4Nz212Cgv
        tVyvODG3uDQvXS85P3cTIzAJnv53/MsOxuWvPuodYmTiYDzEKMHBrCTCW32RIVmINyWxsiq1
        KD++qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDU+fr17ZFHkJTHAyM/GOm
        npk+z+ynE7/x5FifZ19mJieWbP9f2yIwI3Wh0SOebbMOH+OP/sHHcKVmwbFr/blTDrw9WJ/w
        pfefs4meeVP18mhnd5U3p//6PSvYqNWdVTultnZ5k92u6LKDDvyKOvd3rCpp0Xhww+3Hn4JJ
        6Uq5qy/siM3WL3ua/lNIcN/rS0dcWxI3xH+YcuWw4tsYkV9iCnMM/Y4WLVSpuN9kKWddk7G9
        TOCvNk/H9INHdxZcTVxQnaB36tHKN2fcbz2oWn8uxItB2HGH+fe7lxYVqJ+pS95VP71nl3tb
        rOCfTWwbt694EcVXFneq9nr2kasFHTYXj8TJpTza2RGSctjqp/+K90osxRmJhlrMRcWJACdk
        bZrxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oHj7IkGzzuZrZYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWnlcteMtbMetPL3sD41LuLkZODgkBE4kb
        29azdjFycQgJLGWUmDf3ADNEQkLi9sImRghbWOLPtS42iKJnjBILJrxj6WLk4GAT0JJo7GQH
        qRERyJU4vHkCE0gNs8ARJonVjWtZQWqEBZIlJt5hBzFZBFQlFq3QBinnFbCWmLj7EQvEeHmJ
        mZe+g43hBIrPW3oKbK2QgJXE/Fuf2CDqBSVOznwCVs8MVN+8dTbzBEaBWUhSs5CkFjAyrWIU
        SS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM1m3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeKsvMiQL
        8aYkVlalFuXHF5XmpBYfYjQFOnsis5Rocj4wXeSVxBuaGZgamphZGphamhkrifN6FnQkCgmk
        J5akZqemFqQWwfQxcXBKNTBNzWdS19w9eYGLcUzK7Gr7OweVdN4usbt+RGbeiWV2uXdPfda7
        E3HPYevM6bX8Tyq/t1UZdCjem7/wquXjNYdWmK4407FV8kz9p+4P+Y0pjFpvV5cfbVjxfW3b
        SZOLbQcW6L1Lr1FkcTswP/LqtMPsC2pKrp0ye55/xJZ3cmYq40cN8fllXeLJLFtX6YUffnrW
        TY+rjf2D8KO3wcsyW15P8lv6LdBVpm16cUNkbOLf44HMt+0NMzin/IjuLrc/cDs1J+mryHc2
        nQvLWGSENUPaS9fUVNu39+lFNF56mMjcFVFXp7MusPe7hbzHvImLUvLzlp/4zVcQrxhy5dGz
        CnMv0ROBiaEHD03V+s22dooSS3FGoqEWc1FxIgCmqqSRXwMAAA==
X-CMS-MailID: 20220823121913eucas1p11c222f4c57a0132117bb9712e6018668
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121913eucas1p11c222f4c57a0132117bb9712e6018668
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121913eucas1p11c222f4c57a0132117bb9712e6018668
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121913eucas1p11c222f4c57a0132117bb9712e6018668@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation, and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore.

Currently, this is not a problem as the targets that support zoned devices
such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
and even if they do (such as dm-flakey), they don't modify the
bio->bi_iter.bi_sector of the cloned bio that is used to update the
orig_bio's bi_sector in dm_zone_endio function.

This is a prep patch for the new dm-po2zone target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 60549b65c799..58b392c51d04 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1122,10 +1122,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1154,6 +1150,10 @@ static void clone_endio(struct bio *bio)
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

