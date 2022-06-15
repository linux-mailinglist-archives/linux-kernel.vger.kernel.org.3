Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7B54C5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiFOKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiFOKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:20:12 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118A34BFF2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:19:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615101953euoutp0216a2cff7bf6991ab17e89ef82170376f~4xAYvB8lU2943629436euoutp02D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:19:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615101953euoutp0216a2cff7bf6991ab17e89ef82170376f~4xAYvB8lU2943629436euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1655288393;
        bh=bwZDXQMCqMHhu3ZuVm0AocKjdjGbQSZlDWP1ndwgqcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsnRcezjOXiALz83wEzrvdnlRnY+kZXZoQVFFEWvYvw9evcptXtOsuvwqnMJSYc0P
         8IIlnoqCRamVvxdHGftchVRgmOuQt0530yccfh5h8RPRuyp1OqdjjesqSGh4Cl9Ia9
         x3jSn9zK07ksmxSos9HsltT1N96m03ezesyOhA6k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220615101951eucas1p18d84bd7b38d6657a6c512bd382ceedf6~4xAW0wNp51438314383eucas1p1I;
        Wed, 15 Jun 2022 10:19:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 39.77.10067.742B9A26; Wed, 15
        Jun 2022 11:19:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220615101951eucas1p238eb45e563bd9645af81bf16c56d98ec~4xAWbmb-F2114221142eucas1p2b;
        Wed, 15 Jun 2022 10:19:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220615101951eusmtrp2c759d4ee173fff60b6c81fb090bf1131~4xAWarPxE0361403614eusmtrp2l;
        Wed, 15 Jun 2022 10:19:51 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-9e-62a9b247678f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.24.09038.742B9A26; Wed, 15
        Jun 2022 11:19:51 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220615101950eusmtip1b23a4a7a289c85a785fe400b913c2e54~4xAVmPX1i1152711527eusmtip1J;
        Wed, 15 Jun 2022 10:19:50 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v7 08/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Wed, 15 Jun 2022 12:19:15 +0200
Message-Id: <20220615101920.329421-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djP87rum1YmGdyfpG+x+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        AvijuGxSUnMyy1KL9O0SuDJ+3znDVvCLu6Jj3mGmBsY3nF2MnBwSAiYSE9vfsIPYQgIrGCW2
        bLTrYuQCsr8wSvTs3MgKkfjMKPHsQx1Mw8PDS5ghipYzSjS8Pc4K4bxklLi0Yx1TFyMHB5uA
        lkRjJ9hUEYFwiaN77jGB1DAL9DFLbD3XBzZVWCBYYv/BfUwgNouAqsTfvqMsIDavgJXE8Y6D
        bBDb5CVmXvoONohTwFpix+weVogaQYmTM5+A1TMD1TRvnQ12kYTAOU6J3v1PmSCaXSS6Jr+G
        soUlXh3fwg5hy0j83zkfKl4t8fTGb6jmFkaJ/p3r2UA+kADa1ncmB8RkFtCUWL9LH6LcUeLd
        gqnsEBV8EjfeCkKcwCcxadt0Zogwr0RHmxBEtZLEzp9PoJZKSFxumsMCYXtIXP86gWkCo+Is
        JM/MQvLMLIS9CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmztP/jn/Zwbj81Ue9
        Q4xMHIyHGCU4mJVEeM2CVyYJ8aYkVlalFuXHF5XmpBYfYpTmYFES503O3JAoJJCeWJKanZpa
        kFoEk2Xi4JRqYGp4NPuC2qbV1R0qS5ftOxipW13ON0tPLFchdeGhXOFZPfmfLiVdXZqnE1IX
        sUtKoa+/iVs8cm3HCdfzZ53TGzhdH/ldu2CXFHb1ad3mmVIO4pGrrLIKv75OEOhTrTG2Y3bR
        abL3qhVfGf37a+bfGPuzbl1yS2amXneOt/56lOXstY6zX1ds+1B/98zRYp+GuurNUz8YfHC4
        qLnO4I7Y/oMei8V+Ka3rSr7696CL444437KXN3Tkt03K+uW7T6uuYDmPsZ6g4UwZ+Z1P/Y9H
        PhQN1Yzefepu/KuJyewFz+fMF10zOdXfY5noo8aaRWUdXOH82/mn7WwOiNv0ZMnza3JLNvZU
        p2x+PfGT6fGPLEosxRmJhlrMRcWJAP1zcsMLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7rum1YmGXz5KWyx+m4/m8W0Dz+Z
        LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
        aVtc3jWHzWL+sqfsFjcmPGW0+Ly0hd1izc2nLBZtG78yOgh7XL7i7fHvxBo2j52z7rJ7XD5b
        6rFpVSebx8KGqcwem5fUe+y+2QCUa73P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZ
        Avij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ+
        3znDVvCLu6Jj3mGmBsY3nF2MnBwSAiYSDw8vYe5i5OIQEljKKLEB6CqIhITE7YVNjBC2sMSf
        a11sEEXPGSUaT+0DSnBwsAloSTR2gtWLCERLdN58D1bDLLCAWeL57VlsIAlhgUCJZccbmUBs
        FgFVib99R1lAbF4BK4njHQfZIBbIS8y89B1sEKeAtcSO2T2sIPOFgGp2vYuHKBeUODnzCVgr
        M1B589bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMMq3Hfu5ZQfj
        ylcf9Q4xMnEwHmKU4GBWEuE1C16ZJMSbklhZlVqUH19UmpNafIjRFOjsicxSosn5wDSTVxJv
        aGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAVGqfM/9J7trGTYu3n9tg
        4f+6KSlr6sv5XMxR4TEBV8I/7rsd7JjDtLRgWejBXSq/Yg8ucnnRobpMQmLKu7+l8w4sdJ5e
        n8f+4FAJx0PWK3Z8z3gZsgMfSAh8i/HQWWHlZP/n3IatOxkaljuevx8hevV6r6pM/7bYL4+f
        XWO0On3zzhMpv8Dj/J2lDRPLrV48XfZ+l131eaZHtncMtDR0BGf69/9MVEq8zXRhzi4HR9tl
        uvb8L/QX3PeQOxcX4TXpQFrRw5kHIhfUbVCLWre/p64y6xDPxAI92YwA9VqRVy9Vf7von9cL
        CGo44dS10dFQ0fvkjzXRh4KdJ2gE2554ryL78Ohj7jufGreXXkhtU2Ipzkg01GIuKk4EAHwS
        U/N7AwAA
X-CMS-MailID: 20220615101951eucas1p238eb45e563bd9645af81bf16c56d98ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615101951eucas1p238eb45e563bd9645af81bf16c56d98ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615101951eucas1p238eb45e563bd9645af81bf16c56d98ec
References: <20220615101920.329421-1-p.raghav@samsung.com>
        <CGME20220615101951eucas1p238eb45e563bd9645af81bf16c56d98ec@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zoned-target.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index 0ec5d8b9b..ad4228db5 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 				return -EINVAL;
 			}
 			zone_nr_sectors = blk_queue_zone_sectors(q);
+			if (!is_power_of_2(zone_nr_sectors)) {
+				ti->error = "Zone size not power of 2";
+				return -EINVAL;
+			}
 			zoned_dev->zone_nr_sectors = zone_nr_sectors;
 			zoned_dev->nr_zones =
 				blkdev_nr_zones(zoned_dev->bdev->bd_disk);
@@ -806,6 +810,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
 		q = bdev_get_queue(zoned_dev->bdev);
 		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
 		zoned_dev->nr_zones = blkdev_nr_zones(zoned_dev->bdev->bd_disk);
+		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
+			ti->error = "Zone size not power of 2";
+			return -EINVAL;
+		}
 	}
 
 	if (reg_dev) {
-- 
2.25.1

