Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028A6595D14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiHPNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiHPNPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063055E66A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:53 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131551euoutp01410e1af0051d26ddbe244f37c42fe3e0~L1ZuVwX380146201462euoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131551euoutp01410e1af0051d26ddbe244f37c42fe3e0~L1ZuVwX380146201462euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655751;
        bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDH38K2GOpbfY5X1mZbPN66TF+MO4Q70j41XtLjvIForjppk7GPpF6aTfBLwqLmJ1
         IivBhqLpJIsDwa7NrIgmxiI1HDfVACr9zHnGCjgI0Mq3moj0cM7XfejZsSwPTA6bil
         L7rOZwyMMrJTNw/zXsJYG9CfVx2R1LJCdw3+y7Wc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131549eucas1p17fa1579e347d9cfeef06118a51426172~L1Zsdxeee0548905489eucas1p16;
        Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.75.09580.5889BF26; Tue, 16
        Aug 2022 14:15:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e~L1ZsCVUUl3098130981eucas1p2I;
        Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131549eusmtrp20ef0d99d7fedbc189849e7809c5d583a~L1ZsBcCrj0621306213eusmtrp2c;
        Tue, 16 Aug 2022 13:15:49 +0000 (GMT)
X-AuditID: cbfec7f5-1bfc7a800000256c-f5-62fb98856cc8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 06.31.09038.5889BF26; Tue, 16
        Aug 2022 14:15:49 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131548eusmtip1614be62435f7387e8d91eace6aacd19c~L1ZrtB0c12694326943eusmtip1D;
        Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Tue, 16 Aug 2022 15:15:34 +0200
Message-Id: <20220816131536.189406-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87qtM34nGcxer2ex/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPK9a8Ja3
        YtafXvYGxqXcXYycHBICJhIrvz9hAbGFBFYwSiw7ntbFyAVkf2GUmDfrGguE85lR4vDxbmaY
        jkU7NkB1LGeU2HIuE6LoBaNE/4pjrF2MHBxsAloSjZ3sIDUiAukSU1pegg1iFtjGJPHm0gRG
        kISwQKrEsYUnmUDqWQRUJSb2hICEeQWsJRq7FzJB7JKXmHnpO9gcTqD4v4ZVLBA1ghInZ0Jc
        zQxU07x1NjPIfAmB9ZwSd843QzW7SBw+8RDKFpZ4dXwLO4QtI/F/53yoeLXE0xu/oZpbgB7Y
        uZ4N5CAJoG19Z3JATGYBTYn1u/Qhyh0lup6dZISo4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKqV
        JHb+fAK1VELictMcFgjbQ+LwtLdMExgVZyF5ZhaSZ2Yh7F3AyLyKUTy1tDg3PbXYOC+1XK84
        Mbe4NC9dLzk/dxMjMAGe/nf86w7GFa8+6h1iZOJgPMQowcGsJMIr+OJHkhBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYmg43lYqWr/t/dsTW6jjG1TfG+
        bcTBlcabmQUuavncvPqomvuMnG6zuoz+49Wnzx57b/l286yri7wcxdR9/91RPWn3+EXJqsl5
        YpE5mg4XJRjV20tXcDgwzWD/ejUxaUtE94xviZl9l2d5mVzYtc1rV94U3oMaFR3/tDMXzK10
        VVh6Lmvutlt9DIdvXWxL+K7xW4T59c+pwvsXSu21uX/Fk+FhbMvM70vXf7S6fT5dvPb2EfF+
        3lrzt5bBFyY5/r3kPPf2a80lIqZS596fYHHQOv7WOL2tJCbaburkSzzlNk8r3f/ZNs6bFyi1
        7+f701tn7Jh2cv9+HnV7wTlzdP9NY5c9op2kpdT4V1d4uprRdCWW4oxEQy3mouJEAEubS8rv
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7qtM34nGcw9KGCx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsPK9a8Ja3YtafXvYGxqXcXYycHBICJhKL
        dmxg6WLk4hASWMoo8erPVFaIhITE7YVNjBC2sMSfa11sEEXPGCX+b1vP3MXIwcEmoCXR2MkO
        UiMikCuxaFkHK0gNs8ARJokF05czgySEBZIlWvYsAqtnEVCVmNgTAhLmFbCWaOxeyAQxX15i
        5qXvYHM4geL/GlaxgNhCAlYSbccuM0PUC0qcnPkELM4MVN+8dTbzBEaBWUhSs5CkFjAyrWIU
        SS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM123Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeAVf/EgS
        4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR5HxgwsgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJI
        TyxJzU5NLUgtgulj4uCUamDSEHjPfFm5rvvMA7+NM780TA/V+izLrL2eRXOj+JLNi5qu5+of
        fBxYrPX1iWjuntp5t5TjEuwPRE3VPVB9UXXKXOW3NzhNv/SwnFEWNhO5vP5X/dn1wqW5ZV8C
        kv59ePlQ/XwJY2KD93/1SQ1c1YXO3V8aug2Sk1h7wpbZT927p+33VoOaz4x758pNiSoMe/J6
        ZcXvdUHvzxaZy3Bf+RvdcWWVyoOgz128WzUl2MtmaV5heJK2eaF6AmtN0Q3zrUwipm4Xznzg
        b32ypMn/enqP8RvduZYrWzyP1sza6MUWWLDpzM17vLb3U7a6sYZacKxjnXB82+PkV2tUgvz4
        /WbMTd4SxcQzw7Ti9a7m/eZKLMUZiYZazEXFiQC25n6hYAMAAA==
X-CMS-MailID: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131549eucas1p2b7079d3222e2a3313c7bf19c712d6e0e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

