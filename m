Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1415340B9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiEYPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiEYPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:50:13 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8334B86
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:50:12 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220525155011euoutp0255e0dad2a298e0685c1c8d16ff28cbab~yY9xQc-Ag0258602586euoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:50:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220525155011euoutp0255e0dad2a298e0685c1c8d16ff28cbab~yY9xQc-Ag0258602586euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653493811;
        bh=sJcs4ay0hQ3CcXQiFMNDhZ8v6ROIy7WSZthy8VqD664=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNX5bjAYu1tkdf73vb1Q6Y2iZVDfyvK1dzG3KioR/JgvD6R6huel8XduDAfAjWAck
         45SpJaqIQL2540ce0/C+Q879AkQa94bFYOGEgYzzUppq8V6+jlDQFWywS1Y0XqM17R
         JJy45bq/3KxdcdycoqNOYKv2sVhv0kkMXta7X1MI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220525155009eucas1p2d4bd13415b909eaaf6c6ca7e53c3fdb0~yY9vmoDnt0522505225eucas1p2N;
        Wed, 25 May 2022 15:50:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.00.10260.1305E826; Wed, 25
        May 2022 16:50:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789~yY9vPWFha2575925759eucas1p23;
        Wed, 25 May 2022 15:50:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220525155008eusmtrp1a64719bbb66a103e535236dc149d926e~yY9vMaFka1510315103eusmtrp1M;
        Wed, 25 May 2022 15:50:08 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-e6-628e503101f0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.27.09522.0305E826; Wed, 25
        May 2022 16:50:08 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220525155008eusmtip1a64c0e3e336ababa11af2ab44dfa7e53~yY9u2GdvG1782817828eusmtip1c;
        Wed, 25 May 2022 15:50:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        snitzer@redhat.com, Johannes.Thumshirn@wdc.com, hch@lst.de,
        hare@suse.de
Cc:     dsterba@suse.com, dm-devel@redhat.com, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
        gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v6 8/8] dm: ensure only power of 2 zone sizes are allowed
Date:   Wed, 25 May 2022 17:49:57 +0200
Message-Id: <20220525154957.393656-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525154957.393656-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djPc7qGAX1JBsdu8FmsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbvF5aQu7RdvGr4wO/B7/Tqxh87h8ttRj06pONo/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1b
        VjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBEcdmkpOZklqUW6dslcGXMW/eGreAbe0XXa7MGxnVs
        XYycHBICJhJ/T9xh72Lk4hASWMEosf7NXEYI5wujxImtHWwQzmdGiS0HX8G1PH97kRkisZxR
        ou/iFhaQhJDAC0aJKYtquhg5ONgEtCQaO8HGigg0MkpMfXkCbCyzwFdGiRsHnzOCNAgLeEp0
        N04Dm8oioCox+fJ7sEG8AlYSLQveM0Nsk5eYeek7O4jNKWAtMX//Z2aIGkGJkzOfgNUzA9U0
        b50NdpGEwGJOiaN7rkCd6iKx+OITJghbWOLV8S3sELaMxOnJPSwQdrXE0xu/oZpbGCX6d65n
        A3lBAmhb35kcEJNZQFNi/S59iHJHiZ+N15ghKvgkbrwVhDiBT2LStulQYV6JjjYhiGoliZ0/
        n0AtlZC43DQHaqmHxJSTF1gmMCrOQvLMLCTPzELYu4CReRWjeGppcW56arFxXmq5XnFibnFp
        Xrpecn7uJkZg2jv97/jXHYwrXn3UO8TIxMF4iFGCg1lJhPfC094kId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUyJ6TkRuum2ISueNB1e+yQ47OuCfMP0
        k10y4j/ecET7zHvWlHVB8MK1K+UCWytTMv/vCPzxVvbMu+aY2u0e07r+Tlg2dWrSrM9nV6+c
        uyn6ycfq+Ly+m8cWO9n1eZzZ78la8WzdH+m7m8xf3dA6xrBr0pLMoM4VX+W4b2/7HyW4meXO
        /i2sX7bYG6kmZDi9upBx+PmOSVGZq8tmXN+3dkuX0fRao0k7/iSV2ASveXOOyaq3kOmR3kGD
        ICEeq5ai3R5nr3tY6Nft3+/G7W2ROiVZauukrqNvHj6uYz2+QaYwvdRRPJbn4aG3sk9L9X6I
        pcQcnu1nffBe+qn+iexPrDKaVqb4lTz49o9/hsFtxnWlSizFGYmGWsxFxYkADVfSLuoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7oGAX1JBrOe6lmsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJ4sn6WcwWPQc+sFj87brHZLH3lrbF5V1z2Czm
        L3vKbvF5aQu7RdvGr4wO/B7/Tqxh87h8ttRj06pONo/NS+o9dt9sYPPY2Xqf1eP9vqtsHn1b
        VjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GXMW/eGreAbe0XXa7MGxnVsXYycHBICJhLP315k7mLk4hAS
        WMoocar/AjNEQkLi9sImRghbWOLPtS6wBiGBZ4wSH3ZrdzFycLAJaEk0drKD9IoIdDJKzNnX
        CuYwC/xnlPjTcRGsWVjAU6K7cRpYM4uAqsTky+9ZQGxeASuJlgXvoZbJS8y89J0dxOYUsJaY
        v/8zM8QyK4mvd76yQtQLSpyc+QSslxmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhX
        nJhbXJqXrpecn7uJERih24793LyDcd6rj3qHGJk4GA8xSnAwK4nwXnjamyTEm5JYWZValB9f
        VJqTWnyI0RTo7onMUqLJ+cAUkVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE
        08fEwSnVwLT8TdKR9fHVn7LiXvbuO/F603rt914ZSf9WP+KKPLZwilHkxQfNRlP0w5Zu/8Ne
        F6WX6a3lrOYjpjZB5fZZdUmD7Aa1f1cncGZ+vGv2x97q1aufmzzYr7YkfDu2tW1Ww4lEv3Yf
        fZ3Drp9uCX7X9IndVbN95aWK0j1LXI593+0Y01nmtWfTBbXDHM/s/t1QTWq18g4/MtNfaPIp
        jrQnukVzJvs+m1Whttwr0/6VjHReo0tK5I2Y/3J2jVXuDxx3Pv603vSSe/HMvninLXmGm+LX
        TFvna3TNaea2M2t790UFXcq4vLLo6Mq+ktdWXW9368wt8DXbsOef5skakSDLwBm7p6yS/RJQ
        2P1ue9Wn43uVWIozEg21mIuKEwHyFF8FWQMAAA==
X-CMS-MailID: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789
References: <20220525154957.393656-1-p.raghav@samsung.com>
        <CGME20220525155008eucas1p2c843cc9098f2920e961f80ffaf535789@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that only power of 2 zoned devices are enabled for dm targets that
supports zoned devices. This constraint can be relaxed once non power of
2 zone size support is added to the DM layer.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 03541cfc2317..2a8af70d1d4a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -251,6 +251,12 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
+		if (!is_power_of_2(zone_sectors)) {
+			DMWARN("%s: %pg only power of two zone size supported",
+			       dm_device_name(ti->table->md), bdev);
+			return 1;
+		}
+
 		if (start & (zone_sectors - 1)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
-- 
2.25.1

