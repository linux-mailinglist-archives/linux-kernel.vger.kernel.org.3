Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27A5889CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiHCJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiHCJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:48:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD30043322
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:48:17 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094816euoutp01208785f30c009e24e7321996a34a83fd~HzLwuM3jI3139831398euoutp01Q
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:48:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094816euoutp01208785f30c009e24e7321996a34a83fd~HzLwuM3jI3139831398euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659520096;
        bh=lA4ACIhgPS1mwgZjIDSka7RcIpNQB3Ybt1avCcUQ/Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cb7tKxxadHNXkycJOuwBdAOSgjp02cXRJc856j5eOSXlHEgzQT7DyUPR0aJ1lLMg9
         Xxro3Dje+CtTQ8CDHH2cEAfTqmvzxXSpoE/mYOXhSBunJhLUHDtT5CsHXOd27s1o+K
         QfnagQ3obYJZWnA44z0y5SNdfysFdVWf0enhizDU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220803094814eucas1p26e088e4d1902813c1d06ef0dd994f407~HzLvOmBkY2470524705eucas1p2x;
        Wed,  3 Aug 2022 09:48:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.FF.09664.E544AE26; Wed,  3
        Aug 2022 10:48:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220803094814eucas1p2789149466d095cc16710ee09a380cbdb~HzLuz7QyB1531915319eucas1p2L;
        Wed,  3 Aug 2022 09:48:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220803094814eusmtrp1addc32d50c84a58b17d01be64653b93c~HzLuy7eRs2000320003eusmtrp1m;
        Wed,  3 Aug 2022 09:48:14 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-9f-62ea445e1e5a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.9B.09038.E544AE26; Wed,  3
        Aug 2022 10:48:14 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220803094813eusmtip148af0e15644aab588a871f6c749a8ca7~HzLudRlMc2554125541eusmtip1o;
        Wed,  3 Aug 2022 09:48:13 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v9 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date:   Wed,  3 Aug 2022 11:47:59 +0200
Message-Id: <20220803094801.177490-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7pxLq+SDNY8UrdYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAniiuGxSUnMyy1KL9O0SuDJWnlcteMtb
        MetPL3sD41LuLkZODgkBE4mDL2cwdzFycQgJrGCU2PD1NhuE84VRYt3O4+wQzmdGida7k1lh
        WtovPmGCSCxnlJi//h4LhPOSUaLx1EWgfg4ONgEticZOsG4RgWZGibt/e1hBHGaBGUwSHR/7
        WEBGCQukSLy/PA3MZhFQlZh24yMjiM0rYC1xb+JPZoh18hIzL31nB7E5geJT/v1jhqgRlDg5
        8wlYLzNQTfPW2WBfSAis55R4umMSO0Szi0Tb231sELawxKvjW6DiMhKnJ/ewQNjVEk9v/IZq
        bmGU6N+5HuwFCaBtfWdyQExmAU2J9bv0IcodJdbfeM4IUcEnceOtIMQJfBKTtk1nhgjzSnS0
        CUFUK0ns/PkEaqmExOWmOVBLPSRWv5vCMoFRcRaSZ2YheWYWwt4FjMyrGMVTS4tz01OLDfNS
        y/WKE3OLS/PS9ZLzczcxAhPh6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8d1yeJwnxpiRWVqUW
        5ccXleakFh9ilOZgURLnTc7ckCgkkJ5YkpqdmlqQWgSTZeLglGpgsn/3daHVR1/GBzL/l+8q
        SNh/9qH8XaNlF1x+//FczeWvsjxx/xpd+7WrL0ozVDbNvmARr1Fjx8a7a8/SR4ozfy+JsuWc
        nfHjb0/M1Bu5D6pjLbpresrmdOrH7N6yW3r6AjOOyQ99L95vFOndn3HP3DBg84MGHo3XppYP
        Kl1Pfau8p1iwwZqtXkRXjv3h7QZ/54fT7giaLebgbZ+WIf44ZNJJ5/+Xw+f3awlP85n9q3r9
        +stlbMXcfw35vhx6effEPuEE0xgRoYdLglJyV+69lBGafdjw+u/GZ0rnU7cm3P/G3BPisUSO
        cf2Bk2VdkSp73kZdn8GSkKdQIv920VfLqgD16Ky8t2cWCKhuST99QImlOCPRUIu5qDgRAJtX
        NWXzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xu7pxLq+SDKas57BYf+oYs8Xqu/1s
        FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
        f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
        zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
        LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWnlcteMtbMetPL3sD41LuLkZODgkBE4n2
        i0+Yuhi5OIQEljJKtE0/xAaRkJC4vbCJEcIWlvhzrYsNoug5o8SdpyeAEhwcbAJaEo2d7CBx
        EYFuRonLZ86xgjjMAsuYJJq+XAebJCyQJHHsykFWEJtFQFVi2o2PYFN5Bawl7k38yQyxQV5i
        5qXv7CA2J1B8yr9/YHEhASuJdX9nsULUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYx
        iqSWFuem5xYb6RUn5haX5qXrJefnbmIExuy2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrx3XJ4n
        CfGmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MGnklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUwWViar29cW30op0pJn+/BunfmD0ykbxjc9mV8PWtm9R7e1y7T
        RM8u/y/PJiXzofPjduYbXTGd6xOX6N0TWOmcNklUa+8nF7uVvhKvFWam19poiCuvipmrbfBA
        IKLnypmVlzTTVhx4I5k4o2mv3Oy7b/rn289l/ndfR21lwL/iD1WyM6x6jG8c8H946/WyGW7x
        BbXLyvNmGU+bdYPHeTfTj50/XkT8j9NbfHtT3DRt2dNPjpZd0Vjg9vWTxvbc6M8PtuzYJ669
        RGR1g8bkufut1mRHxDJOVuz680iu6cC8FcvNLqf6+0x9GrC+c7a8vJHfRtvaPLvyf64Gsv51
        GVNXuugZGKzc5ZWlud4qaQcntxJLcUaioRZzUXEiAIcg50liAwAA
X-CMS-MailID: 20220803094814eucas1p2789149466d095cc16710ee09a380cbdb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094814eucas1p2789149466d095cc16710ee09a380cbdb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094814eucas1p2789149466d095cc16710ee09a380cbdb
References: <20220803094801.177490-1-p.raghav@samsung.com>
        <CGME20220803094814eucas1p2789149466d095cc16710ee09a380cbdb@eucas1p2.samsung.com>
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

