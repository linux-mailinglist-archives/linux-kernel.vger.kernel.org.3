Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016FB58FE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiHKObu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiHKObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:31:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAA753AF
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:31:00 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143058euoutp01973f0324890e2ce5aa391aa0495ce709~KUM4jCQJO2619026190euoutp01K
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143058euoutp01973f0324890e2ce5aa391aa0495ce709~KUM4jCQJO2619026190euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228258;
        bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0TPeXeHN8PTA6FW37forHrG7f7AlOGS2BK+2YljPf368nKoRR47TKOqKx1sLC6XT
         tQZwyp0+mut6LQ/Z0lsoLsoY+C0HNO0lcxW3EhYM+y3JLJXsCymHLD6UX8TBpOhDTT
         e6NFKooLtRO6MrVhguJXD+YPYXbQd7jn3ROqIv+I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143057eucas1p216223c029efa1998ccb79a46fc64c3c3~KUM3Cf9rH1006010060eucas1p2E;
        Thu, 11 Aug 2022 14:30:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F9.EF.10067.1A215F26; Thu, 11
        Aug 2022 15:30:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220811143056eucas1p13136f35c6f0c7c2717b68a63c8d4c7c6~KUM2k0vmR0222302223eucas1p1m;
        Thu, 11 Aug 2022 14:30:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220811143056eusmtrp18ae8a15c69fb595a999ace9730c8135c~KUM2jz95k2320623206eusmtrp1u;
        Thu, 11 Aug 2022 14:30:56 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-62-62f512a18632
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.10.09038.0A215F26; Thu, 11
        Aug 2022 15:30:56 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143056eusmtip2b4d22c9e91ac86e932b862deddd8d3aa~KUM2NjP9e1283212832eusmtip2E;
        Thu, 11 Aug 2022 14:30:56 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Thu, 11 Aug 2022 16:30:41 +0200
Message-Id: <20220811143043.126029-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87oLhb4mGXybwW+x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGWsPK9a8Ja3
        YtafXvYGxqXcXYycHBICJhKt5/+zdzFycQgJrGCUmHb1KzOE84VR4l1zL1TmM6PE1q8nWGBa
        tkxqZ4FILGeUWHzxMhtIQkjgBaNEx2KrLkYODjYBLYnGTnaQsIhAusT6BcvBepkFtjFJbHkg
        DGILC6RKPP4+nRnEZhFQlVhyqIcJxOYVsJa4MvUhI8QueYmZl76DzeEEik9YdBGqRlDi5Mwn
        UDPlJZq3zmaGqF/NKfFxgz2E7SJx/PElNghbWOLV8S3sELaMxOnJPVC/VEs8vfEb7GMJgRZG
        if6d69lA7pcAWtZ3JgfEZBbQlFi/Sx+i3FHi7rp7UBV8EjfeCkJcwCcxaRvIJyBhXomONiGI
        aiWJnT+fQC2VkLjcNIcFosRD4tKk+AmMirOQvDILySuzENYuYGRexSieWlqcm55abJSXWq5X
        nJhbXJqXrpecn7uJEZj+Tv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhLVv0OUmINyWxsiq1KD++
        qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDU9bbD4xZf6/8vZa7VE5+iYOh
        2Jkb6Q+/7X7/6WTR8ZKFajkvWrOifP35uZ3WmWzcufNEepnjI3XmwwLVPN+eLAhve2zLLLJ4
        w/L4rec+BzKtlnsQ/fhj0FtL327x+slm4oILlu7l2LviYg//qtm50b5a/N+P6tk/mHH/Syyn
        s9x8+39SrVt+NsvdYi1uS1BbvWRnX//Mi8cjfn9mf5Ecf+o1s2fegcDtCiKuASe3RTDbGZ9t
        Pnz43c8SX1MtNbM5uhI8IbtzeLf33Fzbfvyo5pGODbP0n3MltLz9r3G4Z0HreptnrJKCX7b6
        zS204cqL+vBP+qH3549zZ27N3nbqSG/ChshZxQfa/7vFJc1/LanEUpyRaKjFXFScCABEtkMJ
        7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7oLhL4mGfS+0bRYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWnlcteMtbMetPL3sD41LuLkZODgkBE4kt
        k9pZuhi5OIQEljJKdB9fxASRkJC4vbCJEcIWlvhzrYsNougZo0Tz8X9ARRwcbAJaEo2d7CCm
        iECuxMEjgSAlzAJHmCSa3+5iAekVFkiWmHbrEjOIzSKgKrHkUA/YfF4Ba4krUx9CzZeXmHnp
        OzuIzQkUn7DoIliNkICVxISOY+wQ9YISJ2c+AZvJDFTfvHU28wRGgVlIUrOQpBYwMq1iFEkt
        Lc5Nzy020itOzC0uzUvXS87P3cQIjNdtx35u2cG48tVHvUOMTByMhxglOJiVRHjLFn1OEuJN
        SaysSi3Kjy8qzUktPsRoCnT3RGYp0eR8YMLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8s
        Sc1OTS1ILYLpY+LglGpgUlRhj1zRU7JO80QRX07u/XMbPxTXHZdZNCF9w8pnn2WNo1YqWcrH
        fza4JCfQ+Y7t8pXuII+ARd37j03sFP3wTTngmtgcqWcmEQpivYcFZoeH7d3xdsFR44QUc4mn
        Ql32tX8Oer+70vXYiH+xYTc/h/qu2RyTjkUdTu7JPsd/NaPyRdPiEo8mUeafJ4/tDnn2wHna
        ZpEYF9edsb1/NumaabFJfFXUCmV0Xvpl4uFT819PD3rvaDyhJ6jvxTSx37OuXmsqV6rdbCq7
        0UzPTNd0oc5fnkbPyEO3m39ytny3WtNfv01x3SyTP64B5nWna6ecTuhk3KC/U3lLWEZro9zH
        KRKfXuxbovV9QnZt8vy1SizFGYmGWsxFxYkARy5Ry2ADAAA=
X-CMS-MailID: 20220811143056eucas1p13136f35c6f0c7c2717b68a63c8d4c7c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143056eucas1p13136f35c6f0c7c2717b68a63c8d4c7c6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143056eucas1p13136f35c6f0c7c2717b68a63c8d4c7c6
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143056eucas1p13136f35c6f0c7c2717b68a63c8d4c7c6@eucas1p1.samsung.com>
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

