Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB4595D13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiHPNQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiHPNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:15:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44CC5A3E3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:15:49 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220816131548euoutp014a730e9b7458b737daf9908546893d11~L1ZrgmIJY0139901399euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:15:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220816131548euoutp014a730e9b7458b737daf9908546893d11~L1ZrgmIJY0139901399euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660655748;
        bh=tSSBnG0aDQsGLDWCBqD+ZIZXJV/OR5HHGZmAzSOHsrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjT6BcVWK/M/RWCJkvFVgEPS9WBA7XQd4IwGqlZTIslskr2TxhChMjBtUaUsG89d2
         YvCiuEAYzQ1CcjFvFD61i7k/HQZb0PjLKt06ZlEB9mZt1ZYUjNgX350FKoEsIRNr/F
         2Gv24/HW6SVWQxATyZN4RJAbhjcAn7bAmnt4W4rM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220816131546eucas1p1f3c231b04a31e7cc32176cfc05e83c72~L1ZphtR6j0141901419eucas1p1T;
        Tue, 16 Aug 2022 13:15:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.C7.10067.2889BF26; Tue, 16
        Aug 2022 14:15:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220816131546eucas1p190ff39f4a53b379b873ea83029370f4c~L1ZpI_Gr_0139801398eucas1p1V;
        Tue, 16 Aug 2022 13:15:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220816131546eusmtrp2d9086ae758fb09eea5925b027df021b1~L1ZpIK9aC0621306213eusmtrp2Q;
        Tue, 16 Aug 2022 13:15:46 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-1e-62fb98822633
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 03.31.09038.2889BF26; Tue, 16
        Aug 2022 14:15:46 +0100 (BST)
Received: from localhost (unknown [106.210.248.74]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816131545eusmtip2999fba249cde6ce2fe24d4c98362b6c3~L1Zox9x-f1650116501eusmtip2g;
        Tue, 16 Aug 2022 13:15:45 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v11 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Tue, 16 Aug 2022 15:15:31 +0200
Message-Id: <20220816131536.189406-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816131536.189406-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djPc7pNM34nGXz8oWKx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCeKyyYlNSezLLVI3y6BK2Ne
        u0TBPJ6KOQ1fWRoYW7i6GDk5JARMJK6vPsnUxcjFISSwglHi0+MvrBDOF0aJnXemMoFUCQl8
        ZpT4u0gXpmPpidPMEEXLGSV+Nn5ghSh6wSix4JVqFyMHB5uAlkRjJztIWEQgXWJKy0sWEJtZ
        4A6TROcHRRBbWCBEYu7l82BxFgFViW+LJoHZvAJWEteX/mOB2CUvMfPSd7A5nALWEv8aVkHV
        CEqcnPkEaqa8RPPW2WD3SAhs55T4sOoMG0Szi8T2j1uZIGxhiVfHt7BD2DIS/3fOh4pXSzy9
        8RuquYVRon/nejaQBySAtvWdyQExmQU0Jdbv0ocod5TYefkEK0QFn8SNt4IQJ/BJTNo2nRki
        zCvR0SYEUa0ksfPnE6ilEhKXm+ZAfeUhcf79a5YJjIqzkDwzC8kzsxD2LmBkXsUonlpanJue
        WmyUl1quV5yYW1yal66XnJ+7iRGYCk//O/5lB+PyVx/1DjEycTAeYpTgYFYS4RV88SNJiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA1P9lI/8ulsy7/6u
        ef9UaPPlz/2XTqzXu7aM7+6at7pbjgv+2Xygnml24LkHrz1MN5Rtfs4tf/Pmo0Zlx+ol9u9K
        L/kp1Zyu/OXNkGlwy++ZptEPtRWPdmz2riiQKp2aX2tYsuHKHKlFx/qPGz/raAi6p6IpeWX+
        8X8mP9qLV587vufmhg/lL67cdrqcZrY1dp4iD2f4HEHd8xmeq6bEMH6KtPXKWryWp9NS39bw
        o9V8gz0hTwXLpk1+6+3MJyV3Qelo6EptBSvrc8uYrdZ4yrPvP3lq9w55b6ZNQukRR+zkzdfX
        zHwZtnTaverH6xYEzH23/NByUYXznv8SYoxOv+ftbErK0/V/FrvurcuXrQ3eSizFGYmGWsxF
        xYkApo8LfvQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7pNM34nGbzfw2Gx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW9yY8JTR4vPSFnaLNTefslicuCXtIORx+Yq3x85Zd9k9Lp8t9di0qpPNY/OS
        eo/dNxvYPHa23mf1eL/vKptH35ZVjB6bT1d7fN4k59F+oJspgCdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Neu0TBPJ6KOQ1fWRoYW7i6GDk5
        JARMJJaeOM3cxcjFISSwlFFi4aX9TBAJCYnbC5sYIWxhiT/XuthAbCGBZ4wSUyaLdzFycLAJ
        aEk0drKDhEUEciUWLetgBZnDLPCGSeJwTx8rSEJYIEhi6qk/YEUsAqoS3xZNYgGxeQWsJK4v
        /ccCMV9eYual72A1nALWEv8aVrFA7LKSaDt2mRmiXlDi5MwnYHFmoPrmrbOZJzAKzEKSmoUk
        tYCRaRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg5G479nPLDsaVrz7qHWJk4mA8xCjBwawk
        wiv44keSEG9KYmVValF+fFFpTmrxIUZToLsnMkuJJucDU0deSbyhmYGpoYmZpYGppZmxkjiv
        Z0FHopBAemJJanZqakFqEUwfEwenVANTyEcWuxBfy6TpO6Pl/of4TFtWrS277sy/w40zew7f
        iN79+ulim5RPDFYcSzPtl27JudYRwKf6xC17yrl1Cy2W3SlPDi94vl5moXnzlCuHlcVW8Zju
        2q/hzdm+tWyT9o9zb0/pW3uw7PGon35q7UqPRcuXd9l/85UpCf60oP7vPhGNB6u936ud9Wuy
        OtS5fY2fyxsTabv/cuvjPibbBBQ5JvxO2hBqLHFst3dgkmJ277d9h2Xizzw53B+bUBvsIHgi
        KEXp4axYp7o/rdNi9Zp4wxenrraPaN8gqh5qfju33DEuKmuhav+XJNGuFSWHknUCpFqdV//K
        /NZovUAkw+x2q7R0g9CSpbULCl/PjFViKc5INNRiLipOBAAvOmjGZQMAAA==
X-CMS-MailID: 20220816131546eucas1p190ff39f4a53b379b873ea83029370f4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220816131546eucas1p190ff39f4a53b379b873ea83029370f4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220816131546eucas1p190ff39f4a53b379b873ea83029370f4c
References: <20220816131536.189406-1-p.raghav@samsung.com>
        <CGME20220816131546eucas1p190ff39f4a53b379b873ea83029370f4c@eucas1p1.samsung.com>
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

