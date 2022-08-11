Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4258FE61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiHKObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiHKObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:31:00 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF874DEE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:30:58 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220811143057euoutp01b8a561b428b1e036b711170434d8c079~KUM3irIYv2261422614euoutp01N
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:30:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220811143057euoutp01b8a561b428b1e036b711170434d8c079~KUM3irIYv2261422614euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660228257;
        bh=rwrR95VBKntQTDKdi+ldY8ggDErFsfT3t9lp/si7I3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ai6aDrNkh0eQwL/qofv+ISxJWVGmLw4uuTo9XT81CcoUbMFTCV/Yd+fpYssbfazrU
         G6f9sa/6MC1Pfjh6REpiCrjUXLNF8EHUj3wkcu1+Y4xtIbRTfXG6Np3OSDSI/7lYRD
         eLcZWS03lU7z+gDoTBs6dp6UrvchnKFdrgSELeDM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220811143056eucas1p29b49d12b0338a4711a28d327fff7e6ef~KUM2A2ali2350223502eucas1p2N;
        Thu, 11 Aug 2022 14:30:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C8.3A.09664.0A215F26; Thu, 11
        Aug 2022 15:30:56 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220811143055eucas1p2211be7f9ed867e40df58c25e6222be2d~KUM1h4IZp1002510025eucas1p2N;
        Thu, 11 Aug 2022 14:30:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220811143055eusmtrp21d2729a01fe711c562dc7208725ba968~KUM1g-qmk0788907889eusmtrp2y;
        Thu, 11 Aug 2022 14:30:55 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-06-62f512a0328a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C5.9F.09095.F9215F26; Thu, 11
        Aug 2022 15:30:55 +0100 (BST)
Received: from localhost (unknown [106.210.248.43]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220811143055eusmtip27cf972cf7bdafadf6e46b39ae5ae2fed~KUM1NLS-a1262412624eusmtip2y;
        Thu, 11 Aug 2022 14:30:55 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v10 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Thu, 11 Aug 2022 16:30:40 +0200
Message-Id: <20220811143043.126029-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811143043.126029-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7djP87oLhL4mGcxdzG6x/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVcvn+HteAI
        b8Wqhy2MDYwfuLoYOTkkBEwk1h3Zxd7FyMUhJLCCUWLnzw3MIAkhgS+MEtfnikIkPjNKvD+4
        ggWm49uGfVAdyxklFu6exwTR8YJR4t/LiC5GDg42AS2Jxk52kLCIQLrE+gXLwXqZBbYxSWx5
        IAxiCwtESrTe6gCrYRFQlbi5/isbiM0rYC1xaskSVohd8hIzL30Hq+EEik9YdJEJokZQ4uTM
        J1Az5SWat85mBrlHQmA9p8TSS+eYIJpdJNbeWAFlC0u8Or6FHcKWkfi/cz5UvFri6Y3fUM0t
        jBL9O9ezgTwgAbSt70wOiMksoCmxfpc+RNRRYtJHWwiTT+LGW0GIC/gkJm2bzgwR5pXoaBOC
        mK0EDM0nUDslJC43zYEGoIdEz4oupgmMirOQ/DILyS+zENYuYGRexSieWlqcm55abJiXWq5X
        nJhbXJqXrpecn7uJEZgAT/87/mkH49xXH/UOMTJxMB5ilOBgVhLhLVv0OUmINyWxsiq1KD++
        qDQntfgQozQHi5I4b3LmhkQhgfTEktTs1NSC1CKYLBMHp1QDU+3enqtOzH1Tpt1aGx0xZa90
        /iPTO4saVGaof1wuPG/p1CTVtkPB5UzLFqxNOXX+2JL7Sz6KlAtbBDjyC99b0LzoLb9L7nrR
        RPXejv939v/TP/ZyxwKv5w1pkayP+tJvny2tXtC580HQu55VxbzTDvGEXZvoePd16F2tVf2X
        RWN1rnfsXtCtXvZ5lf2MCa+L7mkGVUQzr975reLCouaTDTy35n9IemW45u/z2Emrl2SJrF6Q
        Odv/p/iEq73cbLtnrZ/yWiN35+mdN4U+brAzOpsUYfDZ+rWJSdDMHq0ZgVHzerICvN7uMH3y
        K+PkynhuplOfbmfu0zn1vv13xzaThu3FxdZaxgKiRrcEV3E/WpqqxFKckWioxVxUnAgAEnVm
        AO8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7rzhb4mGby8pGqx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcvn+HteAIb8Wqhy2MDYwfuLoYOTkkBEwk
        vm3Yx97FyMUhJLCUUaJlxXNGiISExO2FTVC2sMSfa11sEEXPGCXWte5g6mLk4GAT0JJo7GQH
        MUUEciUOHgkEKWEWOMIk0fx2FwtIr7BAuMTqGW/BbBYBVYmb67+ygdi8AtYSp5YsYYWYLy8x
        89J3dhCbEyg+YdFFJhBbSMBKYkLHMXaIekGJkzOfgM1hBqpv3jqbeQKjwCwkqVlIUgsYmVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIERuy2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrxliz4n
        CfGmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MGXklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
        pCeWpGanphakFsH0MXFwSjUwce1/6Ljx3l6GRN/Xnx3m8p54dIHzrE+sDFO1mYBIxw6DR4kt
        rSaRWR488ziUVY4G2q7Q9zrx7D8r55+IMwZLw/601cc/16hMnR9aoGAY7ylrN+1lzGSfSRtU
        2/n+f165780Et9VzZ/pJvn37UtRexfcIe9q63thDSvf9k6/PeDrj80Z7vv+CpmFuPDN0cs9G
        BMxr9/yxaefz/ZLbO5ii7c5niy+M+fYnPefRVs3s+O3KMtfjahZXpzY1X4u4sbDN2pvj7WLh
        7Hkmv3uFXKR/Wk62VuafU/swomfOxRNa3+ZtdvXnZn2oIVP3kHmZ760FBxuFvqiv9Lit+tXe
        vLXu+Sft/48DGKbfVS+p3j1PiaU4I9FQi7moOBEAYdrlj2EDAAA=
X-CMS-MailID: 20220811143055eucas1p2211be7f9ed867e40df58c25e6222be2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220811143055eucas1p2211be7f9ed867e40df58c25e6222be2d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220811143055eucas1p2211be7f9ed867e40df58c25e6222be2d
References: <20220811143043.126029-1-p.raghav@samsung.com>
        <CGME20220811143055eucas1p2211be7f9ed867e40df58c25e6222be2d@eucas1p2.samsung.com>
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

Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
the block layer now supports it.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/dm-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 332f96b58252..31eb1d29d136 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (start & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (len & (zone_sectors - 1)) {
+		if (!bdev_is_zone_start(bdev, len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1642,8 +1642,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
 		return -EINVAL;
 	}
 
-	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1

