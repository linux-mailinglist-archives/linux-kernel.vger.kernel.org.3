Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B759E6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiHWQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244473AbiHWQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:16:17 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93932E0AA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:37:44 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121913euoutp0290e796a9e725b608a9da9953683316c2~N_JREu5MZ2224522245euoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220823121913euoutp0290e796a9e725b608a9da9953683316c2~N_JREu5MZ2224522245euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257153;
        bh=tSSBnG0aDQsGLDWCBqD+ZIZXJV/OR5HHGZmAzSOHsrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRBcRdkMzCkdVW8n6VARvkwBx44WtiAd6g0dr8nBBnoM4rURt630eqwWlBIiyNbOX
         OOjLhOueuxlgBkoj8+bK3YDjwAxJ1RUtmaVvCoAGhl9RBeEbLqOFn3MaCF+3XGFpAe
         lGzbkC7/7EuZEPGJWfJ5ejM+dvuL+4OBwfCIbrt8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121910eucas1p206e6e5c5cbb03ac40a9e7b55978a31a9~N_JOrpiCL1807618076eucas1p2G;
        Tue, 23 Aug 2022 12:19:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DE.82.29727.EB5C4036; Tue, 23
        Aug 2022 13:19:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf~N_JN-u-W01882018820eucas1p1U;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220823121909eusmtrp150c510413ffc810768faee3cc512696f~N_JN_6pIf1042010420eusmtrp1H;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-8f-6304c5bede52
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.81.10862.DB5C4036; Tue, 23
        Aug 2022 13:19:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121909eusmtip100fdaff39bbf167292206c172f54e8a0~N_JNsdKjr0901809018eusmtip1I;
        Tue, 23 Aug 2022 12:19:09 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Tue, 23 Aug 2022 14:18:54 +0200
Message-Id: <20220823121859.163903-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djP87r7jrIkG9w5qGSx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2Ne
        u0TBPJ6KOQ1fWRoYW7i6GDk5JARMJBpu7GDrYuTiEBJYwSjx+cAvVgjnC6PE5RcP2CGcz4wS
        FxYfYYRpWbHqHSNEYjmjRNeu5cwQzgtGidbO60AOBwebgJZEYyc7SIOIQLrE168bwBqYBe4w
        Sfzcs5AFJCEsECKx8v8dNhCbRUBV4s/26WAbeAWsJD5u7GeC2CYvMfPSd7BBnALWEvOWnoKq
        EZQ4OfMJ2BxmoJrmrbPBjpAQ2M4p8XLfZDaIZheJ3msfoWxhiVfHt7BD2DISpyf3sEDY1RJP
        b/yGam5hlOjfuZ4N5AMJoG19Z3JATGYBTYn1u/Qhyh0l3q86xAJRwSdx460gxAl8EpO2TWeG
        CPNKdLQJQVQrSez8+QRqqYTE5aY5UEs9JFbMfc46gVFxFpJnZiF5ZhbC3gWMzKsYxVNLi3PT
        U4sN81LL9YoTc4tL89L1kvNzNzECE+Lpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrzVFxmShXhT
        EiurUovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTAlXnLYzcA+W8E1
        4evBDaxMSrv2PAsUeZxZ8fvL3yfGIRc6k1WLZfYsd+WcrD+hco335qrf5c+3Cycvr6xo0/hh
        tWXPlE+F4fMys1+YTxPuFO9TPDu1SPR4RzDDKUfDFI/MWfIVGanvqyomSArV2vZYVQssOLH7
        1xbFxtvcOav8laPezaw/E/fyu7MN/wrmqWpbX3x3U40yKuxYPfcgv0nAxol33I5/v2Lctzxk
        yskkCTHXIGuda1w3ZGS5k/51dXfuLv90utlga8HHH/mnIz8rzmareM3+RPtkzP8HGx6yHXc3
        enzX1jM5Z/cHkzdWnFuOpxkVP+50uGUXqRujzmls81RI48fSGmHr67yrDiixFGckGmoxFxUn
        AgCYPxRE9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7p7j7IkGzz/a2ax/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Neu0TBPJ6KOQ1fWRoYW7i6GDk5
        JARMJFasesfYxcjFISSwlFHi2+UPrBAJCYnbC5sYIWxhiT/Xutggip4xStx6uZK5i5GDg01A
        S6Kxkx2kRkQgV+Lw5glMIDXMAm+YJC5PP8cCkhAWCJJoufMUbCiLgKrEn+3TwYbyClhJfNzY
        zwSxQF5i5qXvYIM4Bawl5i09BVYjBFQz/9YnNoh6QYmTM5+AzWQGqm/eOpt5AqPALCSpWUhS
        CxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG7rZjP7fsYFz56qPeIUYmDsZDjBIczEoi
        vNUXGZKFeFMSK6tSi/Lji0pzUosPMZoC3T2RWUo0OR+YPPJK4g3NDEwNTcwsDUwtzYyVxHk9
        CzoShQTSE0tSs1NTC1KLYPqYODilGpiE5fziTq3lK96pmJv7QO//uS8JS4+ked890X65eaXO
        H7Pr6z4sMZJvzlJdO9fN+xDHleIujuaT2qE6Zw+7H91bE7T93tJfpY/mXDoV9rHw77xdut95
        HE4fjrBv+/z96ybp1rW6q/wOfGo9H5rcvOt8hczb/Jm2B8+ZMU+X1Ur3fBbCEx0+9waj3eNc
        sS/G0+cpTDH+czBo9+bVP8WKD3BFrJgmuHej8JOyuXOfzHOtXbe9b8Fuffd/ntfO6SeFtvJE
        lDPf3H9f8q4du7PCnuqQ7dbV0Q6b5C29TlpfMWVIkou+5HAxtlNj3vuO1Y0zdtbUhJyp43zj
        4dF7bdfEhlJxt45ZW34WX3785frnV5x6SizFGYmGWsxFxYkA7sABNWYDAAA=
X-CMS-MailID: 20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121909eucas1p113c0c29f7e28d0ee3e1161f7da243baf@eucas1p1.samsung.com>
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

From: Luis Chamberlain <mcgrof@kernel.org>

dm-zoned relies on the assumption that the zone size is a
power-of-2(po2) and the zone capacity is same as the zone size.

Ensure only po2 devices can be used as dm-zoned target until a native
support for zoned devices with non-po2 zone size is added.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 95b132b52f33..9325bf5dee81 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = bdev_zone_sectors(bdev);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size is not a power-of-2 number of sectors";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones = bdev_nr_zones(bdev);
 		}
@@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 			return -EINVAL;
 		}
 		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size is not a power-of-2 number of sectors";
+			return -EINVAL;
+		}
 		zoned_dev->nr_zones = bdev_nr_zones(bdev);
 	}
 
-- 
2.25.1

