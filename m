Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2329159E6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiHWQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244459AbiHWQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:15:26 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E248E4FE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:36:42 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220823121914euoutp01d8b3264d1c79f84ad130c0753e8d8a0e~N_JSfw3Ft1729817298euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220823121914euoutp01d8b3264d1c79f84ad130c0753e8d8a0e~N_JSfw3Ft1729817298euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661257154;
        bh=rwrR95VBKntQTDKdi+ldY8ggDErFsfT3t9lp/si7I3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHrcAM/fECWHA4d264kl7GeMzsolp3NwaIFh2GpZgHC+0QT4cRHxt5HF+LnAV8mWw
         fKy0n1MH7q2tNhvQ81xvpkvRgDLu5oNC/ASA1+SrGpnROenbZ+sHsEhhCBrQCZN6cF
         c07y1ggnMNJ5S+sVAKdNsxD9AIaxTeN6Ui+UrXbU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220823121912eucas1p2e8f19f59fde5e7242ae317e574bfe0ec~N_JQo_25C2219222192eucas1p2f;
        Tue, 23 Aug 2022 12:19:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 51.92.29727.0C5C4036; Tue, 23
        Aug 2022 13:19:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea~N_JP-yQ0B1882018820eucas1p1W;
        Tue, 23 Aug 2022 12:19:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220823121912eusmtrp25ede222dcc699b75396ed2ec6947dd4e~N_JP_5LBT2723427234eusmtrp2l;
        Tue, 23 Aug 2022 12:19:12 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-97-6304c5c0c0c5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.12.07473.FB5C4036; Tue, 23
        Aug 2022 13:19:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.52]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220823121911eusmtip21e834d44802a27da7ae0b65ee5c12be9~N_JPr2CtE1999619996eusmtip2Q;
        Tue, 23 Aug 2022 12:19:11 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de
Cc:     pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, hare@suse.de,
        jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        matias.bjorling@wdc.com, gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v12 10/13] dm-table: allow zoned devices with non power-of-2
 zone sizes
Date:   Tue, 23 Aug 2022 14:18:56 +0200
Message-Id: <20220823121859.163903-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823121859.163903-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87oHjrIkG9yZpmOx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGVcvn+HteAI
        b8Wqhy2MDYwfuLoYOTkkBEwkPiw4xNjFyMUhJLCCUeLZuu9QzhdGiYMbbrJBOJ8ZJU73H2ft
        YuQAazk2LR0ivpxR4lvzHFYI5wWjxNsNh1lAitgEtCQaO9lBVogIpEt8/boBbCqzwDYmiV93
        L7GAJIQFIiVW/z/CBGKzCKhK/Gp+DxbnFbCW+HGlgQniPnmJmZe+gw3iBIrPW3qKEaJGUOLk
        zCdg9cxANc1bZzODLJAQ2MwpsfLHfRaIZheJu5ceMkLYwhKvjm9hh7BlJP7vnA+1oFri6Y3f
        UM0tjBL9O9ezQbxpLdF3JgfEZBbQlFi/Sx+i3FFi35rzTBAVfBI33gpCnMAnMWnbdGaIMK9E
        R5sQRLWSxM6fT6CWSkhcbpoDdZiHxJIn21gmMCrOQvLMLCTPzELYu4CReRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgGjz97/inHYxzX33UO8TIxMF4iFGCg1lJhLf6IkOyEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBiaFrpdR5ckHDm6ev3WP
        ukWLs8Cvc6t2mcrJLDH1/RB9MWx1uozwy7MmNmmn38ypLr44a9Zd+UxWzoi8wEaZlus/9Vm2
        mv27vmPxSpErTz2Elq2bMo2vdZkY151TU9bNbos12CfOdWxqccjBr5V6rF7XD665FfIpheOf
        eoW0PWvG9ebE0sKMj0c2PipVD+vc4X489bZfm1r+Fo2rNwrylm479bVB/dz1wEaOKRkRVyW2
        BZxuLeU/eMb8d+jWeScKnJXXP0k8fkhw2c+Km5c2R8dFfeVOUTg5wTTPu9J7LtPTc4LVnA0T
        qg8Zvy/8VCuhpHKr9o8b/49E3QXsfRLvl1rs6JL54r04ujU0qNdaW0uJpTgj0VCLuag4EQCz
        d4wH8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7oHjrIkG+yYyGSx/tQxZovVd/vZ
        LKZ9+Mls8fvseWaLve9ms1rcPLCTyWLPoklMFitXH2WyeLJ+FrPF3657TBZ7b2lbXN41h81i
        /rKn7BYT2r4yW3xe2sJusebmUxaLE7ekHQQ9Ll/x9tg56y67x+WzpR6bVnWyeWxeUu+x+2YD
        m8fO1vusHu/3XWXz6NuyitFj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcvn+HteAIb8Wqhy2MDYwfuLoYOTgkBEwk
        jk1L72Lk4hASWMoo8fblP5YuRk6guITE7YVNjBC2sMSfa11sEEXPGCXOz9nMBtLMJqAl0djJ
        DlIjIpArcXjzBCaQGmaBI0wSqxvXsoIkhAXCJSZfPMUEYrMIqEr8an4PtoBXwFrix5UGJogF
        8hIzL30HG8QJFJ+39BTYYiEBK4n5tz6xQdQLSpyc+QSslxmovnnrbOYJjAKzkKRmIUktYGRa
        xSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERix24793LyDcd6rj3qHGJk4GA8xSnAwK4nwVl9k
        SBbiTUmsrEotyo8vKs1JLT7EaAp090RmKdHkfGDKyCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgU
        EkhPLEnNTk0tSC2C6WPi4JRqYNr2N3V3WdvXH3GSXyqOF0xe9u7xw3lzzhus2GwTb6Xv5hhR
        Xnsq+TTjlf/fLRj6/lp+PHRQPjLkwG8tzSN2mu0vpnZNK3n85sDjHYyZhx6rlrKzh3YFXz2z
        4GBU65s5H47YW2v07fg5vXa75QXtlZMcz2rMLQhssdfe2JtxO2+N7tHXm20znkUk9Eositlf
        4SbYVjDt6/frEsqlv3blXPLkZT4/U7SM7yp7l7j1xoc3zx6ISfv5sU25IG3KXre/7Dxh9x9V
        5Jz6Uv/OTWzdSemcf599zvnHfvXdd8f+e9wa9dh3/723cSfKn5yUZxOy8e6z/S0F5Vtv3+H+
        /+h71ZurK+qfTvVZVXel+89GpV3eSizFGYmGWsxFxYkAvoYeHWEDAAA=
X-CMS-MailID: 20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea
References: <20220823121859.163903-1-p.raghav@samsung.com>
        <CGME20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

